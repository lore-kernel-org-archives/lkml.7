Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F33CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DDC2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0V1Hbvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbfJXBaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:30:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Z7ZCJGwnZqvSqKFTwP6utocG5I1evhvOjHrEG4uqfs=; b=H0V1HbvolB8u0MRm0bkksA4ZF
        xR7OaEFPqYFcLmJKQfLuS2eetOR0oSHm2bGbaEkcK2Hlff5GOxeZDSDuUpiQ1Xpz8isL50Tu+nZqJ
        XpyTOeR6aMq61FfG+FqKZ+MlncyrxaS9HyvIxAuDhl+jM3OUudVrGilEYuDOgcq/+phYKgEOw+KwB
        UOG9vLIwNmnEmRBAZsRybNDYs2OP67bV+GRjRDezsDeDQRcWdgBqLfSFHhL0z99Fra694vCO7DiLe
        dyNN6q1l1CCC4rulWz442mcrfts+nGkXXMPTYyKKizq8nHWAO6Co7MbE409oNTKf02Ypz0b7NQGHd
        dA0KzLhfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNRxD-0001Xn-Co; Thu, 24 Oct 2019 01:30:19 +0000
Date:   Wed, 23 Oct 2019 18:30:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, alan.mikhak@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
Message-ID: <20191024013019.GA675@infradead.org>
References: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
 <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:07:10PM -0700, Palmer Dabbelt wrote:
> > > +		/* skip contexts other than supervisor external interrupt */
> > > +		if (parent.args[0] != IRQ_S_EXT)
> > >  			continue;
> > 
> > Will this need to change for RISC-V M-mode Linux support?
> > 
> > https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/
> 
> Yes.

For M-mode we'll want to check IRQ_M_EXT above.  So we should just
merge this patch ASAP and then for my rebased M-mode series I'll
fix the check to do that for the M-Mode case, which is much cleaner
than my hack.
