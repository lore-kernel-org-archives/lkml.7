Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C61A2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vyzCDD3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCME7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:59:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56000 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCME7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:59:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2D4x9bL071590;
        Tue, 12 Mar 2019 23:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552453149;
        bh=a4DlH7enMgD0Yt9tjUb6+jvt8aPoK6MGtZwtvhqLkxk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vyzCDD3NS7FKugj7BliRtGkUFPbnp4GSX9ZN+9114sQnOgo5CMiAiK3Uk/2sfuq5p
         H4QLoNRSuk+3b0+Q8gbRialMs+q3YCsNQ1OKH1cIbRnR721vVYVanwbGzuulPV4Kbt
         zWPauNIYgSEusX2QQ6q2KQ+a6hade8zRMkjsBUsc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2D4x9Dr043429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 23:59:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 23:59:09 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 23:59:09 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2D4x56O023208;
        Tue, 12 Mar 2019 23:59:06 -0500
Subject: Re: [PATCH] regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from
 struct palmas_pmic
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>,
        <linux-omap@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20190310150609.5178-1-axel.lin@ingics.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <70f2fbf5-a2cd-3806-6b94-9ce857845616@ti.com>
Date:   Wed, 13 Mar 2019 10:29:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190310150609.5178-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/19 8:36 PM, Axel Lin wrote:
> This driver is using devm_regulator_register() so it is not necessary
> to save *rdev for clean up. Actually the pmic->rdev[id] is not used now.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/palmas-regulator.c | 12 ------------
>   include/linux/mfd/palmas.h           |  1 -
>   2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
> index 7fb9e8dd834e..f13c7c8b1061 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -991,9 +991,6 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
>   			return PTR_ERR(rdev);
>   		}
>   
> -		/* Save regulator for cleanup */
> -		pmic->rdev[id] = rdev;
> -
>   		/* Initialise sleep/init values from platform data */
>   		if (pdata) {
>   			reg_init = pdata->reg_init[id];
> @@ -1101,9 +1098,6 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
>   			return PTR_ERR(rdev);
>   		}
>   
> -		/* Save regulator for cleanup */
> -		pmic->rdev[id] = rdev;
> -
>   		/* Initialise sleep/init values from platform data */
>   		if (pdata) {
>   			reg_init = pdata->reg_init[id];
> @@ -1288,9 +1282,6 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
>   				pdev_name);
>   			return PTR_ERR(rdev);
>   		}
> -
> -		/* Save regulator for cleanup */
> -		pmic->rdev[id] = rdev;
>   	}
>   
>   	return 0;
> @@ -1395,9 +1386,6 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
>   				pdev_name);
>   			return PTR_ERR(rdev);
>   		}
> -
> -		/* Save regulator for cleanup */
> -		pmic->rdev[id] = rdev;
>   	}
>   
>   	return 0;
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 75e5c8ff85fc..c34d5f0d34d7 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -553,7 +553,6 @@ struct palmas_pmic {
>   	struct palmas *palmas;
>   	struct device *dev;
>   	struct regulator_desc desc[PALMAS_NUM_REGS];
> -	struct regulator_dev *rdev[PALMAS_NUM_REGS];
>   	struct mutex mutex;
>   
>   	int smps123;
> 
