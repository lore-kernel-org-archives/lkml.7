Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190CD2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lbjhdS+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfFZPHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:07:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42070 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:07:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5QF7F2r115183;
        Wed, 26 Jun 2019 10:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561561635;
        bh=NLQ2SwXzz1fnoc5qjD4AwGyCd53PSsXJFuyLlIJl520=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lbjhdS+nPu6tWbOxPEfazvgRZuyzAFcXomcH7WkQp4W1R3ODN0xa1RKu6VNZ7Cxwc
         4qeWJnI/OQ7nK4w2AZnHIyVtVueRnGekCuodvHYPVbllrKwqs3RURRfheajaako9dm
         bsNSqgztgfel27iG8BDgp7rFligmhL4/7IIun8Vs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5QF7Fw2093014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 10:07:15 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 10:07:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 10:07:14 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5QF7EZk049063;
        Wed, 26 Jun 2019 10:07:14 -0500
Subject: Re: [RFT][PATCH 1/2] regulator: lm363x: Fix off-by-one n_voltages for
 lm3632 ldo_vpos/ldo_vneg
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190626132632.32629-1-axel.lin@ingics.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a99b04a3-f079-3a43-9e19-d9501b76a96e@ti.com>
Date:   Wed, 26 Jun 2019 10:06:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626132632.32629-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 6/26/19 8:26 AM, Axel Lin wrote:
> According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pdf
> Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
> Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
> 000000: 4 V
> 000001: 4.05 V
> 000010: 4.1 V
> ....................
> 011101: 5.45 V
> 011110: 5.5 V (Default)
> 011111: 5.55 V
> ....................
> 100111: 5.95 V
> 101000: 6 V
> Note: Codes 101001 to 111111 map to 6 V
>
> The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum voltage
> can match the datasheet.
>
> Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/lm363x-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
> index 5647e2f97ff8..e4a27d63bf90 100644
> --- a/drivers/regulator/lm363x-regulator.c
> +++ b/drivers/regulator/lm363x-regulator.c
> @@ -30,7 +30,7 @@
>   
>   /* LM3632 */
>   #define LM3632_BOOST_VSEL_MAX		0x26
> -#define LM3632_LDO_VSEL_MAX		0x29
> +#define LM3632_LDO_VSEL_MAX		0x28

Similar comment as I made on the LM36274

These are 0 based registers so it is 28 + 1

Dan


>   #define LM3632_VBOOST_MIN		4500000
>   #define LM3632_VLDO_MIN			4000000
>   
