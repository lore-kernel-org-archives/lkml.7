Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947CB22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GTfvztIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392637AbfHWHEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:04:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18464 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbfHWHEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:04:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5f8fe90000>; Fri, 23 Aug 2019 00:04:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 00:04:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 23 Aug 2019 00:04:08 -0700
Received: from [10.24.47.72] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 07:04:06 +0000
Subject: Re: [PATCH -next] phy: tegra: Use PTR_ERR_OR_ZERO in
 tegra_p2u_probe()
To:     YueHaibing <yuehaibing@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190822063407.71148-1-yuehaibing@huawei.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7c060719-1df3-c0b8-2e61-5dbfdf1e4798@nvidia.com>
Date:   Fri, 23 Aug 2019 12:34:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822063407.71148-1-yuehaibing@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566543849; bh=EwmZCObquR6UQVPL4m9hVlMsgpb0RyyhCOhP8j1ndas=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GTfvztIz1tlRe4YWr0na/DfdCCrcCopD2lC9zAyI176cMtkg83rhKwgujX4e5B4Nm
         3nIC6+7YmRj0daJYPBPy69tj2oPfT5U3+xH4v+XOaZchieDjcsQPmKq71VeIPi7A1Q
         frlaxHgboHFTgj0KyM/Tizcv0dRcjutmaCg0jvG0sMtmxQjfNVpcUrx6gIRoCiue4t
         pqthrIV5v90gJerkb+JyVcEAFtnVFG5CoHPDfjv2BwoPc5eT9Hf82RTyMGovVQ5JoM
         yTlgiQoX939P/hpbLNnySoJe+QFY//JjKtI+XjY7hyucqFOpQn39q4jYcXEEwghtz7
         ywLSjCC5dg59w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2019 12:04 PM, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/phy/tegra/phy-tegra194-p2u.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
> index 7042bed9feaa..42394d27f4cb 100644
> --- a/drivers/phy/tegra/phy-tegra194-p2u.c
> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
> @@ -92,10 +92,7 @@ static int tegra_p2u_probe(struct platform_device *pdev)
>   	phy_set_drvdata(generic_phy, phy);
>   
>   	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> -	if (IS_ERR(phy_provider))
> -		return PTR_ERR(phy_provider);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(phy_provider);
>   }
Since PTR_ERR_OR_ZERO macro returns zero if input is valid, if some more code gets added in
future after this, then, they might have to change this back to what it is now.
So I ended up continuing with if(IS_ERR(...)) + PTR_ERR towards the end also.
Having said that, I'm fine with this change as well.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

>   
>   static const struct of_device_id tegra_p2u_id_table[] = {
> 
> 
> 
> 
> 

