Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99CF20643
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EezxuOvg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hK9xPeML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfDAIBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:01:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfDAIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:01:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B062611FA; Mon,  1 Apr 2019 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105679;
        bh=pWSrvV+/J97gFvn3dXEV1V4mmotcnZqelBsZoybQjvE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EezxuOvgRcNHwJesO0JPEgQSPXCThB1eB86dc+i3axvTcSkKhYrHq1ztEgZJ3jCs3
         2VNB3HGDwoZeUk31ZYyK59RrivlToBpneTESmDaeiKRcVSstxFoQooF3yuiRpp1wff
         nUc2rsFIl18u3sPGQzyNu/NZ2ANQdRuu5HlttQxs=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F799619F9;
        Mon,  1 Apr 2019 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105672;
        bh=pWSrvV+/J97gFvn3dXEV1V4mmotcnZqelBsZoybQjvE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hK9xPeMLHGWjlSjdQSQPpXHz2qBkU0mimp6tWhNhhZp4UqoSxxg863qLGx97Apara
         FoInfe6ur1fAPzEGuT3DXVHU7JqEq08tWfMVHY6VW8kH7umPqhxR6QHa8Z+fWfQI/1
         olIV9V3EVJjm3AKaThL7VghTbToSeS8wJzg6HkJQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F799619F9
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
Message-ID: <1fae9beb-1dbc-5e62-a39e-57ae5d8e7671@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:31:05 +0530
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
