Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964F82084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jfPp0FtT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xzy4MC3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfDAIOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:14:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:14:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E586B61AC0; Mon,  1 Apr 2019 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106480;
        bh=2X/bKbyJUsjiDc+LPAlQvGsZ1hkI2RjvUggvFdaDbKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jfPp0FtTR2eCtlaU8/+5rmeX9/aE4L8k5XhJpQlXfOJabnQS7r112MMqhqB4zWGlE
         GxtEG1hUCEhSHW4iVt3V4S70sl9z9op3YTURok3ovmm9Ju9IADo35CcPXO7koHiBVB
         puI4IG1agjpY5Bcy2pwSIupkeV0sba1aqLKcqbnc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 379D061ABB;
        Mon,  1 Apr 2019 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106472;
        bh=2X/bKbyJUsjiDc+LPAlQvGsZ1hkI2RjvUggvFdaDbKw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xzy4MC3qRAvdiYOxSrMITBqQ6TDn3nHS2NIZe0/s3NHkr6ZXvNImzmYN3bbzeQzi/
         iapmmfCsiPKyWkBVYWa0o1ezCajc6eH2YpHSIrBNhaF5borgduGAHAcySTsinlBxIZ
         +tArmYZQVAlX7mH6E1X+oY19+TnNEHtixpp9TXUs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 379D061ABB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 3/3] nvmem: imx-iim: use devm_platform_ioremap_resource()
 to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
 <1554094479-14596-3-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <38642905-7084-0395-54a6-f76507badfcf@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:44:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094479-14596-3-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:29 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/nvmem/imx-iim.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
> index 6651e4c..3458229 100644
> --- a/drivers/nvmem/imx-iim.c
> +++ b/drivers/nvmem/imx-iim.c
> @@ -104,7 +104,6 @@ static int imx_iim_probe(struct platform_device *pdev)
>   {
>   	const struct of_device_id *of_id;
>   	struct device *dev = &pdev->dev;
> -	struct resource *res;
>   	struct iim_priv *iim;
>   	struct nvmem_device *nvmem;
>   	struct nvmem_config cfg = {};
> @@ -114,8 +113,7 @@ static int imx_iim_probe(struct platform_device *pdev)
>   	if (!iim)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	iim->base = devm_ioremap_resource(dev, res);
> +	iim->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(iim->base))
>   		return PTR_ERR(iim->base);
>   
