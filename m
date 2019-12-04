Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649BCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277C420674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uZju8+En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLDIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:39:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:39:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB48dnlB098180;
        Wed, 4 Dec 2019 02:39:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575448789;
        bh=kIf+FK3QwDZXdvWtPj+QZXSJqavKAzj/7/FnUtLPm3A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uZju8+EnXkDg7P4M4xAjZbKLodTE2G0Z8eF+IypZcHMt8/yLfPF8qypBv6RGndIxE
         /cC505SXhUjDtYZUVEqJjkTKkTsYTr+VljkoTBODyaE3eHfMyedSp0Kjl1p4A97xd5
         Ny5DXkxu1mupilF5uwq0sVaFnmjdUtE2ujfPdEik=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB48dnlo070005;
        Wed, 4 Dec 2019 02:39:49 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 02:39:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 02:39:49 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB48dltU102099;
        Wed, 4 Dec 2019 02:39:48 -0600
Subject: Re: [PATCH] phy: ti-pipe3: fix missed clk_disable_unprepare in remove
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20191204072540.1452-1-hslester96@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3384e4e0-d3d0-1ab0-f631-8b1dfdc5705a@ti.com>
Date:   Wed, 4 Dec 2019 10:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204072540.1452-1-hslester96@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuhong,

On 04/12/2019 09:25, Chuhong Yuan wrote:
> The driver calls clk_prepare_enable in probe but forgets to call
> clk_disable_unprepare in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>   drivers/phy/ti/phy-ti-pipe3.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> index edd6859afba8..19fd1005a440 100644
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

In fact we are doing an additional disable in ti_pipe3_disable_clocks()
for SATA case.

I think that piece of code should removed if you implement it in
ti_pipe3_remove().
Also commit log should be updated accordingly.

>   	pm_runtime_disable(&pdev->dev);
>   
>   	return 0;
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
