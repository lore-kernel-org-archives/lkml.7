Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AD3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0752F218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCPJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:39:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfCPJjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 05:39:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2CADE823164DF3D7D755;
        Sat, 16 Mar 2019 17:38:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Mar 2019
 17:38:55 +0800
Message-ID: <5C8CC42E.1090208@huawei.com>
Date:   Sat, 16 Mar 2019 17:38:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+cbb52e396df3e565ab02@syzkaller.appspotmail.com>,
        Michal Hocko <mhocko@kernel.org>, <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: KASAN: use-after-free Read in get_mem_cgroup_from_mm
References: <00000000000006457e057c341ff8@google.com> <5C7BFE94.6070500@huawei.com> <CACT4Y+Z+CH0UTdSz-w_woMPrBwg-GuobV1Su4qd9ReffTkyfVg@mail.gmail.com> <5C7D2F82.40907@huawei.com> <CACT4Y+agwaszODNGJHCqn4fSk4Le9exn3Cau0nornJ0RaTpDJw@mail.gmail.com> <5C7D4500.3070607@huawei.com> <CACT4Y+b6y_3gTpR8LvNREHOV0TP7jB=Zp1L03dzpaz_SaeESng@mail.gmail.com> <5C7E1A38.2060906@huawei.com> <20190306020540.GA23850@redhat.com> <5C821550.50506@huawei.com> <20190315213944.GD9967@redhat.com>
In-Reply-To: <20190315213944.GD9967@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/16 5:39, Andrea Arcangeli wrote:
> On Fri, Mar 08, 2019 at 03:10:08PM +0800, zhong jiang wrote:
>> I can reproduce the issue in arm64 qemu machine.  The issue will leave after applying the
>> patch.
>>
>> Tested-by: zhong jiang <zhongjiang@huawei.com>
> Thanks a lot for the quick testing!
>
>> Meanwhile,  I just has a little doubt whether it is necessary to use RCU to free the task struct or not.
>> I think that mm->owner alway be NULL after failing to create to process. Because we call mm_clear_owner.
> I wish it was enough, but the problem is that the other CPU may be in
> the middle of get_mem_cgroup_from_mm() while this runs, and it would
> dereference mm->owner while it is been freed without the call_rcu
> affter we clear mm->owner. What prevents this race is the
As you had said, It would dereference mm->owner after we clear mm->owner.

But after we clear mm->owner,  mm->owner should be NULL.  Is it right?

And mem_cgroup_from_task will check the parameter. 
you mean that it is possible after checking the parameter to  clear the owner .
and the NULL pointer will trigger. :-(

Thanks,
zhong jiang
> rcu_read_lock() in get_mem_cgroup_from_mm() and the corresponding
> call_rcu to free the task struct in the fork failure path (again only
> if CONFIG_MEMCG=y is defined). Considering you can reproduce this tiny
> race on arm64 qemu (perhaps tcg JIT timing variantions helps?), you
> might also in theory be able to still reproduce the race condition if
> you remove the call_rcu from delayed_free_task and you replace it with
> free_task.
>
> .
>


