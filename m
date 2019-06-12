Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98952080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jSOsDE7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406706AbfFLHmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:42:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50702 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405892AbfFLHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:42:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612074201euoutp02a8de89021c2a5e387ed4a03649f06a7e~nY50BA9hv1631416314euoutp02i
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:42:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612074201euoutp02a8de89021c2a5e387ed4a03649f06a7e~nY50BA9hv1631416314euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560325321;
        bh=hA0QkjZ86uXdvD6NbT4dMilyev4ASJg1HbqpuiViPBs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jSOsDE7bXByBWKvtXOK7fPP9/2i1pr8QsQUpQRIuc73P9WS7kUI4xGZ0Rh4uMSHUM
         l+t8E6/KWH8ypaBtkiZOyieml4laHZLHj8fDjsxqqi6DuK3pqprRpx9lV1JneWhXVX
         RlBamZjsBt13kENv0f0V0AQDfiZUffpLKczlcaxk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190612074200eucas1p260bddfc57f33444ad9334d414c5b8cec~nY5yoeggZ2002920029eucas1p2L;
        Wed, 12 Jun 2019 07:42:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F8.BD.04377.8CCA00D5; Wed, 12
        Jun 2019 08:42:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612074159eucas1p1e1cf15d878f332c6924b15d09b6a8a2c~nY5x3qgBe3065330653eucas1p1K;
        Wed, 12 Jun 2019 07:41:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190612074159eusmtrp260103c48db8e32de1be26a3819cb7e53~nY5xokwQZ0905709057eusmtrp2E;
        Wed, 12 Jun 2019 07:41:59 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-16-5d00acc8135b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.CD.04146.7CCA00D5; Wed, 12
        Jun 2019 08:41:59 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190612074158eusmtip15e4ff3ddaa878a1dff3a194a335dd967~nY5wzCII40135301353eusmtip1i;
        Wed, 12 Jun 2019 07:41:58 +0000 (GMT)
Subject: Re: [PATCH v2 3/7] drm/bridge: extract some Analogix I2C DP common
 code
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
Message-ID: <39f52c37-b266-ea0c-f277-e7821d6ca033@samsung.com>
Date:   Wed, 12 Jun 2019 09:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604122256.4E81268B05@newverein.lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O7cdpclxGr6sIBpEGGQX+vFF0Y1+HCLM/JOUUctOJuqKnbSb
        4aAMrbyVpR3zlkphS9ems81KUUst5pLyklhKqXQvchqz0radJP8933N5n/eFjyVVxYyajdcd
        E/Q6baKGCaCsT9zO5R1Gv70r7xSxOKurk8DpT8YQnrHmkbi0rYvGLye+MXjy5VMCn62oZXCd
        3UHj8fI3BM7Mq1Rg87teGr+w32BwVV83gYc/NCGc/rBNgV+bHAhbzFdJ7LaXUNjd4iQ2BfMV
        7mmCN5YYEV9iPM2Ptn5S8EWGboo3vb1D8w8nyyjeJr32cBnXad5cncnwX7u6FHzD5DDNNxUb
        FfzQxXaCt1Sm8Y2vDExk0O6A9QeFxPgUQb9iw/6Aw/UDmqMNMSeyp/IpA+rhLyB/Frg1YH9U
        TXmxiruNwPQ87QIK8GAXgt73Ei0/xhF8d/ZTswlXs4Rk4RaCNw4TKT++IBirucJ4XcFcFNSW
        PWC8QgjXSkF+zlPfLJJLR1BmGffNYrgw+GN55UsouQ1wcaSG9mKKWwIOV6ePn89Fg8tmRrIn
        CDqvj/iy/txauDQ46POT3CI4W19EyjgUBkZKCW8ZcP0s3HVaFPLiW6H0hxXJOBg+ttf94xfC
        jM0b8OI0GLp9jpTDGQjqTTZSFtZBa3u3p431NIRBrX2FTG+GqcFGhZcGLhD6vwTJOwTCZWsB
        KdNKyDivkt2LYchR/29gKFQ9n2BykUaac5k05xppzjXS/94yRFWjUCFZTIoTxNU64Xi4qE0S
        k3Vx4bFHkszI82mfTbe77iP77wMtiGORZp6yuWAmRkVrU8STSS0IWFITolyd4LdXpTyoPXlK
        0B/Zp09OFMQWtIClNKHK037De1RcnPaYkCAIRwX9rEqw/moDqknOtnY8nni7pS4y6+e9zF29
        o1rnpebC+w+eVb5/Zz+eWk2HzbTN3/67YDR3eciVHHy5L6L82rKp2pGNEb/SAs9IMYX6W1Hx
        sHPl1RtE+I6mPnNH3cC2pbHjh6K7nesJETfe7ZCKf0Qb1e6F6jbr55sf1LZV0z1iQ2pCbIUt
        XmfQUOJh7aplpF7U/gWBtas4sAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0iTYRjHfb/TprX6nJpvdlEsIuww29R8jbLAmxeCNO0iUqmhXy50TvbN
        ygocqWDTDtLJttoUlcCWh60yp2ItaVhpaVppnihNyg6UZike0s3Au9/z/P+/iwceISmuoQOE
        x9K0nCZNkSphvKjns86+rU6LR8K2TzkidL6thUC5Tz8BNPegkETm5jYadf7+waCJzmcEyi6t
        YtA9eyuNxkr6CXSusEyArB/f0Oi1/SaDyt+2E2jwcxNAuY3NAtRX3QqQzXqVRJN2E4UmHS+J
        PT64dHKWwBaTBWCT5TQefjIqwEZdO4WrP9yhceNEMYXrDH3zu7wbNLZWnGPw97Y2Aa6dGKRx
        0y2LAA/kOwlsK8vC9d06Jtr7kHSnRp2h5dYp1bx2lyROhuRSWTiSykPCpbLgsIQd8lBJUMTO
        JC712HFOExRxRKq83yNJr40/eWHqCqUDXVgPPIWQDYHjjwxAD7yEYrYcwB57DukO/GG9+dsi
        +8DpN3rGXRoF0NlVQCwEPmwMrCpucAW+rJOC+h9FxMJAsrkAThd8FriVegB/ftO5FIYNhDO2
        bmaBRWwEzB+qpBeYYjfA1vEW196PPQiNdh3l7njDlhtDLvZkw2FBb6+rT7Ib4bSpg3TzWph9
        37jI/rBnyExcAmLDEt2wRDEsUQxLlGJAVQBfLoNXJat4mZRXqPiMtGRpolplBfPv8uDppO0h
        6KiJdQBWCCTLRY+uz8WLacVxPlPlAFBISnxF8hSPBLEoSZF5itOoD2syUjneAULnjyskA/wS
        1fPPl6Y9LAuVhaFwWVhwWPB2JPEX5bGP48VsskLLpXBcOqf57xFCzwAdiBrx+np55oS2qMo0
        ujo79toRwhHZMFUYaN10NzfycnQkXTcwvKYp/fa+qJ79v+L7Z6MVfzpZD/lue9xZo7Ji9u+L
        9+uP+pm6MkvPX9wyVq2U9vvVP3xd/iqkOWvmtFivMtfsqVyxbGRtycizL/mxZ/ZWROFVrQeM
        RarN75wxK4djayUUr1TINpEaXvEPGgRC5UQDAAA=
X-CMS-MailID: 20190612074159eucas1p1e1cf15d878f332c6924b15d09b6a8a2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190604122325epcas2p491fdd72faef66feee2b413bdafe05cca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190604122325epcas2p491fdd72faef66feee2b413bdafe05cca
References: <20190604122150.29D6468B05@newverein.lst.de>
        <CGME20190604122325epcas2p491fdd72faef66feee2b413bdafe05cca@epcas2p4.samsung.com>
        <20190604122256.4E81268B05@newverein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2019 14:22, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Some code can be shared within different DP bridges by Analogix.
> Extract them to analogix_dp.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  drivers/gpu/drm/bridge/analogix/Makefile           |   2 +-
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 146 +----------------
>  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.c    | 173 +++++++++++++++++++++
>  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.h    |   3 +
>  4 files changed, 178 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
>
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index 6fcbfd3ee560..7623b9b80167 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
> +analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o analogix-i2c-dptx.o
>  obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index c09aaf93ae1b..f36ae51c641d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -45,8 +45,6 @@
>  #define I2C_IDX_RX_P1		4
>  
>  #define XTAL_CLK		270 /* 27M */
> -#define AUX_CH_BUFFER_SIZE	16
> -#define AUX_WAIT_TIMEOUT_MS	15
>  
>  static const u8 anx78xx_i2c_addresses[] = {
>  	[I2C_IDX_TX_P0] = TX_P0,
> @@ -109,153 +107,11 @@ static int anx78xx_clear_bits(struct regmap *map, u8 reg, u8 mask)
>  	return regmap_update_bits(map, reg, mask, 0);
>  }
>  
> -static bool anx78xx_aux_op_finished(struct anx78xx *anx78xx)
> -{
> -	unsigned int value;
> -	int err;
> -
> -	err = regmap_read(anx78xx->map[I2C_IDX_TX_P0], SP_DP_AUX_CH_CTRL2_REG,
> -			  &value);
> -	if (err < 0)
> -		return false;
> -
> -	return (value & SP_AUX_EN) == 0;
> -}
> -
> -static int anx78xx_aux_wait(struct anx78xx *anx78xx)
> -{
> -	unsigned long timeout;
> -	unsigned int status;
> -	int err;
> -
> -	timeout = jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
> -
> -	while (!anx78xx_aux_op_finished(anx78xx)) {
> -		if (time_after(jiffies, timeout)) {
> -			if (!anx78xx_aux_op_finished(anx78xx)) {
> -				DRM_ERROR("Timed out waiting AUX to finish\n");
> -				return -ETIMEDOUT;
> -			}
> -
> -			break;
> -		}
> -
> -		usleep_range(1000, 2000);
> -	}
> -
> -	/* Read the AUX channel access status */
> -	err = regmap_read(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_CH_STATUS_REG,
> -			  &status);
> -	if (err < 0) {
> -		DRM_ERROR("Failed to read from AUX channel: %d\n", err);
> -		return err;
> -	}
> -
> -	if (status & SP_AUX_STATUS) {
> -		DRM_ERROR("Failed to wait for AUX channel (status: %02x)\n",
> -			  status);
> -		return -ETIMEDOUT;
> -	}
> -
> -	return 0;
> -}
> -
> -static int anx78xx_aux_address(struct anx78xx *anx78xx, unsigned int addr)
> -{
> -	int err;
> -
> -	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_ADDR_7_0_REG,
> -			   addr & 0xff);
> -	if (err)
> -		return err;
> -
> -	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_AUX_ADDR_15_8_REG,
> -			   (addr & 0xff00) >> 8);
> -	if (err)
> -		return err;
> -
> -	/*
> -	 * DP AUX CH Address Register #2, only update bits[3:0]
> -	 * [7:4] RESERVED
> -	 * [3:0] AUX_ADDR[19:16], Register control AUX CH address.
> -	 */
> -	err = regmap_update_bits(anx78xx->map[I2C_IDX_TX_P0],
> -				 SP_AUX_ADDR_19_16_REG,
> -				 SP_AUX_ADDR_19_16_MASK,
> -				 (addr & 0xf0000) >> 16);
> -
> -	if (err)
> -		return err;
> -
> -	return 0;
> -}
> -
>  static ssize_t anx78xx_aux_transfer(struct drm_dp_aux *aux,
>  				    struct drm_dp_aux_msg *msg)
>  {
>  	struct anx78xx *anx78xx = container_of(aux, struct anx78xx, aux);
> -	u8 ctrl1 = msg->request;
> -	u8 ctrl2 = SP_AUX_EN;
> -	u8 *buffer = msg->buffer;
> -	int err;
> -
> -	/* The DP AUX transmit and receive buffer has 16 bytes. */
> -	if (WARN_ON(msg->size > AUX_CH_BUFFER_SIZE))
> -		return -E2BIG;
> -
> -	/* Zero-sized messages specify address-only transactions. */
> -	if (msg->size < 1)
> -		ctrl2 |= SP_ADDR_ONLY;
> -	else	/* For non-zero-sized set the length field. */
> -		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
> -
> -	if ((msg->request & DP_AUX_I2C_READ) == 0) {
> -		/* When WRITE | MOT write values to data buffer */
> -		err = regmap_bulk_write(anx78xx->map[I2C_IDX_TX_P0],
> -					SP_DP_BUF_DATA0_REG, buffer,
> -					msg->size);
> -		if (err)
> -			return err;
> -	}
> -
> -	/* Write address and request */
> -	err = anx78xx_aux_address(anx78xx, msg->address);
> -	if (err)
> -		return err;
> -
> -	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0], SP_DP_AUX_CH_CTRL1_REG,
> -			   ctrl1);
> -	if (err)
> -		return err;
> -
> -	/* Start transaction */
> -	err = regmap_update_bits(anx78xx->map[I2C_IDX_TX_P0],
> -				 SP_DP_AUX_CH_CTRL2_REG, SP_ADDR_ONLY |
> -				 SP_AUX_EN, ctrl2);
> -	if (err)
> -		return err;
> -
> -	err = anx78xx_aux_wait(anx78xx);
> -	if (err)
> -		return err;
> -
> -	msg->reply = DP_AUX_I2C_REPLY_ACK;
> -
> -	if ((msg->size > 0) && (msg->request & DP_AUX_I2C_READ)) {
> -		/* Read values from data buffer */
> -		err = regmap_bulk_read(anx78xx->map[I2C_IDX_TX_P0],
> -				       SP_DP_BUF_DATA0_REG, buffer,
> -				       msg->size);
> -		if (err)
> -			return err;
> -	}
> -
> -	err = anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P0],
> -				 SP_DP_AUX_CH_CTRL2_REG, SP_ADDR_ONLY);
> -	if (err)
> -		return err;
> -
> -	return msg->size;
> +	return anx_dp_aux_transfer(anx78xx->map[I2C_IDX_TX_P0], msg);
>  }
>  
>  static int anx78xx_set_hpd(struct anx78xx *anx78xx)
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> new file mode 100644
> index 000000000000..d6016f789d80
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> @@ -0,0 +1,174 @@
> +/*
> + * Copyright(c) 2016, Analogix Semiconductor.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.


Again spdx.


With that fixed:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> + *
> + * Based on anx7808 driver obtained from chromeos with copyright:
> + * Copyright(c) 2013, Google Inc.
> + *
> + */
> +#include <linux/regmap.h>
> +
> +#include <drm/drm.h>
> +#include <drm/drm_dp_helper.h>
> +#include <drm/drm_print.h>
> +
> +#include "analogix-i2c-dptx.h"
> +
> +#define AUX_WAIT_TIMEOUT_MS	15
> +#define AUX_CH_BUFFER_SIZE	16
> +
> +static int anx_i2c_dp_clear_bits(struct regmap *map, u8 reg, u8 mask)
> +{
> +	return regmap_update_bits(map, reg, mask, 0);
> +}
> +
> +static bool anx_dp_aux_op_finished(struct regmap *map_dptx)
> +{
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_read(map_dptx, SP_DP_AUX_CH_CTRL2_REG, &value);
> +	if (err < 0)
> +		return false;
> +
> +	return (value & SP_AUX_EN) == 0;
> +}
> +
> +static int anx_dp_aux_wait(struct regmap *map_dptx)
> +{
> +	unsigned long timeout;
> +	unsigned int status;
> +	int err;
> +
> +	timeout = jiffies + msecs_to_jiffies(AUX_WAIT_TIMEOUT_MS) + 1;
> +
> +	while (!anx_dp_aux_op_finished(map_dptx)) {
> +		if (time_after(jiffies, timeout)) {
> +			if (!anx_dp_aux_op_finished(map_dptx)) {
> +				DRM_ERROR("Timed out waiting AUX to finish\n");
> +				return -ETIMEDOUT;
> +			}
> +
> +			break;
> +		}
> +
> +		usleep_range(1000, 2000);
> +	}
> +
> +	/* Read the AUX channel access status */
> +	err = regmap_read(map_dptx, SP_AUX_CH_STATUS_REG, &status);
> +	if (err < 0) {
> +		DRM_ERROR("Failed to read from AUX channel: %d\n", err);
> +		return err;
> +	}
> +
> +	if (status & SP_AUX_STATUS) {
> +		DRM_ERROR("Failed to wait for AUX channel (status: %02x)\n",
> +			  status);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int anx_dp_aux_address(struct regmap *map_dptx, unsigned int addr)
> +{
> +	int err;
> +
> +	err = regmap_write(map_dptx, SP_AUX_ADDR_7_0_REG, addr & 0xff);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(map_dptx, SP_AUX_ADDR_15_8_REG,
> +			   (addr & 0xff00) >> 8);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * DP AUX CH Address Register #2, only update bits[3:0]
> +	 * [7:4] RESERVED
> +	 * [3:0] AUX_ADDR[19:16], Register control AUX CH address.
> +	 */
> +	err = regmap_update_bits(map_dptx, SP_AUX_ADDR_19_16_REG,
> +				 SP_AUX_ADDR_19_16_MASK,
> +				 (addr & 0xf0000) >> 16);
> +
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +ssize_t anx_dp_aux_transfer(struct regmap *map_dptx,
> +				struct drm_dp_aux_msg *msg)
> +{
> +	u8 ctrl1 = msg->request;
> +	u8 ctrl2 = SP_AUX_EN;
> +	u8 *buffer = msg->buffer;
> +	int err;
> +
> +	/* The DP AUX transmit and receive buffer has 16 bytes. */
> +	if (WARN_ON(msg->size > AUX_CH_BUFFER_SIZE))
> +		return -E2BIG;
> +
> +	/* Zero-sized messages specify address-only transactions. */
> +	if (msg->size < 1)
> +		ctrl2 |= SP_ADDR_ONLY;
> +	else	/* For non-zero-sized set the length field. */
> +		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
> +
> +	if ((msg->request & DP_AUX_I2C_READ) == 0) {
> +		/* When WRITE | MOT write values to data buffer */
> +		err = regmap_bulk_write(map_dptx,
> +					SP_DP_BUF_DATA0_REG, buffer,
> +					msg->size);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Write address and request */
> +	err = anx_dp_aux_address(map_dptx, msg->address);
> +	if (err)
> +		return err;
> +
> +	err = regmap_write(map_dptx, SP_DP_AUX_CH_CTRL1_REG, ctrl1);
> +	if (err)
> +		return err;
> +
> +	/* Start transaction */
> +	err = regmap_update_bits(map_dptx, SP_DP_AUX_CH_CTRL2_REG,
> +				 SP_ADDR_ONLY | SP_AUX_EN, ctrl2);
> +	if (err)
> +		return err;
> +
> +	err = anx_dp_aux_wait(map_dptx);
> +	if (err)
> +		return err;
> +
> +	msg->reply = DP_AUX_I2C_REPLY_ACK;
> +
> +	if ((msg->size > 0) && (msg->request & DP_AUX_I2C_READ)) {
> +		/* Read values from data buffer */
> +		err = regmap_bulk_read(map_dptx,
> +				       SP_DP_BUF_DATA0_REG, buffer,
> +				       msg->size);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = anx_i2c_dp_clear_bits(map_dptx, SP_DP_AUX_CH_CTRL2_REG,
> +				    SP_ADDR_ONLY);
> +	if (err)
> +		return err;
> +
> +	return msg->size;
> +}
> +EXPORT_SYMBOL_GPL(anx_dp_aux_transfer);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> index 5a54c6d86428..30436c88f181 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
> @@ -253,4 +253,7 @@
>  /* DP AUX Buffer Data Registers */
>  #define SP_DP_BUF_DATA0_REG		0xf0
>  
> +ssize_t anx_dp_aux_transfer(struct regmap *map_dptx,
> +				struct drm_dp_aux_msg *msg);
> +
>  #endif


