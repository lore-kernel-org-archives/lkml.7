Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2926121872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWtF51Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfCOIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:54:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LupZRW1uB+cSCMAHlxjj+Z/tSq1eYIlK2KG3gehlTIc=; b=UWtF51UmCT4NEFMfpWluvUMaZ
        aE9KaHuLwKiM10lvO42/MoJMW0RTbmKWS7IK0OH+dYhLD7XE+zeguTUgmWTjsNk4j0mZH9WZ87F1D
        ZYvGJX23mQprmddgQhoYVYSaqz5URIPcSTX+IHrAT9F1vbMmD1QWCyNBV9aJD0QatdkuifqM7dtRj
        RvGJwvU1IFBj4r57fkgGoU1Vo7npA+hGidFUQvDluxO2rGh/ishtM4wCIukWgL/LumymAx3wJtjEl
        O080+5O5CIr01NcHTulZzI3arGVLUUT8NEM6CuAXyGo7hTRk2jpLeSF03o3XdF+gZ2T+CxGO5Wv26
        yxK8VQ69w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4ic2-0001QE-RI; Fri, 15 Mar 2019 08:54:46 +0000
Date:   Fri, 15 Mar 2019 01:54:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Message-ID: <20190315085446.GA4470@infradead.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551819273-640-2-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dma_heap_release(struct inode *inode, struct file *filp)
> +{
> +	filp->private_data = NULL;
> +
> +	return 0;
> +}

No point in clearing ->private_data, the file is about to be freed.

> +
> +static long dma_heap_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long arg)

Pleae don't use the weird legacy filp naming, file is a perfectly
valid and readable default name for struct file pointers.

> +{
> +	switch (cmd) {
> +	case DMA_HEAP_IOC_ALLOC:
> +	{
> +		struct dma_heap_allocation_data heap_allocation;
> +		struct dma_heap *heap = filp->private_data;
> +		int fd;

Please split each ioctl into a separate function from the very start,
otherwise this will grow into a spaghetty mess sooner than you can
see cheese.

> +	dev_ret = device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);

No need this weird argument alignment.
