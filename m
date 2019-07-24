Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72932C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E4C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999799;
	bh=NBBBglQK+Yq5wlIKUZLXqNIBOF02Fs1buLxEgTTKyjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TqyujykqWhlTnyVzRIJ18Gmid/M+bBTVKr6jY8Yq1desCQHQvgRM67GHkqe+yEdyg
	 VeJDSM8cr67pzzlwy+lheJr8IuegPMe5INfC6SfYUhdyVu7LF3rmuB6xS5/m0xCUkT
	 ECAJhXSUJAcC2Yrh+VH4bbKAe+SkyoC5kzXqunBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392908AbfGXUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:23:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36129 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390453AbfGXTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:43:01 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so92214717iom.3;
        Wed, 24 Jul 2019 12:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSPJRPecmIkBOwXjOa6IB3IwqosGZbZUtric4Ph4E4o=;
        b=Uz1vzZMmISM+EBL8D3JE3iB1WEkzLnUcCa+bZq8kQ8vBTZt/CeK49yyuH9VYj/mSQc
         cKlTho2y9sBe6EHEFFt83JI7+My4kdNg5/+xAF5za2rAOUUBC7D6OFf8Rj9CzLLEbGT6
         3qYGZyfMMWw74jZBcFkWO/qG5IdITPtAAHdx9Y6orfZRsFu3yyUmMDK0j2G8h16un2Tb
         YedgapKIVgB3pfSAq9fJZ9cz933OAL0WyWhvAYCj/NQ3bvKRQGeB9H6AWHrzQCS43ezW
         cSueR2pTrupM5Z8xG9FJBTA22Rt46yyKNWN87IvV2nmEaKWlh/sGqUGiEiR4WzQLKL/u
         44ZQ==
X-Gm-Message-State: APjAAAW6XZ70Q2gH8z4pMOEYyTJDuWWAH/kl6D/Fczi/WQ8GNHJqSCwc
        ze1rvu/wU7y7+fUKcNTvkw==
X-Google-Smtp-Source: APXvYqwHgt8wZNph+Kfk3NAJ2uOYvBBd1tibxisfgZlYpbdY6CVInbD0nZywDI8EDMJ/YLDUSyHdAw==
X-Received: by 2002:a5d:885a:: with SMTP id t26mr25104113ios.218.1563997380432;
        Wed, 24 Jul 2019 12:43:00 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v13sm38532541ioq.13.2019.07.24.12.42.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:42:59 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:42:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to
 make display work again
Message-ID: <20190724194259.GA25847@bogus>
References: <cover.1562597164.git.hns@goldelico.com>
 <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:46:05PM +0200, H. Nikolaus Schaller wrote:
> commit 6953c57ab172 "gpio: of: Handle SPI chipselect legacy bindings"
> 
> did introduce logic to centrally handle the legacy spi-cs-high property
> in combination with cs-gpios. This assumes that the polarity
> of the CS has to be inverted if spi-cs-high is missing, even
> and especially if non-legacy GPIO_ACTIVE_HIGH is specified.
> 
> The DTS for the GTA04 was orginally introduced under the assumption
> that there is no need for spi-cs-high if the gpio is defined with
> proper polarity GPIO_ACTIVE_HIGH.

Given that spi-cs-high is called legacy, that would imply that DT's 
should not have to use spi-cs-high.

> This was not a problem until gpiolib changed the interpretation of
> GPIO_ACTIVE_HIGH and missing spi-cs-high.

Then we should fix gpiolib...

> The effect is that the missing spi-cs-high is now interpreted as CS being
> low (despite GPIO_ACTIVE_HIGH) which turns off the SPI interface when the
> panel is to be programmed by the panel driver.
> 
> Therefore, we have to add the redundant and legacy spi-cs-high property
> to properly pass through the legacy handler.
> 
> Since this is nowhere documented in the bindings, we add some words of
> WARNING.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 6 ++++++
>  arch/arm/boot/dts/omap3-gta04.dtsi                | 1 +
>  2 files changed, 7 insertions(+)
