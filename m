Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B9C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3946B21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxotBa+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbfGYNCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:02:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGYNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X2Ie7x+H1aHkmtp8bzILEEJm3H5F1Un7xFNqVCdOo2s=; b=KxotBa+KzoGYIcHTbkuHbvWeb
        f6ODLmsytevCUprW3mMkkhsdqClh0iQhTaKFThR8RbICbEAB2wcCVXvGsDmAVwGOILNRONMOYfWGY
        oX8FTAuFBjNnC78XPJSqra4UVoO+a+k7I2E9cjE3Q6eLiyFEkKv8dzNIKDA8kggWhAyEOZy6lMWuu
        DmwzzStn8YkQvGKzYRZ9A/lEfURc5ma1f8/Ja4A2U8jeWnFOz4g9cnNpLCx3I7qiEZV1l39LTr1ed
        pERpRY0IIE/F6SFohwF+n5u1CTpmhf1rwHdNIcfvQoJwVarDRVP8lHoiKpFTKmuqQWdXl9z0AE7sc
        q4WfMWyRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqdNl-0007NA-0F; Thu, 25 Jul 2019 13:02:05 +0000
Date:   Thu, 25 Jul 2019 06:02:04 -0700
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
Subject: Re: [PATCH v7 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
Message-ID: <20190725130204.GG20286@infradead.org>
References: <20190724003656.59780-1-john.stultz@linaro.org>
 <20190724003656.59780-4-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724003656.59780-4-john.stultz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct system_heap {
> +	struct dma_heap *heap;
> +} sys_heap;

It seems like this structure could be removed and if would improve
the code flow.

> +static struct dma_heap_ops system_heap_ops = {
> +	.allocate = system_heap_allocate,
> +};
> +
> +static int system_heap_create(void)
> +{
> +	struct dma_heap_export_info exp_info;
> +	int ret = 0;
> +
> +	exp_info.name = "system_heap";
> +	exp_info.ops = &system_heap_ops;
> +	exp_info.priv = &sys_heap;
> +
> +	sys_heap.heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(sys_heap.heap))
> +		ret = PTR_ERR(sys_heap.heap);
> +
> +	return ret;

The data structures here seem a little odd.  I think you want to:

 - mark all dma_heap_ops instanes consts, as we generally do that for
   all structures containing function pointers
 - move the name into dma_heap_ops.
 - remove the dma_heap_export_info structure, which is a bit pointless
 - don't bother setting a private data, as you don't need it.
   If other heaps need private data I'd suggest to switch to embedding
   the dma_heap structure into containing structure insted so that you
   can use container_of to get at it.
 - also why is the free callback passed as a callback rather than
   kept in dma_heap_ops, next to the paired alloc one?
