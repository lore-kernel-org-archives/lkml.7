Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B74C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D748206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSD0dC7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHAX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:23:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45275 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgAHAX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:23:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so355776pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 16:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2HOzMvjxdFAsvUsSS+tExn/1UWmQ2RTmwasyLm3xDA=;
        b=lSD0dC7TynpLCyKcWcI0d9v50j5OB5dWI9PLu9bJy7OzWIQjYqdJSSpEd+oVjL3EGi
         1cZTnRozZ7dORB/nGbB39FRX8jT5xABZzflR3ShG+rTyz04PysdQ3vpYmQFiTZXuvBuK
         NJQi+OsL7J5d4j0yGTLrTlDKXKVKQ/cP0r3H01ihbvQKJ/Qdq56O0yNjP2pvS+BqB9FC
         5QGxJ1XSWyCm5jsgUSHKv8K7vEJ2S/PfbjRL9/GTWacQ0QWRoM7tmrZFwetx/dUkfjwj
         bFozlY2VpofbXcSWUS+p+fm4B0Asi8n7o2vyb+gkVH1g57/NqDt9k8FAvwOyHxvapo3p
         cVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2HOzMvjxdFAsvUsSS+tExn/1UWmQ2RTmwasyLm3xDA=;
        b=Cm38OLCZkl1Gaz0RHMZtPrRclQRnDzvCJ+Tgsfy0+PfQ8Ya40WAdZ5AU8LTUpiyrF2
         VrO5EhR4e8S+V9v9xjVCevyCXK+N4QhAUs6GA7X9OsSmUYHyDRYcnvJNk8sNTQmBIMvs
         eW9sfRAUi6PqPNZu6aJYEZe+0aJv8ZFRBZnUy2vI2YQ+8H7oRq7wc9dmzdLLXaPV0c5f
         t54WnWgoEGO3bN6J1ojq8WignkyTTD20HwVLSIcfZcqtsJ4KvMf4qm9JKlxNemiVzl1B
         yIkV0S438f14H4nCenEOXmBLWwHdn9rz1Dw3yBkF2li0AGkiMy3TTtKaBKLrpjIILVH0
         QkyA==
X-Gm-Message-State: APjAAAWeED8z0SkJYfz4oW9hjwSnhvyD214l6W0c9Wt1MMMaWRHGwEaZ
        D+1B168wQWfnyHp15viSFu5now==
X-Google-Smtp-Source: APXvYqzNIK+9fJX/YJEuWjM1jbn4YuVngrzbIWPpjqvInkb6uIHo4CQh6EHYpX3xwgsCj0eYDJFvYA==
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr1404087pjz.56.1578443006434;
        Tue, 07 Jan 2020 16:23:26 -0800 (PST)
Received: from yoga ([2607:fb90:2847:68b5:4ce0:3dff:fe1c:88ba])
        by smtp.gmail.com with ESMTPSA id x197sm769495pfc.1.2020.01.07.16.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:23:25 -0800 (PST)
Date:   Tue, 7 Jan 2020 16:23:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3] reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be
 a tristate
Message-ID: <20200108002311.GG738324@yoga>
References: <20200108001913.28485-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108001913.28485-1-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 16:19 PST 2020, John Stultz wrote:

> Allow CONFIG_RESET_QCOM_AOSS to be set as as =m to allow for the
> driver to be loaded from a modules.
> 
> Also replaces the builtin_platform_driver() line with
> module_platform_driver() and adds a MODULE_DEVICE_TABLE() entry.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> v2: Fix builtin_platform_driver line in driver code
> v3: Add MODULE_DEVICE_TABLE() as suggested by Bjorn
> ---
>  drivers/reset/Kconfig           | 2 +-
>  drivers/reset/reset-qcom-aoss.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3ad7817ce1f0..45e70524af36 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,7 +99,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_QCOM_AOSS
> -	bool "Qcom AOSS Reset Driver"
> +	tristate "Qcom AOSS Reset Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  This enables the AOSS (always on subsystem) reset driver
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
> index 36db96750450..9333b923dda0 100644
> --- a/drivers/reset/reset-qcom-aoss.c
> +++ b/drivers/reset/reset-qcom-aoss.c
> @@ -118,6 +118,7 @@ static const struct of_device_id qcom_aoss_reset_of_match[] = {
>  	{ .compatible = "qcom,sdm845-aoss-cc", .data = &sdm845_aoss_desc },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, qcom_aoss_reset_of_match);
>  
>  static struct platform_driver qcom_aoss_reset_driver = {
>  	.probe = qcom_aoss_reset_probe,
> @@ -127,7 +128,7 @@ static struct platform_driver qcom_aoss_reset_driver = {
>  	},
>  };
>  
> -builtin_platform_driver(qcom_aoss_reset_driver);
> +module_platform_driver(qcom_aoss_reset_driver);
>  
>  MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
