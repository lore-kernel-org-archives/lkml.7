Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4360C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA562067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfG2VGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfG2VGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:06:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2FB37FDEC;
        Mon, 29 Jul 2019 21:06:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044505C1A1;
        Mon, 29 Jul 2019 21:06:35 +0000 (UTC)
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729081800.qbamrvsf4rjna656@e107158-lin.cambridge.arm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <be28b3d2-3f94-806b-874d-db2248a2c3a9@redhat.com>
Date:   Mon, 29 Jul 2019 17:06:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729081800.qbamrvsf4rjna656@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 Jul 2019 21:06:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 4:18 AM, Qais Yousef wrote:
> On 07/27/19 13:10, Waiman Long wrote:
>> It was found that a dying mm_struct where the owning task has exited
>> can stay on as active_mm of kernel threads as long as no other user
>> tasks run on those CPUs that use it as active_mm. This prolongs the
>> life time of dying mm holding up memory and other resources like swap
>> space that cannot be freed.
>>
>> Fix that by forcing the kernel threads to use init_mm as the active_mm
>> if the previous active_mm is dying.
>>
>> The determination of a dying mm is based on the absence of an owning
>> task. The selection of the owning task only happens with the CONFIG_MEMCG
>> option. Without that, there is no simple way to determine the life span
>> of a given mm. So it falls back to the old behavior.
> I don't really know a lot about this code, but does the owner field has to
> depend on CONFIG_MEMCG? ie: can't the owner be always set?
>
Yes, the owner field is only used and defined when CONFIG_MEMCG is on.

Cheers,
Longman

