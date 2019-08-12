Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395ECC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41DF2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e3gKu9VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHLUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:31:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:31:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so3362072pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8/dzomfKZtMmJBCxwZthQlRqMx3W9Dc6DXlVE3ZOJ98=;
        b=e3gKu9VE3T9jzG9hciNyK0x0OK+iti0j4JSgrsCMf1iFhV3LZxpdlCtga8J82aXRgG
         hvN47PEvUiGgWu8qPwec45iUvVohkyDRCeOKQlZ+j0QJq/llZ/iSO1yjlkjP79wjNqaL
         I3jwvEphQJvT2hCtGhPMo2S5MpDyy2RagsceziAKt0EGRJzgKrMjZMFuCqNpvLJKNERU
         zJZm+6b3YPKnWbjB8eeLgrmCjBBAmY8F7G+ANNwgl+Jig575o5Yf1c8mXiN0JDVe9ZfR
         gAs9EZkIsp0Hg29EhVVzpqIp6kVkuDF3AhjBo9I70LREOI6yLLo/3UyHrLwdQWj8zo0c
         yD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8/dzomfKZtMmJBCxwZthQlRqMx3W9Dc6DXlVE3ZOJ98=;
        b=LAYFklbeEQ34W1cgE5qzMBM8xxTFRa9QKACbnz4Xja8hgYPSGq+/V+E8pSGuzeNDTm
         ASNWLCJDJXk7WIJauuuQgITzl2pJ3ABGEQK7kJnLQbmriGLf2vN+fjgbaTmLRukUARrB
         rjkIIjfGgdZahrrZdaZqFhw2cRnsAb+Ie7F8xsyk/6x+2hbNzRikMfM4xk0hFEJV2Dtp
         WWz5u/cNu8lph1TUfx5towTBlrgxwS+hNNHEQ5R4o5cCxhCmEAaZOoY8bQ4nj+apSynt
         SBSl1JcYJN5EVglP1ZgJNIXaWQQXMnkKfaI3j0xMpcng+Z/iIvhuu6Wgh5WhCzjNwd/q
         ImRA==
X-Gm-Message-State: APjAAAWvovAzet+4SmvxgP08KIfjipbiXc4TSRrBZGkIQ18ggnkXWcbh
        /lz815zCrs1zU1R3PwLAbo8Kbg==
X-Google-Smtp-Source: APXvYqzRVx7zE/aBCc9H6C7hScAoLaJmDfXikuBGTg+k7m7mx2eKPJSF/Mmu1eyHEj3FG+3hh9tBqA==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr31505067pgq.130.1565641883048;
        Mon, 12 Aug 2019 13:31:23 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:14bb:580e:e4d6:b3a8])
        by smtp.gmail.com with ESMTPSA id h195sm5229140pfe.20.2019.08.12.13.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 13:31:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: meson-g12b-khadas-vim3: add initial device-tree
In-Reply-To: <20190812074857.8133-1-narmstrong@baylibre.com>
References: <20190812074857.8133-1-narmstrong@baylibre.com>
Date:   Mon, 12 Aug 2019 13:31:21 -0700
Message-ID: <7hzhke15ye.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Christian Hewitt <christianshewitt@gmail.com>
>
> The Khadas VIM3 uses the Amlogic S922X or A311S SoC, both based on the
> Amlogic G12B SoC family, on a board with the same form factor as the
> VIM/VIM2 models. It ships in two variants; basic and
> pro which differ in RAM and eMMC size:
>
> - 2GB (basic) or 4GB (pro) LPDDR4 RAM
> - 16GB (basic) or 32GB (pro) eMMC 5.1 storage
> - 16MB SPI flash
> - 10/100/1000 Base-T Ethernet
> - AP6398S Wireless (802.11 a/b/g/n/ac, BT5.0)
> - HDMI 2.1 video
> - 1x USB 2.0 + 1x USB 3.0 ports
> - 1x USB-C (power) with USB 2.0 OTG
> - 3x LED's (1x red, 1x blue, 1x white)
> - 3x buttons (power, function, reset)
> - IR receiver
> - M2 socket with PCIe, USB, ADC & I2C
> - 40pin GPIO Header
> - 1x micro SD card slot
>
> A common meson-g12b-khadas-vim3.dtsi is added to support both S922X and
> A311D SoCs supported by two variants of the board.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This still has a build-time dependency on the CPUB clock patch.

Looks like Jerome has sent a PR w/tag today that includes that, so I'll
merge that tag and then queue this patch.

Thanks,

Kevin
