Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41991C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D40F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B5A2tsH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCKPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:47:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C+qz6JiqwVYBZHajEVbScMdi8y6lSsNbkpQ6wInWVNs=; b=B5A2tsH2s/+vYQnPvr/LRR6Dx
        Z5uiQJzXB9gwg0KsLj6S6y8u0u0YZWi6mcxC+pni5lM5cG2miMxbDXUaUE9ywb/JrPY2Wg0FgVLFt
        6mqceM8aQ5VKpMvNOIZsgpn3MCFBlqr/XBheAE1+v7lZ/dSLoZGuw65Le+Qw04h2DEoPlbn2jI9ig
        16bGF1MXB76CskTKW+MSMAXKYbjm4374MkcEKQOiYXcAS7MS+bxRBs+dSx3ScvCaHz+lqa/Xr2BT1
        IGTIOIjYCL+XnLzpWuwXxpumWJpIwwm1wH/DSQPWYVhbBRu5wxEAG7jvLB4jfA09DwIvB577riITu
        3xGzxdrQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3N8h-0002i5-88; Mon, 11 Mar 2019 15:46:55 +0000
Date:   Mon, 11 Mar 2019 08:46:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Brian Brooks <brian.brooks@linaro.org>,
        David Miller <davem@davemloft.net>,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20190311154655.GB28982@infradead.org>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
 <20180827135524.fv4mxkwjn5bv7p5e@di3>
 <20180827154843.GA25821@infradead.org>
 <20190301142602.GC3554@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301142602.GC3554@kwain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 03:26:02PM +0100, Antoine Tenart wrote:
> Hi Christoph,
> 
> I saw you sent this patch as part of another series back in August, but
> it seems it was never applied and I can't find it even in -next. We made
> some tests and this patch is helping a lot the PPv2 engine driver in
> improving its performances.
> 
> Do you plan on re-sending it, or reworking it? Are there current issues
> with it that prevent it from being merged upstream? Can we help in any
> way?

Hi Antoine,

it's been a while, but my vague memory is that this caused failures
in some ARM setups, and I was tought why for AMBA setting up the
default mask is a bad idea.  I don't really remember more, though.
