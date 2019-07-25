Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57972218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQQDJiby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbfGYNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:54:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43797 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfGYNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:54:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so50863420wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kiGD59LaW0LszoAZzmVLJ1Hft59fIaEtybxXjg0U4OU=;
        b=sQQDJiby1lR9rJnYwpFayBJL1RCmEUHrXJL5ktfkxstXcB1e72/IJ+7W0b7G/ZBDE7
         l2/Oe7WGAKBlaplOUnR9eKLvijJm+yqgNtv1e2Xt94tpqVPUHg4DEcD9UGsRs0szMquI
         gd0SnX7mYKDLhjJOaB+OD74kiTzZcmfgGeIajBjxHk8HORwabuVH5qYZ14shV48okQcq
         oV1q3+hmkLuRmabQQ4N1s3WbE9w1LtffyarQQhGJ98ItiO4babxYtOZPj/d8HElgIXh3
         +7ifv5dKadFG/B1N65t8KG2r29CwpiyOZg/YA0MfSDcC9TY3HZioK4MipWty6YP9bw5P
         6xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kiGD59LaW0LszoAZzmVLJ1Hft59fIaEtybxXjg0U4OU=;
        b=ltB1p/gom1IFtMSu21b2TNE7bB6lDQaG1f2vii86L4pv0P1utEG90uK2RtmxWOmzOG
         aLNAu17h213aGCJKBOCN0+HFYQwwZdRAnvAVNDnIZItmWUPHqYlfrcPX5TWJTEzjzVCS
         ogyHJESB4XTfb7gyOSF2Un4KnlJf9qKkxj6Ba56Uhp6Ij9lNO/GiQD/Fs3abdpkDECXg
         sOA4jWs+skRWJ35YgDuRxw72Y4gJIhLmq0CUjoJa/1xIxCbKTlkg5GQUHbcnz4MYFk35
         5Eq+kj65Iy0CpROIzbRjY286WLfVqxlvJVBmhySl+G+wVNC26tkaCU+APCvldofyobte
         28AA==
X-Gm-Message-State: APjAAAVhnwEl3WVvNl8Z30e1TQMGT+Jz8mwOMKuA83EJlsnpTgBnbgf4
        I9K0pXfufDR3RBt3DUZQYsfAwQ==
X-Google-Smtp-Source: APXvYqyi+7SaHwgU0aK/nQJij+0evagD7L54rP/lc55M34rnwnlBR+KX1Ln1iOdMtsPd3Xr0XJt2kw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr64650717wrp.38.1564062869954;
        Thu, 25 Jul 2019 06:54:29 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id c9sm40786310wml.41.2019.07.25.06.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 06:54:29 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:54:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Wolfram Sang <wsa@the-dreams.de>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3 2/7] drivers: Introduce device lookup variants by
 of_node
Message-ID: <20190725135402.GL23883@dell>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723221838.12024-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019, Suzuki K Poulose wrote:

> Introduce wrappers for {bus/driver/class}_find_device() to
> locate devices by its of_node.
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: devicetree@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  - Dropped the reviewed-by tags from Thor, Mark, Andrew and Peter as the
>    patches are mereged, though there are no functional changes.
> ---
>  drivers/amba/tegra-ahb.c              | 11 +-------
>  drivers/fpga/fpga-bridge.c            |  8 +-----
>  drivers/fpga/fpga-mgr.c               |  8 +-----
>  drivers/gpu/drm/drm_mipi_dsi.c        |  7 +----
>  drivers/i2c/i2c-core-of.c             |  7 +----
>  drivers/mfd/altera-sysmgr.c           | 14 ++--------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

What's the merge plan for this patch?

Is anyone prepared to create an immutable branch for us to pull from?
I'm happy to do it if no one else steps up.

>  drivers/mux/core.c                    |  7 +----
>  drivers/net/phy/mdio_bus.c            |  9 +------
>  drivers/nvmem/core.c                  |  7 +----
>  drivers/of/of_mdio.c                  |  8 +-----
>  drivers/of/platform.c                 |  7 +----
>  drivers/regulator/of_regulator.c      |  7 +----
>  drivers/spi/spi.c                     | 20 +++------------
>  include/linux/device.h                | 37 +++++++++++++++++++++++++++
>  sound/soc/rockchip/rk3399_gru_sound.c |  9 ++-----
>  15 files changed, 56 insertions(+), 110 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
