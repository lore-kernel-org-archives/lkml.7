Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923FA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FtKb41UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCLKEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:04:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3864 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfCLKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:04:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8784420000>; Tue, 12 Mar 2019 03:04:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 03:04:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Mar 2019 03:04:49 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 10:04:47 +0000
Subject: Re: [PATCH 3/9] drivers: ata: ahci_tegra: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hdegoede@redhat.com>,
        <b.zolnierkie@samsung.com>, <linus.walleij@linaro.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-3-git-send-email-info@metux.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c16b35f1-0c0a-707b-d097-bb0440454cbb@nvidia.com>
Date:   Tue, 12 Mar 2019 10:04:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552382374-28789-3-git-send-email-info@metux.net>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552385090; bh=9CX1dkkXixTkp+czgYBddLsVCG8J/kXJV7Ym5LA6Bmc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FtKb41UKi0LqRMX/nZbnP1CYPkv5J5uYUfh69mz+ND8ChEyETJ32ffq/MBejkcrdc
         jfIIdPEnpgEvFul0ke9tN/rEHjYQItyXbK/c1Wnc9MzkegQM3g4av64nV6oBkn+uvH
         6G0rkIBUM3/oG41DvEsiEAEiJAmqsIhHC9M/KDbUJJl1XwSubeV7nMaf7DOoI3R9Hs
         kUaz0t56wnfKxAZp+gJIH6rgFHUWAPRsi/A5VlzArExJ47M883gO1kVaKCzuIGUtQL
         lYEd8li+xA4bSPNLEVfvjh5s79SgCHiPnpFFgKuvtucsXTzQ3z6yw8sxa1ozM343Jp
         u0RgzBA9SazyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2019 09:19, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ata/ahci_tegra.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 004f260..88748ca 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -490,7 +490,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  {
>  	struct ahci_host_priv *hpriv;
>  	struct tegra_ahci_priv *tegra;
> -	struct resource *res;
>  	int ret;
>  	unsigned int i;
>  
> @@ -507,19 +506,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  	tegra->pdev = pdev;
>  	tegra->soc = of_device_get_match_data(&pdev->dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tegra->sata_regs))
>  		return PTR_ERR(tegra->sata_regs);
>  
>  	/*
>  	 * AUX registers is optional.
>  	 */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	if (res) {
> -		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(tegra->sata_aux_regs))
> -			return PTR_ERR(tegra->sata_aux_regs);
> +	tegra->sata_aux_regs = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(tegra->sata_aux_regs)) {
> +		dev_info(&pdev->dev, "Cant get aux registers (optional)");

dev_err?

> +		tegra->sata_aux_regs = NULL;

This bit does not look right, because although the AUX registers are
optional, now we don't know if it failed because they are not supported
for a given device or something else failed. So I am not sure we can do
this here.

Cheers
Jon

-- 
nvpublic
