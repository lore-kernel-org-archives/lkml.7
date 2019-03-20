Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC62184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVAeOn5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfCTO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:57:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33466 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:57:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so2016029pgk.0;
        Wed, 20 Mar 2019 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xW98coCfzYxTBvXFzTO2cKOFYscWujwDg237aas+aNE=;
        b=oVAeOn5mXDT7xWp8Nazq1oY7g4GLdWMQgWcxEklEMDeEKx92a/FfEq+O2nVrLyPQ8f
         JXFo72LP20RrTkcrTxbnu6ggfFyMnCGpC9x3hKI3aTfkySif5v/80zj6ISD98uTqIGYt
         Kff3wFQ/Fo80jUc9CZYkQHFJ1CCKedvH+54v6jp8HGVFlq927+Vz4XburpzCBdYIJ9YO
         +aMMLv+YotkJANkEFO9Y4nrUWt9T9oLiYMyE59/Hq9+0Hg9Pt2mMszDYI/gewLv4/cPQ
         uqADzBMVT0wqpqpg8nnVGiHdEV5I1eRE5zF9zsXut/4+G9AYj8Te+UFaWeDRAGu7qD02
         EhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xW98coCfzYxTBvXFzTO2cKOFYscWujwDg237aas+aNE=;
        b=awoD7Cl32p3cXdUc6h0a2/5iFeQ6+xiPBCPfIx8+x2dLmRC1A1qgBhEirgbAnKAlL0
         b0y1KsdggKDKgKy6PDy9G6tRfcH+9Hn/0kx9pRgw9gbVqjp2MKF8YZhwCkB+rkVZC+L1
         2bpuQTd12hjo2igE4R8kptd5yKCp3ZpjvazrgPuuRdNaQhJkbCMoTc3/AVYlnmKRNOXT
         jA0ZKEeuV1zhLyeRTxfyk3XywuBI6pYBOfT3XBURfxwb4Emry9xtMoQnEjF3FLv+t0k5
         s7GXntaD2sIZnnR2GNXoSvIotVTyrixdrnfl3Pv15YcQN/NzmLoevlZ/HYuNFrpBPq/2
         u93g==
X-Gm-Message-State: APjAAAW72Hr9sQNRiPr71PMwSGudRtebluN8kF3RuKohvhFMdiXnmAZJ
        m+lmGYeELEXfXUz6vBG899q8NCXx
X-Google-Smtp-Source: APXvYqz4/qp6HNKn/+WSiUfyZYP5VWN/9NDoOvTkpOckeLNLIbQmM3NZMVNFvuenESsakOQp2KZhzw==
X-Received: by 2002:a62:e411:: with SMTP id r17mr20298816pfh.127.1553093868289;
        Wed, 20 Mar 2019 07:57:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k27sm3309432pgb.70.2019.03.20.07.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:57:47 -0700 (PDT)
Date:   Wed, 20 Mar 2019 07:57:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH -next] watchdog: sb_wdog: Make sbwdog_set and sbwdog_pet
 static
Message-ID: <20190320145746.GA10980@roeck-us.net>
References: <20190320134250.13348-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320134250.13348-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 09:42:50PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/watchdog/sb_wdog.c:70:6: warning: symbol 'sbwdog_set' was not declared. Should it be static?
> drivers/watchdog/sb_wdog.c:84:6: warning: symbol 'sbwdog_pet' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sb_wdog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> index 3abae50..8264fced 100644
> --- a/drivers/watchdog/sb_wdog.c
> +++ b/drivers/watchdog/sb_wdog.c
> @@ -67,7 +67,7 @@ static DEFINE_SPINLOCK(sbwd_lock);
>   *
>   * wdog is the iomem address of the cfg register
>   */
> -void sbwdog_set(char __iomem *wdog, unsigned long t)
> +static void sbwdog_set(char __iomem *wdog, unsigned long t)
>  {
>  	spin_lock(&sbwd_lock);
>  	__raw_writeb(0, wdog);
> @@ -81,7 +81,7 @@ void sbwdog_set(char __iomem *wdog, unsigned long t)
>   *
>   * wdog is the iomem address of the cfg register
>   */
> -void sbwdog_pet(char __iomem *wdog)
> +static void sbwdog_pet(char __iomem *wdog)
>  {
>  	spin_lock(&sbwd_lock);
>  	__raw_writeb(__raw_readb(wdog) | 1, wdog);
> -- 
> 2.7.0
> 
> 
