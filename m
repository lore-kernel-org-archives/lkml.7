Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDD6229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hsg2cctp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389569AbfGYMzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:55:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbfGYMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s5Z6EurVp6TZLOQ8ZvNGlmSS1tYEjf/1b9mDRYLPXPs=; b=Hsg2cctp+d5eAKszON1CuJxF0
        tcXTs/jkypbx96r4p5rG727pZLN5sHbmjfWb0/B307oo998Gebr8TaBpQ8sZKbE0sWRHR+X417+LD
        VwYhd9vnYU0+lmOr33lgDmDl6DBvOOBv8/tolWozRgh9SbwFgrUKdNloZrELvjNo1yJ9MIxiY/SO9
        olPNILvoTyJxmM4dnrY5k3G2utGJbF4WDBfoWLz1rGmv/jb0xvkzexLDrjGmTXadTiCZHmpuiQO4M
        HmWjr7MYJ8wNjnUhgmQY7kWhxpbTLw2SllYdqrLAPsWeNtgZdp4TVoiplhC5PKbKu5idSw9KMgB9J
        IEHb715cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdHm-0004PR-MU; Thu, 25 Jul 2019 12:55:54 +0000
Date:   Thu, 25 Jul 2019 05:55:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20190725125554.GF20286@infradead.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
 <20190724003656.59780-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724003656.59780-3-john.stultz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct dma_buf *heap_helper_export_dmabuf(
> +				struct heap_helper_buffer *helper_buffer,
> +				int fd_flags)

Indentation seems odd here as it doesn't follow any of the usual schools
for multi-level prototypes.  But maybe shortening some identifier would
help avoiding that problem altogether :)

> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}

Note that a lot of systems don't have highmem at all or don't support
CMA in highmem.  So for contigous allocations that aren't highmem we
could skip the vmap here altogether and just use the direct mapping.
