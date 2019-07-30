Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A706C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217612087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfG3VFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfG3VFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E9BF308AA11;
        Tue, 30 Jul 2019 21:05:51 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AA7E60BEC;
        Tue, 30 Jul 2019 21:05:49 +0000 (UTC)
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
References: <20190729210728.21634-1-longman@redhat.com>
 <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
 <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
 <20190730072439.GL9330@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <31cea85f-8d8e-a701-db75-fe1ec67d6c29@redhat.com>
Date:   Tue, 30 Jul 2019 17:05:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730072439.GL9330@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 30 Jul 2019 21:05:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 3:24 AM, Michal Hocko wrote:
> On Mon 29-07-19 17:42:20, Waiman Long wrote:
>> On 7/29/19 5:21 PM, Rik van Riel wrote:
>>> On Mon, 2019-07-29 at 17:07 -0400, Waiman Long wrote:
>>>> It was found that a dying mm_struct where the owning task has exited
>>>> can stay on as active_mm of kernel threads as long as no other user
>>>> tasks run on those CPUs that use it as active_mm. This prolongs the
>>>> life time of dying mm holding up some resources that cannot be freed
>>>> on a mostly idle system.
>>> On what kernels does this happen?
>>>
>>> Don't we explicitly flush all lazy TLB CPUs at exit
>>> time, when we are about to free page tables?
>> There are still a couple of calls that will be done until mm_count
>> reaches 0:
>>
>> - mm_free_pgd(mm);
>> - destroy_context(mm);
>> - mmu_notifier_mm_destroy(mm);
>> - check_mm(mm);
>> - put_user_ns(mm->user_ns);
>>
>> These are not big items, but holding it off for a long time is still not
>> a good thing.
> It would be helpful to give a ball park estimation of how much that
> actually is. If we are talking about few pages worth of pages per idle
> cpu in the worst case then I am not sure we want to find an elaborate
> way around that. We are quite likely having more in per-cpu caches in
> different subsystems already. It is also quite likely that large
> machines with many CPUs will have a lot of memory as well.

I think they are relatively small. So I am not going to pursue it
further at this point.

Cheers,
Longman

