Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897E420659
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfG2UlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:41:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfG2UlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3B40368E3;
        Mon, 29 Jul 2019 20:41:01 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD1435D9CA;
        Mon, 29 Jul 2019 20:41:00 +0000 (UTC)
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729091249.GE9330@dhcp22.suse.cz>
 <556445a2-8912-c017-413c-7a4f36c4b89e@redhat.com>
 <20190729185853.GJ9330@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9e403b46-e0cb-0841-4ff7-6ecb30580d33@redhat.com>
Date:   Mon, 29 Jul 2019 16:41:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729185853.GJ9330@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 29 Jul 2019 20:41:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 2:58 PM, Michal Hocko wrote:
> On Mon 29-07-19 11:27:35, Waiman Long wrote:
>> On 7/29/19 5:12 AM, Michal Hocko wrote:
>>> On Sat 27-07-19 13:10:47, Waiman Long wrote:
>>>> It was found that a dying mm_struct where the owning task has exited
>>>> can stay on as active_mm of kernel threads as long as no other user
>>>> tasks run on those CPUs that use it as active_mm. This prolongs the
>>>> life time of dying mm holding up memory and other resources like swap
>>>> space that cannot be freed.
>>> IIRC use_mm doesn't pin the address space. It only pins the mm_struct
>>> itself. So what exactly is the problem here?
>> As explained in my response to Peter, I found that resource like swap
>> space were depleted even after the exit of the offending program in a
>> mostly idle system. This patch is to make sure that those resources get
>> freed after program exit ASAP.
> Could you elaborate more? How can a mm counter (do not confuse with
> mm_users) prevent address space to be torn down on exit?

Many of the resources tied to mm_struct are indeed freed when mm_users
becomes 0 including swap space reservation, I think. I was testing a mm
patch and it did have a missing mmput bug that cause mm_users not going
to 0. I fixed the bug, and with sched patch to speed up the release the
mm_struct, every was fine. I didn't realize that fixing the mm bug is
enough to free the swap space.

Still there are some resources not being free when the mm_count is
non-zero. It is certainly less serious than what I have thought. Sorry
for the confusion.

Cheers,
Longman

