Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECE9217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/WMwjjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfIBJmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:42:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51302 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfIBJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:42:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so13797231wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iK4LKa2PqlS0Y5u4Gjl7mrzOSTmztak1fj4wGqVsFy4=;
        b=S/WMwjjBsYD6eC5+gEOI58+jRpAry6yXwLdfqno73t/WpmJzLCQpqM2O2mTs/aiwQR
         TCGv+n2vwxgVgIx+fPgz4pHjr9PA1fIL+38d3IdqZWTS9Tyg0SCxGxy5hC9PnOHU0A6S
         6S6nOWcPZFNCZ2aIevsy5XbQrn1qE0XwXbaXnXNnt6jhsNbdKuXnJjHv+pVAVFGLna0+
         YU/tKj9qpFXh/951Jev2PUuDzIubEmF24MUyCESqrgAuuraAsPwd1+e18ZC6zmc4eaRi
         cQ7yC7GHWkx6zeRgTvQrH97fL7TXhIoW0isOYDcSdW/bYVSopm5JEQjiBCDxmVrFQc+/
         YUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iK4LKa2PqlS0Y5u4Gjl7mrzOSTmztak1fj4wGqVsFy4=;
        b=dwKeXWYmS7FDFLKED6ZRLhQViZ6MZK3NbypADlFfzZhKaeqzjWjos3X8KU70u2fyON
         GpMmF2WBatTTS/UcK2t1mOY3lnBWsIuNRGjDCVckFY9g8nZ3A9fWAdFIQ5iDJF0l1RkD
         AXGFwTwc9SADNUHkmqFTmJxI1iFIwGf9+VTYmheqJUr45TF9YbW6U8H8YBlLENUUliPn
         +tCwwOgda1XNjReGFG0IekyOjHGStSyDtyyBR1ByQpbPdTtU/GiuNN9eGpH6v4/uuOq5
         sjfvTvfC9i29Fah+pnlmO8ksvKznqyB7DNBqTpi8DOP3MHZ/AtvW3r7TaTPC5ou3OMC8
         s4lA==
X-Gm-Message-State: APjAAAXM9/s+rPLiO1KG0usJg0xcDaEqp1/ij4uy2a/ULyumYemHPi+f
        Vftu23vXixiYnV3IH/O2Bz5sSA==
X-Google-Smtp-Source: APXvYqzNZJNoxLswvc9p2LnkDfvzZJYlWCgpWeM7LW0HaPoM2ddXbfzMbv9rhLZWFOa3XTsnVAB6og==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr35998457wmb.116.1567417333221;
        Mon, 02 Sep 2019 02:42:13 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id k9sm16402618wrq.15.2019.09.02.02.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:42:12 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:42:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Message-ID: <20190902094211.GO32232@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-5-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709190007.91260-5-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jul 2019, Matthias Kaehlcke wrote:

> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes in v3:
> - none
> 
> Changes in v2:
> - use 128 (power of two) instead of 100 as factor for the slope
> - add comment about max quantization error
> - added Daniel's 'Acked-by' tag
> ---
>  drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
