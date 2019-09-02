Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DC2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8188217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIHmB+Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfIBJLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:11:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37044 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIBJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:11:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so13750124wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8oqJdBiHyKqAlISuPnLa2MGGfZJDAaKp4XjFcqqHTI8=;
        b=DIHmB+MhpRayg6spOmLydYJ01PHT4VKTWXLlYhvJPb+LIBpWOOgWnzwVP9Emq17Spb
         8lPzi2/StfEbpYNaD3ubpzc+CkNRKgTx0mPxR56ZaqRQ2hZqkPMbtu790XYGirmaYKIB
         ShOSAq5oxixfW/1idndxBdzTSy0fCMrA1dsEEHQauEwpO+USJiaw0r4acOgDtxUpovnk
         sCRsT5siGKSqyshqIeIE/0CFUbmTbr2iaDvAGstjGPD1k9vkNiX5GM/QwUsdIOJeQw3y
         y4hoirYqZgpW/jo3rscQSbPHqKBMeO4KAorS2upSf46AV+2Ta85G4U69DxF7exqggh8f
         kOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8oqJdBiHyKqAlISuPnLa2MGGfZJDAaKp4XjFcqqHTI8=;
        b=CiCtoVKb08NkcDBFyhBaTQcA4PL64F4xuMruVpYs4RWpH3a7OfthBZfOiWIzpCA69i
         c1sIV/TQcqPicHBz2XPOE33/nSB09vRIuqFOFt4+ydNIM4ZPpnnQOKXWsFMMjyR0PYiq
         HOw++Jsboh7YKZHqgtCRSPi7DYbigKAlRzdB0jB8lCUOrhmmCLww23T+xoh0d/BDUQeh
         1DIzc82cgpOkxxnPZnl5R6ndvdsho+gIH9U5eMt7OAJywQUKwRsO2ki6tj2XIS/80g4T
         fWUPeg0+xRkkTFk8C12RidoQ3sSRHS4OBOkU3z8QCGvd7SbVrZ9K9IynZjCNyz9h29pf
         kH3w==
X-Gm-Message-State: APjAAAVOIbG9LbVy1IG1pA+0KmVSfLYYV/l1dYF54Nc8BFghtKr6pB6O
        pWpAP9HacJQNQk6wpBxsIuxYYg==
X-Google-Smtp-Source: APXvYqz6zTE3+7Cab43jkjP1vZUcgAoMSLfW1kYAvqHXdmLYBFVgNKWMXsb5YhZZGLOZta3H6WSVOg==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr299001wmc.153.1567415492632;
        Mon, 02 Sep 2019 02:11:32 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id s15sm6398842wmh.12.2019.09.02.02.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:11:32 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:11:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     jingoohan1@gmail.com, daniel.thompson@linaro.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v3] backlight: gpio-backlight: Correct initial power
 state handling
Message-ID: <20190902091130.GG32232@dell>
References: <20190731084018.5318-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731084018.5318-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019, Peter Ujfalusi wrote:

> The default-on property - or the def_value via legacy pdata) should be
> handled as:
> if it is 1, the backlight must be enabled (kept enabled)
> if it is 0, the backlight must be disabled (kept disabled)
> 
> This only works for the case when default-on is set. If it is not set then
> the brightness of the backlight is set to 0. Now if the backlight is
> enabled by external driver (graphics) the backlight will stay disabled since
> the brightness is configured as 0. The backlight will not turn on.
> 
> In order to minimize screen flickering during device boot:
> 
> The initial brightness should be set to 1.
> 
> If booted in non DT mode or no phandle link to the backlight node:
> follow the def_value/default-on to select UNBLANK or POWERDOWN
> 
> If in DT boot we have phandle link then leave the GPIO in a state which the
> bootloader left it and let the user of the backlight to configure it
> further.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> sorry for the delay, but got distracted a bit with the resend of this...
> Let's try again ;)
> 
> Changes since v2 (https://lore.kernel.org/patchwork/patch/1002359/):
> - Rebased on drm-next
> 
> Changes since v1:
> - Implement similiar initial power state handling as pwm backlight have
> 
> Regards,
> Peter
> 
>  drivers/video/backlight/gpio_backlight.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
