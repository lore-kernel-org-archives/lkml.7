Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082DC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC0214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfKGNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:50:22 -0500
Received: from verein.lst.de ([213.95.11.211]:57376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGNuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:50:22 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 0A04068BE1; Thu,  7 Nov 2019 14:50:18 +0100 (CET)
From:   Torsten Duwe <duwe@lst.de>
Date:   Mon, 4 Nov 2019 11:34:23 +0100
Subject: [PATCH v5 0/7][rebased] Add anx6345 DP/eDP bridge for Olimex Teres-I
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <20191107135018.0A04068BE1@verein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:21:31PM +0100, Maxime Ripard wrote:
>
> Please resend the whole series rebased on top of either linux-next or
> drm-misc-next.

Here it is. Applies cleanly to both, modulo those patches already in.

	Torsten

---

ANX6345 LVTTL->eDP video bridge, driver with device tree bindings.

Changes since v4:

* enforce DT ports to be nodes and forbid additionalProperties.

Changes since v3:

* converted binding schema file to json-schema ("YAML")
  It now validates (itself and the dts) like a charm ;-)
  Input port0 is mandatory, output port1 is optional.

* Enric Balletbo i Serra waived analogix-anx6345 module ownership to icenowy
  <CAFqH_50s0J_NEevV9b5o-wq-bw+xGaUZ3WyhVDRZKyM2Yn-iVg@mail.gmail.com>
  Since they both agree, I won't interfere.

Changes from v2:

* use SPDX-IDs throughout

* removed the panel output again, as it was not what Maxime had in mind.
  At least the Teres-I does very well without.

* binding clarifications and cosmetic changes as suggested by Andrzej

Changes from v1:

* fixed up copyright information. Most code changes are only moves and thus
  retain copyright and module ownership. Even the new analogix-anx6345.c originates
  from the old 1495-line analogix-anx78xx.c, with 306 insertions and 987 deletions
  (ignoring the trivial anx78xx -> anx6345 replacements) 306 new vs. 508 old...

* fixed all minor formatting issues brought up

* merged previously separate new analogix_dp_i2c module into existing analogix_dp

* split additional defines into a preparatory patch

* renamed the factored-out common functions anx_aux_* -> anx_dp_aux_*, because
  anx_...aux_transfer was exported globally. Besides, it is now GPL-only exported.

* moved chip ID read into a separate function.

* keep the chip powered after a successful probe.
  (There's a good chance that this is the only display during boot!)

* updated the binding document: LVTTL input is now required, only the output side
  description is optional.

 Laurent: I have also looked into the drm_panel_bridge infrastructure,
 but it's not that trivial to convert these drivers to it.

Changes from the respective previous versions:

* the reset polarity is corrected in DT and the driver;
  things should be clearer now.

* as requested, add a panel (the known innolux,n116bge) and connect
  the ports.

* renamed dvdd?? to *-supply to match the established scheme

* trivial update to the #include list, to make it compile in 5.2

Icenowy Zheng (4):
  drm/bridge: move ANA78xx driver to analogix subdirectory
  drm/bridge: split some definitions of ANX78xx to dedicated headers
  drm/bridge: extract some Analogix I2C DP common code
  drm/bridge: Add Analogix anx6345 support

Torsten Duwe (3):
  drm/bridge: Prepare Analogix anx6345 support
  dt-bindings: Add ANX6345 DP/eDP transmitter binding
  arm64: dts: allwinner: a64: enable ANX6345 bridge on Teres-I

 .../bindings/display/bridge/anx6345.yaml           |  92 +++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |  45 +-
 drivers/gpu/drm/bridge/Kconfig                     |  10 -
 drivers/gpu/drm/bridge/Makefile                    |   4 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.h          | 710 ------------------
 drivers/gpu/drm/bridge/analogix/Kconfig            |  22 +
 drivers/gpu/drm/bridge/analogix/Makefile           |   4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 793 +++++++++++++++++++++
 .../drm/bridge/{ => analogix}/analogix-anx78xx.c   | 146 +---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h | 255 +++++++
 .../gpu/drm/bridge/analogix/analogix-i2c-dptx.c    | 165 +++++
 .../gpu/drm/bridge/analogix/analogix-i2c-dptx.h    | 258 +++++++
 .../drm/bridge/analogix/analogix-i2c-txcommon.h    | 236 ++++++
 13 files changed, 1868 insertions(+), 872 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.yaml
 delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
 rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h

-- 
2.16.4

