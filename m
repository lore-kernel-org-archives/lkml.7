Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC21BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD04218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sGDmDKwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfCOJGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfCOJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j78cqxO0j5kBy+Sel1YCiPWdQ5D6/QSjaVylMNTrh48=; b=sGDmDKwR4njjrRMCEpeaF6hBe
        KIiB3DdMToavB3IYYtrotZF1iT734TjiYMuj5/TYQqat6ZVLbJg0bRLTKTxuurcSSvQa5pePbArgV
        3nHIGQyoADXzwnDRw83UUymxMQVg5/FkBKal4lDH8Ka2cCNMw/kItqAt3d5j9NyaslNKGLEi8qoE6
        sdbjBGnCRJykv552LBoGqHWxCFvCGtg0eGIeGottgNxHsxtT6sQp3kajZuWPo5nxF3pFpeMWTynFY
        bwldQC66NWZ2U4WXEKWQYUqbqeRk1eqsVn1VMku/pS6vscHtaEd68SSUgyUPdSzHmv+w1h+1dwhMW
        fGBaglPrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4ine-0008AA-SJ; Fri, 15 Mar 2019 09:06:46 +0000
Date:   Fri, 15 Mar 2019 02:06:46 -0700
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
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
Message-ID: <20190315090646.GC4470@infradead.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551819273-640-3-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	struct scatterlist *sg;
> +	int i, j;
> +	void *vaddr;
> +	pgprot_t pgprot;
> +	struct sg_table *table = buffer->sg_table;
> +	int npages = PAGE_ALIGN(buffer->heap_buffer.size) / PAGE_SIZE;
> +	struct page **pages = vmalloc(array_size(npages,
> +						 sizeof(struct page *)));
> +	struct page **tmp = pages;
> +
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pgprot = PAGE_KERNEL;
> +
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
> +		struct page *page = sg_page(sg);
> +
> +		WARN_ON(i >= npages);
> +		for (j = 0; j < npages_this_entry; j++)
> +			*(tmp++) = page++;

This should probably use nth_page.

That being said I really wish we could have a more iterative version
of vmap, where the caller does a get_vm_area_caller and then adds
each chunk using another call, including the possibility of mapping
larger than PAGE_SIZE contigous ones.  Any chance you could look into
that?

> +		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
> +				      vma->vm_page_prot);

So the same chunk could be mapped to userspace and vmap, and later on
also DMA mapped.  Who is going to take care of cache aliasing as I
see nothing of that in this series?

> +	if (buffer->kmap_cnt) {
> +		buffer->kmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr = dma_heap_map_kernel(buffer);
> +	if (WARN_ONCE(!vaddr,
> +		      "heap->ops->map_kernel should return ERR_PTR on error"))
> +		return ERR_PTR(-EINVAL);
> +	if (IS_ERR(vaddr))
> +		return vaddr;
> +	buffer->vaddr = vaddr;
> +	buffer->kmap_cnt++;

The cnt manioulation is odd.  The normal way to make this readable
is to use a postfix op on the check, as that makes it clear to everyone,
e.g.:

	if (buffer->kmap_cnt++)
		return buffer->vaddr;
	..

> +	buffer->kmap_cnt--;
> +	if (!buffer->kmap_cnt) {
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr = NULL;
> +	}

Same here, just with an infix.

> +static inline void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +				 void (*free)(struct heap_helper_buffer *))
> +{
> +	buffer->private_flags = 0;
> +	buffer->priv_virt = NULL;
> +	mutex_init(&buffer->lock);
> +	buffer->kmap_cnt = 0;
> +	buffer->vaddr = NULL;
> +	buffer->sg_table = NULL;
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	buffer->free = free;
> +}

There is absolutely no reason to inlines this as far as I can tell.

Also it would seem much simpler to simply let the caller assign the
free callback.
