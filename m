Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F97C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAD921881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p54r3CaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGCRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:21:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfGCRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KLNpXUeBNjOGtXnDQ3qzX7M6wN19aQMGgVhJjQ1BSuc=; b=p54r3CaTxN1VjNO3vNGbNNXLB
        djZuP4fanPNsLlBqMzU5MoP+1WLXTYZva0j3m3P7OUtM3wERwG+ot3qGTaebOvLcOlZE0NaZzIL2D
        /HTFZdIBzKlwn1NFvQKlPE48i6NLNn5ZwqhLc804x/8rUCdrK0U+KhMah1s+XDe5M9w0MpvU4susf
        HjmAYtShG3Hd42th/Q8PDRRdMRwIQH7zILUpUh67kFTwPYTmmjHzvF5JLUV7gOAchy78zV/lHSv4x
        sJF1Mv54B5XJdRqqtIALihUynxzBVmmmmiJsl7TXUVScwRO2NcTplls5IExQYeZMS5sUhuWfEg2+L
        0h3Q2PXug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiiwW-0007Al-2D; Wed, 03 Jul 2019 17:21:16 +0000
Date:   Wed, 3 Jul 2019 10:21:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, brian.brooks@linaro.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nadavh@marvell.com, stefanc@marvell.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Allow using a dedicated dma_mask
 for platform_device
Message-ID: <20190703172115.GA22034@infradead.org>
References: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
 <20190628155946.GA16956@infradead.org>
 <20190701132340.21123dee@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701132340.21123dee@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 01:24:39PM +0200, Maxime Chevallier wrote:
> I agree that this the real solution, it just seemed a bit overwhelming
> to me. I'll be happy to help with this though, now that you took a big
> first step.

I think the first step is to resurrect my original patch to default
to a 32-bit DMA mask for platform devices, as that will cut a lot
of crap from the platform device declarations.

IIRC the problem back then was that USB uses the fact that a DMA
mask exist to decide if it uses a DMA vs PIO path in the HCD core.

So I'll need some help from Greg or other USB folks to clean that up,
after that we can try to apply my patch again (preferably early in
the next merge window), and once that sticks clean up all the 32-bit
dma mask initialization for platform devices, and then turn the dma_mask
into a scalar.
