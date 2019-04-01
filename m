Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48822C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BAB20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ActcYOKr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VbYCEs4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfDAILX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:11:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDAILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:11:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0794461214; Mon,  1 Apr 2019 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106282;
        bh=dW3wCitEOoMta1HJDa72MNfigZmGJOICNenyg0h17Bg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ActcYOKrV5Q/p7RpXAq4HLdtxV0OaW7CR1OK01QRXvXS1TXuYmI4iGtMtudPka1Ja
         QVgKVb0SW7/+SI7o6dANv/eWsIuh5HNXuHDrD9gX9wTevFWBQk7ksJ3HVFMUSGKwNH
         BMA+/5fF//dKbhnmj26M8odMXT/PuIp3mLKBcles=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57F7160AE0;
        Mon,  1 Apr 2019 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106281;
        bh=dW3wCitEOoMta1HJDa72MNfigZmGJOICNenyg0h17Bg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VbYCEs4SLF/GBNSUdoWTSExUPB5QuNwZH9DFVSQuITNsSbtE9+rS8VN9WhdizSyVJ
         oax0a+pEMxm0c90gQBmwbD6RfyErLzDNtwRq+wdQ+cwW+eXobZncURgyMrOzxi7XS9
         LfEaFpn4z9DoyHgnwLgJVK5BnYlwwHKt4NZxRT4A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57F7160AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] gpio: mxc: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554095107-15003-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ce7c8e36-39d0-efef-eb0c-d403d8eb8801@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:41:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554095107-15003-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:39 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/gpio/gpio-mxc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index e86e61d..b281358 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -411,7 +411,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	struct mxc_gpio_port *port;
> -	struct resource *iores;
>   	int irq_base;
>   	int err;
>   
> @@ -423,8 +422,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
>   
>   	port->dev = &pdev->dev;
>   
> -	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	port->base = devm_ioremap_resource(&pdev->dev, iores);
> +	port->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(port->base))
>   		return PTR_ERR(port->base);
>   
