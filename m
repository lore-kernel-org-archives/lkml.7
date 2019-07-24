Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92921873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfGXPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:52:33 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:33530 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGXPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:52:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 3F193FB06;
        Wed, 24 Jul 2019 17:52:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c2rVJsA1noyh; Wed, 24 Jul 2019 17:52:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id E638A43417; Wed, 24 Jul 2019 17:52:26 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 0/3] drm: bridge: Add NWL MIPI DSI host controller support
Date:   Wed, 24 Jul 2019 17:52:23 +0200
Message-Id: <cover.1563983037.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for the NWL MIPI DSI Host controller found on i.MX8
SoCs.

It adds support for the i.MX8MQ but the same IP core can also be found on e.g.
i.MX8QXP. I added the necessary hooks to support other imx8 variants but since
I only have imx8mq boards to test I omitted the platform data for other SoCs.

The code is based on NXPs BSP so I added Robert Chiras as
Co-authored-by. Robert, if this looks sane could you add your
Signed-off-by:?

The most notable changes over the BSP driver are
 - Calculate HS mode timing from phy_configure_opts_mipi_dphy
 - Perform all clock setup via DT
 - Merge nwl-imx and nwl drivers
 - Add B0 silion revision quirk
 - become a bridge driver to hook into mxsfb (from what I read[0] DCSS, which
   also can drive the nwl on the imx8mq will likely not become part of
   imx-display-subsystem so it makes sense to make it drive a bridge for dsi as
   well).
 - Use panel_bridge to attach the panel

This has been tested on a Librem 5 devkit using mxsfb with Robert's patches[1]
and the rocktech-jh057n00900 panel driver. The DCSS can later on also act as
input source too.

Changes from v0:
- Add quirk for IMQ8MQ silicon B0 revision to not mess with the
  system reset controller on power down since enable() won't work
  otherwise.
- Drop devm_free_irq() handled by the device driver core
- Disable tx esc clock after the phy power down to unbreak
  disable/enable (unblank/blank)
- Add ports to dt binding docs
- Select GENERIC_PHY_MIPI_DPHY instead of GENERIC_PHY for
  phy_mipi_dphy_get_default_config
- Select DRM_MIPI_DSI
- Include drm_print.h to fix build on next-20190408
- Drop some debugging messages
- Newline terminate all DRM_ printouts
- Turn component driver into a drm bridge

[0]: https://lists.freedesktop.org/archives/dri-devel/2019-May/219484.html
[1]: https://patchwork.freedesktop.org/series/62822/

Guido Günther (3):
  arm64: imx8mq: add imx8mq iomux-gpr field defines
  dt-bindings: display/bridge: Add binding for IMX NWL mipi dsi host
    controller
  drm/bridge: Add NWL MIPI DSI host controller support

 .../bindings/display/bridge/imx-nwl-dsi.txt   |  89 +++
 drivers/gpu/drm/bridge/Kconfig                |   2 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/imx-nwl/Kconfig        |  15 +
 drivers/gpu/drm/bridge/imx-nwl/Makefile       |   2 +
 drivers/gpu/drm/bridge/imx-nwl/nwl-drv.c      | 529 +++++++++++++
 drivers/gpu/drm/bridge/imx-nwl/nwl-drv.h      |  72 ++
 drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.c      | 745 ++++++++++++++++++
 drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.h      | 111 +++
 include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h  |  62 ++
 10 files changed, 1628 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/Makefile
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/nwl-drv.c
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/nwl-drv.h
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.c
 create mode 100644 drivers/gpu/drm/bridge/imx-nwl/nwl-dsi.h
 create mode 100644 include/linux/mfd/syscon/imx8mq-iomuxc-gpr.h

-- 
2.20.1

