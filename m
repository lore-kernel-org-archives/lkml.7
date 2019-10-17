Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA13CFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6A020872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440534AbfJQQyz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:54:55 -0400
Received: from mailoutvs57.siol.net ([185.57.226.248]:49257 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732079AbfJQQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:54:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3DE9E52402E;
        Thu, 17 Oct 2019 18:54:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D6UzhXF7HyCW; Thu, 17 Oct 2019 18:54:51 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DCFF2524BFA;
        Thu, 17 Oct 2019 18:54:51 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 8A3395247E3;
        Thu, 17 Oct 2019 18:54:51 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, hverkuil@xs4all.nl, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 5/6] media: sun4i: Add H3 deinterlace driver
Date:   Thu, 17 Oct 2019 18:54:51 +0200
Message-ID: <14416618.qeK7XMoh1f@jernej-laptop>
In-Reply-To: <20191017092800.old6jcyeoq3ruawv@gilmour>
References: <20191016192807.1278987-1-jernej.skrabec@siol.net> <20191016192807.1278987-6-jernej.skrabec@siol.net> <20191017092800.old6jcyeoq3ruawv@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 17. oktober 2019 ob 11:28:00 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> I have a small comment that can definitely be addressed in a subsequent
> patch
> On Wed, Oct 16, 2019 at 09:28:06PM +0200, Jernej Skrabec wrote:
> > +	dev->bus_clk = devm_clk_get(dev->dev, "bus");
> > +	if (IS_ERR(dev->bus_clk)) {
> > +		dev_err(dev->dev, "Failed to get bus clock\n");
> > +
> > +		return PTR_ERR(dev->bus_clk);
> > +	}
> > +
> > +	dev->mod_clk = devm_clk_get(dev->dev, "mod");
> > +	if (IS_ERR(dev->mod_clk)) {
> > +		dev_err(dev->dev, "Failed to get mod clock\n");
> > +
> > +		return PTR_ERR(dev->mod_clk);
> > +	}
> > +
> > +	dev->ram_clk = devm_clk_get(dev->dev, "ram");
> > +	if (IS_ERR(dev->ram_clk)) {
> > +		dev_err(dev->dev, "Failed to get ram clock\n");
> > +
> > +		return PTR_ERR(dev->ram_clk);
> > +	}
> > +
> > +	dev->rstc = devm_reset_control_get(dev->dev, NULL);
> > +	if (IS_ERR(dev->rstc)) {
> > +		dev_err(dev->dev, "Failed to get reset control\n");
> > +
> > +		return PTR_ERR(dev->rstc);
> > +	}
> > +
> > +	clk_set_rate_exclusive(dev->mod_clk, 300000000);
> 
> clk_set_rate_exclusive puts a pretty big constraint on the clock tree,
> and we shouldn't really enforce it if the device is unused.

That is true in general, but as I said before, that is not really an issue for 
H3. Deinterlace clock default parent is peripheral clock, which is fixed to 600 
MHz and doesn't change.

> 
> I guess we should move it to the runtime_pm resume hook (with the
> put_exclusive call in suspend).

Ok, I'll move it in case that this deinterlace core is used on other SoCs with 
non-fixed parent clock.

> 
> Otherwise, that patch is
> Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!

Best regards,
Jernej




