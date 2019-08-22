Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C6AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA43233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfHVKof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:44:35 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34902 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387710AbfHVKoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:44:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DBD26FB03;
        Thu, 22 Aug 2019 12:44:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7msndP5EInss; Thu, 22 Aug 2019 12:44:17 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A14CF4014F; Thu, 22 Aug 2019 12:44:16 +0200 (CEST)
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
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/2] drm: bridge: Add NWL MIPI DSI host controller support
Date:   Thu, 22 Aug 2019 12:44:14 +0200
Message-Id: <cover.1566470526.git.agx@sigxcpu.org>
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
 - Use multiplex framework instead of accessing syscon directly

This has been tested on a Librem 5 devkit using mxsfb with Robert's patches[1]
and the rocktech-jh057n00900 panel driver on next-20190821. The DCSS can later
on also act as input source too.

Changes from v2:
- Per review comments by Rob Herring
  https://lists.freedesktop.org/archives/dri-devel/2019-August/230448.html
  - bindings:
    - Simplify by restricting to fsl,imx8mq-nwl-dsi
    - document reset lines
    - add port@{0,1}
    - use a real compatible string for the panel
    - resets are required
- Per review comments by Arnd Bergmann
  https://lists.freedesktop.org/archives/dri-devel/2019-August/230868.html
  - Don't access iomuxc_gpr regs directly. This allows us to drop the
    first patch in the series with the iomuxc_gpr field defines.
- Per review comments by Laurent Pinchart
    - Fix wording in bindings
- Add mux-controls to bindings
- Don't print error message on dphy probe deferal

Changes from v1:
- Per review comments by Sam Ravnborg
  https://lists.freedesktop.org/archives/dri-devel/2019-July/228130.html
  - Change binding docs to YAML
  - build: Don't always visit imx-nwl/
  - build: Add header-test-y
  - Sort headers according to DRM convention
  - Use drm_display_mode instead of videmode
- Per review comments by Fabio Estevam
  https://lists.freedesktop.org/archives/dri-devel/2019-July/228299.html
  - Don't restrict build to ARCH_MXC
  - Drop unused includes
  - Drop unreachable code in imx_nwl_dsi_bridge_mode_fixup()
  - Drop remaining calls of dev_err() and use DRM_DEV_ERR()
    consistently.
  - Use devm_platform_ioremap_resource()
  - Drop devm_free_irq() in probe() error path
  - Use single line comments where sufficient
  - Use <linux/time64.h> instead of defining USEC_PER_SEC
  - Make input source select imx8 specific
  - Drop <asm/unaligned.h> inclusion (after removal of get_unaligned_le32)
  - Drop all EXPORT_SYMBOL_GPL() for functions used in the same module
    but different source files.
  - Drop nwl_dsi_enable_{rx,tx}_clock() by invoking clk_prepare_enable()
    directly
  - Remove pointless comment
- Laurent Pinchart
  https://lists.freedesktop.org/archives/dri-devel/2019-July/228313.html
  https://lists.freedesktop.org/archives/dri-devel/2019-July/228308.html
  - Drop (on iMX8MQ) unused csr regmap
  - Use NWL_MAX_PLATFORM_CLOCKS everywhere
  - Drop get_unaligned_le32() usage
  - remove duplicate 'for the' in binding docs
  - Don't include unused <linux/clk-provider.h>
  - Don't include unused <linux/component.h>
  - Drop dpms_mode for tracking state, trust the drm layer on that
  - Use pm_runtime_put() instead of pm_runtime_put_sync()
  - Don't overwrite encoder type
  - Make imx_nwl_platform_data const
  - Use the reset controller API instead of open coding that platform specific
    part
  - Use <linux/bitfield.h> intead of making up our own defines
  - name mipi_dsi_transfer less generic: nwl_dsi_transfer
  - ensure clean in .remove by calling mipi_dsi_host_unregister.
  - prefix constants by NWL_DSI_
  - properly format transfer_direction enum
  - simplify platform clock handling
  - Don't modify state in mode_fixup() and use mode_set() instead
  - Drop bridge detach(), already handle by nwl_dsi_host_detach()
  - Drop USE_*_QUIRK() macros
- Drop (for now) unused clock defnitions. 'pixel' and 'bypass' clock will be
  used for i.MX8 SoCs but since they're unused atm drop the definitions - but
  keep the logic to enable/disable several clocks in place since we know we'll
  need it in the future.

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

To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@siol.net>, Lee Jones <lee.jones@linaro.org>, Guido Günther <agx@sigxcpu.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>


Guido Günther (2):
  dt-bindings: display/bridge: Add binding for NWL mipi dsi host
    controller
  drm/bridge: Add NWL MIPI DSI host controller support

 .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++
 drivers/gpu/drm/bridge/Kconfig                |   2 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/nwl-dsi/Kconfig        |  16 +
 drivers/gpu/drm/bridge/nwl-dsi/Makefile       |   4 +
 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.c      | 501 +++++++++++++
 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.h      |  65 ++
 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.c      | 700 ++++++++++++++++++
 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.h      | 112 +++
 9 files changed, 1556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/Makefile
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.c
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-drv.h
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.c
 create mode 100644 drivers/gpu/drm/bridge/nwl-dsi/nwl-dsi.h

-- 
2.20.1

