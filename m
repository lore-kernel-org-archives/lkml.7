Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714EDC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41597214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PoQ9OMzC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WMqwFLFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfDAIAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:00:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbfDAIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:00:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DCF746177C; Mon,  1 Apr 2019 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105641;
        bh=zZaH69SjJucQsrQOpi6i2XzK4ey3yx7Zs6Fjpp6p1vs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PoQ9OMzChuVCiMlR5WTDYr/+maWXA5MOCBAykf5cqw4Pgzi7Dkmf7sgytzU77WW1O
         GNSS0hEWmBbQTEVF+obx7TPWVejfMtkd9qwQRAxNWmZFdcCpLM5JzZtciJpXdIIkHe
         KHalesC0JZVvIOeDZNWi6MNGYec6L9uKETZEaOew=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A9726079C;
        Mon,  1 Apr 2019 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105628;
        bh=zZaH69SjJucQsrQOpi6i2XzK4ey3yx7Zs6Fjpp6p1vs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WMqwFLFFq0p4Pv02DYVvvjmeThibtD+phkYrEdDVAqbhH+8c9MbOHMLCbxgSWzsns
         2aqjGyWWTUyiYNoIY5Tl40y5GXXqNhK/Wx2f+s+qURdVxGfpM6I3j+oPnZAkZcYRET
         1Gdp5s/YdmxhiCgieGldiu65d2co7l706wvPIoOU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A9726079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4d10cb49-baf0-dc59-6df2-62174bb06931@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:30:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:54 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/pwm/pwm-imx27.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 8061306..434a351 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -291,7 +291,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
>   static int pwm_imx27_probe(struct platform_device *pdev)
>   {
>   	struct pwm_imx27_chip *imx;
> -	struct resource *r;
>   
>   	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>   	if (imx == NULL)
> @@ -326,8 +325,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>   	imx->chip.of_xlate = of_pwm_xlate_with_flags;
>   	imx->chip.of_pwm_n_cells = 3;
>   
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> +	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(imx->mmio_base))
>   		return PTR_ERR(imx->mmio_base);
>   
