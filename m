Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C89C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0464D20700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XeHD7UpR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UurhTr1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfDAHrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:47:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:47:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDCC56086B; Mon,  1 Apr 2019 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104849;
        bh=/4QEz4k9phkMttJnXlNp4FUBjQgpdrY5TwKYjAcGHAc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XeHD7UpRa68v7n2T4OGKV6D8boaA+fVUyaEGOD65ta4KmsaEIIuV7FscaQ+7AA//E
         QLooQHl2zoSMAKRfmkBfvZJ/Y9FNC8Y7FTF/bdiqua6AUrKfDQRsUmRHa+LFYdZq5k
         puUaIOG57kfYxx8WVZp5tNDX2VcXao1B5Z27ockI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10166602F2;
        Mon,  1 Apr 2019 07:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554104848;
        bh=/4QEz4k9phkMttJnXlNp4FUBjQgpdrY5TwKYjAcGHAc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UurhTr1pyw9cxC7bR4cyUWskjTIJMqONmK6xMs5xZnlsMpeFTQXGXiuXaHbn/m2ZE
         WJs7AozywzW9B5zbVqzvdfaLB+pMOY9WuoodL9+LuZQjdluf1TTFFJTY2lo9PwgrWO
         sT44IjN9XSKgqoQw1gQSUa4eraK1Mg18J5MJErLk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10166602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] irqchip/imx-irqsteer: use
 devm_platform_ioremap_resource() to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554099427-5240-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e7f06738-6732-dc08-670d-ab78c985231f@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:17:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554099427-5240-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 11:51 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/irqchip/irq-imx-irqsteer.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 88df3d00..290531e 100644
> --- a/drivers/irqchip/irq-imx-irqsteer.c
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -144,7 +144,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	struct irqsteer_data *data;
> -	struct resource *res;
>   	u32 irqs_num;
>   	int i, ret;
>   
> @@ -152,8 +151,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>   	if (!data)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	data->regs = devm_ioremap_resource(&pdev->dev, res);
> +	data->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(data->regs)) {
>   		dev_err(&pdev->dev, "failed to initialize reg\n");
>   		return PTR_ERR(data->regs);
