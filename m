Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5ABC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4AD206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3uL4xR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfHLH0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:26:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36487 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHLH0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:26:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so10837433wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PUYFwTQM6k2TXKtGxVv6RCi/wuf9Urwy1FkTCccMbMM=;
        b=y3uL4xR0fxckWe7u9pXs2CnyVYlPo79kFLr/DMANHHmkBudJM4/K/1xI7EEIhlNozo
         ezwdujfO+X49ep5M195RGpIb9t/mE4/VeeWKQG5VX75D5K92l68ipqM3+M/Jw0wqakPw
         52wzx89vLtQaQB++citGQ9Su8srwMt4qs55twOTTI1Rv043lSsf42wyWGcigaReI4Vkg
         Hxdd9tIIuyamv6a9i5+nVNJh5uFLIsIJCbChTKEB8FURUJGKXw1cy1+cXhUd6YaquW+W
         PgLALkkLuzZwNo+XNWbWuPBIBLbUaK9BceODRQEbrAdtIhg6ePgiFrQFXyotoaUL61Cz
         btZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PUYFwTQM6k2TXKtGxVv6RCi/wuf9Urwy1FkTCccMbMM=;
        b=dK5urX4IMChDBFRhHKAXAd6S/tKjtP6uMnfSYXued6crxxGH/mH8gMxHK34pZY5CzE
         6IZXWrPMySZZD4p5s5k+Ufpne2WUADn4u8SBcXpmaNj++Q29yusHH1/8J3knzhiwy40D
         Bowk7I2eejb3dPEBa5xF+at5a9aOCpovuZQgyW5YUNAgIjqrJ/Ytjmq6Bk0Fsa3XjJdI
         LeTR+Fni4lF8wbCjeoNW0U5/rxAvKIdCXf8AGNROlYpUswHNKOZZwV6dp6gC+0/eIpGM
         +zSyEFDkzb6oZN74NE2Jxie16yG8adVmdYi/FdsyNVHn+Oa9IA54f2x4C9vhgSlRsEoj
         bsqw==
X-Gm-Message-State: APjAAAXUWWPkgvBkcnC5+1ksI1GJuuA5oSpOes7KzTn4R7x+Ea156PBc
        3zlVUXWGOFKM90kRZm/F6eIJ+Q==
X-Google-Smtp-Source: APXvYqxPlhRcIfUjd9eqy3ozHPa5VIaOKS3K6/AEqQ5O/FTwOXFHwvqbbymK8vUaxNSsUvOgT6Mrkw==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr25884378wmk.51.1565594773385;
        Mon, 12 Aug 2019 00:26:13 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id r11sm165582541wre.14.2019.08.12.00.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:26:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:26:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 11/11] arm/arm64: defconfig: Update configs to use the
 new CROS_EC options
Message-ID: <20190812072611.GM4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-12-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-12-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> Recently we refactored the CrOS EC drivers moving part of the code from
> the MFD subsystem to the platform chrome subsystem. During this change
> we needed to rename some config options, so, update the defconfigs
> accordingly.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/exynos_defconfig   | 3 ++-
>  arch/arm/configs/multi_v7_defconfig | 8 ++++----
>  arch/arm/configs/pxa_defconfig      | 8 ++++----
>  arch/arm/configs/tegra_defconfig    | 6 ++++--
>  arch/arm64/configs/defconfig        | 6 ++++--
>  5 files changed, 18 insertions(+), 13 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
