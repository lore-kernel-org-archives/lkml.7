Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472DC2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJtdIhjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLIQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:49:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3bT48mpMXZUuogugS+Lg7eAMtkdz0EBh6YluGkfTfmU=; b=rJtdIhjsp92dCFfJifVAcPJVG
        +pRGZ8+nnjhxTORDTLC5Q6ZKLMGroP1y6w1jAS0C4nkoedazXd6C429W+6G4VkUm4EWWzW6X2srKD
        rW2wn55qJfS92O7jzuCHxc8y2PgpRPlKbtgbEwAL25u0a+/JtBWEAo1QguW+YZ1wKal1s9nYUKBUG
        2DyqcPvdNwTJzSNUNLr7JstLIrm22v+YCa7e6EGw+pIW68D8+MdutExcDNkETPDMAGhmDynv+loHu
        kfgqV2tcgdYi8WPlMXIvXpFJEjADmsOvMM7zN80pnMbquq4lhU7xoC17JLKqTweey5wXGsuhYG3Aw
        RLdOd+s/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieMDb-0003yT-NC; Mon, 09 Dec 2019 16:49:07 +0000
Date:   Mon, 9 Dec 2019 08:49:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] hugetlbfs: Disable IRQ when taking hugetlb_lock in
 set_max_huge_pages()
Message-ID: <20191209164907.GD32169@bombadil.infradead.org>
References: <20191209160150.18064-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209160150.18064-1-longman@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:01:50AM -0500, Waiman Long wrote:
> [  613.245273] Call Trace:
> [  613.256273]  <IRQ>
> [  613.265273]  dump_stack+0x9a/0xf0
> [  613.281273]  mark_lock+0xd0c/0x12f0
> [  613.341273]  __lock_acquire+0x146b/0x48c0
> [  613.401273]  lock_acquire+0x14f/0x3b0
> [  613.440273]  _raw_spin_lock+0x30/0x70
> [  613.477273]  free_huge_page+0x36f/0xaa0
> [  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0

Oh, this is fun.  So we kicked off IO to a hugepage, then truncated or
otherwise caused the page to come free.  Then the IO finished and did the
final put on the page ... from interrupt context.  Splat.  Not something
that's going to happen often, but can happen if a process dies during
IO or due to a userspace bug.

Maybe we should schedule work to do the actual freeing of the page
instead of this rather large patch.  It doesn't seem like a case we need
to optimise for.

Further, this path is called from softirq context, not hardirq context.
That means the whole mess could be a spin_lock_bh(), not spin_lock_irq()
which is rather cheaper.  Anyway, I think the schedule-freeing-of-a-page-
if-in-irq-context approach is likely to be better.

> +/*
> + * Check to make sure that IRQ is enabled before calling spin_lock_irq()
> + * so that after a matching spin_unlock_irq() the system won't be in an
> + * incorrect state.
> + */
> +static __always_inline void spin_lock_irq_check(spinlock_t *lock)
> +{
> +	lockdep_assert_irqs_enabled();
> +	spin_lock_irq(lock);
> +}
> +#ifdef spin_lock_irq
> +#undef spin_lock_irq
> +#endif
> +#define spin_lock_irq(lock)	spin_lock_irq_check(lock)

Don't leave your debugging code in the patch you submit for merging.

> @@ -1775,7 +1793,11 @@ static void return_unused_surplus_pages(struct hstate *h,
>  		unused_resv_pages--;
>  		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
>  			goto out;
> -		cond_resched_lock(&hugetlb_lock);
> +		if (need_resched()) {
> +			spin_unlock_irq(&hugetlb_lock);
> +			cond_resched();
> +			spin_lock_irq(&hugetlb_lock);
> +		}

This doesn't work.  need_resched() is only going to be set due to things
happening in interrupt context.  But you've disabled interrupts, so
need_resched() is never going to be set.

