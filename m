Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4310DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8EA20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Xv4aMsJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfJNM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:59:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54866 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfJNM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:59:08 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5F42A5C0D8D;
        Mon, 14 Oct 2019 14:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571057945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrIk/+NuneeimSRaD+CUqurgwLLXMUHt9TmXZu2aqpA=;
        b=Xv4aMsJ9afzK00Ld1FLFhDFzXUNX9iYwatA5qEdjd+uXiJ+2IJv8fm/mhS/0MqSvOEZPpp
        CA8HQH5Ct1Gby0YK3hpwVfSxDkq7VbMJ609XS//x1ShVd4oDcy4EpZ1FceBBGhKlkP0uD3
        n28S1auNMXzYIssL/sGaCXW1ba7sxYA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 14 Oct 2019 14:59:05 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/14] drm/mxsfb: Reset vital registers for a proper
 initialization
In-Reply-To: <1567078215-31601-5-git-send-email-robert.chiras@nxp.com>
References: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
 <1567078215-31601-5-git-send-email-robert.chiras@nxp.com>
Message-ID: <29759c86d92f5f59da16a2ae2438c649@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-29 13:30, Robert Chiras wrote:
> Some of the registers, like LCDC_CTRL, CTRL2_OUTSTANDING_REQS and
> CTRL1_RECOVERY_ON_UNDERFLOW needs to be properly cleared/initialized
> for a better start and stop routine.


This patch uses CTRL2_OUTSTANDING_REQS which is only introduced in the
next patch. This breaks bisectability.

--
Stefan

> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Tested-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index b69ace8..5e44f57 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -127,6 +127,10 @@ static void mxsfb_enable_controller(struct
> mxsfb_drm_private *mxsfb)
>  		clk_prepare_enable(mxsfb->clk_disp_axi);
>  	clk_prepare_enable(mxsfb->clk);
>  
> +	if (mxsfb->devdata->ipversion >= 4)
> +		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
> +		       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +
>  	/* If it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
>  
> @@ -136,12 +140,19 @@ static void mxsfb_enable_controller(struct
> mxsfb_drm_private *mxsfb)
>  	writel(reg, mxsfb->base + LCDC_VDCTRL4);
>  
>  	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
> +	writel(CTRL1_RECOVERY_ON_UNDERFLOW, mxsfb->base + LCDC_CTRL1 + REG_SET);
>  }
>  
>  static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
>  {
>  	u32 reg;
>  
> +	if (mxsfb->devdata->ipversion >= 4)
> +		writel(CTRL2_OUTSTANDING_REQS(0x7),
> +		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
> +
> +	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
> +
>  	/*
>  	 * Even if we disable the controller here, it will still continue
>  	 * until its FIFOs are running out of data
> @@ -295,6 +306,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
>  	dma_addr_t paddr;
>  
>  	mxsfb_enable_axi_clk(mxsfb);
> +	writel(0, mxsfb->base + LCDC_CTRL);
>  	mxsfb_crtc_mode_set_nofb(mxsfb);
>  
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
