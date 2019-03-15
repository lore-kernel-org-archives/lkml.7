Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71373C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFAA218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2sYvTvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfCOJHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfCOJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dhnvin1A+/DeqhKqw1M209Ghaxo83lMkAF87K2TEozs=; b=D2sYvTvAumK+FL7XrQVQgorza
        4cMnFHz2EAvIXuIzRbGbVloAQMtw+9/UzmPIJPqu6AXGHCA+TEsrlSyISslUYYHSbkRc1hdpuksJT
        j7m0I8BHNdfzii7yIWOdHu7p3SA10ZOJmQK21RMKm5tTiytHg34gSkJ/B9X4VdfvlYYjJfp34vS7X
        9w6ZbqIdvKa2+yQB9tYTM4z4ap62L99exHTylNrUwG4MBI4vMq53wdDkvzsDYYle1ekq+LuZoZ8st
        R55qkSc3KCnSRjaJ7PYkUFL1SQRnLpUzlOrM2Q7xaRqKrrBwtkKki42QGTsYOD7RX8BLO7JmMlxG4
        l2C8fzGLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4inh-0008Du-NK; Fri, 15 Mar 2019 09:06:49 +0000
Date:   Fri, 15 Mar 2019 02:06:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf
 heaps
Message-ID: <20190315090649.GD4470@infradead.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-4-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551819273-640-4-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	i = sg_alloc_table(table, npages, GFP_KERNEL);
> +	if (i)
> +		goto err1;
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		struct page *page;
> +
> +		page = alloc_page(GFP_KERNEL);
> +		if (!page)
> +			goto err2;
> +		sg_set_page(sg, page, PAGE_SIZE, 0);
> +	}

Given that one if not the primary intent here is to DMA map the memory
this is a bad idea, as it might require bounce buffering.

What we really want here is something like this:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator.3

And I wonder if the S/G building should also move into common code
instead of being duplicated everywhere.

> +static int system_heap_create(void)
> +{
> +	struct system_heap *sys_heap;
> +
> +	sys_heap = kzalloc(sizeof(*sys_heap), GFP_KERNEL);
> +	if (!sys_heap)
> +		return -ENOMEM;
> +	sys_heap->heap.name = "system_heap";
> +	sys_heap->heap.ops = &system_heap_ops;
> +
> +	dma_heap_add(&sys_heap->heap);

Why is this dynamically allocated?
