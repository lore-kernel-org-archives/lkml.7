Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1520421906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gw/RPOoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbfJWIIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:08:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40848 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390035AbfJWIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:08:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N88WYj076964;
        Wed, 23 Oct 2019 03:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571818112;
        bh=8TVmm97HdkcTxHMy4E/vDIGl+8tPfIFTz7dUv6cSREk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Gw/RPOoCBvKJZR+30BdyQ5PXdddkMhZiUiP1Xq6GSdG3ANF7eSj+ycwN3nHLNUzsH
         gqk1VLxSteXH6M5jXYHw1Et3WOQiGCc9/teTCIRFYwpaB7iqazKYTosyEFSjlX+FvE
         VTKjLgoi6+K4N2nO42vztwhj6BXyFLnbXP60xseI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N88VNt087263;
        Wed, 23 Oct 2019 03:08:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:07:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:07:56 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N8845V017123;
        Wed, 23 Oct 2019 03:08:04 -0500
Subject: Re: [PATCH -next] phy: ti: dm816x: remove set but not used variable
 'phy_data'
To:     YueHaibing <yuehaibing@huawei.com>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20191023074523.31888-1-yuehaibing@huawei.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <9e60aeb1-e9e7-f6c1-a392-8a714171b878@ti.com>
Date:   Wed, 23 Oct 2019 11:08:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023074523.31888-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/2019 10:45, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/phy/ti/phy-dm816x-usb.c:192:29: warning:
>   variable phy_data set but not used [-Wunused-but-set-variable]
> 
> It is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>   drivers/phy/ti/phy-dm816x-usb.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
> index cbcce7c..26f1947 100644
> --- a/drivers/phy/ti/phy-dm816x-usb.c
> +++ b/drivers/phy/ti/phy-dm816x-usb.c
> @@ -189,7 +189,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
>   	struct phy_provider *phy_provider;
>   	struct usb_otg *otg;
>   	const struct of_device_id *of_id;
> -	const struct usb_phy_data *phy_data;
>   	int error;
>   
>   	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
> @@ -220,8 +219,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
>   	if (phy->usbphy_ctrl == 0x2c)
>   		phy->instance = 1;
>   
> -	phy_data = of_id->data;
> -
>   	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
>   	if (!otg)
>   		return -ENOMEM;
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
