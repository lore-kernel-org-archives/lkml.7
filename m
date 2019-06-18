Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B1C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bg323twP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfFRQxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:53:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39062 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfFRQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:53:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so7995034pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=IqqtXsFGosoxNpPkm5wyCgfinoqyhByKBZjMuz4MB0I=;
        b=bg323twPxByid8peFGN7CaP7DYTzxD48CEFt6vzKFLuZr27ZPVeYR9aqapgK/NZyMX
         VwWDxuPluBaWMti4Db1jhMO8vU/6BpjUYDcDWPDqPIvC8V72JIX4y5qjBmafMOwLeDC+
         ex3OfhlOOmJs9zSa/1f/dp42YA8jMBbipGqeaijIyJMFO3zPZKzEYTlm6JJQaYMvayp0
         YcOwru57r9aSI06mvYdo4y0QlmqTtTz7ltIdOozdK1wEgu14p/fq2LSvG9qOBut3BD8o
         fU4dXkm9gaS6lKhpmdzsnMcIDNm+U2NyMlAqoMSX6bh2OonBDJ48eTnIkbyGgA+1Ugg+
         5hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IqqtXsFGosoxNpPkm5wyCgfinoqyhByKBZjMuz4MB0I=;
        b=X5n7vizYnYfIk8coqZcrAZgNqgVpLpkcEz8afBHu/JivgXDb6zSEK9K2DWiCHfcrfb
         19Qht7P3lu7K0h+brmNItb+QtH0xeOVKrLiQxtfiuGEcu8cX94K9PT1j+J/HsCmlhoPZ
         5ITg1QsdocFGxgVD/6jcb1vBJd269KXbfo1nvODxUEdD4ET663810gA6dCYlq6ZIMRvk
         KbUCeHANfJu6CDUWBWeXRhQlKPu3+yesMcv+d8iPQ+hZ0rsTGbClfitBMl7kNQ99osfG
         nL7M+3iDNe6maBY95gwhU6PpaA2WGSFOR1IZYs0/GMpi/zcAkBN1IT1JGD6BXkVzsJS1
         Xq2Q==
X-Gm-Message-State: APjAAAXUFw8EZCrhv4anRQvjne3x4kOsM3QQKhhfARNGuEJiHvBHd0Vs
        TK3iO6U/WgrKNJjI+8TgAV+rxg==
X-Google-Smtp-Source: APXvYqza2rYN7tr43Lk9Mo1yoxZIdHHve48RruCrOAFPMAW78pCSNW6feYT0xc+hh4kEhI6LzewVVA==
X-Received: by 2002:a63:4a1f:: with SMTP id x31mr3594318pga.150.1560876788415;
        Tue, 18 Jun 2019 09:53:08 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id a11sm15966693pff.128.2019.06.18.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 09:53:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, broonie@kernel.org, matthew.hart@linaro.org,
        enric.balletbo@collabora.com
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: next/master boot bisection: next-20190617 on sun8i-h2-plus-orangepi-zero
In-Reply-To: <5d089fb6.1c69fb81.4f92.9134@mx.google.com>
References: <5d089fb6.1c69fb81.4f92.9134@mx.google.com>
Date:   Tue, 18 Jun 2019 09:53:07 -0700
Message-ID: <7hr27qdedo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> next/master boot bisection: next-20190617 on sun8i-h2-plus-orangepi-zero
>
> Summary:
>   Start:      a125097c8410 Add linux-next specific files for 20190617
>   Details:    https://kernelci.org/boot/id/5d07987659b51412add51503
>   Plain log:  https://storage.kernelci.org//next/master/next-20190617/arm/multi_v7_defconfig/gcc-8/lab-baylibre/boot-sun8i-h2-plus-orangepi-zero.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190617/arm/multi_v7_defconfig/gcc-8/lab-baylibre/boot-sun8i-h2-plus-orangepi-zero.html
>   Result:     ce4ab73ab0c2 net: stmmac: drop the reset delays from struct stmmac_mdio_bus_data
>
> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     sun8i-h2-plus-orangepi-zero
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit ce4ab73ab0c27c6a3853695aa8ec0f453c6329cd
> Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Date:   Sat Jun 15 12:09:31 2019 +0200
>
>     net: stmmac: drop the reset delays from struct stmmac_mdio_bus_data
>     
>     Only OF platforms use the reset delays and these delays are only read in
>     stmmac_mdio_reset(). Move them from struct stmmac_mdio_bus_data to a
>     stack variable inside stmmac_mdio_reset() because that's the only usage
>     of these delays.
>     
>     Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

This seems to have broken on several sunxi SoCs, but also a MIPS SoC
(pistachio_marduk):

https://storage.kernelci.org/next/master/next-20190618/mips/pistachio_defconfig/gcc-8/lab-baylibre-seattle/boot-pistachio_marduk.html

Kevin
