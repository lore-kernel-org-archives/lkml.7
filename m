Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348F213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ltKv/0ct";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CXjbfzrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbfDAIEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:04:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:04:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7910B6137D; Mon,  1 Apr 2019 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105842;
        bh=b0fcVXl/aLBxRo2/tEcBWiP/kRgk/Fv7X54bTiGUte0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ltKv/0ct6LFasHkJIMVTLJMg6uscYZUsCUeGTrw9Hjfnaf2AerYc2YG8vkfLz7fHh
         kLA6pXi+uFAJL21sMqrzx1WF4BTLnN42s4puotGa9CjbwJbHLp49wYN74fRVeGgvtG
         EWnnlJU4bfy8Zz68iQUpTXz6PWazF9F0MiFHUc20=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF5DB61195;
        Mon,  1 Apr 2019 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105841;
        bh=b0fcVXl/aLBxRo2/tEcBWiP/kRgk/Fv7X54bTiGUte0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CXjbfzrDex4FTWSMrbwdvPF9nyjue0JVlvb4QkRyX/e7M8iNCddyVFsdYlxatj+mH
         h9S1tA/kXD0BavEkto99Hww6vX+mylV6Y9MBD5EFINaRf4UdHjgjYfnne3wF2HQjrv
         +xlFq/t1foUdoqbCUM7vY7edmxqNhN+nXco9BPwE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF5DB61195
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6a34a412-50f4-2380-c9ee-1fbb9ac19d52@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:33:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:45 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/mailbox/imx-mailbox.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 85fc5b5..25be8bb 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -264,7 +264,6 @@ static int imx_mu_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct resource *iomem;
>   	struct imx_mu_priv *priv;
>   	unsigned int i;
>   	int ret;
> @@ -275,8 +274,7 @@ static int imx_mu_probe(struct platform_device *pdev)
>   
>   	priv->dev = dev;
>   
> -	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(&pdev->dev, iomem);
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
