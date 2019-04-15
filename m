Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19D2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CnsUkAnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfDOMtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:49:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:49:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FCnlRP096267;
        Mon, 15 Apr 2019 07:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555332587;
        bh=YFe124ETZVwznKGr2SyFnSV2sutzA4gL936fl5U6N2g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CnsUkAnhl2XTSVGhDUs4Pov7lfbMfmVJ6+iIisB0eh5G6aexp+tKgn3ezQLqPts36
         iszVY9WkPRxaZqt6P+NszbSE7ULh9hirpVZKRSzJBqhy4CFDhJSNBc1igBrMRf/CZE
         eU3f+9WpX2ZwtS0uq2Mj0hOTNn83owj2B4+gdQCM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FCnlf9083964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 07:49:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 07:49:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 07:49:47 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FCnlvw035450;
        Mon, 15 Apr 2019 07:49:47 -0500
Subject: Re: [PATCH 5/5] leds: lm3697: Introduce the lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-6-dmurphy@ti.com> <20190413200605.GA3013@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f47fff9b-bca1-6412-c423-acf01baabc9f@ti.com>
Date:   Mon, 15 Apr 2019 07:49:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413200605.GA3013@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 4/13/19 3:06 PM, Pavel Machek wrote:
> On Mon 2019-03-25 09:24:03, Dan Murphy wrote:
>> Introduce the lm3697 LED driver for
>> backlighting and display.
>>
>> Datasheet location:
>> http://www.ti.com/lit/ds/symlink/lm3697.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/leds/Kconfig       |   8 +-
>>  drivers/leds/Makefile      |   1 +
>>  drivers/leds/leds-lm3697.c | 401 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 409 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/leds/leds-lm3697.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 735009e73414..688bb9a6f275 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -776,9 +776,15 @@ config LEDS_NIC78BX
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called leds-nic78bx.
>>  
>> +config LEDS_LM3697
>> +	tristate "LED driver for LM3697"
>> +	depends on LEDS_TI_LMU_COMMON
>> +	help
>> +	  Say Y to enable the LM3697 LED driver for TI LMU devices.
>> +	  This supports the LED device LM3697.
>> +
>>  config LEDS_TI_LMU_COMMON
>>  	tristate "LED driver for TI LMU"
>> -	depends on REGMAP
>>  	help
>>            Say Y to enable the LED driver for TI LMU devices.
>>            This supports common features between the TI LM3532, LM3631, LM3632,
> 
> Is deleting "depends on REGMAP" intentional? AFAICT you are using it.
> 

Thanks for pointing that out.  I don't know how that was in there.

> Plus we'd normally expect "COMMON" first and then specific driver. Not
> sure if Kconfig can handle it out-of-order...
> 
> 

OK.  Should I rename the ti_lmu file to leds-common-ti-lmu?

This keeps the naming convention the same in the leds directory as well.

FYI I will not add your acked-by on the LMU patch that introduced the code unless you approve.
Since you found issues with the kconfig

Refererence
https://lore.kernel.org/patchwork/patch/1054500/

>> +static int lm3697_init(struct lm3697 *priv)
>> +{
>> +	struct lm3697_led *led;
>> +	int i, ret;
>> +
>> +	if (priv->enable_gpio) {
>> +		gpiod_direction_output(priv->enable_gpio, 1);
>> +	} else {
>> +		ret = regmap_write(priv->regmap, LM3697_RESET, LM3697_SW_RESET);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "Cannot reset the device\n");
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, LM3697_CTRL_ENABLE, 0x0);
>> +	if (ret) {
>> +		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, LM3697_OUTPUT_CONFIG, priv->bank_cfg);
>> +	if (ret)
>> +		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
> 
> Missing goto out?

Ack

> 
>> +	for (i = 0; i < LM3697_MAX_CONTROL_BANKS; i++) {
>> +		led = &priv->leds[i];
>> +		ret = ti_lmu_common_set_ramp(&led->lmu_data);
>> +		if (ret)
>> +			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
>> +	}
>> +out:
>> +	return ret;
>> +}
> 									Pavel
> 
