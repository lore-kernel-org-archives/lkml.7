Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC7C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3DD2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ete2voH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDAPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:55:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44513 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:55:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so4771469pfm.11;
        Mon, 01 Apr 2019 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8HkfTU1JwuLA9O2wYXsN3lbEJpYnLLEy7iHqzf5uSM=;
        b=ete2voH8vofQSlolDs/QWXWkfe3snZwEutqGQB8z720CqYpidn9oEHfzXU08BJ8GvN
         q8/9ZUfTky2p605OsydypQ/W4q9n1nF/8poPGawkkXJ0DhwK4Th1Im+aQEqODCSUHXnS
         lkqJa+9AwybP/zSTB45ltXrm7N9FkZFrDufLTxzVjE31Qsu4LKMuvC7sGgvJ6FYYZDbV
         VvsskHospNloFbGRAa2xSHIxEYAbCkTXiQfJC7knzQmZgGfIbQkjzz7oY0kREfUYcEW7
         gadm6isJRJQOVAW6vsi54x27qsG4w45PYpS0eGfeTKKXPdz+k3yy23r21AqLeodObx2a
         +/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8HkfTU1JwuLA9O2wYXsN3lbEJpYnLLEy7iHqzf5uSM=;
        b=CMtQ/BVViHy8uclEQP3ECNTggsjC2TVCDlLWzyw4jEnSUA5XMWfjG/XfSGtVam1nYD
         Uoq9DGy3/IBES6IR7wFKdAiDB7KeCYVwu/G0bsGxl7rXM3idS6psajnxlTnYUun/gNHE
         Fdf4KLE0gnwy0aJ9zS+vIfSmD3mRXKhXwVYg/qXq03ESXjucgWR1m//9JLlt6Ru2KJrO
         0LvCxkN+rT3RDLc/5gkJz5UF8PjhroL3zFTQvWGqif7d6l7wlwzHzERk0cr9uziaoTRP
         6AvmfIFJqvS7aFe62GpDiOD1jGeo39gyS3AdCXDDfpw6V0KN8N3sb8N/BdJT0L/Mn8F9
         polw==
X-Gm-Message-State: APjAAAUqG7MDG+da6PXwbAVwi6BUaguHB7SWeh1lJ8TiUrX0JGtfzYXg
        1vJIHvVtxKKYGM8XRV4Yg0M=
X-Google-Smtp-Source: APXvYqx7itk51q3rQMUI1Bf5B/L7ZRpFFG5WUfbUl7RwshGxtxzUFMtrVMv128tlZxtjI0bbRApMTA==
X-Received: by 2002:a63:1a1b:: with SMTP id a27mr53863298pga.59.1554134131718;
        Mon, 01 Apr 2019 08:55:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i5sm13992971pfd.16.2019.04.01.08.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 08:55:30 -0700 (PDT)
Date:   Mon, 1 Apr 2019 08:55:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20190401155529.GA27316@roeck-us.net>
References: <1554094787-14766-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554094787-14766-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 05:04:30AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/imx2_wdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2b52514..1b0faa2 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -247,7 +247,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
> -	struct resource *res;
>  	void __iomem *base;
>  	int ret;
>  	u32 val;
> @@ -256,8 +255,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>  	if (!wdev)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -- 
> 2.7.4
> 
