Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC6AC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2BF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wUS2FXnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfILLko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:40:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58868 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfILLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:40:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8CBePBm024620;
        Thu, 12 Sep 2019 06:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568288425;
        bh=JAbUfkXS1yEg2PX6HE2Q/UJubwObycdqS5f0+MTrqI8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=wUS2FXnjRMRb7nbux+n8VSR2S+QdV9Fa9p8pUDFqVPSwvbqhilzjFXWtVJlCnJesl
         oxX6owTH+yAb4R2D2Xn5kNI5aT5dvwiYKBMv1nvTt9VM+KVjf6tYnwkzQSs0R6XsVw
         r9mS2gdQ5iImyK6GMPxAN/Q5JPZMIG/GYLaCW6AI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8CBePTt013823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Sep 2019 06:40:25 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 12
 Sep 2019 06:40:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 12 Sep 2019 06:40:24 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8CBeOl4035179;
        Thu, 12 Sep 2019 06:40:24 -0500
Subject: Re: [PATCH v3 2/2] backlight: lm3630a: add an enable gpio for the
 HWEN pin
To:     Andreas Kemnade <andreas@kemnade.info>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
References: <20190911172106.12843-1-andreas@kemnade.info>
 <20190911172106.12843-3-andreas@kemnade.info>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4b3407bb-d171-6a70-8252-573a4afbd056@ti.com>
Date:   Thu, 12 Sep 2019 06:40:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911172106.12843-3-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas

On 9/11/19 12:21 PM, Andreas Kemnade wrote:
> For now just enable it in the probe function to allow i2c
> access. Disabling also means resetting the register values
> to default and according to the datasheet does not give
> power savings.
>
> Tested on Kobo Clara HD.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> changes in v2:
> - simplification
> - correct gpio direction initialisation
>
> changes in v3:
> - removed legacy include
>
>   drivers/video/backlight/lm3630a_bl.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 8f84f3684f04..d9e67b9b2571 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -12,6 +12,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/interrupt.h>
>   #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/pwm.h>
>   #include <linux/platform_data/lm3630a_bl.h>
>   
> @@ -48,6 +49,7 @@ struct lm3630a_chip {
>   	struct lm3630a_platform_data *pdata;
>   	struct backlight_device *bleda;
>   	struct backlight_device *bledb;
> +	struct gpio_desc *enable_gpio;
>   	struct regmap *regmap;
>   	struct pwm_device *pwmd;
>   };
> @@ -535,6 +537,13 @@ static int lm3630a_probe(struct i2c_client *client,
>   	}
>   	pchip->pdata = pdata;
>   
> +	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
> +						GPIOD_OUT_HIGH);
> +	if (IS_ERR(pchip->enable_gpio)) {
> +		rval = PTR_ERR(pchip->enable_gpio);
> +		return rval;
> +	}
> +
>   	/* chip initialize */
>   	rval = lm3630a_chip_init(pchip);
>   	if (rval < 0) {

Thanks for the explanation

It looks good to me

Reviewed-by: Dan Murphy <dmurphy@ti.com>

