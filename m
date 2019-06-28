Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10287C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09CB2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJYYRBPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfF1D2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:28:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51606 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1D2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:28:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5S3S6lZ006317;
        Thu, 27 Jun 2019 22:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561692486;
        bh=lHtPKETdLi4mz0hSNNJnuE1V/UMtFP6OzWRnYrjP7po=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cJYYRBPy3RiT5CHxIoh9lbCAyGUZ0Jyhh3HTYiu4pNLfmNYAgv2nPP7/sub8ekxnm
         unBkNLYeyn0mBZoAM9EsEzy4aMImJe5bhcvJgIyTMMfRpo8qqUf5U3tLLAb1qKanrm
         7BudChPInpqWkneMujwpafOdwJS6oIOQrxzMfrWY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5S3S6uH083741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 22:28:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 22:28:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 22:28:05 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5S3S3Ej112735;
        Thu, 27 Jun 2019 22:28:04 -0500
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190627131639.6394-1-colin.king@canonical.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <1a17ea61-a164-d61f-6416-637d47668f1b@ti.com>
Date:   Fri, 28 Jun 2019 08:58:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627131639.6394-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/19 6:46 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
> break statement, causing it to fall through to a dev_err message.
> Fix this by adding in the missing break statement.
> 
> Addresses-Coverity: ("Missing break in switch")
> Fixes: 7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/regulator/lp87565-regulator.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
> index 993c11702083..5d067f7c2116 100644
> --- a/drivers/regulator/lp87565-regulator.c
> +++ b/drivers/regulator/lp87565-regulator.c
> @@ -180,6 +180,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
>   	case LP87565_DEVICE_TYPE_LP87561_Q1:
>   		min_idx = LP87565_BUCK_3210;
>   		max_idx = LP87565_BUCK_3210;
> +		break;

Thanks Colin.

Reviewed-by: Keerthy <j-keerthy@ti.com>

>   	default:
>   		dev_err(lp87565->dev, "Invalid lp config %d\n",
>   			lp87565->dev_type);
> 
