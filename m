Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA140C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA9420659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLFJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:53:20 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52468 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLFJxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:53:20 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25AFD1A05F5;
        Fri,  6 Dec 2019 10:53:18 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1878C1A05E1;
        Fri,  6 Dec 2019 10:53:18 +0100 (CET)
Received: from fsr-ub1664-121.ea.freescale.net (fsr-ub1664-121.ea.freescale.net [10.171.82.171])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8826D20395;
        Fri,  6 Dec 2019 10:53:17 +0100 (CET)
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     agx@sigxcpu.org, l.stach@pengutronix.de, lukas@mntmn.com,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add support for iMX8MQ Display Controller Subsystem
Date:   Fri,  6 Dec 2019 11:52:37 +0200
Message-Id: <1575625964-27102-1-git-send-email-laurentiu.palcu@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Changes in v3:
 * rebased to latest linux-next and made it compile as drmP.h was
   removed;
 * removed the patch adding the VIDEO2_PLL clock. It's already applied;
 * removed an unnecessary 50ms sleep in the dcss_dtg_sync_set();
 * fixed a a spurious hang reported by Lukas Hartmann and encountered
   by me several times;
 * mask DPR and DTG interrupts by default, as they may come enabled from
   U-boot;

Changes in v2:
 * Removed '0x' in node's unit-address both in DT and yaml;
 * Made the address region size lowercase, to be consistent;
 * Removed some left-over references to P010;
 * Added a Kconfig dependency of DRM && ARCH_MXC. This will also silence compilation
   issues reported by kbuild for other architectures;


Laurentiu Palcu (4):
  drm/imx: compile imx directory by default
  drm/imx: Add initial support for DCSS on iMX8MQ
  dt-bindings: display: imx: add bindings for DCSS
  arm64: dts: imx8mq: add DCSS node

 .../bindings/display/imx/nxp,imx8mq-dcss.yaml      |  86 +++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  25 +
 drivers/gpu/drm/Makefile                           |   2 +-
 drivers/gpu/drm/imx/Kconfig                        |   2 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   8 +
 drivers/gpu/drm/imx/dcss/Makefile                  |   6 +
 drivers/gpu/drm/imx/dcss/dcss-blkctl.c             |  75 ++
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               | 224 ++++++
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c              | 447 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.c                | 286 +++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.h                | 195 +++++
 drivers/gpu/drm/imx/dcss/dcss-dpr.c                | 550 ++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-drv.c                | 181 +++++
 drivers/gpu/drm/imx/dcss/dcss-dtg.c                | 442 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c                | 322 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.h                |  52 ++
 drivers/gpu/drm/imx/dcss/dcss-plane.c              | 418 +++++++++++
 drivers/gpu/drm/imx/dcss/dcss-scaler.c             | 826 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-ss.c                 | 179 +++++
 20 files changed, 4326 insertions(+), 1 deletion(-)
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

