Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04023C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB2D2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMqE4TEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgAHPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:37:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41975 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:37:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so1804428pfw.8;
        Wed, 08 Jan 2020 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wy+5js3zItzE+IXXbeD47P8dVoT/DlGMYBOUFxo/F6U=;
        b=lMqE4TEgNDVBlfw96Y2zHwAXzEgQfDR+tKoGRswRrOoTCZ5QcK1b2oNxUVT6ESdR65
         54Cgtyj/I3escskYKCImI+73GI3g0r1Oi0P89GkDvMsgi3PTRbzYQ8IyTXipo+zDkgWp
         jMmAaresu5JBtECYoxsF+RPZa1h5hftriyTc2wMjRwDWmjbEpv1bZSPQT8Dy/36LJQoN
         5zLRIoO+XfdoOxYjTMlOH1Urbj8CuGMyUK1j09uE1M8iVWzv+SeHGpeFJaZ+3fg9xGwC
         /o0sylUt2598r/xd5MAu0+wXbO8Mrh2c1baPhGCz7b7uFBcmY6/EI7TgZipvSYg/prhF
         yxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wy+5js3zItzE+IXXbeD47P8dVoT/DlGMYBOUFxo/F6U=;
        b=iELvG5d6Rk9545HL84rwqs3SvtYnVb2jXLGpMuJ27aQ/N+tYNV0x91xT5iXxLrmOM0
         XFjtKn26hADdL7M6vaB820yacCd8vl3SQtvRpE++z3cO2feQnVzXqaBEntjcpY/lC51t
         PSKB5baqacCirnnTQl2pjhFi0ELgGKRwuFYFqQ4zrUIJlkJkqW93kVNuVaUssMq3XPs3
         F+x9m2UvADbV+tmu/foOSMu7+GE6pxLCCwUM0KnnWg9XTqgkcJcyYFaUwXKCKYZlPV6p
         +bIaxoZlH71BuyvtqN1zPa595LhhFmLpEsL6S6zEcDkaecFzhNC+WxPgoFRAiZ1cqER5
         DTMw==
X-Gm-Message-State: APjAAAW6nnlcWDPdq2bYUu2AxfyH5GxuMfzM6YEKTyLyUU23MO1Yy05N
        a+ZGiCvYTDp87ZmQ+/tX1qQ=
X-Google-Smtp-Source: APXvYqwi6h0/ie8f17s4N/dBQCyRk0wsW47YVhXZJ/+Afy1WdhX+ZOy0D3QpneDpiPS3ang8Z74EZg==
X-Received: by 2002:a63:5d4d:: with SMTP id o13mr5694523pgm.182.1578497838426;
        Wed, 08 Jan 2020 07:37:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r37sm3698843pjb.7.2020.01.08.07.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 07:37:17 -0800 (PST)
Date:   Wed, 8 Jan 2020 07:37:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/36] watchdog: intel-mid_wdt: Convert to use new SCU
 IPC API
Message-ID: <20200108153716.GC28530@roeck-us.net>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-17-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-17-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:41PM +0300, Mika Westerberg wrote:
> This converts the Intel MID watchdog driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 53 ++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 470213abfd3d..1ae03b64ef8b 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -33,14 +33,24 @@ enum {
>  	SCU_WATCHDOG_KEEPALIVE,
>  };
>  
> -static inline int wdt_command(int sub, u32 *in, int inlen)
> +struct mid_wdt {
> +	struct watchdog_device wd;
> +	struct device *dev;
> +	struct intel_scu_ipc_dev *scu;
> +};
> +
> +static inline int
> +wdt_command(struct mid_wdt *mid, int sub, const void *in, size_t inlen, size_t size)
>  {
> -	return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, NULL, 0);
> +	struct intel_scu_ipc_dev *scu = mid->scu;
> +
> +	return intel_scu_ipc_dev_command_with_size(scu, IPC_WATCHDOG, sub, in,
> +						   inlen, size, NULL, 0);
>  }
>  
>  static int wdt_start(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret, in_size;
>  	int timeout = wd->timeout;
>  	struct ipc_wd_start {
> @@ -49,38 +59,41 @@ static int wdt_start(struct watchdog_device *wd)
>  	} ipc_wd_start = { timeout - MID_WDT_PRETIMEOUT, timeout };
>  
>  	/*
> -	 * SCU expects the input size for watchdog IPC to
> -	 * be based on 4 bytes
> +	 * SCU expects the input size for watchdog IPC to be 2 which is the
> +	 * size of the structure in dwords. SCU IPC normally takes bytes
> +	 * but this is a special case where we specify size to be different
> +	 * than inlen.
>  	 */
>  	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
>  
> -	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
> +	ret = wdt_command(mid, SCU_WATCHDOG_START, &ipc_wd_start,
> +			  sizeof(ipc_wd_start), in_size);
>  	if (ret)
> -		dev_crit(dev, "error starting watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "error starting watchdog: %d\n", ret);
>  
>  	return ret;
>  }
>  
>  static int wdt_ping(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret;
>  
> -	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_KEEPALIVE, NULL, 0, 0);
>  	if (ret)
> -		dev_crit(dev, "Error executing keepalive: %d\n", ret);
> +		dev_crit(mid->dev, "Error executing keepalive: %d\n", ret);
>  
>  	return ret;
>  }
>  
>  static int wdt_stop(struct watchdog_device *wd)
>  {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>  	int ret;
>  
> -	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_STOP, NULL, 0, 0);
>  	if (ret)
> -		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "Error stopping watchdog: %d\n", ret);
>  
>  	return ret;
>  }
> @@ -110,6 +123,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct watchdog_device *wdt_dev;
>  	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
> +	struct mid_wdt *mid;
>  	int ret;
>  
>  	if (!pdata) {
> @@ -123,10 +137,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
> -	if (!wdt_dev)
> +	mid = devm_kzalloc(dev, sizeof(*mid), GFP_KERNEL);
> +	if (!mid)
>  		return -ENOMEM;
>  
> +	mid->dev = dev;
> +	wdt_dev = &mid->wd;
> +
>  	wdt_dev->info = &mid_wdt_info;
>  	wdt_dev->ops = &mid_wdt_ops;
>  	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
> @@ -135,7 +152,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  	wdt_dev->parent = dev;
>  
>  	watchdog_set_nowayout(wdt_dev, WATCHDOG_NOWAYOUT);
> -	watchdog_set_drvdata(wdt_dev, dev);
> +	watchdog_set_drvdata(wdt_dev, mid);
>  
>  	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
>  			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
> @@ -145,6 +162,10 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	mid->scu = devm_intel_scu_ipc_dev_get(dev);
> +	if (!mid->scu)
> +		return -EPROBE_DEFER;
> +
>  	/*
>  	 * The firmware followed by U-Boot leaves the watchdog running
>  	 * with the default threshold which may vary. When we get here
> -- 
> 2.24.1
> 
