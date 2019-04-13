Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABDBC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610E921721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ZfoT5Ueb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfDMQz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:55:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:48980 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfDMQyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555174459; bh=moDWgzcoNwIAu2PuifmbBiMMyKLYxeK5+BUvy/lJJ/w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZfoT5Uebg2v6YglpVSojOxyNh2bKErwem3Zj/slqinXMAOo9F7SM880Tt5SMuOeTj
         G/6L6/v9SL0xyFXZ2cGbIq0yN/DQIAWLtJEhGwLd+qt1TKxMnAEvXfW9om1O5zHsJ+
         fHj+jp6NE7Uf9mVK3OAkuhVy3NartbeMAcmk+J0Q=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH v4 0/9] Add support for Orange Pi 3
Date:   Sat, 13 Apr 2019 18:54:09 +0200
Message-Id: <20190413165418.27880-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This series implements support for Xunlong Orange Pi 3 board.

Unfortunately, this board needs some small driver patches, so I have
split the boards DT patch into chunks that require patches for drivers
in various subsystems.

Suggested merging plan/dependencies:

- Pinctrl and stmmac patches are needed for ethernet support.
  (patches 1-5) - these should be ready now
- HDMI support - waits for DT review. (patches 6-8)
- mmc1 pinconf (patch 9) can probably be merged now, too (it will
  certainly be used soon by all the other WiFi featuring boards
  based on H6)

This patch is also needed to not get segfault on boot (it was already
merged): 
  https://lkml.org/lkml/2019/4/5/856

Changes in v2:
- added dt-bindings documentation for the board's compatible string
  (suggested by Clement)
- addressed checkpatch warnings and code formatting issues (on Maxime's
  suggestions)
- stmmac: dropped useless parenthesis, reworded description of the patch
  (suggested by Sergei)
- drop useles dev_info() about the selected io bias voltage
- docummented io voltage bias selection variant macros
- wifi: marked WiFi DTS patch and realted mmc1_pins as "DO NOT MERGE",
  because wifi depends on H6 RTC support that's not merged yet (suggested
  by Clement)
- added missing signed-of-bys
- changed &usb2otg dr_mode to otg, and added a note about VBUS
- improved wording of HDMI driver's DDC power supply patch

Changes in v3:
- dropped already applied patches
- changed pinctrl I/O bias selection constants to enum and renamed
- added /omit-if-no-ref/ to mmc1_pins
- made mmc1_pins default pinconf for mmc1 in H6 dtsi
- move ddc-supply to HDMI connector node, updated patch descriptions,
  changed dt-bindings docs

Changes in v4:
- fix checkpatch warnings/style issues
- use enum in struct sunxi_desc_function for io_bias_cfg_variant
- collected acked-by's
- fix compile error in drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c:156
  caused by missing conversion from has_io_bias_cfg struct member
  (I've kept the acked-by, because it's a trivial change, but feel free
  to object.) (reported by Martin A. on github)
  I did not have A80 pinctrl enabled for some reason, so I did not catch
  this sooner.
- dropped brcm firmware patch (was already applied)
- dropped the wifi dts patch (will re-send after H6 RTC gets merged,
  along with bluetooth support, in a separate series)

Please take a look.

thank you and regards,
  Ondrej Jirman

Icenowy Zheng (2):
  net: stmmac: sun8i: add support for Allwinner H6 EMAC
  net: stmmac: sun8i: force select external PHY when no internal one

Ondrej Jirman (7):
  pinctrl: sunxi: Prepare for alternative bias voltage setting methods
  pinctrl: sunxi: Support I/O bias voltage setting on H6
  arm64: dts: allwinner: orange-pi-3: Enable ethernet
  dt-bindings: display: hdmi-connector: Add DDC power supply
  drm: sun4i: Add support for enabling DDC I2C bus power to dw_hdmi glue
  arm64: dts: allwinner: orange-pi-3: Enable HDMI output
  arm64: dts: allwinner: h6: Add MMC1 pins

 .../display/connector/hdmi-connector.txt      |  1 +
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 79 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 11 +++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         | 61 +++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 21 +++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c     |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c   |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c     |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 56 ++++++++-----
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         | 18 ++++-
 11 files changed, 230 insertions(+), 24 deletions(-)

-- 
2.21.0

