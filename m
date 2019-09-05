Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7ABC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819112082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSExCENs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbfIEQjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:39:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43269 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733199AbfIEQjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:39:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so1696994pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/krqdhGD0b6agttkrmWKeFBfqNen0JM8FWwtqdjs3cw=;
        b=tSExCENsTht85O8+DTFmEOMOf0lhykiTB50x1SrFCcWywLzJJMuri6kj+B18Yh3XT8
         HvU3rNZbNG1gaptUFVAM7Cl+8BlxJjVQZPeL7ELsPlCfdO/AGDBZogvmirnvjtAo29pF
         oXS3z5ti5J7IQ7R6RfXbpGdY6uiBEvt7ekKLUoaq+5hVGFnrWyJtYwaM/+Rf+yopeKY6
         G8FayBlMQR+NZJAnupwcXIBYvtHQECE/aLUMI7AD3/pbHcXO1mV36KS0danTAi2HbHPm
         Uenrs3oL6hWLm5mXiOFNKzTWGKDXK+6cvv5HLb9upEiwUTXEzA8XR9WFxkTwYqQimeYd
         dI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/krqdhGD0b6agttkrmWKeFBfqNen0JM8FWwtqdjs3cw=;
        b=gAdTerXEccUCR+IpiAnvuz40X7uqh+ZCXOaZymTvqKASjoTcbqnjm3uxRCrpk+wqfY
         GUAjM/7G+R3N0fEwIIyoSB35j7s7xao9VvvX9cTfC7jgOwovQRvzzrdsayQCvD9EqIPj
         Obgzgmz5RXvaeSfc7BUQHbfAIsXubA2UsQsauZNLs2SENh+h3jc6u1bjswpUWZ8pFaRS
         Q+Dz+vBy0m5tQCG5aVoBB0EQqOWaekHSny+7e6AeaThAIbn5nLL4lMM/8GzycG19bBJ7
         QqdA6E3mfbGeLPOfP0TFKulGKRrePCdZ6KgVbePbDlqwMusLgxAdz3wdNQoXyYR0uRU8
         LHew==
X-Gm-Message-State: APjAAAVj+v1CTOatSJy9P6cgvcVy2XDmuGAtRgmPTkeviYFssmZS+Yfu
        gd/+U5JJtOxM19yXyKNbUHA4ZA==
X-Google-Smtp-Source: APXvYqz3JIi6hfNGmKeMxI2SJp+cUc+piVJoCHvTLymB3aYHUilJmjuRyQXtrGGhLtIMbxXimYtjmA==
X-Received: by 2002:a63:e148:: with SMTP id h8mr4021185pgk.275.1567701562585;
        Thu, 05 Sep 2019 09:39:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j128sm6992208pfg.51.2019.09.05.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:39:21 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:39:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     agross@kernel.org, wim@linux-watchdog.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: qcom: add support for the bark interrupt
Message-ID: <20190905163919.GA1676@tuxbook-pro>
References: <20190905162135.2618-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905162135.2618-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Sep 09:21 PDT 2019, Jorge Ramirez-Ortiz wrote:

> Use the bark interrupt to notify the bark event. Since the bark and bite
> timeouts are identical, increase the bite timeout by one second so
> that the bark event can be logged to the console.
> 

Afaict you should tie the bark to the "pretimeout" in the watchdog
framework , which would allow the user to specify a pretimeout and
configure what should happen at the bark (just a pr_alert() or panic()).

Regards,
Bjorn

> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/watchdog/qcom-wdt.c | 42 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 7be7f87be28f..5eaf92084b93 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -10,6 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  #include <linux/of_device.h>
> +#include <linux/interrupt.h>
>  
>  enum wdt_reg {
>  	WDT_RST,
> @@ -41,6 +42,8 @@ struct qcom_wdt {
>  	unsigned long		rate;
>  	void __iomem		*base;
>  	const u32		*layout;
> +	unsigned int		irq;
> +	const struct device	*dev;
>  };
>  
>  static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
> @@ -54,15 +57,37 @@ struct qcom_wdt *to_qcom_wdt(struct watchdog_device *wdd)
>  	return container_of(wdd, struct qcom_wdt, wdd);
>  }
>  
> +static inline int qcom_wdt_enable(struct qcom_wdt *wdt)
> +{
> +	if (wdt->irq < 0)
> +		return 1;
> +
> +	/* enable timeout with interrupt */
> +	return 3;
> +}
> +
> +static irqreturn_t qcom_wdt_irq(int irq, void *cookie)
> +{
> +	struct qcom_wdt *wdt =  (struct qcom_wdt *) cookie;
> +
> +	dev_warn(wdt->dev, "barking, one second countdown to reset\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> +	unsigned int bark, bite;
> +
> +	bark = wdd->timeout;
> +	bite = wdt->irq < 0 ? bark : bark + 1;
>  
>  	writel(0, wdt_addr(wdt, WDT_EN));
>  	writel(1, wdt_addr(wdt, WDT_RST));
> -	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
> -	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> -	writel(1, wdt_addr(wdt, WDT_EN));
> +	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
> +	writel(bite * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
> +	writel(qcom_wdt_enable(wdt), wdt_addr(wdt, WDT_EN));
>  	return 0;
>  }
>  
> @@ -210,10 +235,21 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>  	wdt->wdd.parent = dev;
>  	wdt->layout = regs;
> +	wdt->dev = &pdev->dev;
>  
>  	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
>  		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>  
> +	wdt->irq = platform_get_irq(pdev, 0);
> +	if (wdt->irq >= 0) {
> +		ret = devm_request_irq(&pdev->dev, wdt->irq, qcom_wdt_irq,
> +				       IRQF_TRIGGER_RISING, "wdog_bark", wdt);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request irq\n");
> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
>  	 * default, unless the max timeout is less than 30 seconds, then use
> -- 
> 2.23.0
> 
