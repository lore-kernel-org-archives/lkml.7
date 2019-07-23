Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E24C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A00E223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ffqKtykH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfGWIIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:08:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727375AbfGWIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:08:44 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N87WFN014631;
        Tue, 23 Jul 2019 10:08:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=AKxPpMAXwIcIBJsSDUaSrH2KFjcTDebR2UQK62XeNTI=;
 b=ffqKtykHafNMPh5TWxQPVQuWC2I7ICVHmjwFXjHSX9qqaCMK+q/4ZW5Lk3FR6prWaaox
 8/CVaCA3yQLnUt9KM/XEw2BZFNRyEUvaCbDVgU66erqmJTiKUd2mwPU0bi9rDWVk9tzv
 NfYT6vTWIWqB88RB/jvKdT0geA0dInDvxjMC8W7H9wXxa62vGaU9qDxfGSoRPKR8sZYW
 xa8rIBqhlrABX4idNe6Yq3WTuKgm8MWhO9cjU/iLS5GGPFEbVeeg7QtcFIxmil6aaj0O
 BE3+Eq3BWGsalZvNenPxF0GyaY2Wx63Id0Zp9Q9ZlIHsCjRNqDd1+wGIgakB6xqgGcLl SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tur39ge38-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Jul 2019 10:08:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E3F93A;
        Tue, 23 Jul 2019 08:08:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 066C82514;
        Tue, 23 Jul 2019 08:08:37 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Jul
 2019 10:08:37 +0200
Received: from [10.48.0.167] (10.48.0.167) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Jul 2019 10:08:36
 +0200
Subject: Re: [PATCH] regulator: stm32-booster: Remove .min_uV and
 .list_voltage for fixed regulator
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190723014102.25103-1-axel.lin@ingics.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <d36c7925-1374-80e0-60e2-b08377be1f5f@st.com>
Date:   Tue, 23 Jul 2019 10:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723014102.25103-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.167]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 3:41 AM, Axel Lin wrote:
> Setting .n_voltages = 1 and .fixed_uV is enough for fixed regulator,
> remove the redundant .min_uV and .list_voltage settings.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Hi Axel,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> ---
>  drivers/regulator/stm32-booster.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/regulator/stm32-booster.c b/drivers/regulator/stm32-booster.c
> index 2a897666c650..03f162ffd144 100644
> --- a/drivers/regulator/stm32-booster.c
> +++ b/drivers/regulator/stm32-booster.c
> @@ -20,7 +20,6 @@
>  #define STM32MP1_SYSCFG_EN_BOOSTER_MASK	BIT(8)
>  
>  static const struct regulator_ops stm32h7_booster_ops = {
> -	.list_voltage	= regulator_list_voltage_linear,
>  	.enable		= regulator_enable_regmap,
>  	.disable	= regulator_disable_regmap,
>  	.is_enabled	= regulator_is_enabled_regmap,
> @@ -31,7 +30,6 @@ static const struct regulator_desc stm32h7_booster_desc = {
>  	.supply_name = "vdda",
>  	.n_voltages = 1,
>  	.type = REGULATOR_VOLTAGE,
> -	.min_uV = 3300000,
>  	.fixed_uV = 3300000,
>  	.ramp_delay = 66000, /* up to 50us to stabilize */
>  	.ops = &stm32h7_booster_ops,
> @@ -53,7 +51,6 @@ static int stm32mp1_booster_disable(struct regulator_dev *rdev)
>  }
>  
>  static const struct regulator_ops stm32mp1_booster_ops = {
> -	.list_voltage	= regulator_list_voltage_linear,
>  	.enable		= stm32mp1_booster_enable,
>  	.disable	= stm32mp1_booster_disable,
>  	.is_enabled	= regulator_is_enabled_regmap,
> @@ -64,7 +61,6 @@ static const struct regulator_desc stm32mp1_booster_desc = {
>  	.supply_name = "vdda",
>  	.n_voltages = 1,
>  	.type = REGULATOR_VOLTAGE,
> -	.min_uV = 3300000,
>  	.fixed_uV = 3300000,
>  	.ramp_delay = 66000,
>  	.ops = &stm32mp1_booster_ops,
> 
