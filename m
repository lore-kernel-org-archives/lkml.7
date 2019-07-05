Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB999C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435D2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfGEKcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:32:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGEKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:32:06 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hjLVc-0008Jm-Pl; Fri, 05 Jul 2019 12:32:04 +0200
Message-ID: <1562322724.4291.5.camel@pengutronix.de>
Subject: Re: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Wen He <wen.he_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Leo Li <leoyang.li@nxp.com>
Date:   Fri, 05 Jul 2019 12:32:04 +0200
In-Reply-To: <20190508105755.5881-1-wen.he_1@nxp.com>
References: <20190508105755.5881-1-wen.he_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

On Wed, 2019-05-08 at 10:56 +0000, Wen He wrote:
> The new LS1028A DP driver code causes a link failure when DRM_IMX built-in,
> but platform is ARCH_LAYERSCAPE:
> 
> drivers/gpu/drm/imx/ipuv3-crtc.c:51: undefined reference to `ipu_prg_enable'
> drivers/gpu/drm/imx/ipuv3-crtc.c:52: undefined reference to `ipu_dc_enable'
> drivers/gpu/drm/imx/ipuv3-crtc.c:53: undefined reference to `ipu_dc_enable_channel'
> drivers/gpu/drm/imx/ipuv3-crtc.c:54: undefined reference to `ipu_di_enable'
> drivers/gpu/drm/imx/ipuv3-crtc.o: In function `ipu_crtc_mode_set_nofb
> 
> Adding a Kconfig dependency allow to build if ARCH_LAYERSCAPE is enable.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
>  drivers/gpu/ipu-v3/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
> index fe6f8c5b4445..51ea88c440df 100644
> --- a/drivers/gpu/ipu-v3/Kconfig
> +++ b/drivers/gpu/ipu-v3/Kconfig
> @@ -1,6 +1,6 @@
>  config IMX_IPUV3_CORE
>  	tristate "IPUv3 core support"
> -	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM || COMPILE_TEST
> +	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM || COMPILE_TEST || ARCH_LAYERSCAPE
>  	depends on DRM || !DRM # if DRM=m, this can't be 'y'
>  	select BITREVERSE
>  	select GENERIC_ALLOCATOR if DRM
> -- 
> 2.17.1

Thank you for the patch, but this does not seem right.
ipuv3-crtc.c is part of DRM_IMX, which already depends on
IMX_IPUV3_CORE. How did you manage to make it try to compile imxdrm?

Since LS1028A does not have the IPUv3, keeping this under COMPILE_TEST
should be correct.

regards
Philipp
