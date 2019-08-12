Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73804C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA402085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfgUI5T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHLHpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:45:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:44:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so1435461wrr.8;
        Mon, 12 Aug 2019 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axx5t1pQziCogZokCRaPN9srE7gDApf+a9vIu6w+Yk4=;
        b=tfgUI5T++M6iHqMqem1ZMPsuh/DJUBAIUNiuHKoVjVd/Hzq+a1Kzo4lGqVWrLZ6Zo3
         ZAr6IbA8x/pfpaIsqMJ4y0C5+6gfu+KHaPY4a1+SATevORrUdRBOMRnl3gCYx3NW0pzt
         2dwgAhpbjA4E3S5QqPpBjA2dEuPdRA3upEDbEYqH45NEoIMxRDDjIJdjShklUkqU5x+i
         szOgZI/XhsxE5X+ipK8CG6PmICu3SV5/6fk5W03NyiYpeFt8v6GGJmfw7yqNMFteISlC
         txROC1BLOs9by1xXiLAWQq3n/F9F7sAmhaEtJt2XLESE8eT4DRXHPQPUIXQtrU0oeYuT
         Mulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axx5t1pQziCogZokCRaPN9srE7gDApf+a9vIu6w+Yk4=;
        b=CUIxGn8GuvfSf2dbXVhWXqJlWjNMNp/wsQWnM6nR026ZtFPv6oQfXenYt6W6K2X8Fx
         T2hOGIGCuBVH4ITM7mVHXlkb97MS3DEXTC7Prxs+x3MkO2LkPCRgDqYfuJ9IzkobS62y
         zvoO1wsNIjo2ISwu8PS3EcdBXqbEy8KMzHqe9RDSNdTfuVRjlCi4mSlLoGUrnfTT6Y2a
         uMwFz6MUf3usE6x2V6JMY1WRA3JpTd9PsxEQvHUssvb382hq8+ySHph1XK+Wsrp/TPWt
         m4KXqZrPb6+BVNFJo5skfxLFU4nLZYIXMwVjjZvFyvutJ2L0o/CAKbYY2oBOwhjfR0ix
         C1TA==
X-Gm-Message-State: APjAAAUGI227Xu0Q8H1ASq8cuk0SmSjNEfYKvX7MszQ7CujsMtguvuV8
        naHfO1spZkttZCJ9cGDOIWo=
X-Google-Smtp-Source: APXvYqwimf6/yTeGd34WQ+E48bgUvFXw45Oi2gN+Lu+PXH39ryjbfIhfxq7h9T3upcatBs1YMoVbwg==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr33506400wro.190.1565595896607;
        Mon, 12 Aug 2019 00:44:56 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id a81sm5050776wma.3.2019.08.12.00.44.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 00:44:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, megous@megous.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v8 0/4] Add support for Orange Pi 3
Date:   Mon, 12 Aug 2019 09:44:53 +0200
Message-ID: <2218280.0sI6yjypBf@jernej-laptop>
In-Reply-To: <20190806155744.10263-1-megous@megous.com>
References: <20190806155744.10263-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 06. avgust 2019 ob 17:57:39 CEST je megous@megous.com napisal(a):
> From: Ondrej Jirman <megous@megous.com>
> 
> This series implements support for Xunlong Orange Pi 3 board. There
> are only a few patches remaining.
> 
> - ethernet support - just a DT change (patch 1)
> - HDMI support (patches 2-4)
> 
> For some people, ethernet doesn't work after reboot because u-boot doesn't
> support AXP805 PMIC, and will not turn off the etherent PHY regulators.
> So the regulator controlled by gpio will be shut down, but the other one
> controlled by the AXP PMIC will not.
> 
> This is a problem only when running with a builtin driver. This needs
> to be fixed in u-boot.
> 
> 
> Please take a look.

Is there anything missing? It would be nice to get this in 5.4. There is a lot 
of H6 boards which needs DDC bus enable mechanism (part of H6 reference 
design), including Beelink GS1 which already has HDMI node in mainline kernel 
DT, but due to disabled DDC lines works only with 1024x768 (fallback 
resolution in DRM core).

Best regards,
Jernej

> 
> thank you and regards,
>   Ondrej Jirman
> 
> Changes in v8:
> - added reviewed-by tags
> - dropped already applied patches
> - added more info about the phy initialization issue after reset
> 
> Changes in v7:
> - dropped stored reference to connector_pdev as suggested by Jernej
> - added forgotten dt-bindings reviewed-by tag
> 
> Changes in v6:
> - added dt-bindings reviewed-by tag
> - fix wording in stmmac commit (as suggested by Sergei)
> 
> Changes in v5:
> - dropped already applied patches (pinctrl patches, mmc1 pinconf patch)
> - rename GMAC-3V3 -> GMAC-3V to match the schematic (Jagan)
> - changed hdmi-connector's ddc-supply property to ddc-en-gpios
>   (Rob Herring)
> 
> Changes in v4:
> - fix checkpatch warnings/style issues
> - use enum in struct sunxi_desc_function for io_bias_cfg_variant
> - collected acked-by's
> - fix compile error in drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c:156
>   caused by missing conversion from has_io_bias_cfg struct member
>   (I've kept the acked-by, because it's a trivial change, but feel free
>   to object.) (reported by Martin A. on github)
>   I did not have A80 pinctrl enabled for some reason, so I did not catch
>   this sooner.
> - dropped brcm firmware patch (was already applied)
> - dropped the wifi dts patch (will re-send after H6 RTC gets merged,
>   along with bluetooth support, in a separate series)
> 
> Changes in v3:
> - dropped already applied patches
> - changed pinctrl I/O bias selection constants to enum and renamed
> - added /omit-if-no-ref/ to mmc1_pins
> - made mmc1_pins default pinconf for mmc1 in H6 dtsi
> - move ddc-supply to HDMI connector node, updated patch descriptions,
>   changed dt-bindings docs
> 
> Changes in v2:
> - added dt-bindings documentation for the board's compatible string
>   (suggested by Clement)
> - addressed checkpatch warnings and code formatting issues (on Maxime's
>   suggestions)
> - stmmac: dropped useless parenthesis, reworded description of the patch
>   (suggested by Sergei)
> - drop useles dev_info() about the selected io bias voltage
> - docummented io voltage bias selection variant macros
> - wifi: marked WiFi DTS patch and realted mmc1_pins as "DO NOT MERGE",
>   because wifi depends on H6 RTC support that's not merged yet (suggested
>   by Clement)
> - added missing signed-of-bys
> - changed &usb2otg dr_mode to otg, and added a note about VBUS
> - improved wording of HDMI driver's DDC power supply patch
> 
> Ondrej Jirman (4):
>   arm64: dts: allwinner: orange-pi-3: Enable ethernet
>   dt-bindings: display: hdmi-connector: Support DDC bus enable
>   drm: sun4i: Add support for enabling DDC I2C bus to sun8i_dw_hdmi glue
>   arm64: dts: allwinner: orange-pi-3: Enable HDMI output
> 
>  .../display/connector/hdmi-connector.txt      |  1 +
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 70 +++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         | 54 ++++++++++++--
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  2 +
>  4 files changed, 123 insertions(+), 4 deletions(-)




