Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752E720643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VOd6eEyT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QIUwm6gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfDAICX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:02:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfDAICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:02:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59CE06047C; Mon,  1 Apr 2019 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105741;
        bh=PAZnGyKGbIq8AnluGW7W5FxmqvQOyoYzKWKxXCGPhuk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VOd6eEyThB2w/Ep9oQjNaXNL75gDxSLg/z1cF+4z/N3YJqthseG/8aUIQK2Tye47K
         koUUBuRtWv4KAvpczPvgbBK6vlWo5fMHv0WtvcmPMc8LBLGtaiLLB9ia1T8Lcrdck2
         UJH93opfCSUuG4757yHqEEM3wSyTLHL1dTTlB2bc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36CDB60392;
        Mon,  1 Apr 2019 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105739;
        bh=PAZnGyKGbIq8AnluGW7W5FxmqvQOyoYzKWKxXCGPhuk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QIUwm6gu7mZNZacNdwhvXv1hQ6rA7B6qpzGbm/HzYIsFTD4Cn3c9RLrlx8SpfiYuA
         sS0JbZF4dBwmoE4+efYrXjRxrq6/Yf61sazVt9PWg7NGOjXz7ohm3hAkAR8Q1Ia/Y7
         LQd+gp5RPtaC1esqB+nUy1GNwQF7gX973VLNEBJ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36CDB60392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
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
References: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d3b8cf17-36bb-d79d-7d60-76ae2416075d@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:32:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:49 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/input/touchscreen/imx6ul_tsc.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
> index c10fc59..e04eecd 100644
> --- a/drivers/input/touchscreen/imx6ul_tsc.c
> +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> @@ -364,8 +364,6 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
>   	struct device_node *np = pdev->dev.of_node;
>   	struct imx6ul_tsc *tsc;
>   	struct input_dev *input_dev;
> -	struct resource *tsc_mem;
> -	struct resource *adc_mem;
>   	int err;
>   	int tsc_irq;
>   	int adc_irq;
> @@ -403,16 +401,14 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> -	tsc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	tsc->tsc_regs = devm_ioremap_resource(&pdev->dev, tsc_mem);
> +	tsc->tsc_regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(tsc->tsc_regs)) {
>   		err = PTR_ERR(tsc->tsc_regs);
>   		dev_err(&pdev->dev, "failed to remap tsc memory: %d\n", err);
>   		return err;
>   	}
>   
> -	adc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tsc->adc_regs = devm_ioremap_resource(&pdev->dev, adc_mem);
> +	tsc->adc_regs = devm_platform_ioremap_resource(pdev, 1);
>   	if (IS_ERR(tsc->adc_regs)) {
>   		err = PTR_ERR(tsc->adc_regs);
>   		dev_err(&pdev->dev, "failed to remap adc memory: %d\n", err);
