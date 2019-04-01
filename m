Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D46213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G+yZ2Gdw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hsmom+Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfDAHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:49:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:49:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02860611CE; Mon,  1 Apr 2019 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104961;
        bh=gUstZ7fbGG7ynTYbBk1Rblh0RK+j6KCLDnxzoMeQyhg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G+yZ2Gdw/eeKCrqp4x+KNM1nYutcquwpJOdxCWJKFWxybdMJAnDYNUubYXGTP9gXV
         Pm8zc9tAP0fI/jtPXPpH64sf74tH9L/3nY5cEjBE21WAAtH2GSjSTMHyTWQoc64q5U
         yvgUcGYuKV42IL0tROClkJQbAT5NyNLGFno1aynw=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 725E8609F3;
        Mon,  1 Apr 2019 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104956;
        bh=gUstZ7fbGG7ynTYbBk1Rblh0RK+j6KCLDnxzoMeQyhg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hsmom+YwnOzH6ma4OfpUzQIkUYWU111vdhgL+cgTPHUFbGokt3wyN0Q4sJKvJRUTD
         o/IHqsluaeXLdtbhvgnd5wJ/rdwm4XB8Fk9qsYbE8WisQzcYX7FHD6i5a9BCjZtrMI
         Kgh1c+Sz9POdaHhLfrUnyo4QESgyAoZgHKC2HZK8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 725E8609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/2] soc: imx: gpcv2: use devm_platform_ioremap_resource()
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
 <1554098543-5036-2-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9374e771-4132-6183-fdfa-e227aedfdbbd@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:19:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554098543-5036-2-git-send-email-Anson.Huang@nxp.com>
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
>   drivers/soc/imx/gpcv2.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index e06bf12..31b8d00 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -563,7 +563,6 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *pgc_np, *np;
>   	struct regmap *regmap;
> -	struct resource *res;
>   	void __iomem *base;
>   	int ret;
>   
> @@ -573,8 +572,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	res  = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
