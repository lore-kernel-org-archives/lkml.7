Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033E22084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CldEs/yU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iDEMe4as"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfDAIMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:12:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731902AbfDAIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:12:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C79E60DA8; Mon,  1 Apr 2019 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106327;
        bh=FaHGyGl3W2YvcEUnISFXJW+U2HCmMNd4ejcl5rJCRho=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CldEs/yUFC2TzdBfNFHKF7aejCaR+aG1cSkqmOTmw5/ySInus4iIyUtD33MNYPN0C
         JkCUwxkD8GcsMWk3BK25q62tMwPbE5X80dVWcEvUH9sS51KPn9NjHTBQN0dWAUNAW2
         bDNCapUI5zOBsF262aZOONo/MbGHNDn1elCNU9Dk=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 757A660736;
        Mon,  1 Apr 2019 08:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106324;
        bh=FaHGyGl3W2YvcEUnISFXJW+U2HCmMNd4ejcl5rJCRho=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iDEMe4asaIVlS4hno2zVWHs3ZcLr0veUv+B7MFa0NuLsQREUAFD7sY1mFVt6h/HMK
         GVHlB0Ot9ojasDjI4zg03M567yJDsoz5nTGpriW6gv5q19gGFkWYJlLXOSMTK51Qq5
         fLgNx3bDSN6AgIQxWCjRpuD+AOilvtYlBSxmwTnA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 757A660736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] pinctrl: freescale: use devm_platform_ioremap_resource()
 to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554094986-14897-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f1acb40f-bc90-3241-0a6b-f26f6abe4f0c@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:41:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094986-14897-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:37 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/pinctrl/freescale/pinctrl-imx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 188001b..cc6f5cc 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -785,7 +785,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>   	struct pinctrl_desc *imx_pinctrl_desc;
>   	struct device_node *np;
>   	struct imx_pinctrl *ipctl;
> -	struct resource *res;
>   	struct regmap *gpr;
>   	int ret, i;
>   
> @@ -817,8 +816,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>   			ipctl->pin_regs[i].conf_reg = -1;
>   		}
>   
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		ipctl->base = devm_ioremap_resource(&pdev->dev, res);
> +		ipctl->base = devm_platform_ioremap_resource(pdev, 0);
>   		if (IS_ERR(ipctl->base))
>   			return PTR_ERR(ipctl->base);
>   
