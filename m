Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222DC20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ApTJ0OFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCDONW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:13:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57470 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCDONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:13:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x24EDJfB066824;
        Mon, 4 Mar 2019 08:13:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551708799;
        bh=B+RW5Iwl73wACan9RD20VEUjFUvZ9LlAkxmoYlmbkYY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ApTJ0OFPtgk8gzKDhof4QkklrwUP/4E9ZoGl3wedq+mMsK7pJC+PSv6z12ghTHS9D
         5+RQDJX+HYVoUMhRQa/Yjz06/VVY+3GpXmKkkuWaLyr4jnW7ORbGSupc/sqsTc15e7
         p2uJxVgI3rMwA5Z+FT5tYxUJpMkutYV1Xi05RjPk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x24EDJos025402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Mar 2019 08:13:19 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Mar 2019 08:13:18 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Mar 2019 08:13:18 -0600
Received: from [172.22.102.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x24EDIGE018669;
        Mon, 4 Mar 2019 08:13:18 -0600
Subject: Re: [PATCH] regulator: tps65086: Fix tps65086_ldoa1_ranges for
 selector 0xB
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190304085752.15251-1-axel.lin@ingics.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <396707e3-1aad-1d55-c2a3-ed33629a5f7b@ti.com>
Date:   Mon, 4 Mar 2019 08:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304085752.15251-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 2:57 AM, Axel Lin wrote:
> selector 0xB (1011) should be 2.6V rather than 2.7V, fit ix.
> 
> Table 5-4. LDOA1 Output Voltage Options
> VID Bits VOUT VID Bits VOUT VID Bits VOUT VID Bits VOUT
> 0000     1.35 0100     1.8  1000     2.3  1100     2.85
> 0001     1.5  0101     1.9  1001     2.4  1101     3.0
> 0010     1.6  0110     2.0  1010     2.5  1110     3.3
> 0011     1.7  0111     2.1  1011     2.6  1111     Not Used
> 
> Fixes: d2a2e729a666 ("regulator: tps65086: Add regulator driver for the TPS65086 PMIC")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Steven and Andrew,
> I don't have this h/w to test. Can you help to verify it?
> 

I'll dig one of these out for testing, I'll report back here if
something is wrong, but for now you are correct according to the
datasheet so:

Acked-by: Andrew F. Davis <afd@ti.com>

> Thanks,
> Axel
> 
>  drivers/regulator/tps65086-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
> index 45e96e154690..5a5e9b5bf4be 100644
> --- a/drivers/regulator/tps65086-regulator.c
> +++ b/drivers/regulator/tps65086-regulator.c
> @@ -90,8 +90,8 @@ static const struct regulator_linear_range tps65086_buck345_25mv_ranges[] = {
>  static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(1350000, 0x0, 0x0, 0),
>  	REGULATOR_LINEAR_RANGE(1500000, 0x1, 0x7, 100000),
> -	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xA, 100000),
> -	REGULATOR_LINEAR_RANGE(2700000, 0xB, 0xD, 150000),
> +	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xB, 100000),
> +	REGULATOR_LINEAR_RANGE(2850000, 0xC, 0xD, 150000),
>  	REGULATOR_LINEAR_RANGE(3300000, 0xE, 0xE, 0),
>  };
>  
> 
