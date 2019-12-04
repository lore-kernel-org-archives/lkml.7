Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5D20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m6yfe3kY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfLDMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:32:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35682 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfLDMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:32:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4CWXoF033651;
        Wed, 4 Dec 2019 06:32:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575462753;
        bh=6G/9MRzKyVc1RjmQv1A+jIRb9kngu1DhAJbeluXOOKQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m6yfe3kY/NEtb7u7K6Ev7IBbFJKxUXBdHIXUmzS7vm6991ZdIyMikG2DaXHe8DTgH
         R4ZGVcJBqoLHBNg3kj4AucB0LqXGuGjQpvagZZ7+ams3WvI3V9NtB0i+amHbvAhMeF
         EDuYGGieeLWdMICKoxUstgjIm+JNGMIWsftNVcD8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB4CWX8B052924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Dec 2019 06:32:33 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 06:32:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 06:32:33 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4CWWuq119399;
        Wed, 4 Dec 2019 06:32:32 -0600
Subject: Re: [PATCH v2] phy: ti-pipe3: make clk operations symmetric in probe
 and remove
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20191204114759.3754-1-hslester96@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <2dd4749d-edca-3b63-4804-d51b13f3724d@ti.com>
Date:   Wed, 4 Dec 2019 14:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204114759.3754-1-hslester96@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2019 13:47, Chuhong Yuan wrote:
> The driver calls clk_prepare_enable in probe but the corresponding
> clk_disable_unprepare() is in ti_pipe3_disable_clocks().
> Move clk_disable_unprepare() to remove to make them symmetric.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
> Changes in v2:
>    - Modify commit message.
>    - Delete the clk_disable_unprepare() in ti_pipe3_disable_clocks().
> 
>   drivers/phy/ti/phy-ti-pipe3.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> index edd6859afba8..a87946589eb7 100644
> --- a/drivers/phy/ti/phy-ti-pipe3.c
> +++ b/drivers/phy/ti/phy-ti-pipe3.c
> @@ -850,6 +850,12 @@ static int ti_pipe3_probe(struct platform_device *pdev)
>   
>   static int ti_pipe3_remove(struct platform_device *pdev)
>   {
> +	struct ti_pipe3 *phy = platform_get_drvdata(pdev);
> +
> +	if (phy->mode == PIPE3_MODE_SATA) {
> +		clk_disable_unprepare(phy->refclk);
> +		phy->sata_refclk_enabled = false;
> +	}
>   	pm_runtime_disable(&pdev->dev);
>   
>   	return 0;
> @@ -900,18 +906,8 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy)
>   {
>   	if (!IS_ERR(phy->wkupclk))
>   		clk_disable_unprepare(phy->wkupclk);
> -	if (!IS_ERR(phy->refclk)) {
> +	if (!IS_ERR(phy->refclk))
>   		clk_disable_unprepare(phy->refclk);
> -		/*
> -		 * SATA refclk needs an additional disable as we left it
> -		 * on in probe to avoid Errata i783
> -		 */
> -		if (phy->sata_refclk_enabled) {
> -			clk_disable_unprepare(phy->refclk);
> -			phy->sata_refclk_enabled = false;
> -		}
> -	}
> -
>   	if (!IS_ERR(phy->div_clk))
>   		clk_disable_unprepare(phy->div_clk);
>   }
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
