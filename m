Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E8FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5772189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2V5yl56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfH1PF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:05:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39191 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1PFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:05:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so1621662pgi.6;
        Wed, 28 Aug 2019 08:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oT6JHQLY2bffi/RBYzy1DC4j9md0DkvSeKobvsL7S6I=;
        b=b2V5yl56Br0rzlMxOh8a2JL6Q3YHC7a+2eceZeZ5iSIXeTSdtWLVKi60tN4ZD1l/Nw
         Krivg6Xad6xKXQAVI+OSwIpL8i+ZKZStBOgLI3JiWB3rJqJO9EqokRgzkpsa082DAdWL
         a0YbJ7qe7ONQm+dz6OwURGdPXBeeDe7XpoM0ISj46E2YQInSJek+SXjOqcEfAneEaqOI
         Ni1uXbAtBHF4AqPi61uaOrhotRsqkWXG/8+z4gOnpEVnh6hsfuw1QLo+eqEG+C+BmKOE
         bL80idkIvD5wlg87m2s4wwPWpt7yOgctNLUEPzMaEnaBL07t3vJSN7BDG5y+pPeA0GhA
         bJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oT6JHQLY2bffi/RBYzy1DC4j9md0DkvSeKobvsL7S6I=;
        b=JDanV17tD7CxeTSNCBDZrkQkVCVB+XuZVMPe01bMZi7YjEeEUePQPKenCSlUjFJZse
         RaoZ1RT42tZFexnQjVjXX/SGrzPMTNqbRgzwkpq8YjFHl+PPE9Xq7lv7CNeF1QWA2qjz
         GSjKG24iB8Cj/tjRxPXNrktViVqY2XWSi9zet8K8As3IQ3UMRM+KVMqMNijEFwixMBez
         0wPFi79GUUfVuYzkbq+YcuRUU5vXo0xPjNvHyGANssuT6Ohfo6Sc6WTfTVboz7bgiYWg
         1bvyRAa7N19kt8gNg/IOUbG4kuG232XkPI0WHwXoU2AO6Oz3JeBZ9E9/t7gPRLrwcUJV
         5NaA==
X-Gm-Message-State: APjAAAUzAE14pM+ssVaeD7CUBawNPorYfjg/7IskB7KQVn7hxAAaMuMJ
        29II3OtHwuBcW83/n9zujJM=
X-Google-Smtp-Source: APXvYqy0pQWuSH+y/3S9KH2yu5f5undYzAePy+CL4gYdsrM0Cj6LIR0/bgA+F/eftp9a5nXjs63f4Q==
X-Received: by 2002:a17:90a:256d:: with SMTP id j100mr4691011pje.126.1567004724572;
        Wed, 28 Aug 2019 08:05:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 4sm4363397pfe.76.2019.08.28.08.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:05:23 -0700 (PDT)
Date:   Wed, 28 Aug 2019 08:05:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Use platform_get_irq_optional()
Message-ID: <20190828150522.GA21494@roeck-us.net>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
 <20190828083411.2496-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828083411.2496-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:34:11AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The PWM fan interrupt is optional, so we don't want an error message in
> the kernel log if it wasn't specified.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume that Greg will pick up this patch.

Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 54c0ff00d67f..42ffd2e5182d 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -304,7 +304,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ctx);
>  
> -	ctx->irq = platform_get_irq(pdev, 0);
> +	ctx->irq = platform_get_irq_optional(pdev, 0);
>  	if (ctx->irq == -EPROBE_DEFER)
>  		return ctx->irq;
>  
> -- 
> 2.22.0
> 
