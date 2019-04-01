Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4241C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20B02084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cYJid7nz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H6FUDKWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfDAINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:13:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfDAINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:13:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 970966137E; Mon,  1 Apr 2019 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106410;
        bh=IXze6x2h0YcJLm8pPvb+VJ8OR9Ee3n1XaCA+FChqARo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cYJid7nz9yZOClmEm0sVXaXOw27qvNlWsD8yxUvHBOPadnBLqGERfBLIHtb2wuaEo
         aIqF9Tq7fDSLKPiq11Db11RqmJil3zX9d22VzXhdWstubBapXFzsjBavqZdoDaiP5V
         84koe8ioWtBrxHW4nKebAPl7nFf+dUHncjCAffnY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D946C60FEB;
        Mon,  1 Apr 2019 08:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106407;
        bh=IXze6x2h0YcJLm8pPvb+VJ8OR9Ee3n1XaCA+FChqARo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H6FUDKWXic3w14quR9oD06l/oX61A9sFa0IYot24Zht8JLKXRg2b1FX9fKX3a/z4N
         vJ9syRnOU8mYKs4VVIUUb7NqUEEXH7JkN+WRrIXqBC7PHegBowxXnZg8b/JZolxoeX
         rCcEfmWESgIfayKnSC/LYQeaDadeoh8qdR2R63o8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D946C60FEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/3] nvmem: imx-ocotp: use
 devm_platform_ioremap_resource() to simplify code
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
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e81617c9-54f1-e5c9-4e9d-4ab04ca59799@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:43:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
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
>   drivers/nvmem/imx-ocotp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index e0b22b6..4cf7b61 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -467,7 +467,6 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
>   static int imx_ocotp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct resource *res;
>   	struct ocotp_priv *priv;
>   	struct nvmem_device *nvmem;
>   
> @@ -477,8 +476,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
>   
>   	priv->dev = dev;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
