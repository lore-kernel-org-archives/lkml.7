Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F2C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429EE20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfL2JZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 04:25:16 -0500
Received: from mailoutvs37.siol.net ([185.57.226.228]:46932 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbfL2JZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 04:25:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 345CD5209D1;
        Sun, 29 Dec 2019 10:25:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xV8-l4oTnBLS; Sun, 29 Dec 2019 10:25:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D585B5209D2;
        Sun, 29 Dec 2019 10:25:12 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 96D045209D1;
        Sun, 29 Dec 2019 10:25:12 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [RFC 4/4] drm/sun4i: Update mixer's internal registers after initialization
Date:   Sun, 29 Dec 2019 10:25:12 +0100
Message-ID: <2960593.5fSG56mABF@jernej-laptop>
In-Reply-To: <20191228202818.69908-5-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com> <20191228202818.69908-5-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 28. december 2019 ob 21:28:18 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> At system start blink of u-boot ghost framebuffer can be observed.
> Fix it.

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Please note that U-Boot to Linux handover may not be without issues. I noticed 
that in some cases, HDMI EDID readout is broken. I guess already initialized 
HDMI controller doesn't like to be reinitialized. Or it may have something to 
do with the fact that U-Boot HDMI driver sets I2C timing and Linux kernel uses 
default one.

Best regards,
Jernej

> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index da84fccf7784..b906b8cc464e
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -588,6 +588,9 @@ static int sun8i_mixer_bind(struct device *dev, struct
> device *master, regmap_update_bits(mixer->engine.regs,
> SUN8I_MIXER_BLEND_PIPE_CTL(base), SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
> 
> +	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_DBUFF,
> +		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
> +
>  	return 0;
> 
>  err_disable_bus_clk:




