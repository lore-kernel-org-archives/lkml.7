Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861B3205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKu/7y4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLWPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:46:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53821 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLWPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:46:53 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so7618268pjc.3;
        Mon, 23 Dec 2019 07:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9q4Qa+3dR5izkjY49fumDCLPkPXgq/tKTsRV9qz0S84=;
        b=YKu/7y4WgHJkHt1yzJt3Ev2jp1cfNULuFfThl0N+6Lm/2sLUL2HbiA3oBq6V5dl/JX
         qNV8n3utnhBwV6OImR02VvF4JKBdlTCl9D2OSLQ6C4XYfEspK4QjplttKsRUNJuytdEM
         JPbvSS5fZXG9Ze/T3C129EwKYKJym1UeLj7L/nf92xkcTzEb6Tmbw3Qeu3ggved0c8fv
         fNkxgCgks950qWhxa/HFfR1Yn4+rp2yx3LlFu5LhERupr5YUHtlRY4toDGvqiWwK13mk
         NjQDIsgA7JfCwJcy5U1E0cvUTaW9v1DfkQ2HSa6VcR/qspsXRl+WAkV0kYk4YusPlPqd
         CV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9q4Qa+3dR5izkjY49fumDCLPkPXgq/tKTsRV9qz0S84=;
        b=HIUozIyy9N52CIvqixKIVdzNtKq4yxmaUJYak/mD0I+rASxxFy/wZjgPNUU93FBjqk
         /Q45lEf0SDeIBjy7/+zSJ30bsuT+BKPlKQGAK64ultS1YnpWU4EGGrJDgLYAQR46hEy5
         YEj/vaTuu6apAe51sAlCtoweSOzk4WH5Iv4pqcZt4s0XksfE/cAdHunq0Ik3c5Aq7XO+
         LOuHZm+e/eJyeK6XqfQdgCGQKXyjUqV/WdlmF3XgS84qGwd6KeV6qGy+4TvrLjLZOJYE
         0pVZDZKh9JxWdvZHvggd91vYTuHT097h6FoJBGAeB05rmMM/PBvJ1F+V6GjfSsZz/RlT
         vZFg==
X-Gm-Message-State: APjAAAVx1LCxaKp3YpkFKdNTF4BLEUL1w4NLGBN98F7jnSAXHFF9MK0b
        ZcoiS5jiz5yhKM/Vzs+ai32GSydv
X-Google-Smtp-Source: APXvYqz3t8Gx3zLKmx9tay6TK1Vxg62MFuznpIoi3itolHAXVqfHyXGjpWSwC8UWoIBhzumtqdFX3w==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr31113821plx.239.1577116012538;
        Mon, 23 Dec 2019 07:46:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k23sm21829545pgg.7.2019.12.23.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:46:51 -0800 (PST)
Subject: Re: [PATCH 16/37] watchdog: intel-mid_wdt: Convert to use new SCU IPC
 API
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-17-mika.westerberg@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0a488bbc-e101-0479-2968-1fb9acef69fc@roeck-us.net>
Date:   Mon, 23 Dec 2019 07:46:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223141716.13727-17-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/19 6:16 AM, Mika Westerberg wrote:
> This converts the Intel MID watchdog driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.
> 
> While there drop useless print at the end of probe.

If you say that you drop the statement you should actually do so.

Guenter

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/watchdog/intel-mid_wdt.c | 53 ++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 470213abfd3d..1ae03b64ef8b 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -33,14 +33,24 @@ enum {
>   	SCU_WATCHDOG_KEEPALIVE,
>   };
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
>   {
> -	return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, NULL, 0);
> +	struct intel_scu_ipc_dev *scu = mid->scu;
> +
> +	return intel_scu_ipc_dev_command_with_size(scu, IPC_WATCHDOG, sub, in,
> +						   inlen, size, NULL, 0);
>   }
>   
>   static int wdt_start(struct watchdog_device *wd)
>   {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>   	int ret, in_size;
>   	int timeout = wd->timeout;
>   	struct ipc_wd_start {
> @@ -49,38 +59,41 @@ static int wdt_start(struct watchdog_device *wd)
>   	} ipc_wd_start = { timeout - MID_WDT_PRETIMEOUT, timeout };
>   
>   	/*
> -	 * SCU expects the input size for watchdog IPC to
> -	 * be based on 4 bytes
> +	 * SCU expects the input size for watchdog IPC to be 2 which is the
> +	 * size of the structure in dwords. SCU IPC normally takes bytes
> +	 * but this is a special case where we specify size to be different
> +	 * than inlen.
>   	 */
>   	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
>   
> -	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
> +	ret = wdt_command(mid, SCU_WATCHDOG_START, &ipc_wd_start,
> +			  sizeof(ipc_wd_start), in_size);
>   	if (ret)
> -		dev_crit(dev, "error starting watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "error starting watchdog: %d\n", ret);
>   
>   	return ret;
>   }
>   
>   static int wdt_ping(struct watchdog_device *wd)
>   {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>   	int ret;
>   
> -	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_KEEPALIVE, NULL, 0, 0);
>   	if (ret)
> -		dev_crit(dev, "Error executing keepalive: %d\n", ret);
> +		dev_crit(mid->dev, "Error executing keepalive: %d\n", ret);
>   
>   	return ret;
>   }
>   
>   static int wdt_stop(struct watchdog_device *wd)
>   {
> -	struct device *dev = watchdog_get_drvdata(wd);
> +	struct mid_wdt *mid = watchdog_get_drvdata(wd);
>   	int ret;
>   
> -	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
> +	ret = wdt_command(mid, SCU_WATCHDOG_STOP, NULL, 0, 0);
>   	if (ret)
> -		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
> +		dev_crit(mid->dev, "Error stopping watchdog: %d\n", ret);
>   
>   	return ret;
>   }
> @@ -110,6 +123,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct watchdog_device *wdt_dev;
>   	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
> +	struct mid_wdt *mid;
>   	int ret;
>   
>   	if (!pdata) {
> @@ -123,10 +137,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
>   			return ret;
>   	}
>   
> -	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
> -	if (!wdt_dev)
> +	mid = devm_kzalloc(dev, sizeof(*mid), GFP_KERNEL);
> +	if (!mid)
>   		return -ENOMEM;
>   
> +	mid->dev = dev;
> +	wdt_dev = &mid->wd;
> +
>   	wdt_dev->info = &mid_wdt_info;
>   	wdt_dev->ops = &mid_wdt_ops;
>   	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
> @@ -135,7 +152,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>   	wdt_dev->parent = dev;
>   
>   	watchdog_set_nowayout(wdt_dev, WATCHDOG_NOWAYOUT);
> -	watchdog_set_drvdata(wdt_dev, dev);
> +	watchdog_set_drvdata(wdt_dev, mid);
>   
>   	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
>   			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
> @@ -145,6 +162,10 @@ static int mid_wdt_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	mid->scu = devm_intel_scu_ipc_dev_get(dev);
> +	if (!mid->scu)
> +		return -EPROBE_DEFER;
> +
>   	/*
>   	 * The firmware followed by U-Boot leaves the watchdog running
>   	 * with the default threshold which may vary. When we get here
> 

