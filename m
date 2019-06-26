Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE54C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pm9B8nT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFZPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:07:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42056 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfFZPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:07:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5QF77bI115167;
        Wed, 26 Jun 2019 10:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561561627;
        bh=jNzQtnF7CSc+vMKT07mzXLcQafUP1JhZFZLSqOuS39o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pm9B8nT/Ow+sAAwTqTsKgLpvQyW3bJ6gG0GFc/0OD7c3ZEqhV5jiUA9ENBA9AUFRf
         aLRYKlJE4lQFoT28BxdDckqDP1N9TH9D7Mj/RUDbjpmQkIf+Kn+vbA1GRA43vWQjiG
         tVJM6Tz+ejdskbGD3+QTf4wzdEomH6jsfmcAPuqs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5QF77Vr092838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 10:07:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 10:07:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 10:07:07 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5QF767q048868;
        Wed, 26 Jun 2019 10:07:07 -0500
Subject: Re: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for
 lm36274
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190626132632.32629-1-axel.lin@ingics.com>
 <20190626132632.32629-2-axel.lin@ingics.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com>
Date:   Wed, 26 Jun 2019 10:06:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626132632.32629-2-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 6/26/19 8:26 AM, Axel Lin wrote:
> According to the datasheet http://www.ti.com/lit/ds/symlink/lm36274.pdf:
> Table 23. VPOS Bias Register Field Descriptions VPOS[5:0]:
> VPOS voltage (50-mV steps): VPOS = 4 V + (Code × 50 mV), 6.5 V max
> 000000 = 4 V
> 000001 = 4.05 V
> :
> 011110 = 5.5 V (Default)
> :
> 110010 = 6.5 V
> 110011 to 111111 map to 6.5 V
>
> So the LM36274_LDO_VSEL_MAX should be 0b110010 (0x32).
> The valid selectors are 0 ... LM36274_LDO_VSEL_MAX, n_voltages should be
> LM36274_LDO_VSEL_MAX + 1. Similarly, the n_voltages should be
> LM36274_BOOST_VSEL_MAX + 1 for LM36274_BOOST.
>
> Fixes: bff5e8071533 ("regulator: lm363x: Add support for LM36274")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/lm363x-regulator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
> index e4a27d63bf90..4b9f618b07e9 100644
> --- a/drivers/regulator/lm363x-regulator.c
> +++ b/drivers/regulator/lm363x-regulator.c
> @@ -36,7 +36,7 @@
>   
>   /* LM36274 */
>   #define LM36274_BOOST_VSEL_MAX		0x3f
> -#define LM36274_LDO_VSEL_MAX		0x34
> +#define LM36274_LDO_VSEL_MAX		0x32

This does not seem correct the max number of voltages are 0x34.

The register is zero based so you can have 33 voltage select levels and 
+ 1 is 34 total selectors

Liam/Mark correct me if I am incorrect.

Dan


>   #define LM36274_VOLTAGE_MIN		4000000
>   
>   /* Common */
> @@ -226,7 +226,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
>   		.of_match	= "vboost",
>   		.id             = LM36274_BOOST,
>   		.ops            = &lm363x_boost_voltage_table_ops,
> -		.n_voltages     = LM36274_BOOST_VSEL_MAX,
> +		.n_voltages     = LM36274_BOOST_VSEL_MAX + 1,
>   		.min_uV         = LM36274_VOLTAGE_MIN,
>   		.uV_step        = LM363X_STEP_50mV,
>   		.type           = REGULATOR_VOLTAGE,
> @@ -239,7 +239,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
>   		.of_match	= "vpos",
>   		.id             = LM36274_LDO_POS,
>   		.ops            = &lm363x_regulator_voltage_table_ops,
> -		.n_voltages     = LM36274_LDO_VSEL_MAX,
> +		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
>   		.min_uV         = LM36274_VOLTAGE_MIN,
>   		.uV_step        = LM363X_STEP_50mV,
>   		.type           = REGULATOR_VOLTAGE,
> @@ -254,7 +254,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
>   		.of_match	= "vneg",
>   		.id             = LM36274_LDO_NEG,
>   		.ops            = &lm363x_regulator_voltage_table_ops,
> -		.n_voltages     = LM36274_LDO_VSEL_MAX,
> +		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
>   		.min_uV         = LM36274_VOLTAGE_MIN,
>   		.uV_step        = LM363X_STEP_50mV,
>   		.type           = REGULATOR_VOLTAGE,
