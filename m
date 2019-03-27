Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F1C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF662146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGyg7HQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfC0Rcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:32:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34236 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfC0Rcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:32:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so10293681pgq.1;
        Wed, 27 Mar 2019 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2w0GVPkq96+VGwbnSZt6SJKIz1CPqDIVXcS3isgzuo=;
        b=qGyg7HQWh6WncLYFIwMySycS2BygxFEPbGBWQlgYfbAhfUsOcy4dzKA9+uvLloUncg
         CVIiCZ05WuL/aEXv2zqh1xd7sF4bOs9cEjWc8G7sRVAgL2LZ54eknMGLRGnm9Ylzvl6K
         /iS5rSkwN410eo8CfI9Qw706QXF/49J/K/2uPl7RbqZSL3KeCZeVBEdHyC3jLB8KlT24
         j8ut+ksLPP/n4PDIO4Xv0wd6iVz7D2eyLZuHIao5b1CwNxWtxIXOOwKOxBKv4DlofC5i
         9XQ/ygVMvmBmT4Yy7Jwg1cw7THroWEU1tNu5FYF2XdarpjMX6NYqY/yPZqfnJtHYZabi
         Xu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2w0GVPkq96+VGwbnSZt6SJKIz1CPqDIVXcS3isgzuo=;
        b=BMulb3lnk/a0PA+rQWVdF8n4xEKLKbNUrB1xTBtYpujOrAj4hJFOe0zwyVPVK0uBSS
         +vmOGrRpH18ili1qGmn28xNKmnKirLwu4Qyt/YbzGH7XDU9HfSPVDqF57rxj98Z5DDl+
         VB6gUPNF3v555hHOEfyVflfl5hU+q+UYVuwjxJfNW9jNPdlnYwC1M2f/dhRNcDwSrV8o
         4kkZozAJNpUwqTnWaJ1QpBjTm//w168ylTipi8Y3iLpwmi0ZfduzkGbFrBgohHnUt1sm
         vYJrsHHUSHiFnmtX9XrssDUdl0n9pa3UyD8TCRi5qvw24z8Jqw0s7ssNSHN7g7/8lEI6
         P57Q==
X-Gm-Message-State: APjAAAXBu5CLmsrKbihn+cEZ+g+kknBHNYEhIvrU2gF3521i93/EptaX
        ykE3++9AoFC2vi+1blW63Q4=
X-Google-Smtp-Source: APXvYqw+S8GoAUCIoteeKTKkOQvlM4k1QIAhzjlLXWQxK1zB5NfsENEAFOm0z0BC2QriZgKo3yBEvg==
X-Received: by 2002:a65:4247:: with SMTP id d7mr17257752pgq.114.1553707961297;
        Wed, 27 Mar 2019 10:32:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k83sm79122645pfj.178.2019.03.27.10.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:32:40 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:32:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 2/2] watchdog: f71808e_wdt: fix F81866 bit operation
Message-ID: <20190327173239.GC9951@roeck-us.net>
References: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1553668971-18801-2-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553668971-18801-2-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:42:51PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Fix error bit operation in watchdog_start()
> 
> Fixes: 14b24a88a3660 ("watchdog: f71808e_wdt: Add F81866 support")
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/f71808e_wdt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index bd2ced9f39f4..afd1446241b3 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -339,6 +339,7 @@ static int f71862fg_pin_configure(unsigned short ioaddr)
>  static int watchdog_start(void)
>  {
>  	int err;
> +	u8 tmp;
>  
>  	/* Make sure we don't die as soon as the watchdog is enabled below */
>  	err = watchdog_keepalive();
> @@ -388,19 +389,18 @@ static int watchdog_start(void)
>  		break;
>  
>  	case f81866:
> -		/* Set pin 70 to WDTRST# */
> -		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> -				  BIT(3) | BIT(0));
> -		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> -				BIT(2));
>  		/*
>  		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
>  		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
>  		 *     BIT5: 0 -> WDTRST#
>  		 *           1 -> GPIO15
>  		 */
> -		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
> -				  BIT(5));
> +		tmp = superio_inb(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL);
> +		tmp &= ~(BIT(3) | BIT(0));
> +		tmp |= BIT(2);
> +		superio_outb(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, tmp);
> +
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1, 5);
>  		break;
>  
>  	default:
> -- 
> 2.7.4
> 
