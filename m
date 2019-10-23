Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF296CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EzeP7+NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbfJWF37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:29:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40024 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfJWF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:29:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N5TtlJ091320;
        Wed, 23 Oct 2019 00:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571808595;
        bh=Hi7eqp7k33xU8scvMYGLmRaKPB2Y1yz2In2DfbGOD9w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EzeP7+NJPphcPvxER9+TBrztxnnb6fibxgVa73D8UUlGzOSMGJ22HZHkFjjlyYrNz
         wsnek13dsBbUKoWkBAiStBDMlK2YOyaS06wJGIGOPKMsCav7k+Ro4okuX6PbOPmX/r
         IwA1/Hxs0Jn5dit2B2DcvUlvYVNiYIb1ykXAxPe0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N5Td1F044859
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 00:29:40 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 00:29:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 00:29:39 -0500
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N5Sqiq100120;
        Wed, 23 Oct 2019 00:28:52 -0500
Subject: Re: [PATCH 3/3] phy: ti: j721e-wiz: Manage typec-gpio-dir
To:     Roger Quadros <rogerq@ti.com>, <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191022132249.869-1-rogerq@ti.com>
 <20191022132249.869-4-rogerq@ti.com>
From:   Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <35e5a15c-5513-9c0d-6fdd-df06f8c95450@ti.com>
Date:   Wed, 23 Oct 2019 08:28:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022132249.869-4-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2019 16:22, Roger Quadros wrote:
> Based on this GPIO state we need to configure LN10
> bit to swap lane0 and lane1 if required (flipped connector).
> 
> Type-C companions typically need some time after the cable is
> plugged before and before they reflect the correct status of
> Type-C plug orientation on the DIR line.
> 
> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
> of 100 ms (min) to 200 ms (max).
> 
> Use the DT property to figure out if we need to add delay
> or not before sampling the Type-C DIR line.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 2a95da843e9f..2becdbcb762a 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -9,6 +9,8 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mux/consumer.h>
> @@ -22,6 +24,7 @@
>  #define WIZ_SERDES_CTRL		0x404
>  #define WIZ_SERDES_TOP_CTRL	0x408
>  #define WIZ_SERDES_RST		0x40c
> +#define WIZ_SERDES_TYPEC	0x410
>  #define WIZ_LANECTL(n)		(0x480 + (0x40 * (n)))
>  
>  #define WIZ_MAX_LANES		4
> @@ -29,6 +32,8 @@
>  #define WIZ_DIV_NUM_CLOCKS_16G	2
>  #define WIZ_DIV_NUM_CLOCKS_10G	1
>  
> +#define WIZ_SERDES_TYPEC_LN10_SWAP	BIT(30)
> +
>  enum wiz_lane_standard_mode {
>  	LANE_MODE_GEN1,
>  	LANE_MODE_GEN2,
> @@ -206,6 +211,8 @@ struct wiz {
>  	u32			num_lanes;
>  	struct platform_device	*serdes_pdev;
>  	struct reset_controller_dev wiz_phy_reset_dev;
> +	struct gpio_desc	*gpio_typec_dir;
> +	int			typec_dir_delay;
>  };
>  
>  static int wiz_reset(struct wiz *wiz)
> @@ -703,6 +710,21 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  	struct wiz *wiz = dev_get_drvdata(dev);
>  	int ret;
>  
> +	/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
> +	if (id == 0 && wiz->gpio_typec_dir) {
> +		if (wiz->typec_dir_delay)
> +			msleep_interruptible(wiz->typec_dir_delay);
> +
> +		if (gpiod_get_value_cansleep(wiz->gpio_typec_dir)) {
> +			regmap_update_bits(wiz->regmap, WIZ_SERDES_TYPEC,
> +					   WIZ_SERDES_TYPEC_LN10_SWAP,
> +					   WIZ_SERDES_TYPEC_LN10_SWAP);

A nit pick, but wouldn't it be more coherent with the rest of the driver
to define a REG_FIELD also for TYPEC_LN10_SWAP bit?

> +		} else {
> +			regmap_update_bits(wiz->regmap, WIZ_SERDES_TYPEC,
> +					   WIZ_SERDES_TYPEC_LN10_SWAP, 0);
> +		}
> +	}
> +
>  	if (id == 0) {
>  		ret = regmap_field_write(wiz->phy_reset_n, true);
>  		return ret;
> @@ -789,6 +811,25 @@ static int wiz_probe(struct platform_device *pdev)
>  		goto err_addr_to_resource;
>  	}
>  
> +	wiz->gpio_typec_dir = devm_gpiod_get_optional(dev, "typec-dir",
> +						      GPIOD_IN);
> +	if (IS_ERR(wiz->gpio_typec_dir)) {
> +		ret = PTR_ERR(wiz->gpio_typec_dir);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request typec-dir gpio: %d\n",
> +				ret);
> +		goto err_addr_to_resource;
> +	}
> +
> +	if (wiz->gpio_typec_dir) {
> +		ret = of_property_read_u32(node, "typec-dir-debounce",
> +					   &wiz->typec_dir_delay);
> +		if (ret && ret != -EINVAL) {
> +			dev_err(dev, "Invalid typec-dir-debounce property\n");
> +			goto err_addr_to_resource;
> +		}
> +	}
> +
>  	wiz->dev = dev;
>  	wiz->regmap = regmap;
>  	wiz->num_lanes = num_lanes;
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
