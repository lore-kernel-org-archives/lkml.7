Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BD22177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BuzDxzg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCMMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:49:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:49:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so1902628wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jkoYwunv3e2QpBe86AjRH/TzGATaTjYM/hdyzxm0460=;
        b=BuzDxzg+BODYzFIXEq2sfb4ne+mJ20IUGFYzq2Eo1BTbojkdyVuXIi/2reqyyrEdgq
         KUoEFiUx3SbGt9O35A9HwH6rD7cv6WHX5c/D6NrLfzdufTOWfW6a0pZC0j6Z5i8a5Tzx
         cldxIH4Tmp4mTuU3hPnOKoBPdSAssZFMuY0xBHycyI0hNsazznfat3WPQIEb9z4EbMUc
         hTeMiTDP5xEDdTxp/kanwrnKwJGQK0fP134jlCeYEOutxvy8zeKBRzkGQDJ+fHDhxr6q
         8DO1QhjbDKPaNiezORbQ44NoOtzLzs5jaBBFPxdZO0KTTG7GuXlNSd/CoAXXg6kptJsK
         CzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jkoYwunv3e2QpBe86AjRH/TzGATaTjYM/hdyzxm0460=;
        b=O8FN/pptZErkQbE/IHZQVFeu+gpHohY0nYimFRmNuoFpaRjHkTv22nUfzkRjrcr+gM
         m2QKn4Egd84m1AV4xUZ8xZfxmNw+0LzfCWaq88c2z7IpDk+9OZH81F39zqgxsI+c+lIa
         rPerhixfsS4zR0NzWtvFfoG3KiHDXsh+WcGqNFhVDsaKCA9e+iLqTlazvWy8S8PXF/H3
         ILfKFeWEB/nYKs4kiCk8mkPzqz2fpQxxwQXDRZmyNIxxnLrrSgpw06jHmQjsPAc+0owu
         PZ+0CjjajIe0jMNQxHeTMgyRJ7ZcA/X327nAxVuoNFl68BmixJDsr8hL6x6FMmLPJROp
         Oaaw==
X-Gm-Message-State: APjAAAV9itfFaiFAaDGNaRy8Kn6Zr64cQG94HNFLOLXKRb6/PprGbOBq
        tcd59ky2Fic0Sxwbuyuuwr4yUw==
X-Google-Smtp-Source: APXvYqxfydFCz7y2SbfIBN9eEJbmSe+C4BgI9WwMUYhRxahWgYN49Gy1Z+jcnowL/yjj8HChBRbh/w==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr2088266wmb.89.1552481382958;
        Wed, 13 Mar 2019 05:49:42 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o14sm12763419wrp.34.2019.03.13.05.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 05:49:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/meson: exclusively use the canvas provider module
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190311105144.7276-1-mjourdan@baylibre.com>
 <20190311105144.7276-3-mjourdan@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b589f93c-e898-d8ee-d04e-8f3f6a1bdc52@baylibre.com>
Date:   Wed, 13 Mar 2019 13:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311105144.7276-3-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 11:51, Maxime Jourdan wrote:
> Now that the DMC register range is no longer in the bindings, remove any
> mention towards it and exclusively use the meson-canvas module.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/Makefile        |  2 +-
>  drivers/gpu/drm/meson/meson_canvas.c  | 73 -----------------------
>  drivers/gpu/drm/meson/meson_canvas.h  | 51 ----------------
>  drivers/gpu/drm/meson/meson_crtc.c    | 84 ++++++++-------------------
>  drivers/gpu/drm/meson/meson_drv.c     | 68 ++++++++--------------
>  drivers/gpu/drm/meson/meson_drv.h     |  1 -
>  drivers/gpu/drm/meson/meson_overlay.c |  8 ---
>  drivers/gpu/drm/meson/meson_plane.c   |  6 +-
>  drivers/gpu/drm/meson/meson_viu.c     |  1 -
>  9 files changed, 51 insertions(+), 243 deletions(-)
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
> 
> diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
> index 7709f2fbb9f7..d4ea82fc493b 100644
> --- a/drivers/gpu/drm/meson/Makefile
> +++ b/drivers/gpu/drm/meson/Makefile
> @@ -1,5 +1,5 @@
>  meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_venc_cvbs.o
> -meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_canvas.o meson_overlay.o
> +meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_overlay.o
>  
>  obj-$(CONFIG_DRM_MESON) += meson-drm.o
>  obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
> diff --git a/drivers/gpu/drm/meson/meson_canvas.c b/drivers/gpu/drm/meson/meson_canvas.c
> deleted file mode 100644
> index 5de11aa7c775..000000000000
> --- a/drivers/gpu/drm/meson/meson_canvas.c
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/*
> - * Copyright (C) 2016 BayLibre, SAS
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> - * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
> - * Copyright (C) 2014 Endless Mobile
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include "meson_drv.h"
> -#include "meson_canvas.h"
> -#include "meson_registers.h"
> -
> -/**
> - * DOC: Canvas
> - *
> - * CANVAS is a memory zone where physical memory frames information
> - * are stored for the VIU to scanout.
> - */
> -
> -/* DMC Registers */
> -#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
> -#define CANVAS_WIDTH_LBIT	29
> -#define CANVAS_WIDTH_LWID       3
> -#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
> -#define CANVAS_WIDTH_HBIT       0
> -#define CANVAS_HEIGHT_BIT       9
> -#define CANVAS_BLKMODE_BIT      24
> -#define CANVAS_ENDIAN_BIT	26
> -#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
> -#define CANVAS_LUT_WR_EN        (0x2 << 8)
> -#define CANVAS_LUT_RD_EN        (0x1 << 8)
> -
> -void meson_canvas_setup(struct meson_drm *priv,
> -			uint32_t canvas_index, uint32_t addr,
> -			uint32_t stride, uint32_t height,
> -			unsigned int wrap,
> -			unsigned int blkmode,
> -			unsigned int endian)
> -{
> -	unsigned int val;
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_DATAL,
> -		(((addr + 7) >> 3)) |
> -		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_DATAH,
> -		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
> -						CANVAS_WIDTH_HBIT) |
> -		(height << CANVAS_HEIGHT_BIT) |
> -		(wrap << 22) |
> -		(blkmode << CANVAS_BLKMODE_BIT) |
> -		(endian << CANVAS_ENDIAN_BIT));
> -
> -	regmap_write(priv->dmc, DMC_CAV_LUT_ADDR,
> -			CANVAS_LUT_WR_EN | canvas_index);
> -
> -	/* Force a read-back to make sure everything is flushed. */
> -	regmap_read(priv->dmc, DMC_CAV_LUT_DATAH, &val);
> -}
> diff --git a/drivers/gpu/drm/meson/meson_canvas.h b/drivers/gpu/drm/meson/meson_canvas.h
> deleted file mode 100644
> index 85dbf26e2826..000000000000
> --- a/drivers/gpu/drm/meson/meson_canvas.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/*
> - * Copyright (C) 2016 BayLibre, SAS
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> - * Copyright (C) 2014 Endless Mobile
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -/* Canvas LUT Memory */
> -
> -#ifndef __MESON_CANVAS_H
> -#define __MESON_CANVAS_H
> -
> -#define MESON_CANVAS_ID_OSD1	0x4e
> -#define MESON_CANVAS_ID_VD1_0	0x60
> -#define MESON_CANVAS_ID_VD1_1	0x61
> -#define MESON_CANVAS_ID_VD1_2	0x62
> -
> -/* Canvas configuration. */
> -#define MESON_CANVAS_WRAP_NONE	0x00
> -#define	MESON_CANVAS_WRAP_X	0x01
> -#define	MESON_CANVAS_WRAP_Y	0x02
> -
> -#define	MESON_CANVAS_BLKMODE_LINEAR	0x00
> -#define	MESON_CANVAS_BLKMODE_32x32	0x01
> -#define	MESON_CANVAS_BLKMODE_64x64	0x02
> -
> -#define MESON_CANVAS_ENDIAN_SWAP16	0x1
> -#define MESON_CANVAS_ENDIAN_SWAP32	0x3
> -#define MESON_CANVAS_ENDIAN_SWAP64	0x7
> -#define MESON_CANVAS_ENDIAN_SWAP128	0xf
> -
> -void meson_canvas_setup(struct meson_drm *priv,
> -			uint32_t canvas_index, uint32_t addr,
> -			uint32_t stride, uint32_t height,
> -			unsigned int wrap,
> -			unsigned int blkmode,
> -			unsigned int endian);
> -
> -#endif /* __MESON_CANVAS_H */
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 4f5c67f70c4d..37c70641bcdf 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -37,7 +37,6 @@
>  #include "meson_venc.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /* CRTC definition */
> @@ -214,13 +213,7 @@ void meson_crtc_irq(struct meson_drm *priv)
>  		writel_relaxed(priv->viu.osd_sc_v_ctrl0,
>  				priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
>  
> -		if (priv->canvas)
> -			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
> -				priv->viu.osd1_addr, priv->viu.osd1_stride,
> -				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
> -				MESON_CANVAS_BLKMODE_LINEAR, 0);
> -		else
> -			meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
> +		meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
>  				priv->viu.osd1_addr, priv->viu.osd1_stride,
>  				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
>  				MESON_CANVAS_BLKMODE_LINEAR, 0);
> @@ -237,61 +230,34 @@ void meson_crtc_irq(struct meson_drm *priv)
>  
>  		switch (priv->viu.vd1_planes) {
>  		case 3:
> -			if (priv->canvas)
> -				meson_canvas_config(priv->canvas,
> -						    priv->canvas_id_vd1_2,
> -						    priv->viu.vd1_addr2,
> -						    priv->viu.vd1_stride2,
> -						    priv->viu.vd1_height2,
> -						    MESON_CANVAS_WRAP_NONE,
> -						    MESON_CANVAS_BLKMODE_LINEAR,
> -						    MESON_CANVAS_ENDIAN_SWAP64);
> -			else
> -				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_2,
> -						   priv->viu.vd1_addr2,
> -						   priv->viu.vd1_stride2,
> -						   priv->viu.vd1_height2,
> -						   MESON_CANVAS_WRAP_NONE,
> -						   MESON_CANVAS_BLKMODE_LINEAR,
> -						   MESON_CANVAS_ENDIAN_SWAP64);
> +			meson_canvas_config(priv->canvas,
> +					    priv->canvas_id_vd1_2,
> +					    priv->viu.vd1_addr2,
> +					    priv->viu.vd1_stride2,
> +					    priv->viu.vd1_height2,
> +					    MESON_CANVAS_WRAP_NONE,
> +					    MESON_CANVAS_BLKMODE_LINEAR,
> +					    MESON_CANVAS_ENDIAN_SWAP64);
>  		/* fallthrough */
>  		case 2:
> -			if (priv->canvas)
> -				meson_canvas_config(priv->canvas,
> -						    priv->canvas_id_vd1_1,
> -						    priv->viu.vd1_addr1,
> -						    priv->viu.vd1_stride1,
> -						    priv->viu.vd1_height1,
> -						    MESON_CANVAS_WRAP_NONE,
> -						    MESON_CANVAS_BLKMODE_LINEAR,
> -						    MESON_CANVAS_ENDIAN_SWAP64);
> -			else
> -				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_1,
> -						   priv->viu.vd1_addr2,
> -						   priv->viu.vd1_stride2,
> -						   priv->viu.vd1_height2,
> -						   MESON_CANVAS_WRAP_NONE,
> -						   MESON_CANVAS_BLKMODE_LINEAR,
> -						   MESON_CANVAS_ENDIAN_SWAP64);
> +			meson_canvas_config(priv->canvas,
> +					    priv->canvas_id_vd1_1,
> +					    priv->viu.vd1_addr1,
> +					    priv->viu.vd1_stride1,
> +					    priv->viu.vd1_height1,
> +					    MESON_CANVAS_WRAP_NONE,
> +					    MESON_CANVAS_BLKMODE_LINEAR,
> +					    MESON_CANVAS_ENDIAN_SWAP64);
>  		/* fallthrough */
>  		case 1:
> -			if (priv->canvas)
> -				meson_canvas_config(priv->canvas,
> -						    priv->canvas_id_vd1_0,
> -						    priv->viu.vd1_addr0,
> -						    priv->viu.vd1_stride0,
> -						    priv->viu.vd1_height0,
> -						    MESON_CANVAS_WRAP_NONE,
> -						    MESON_CANVAS_BLKMODE_LINEAR,
> -						    MESON_CANVAS_ENDIAN_SWAP64);
> -			else
> -				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_0,
> -						   priv->viu.vd1_addr2,
> -						   priv->viu.vd1_stride2,
> -						   priv->viu.vd1_height2,
> -						   MESON_CANVAS_WRAP_NONE,
> -						   MESON_CANVAS_BLKMODE_LINEAR,
> -						   MESON_CANVAS_ENDIAN_SWAP64);
> +			meson_canvas_config(priv->canvas,
> +					    priv->canvas_id_vd1_0,
> +					    priv->viu.vd1_addr0,
> +					    priv->viu.vd1_stride0,
> +					    priv->viu.vd1_height0,
> +					    MESON_CANVAS_WRAP_NONE,
> +					    MESON_CANVAS_BLKMODE_LINEAR,
> +					    MESON_CANVAS_ENDIAN_SWAP64);
>  		};
>  
>  		writel_relaxed(priv->viu.vd1_if0_gen_reg,
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 12ff47b13668..7913983f2981 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -48,7 +48,6 @@
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
>  #include "meson_venc.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  #define DRIVER_NAME "meson"
> @@ -214,50 +213,31 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	}
>  
>  	priv->canvas = meson_canvas_get(dev);
> -	if (!IS_ERR(priv->canvas)) {
> -		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
> -		if (ret)
> -			goto free_drm;
> -		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
> -		if (ret) {
> -			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> -			goto free_drm;
> -		}
> -		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
> -		if (ret) {
> -			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> -			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
> -			goto free_drm;
> -		}
> -		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
> -		if (ret) {
> -			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> -			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
> -			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
> -			goto free_drm;
> -		}
> -	} else {
> -		priv->canvas = NULL;
> -
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> -		if (!res) {
> -			ret = -EINVAL;
> -			goto free_drm;
> -		}
> -		/* Simply ioremap since it may be a shared register zone */
> -		regs = devm_ioremap(dev, res->start, resource_size(res));
> -		if (!regs) {
> -			ret = -EADDRNOTAVAIL;
> -			goto free_drm;
> -		}
> +	if (IS_ERR(priv->canvas)) {
> +		ret = PTR_ERR(priv->canvas);
> +		goto free_drm;
> +	}
>  
> -		priv->dmc = devm_regmap_init_mmio(dev, regs,
> -						  &meson_regmap_config);
> -		if (IS_ERR(priv->dmc)) {
> -			dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
> -			ret = PTR_ERR(priv->dmc);
> -			goto free_drm;
> -		}
> +	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
> +	if (ret)
> +		goto free_drm;
> +	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
> +	if (ret) {
> +		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> +		goto free_drm;
> +	}
> +	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
> +	if (ret) {
> +		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> +		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
> +		goto free_drm;
> +	}
> +	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
> +	if (ret) {
> +		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
> +		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
> +		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
> +		goto free_drm;
>  	}
>  
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
> index 4dccf4cd042a..214a7cb18ce2 100644
> --- a/drivers/gpu/drm/meson/meson_drv.h
> +++ b/drivers/gpu/drm/meson/meson_drv.h
> @@ -29,7 +29,6 @@ struct meson_drm {
>  	struct device *dev;
>  	void __iomem *io_base;
>  	struct regmap *hhi;
> -	struct regmap *dmc;
>  	int vsync_irq;
>  
>  	struct meson_canvas *canvas;
> diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
> index 691a9fd16b36..b54a22e483b9 100644
> --- a/drivers/gpu/drm/meson/meson_overlay.c
> +++ b/drivers/gpu/drm/meson/meson_overlay.c
> @@ -22,7 +22,6 @@
>  #include "meson_overlay.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /* VD1_IF0_GEN_REG */
> @@ -350,13 +349,6 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
>  
>  	DRM_DEBUG_DRIVER("\n");
>  
> -	/* Fallback is canvas provider is not available */
> -	if (!priv->canvas) {
> -		priv->canvas_id_vd1_0 = MESON_CANVAS_ID_VD1_0;
> -		priv->canvas_id_vd1_1 = MESON_CANVAS_ID_VD1_1;
> -		priv->canvas_id_vd1_2 = MESON_CANVAS_ID_VD1_2;
> -	}
> -
>  	interlace_mode = state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE;
>  
>  	spin_lock_irqsave(&priv->drm->event_lock, flags);
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index 6119a0224278..b7786218cb10 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -38,7 +38,6 @@
>  #include "meson_plane.h"
>  #include "meson_vpp.h"
>  #include "meson_viu.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /* OSD_SCI_WH_M1 */
> @@ -148,10 +147,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>  				   (0xFF << OSD_GLOBAL_ALPHA_SHIFT) |
>  				   OSD_BLK0_ENABLE;
>  
> -	if (priv->canvas)
> -		canvas_id_osd1 = priv->canvas_id_osd1;
> -	else
> -		canvas_id_osd1 = MESON_CANVAS_ID_OSD1;
> +	canvas_id_osd1 = priv->canvas_id_osd1;
>  
>  	/* Set up BLK0 to point to the right canvas */
>  	priv->viu.osd1_blk0_cfg[0] = ((canvas_id_osd1 << OSD_CANVAS_SEL) |
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index e46e05f50bad..ac0f3687e09a 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -25,7 +25,6 @@
>  #include "meson_viu.h"
>  #include "meson_vpp.h"
>  #include "meson_venc.h"
> -#include "meson_canvas.h"
>  #include "meson_registers.h"
>  
>  /**
> 

Finally !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
