Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACFC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941F82133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVWsqpzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfJDJxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:53:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbfJDJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:53:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so6322426wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YhHlhwGt1TAWXafFmkDE+SBCnhwFe8ErS8cgtMMTtE=;
        b=rVWsqpzVnJGi0YJ4CwuRNcaOlX+d7aKvIZN1mIp3uBoH7n6mm4b9o6bFRNye4VHvN0
         dmHpJgNyeQXGqq8oqFzi3tkydvv82SxHK6xZ5YgxvmJH2xq7/U3SLoSuKymkyPG7iYi6
         ScXsvWgiaPqfKnMnQUFEp15myR3XEB5V/7GNNKMgjnsvzfBTL2SIUtBXFMk81yumnur+
         vAjwHRiomQ54AQh7zgwceSjUCQqaCw7uoyVyVERGlXcoObSRoJk23p4RPVwZzRIE3bz8
         dRbbKGwpYcig8zrQ7LbMq4VYgJo0hVr2YcX3dJzKnSDqS7/z02rpCGlHl1kbulLwflaw
         VuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YhHlhwGt1TAWXafFmkDE+SBCnhwFe8ErS8cgtMMTtE=;
        b=GJW7YhA6Jhuh6tVaaVkoIW1D5nHNOJSsEV2vTNU6mrONsVmZ9AlZH1pKVzF2099uy8
         k8snov4hJyrHIV86ArVfNW2QgWcjzYuhPR7TAzgmTq3yy1ZCb+8iCSckO03Mx5mvS0aZ
         Ma/Zvt49AfpsbXis5jTnvJKsz30oP/8RLiOpJPCxAk3PRQr8anKrV20ok/P0qU0SMzwx
         l86K/mbDysmqataFbUstjZ3YS4Lj+9nppZDEfkIJ2epx82v8fE2RxMub1U3eonwr95B/
         NOqusihj0B4GO7s9ZhKww4fNDg+QcO3Tn7Xi8LP9ozomDjNk2uxxZ4NQ9aoFFwBVtnHR
         WagQ==
X-Gm-Message-State: APjAAAU9ERHfSrjWYwBVAM7zYlEq59Ua6OHG9ecSabkrZ6aIgOOGyXDS
        wHgsC26qFkYZPXPeeVScLRU05Q==
X-Google-Smtp-Source: APXvYqx575IgPMR5+hBw1Fkasc8Zm3FBPTFTq4xTXjeUiMnpd3XGClpUvuFfrq51IvPd6NIsV6MwQA==
X-Received: by 2002:a5d:4b52:: with SMTP id w18mr1225370wrs.239.1570182802022;
        Fri, 04 Oct 2019 02:53:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b7sm1483036wrx.56.2019.10.04.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:53:21 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:53:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Add missing curly branches in else
 branch
Message-ID: <20191004095319.dkcjemag65xgsmp5@holly.lan>
References: <20191003213502.102110-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003213502.102110-1-mka@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:35:02PM -0700, Matthias Kaehlcke wrote:
> Add curly braces to an 'else' branch in pwm_backlight_update_status()
> to match the corresponding 'if' branch.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..130abff2705f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -125,8 +125,9 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  		state.duty_cycle = compute_duty_cycle(pb, brightness);
>  		pwm_apply_state(pb->pwm, &state);
>  		pwm_backlight_power_on(pb);
> -	} else
> +	} else {
>  		pwm_backlight_power_off(pb);
> +	}
>  
>  	if (pb->notify_after)
>  		pb->notify_after(pb->dev, brightness);
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
