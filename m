Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E77C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8724D2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEZ6Ljls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDBE6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:58:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39005 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBE6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:58:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so5612450plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OH4i3uT4EBcimwMTT/CT8VMm0Y4hc83kBVZZr8qoonw=;
        b=eEZ6LjlshLGqQf+4hzeHnZVYzt0vHpzqhJr0ai0/6Lx6ee6fXeMQVG8erw91Z8mhyi
         UdeCmNawHHMiRMuv2UgIzjCZxeNXA1UIN5o7/2HlsrCjRtCh3WkAr/233h08uQ28QySe
         T4ivLVu14X4lsDjythZEnQphVr6ml/G4C68hAMBdN4IAOhLoWUOa+74MAixYIpUNhj17
         cM7i3BFwhiONwXPvlwob46XdZTjP3Epe1Npna+Dyw4m+fDeScnxa0RPDCCzZ9sefMAdU
         5JlQBE+r/VbQbPI8uTEQg1P7KgziAQ4OeiRKd+1aZh/RhEqxQN9y495jX0hgVUGKr1Ko
         zKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OH4i3uT4EBcimwMTT/CT8VMm0Y4hc83kBVZZr8qoonw=;
        b=UOaM8+cF16V6JTv7keXFvWHza1F3aamoE3a9o102HBPXPYKH42s1oA5cCabLHGzisH
         hCvQjvD/F8ByZPX0EwXHmmKVf4IbEDAV2k3QVvckjKnw1HgeTTQdUprIWxCgOVQY0T0F
         LBrK3A2kABsptmZcbLanV/Y6dvJt4DuKo0ossfPVIvCZX7A08slK0tR0WntP9C2QRgYs
         1yjLcmKiG4eYg/MAfF9hM6YPhzBjzk7AE9CAGGteIVkdFAebGlTnw1LspmDxWudq77Bv
         TbkjLGDGFIogyK0izrCgngLtYXcEKPvTdMQu9T9uNh68WDu0LjHlOgPJ5Ie8Q9YAM/C6
         dj1A==
X-Gm-Message-State: APjAAAU0oLwoGZu73PQBvEqUcH9OzhydtTipsOMO9rE7YR/uQikc13gB
        6MMYMDHEisIMlZpyDT2aT/0N2A==
X-Google-Smtp-Source: APXvYqzjuF05kINbZcLgLi+lueGIWrFA4OeB8arsi1Tmp1y6gpxSL/X8A2eCjaM6h0IqjC1CRLdPtw==
X-Received: by 2002:a17:902:7590:: with SMTP id j16mr32711175pll.98.1554181115817;
        Mon, 01 Apr 2019 21:58:35 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id n26sm35167130pfi.165.2019.04.01.21.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:58:35 -0700 (PDT)
Date:   Tue, 2 Apr 2019 05:58:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: sc27xx: Use SoC compatible string for PMIC
 devices
Message-ID: <20190402045829.GQ4187@dell>
References: <af33f66a602462f14431e99433324b8523f74f78.1552879519.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af33f66a602462f14431e99433324b8523f74f78.1552879519.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Baolin Wang wrote:

> We should use SoC compatible string in stead of wildcard string for
> PMIC child devices.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Hi Lee,
> 
> Could you merge this patch into v5.1-rc if no objection from you?
> Since our DTS patches had been merged into v5.1, our PMIC can not
> work without this patch. Thanks.

Oh dear, what a pickle.  Really you should have pushed these change
though one tree, in either a single patch or at the very least a
single patch-set.  I will see what I can do, so that this doesn't
break for an entire kernel version (but I make no promises).

> ---
>  drivers/mfd/sprd-sc27xx-spi.c |   42 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 69df277..43ac716 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -53,67 +53,67 @@ struct sprd_pmic_data {
>  static const struct mfd_cell sprd_pmic_devs[] = {
>  	{
>  		.name = "sc27xx-wdt",
> -		.of_compatible = "sprd,sc27xx-wdt",
> +		.of_compatible = "sprd,sc2731-wdt",
>  	}, {
>  		.name = "sc27xx-rtc",
> -		.of_compatible = "sprd,sc27xx-rtc",
> +		.of_compatible = "sprd,sc2731-rtc",
>  	}, {
>  		.name = "sc27xx-charger",
> -		.of_compatible = "sprd,sc27xx-charger",
> +		.of_compatible = "sprd,sc2731-charger",
>  	}, {
>  		.name = "sc27xx-chg-timer",
> -		.of_compatible = "sprd,sc27xx-chg-timer",
> +		.of_compatible = "sprd,sc2731-chg-timer",
>  	}, {
>  		.name = "sc27xx-fast-chg",
> -		.of_compatible = "sprd,sc27xx-fast-chg",
> +		.of_compatible = "sprd,sc2731-fast-chg",
>  	}, {
>  		.name = "sc27xx-chg-wdt",
> -		.of_compatible = "sprd,sc27xx-chg-wdt",
> +		.of_compatible = "sprd,sc2731-chg-wdt",
>  	}, {
>  		.name = "sc27xx-typec",
> -		.of_compatible = "sprd,sc27xx-typec",
> +		.of_compatible = "sprd,sc2731-typec",
>  	}, {
>  		.name = "sc27xx-flash",
> -		.of_compatible = "sprd,sc27xx-flash",
> +		.of_compatible = "sprd,sc2731-flash",
>  	}, {
>  		.name = "sc27xx-eic",
> -		.of_compatible = "sprd,sc27xx-eic",
> +		.of_compatible = "sprd,sc2731-eic",
>  	}, {
>  		.name = "sc27xx-efuse",
> -		.of_compatible = "sprd,sc27xx-efuse",
> +		.of_compatible = "sprd,sc2731-efuse",
>  	}, {
>  		.name = "sc27xx-thermal",
> -		.of_compatible = "sprd,sc27xx-thermal",
> +		.of_compatible = "sprd,sc2731-thermal",
>  	}, {
>  		.name = "sc27xx-adc",
> -		.of_compatible = "sprd,sc27xx-adc",
> +		.of_compatible = "sprd,sc2731-adc",
>  	}, {
>  		.name = "sc27xx-audio-codec",
> -		.of_compatible = "sprd,sc27xx-audio-codec",
> +		.of_compatible = "sprd,sc2731-audio-codec",
>  	}, {
>  		.name = "sc27xx-regulator",
> -		.of_compatible = "sprd,sc27xx-regulator",
> +		.of_compatible = "sprd,sc2731-regulator",
>  	}, {
>  		.name = "sc27xx-vibrator",
> -		.of_compatible = "sprd,sc27xx-vibrator",
> +		.of_compatible = "sprd,sc2731-vibrator",
>  	}, {
>  		.name = "sc27xx-keypad-led",
> -		.of_compatible = "sprd,sc27xx-keypad-led",
> +		.of_compatible = "sprd,sc2731-keypad-led",
>  	}, {
>  		.name = "sc27xx-bltc",
> -		.of_compatible = "sprd,sc27xx-bltc",
> +		.of_compatible = "sprd,sc2731-bltc",
>  	}, {
>  		.name = "sc27xx-fgu",
> -		.of_compatible = "sprd,sc27xx-fgu",
> +		.of_compatible = "sprd,sc2731-fgu",
>  	}, {
>  		.name = "sc27xx-7sreset",
> -		.of_compatible = "sprd,sc27xx-7sreset",
> +		.of_compatible = "sprd,sc2731-7sreset",
>  	}, {
>  		.name = "sc27xx-poweroff",
> -		.of_compatible = "sprd,sc27xx-poweroff",
> +		.of_compatible = "sprd,sc2731-poweroff",
>  	}, {
>  		.name = "sc27xx-syscon",
> -		.of_compatible = "sprd,sc27xx-syscon",
> +		.of_compatible = "sprd,sc2731-syscon",
>  	},
>  };
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
