Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD1FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC202063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UmgPLgzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408678AbfFLJNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:13:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57591 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfFLJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:13:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612091315euoutp02b2ecc754fe29fdfc60858df709bf77a7~naJdvjzgQ0196201962euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 09:13:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612091315euoutp02b2ecc754fe29fdfc60858df709bf77a7~naJdvjzgQ0196201962euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560330795;
        bh=NT2S4CZiXkYakifxmGkzag7vydnMN1h/CXovgjulgOk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UmgPLgzEW4YOdCJEwgS/Y9rT2FwzcsjKdLQ4sPXXaUcZB2ddjKXxdHZu6RtOHH9QB
         09Ok2FKLYQJ1VDW5/buB8MZnhqZlc3N30knIkvFl4IhY0FixANp+DnWcgesVf0tbHp
         Kn8zZjHG4HcwUbSdxFlJQZJ/v6vqGj+ut5/OvyI8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190612091314eucas1p1493752442b811761654ebb75edbb818f~naJcqb1dU3052130521eucas1p1w;
        Wed, 12 Jun 2019 09:13:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.80.04325.A22C00D5; Wed, 12
        Jun 2019 10:13:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612091313eucas1p1d7b1e334690ff5ca08e46b5950eb2c02~naJbrX8-f2375723757eucas1p1N;
        Wed, 12 Jun 2019 09:13:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190612091313eusmtrp2b1e08a6fc15f9352f8d954612440928b~naJbZcgtG2895928959eusmtrp2G;
        Wed, 12 Jun 2019 09:13:13 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d0-5d00c22aaab9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.C5.04140.822C00D5; Wed, 12
        Jun 2019 10:13:12 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190612091311eusmtip2255a5e4fd7e8daf1002690c7ac80eee1~naJZpxl801773517735eusmtip2R;
        Wed, 12 Jun 2019 09:13:11 +0000 (GMT)
Subject: Re: [PATCH v2 5/7] drm/bridge: Add Analogix anx6345 support
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
Message-ID: <610ab353-7e05-81b6-2cc4-2dac09823d42@samsung.com>
Date:   Wed, 12 Jun 2019 11:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604122302.006A168C7B@newverein.lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRz1u/fu7rpaXKfhrwdEoyCNyh7EFz0oCrkQRERUVJZTLyY6k03N
        ymhZhllRWWmu8pGVZpe0qdMtl7aZq5mrkT3sNSuLHtgDH7Ue2ua18r9zzu+c7/c78DGkopge
        y8QlJvOaRFWCkpZRxmbP3WmhVr+IsJt7aHzYeZvAmc1vER4wHiNxYZNTgtt6P9O4r81B4L0l
        FTSuNrdKcHfxCwIfOHZeig2vH0rwffMZGl945CJwx/sGhDMtTVL8vLIV4SrDSRJ7zAUU9ljv
        EosDuRJPP8EJBQLiCoSd3BvbRyl3WueiuMpXlyWcpa+I4kz6514tK1/CGcoP0Nwnp1PK1fZ1
        SLiGs4KUcx+0E1zV+d3ctXYdvTJgvWxBDJ8Ql8prZiyKlG3ptLyjk7LvoLSSohxCh74Wo2zk
        zwA7By62OKTZSMYo2DIEGXfctEh6EPRke4ZIN4KrH83/IreyhKFIKYLSt0ZCJF3eiP0c4XMF
        ssug1tI1GA9ibRScOOKQ+AjJZiIoquqmfC6aDYHfVe20D8vZRXAoR0f6MMVOBsf37sF9o9l1
        0GMyINETALfzOwez/uw8cLy4IvVhkp0Ae2tOkyIOhiedhYMnAfuMgTMmFy0evgwy6rqGSgTC
        B3u1VMTjYcBUSIh4N7jL9pFiOAtBTaWJFAfzwWZ3eSsw3g0hUGGeIcpLoPBSHe2TgR0Fj7sC
        xBtGQY4xjxRlOWTtV4juieBurRl6MBgu3OuljyKlflgz/bA2+mFt9P/3FiGqHAXzKVp1LK+d
        nchvm65VqbUpibHTo7eqDcj7cVv67b116PqvKCtiGaQcKW/MG9iokKhStdvVVgQMqQySz4r3
        i1DIY1Tbd/CarZs1KQm81orGMZQyWL7Tr2ODgo1VJfPxPJ/Ea/5OCcZ/rA7lR8oz4vT9y9eW
        PViY8iUPpTvo9hPHT87dNNX59Ofq46ktYVPCw4X6JSOV4W2hRzNGu45YNl/PeRlUn5ZZP8mZ
        vFh4v7JJs8s9ptamO7Xv8dL0UyNWldZuOpymVz9MSMLyqFTB0RKdnrsiN9clpOmNZOP3b2vM
        ryt+nL3RHGKLGZApKe0W1cxQUqNV/QEO04I6tAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfe69u5vW4Dq1PQi9sIheoGubmc/KRq94vxhFEb1ZLb2p5DbZ
        nWJGNRDTlmEGks7aFLUXHbqmpc2WtkRTc2WaoZWFrVBEJSxpYdbcCvz2O3/Oj3MOHAEusvHC
        BSlqHatVK1MlZBDRPdcxvH6NMyB+g6dvC7rq6sRQTvtXgP48LMSRuc3FQ/0/pkg009+FoeyK
        OhI12Ht4aLp8GEOXCyv5yPZ5gIf67DdJVPW2F0OfxloAynG08dEHaw9A9bYiHHnsJgJ5nC+x
        bSFMhWcOYywmC2BMlnPMl2fjfKZU30sw1pEaHuOYKSOYR8YP3iyvhMfYqi+TzKTLxWcaZz7x
        mJZbFj7z8UoHxtRXXmSaB/Xk3uAjdIxWk65jVyRrON1WyVEpktFSOaJlG+W0NDI6frMsShKh
        iElkU1MyWG2E4iSd7HaMkmmGFyCzouw6pgffyoEBBAogtRE+z7Pw51lEVQFoMMX6czFsNk/g
        fg6BswMG0t8zDmBJ7sp5DqF2wUbHhDcPEoRSHQQ0TBVj8wVO5QA4mz/Gny9EVDOANbUtPp2k
        1sLf9YM+FlIKmH9d7xtBUKtg189p30ph1CFYatcT/p5g2Fni9nEgJYddw7W+VXFqNZw1vcb9
        vBxmPyj9x2I45DZj14DIuEA3LlCMCxTjAqUMENUglE3nVEkqTkZzShWXrk6iEzQqG/D+y8N2
        T0MTMEzudwJKACSLha03/hwT8ZQZ3FmVE0ABLgkVys4ExIuEicqzWaxWc0KbnspyThDlPa4Q
        Dw9L0Hi/T607IY2SRiO5NDoyOnITkoiFedTTYyIqSaljz7BsGqv972GCwHA9SOzty+9QPdp5
        vmFR8hLrYfvtcItimzNuWWTxgaK51u03LuQUpOrY71fdg6EucY/bsYweNyuGCpcm7Ojul+fS
        x08HqmvuhhX0VesvHYxNEX/f8/5+2jvTbmt8Zm32m6VF1Gi7Zt+9qc2dQ/ipiCc7rKOKx3Vk
        c1Prq4q4rJg7v0ZKJASXrJSuw7Wc8i/dzgLiRQMAAA==
X-CMS-MailID: 20190612091313eucas1p1d7b1e334690ff5ca08e46b5950eb2c02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190604122331epcas1p45e234dfad3f1288cb557e3bae7f9af38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190604122331epcas1p45e234dfad3f1288cb557e3bae7f9af38
References: <20190604122150.29D6468B05@newverein.lst.de>
        <CGME20190604122331epcas1p45e234dfad3f1288cb557e3bae7f9af38@epcas1p4.samsung.com>
        <20190604122302.006A168C7B@newverein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2019 14:23, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The ANX6345 is an ultra-low power DisplayPower/eDP transmitter designed
> for portable devices. This driver adds initial support for RGB to eDP
> mode, without HPD and interrupts.
>
> This is a configuration usually seen in eDP applications.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig            |  12 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |   1 +
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 814 +++++++++++++++++++++
>  3 files changed, 827 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index 704fb0f41dc3..cd89e238b93e 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -1,6 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config DRM_ANALOGIX_ANX6345
> +	tristate "Analogix ANX6345 bridge"
> +	select DRM_ANALOGIX_DP
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	help
> +	  ANX6345 is an ultra-low Full-HD DisplayPort/eDP
> +	  transmitter designed for portable devices. The
> +	  ANX6345 transforms the LVTTL RGB output of an
> +	  application processor to eDP or DisplayPort.
> +
>  config DRM_ANALOGIX_ANX78XX
>  	tristate "Analogix ANX78XX bridge"
> +	select DRM_ANALOGIX_DP
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
>  	help
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index 7623b9b80167..97669b374098 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o analogix-i2c-dptx.o
> +obj-$(CONFIG_DRM_ANALOGIX_ANX6345) += analogix-anx6345.o
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> new file mode 100644
> index 000000000000..ae222f9f6586
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -0,0 +1,814 @@
> +/*
> + * Copyright(c) 2016, Analogix Semiconductor.
> + * Copyright(c) 2017, Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.


SPDX


> + *
> + * Based on anx7808 driver obtained from chromeos with copyright:
> + * Copyright(c) 2013, Google Inc.
> + *
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_dp_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "analogix-i2c-dptx.h"
> +#include "analogix-i2c-txcommon.h"
> +
> +#define I2C_NUM_ADDRESSES	2


You can define it as ARRAY_SIZE(anx6345_i2c_addresses) - more generic.


> +#define I2C_IDX_DPTX		0
> +#define I2C_IDX_TXCOM		1
> +
> +#define POLL_DELAY		50000 /* us */
> +#define POLL_TIMEOUT		5000000 /* us */
> +
> +static const u8 anx6345_i2c_addresses[] = {
> +	[I2C_IDX_DPTX]	= ANALOGIX_I2C_DPTX,
> +	[I2C_IDX_TXCOM]	= ANALOGIX_I2C_TXCOMMON,
> +};
> +
> +struct anx6345 {
> +	struct drm_dp_aux aux;
> +	struct drm_bridge bridge;
> +	struct i2c_client *client;
> +	struct edid *edid;
> +	struct drm_connector connector;
> +	struct drm_dp_link link;
> +	struct drm_panel *panel;
> +	struct regulator *dvdd12;
> +	struct regulator *dvdd25;
> +	struct gpio_desc *gpiod_reset;
> +	struct mutex lock;	/* protect EDID access */
> +
> +	/* I2C Slave addresses of ANX6345 are mapped as DPTX and SYS */
> +	struct i2c_client *i2c_clients[I2C_NUM_ADDRESSES];
> +	struct regmap *map[I2C_NUM_ADDRESSES];
> +
> +	u16 chipid;
> +	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +
> +	bool powered;
> +};
> +
> +static inline struct anx6345 *connector_to_anx6345(struct drm_connector *c)
> +{
> +	return container_of(c, struct anx6345, connector);
> +}
> +
> +static inline struct anx6345 *bridge_to_anx6345(struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct anx6345, bridge);
> +}
> +
> +static int anx6345_set_bits(struct regmap *map, u8 reg, u8 mask)
> +{
> +	return regmap_update_bits(map, reg, mask, mask);
> +}
> +
> +static int anx6345_clear_bits(struct regmap *map, u8 reg, u8 mask)
> +{
> +	return regmap_update_bits(map, reg, mask, 0);
> +}
> +
> +static ssize_t anx6345_aux_transfer(struct drm_dp_aux *aux,
> +				    struct drm_dp_aux_msg *msg)
> +{
> +	struct anx6345 *anx6345 = container_of(aux, struct anx6345, aux);
> +
> +	return anx_dp_aux_transfer(anx6345->map[I2C_IDX_DPTX], msg);
> +}
> +
> +static int anx6345_dp_link_training(struct anx6345 *anx6345)
> +{
> +	unsigned int value;
> +	u8 dp_bw;
> +	int err;
> +
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> +				 SP_POWERDOWN_CTRL_REG,
> +				 SP_TOTAL_PD);
> +	if (err)
> +		return err;
> +
> +	err = drm_dp_dpcd_readb(&anx6345->aux, DP_MAX_LINK_RATE, &dp_bw);
> +	if (err < 0)
> +		return err;
> +
> +	switch (dp_bw) {
> +	case DP_LINK_BW_1_62:
> +	case DP_LINK_BW_2_7:
> +		break;
> +
> +	default:
> +		DRM_DEBUG_KMS("DP bandwidth (%#02x) not supported\n", dp_bw);
> +		return -EINVAL;
> +	}
> +
> +	err = anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM], SP_VID_CTRL1_REG,
> +			       SP_VIDEO_MUTE);
> +	if (err)
> +		return err;
> +
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> +				 SP_VID_CTRL1_REG, SP_VIDEO_EN);
> +	if (err)
> +		return err;
> +
> +	/* Get DPCD info */
> +	err = drm_dp_dpcd_read(&anx6345->aux, DP_DPCD_REV,
> +			       &anx6345->dpcd, DP_RECEIVER_CAP_SIZE);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to read DPCD: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Clear channel x SERDES power down */
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_DPTX],
> +				 SP_DP_ANALOG_POWER_DOWN_REG, SP_CH0_PD);
> +	if (err)
> +		return err;
> +
> +	/* Check link capabilities */
> +	err = drm_dp_link_probe(&anx6345->aux, &anx6345->link);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to probe link capabilities: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Power up the sink */
> +	err = drm_dp_link_power_up(&anx6345->aux, &anx6345->link);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to power up DisplayPort link: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Possibly enable downspread on the sink */
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +			   SP_DP_DOWNSPREAD_CTRL1_REG, 0);
> +	if (err)
> +		return err;
> +
> +	if (anx6345->dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5) {
> +		DRM_DEBUG("Enable downspread on the sink\n");
> +		/* 4000PPM */
> +		err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +				   SP_DP_DOWNSPREAD_CTRL1_REG, 8);
> +		if (err)
> +			return err;
> +
> +		err = drm_dp_dpcd_writeb(&anx6345->aux, DP_DOWNSPREAD_CTRL,
> +					 DP_SPREAD_AMP_0_5);
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = drm_dp_dpcd_writeb(&anx6345->aux, DP_DOWNSPREAD_CTRL, 0);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	/* Set the lane count and the link rate on the sink */
> +	if (drm_dp_enhanced_frame_cap(anx6345->dpcd))
> +		err = anx6345_set_bits(anx6345->map[I2C_IDX_DPTX],
> +				       SP_DP_SYSTEM_CTRL_BASE + 4,
> +				       SP_ENHANCED_MODE);
> +	else
> +		err = anx6345_clear_bits(anx6345->map[I2C_IDX_DPTX],
> +					 SP_DP_SYSTEM_CTRL_BASE + 4,
> +					 SP_ENHANCED_MODE);
> +	if (err)
> +		return err;
> +
> +	value = drm_dp_link_rate_to_bw_code(anx6345->link.rate);
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +			   SP_DP_MAIN_LINK_BW_SET_REG, value);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +			   SP_DP_LANE_COUNT_SET_REG, anx6345->link.num_lanes);
> +	if (err)
> +		return err;
> +
> +	err = drm_dp_link_configure(&anx6345->aux, &anx6345->link);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to configure DisplayPort link: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Start training on the source */
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX], SP_DP_LT_CTRL_REG,
> +			   SP_LT_EN);
> +	if (err)
> +		return err;
> +
> +	err = regmap_read_poll_timeout(anx6345->map[I2C_IDX_DPTX],
> +				       SP_DP_LT_CTRL_REG,
> +				       value, !(value & SP_DP_LT_INPROGRESS),
> +				       POLL_DELAY, POLL_TIMEOUT);
> +	if (err)
> +		return err;
> +
> +	return 0;


You can use:

    return regmap_read_poll_timeout(....);



> +}
> +
> +static int anx6345_tx_initialization(struct anx6345 *anx6345)
> +{
> +	int err, i;
> +
> +	/* FIXME: colordepth is hardcoded for now */
> +	err = regmap_write(anx6345->map[I2C_IDX_TXCOM], SP_VID_CTRL2_REG,
> +			   SP_IN_BPC_6BIT << SP_IN_BPC_SHIFT);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX], SP_DP_PLL_CTRL_REG, 0);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(anx6345->map[I2C_IDX_TXCOM],
> +			   SP_ANALOG_DEBUG1_REG, 0);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +			   SP_DP_LINK_DEBUG_CTRL_REG,
> +			   SP_NEW_PRBS7 | SP_M_VID_DEBUG);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +			   SP_DP_ANALOG_POWER_DOWN_REG, 0);
> +	if (err)
> +		return err;
> +
> +	/* Force HPD */
> +	err = anx6345_set_bits(anx6345->map[I2C_IDX_DPTX],
> +			       SP_DP_SYSTEM_CTRL_BASE + 3,
> +			       SP_HPD_FORCE | SP_HPD_CTRL);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < 4; i++) {
> +		/* 4 lanes */
> +		err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> +				   SP_DP_LANE0_LT_CTRL_REG + i, 0);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Reset AUX */
> +	err = anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM],
> +			       SP_RESET_CTRL2_REG, SP_AUX_RST);
> +	if (err)
> +		return err;
> +
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> +				 SP_RESET_CTRL2_REG, SP_AUX_RST);
> +	if (err)
> +		return err;
> +
> +	return 0;


ditto


> +}
> +
> +static void anx6345_poweron(struct anx6345 *anx6345)
> +{
> +	int err;
> +
> +	/* Ensure reset is asserted before starting power on sequence */
> +	gpiod_set_value_cansleep(anx6345->gpiod_reset, 1);


With fixed devm_gpiod_get below this line can be removed.


> +	usleep_range(1000, 2000);
> +
> +	err = regulator_enable(anx6345->dvdd12);
> +	if (err) {
> +		DRM_ERROR("Failed to enable dvdd12 regulator: %d\n",
> +			  err);
> +		return;
> +	}
> +
> +	/* T1 - delay between VDD12 and VDD25 should be 0-2ms */
> +	usleep_range(1000, 2000);
> +
> +	err = regulator_enable(anx6345->dvdd25);
> +	if (err) {
> +		DRM_ERROR("Failed to enable dvdd25 regulator: %d\n",
> +			  err);
> +		return;
> +	}
> +
> +	/* T2 - delay between RESETN and all power rail stable,
> +	 * should be 2-5ms
> +	 */
> +	usleep_range(2000, 5000);
> +
> +	gpiod_set_value_cansleep(anx6345->gpiod_reset, 0);
> +
> +	/* Power on registers module */
> +	anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM], SP_POWERDOWN_CTRL_REG,
> +			 SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
> +	anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM], SP_POWERDOWN_CTRL_REG,
> +			   SP_REGISTER_PD | SP_TOTAL_PD);
> +
> +	if (anx6345->panel)
> +		drm_panel_prepare(anx6345->panel);
> +
> +	anx6345->powered = true;
> +}
> +
> +static void anx6345_poweroff(struct anx6345 *anx6345)
> +{
> +	int err;
> +
> +	gpiod_set_value_cansleep(anx6345->gpiod_reset, 1);
> +	usleep_range(1000, 2000);
> +
> +	if (anx6345->panel)
> +		drm_panel_unprepare(anx6345->panel);
> +
> +	err = regulator_disable(anx6345->dvdd25);
> +	if (err) {
> +		DRM_ERROR("Failed to disable dvdd25 regulator: %d\n",
> +			  err);
> +		return;
> +	}
> +
> +	usleep_range(5000, 10000);
> +
> +	err = regulator_disable(anx6345->dvdd12);
> +	if (err) {
> +		DRM_ERROR("Failed to disable dvdd12 regulator: %d\n",
> +			  err);
> +		return;
> +	}
> +
> +	usleep_range(1000, 2000);
> +
> +	anx6345->powered = false;
> +}
> +
> +static int anx6345_start(struct anx6345 *anx6345)
> +{
> +	int err;
> +
> +	if (!anx6345->powered)
> +		anx6345_poweron(anx6345);
> +
> +	/* Power on needed modules */
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> +				SP_POWERDOWN_CTRL_REG,
> +				SP_VIDEO_PD | SP_LINK_PD);
> +
> +	err = anx6345_tx_initialization(anx6345);
> +	if (err) {
> +		DRM_ERROR("Failed eDP transmitter initialization: %d\n", err);
> +		anx6345_poweroff(anx6345);
> +		return err;
> +	}
> +
> +	err = anx6345_dp_link_training(anx6345);
> +	if (err) {
> +		DRM_ERROR("Failed link training: %d\n", err);
> +		anx6345_poweroff(anx6345);
> +		return err;
> +	}
> +
> +	/*
> +	 * This delay seems to help keep the hardware in a good state. Without
> +	 * it, there are times where it fails silently.
> +	 */
> +	usleep_range(10000, 15000);
> +
> +	return 0;
> +}
> +
> +static int anx6345_config_dp_output(struct anx6345 *anx6345)
> +{
> +	int err;
> +
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM], SP_VID_CTRL1_REG,
> +				 SP_VIDEO_MUTE);
> +	if (err)
> +		return err;
> +
> +	/* Enable DP output */
> +	err = anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM], SP_VID_CTRL1_REG,
> +			       SP_VIDEO_EN);
> +	if (err)
> +		return err;
> +
> +	/* Force stream valid */
> +	err = anx6345_set_bits(anx6345->map[I2C_IDX_DPTX],
> +			       SP_DP_SYSTEM_CTRL_BASE + 3,
> +			       SP_STRM_FORCE | SP_STRM_CTRL);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int anx6345_get_downstream_info(struct anx6345 *anx6345)
> +{
> +	u8 value;
> +	int err;
> +
> +	err = drm_dp_dpcd_readb(&anx6345->aux, DP_SINK_COUNT, &value);
> +	if (err < 0) {
> +		DRM_ERROR("Get sink count failed %d\n", err);
> +		return err;
> +	}
> +
> +	if (!DP_GET_SINK_COUNT(value)) {
> +		DRM_ERROR("Downstream disconnected\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx6345_get_modes(struct drm_connector *connector)
> +{
> +	struct anx6345 *anx6345 = connector_to_anx6345(connector);
> +	int err, num_modes = 0;
> +	bool power_off = false;
> +
> +	mutex_lock(&anx6345->lock);
> +
> +	if (!anx6345->edid) {
> +		if (!anx6345->powered) {
> +			anx6345_poweron(anx6345);
> +			power_off = true;
> +		}
> +
> +		err = anx6345_get_downstream_info(anx6345);
> +		if (err) {
> +			DRM_ERROR("Failed to get downstream info: %d\n", err);
> +			goto unlock;
> +		}
> +
> +		anx6345->edid = drm_get_edid(connector, &anx6345->aux.ddc);
> +		if (!anx6345->edid)
> +			DRM_ERROR("Failed to read EDID from panel\n");
> +
> +		err = drm_connector_update_edid_property(connector,
> +							 anx6345->edid);
> +		if (err) {
> +			DRM_ERROR("Failed to update EDID property: %d\n", err);
> +			goto unlock;
> +		}
> +	}
> +
> +	num_modes += drm_add_edid_modes(connector, anx6345->edid);
> +
> +unlock:
> +	if (power_off)
> +		anx6345_poweroff(anx6345);
> +
> +	mutex_unlock(&anx6345->lock);
> +
> +	if (!num_modes && anx6345->panel)
> +		num_modes += drm_panel_get_modes(anx6345->panel);
> +
> +	return num_modes;
> +}
> +
> +static const struct drm_connector_helper_funcs anx6345_connector_helper_funcs = {
> +	.get_modes = anx6345_get_modes,
> +};
> +
> +static void
> +anx6345_connector_destroy(struct drm_connector *connector)
> +{
> +	struct anx6345 *anx6345 = connector_to_anx6345(connector);
> +
> +	if (anx6345->panel)
> +		drm_panel_detach(anx6345->panel);
> +	drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs anx6345_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = anx6345_connector_destroy,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int anx6345_bridge_attach(struct drm_bridge *bridge)
> +{
> +	struct anx6345 *anx6345 = bridge_to_anx6345(bridge);
> +	int err;
> +
> +	if (!bridge->encoder) {
> +		DRM_ERROR("Parent encoder object not found");
> +		return -ENODEV;
> +	}
> +
> +	/* Register aux channel */
> +	anx6345->aux.name = "DP-AUX";
> +	anx6345->aux.dev = &anx6345->client->dev;
> +	anx6345->aux.transfer = anx6345_aux_transfer;
> +
> +	err = drm_dp_aux_register(&anx6345->aux);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to register aux channel: %d\n", err);
> +		return err;
> +	}
> +
> +	err = drm_connector_init(bridge->dev, &anx6345->connector,
> +				 &anx6345_connector_funcs,
> +				 DRM_MODE_CONNECTOR_eDP);
> +	if (err) {
> +		DRM_ERROR("Failed to initialize connector: %d\n", err);
> +		return err;
> +	}
> +
> +	drm_connector_helper_add(&anx6345->connector,
> +				 &anx6345_connector_helper_funcs);
> +
> +	err = drm_connector_register(&anx6345->connector);
> +	if (err) {
> +		DRM_ERROR("Failed to register connector: %d\n", err);
> +		return err;
> +	}
> +
> +	anx6345->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +	err = drm_connector_attach_encoder(&anx6345->connector,
> +					   bridge->encoder);
> +	if (err) {
> +		DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> +		return err;
> +	}
> +
> +	if (anx6345->panel) {
> +		err = drm_panel_attach(anx6345->panel, &anx6345->connector);
> +		if (err) {
> +			DRM_ERROR("Failed to attach panel: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static enum drm_mode_status
> +anx6345_bridge_mode_valid(struct drm_bridge *bridge,
> +			  const struct drm_display_mode *mode)
> +{
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		return MODE_NO_INTERLACE;
> +
> +	/* Max 1200p at 5.4 Ghz, one lane */
> +	if (mode->clock > 154000)
> +		return MODE_CLOCK_HIGH;


I wonder if you shouldn't take into account training results here, ie.
training perfrormed before validation.


> +
> +	return MODE_OK;
> +}
> +
> +static void anx6345_bridge_disable(struct drm_bridge *bridge)
> +{
> +	struct anx6345 *anx6345 = bridge_to_anx6345(bridge);
> +
> +	/* Power off all modules except configuration registers access */
> +	anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM], SP_POWERDOWN_CTRL_REG,
> +			 SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
> +	if (anx6345->panel)
> +		drm_panel_disable(anx6345->panel);
> +
> +	if (anx6345->powered)
> +		anx6345_poweroff(anx6345);
> +}
> +
> +static void anx6345_bridge_enable(struct drm_bridge *bridge)
> +{
> +	struct anx6345 *anx6345 = bridge_to_anx6345(bridge);
> +	int err;
> +
> +	if (anx6345->panel)
> +		drm_panel_enable(anx6345->panel);
> +
> +	err = anx6345_start(anx6345);
> +	if (err) {
> +		DRM_ERROR("Failed to initialize: %d\n", err);
> +		return;
> +	}
> +
> +	err = anx6345_config_dp_output(anx6345);
> +	if (err)
> +		DRM_ERROR("Failed to enable DP output: %d\n", err);
> +}
> +
> +static const struct drm_bridge_funcs anx6345_bridge_funcs = {
> +	.attach = anx6345_bridge_attach,
> +	.mode_valid = anx6345_bridge_mode_valid,
> +	.disable = anx6345_bridge_disable,
> +	.enable = anx6345_bridge_enable,
> +};
> +
> +static void unregister_i2c_dummy_clients(struct anx6345 *anx6345)
> +{
> +	unsigned int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(anx6345->i2c_clients); i++)
> +		if (anx6345->i2c_clients[i] &&
> +		    anx6345->i2c_clients[i]->addr != anx6345->client->addr)
> +			i2c_unregister_device(anx6345->i2c_clients[i]);
> +}
> +
> +static const struct regmap_config anx6345_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0xff,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const u16 anx6345_chipid_list[] = {
> +	0x6345,
> +};
> +
> +static bool anx6345_get_chip_id(struct anx6345 *anx6345)
> +{
> +	unsigned int i, idl, idh, version;
> +
> +	if (regmap_read(anx6345->map[I2C_IDX_TXCOM], SP_DEVICE_IDL_REG, &idl))
> +		return false;
> +
> +	if (regmap_read(anx6345->map[I2C_IDX_TXCOM], SP_DEVICE_IDH_REG, &idh))
> +		return false;
> +
> +	anx6345->chipid = (u8)idl | ((u8)idh << 8);
> +
> +	if (regmap_read(anx6345->map[I2C_IDX_TXCOM], SP_DEVICE_VERSION_REG,
> +			&version))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(anx6345_chipid_list); i++) {
> +		if (anx6345->chipid == anx6345_chipid_list[i]) {
> +			DRM_INFO("Found ANX%x (ver. %d) eDP Transmitter\n",
> +				 anx6345->chipid, version);
> +			return true;
> +		}
> +	}
> +
> +	DRM_ERROR("ANX%x (ver. %d) not supported by this driver\n",
> +		  anx6345->chipid, version);
> +
> +	return false;
> +}
> +
> +static int anx6345_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct anx6345 *anx6345;
> +	struct device *dev;
> +	int i, err;
> +
> +	anx6345 = devm_kzalloc(&client->dev, sizeof(*anx6345), GFP_KERNEL);
> +	if (!anx6345)
> +		return -ENOMEM;
> +
> +	mutex_init(&anx6345->lock);
> +
> +	anx6345->bridge.of_node = client->dev.of_node;
> +
> +	anx6345->client = client;
> +	i2c_set_clientdata(client, anx6345);
> +
> +	dev = &anx6345->client->dev;
> +
> +	err = drm_of_find_panel_or_bridge(client->dev.of_node, 1, 0,
> +					  &anx6345->panel, NULL);
> +	if (err == -EPROBE_DEFER)
> +		return err;
> +
> +	if (err)
> +		DRM_DEBUG("No panel found\n");
> +
> +	/* 1.2V digital core power regulator  */
> +	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
> +	if (IS_ERR(anx6345->dvdd12)) {
> +		DRM_ERROR("dvdd12-supply not found\n");
> +		return PTR_ERR(anx6345->dvdd12);
> +	}
> +
> +	/* 2.5V digital core power regulator  */
> +	anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
> +	if (IS_ERR(anx6345->dvdd25)) {
> +		DRM_ERROR("dvdd25-supply not found\n");
> +		return PTR_ERR(anx6345->dvdd25);
> +	}
> +
> +	/* GPIO for chip reset */
> +	anx6345->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);


Shouldn't be set to GPIOD_OUT_HIGH?


> +	if (IS_ERR(anx6345->gpiod_reset)) {
> +		DRM_ERROR("Reset gpio not found\n");
> +		return PTR_ERR(anx6345->gpiod_reset);
> +	}
> +
> +	/* Map slave addresses of ANX6345 */
> +	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
> +		if (anx6345_i2c_addresses[i] >> 1 != client->addr)
> +			anx6345->i2c_clients[i] = i2c_new_dummy(client->adapter,
> +						anx6345_i2c_addresses[i] >> 1);
> +		else
> +			anx6345->i2c_clients[i] = client;
> +
> +		if (!anx6345->i2c_clients[i]) {
> +			err = -ENOMEM;
> +			DRM_ERROR("Failed to reserve I2C bus %02x\n",
> +				  anx6345_i2c_addresses[i]);
> +			goto err_unregister_i2c;
> +		}
> +
> +		anx6345->map[i] = devm_regmap_init_i2c(anx6345->i2c_clients[i],
> +						       &anx6345_regmap_config);
> +		if (IS_ERR(anx6345->map[i])) {
> +			err = PTR_ERR(anx6345->map[i]);
> +			DRM_ERROR("Failed regmap initialization %02x\n",
> +				  anx6345_i2c_addresses[i]);
> +			goto err_unregister_i2c;
> +		}
> +	}
> +
> +	/* Look for supported chip ID */
> +	anx6345_poweron(anx6345);
> +	if (anx6345_get_chip_id(anx6345)) {
> +		anx6345->bridge.funcs = &anx6345_bridge_funcs;
> +		drm_bridge_add(&anx6345->bridge);
> +
> +		return 0;
> +	} else {
> +		anx6345_poweroff(anx6345);
> +		err = -ENODEV;
> +	}
> +
> +err_unregister_i2c:
> +	unregister_i2c_dummy_clients(anx6345);
> +	return err;
> +}
> +
> +static int anx6345_i2c_remove(struct i2c_client *client)
> +{
> +	struct anx6345 *anx6345 = i2c_get_clientdata(client);
> +
> +	drm_bridge_remove(&anx6345->bridge);
> +
> +	unregister_i2c_dummy_clients(anx6345);
> +
> +	kfree(anx6345->edid);
> +
> +	mutex_destroy(&anx6345->lock);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id anx6345_id[] = {
> +	{ "anx6345", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, anx6345_id);
> +
> +static const struct of_device_id anx6345_match_table[] = {
> +	{ .compatible = "analogix,anx6345", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, anx6345_match_table);
> +
> +static struct i2c_driver anx6345_driver = {
> +	.driver = {
> +		   .name = "anx6345",
> +		   .of_match_table = of_match_ptr(anx6345_match_table),
> +		  },
> +	.probe = anx6345_i2c_probe,
> +	.remove = anx6345_i2c_remove,
> +	.id_table = anx6345_id,
> +};
> +module_i2c_driver(anx6345_driver);
> +
> +MODULE_DESCRIPTION("ANX6345 eDP Transmitter driver");
> +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");


Submitter, patch author, and module author are different, this can be
correct, but maybe somebody forgot to update some of these fields.


Regards

Andrzej


> +MODULE_LICENSE("GPL v2");


