Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62690C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E7208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfIEDp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbfIEDp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:45:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E6C3AF6B;
        Thu,  5 Sep 2019 03:45:57 +0000 (UTC)
Date:   Wed, 4 Sep 2019 20:45:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190905034546.i6eklk6flbqk2hox@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
 <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
 <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
 <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
 <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Michel Lespinasse wrote:

>I do not have time for a full review right now, but I did have a quick
>pass at it and it does seem to match the direction I'd like this to
>take.

Thanks, and no worries, I consider all this v5.5 material anyway.

>
>Please let me know if you'd like me to do a full review of this, or if
>it'll be easier to do it on the individual steps once this gets broken
>up.

If nothing else, I would appreciate you making sure I didn't do anything
stupid in the interval_tree_generic.h lookup changes.

>
>BTW are you going to plumbers ? I am and I would love to talk to you
>there, about this and about MM range locking, too.

No, not this year; perhaps lsfmm (although that's not for a while).

>
>Things I noticed in my quick pass:
>
>> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
>> index e0ad547786e8..dc9fad8ea84a 100644
>> --- a/drivers/gpu/drm/radeon/radeon_vm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
>> @@ -450,13 +450,14 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
>>  {
>>         uint64_t size = radeon_bo_size(bo_va->bo);
>>         struct radeon_vm *vm = bo_va->vm;
>> -       unsigned last_pfn, pt_idx;
>> +       unsigned pt_idx;
>>         uint64_t eoffset;
>>         int r;
>>
>>         if (soffset) {
>> +               unsigned last_pfn;
>>                 /* make sure object fit at this offset */
>> -               eoffset = soffset + size - 1;
>> +               eoffset = soffset + size;
>>                 if (soffset >= eoffset) {
>Should probably be if (soffset > eoffset) now (just checking for
>arithmetic overflow).
>>                         r = -EINVAL;
>>                         goto error_unreserve;
>> @@ -471,7 +472,7 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
>>                 }
>>
>>         } else {
>> -               eoffset = last_pfn = 0;
>> +               eoffset = 1; /* interval trees are [a,b[ */
>Looks highly suspicious to me, and doesn't jive with the eoffset /=
>RADEON_GPU_PAGE_SIZE below.
>I did not look deep enough into this to figure out what would be correct though.

I think you're right, I will double check this. I think we only wanna do
the RADEON_GPU_PAGE_SIZE division when soffset is non-zero.

>>         }
>>
>>         mutex_lock(&vm->mutex);
>> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> index 14d2a90964c3..d708c45bfabf 100644
>> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
>> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> @@ -195,13 +195,13 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
>>         trace_hfi1_mmu_rb_search(addr, len);
>>         if (!handler->ops->filter) {
>>                 node = __mmu_int_rb_iter_first(&handler->root, addr,
>> -                                              (addr + len) - 1);
>> +                                              (addr + len));
>>         } else {
>>                 for (node = __mmu_int_rb_iter_first(&handler->root, addr,
>> -                                                   (addr + len) - 1);
>> +                                                   (addr + len));
>>                      node;
>>                      node = __mmu_int_rb_iter_next(node, addr,
>> -                                                  (addr + len) - 1)) {
>> +                                                  (addr + len))) {
>>                         if (handler->ops->filter(node, addr, len))
>>                                 return node;
>>                 }
>
>Weird unnecessary parentheses through this block.

Yes, but I wanted to leave it with the least amount of changes. There are plenty
of places that could use interval_tree_foreach helpers, like the vma tree has.

>
>> @@ -787,7 +787,7 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
>>         struct viommu_domain *vdomain = to_viommu_domain(domain);
>>
>>         spin_lock_irqsave(&vdomain->mappings_lock, flags);
>> -       node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
>> +       node = interval_tree_iter_first(&vdomain->mappings, iova, iova + 1);
>
>I was gonna suggest a stab iterator for the generic interval tree, but
>maybe not if it's only used here.

I considered it as well.

>
>> diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
>> index aaa8a0767aa3..e714e67ebdb5 100644
>> --- a/include/linux/interval_tree_generic.h
>> +++ b/include/linux/interval_tree_generic.h
>> @@ -69,12 +69,12 @@ ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,                         \
>>  }                                                                            \
>>                                                                               \
>>  /*                                                                           \
>> - * Iterate over intervals intersecting [start;last]                          \
>> + * Iterate over intervals intersecting [start;last[                          \
>
>Maybe I'm extra nitpicky, but I would suggest to use 'end' instead of
>'last' when the intervals are half open: [start;end[
>To me 'last' implies that it's in the interval, while 'end' doesn't
>imply anything (and thus the half open convention used through the
>kernel applies).

That's fair enough.

>similarly ITLAST should be changed to ITEND, etc and similarly in the
>various call sites (drm and others).
>Again, maybe it's nitpicky but I feel changing the name also helps
>verify that we don't leave behind any off-by-one use.
>
>That said, it's really only my preference - if you think it's too
>painful to change, that's OK.

I'll see what I can do, but yeah it might be too much of a pain for
the benefits.

Thanks,
Davidlohr
