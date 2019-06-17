Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D01BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A28208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfFQOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfFQOuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2823DC02938A;
        Mon, 17 Jun 2019 14:50:26 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8730B7DF71;
        Mon, 17 Jun 2019 14:50:23 +0000 (UTC)
Subject: Re: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-api@vger.kernel.org
References: <20190617142149.5245-1-longman@redhat.com>
 <20190617143842.GC1492@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9e165eae-e354-04c4-6362-0f80fe819469@redhat.com>
Date:   Mon, 17 Jun 2019 10:50:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617143842.GC1492@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Jun 2019 14:50:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 10:38 AM, Michal Hocko wrote:
> [Cc linux-api]
>
> On Mon 17-06-19 10:21:49, Waiman Long wrote:
>> There are concerns about memory leaks from extensive use of memory
>> cgroups as each memory cgroup creates its own set of kmem caches. There
>> is a possiblity that the memcg kmem caches may remain even after the
>> memory cgroup removal.
>>
>> Therefore, it will be useful to show how many memcg caches are present
>> for each of the kmem caches.
> How is a user going to use that information?  Btw. Don't we have an
> interface to display the number of (dead) cgroups?

The interface to report dead cgroups is for cgroup v2 (cgroup.stat)
only. I don't think there is a way to find that for cgroup v1. Also the
number of memcg kmem caches may not be the same as the number of
memcg's. It can range from 0 to above the number of memcg's.  So it is
an interesting number by itself.

From the user perspective, if the numbers is way above the number of
memcg's, there is probably something wrong there.

Cheers,
Longman

