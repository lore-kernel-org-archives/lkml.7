Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE81C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC71920700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XjVFCalQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6ACo0cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfDAHs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:48:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:48:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7B9DF6194A; Mon,  1 Apr 2019 07:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104937;
        bh=VEiRkFYKeuBuggcZfhD7B/6RH6TnChw/zp1EwqsYi2k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XjVFCalQI32xNg2ZrLGRGXmCCMLR4PgsD0Hx80nIxGg1osq0DSJgCsrRENquAhwE4
         X0s/+XL7h3q9HwCOuH8V3d4NV7hE0gCyCwzV+IVU3//YgnMDzhbJWKWzvW3jDKELU9
         /Zr+cJtv2HO2Tn8SlAs+WG9xbyRIxh46/jmy3PsU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 449B2618DD;
        Mon,  1 Apr 2019 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104923;
        bh=VEiRkFYKeuBuggcZfhD7B/6RH6TnChw/zp1EwqsYi2k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P6ACo0cJeqIT3XywqnvEug6f/fPt7G4yWj2avBgY6B2ez82sFrNyggsajHS6yJNst
         fftNY31D3ZKe1ULmDsQZwYtEDxQa2R76Z82AK38gX4/DAgGoFnHEuT7GwpHD/YYSV/
         gGnUrgFAR3vXEY/U1/d89/vOsluQyDdS4g2k0OJ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 449B2618DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/2] soc: imx: gpc: use devm_platform_ioremap_resource()
 to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554098543-5036-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7f50128c-2c8b-c7b5-8c93-eb86fa627e48@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:18:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554098543-5036-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 11:37 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/soc/imx/gpc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 7d14a4b..a8f1e47 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -406,7 +406,6 @@ static int imx_gpc_probe(struct platform_device *pdev)
>   	const struct imx_gpc_dt_data *of_id_data = of_id->data;
>   	struct device_node *pgc_node;
>   	struct regmap *regmap;
> -	struct resource *res;
>   	void __iomem *base;
>   	int ret;
>   
> @@ -417,8 +416,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>   	    !pgc_node)
>   		return 0;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
