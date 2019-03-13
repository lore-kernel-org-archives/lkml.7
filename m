Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663772070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hbU4/7sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCME43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:56:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42944 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCME43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:56:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2D4uRHI086766;
        Tue, 12 Mar 2019 23:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552452987;
        bh=yLb/l9nc1w61sQiQJ1L71BT9s+212L3K7OZ/zS8oJCg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hbU4/7sF52nljY8qc0okDA4fWZ4vaGbSDm+LCNthGoh3Ta7ngJ/kgjVPAuup8V6aj
         14Qv9URN2mdPXaquFBed1O3OWzaxNznvCn5iWeyVBKoGZF9b5Iaoh0/aXcbv3ClVB2
         4/VeO5rZf1MDJIU5vhU7kXLm1w1X9IDWDAJ+9/10=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2D4uRt7022239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 23:56:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 23:56:26 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 23:56:26 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2D4uOoU011444;
        Tue, 12 Mar 2019 23:56:25 -0500
Subject: Re: [PATCH RFT] regulator: lp87565: Fix missing register for
 LP87565_BUCK_0
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20190301061640.28921-1-axel.lin@ingics.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <f90d4497-a174-352b-6f1e-0b8de19088ec@ti.com>
Date:   Wed, 13 Mar 2019 10:26:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301061640.28921-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/19 11:46 AM, Axel Lin wrote:
> LP87565_BUCK_0 is missed, fix it.
> 
> Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi J Keerthy,
> While reading the code, it seems strange that LP87565_BUCK_0 is never used.
> So current code only register 3 BUCKs for lp87565-regulator.
> Can you confirm if this fix is correct or not?

Axel,

If you look at the if check later:

if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87565_Q1) {

Currently the device that i am using only uses LP87565_BUCK_10 and
LP87565_BUCK_23(dual phase).

So your patch definitely makes sense when all 4 are used individually. 
Thanks for catching this.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Thanks,
> Axel
>   drivers/regulator/lp87565-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
> index 4ed41731a5b1..0418e478c6dc 100644
> --- a/drivers/regulator/lp87565-regulator.c
> +++ b/drivers/regulator/lp87565-regulator.c
> @@ -193,7 +193,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
>   	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
>   	struct regulator_config config = { };
>   	struct regulator_dev *rdev;
> -	int i, min_idx = LP87565_BUCK_1, max_idx = LP87565_BUCK_3;
> +	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
>   
>   	platform_set_drvdata(pdev, lp87565);
>   
> 
