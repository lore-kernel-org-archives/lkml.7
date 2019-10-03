Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E039520865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="Bc59P60s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfJCR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:59:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42298 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJCR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:59:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so2521123lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7n4NvKPpvqFXigh24b8twI7kqYMuMZj67/WZMAs3RxU=;
        b=Bc59P60swsi5ASH0o5bE7smNybp94litM+wgTLMSxSgPd5K15x8U0/hr2VKJ878+XV
         MilBKq3+odr5y0VWyRb/XBMSYwoWETfuVy++Sb96L0dcUzajIqLC5+SXyKPItpcVOtXU
         V7waP48q3moqUtP7yay9xfqnifEMYp3y20JQb1IuXZaL4WUJKFKTLytYE3YeoH89QWxP
         5KQJHxLrUgz4EX/l2eWDswh0AMuDLckAI8e9h3Jncr7VY+HuitMt7/ovb5Ur4zSXniny
         YVJD7JbJVeqvTGutlM4TDZS/9trFAQwaAFZkGcd4lRdH041X6MblRVccYT7deFr+PZtS
         zkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7n4NvKPpvqFXigh24b8twI7kqYMuMZj67/WZMAs3RxU=;
        b=LS3STdgjswilGNP+n5hM/9cnM2QS6ridpV+QujDr577pciYRIY98ltPh5PT8ZqP8se
         pPxQmO+kA2epdY+Xku1AsGMIPgsvqfvWBL2t+H6pm4Ws1L6GIWg1oePJXz6G0pKueV7q
         w+3dIFgVgFZNnnEYmqZdlyi1okxhFdDbSW9ylohOCdP9VednlMwGqlNiCAjBc8TjxSZ6
         mrRW9p/dzqr4pAhb2xSap2835YovT+wLICfiIMyLilL0Ws3my/LpikV5yx2D8e0Xd2A0
         RaKv688yc8/D9OHiPl0EJS0PkXpieQmrlCLfvgoRhwA81ZUiXNXSgYL+kohCrQA1/7+4
         A3Uw==
X-Gm-Message-State: APjAAAUxQ2eCDEgo+Q0Pa4bEnM6/CdjC/O8pUnHvm1UQCHUl3qgy9oaQ
        rqavgz1yuoHIz7BsQXGEqzSdtw==
X-Google-Smtp-Source: APXvYqyH+AcaXNZ6JODwQr/ES+A9IWCabDZeg8LQhr5NHAvWxm1esJUv+eY/UinGqTGd7ZU/FVL5uQ==
X-Received: by 2002:ac2:48ba:: with SMTP id u26mr6538208lfg.164.1570125537473;
        Thu, 03 Oct 2019 10:58:57 -0700 (PDT)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id t22sm588754lfg.91.2019.10.03.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:58:56 -0700 (PDT)
Date:   Thu, 3 Oct 2019 19:58:55 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sh-pfc: Do not use platform_get_irq() to count
 interrupts
Message-ID: <20191003175855.GB1322@bigcity.dyn.berto.se>
References: <20191001180547.734-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001180547.734-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2019-10-01 20:05:47 +0200, Geert Uytterhoeven wrote:
> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing
> of scary messages like:
> 
>     sh-pfc e6060000.pin-controller: IRQ index 0 not found
> 
> Fix this by using the platform_irq_count() helper instead.
> 
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice change.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> This is a fix for v5.4-rc1.
> ---
>  drivers/pinctrl/sh-pfc/core.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index b8640ad41bef26be..ce983247c9e28bfe 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -29,12 +29,12 @@
>  static int sh_pfc_map_resources(struct sh_pfc *pfc,
>  				struct platform_device *pdev)
>  {
> -	unsigned int num_windows, num_irqs;
>  	struct sh_pfc_window *windows;
>  	unsigned int *irqs = NULL;
> +	unsigned int num_windows;
>  	struct resource *res;
>  	unsigned int i;
> -	int irq;
> +	int num_irqs;
>  
>  	/* Count the MEM and IRQ resources. */
>  	for (num_windows = 0;; num_windows++) {
> @@ -42,17 +42,13 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
>  		if (!res)
>  			break;
>  	}
> -	for (num_irqs = 0;; num_irqs++) {
> -		irq = platform_get_irq(pdev, num_irqs);
> -		if (irq == -EPROBE_DEFER)
> -			return irq;
> -		if (irq < 0)
> -			break;
> -	}
> -
>  	if (num_windows == 0)
>  		return -EINVAL;
>  
> +	num_irqs = platform_irq_count(pdev);
> +	if (num_irqs < 0)
> +		return num_irqs;
> +
>  	/* Allocate memory windows and IRQs arrays. */
>  	windows = devm_kcalloc(pfc->dev, num_windows, sizeof(*windows),
>  			       GFP_KERNEL);
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
