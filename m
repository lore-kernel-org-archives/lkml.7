Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC88520820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 02:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDk/GviO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfIECAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 22:00:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35152 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfIECA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 22:00:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id b11so470229vsq.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtBbVu2YuRjZxQMG+WWVEf96/N7afgxfmZK4Z/+uFWI=;
        b=BDk/GviOuG+apQ6Q/QhHTj1xqYrRLRJ/U+Vl5q95c5rnTaFT0q9vnD0FlSm+FhOZMu
         fT3dBm8RjTrA4gE8Cd+3Pq/OuU0LqZqI5fGoyijCmEo1OJ9YH4GJGxcVEf8Hf37u+BD3
         JKtzoiTPyiQgXrUzG0AlNoYIgK56qBaMpOsakxiGkp99hGkduJGX4MlrhOmNoYzbtrzt
         myehfK5bh1Iz/GmYMogUXHiUhsPrJtTsuQaCcfnCGQ6ZxdIzSgf92h3Kbr14WQSM8GyK
         Y7yXbjI3ABUK3pplcWrvaGBY9jw2ZJkaI2Bqq6xyydd6jTSm9wxtlqXVMKEFOjexq/FK
         klIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtBbVu2YuRjZxQMG+WWVEf96/N7afgxfmZK4Z/+uFWI=;
        b=dUjEqIyKs50EGIOBtVr9e85kHBr+qls9aHD5IM0XYMnntgD91ODbNdLPG0GPiyAB5d
         QOivErfakPmPRlNNa3EWyFIhe0iXXvcIkdYxqgl/9wWuERySXb4OL3Fx3fC1sMFeVr9O
         llVjWPndXmmW0YU4Fc+pblXM7xwhuIOsRle2ihSBBpu59Qgf6BtAQwLRmQ7zPmiH2Liv
         UGvU2T+LBcVX30OhXMBE3VeqDa0ZIhKONbhR30A5n2bQpQL9Sv9h+eaMBetj1JOMc/Pv
         NECCymIYsh3oJyrVBUJ92xNt/BiMClq2R8IFLpOmO2aFz40B9VZyaTAhxXZ0lCMt6hg8
         RuKA==
X-Gm-Message-State: APjAAAW4rgA0DRZ3aIJ7Tz8dqkNXLNVC1/XDFYikXRpEU6+J/bpXyqgb
        yWOA55WjwURFnvmo56HXUrVhtRrOK76VpoiYQ2+5bQ==
X-Google-Smtp-Source: APXvYqxacjUbubh/fjdELzo+yEIBzA6Pet0cEMCgAbXj6+KDUhSdstEp8OETBjK3tdrz7F17KCo/GA17ho1MZ4H5QAs=
X-Received: by 2002:a67:3147:: with SMTP id x68mr509652vsx.29.1567648828184;
 Wed, 04 Sep 2019 19:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190813224620.31005-1-dave@stgolabs.net> <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com> <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5> <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
 <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
In-Reply-To: <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 4 Sep 2019 19:00:13 -0700
Message-ID: <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On Wed, Sep 4, 2019 at 5:52 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> Ok, so for that I've added the following helper which will make the
> conversion a bit more straightforward:
>
> #define vma_interval_tree_foreach_stab(vma, root, start)
>        vma_interval_tree_foreach(vma, root, start, start)

Yes, that should help with the conversion :)

> I think this also makes sense as it documents the nature of the lookup.
>
> Now for the interval-tree conversion to [a,b[ , how does the following
> look to you? Note that this should be the end result; we can discuss
> how to get there later, but I wanna make sure that it was more or less
> what you were picturing.

I do not have time for a full review right now, but I did have a quick
pass at it and it does seem to match the direction I'd like this to
take.

Please let me know if you'd like me to do a full review of this, or if
it'll be easier to do it on the individual steps once this gets broken
up.

BTW are you going to plumbers ? I am and I would love to talk to you
there, about this and about MM range locking, too.

Things I noticed in my quick pass:

> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
> index e0ad547786e8..dc9fad8ea84a 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -450,13 +450,14 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
>  {
>         uint64_t size = radeon_bo_size(bo_va->bo);
>         struct radeon_vm *vm = bo_va->vm;
> -       unsigned last_pfn, pt_idx;
> +       unsigned pt_idx;
>         uint64_t eoffset;
>         int r;
>
>         if (soffset) {
> +               unsigned last_pfn;
>                 /* make sure object fit at this offset */
> -               eoffset = soffset + size - 1;
> +               eoffset = soffset + size;
>                 if (soffset >= eoffset) {
Should probably be if (soffset > eoffset) now (just checking for
arithmetic overflow).
>                         r = -EINVAL;
>                         goto error_unreserve;
> @@ -471,7 +472,7 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
>                 }
>
>         } else {
> -               eoffset = last_pfn = 0;
> +               eoffset = 1; /* interval trees are [a,b[ */
Looks highly suspicious to me, and doesn't jive with the eoffset /=
RADEON_GPU_PAGE_SIZE below.
I did not look deep enough into this to figure out what would be correct though.
>         }
>
>         mutex_lock(&vm->mutex);
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
> index 14d2a90964c3..d708c45bfabf 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
> @@ -195,13 +195,13 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
>         trace_hfi1_mmu_rb_search(addr, len);
>         if (!handler->ops->filter) {
>                 node = __mmu_int_rb_iter_first(&handler->root, addr,
> -                                              (addr + len) - 1);
> +                                              (addr + len));
>         } else {
>                 for (node = __mmu_int_rb_iter_first(&handler->root, addr,
> -                                                   (addr + len) - 1);
> +                                                   (addr + len));
>                      node;
>                      node = __mmu_int_rb_iter_next(node, addr,
> -                                                  (addr + len) - 1)) {
> +                                                  (addr + len))) {
>                         if (handler->ops->filter(node, addr, len))
>                                 return node;
>                 }

Weird unnecessary parentheses through this block.

> @@ -787,7 +787,7 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
>         struct viommu_domain *vdomain = to_viommu_domain(domain);
>
>         spin_lock_irqsave(&vdomain->mappings_lock, flags);
> -       node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
> +       node = interval_tree_iter_first(&vdomain->mappings, iova, iova + 1);

I was gonna suggest a stab iterator for the generic interval tree, but
maybe not if it's only used here.

> diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
> index aaa8a0767aa3..e714e67ebdb5 100644
> --- a/include/linux/interval_tree_generic.h
> +++ b/include/linux/interval_tree_generic.h
> @@ -69,12 +69,12 @@ ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,                         \
>  }                                                                            \
>                                                                               \
>  /*                                                                           \
> - * Iterate over intervals intersecting [start;last]                          \
> + * Iterate over intervals intersecting [start;last[                          \

Maybe I'm extra nitpicky, but I would suggest to use 'end' instead of
'last' when the intervals are half open: [start;end[
To me 'last' implies that it's in the interval, while 'end' doesn't
imply anything (and thus the half open convention used through the
kernel applies).
similarly ITLAST should be changed to ITEND, etc and similarly in the
various call sites (drm and others).
Again, maybe it's nitpicky but I feel changing the name also helps
verify that we don't leave behind any off-by-one use.

That said, it's really only my preference - if you think it's too
painful to change, that's OK.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
