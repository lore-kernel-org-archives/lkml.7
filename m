Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87DA2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z3lN3OV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbfJWINL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:13:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41886 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:13:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N8D960078588;
        Wed, 23 Oct 2019 03:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571818389;
        bh=uVlUM68KJ4gRVVup5JV8Sfox9tFnz2sJr5rZVh5XS0s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z3lN3OV6UJMaoD+m9jWaSHmUIYLTQWqyWb14Ld17ooLUBMqQZGYJ+nfEuVYD+s98w
         qrtCk/hEV+VvPy4XqUPnH9EY98e+VwMOj4jGx0UZUdlexNBciQWvYBZyELbGoyR6Sb
         7Ym+gSJp/H7BtspIXy7IION+J7dKgZdGcr1LECPE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N8D45E097509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 03:13:08 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:10:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:10:43 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N8Aob5059117;
        Wed, 23 Oct 2019 03:10:51 -0500
Subject: Re: [PATCH 3/3] phy: ti: j721e-wiz: Manage typec-gpio-dir
To:     Jyri Sarha <jsarha@ti.com>, <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191022132249.869-1-rogerq@ti.com>
 <20191022132249.869-4-rogerq@ti.com>
 <35e5a15c-5513-9c0d-6fdd-df06f8c95450@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <878dc50e-45c9-c355-d064-5251fc4245ec@ti.com>
Date:   Wed, 23 Oct 2019 11:10:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35e5a15c-5513-9c0d-6fdd-df06f8c95450@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/2019 08:28, Jyri Sarha wrote:
> On 22/10/2019 16:22, Roger Quadros wrote:
>> Based on this GPIO state we need to configure LN10
>> bit to swap lane0 and lane1 if required (flipped connector).
>>
>> Type-C companions typically need some time after the cable is
>> plugged before and before they reflect the correct status of
>> Type-C plug orientation on the DIR line.
>>
>> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
>> of 100 ms (min) to 200 ms (max).
>>
>> Use the DT property to figure out if we need to add delay
>> or not before sampling the Type-C DIR line.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>   drivers/phy/ti/phy-j721e-wiz.c | 41 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
>> index 2a95da843e9f..2becdbcb762a 100644
>> --- a/drivers/phy/ti/phy-j721e-wiz.c
>> +++ b/drivers/phy/ti/phy-j721e-wiz.c
>> @@ -9,6 +9,8 @@
>>   #include <dt-bindings/phy/phy.h>
>>   #include <linux/clk.h>
>>   #include <linux/clk-provider.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/mux/consumer.h>
>> @@ -22,6 +24,7 @@
>>   #define WIZ_SERDES_CTRL		0x404
>>   #define WIZ_SERDES_TOP_CTRL	0x408
>>   #define WIZ_SERDES_RST		0x40c
>> +#define WIZ_SERDES_TYPEC	0x410
>>   #define WIZ_LANECTL(n)		(0x480 + (0x40 * (n)))
>>   
>>   #define WIZ_MAX_LANES		4
>> @@ -29,6 +32,8 @@
>>   #define WIZ_DIV_NUM_CLOCKS_16G	2
>>   #define WIZ_DIV_NUM_CLOCKS_10G	1
>>   
>> +#define WIZ_SERDES_TYPEC_LN10_SWAP	BIT(30)
>> +
>>   enum wiz_lane_standard_mode {
>>   	LANE_MODE_GEN1,
>>   	LANE_MODE_GEN2,
>> @@ -206,6 +211,8 @@ struct wiz {
>>   	u32			num_lanes;
>>   	struct platform_device	*serdes_pdev;
>>   	struct reset_controller_dev wiz_phy_reset_dev;
>> +	struct gpio_desc	*gpio_typec_dir;
>> +	int			typec_dir_delay;
>>   };
>>   
>>   static int wiz_reset(struct wiz *wiz)
>> @@ -703,6 +710,21 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>>   	struct wiz *wiz = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	/* if typec-dir gpio was specified, set LN10 SWAP bit based on that */
>> +	if (id == 0 && wiz->gpio_typec_dir) {
>> +		if (wiz->typec_dir_delay)
>> +			msleep_interruptible(wiz->typec_dir_delay);
>> +
>> +		if (gpiod_get_value_cansleep(wiz->gpio_typec_dir)) {
>> +			regmap_update_bits(wiz->regmap, WIZ_SERDES_TYPEC,
>> +					   WIZ_SERDES_TYPEC_LN10_SWAP,
>> +					   WIZ_SERDES_TYPEC_LN10_SWAP);
> 
> A nit pick, but wouldn't it be more coherent with the rest of the driver
> to define a REG_FIELD also for TYPEC_LN10_SWAP bit?

I agree. Although, I hate fields as you need to do so much boilerplate just to
flip one bit.

cheers,
-roger
> 
>> +		} else {
>> +			regmap_update_bits(wiz->regmap, WIZ_SERDES_TYPEC,
>> +					   WIZ_SERDES_TYPEC_LN10_SWAP, 0);
>> +		}
>> +	}
>> +
>>   	if (id == 0) {
>>   		ret = regmap_field_write(wiz->phy_reset_n, true);
>>   		return ret;
>> @@ -789,6 +811,25 @@ static int wiz_probe(struct platform_device *pdev)
>>   		goto err_addr_to_resource;
>>   	}
>>   
>> +	wiz->gpio_typec_dir = devm_gpiod_get_optional(dev, "typec-dir",
>> +						      GPIOD_IN);
>> +	if (IS_ERR(wiz->gpio_typec_dir)) {
>> +		ret = PTR_ERR(wiz->gpio_typec_dir);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "Failed to request typec-dir gpio: %d\n",
>> +				ret);
>> +		goto err_addr_to_resource;
>> +	}
>> +
>> +	if (wiz->gpio_typec_dir) {
>> +		ret = of_property_read_u32(node, "typec-dir-debounce",
>> +					   &wiz->typec_dir_delay);
>> +		if (ret && ret != -EINVAL) {
>> +			dev_err(dev, "Invalid typec-dir-debounce property\n");
>> +			goto err_addr_to_resource;
>> +		}
>> +	}
>> +
>>   	wiz->dev = dev;
>>   	wiz->regmap = regmap;
>>   	wiz->num_lanes = num_lanes;
>>
> 
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
