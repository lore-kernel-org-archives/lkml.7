Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7FC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB06206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdJqJUsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395258AbfIFRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:40:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43121 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395246AbfIFRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:40:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so4946015pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MfCXIWDrpRrIriQFkPuCrRIpoDg39/Cf7VVZfh46qUc=;
        b=hdJqJUszQQn+ajXd2PrZfxyi5LbMQihuZ50MvukpOd+LzCUTPJP9dGHhH6VDFdcRrm
         Xrhpu3jdtN+5bN7/JvDZ4lhirkXorw6B+/ckB4Co8+SB38myvZ/CNAxY96c8Qo7tv4kv
         VrTPT9702GhbvlfFRZCd85xLXRjc66VixEFlSvumySCdwzf3YgSdGuX5C+7dgoZZ0531
         7MogIfba8KGX1sY/X3P6FKM6OUJL3x1GMIdOX2V9ukemcxbxjR97QxekTRb89RebIoku
         X86XQejDTsS6bU6ORUq3oG9yEmxbIQRXe0wM9JRyCb0e5z6ZTR9O5K5UJQRiGeWNdxn8
         Avkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MfCXIWDrpRrIriQFkPuCrRIpoDg39/Cf7VVZfh46qUc=;
        b=DeniokJfnOom7KKpVZ7O3Ks/wpSppCdOWkhmWxAJsxQKSNJ+6YvdaiY6dD5kyPqwnY
         P9K7o8BYcO6+Q0iCg6/Ot+AjCJD4biwsvCSoA6Pgj29p6CxyGwKQZ7/hU72EX2NjGv2U
         ofYsGwl51Bk9DCb6Hf5lgpzDw3SLUh3GG1Y0ceVQh/A+BVc+HjpsPTdnLbX9JNviUefi
         466ev5LBtQrHlPmZ6njVi13NEdkLEe8KWA80EvIlRAhpluNsIOM3B3VSAnZWf2iuuPYc
         o6+wjoeHWrLWyOWZc7n4G4dD+AklbvfX1o5mjY+fKz4Eu2UAKreMuWT9EmTIRIcAlTPy
         lEOg==
X-Gm-Message-State: APjAAAXM72O+gV1vIT+Jx6p7cG+ygOVKCkJ485r3+4//WAc7J6r/YPh4
        Utpd4aBNKuvqtuO5aGYkbB5X2g==
X-Google-Smtp-Source: APXvYqz/8Z9L2H/2FlGwEuB8X/tjQCDU7fWFesi6wqW3WdFldl6CMEl0wgd9zpi+HzqrcXCC40NXjQ==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr8851432pgc.20.1567791612525;
        Fri, 06 Sep 2019 10:40:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h4sm7107891pfg.159.2019.09.06.10.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 10:40:11 -0700 (PDT)
Date:   Fri, 6 Sep 2019 10:40:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, linux@roeck-us.net, wim@linux-watchdog.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: qcom: support pre-timeout when the bark irq
 is available
Message-ID: <20190906174009.GC11938@tuxbook-pro>
References: <20190905210035.9985-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905210035.9985-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Sep 14:00 PDT 2019, Jorge Ramirez-Ortiz wrote:
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
[..]
> +static inline int qcom_get_enable(struct watchdog_device *wdd)
> +{
> +	int enable = QCOM_WDT_ENABLE;
> +
> +	if (wdd->info->options & WDIOF_PRETIMEOUT)
> +		enable |= QCOM_WDT_ENABLE_IRQ;

Looking at downstream they conditionally write 3 to WDT_EN during
initialization, but during suspend/resume they just set it to back to 1.

So I don't think you should touch BIT(1) (which name doesn't match
downstream or the register documentation)

> +
> +	return enable;
> +}
> +
> +static irqreturn_t qcom_wdt_isr(int irq, void *arg)
> +{
> +	struct watchdog_device *wdd = arg;
> +
> +	watchdog_notify_pretimeout(wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> +	unsigned int bark = wdd->timeout;
> +
> +	if (wdd->pretimeout)
> +		bark = bark - wdd->pretimeout;

As Guenter points out, writing wdd->timeout - wdt->pretimeout to
WDT_BARK_TIME unconditionally should do the trick.

>  
>  	writel(0, wdt_addr(wdt, WDT_EN));
>  	writel(1, wdt_addr(wdt, WDT_RST));
> -	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
> +	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
>  	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> -	writel(1, wdt_addr(wdt, WDT_EN));
> +	writel(qcom_get_enable(wdd), wdt_addr(wdt, WDT_EN));
>  	return 0;
>  }
[..]
> @@ -204,7 +248,17 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	wdt->wdd.info = &qcom_wdt_info;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq > 0) {
> +		if (devm_request_irq(dev, irq, qcom_wdt_isr,
> +				     IRQF_TRIGGER_RISING, "wdt_bark",
> +				     &wdt->wdd))

A failure here means that a irq was specified in DT (platform_get_irq()
returned > 0) but you failed to acquire request it, you should fail your
probe() when this happens.

> +			irq = 0;
> +	} else if (irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Some {} around this block please.

Regards,
Bjorn

> +
> +	wdt->wdd.info = irq > 0 ? &qcom_wdt_pt_info : &qcom_wdt_info;
> +	wdt->wdd.pretimeout = irq > 0 ? 1 : 0;
>  	wdt->wdd.ops = &qcom_wdt_ops;
>  	wdt->wdd.min_timeout = 1;
>  	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
> -- 
> 2.23.0
> 
