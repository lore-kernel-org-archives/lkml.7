Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79E82189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q5h/wSLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfGCMqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:46:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32934 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:46:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so1214238pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37zMRc5OLeXQ1EZxQfSrpoqB3BZsrBGRKhWCr9J/qnU=;
        b=q5h/wSLQ54IhHdfloF1JQsl367YdBmGaEDZ0cnhH2TJY2bO/FzWQUWhrAQEeHq2OuQ
         tfiy/9INEduH/BNB9yhHlTCaMdjhTR7HpyZUZwIKNuUaQdIXElTzLYZuROvMD72rRpSP
         CrYl5wWRvL5NxXfkbDc95qb42NyMsLe4BP+ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37zMRc5OLeXQ1EZxQfSrpoqB3BZsrBGRKhWCr9J/qnU=;
        b=UhfEkN0UMCIDlJomzhQX7/3UKREm7tyvchSjBThXywgsajnq8CMjwLdbjcinIQLe7j
         lxWmoo5LS5QwR58VPTHnraJXoECCOiZw4xbmHGm1y22EvRGcoQTSnHjA4eg6nNONTUfD
         FqIk32H8FqaKT7O5Ke3TbCW883DQjM7MDvhKdkvpocSQ+a95RCtVj5x8bRcyFb4i3QUT
         ZP3AkJILkrSJfNIX5EMp9VmjjAcv7jb9fSqmjGRbQzNoT1ZtYiogEmi8i0UdNSYr62ld
         AdPkLiqtQPwonOEh/BFUdOPKOVJLnN5eNVVnshc+xPAWuaK38hewEJo0DtxHLSi0SlCT
         HnaQ==
X-Gm-Message-State: APjAAAXAen9OXiFEFxC91l/DcQjp9eG/SXJsqZx96L3QCiqdYqT8A8hs
        eC7Ujp2kUYzjGhaHpaBYiUF6gxSPpdho6Q==
X-Google-Smtp-Source: APXvYqylfxLeIDA67xo3DLoxeVWI5oA2b3t5Njd8IiyvJgWG5PrfxawnFsDdmwdx+XBWjM/ALyrkWA==
X-Received: by 2002:a17:90a:7148:: with SMTP id g8mr12756345pjs.51.1562158004954;
        Wed, 03 Jul 2019 05:46:44 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:46:44 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/25] arm64/ARM: dts: allwinner: Switch to use SPDX identifier
Date:   Wed,  3 Jul 2019 18:15:44 +0530
Message-Id: <20190703124609.21435-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series to switch all Allwinner dts(i) and associate
files to use SPDX Licence identifier.

Jagan Teki (25):
  arm64: dts: allwinner: Switch A64 dts(i) to use SPDX identifier
  arm64: dts: allwinner: axp803: Switch to use SPDX identifier
  arm64: dts: allwinner: Switch H5 dts(i) to use SPDX identifier
  ARM: dts: sun4i: Switch A10 dts(i) to use SPDX identifier
  ARM: dts: sun5i: Switch A10s dts(i) to use SPDX identifier
  ARM: dts: sun5i: Switch A13 dts(i) to use SPDX identifier
  ARM: dts: sun5i: Switch GR8 dts(i) to use SPDX identifier
  ARM: dts: sun6i: Switch A31 dts(i) to use SPDX identifier
  ARM: dts: sun6i: Switch A31s dts(i) to use SPDX identifier
  ARM: dts: sun7i: Switch A20 dts(i) to use SPDX identifier
  ARM: dts: sun8i: t3-cqa3t-bv3: Remove legacy license text
  ARM: dts: sun8i: Switch A23 dts(i) to use SPDX identifier
  ARM: dts: sun8i: Switch A33 dts(i) to use SPDX identifier
  ARM: dts: sun8i: Switch A83T dts(i) to use SPDX identifier
  ARM: dts: sun8i: Switch H2+ dts to use SPDX identifier
  ARM: dts: sun8i: Switch H3 dts(i) to use SPDX identifier
  ARM: dts: sun8i: Switch R40 dts(i) to use SPDX identifier
  ARM: dts: sun8i: Switch V3s dts(i) to use SPDX identifier
  ARM: dts: sun9i: Switch A80 dts(i) to use SPDX identifier
  ARM: dts: axp152: Switch to use SPDX identifier
  ARM: dts: axp209: Switch to use SPDX identifier
  ARM: dts: axp223: Switch to use SPDX identifier
  ARM: dts: axp22x: Switch to use SPDX identifier
  ARM: dts: axp809: Switch to use SPDX identifier
  ARM: dts: axp81x: Switch to use SPDX identifier

 arch/arm/boot/dts/axp152.dtsi                 | 39 +---------------
 arch/arm/boot/dts/axp209.dtsi                 | 39 +---------------
 arch/arm/boot/dts/axp223.dtsi                 | 39 +---------------
 arch/arm/boot/dts/axp22x.dtsi                 | 39 +---------------
 arch/arm/boot/dts/axp809.dtsi                 | 39 +---------------
 arch/arm/boot/dts/axp81x.dtsi                 | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-a1000.dts         | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts    | 39 +---------------
 .../boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts    | 39 +---------------
 .../boot/dts/sun4i-a10-dserve-dsrv9703c.dts   | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts      | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-hackberry.dts     | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts  | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-inet1.dts         | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts     | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts  | 39 +---------------
 .../dts/sun4i-a10-itead-iteaduino-plus.dts    | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts    | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-marsboard.dts     | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts    | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-mk802.dts         | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts       | 39 +---------------
 .../arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-pcduino.dts       | 39 +---------------
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts      | 39 +---------------
 .../boot/dts/sun4i-a10-pov-protab2-ips9.dts   | 39 +---------------
 arch/arm/boot/dts/sun4i-a10.dtsi              | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts  | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts  | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s-mk802.dts        | 39 +---------------
 .../boot/dts/sun5i-a10s-olinuxino-micro.dts   | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts      | 39 +---------------
 arch/arm/boot/dts/sun5i-a10s.dtsi             | 39 +---------------
 .../boot/dts/sun5i-a13-difrnce-dit4350.dts    | 39 +---------------
 .../dts/sun5i-a13-empire-electronix-d709.dts  | 39 +---------------
 .../dts/sun5i-a13-empire-electronix-m712.dts  | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts      | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts  | 39 +---------------
 .../boot/dts/sun5i-a13-olinuxino-micro.dts    | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts     | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts     | 39 +---------------
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts      | 39 +---------------
 arch/arm/boot/dts/sun5i-a13.dtsi              | 39 +---------------
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts      | 39 +---------------
 arch/arm/boot/dts/sun5i-gr8-evb.dts           | 39 +---------------
 arch/arm/boot/dts/sun5i-gr8.dtsi              | 39 +---------------
 arch/arm/boot/dts/sun5i-r8-chip.dts           | 39 +---------------
 arch/arm/boot/dts/sun5i-r8.dtsi               | 39 +---------------
 .../dts/sun5i-reference-design-tablet.dtsi    | 39 +---------------
 arch/arm/boot/dts/sun5i.dtsi                  | 39 +---------------
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts     | 39 +---------------
 arch/arm/boot/dts/sun6i-a31-colombus.dts      | 39 +---------------
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts   | 39 +---------------
 arch/arm/boot/dts/sun6i-a31-i7.dts            | 39 +---------------
 arch/arm/boot/dts/sun6i-a31-m9.dts            | 39 +---------------
 .../boot/dts/sun6i-a31-mele-a1000g-quad.dts   | 39 +---------------
 arch/arm/boot/dts/sun6i-a31.dtsi              | 39 +---------------
 .../boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 39 +---------------
 arch/arm/boot/dts/sun6i-a31s-cs908.dts        | 39 +---------------
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts    | 39 +---------------
 arch/arm/boot/dts/sun6i-a31s-primo81.dts      | 39 +---------------
 .../arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 39 +---------------
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts      | 39 +---------------
 .../boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   | 39 +---------------
 .../sun6i-a31s-yones-toptech-bs1078-v2.dts    | 39 +---------------
 arch/arm/boot/dts/sun6i-a31s.dtsi             | 39 +---------------
 .../dts/sun6i-reference-design-tablet.dtsi    | 39 +---------------
 .../boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-bananapi.dts      | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-bananapro.dts     | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts   | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts    | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts   | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts     | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts   | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts    | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts     | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-m3.dts            | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-mk808c.dts        | 44 +------------------
 .../arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 39 +---------------
 .../arm/boot/dts/sun7i-a20-olinuxino-lime.dts | 39 +---------------
 .../dts/sun7i-a20-olinuxino-lime2-emmc.dts    | 41 +----------------
 .../boot/dts/sun7i-a20-olinuxino-lime2.dts    | 39 +---------------
 .../dts/sun7i-a20-olinuxino-micro-emmc.dts    | 41 +----------------
 .../boot/dts/sun7i-a20-olinuxino-micro.dts    | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-orangepi.dts      | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts | 39 +---------------
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts      | 39 +---------------
 .../arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 39 +---------------
 .../boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   | 39 +---------------
 arch/arm/boot/dts/sun7i-a20.dtsi              | 39 +---------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          | 39 +---------------
 arch/arm/boot/dts/sun8i-a23-evb.dts           | 39 +---------------
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts      | 39 +---------------
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts      | 39 +---------------
 .../dts/sun8i-a23-polaroid-mid2407pxe03.dts   | 39 +---------------
 .../dts/sun8i-a23-polaroid-mid2809pxe04.dts   | 39 +---------------
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-a23.dtsi              | 39 +---------------
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts    | 39 +---------------
 .../arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts     | 39 +---------------
 .../arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-a33.dtsi              | 39 +---------------
 .../dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 39 +---------------
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 39 +---------------
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 39 +---------------
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-a83t.dtsi             | 39 +---------------
 .../boot/dts/sun8i-h2-plus-orangepi-r1.dts    | 39 +---------------
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 39 +---------------
 .../boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts      | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi        | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts  | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   | 39 +---------------
 .../boot/dts/sun8i-h3-orangepi-pc-plus.dts    | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    | 39 +---------------
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts  | 39 +---------------
 .../arm/boot/dts/sun8i-h3-orangepi-plus2e.dts | 39 +---------------
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-h3.dtsi               | 39 +---------------
 arch/arm/boot/dts/sun8i-q8-common.dtsi        | 39 +---------------
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  | 39 +---------------
 arch/arm/boot/dts/sun8i-r16-parrot.dts        | 39 +---------------
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39 +---------------
 arch/arm/boot/dts/sun8i-r40.dtsi              | 39 +---------------
 .../dts/sun8i-reference-design-tablet.dtsi    | 39 +---------------
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      | 38 ----------------
 .../boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 39 +---------------
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 39 +---------------
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  | 39 +---------------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts   | 39 +---------------
 arch/arm/boot/dts/sun9i-a80-optimus.dts       | 39 +---------------
 arch/arm/boot/dts/sun9i-a80.dtsi              | 39 +---------------
 arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +---------------
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +---------------
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +---------------
 .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +---------------
 .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +---------------
 .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +---------------
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +---------------
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 39 +---------------
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 39 +---------------
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +---------------
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +---------------
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +---------------
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +---------------
 .../allwinner/sun50i-h5-orangepi-prime.dts    | 39 +---------------
 .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +---------------
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +---------------
 162 files changed, 163 insertions(+), 6163 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

