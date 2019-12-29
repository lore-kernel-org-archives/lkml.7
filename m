Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF8EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A0207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL2JLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 04:11:25 -0500
Received: from mailoutvs62.siol.net ([185.57.226.253]:56271 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbfL2JLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 04:11:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 02CDE52154E;
        Sun, 29 Dec 2019 10:11:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qbCTLp6YsYnV; Sun, 29 Dec 2019 10:11:21 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 98855521C67;
        Sun, 29 Dec 2019 10:11:21 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 4286F52154E;
        Sun, 29 Dec 2019 10:11:20 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        roman.stratiienko@globallogic.com
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: Re: [RFC 1/4] drm/sun4i: Wait for previous mixing process finish before committing next
Date:   Sun, 29 Dec 2019 10:11:19 +0100
Message-ID: <7696383.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20191228202818.69908-2-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com> <20191228202818.69908-2-roman.stratiienko@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 28. december 2019 ob 21:28:15 CET je 
roman.stratiienko@globallogic.com napisal(a):
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Screen composition that requires dynamic layout modification,
> especially scaling is corrupted when layout changes.
> 
> For example if one of the layer scales down, misaligned lines can be
> observed, and dynamic increasing of destination area makes mixer to hang
> and draw nothing after drawing modified layer.
> 
> After deep investigation it turns that scaler double-buffered registers
> are not latched by GLB_DBUFFER bit, instead thay are latched immidiately.
> 
> Only way to avoid artifacts is to change the registers after mixer finish
> previous frame.
> 
> Similar was made in sunxi BSP - scaler register values was stored into RAM,
> and moved into registers at sync together with GLB_DBUFFER.
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

Nice catch! However, I'm a bit worried about blocking nature of this solution. 
What about shadowing scaler registers and applying them in "finish_irq" 
handler? You see, VI scaler can in some cases consume almost all time between 
two VSync events. That issue came up on A64 mixer1 with downscaling 4K videos 
in real time. I imagine that this solution might block for too long in this 
case.

Check VI coarse scaling code:
https://elixir.bootlin.com/linux/v5.5-rc3/source/drivers/gpu/drm/sun4i/
sun8i_vi_layer.c#L144

> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 15 +++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index 8b803eb903b8..eea4813602b7
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -257,6 +257,20 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32
> format) return NULL;
>  }
> 
> +static void sun8i_atomic_begin(struct sunxi_engine *engine,
> +			       struct drm_crtc_state *old_state)
> +{
> +	int reg, ret;
> +
> +	ret = regmap_read_poll_timeout(engine->regs, 
SUN8I_MIXER_GLOBAL_STATUS,
> +				       reg,
> +				       !(reg & 
SUN8I_MIXER_GLOBAL_STATUS_BUSY),
> +				       200, 100000);
> +
> +	if (ret)
> +		pr_warn("%s: Wait for frame finish timeout\n", __func__);

Newly introduced drm_warn() should be used here.

Best regards,
Jernej

> +}
> +
>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -310,6 +324,7 @@ static struct drm_plane **sun8i_layers_init(struct
> drm_device *drm, static const struct sunxi_engine_ops sun8i_engine_ops = {
>  	.commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
> +	.atomic_begin	= sun8i_atomic_begin,
>  };
> 
>  static struct regmap_config sun8i_mixer_regmap_config = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> b/drivers/gpu/drm/sun4i/sun8i_mixer.h index c6cc94057faf..915479cc3077
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -25,6 +25,8 @@
> 
>  #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
> 
> +#define SUN8I_MIXER_GLOBAL_STATUS_BUSY		BIT(4)
> +
>  #define DE2_MIXER_UNIT_SIZE			0x6000
>  #define DE3_MIXER_UNIT_SIZE			0x3000




