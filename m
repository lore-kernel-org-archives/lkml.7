Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4067C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4420643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CWwm6QEu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KLOIxtdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbfDAH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:59:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:59:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 133F66086B; Mon,  1 Apr 2019 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105581;
        bh=vsJ4WdJT2ZQrZlnOCKodM05l57aN0m13tWxStHhCL0o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CWwm6QEuKssukn7UO4v0dMtljpGBU83GW4dSRVe/rpCGGq7QmOUIFDN6yMKsf6eUv
         Dk4Ts59XOOJY5gnaH1PZDBUlqplsan7oI6kGyL3vpt/OR/UCUvQpgLVjRoFoNI2kuW
         GOxIDPAXTm369yiGZ6d4thCiM3Rkeo31nDTeINPM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C05460735;
        Mon,  1 Apr 2019 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105578;
        bh=vsJ4WdJT2ZQrZlnOCKodM05l57aN0m13tWxStHhCL0o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KLOIxtdcvWBTxy5W5C+2X4GNyiVlaKNOJiSyuCllAASmmnNjK4GNb6DN3DgCHJaoz
         cKXnCiKtTYLXgAb3cq+zu9HhhsSvF3cAnzdW26azolbVzKyRW70Ej1lYmZg14OLgkF
         TBX4U1Ygy4IG3O78w5L7o2ba/YEgXadt3j25+hfc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C05460735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] input: keyboard: imx: use
 devm_platform_ioremap_resource() to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6214bf1b-6d5f-5c55-6f5d-9f1342722e20@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:29:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:58 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/input/keyboard/imx_keypad.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 539cb67..cf08f4a 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -422,7 +422,6 @@ static int imx_keypad_probe(struct platform_device *pdev)
>   			dev_get_platdata(&pdev->dev);
>   	struct imx_keypad *keypad;
>   	struct input_dev *input_dev;
> -	struct resource *res;
>   	int irq, error, i, row, col;
>   
>   	if (!keymap_data && !pdev->dev.of_node) {
> @@ -455,8 +454,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
>   	timer_setup(&keypad->check_matrix_timer,
>   		    imx_keypad_check_for_events, 0);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
> +	keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(keypad->mmio_base))
>   		return PTR_ERR(keypad->mmio_base);
>   
