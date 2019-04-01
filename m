Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F7C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DFF213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pJzHuBKl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ddU5XWJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfDAIMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:12:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfDAIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:12:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B2E261947; Mon,  1 Apr 2019 08:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106372;
        bh=5KYfurn/5xQD7uJrc/lL/272OYc1sZHS0EsAVpIrEhE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pJzHuBKlFZBV5LM63OiS77imekHD79/XMKSdWMFOlFylS9omwPzilNOSQ/423qzPu
         TEjFtLupwW7hvOZsQabYPC+NJQWMUu/UkIOgmoZiKm7ruX6plJCgjnE5JGWZTnyY0a
         wWe04hDAGENITNtoJEw7aNpblqNmD2g3yrb5tBKc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10D4061156;
        Mon,  1 Apr 2019 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106367;
        bh=5KYfurn/5xQD7uJrc/lL/272OYc1sZHS0EsAVpIrEhE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ddU5XWJbbY2TQ5KJjTCYXrUjcbWhPihQM1as3dJjwK5DrKbywf1V3oMkMmywLAKHZ
         raeD6PRc5hdtqLNCowh4cQllXmu6NryaVVgbL+0HWCpIOnxR3ni3tvftY410pauG6x
         QxJfl13AOUAxx8rUYCCXlVvYRb/VH9+IDReuN5DI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10D4061156
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] watchdog: imx2_wdt: use devm_platform_ioremap_resource()
 to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554094787-14766-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ca6ff9b3-536f-4a0a-c147-ea3219e732f7@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:42:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094787-14766-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:34 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/watchdog/imx2_wdt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2b52514..1b0faa2 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -247,7 +247,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   {
>   	struct imx2_wdt_device *wdev;
>   	struct watchdog_device *wdog;
> -	struct resource *res;
>   	void __iomem *base;
>   	int ret;
>   	u32 val;
> @@ -256,8 +255,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   	if (!wdev)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
