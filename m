Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5AA2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a4pnaBEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFLKRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:17:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34139 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfFLKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:17:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190612101658euoutp0161265aa34792a83a39904ba9d48d318b~nbBGJ8pdP2980929809euoutp01u
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 10:16:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190612101658euoutp0161265aa34792a83a39904ba9d48d318b~nbBGJ8pdP2980929809euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560334618;
        bh=nenqkDXBlGquYGp2/Nq01svR1C1yL5SreYVqcUsRLu4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a4pnaBEipqqcGjNqpOPKEw8iI+jO6LM2RJzx/2aXYnDaXnrSC2XRE8Mqrjf+xtB2N
         CVxJssaPGC1eRGiP/if1q8ibtrkRDjHUHeKptXTSRtGHD8qgvgy92bHpBS9dDkloKD
         /s8gGVfaZOiVaF1lwgdHHwgD+uxz8xwxesdz6B3c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190612101657eucas1p2ed277e7786ff4a14f9a9814768548461~nbBFK42EZ0234702347eucas1p2g;
        Wed, 12 Jun 2019 10:16:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.9B.04298.911D00D5; Wed, 12
        Jun 2019 11:16:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190612101656eucas1p2bacf1537ff5aff54d1e24f3c7ac878be~nbBEYh7yf0232502325eucas1p2r;
        Wed, 12 Jun 2019 10:16:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190612101656eusmtrp2a67b60e92b619fc30e4296fca7e7eaf0~nbBEJcHxk0080900809eusmtrp2W;
        Wed, 12 Jun 2019 10:16:56 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-bd-5d00d1193e4b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.04.04146.811D00D5; Wed, 12
        Jun 2019 11:16:56 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190612101655eusmtip1c605a516b0d1dc52b5159c6165ce6322~nbBDWHlfv2408224082eusmtip1A;
        Wed, 12 Jun 2019 10:16:55 +0000 (GMT)
Subject: Re: [PATCH v2 1/7] drm/bridge: move ANA78xx driver to analogix
 subdirectory
To:     Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5617d9f2-9935-eec6-748b-02cd00450d76@samsung.com>
Date:   Wed, 12 Jun 2019 12:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604122251.676BF68B05@newverein.lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O7cdpdVxFnsrK1pIGnQxCr6opMjgUD/qV3TRctXBhpvaTqvM
        ouUNtaIMuzhN10USGzSmU2eZMafrpjWz0m5KapBiiTphdDHnUfLf8z7P+7zf88DHkopiZh6r
        STwm6BPVWhUTRFU1+V4tn+sJiF1l75Xhiy3PCJzZ9A3hsao8Epe4Wmjc5v3J4NG25wROv/OA
        wZW1zTQevvWFwDl5d2XY1v2Oxm9qixhc+t5D4K7v9Qhn1rlk+LO1GeEK21US+2qLKexzviI2
        hfB3fH8J3lJsQXyxJZXvbeiX8YVGD8Vbv96n+bpRM8U7TJ/HuewCmreV5zD8j5YWGV892kXz
        9TctMr7zvJvgK+6e5R92GJmdwXuDNhwWtJrjgn5lVFzQkfzSXCK5fcnJX0O3kBFdXpiLAlng
        1kBOu5HMRUGsgitDcLusHknDCILMc2mENAwj6La8JKYs+Y9rKEm4h2C0um/SP4Dg0aVW2r8V
        wu0CS961iVuzuQYK8i89p/0DyWUiMFcMU/4thouAPxUdTC5iWTkXBUV1rJ+muDDo8/rNgewc
        bjeMOGwTWM4Fw7OCnglrILcOujsbST8muUWQbi+cxEr40FMykRu4Tyxc7TMyUu5oaOuZ6hAC
        fe5KmYRDYcxRMsmfhc6yDFIyZyOwWx2kJKyHBreH9gclx0M/qF0p0ZvB/vGXzE8DNxPaB4Kl
        DDPhStV1UqLlkJ2lkLYXQ2ezffKgEkpfe5nLSGWa1sw0rY1pWhvT/3fNiCpHSsEg6uIFMTJR
        OLFCVOtEQ2L8ikNJOhsa/7Uv/rqHapC39aATcSxSzZA/uT4Wo6DVx8UUnRMBS6pmy1cnBMQq
        5IfVKacEfdIBvUEriE40n6VUSnlqQNc+BRevPiYkCEKyoJ9SCTZwnhFho2awe8MSXVavpqCk
        8OmTxXGuhft/R8Ro32RE+VIbN0W6rM7vwUPbS7cV1CS3GkbIsLTYhEjzxWuaPO+etdHVS7/d
        sJZfeGood4W//p02K6utRrHgTPrpdUehYzhUbHzb0+/QZww2Dap3JIUrz23OD0lZtWWu2a29
        udqztWjj0EcVJR5RRy4j9aL6H2juCJKxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfc85OzsTF6ep+WJ0Yd1I6NSZma/XCgpe6EsUVJRSow5auU12
        Nsn60EIEXRcbWNnUOW9RNiidmW1Na6aWoWGlXUAXZYJKSZbSyLRNDfz2f57/83su8DCkol4S
        zZzUGgS9Vp2lpEOplzOdA5tgb0j6loohBbrc84JA+R3DAM02WUhU8axHgt5OjtNo6m0XgfKq
        79Go0dUtQT8rBwlUaKmRooYv/RL0xlVGo9p3vQT6NNIKUL7nmRQN3O8GyNlwjUR+l41Cfu8r
        Ykc4rvbPENhhcwBsc5zDX9vGpLjU1Evh+5/vSrBnyk7hR9aBQK7gpgQ31BXS+HtPjxQ/nPok
        wa3lDin2XewksLPmPHZ/MNF7lx7mkvU6o0FYnakTDSnKIzxScXwC4lRbEzg+Nj49URWn3Jya
        fELIOpkj6DenHuMyi2vNRPb7NWf+TFQCE7i60gxkDGS3wuKWZsoMQhkFWwug/0IfPW9EQXfF
        N3Jeh8PpfjM9XzQGYPs9FxU0wtkD0GG5DoJGBNtJQfN4CREMSDYfwOlLI9J5xA3gtUGLNIjQ
        7Eb41/kh0Ith5GwqLPMwwTTFroOjk8FOMiaSPQRLXaa5CXJ2KXxxc2hOy9gE+MXXPrcSyW6A
        07bXC3oVzHtQuqCj4MehCuIqUFgX4dZFiHURYl2E2AFVByIEo6jJ0Ig8J6o1olGbwR3XaRpA
        4F2aOvzOZvC6fr8XsAxQhsmf3JhNU0jUOWKuxgsgQyoj5KrTIekK+Ql17llBrzuqN2YJohfE
        BY6zkNGRx3WB59MajvJxfDxK4ONj42O3IWWUvIB9mqZgM9QG4bQgZAv6/xzByKJNIC3MZ/es
        8Pt2Pb69a9/vpK64STse4a68ait2970ZGH8XXgT3FLUN91fyeGNSDBipKomW5St8g94y+06l
        xxdyzHiJ6msZ5X4sm4lVjZd3LFm/ovvXoTsbHldNnGKdKQWJjbw39ev27GSb9pZBVWjNbGEM
        z3cfdKiXr3WL7aUqJSVmqvkYUi+q/wE8TxNWRAMAAA==
X-CMS-MailID: 20190612101656eucas1p2bacf1537ff5aff54d1e24f3c7ac878be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190604122320epcas3p3bdb18dc38aaad91e8c132625649db9ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190604122320epcas3p3bdb18dc38aaad91e8c132625649db9ba
References: <20190604122150.29D6468B05@newverein.lst.de>
        <CGME20190604122320epcas3p3bdb18dc38aaad91e8c132625649db9ba@epcas3p3.samsung.com>
        <20190604122251.676BF68B05@newverein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2019 14:22, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> As ANA78xx chips are designed and produced by Analogix Semiconductor,
> Inc, move their driver codes into analogix subdirectory.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/bridge/Kconfig                           | 10 ----------
>  drivers/gpu/drm/bridge/Makefile                          |  4 ++--
>  drivers/gpu/drm/bridge/analogix/Kconfig                  | 10 ++++++++++
>  drivers/gpu/drm/bridge/analogix/Makefile                 |  1 +
>  drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c |  0
>  drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h |  0
>  6 files changed, 13 insertions(+), 12 deletions(-)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (100%)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h (100%)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index ee777469293a..862789bf64a0 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -16,16 +16,6 @@ config DRM_PANEL_BRIDGE
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> -config DRM_ANALOGIX_ANX78XX
> -	tristate "Analogix ANX78XX bridge"
> -	select DRM_KMS_HELPER
> -	select REGMAP_I2C
> -	---help---
> -	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> -	  designed for portable devices. The ANX78XX transforms
> -	  the HDMI output of an application processor to MyDP
> -	  or DisplayPort.
> -
>  config DRM_CDNS_DSI
>  	tristate "Cadence DPI/DSI bridge"
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 4934fcf5a6f8..a6c7dd7727ea 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
> @@ -12,8 +11,9 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> -obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> +
> +obj-y += analogix/
>  obj-y += synopsys/
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index e930ff9b5cd4..704fb0f41dc3 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -1,4 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config DRM_ANALOGIX_ANX78XX
> +	tristate "Analogix ANX78XX bridge"
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	help
> +	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> +	  designed for portable devices. The ANX78XX transforms
> +	  the HDMI output of an application processor to MyDP
> +	  or DisplayPort.
> +
>  config DRM_ANALOGIX_DP
>  	tristate
>  	depends on DRM
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index fdbf3fd2f087..6fcbfd3ee560 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
> +obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
> similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h


