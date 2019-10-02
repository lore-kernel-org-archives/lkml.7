Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B95C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273021D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfJBOFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:05:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52362 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfJBOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:05:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C7E920067F;
        Wed,  2 Oct 2019 16:05:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B46E200141;
        Wed,  2 Oct 2019 16:05:40 +0200 (CEST)
Received: from fsr-ub1664-121.ea.freescale.net (fsr-ub1664-121.ea.freescale.net [10.171.82.171])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C8B962060C;
        Wed,  2 Oct 2019 16:05:39 +0200 (CEST)
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     agx@sigxcpu.org, l.stach@pengutronix.de,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/5] Add support for iMX8MQ Display Controller Subsystem
Date:   Wed,  2 Oct 2019 17:04:52 +0300
Message-Id: <1570025100-5634-1-git-send-email-laurentiu.palcu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial DCSS support for iMX8MQ chip. Initial support
includes only graphics plane support (no video planes), no HDR10 capabilities,
no graphics decompression (only linear, tiled and super-tiled buffers allowed).

Support for the rest of the features will be added incrementally, in subsequent
patches.

The patchset was tested with both HDP driver (not yet upstreamed) and MIPI-DSI
(drivers already on the dri-devel ML).

Thanks,
Laurentiu

Changes in v2:
 * Removed '0x' in node's unit-address both in DT and yaml;
 * Made the address region size lowercase, to be consistent;
 * Removed some left-over references to P010;
 * Added a Kconfig dependency of DRM && ARCH_MXC. This will also silence compilation
   issues reported by kbuild for other architectures;


Laurentiu Palcu (5):
  clk: imx8mq: Add VIDEO2_PLL clock
  drm/imx: compile imx directory by default
  drm/imx: Add initial support for DCSS on iMX8MQ
  dt-bindings: display: imx: add bindings for DCSS
  arm64: dts: imx8mq: add DCSS node

 .../bindings/display/imx/nxp,imx8mq-dcss.yaml      |  86 +++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  25 +
 drivers/clk/imx/clk-imx8mq.c                       |   4 +
 drivers/gpu/drm/Makefile                           |   2 +-
 drivers/gpu/drm/imx/Kconfig                        |   2 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   8 +
 drivers/gpu/drm/imx/dcss/Makefile                  |   6 +
 drivers/gpu/drm/imx/dcss/dcss-blkctl.c             |  75 ++
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               | 223 ++++++
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c              | 447 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.c                | 286 +++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.h                | 195 +++++
 drivers/gpu/drm/imx/dcss/dcss-dpr.c                | 548 ++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-drv.c                | 182 +++++
 drivers/gpu/drm/imx/dcss/dcss-dtg.c                | 438 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c                | 321 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.h                |  52 ++
 drivers/gpu/drm/imx/dcss/dcss-plane.c              | 418 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-scaler.c             | 826 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-ss.c                 | 179 +++++
 include/dt-bindings/clock/imx8mq-clock.h           |   4 +-
 22 files changed, 4326 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
 create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
 create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
 create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c

-- 
2.7.4

