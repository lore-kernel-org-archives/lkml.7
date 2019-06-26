Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A7C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DE2205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfFZNc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:32:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57316 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfFZNcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:32:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DB852009AC;
        Wed, 26 Jun 2019 15:32:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1069F2009AB;
        Wed, 26 Jun 2019 15:32:22 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6078A205DB;
        Wed, 26 Jun 2019 15:32:21 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 00/10] Improvements and fixes for mxsfb DRM driver
Date:   Wed, 26 Jun 2019 16:32:08 +0300
Message-Id: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
and 8QXP). Following, are the new features added and fixes from this
patch-set:

1. Add support for drm_bridge
On 8MQ and 8MM, the LCDIF block is not directly connected to a parallel
display connector, where an LCD panel can be attached, but instead it is
connected to DSI controller. Since this DSI stands between the display
controller (eLCDIF) and the physical connector, the DSI can be implemented
as a DRM bridge. So, in order to be able to connect the mxsfb driver to
the DSI driver, the support for a drm_bridge was needed in mxsfb DRM
driver (the actual driver for the eLCDIF block).

2. Add support for additional pixel formats
Some of the pixel formats needed by Android were not implemented in this
driver, but they were actually supported. So, add support for them.

3. Add support for horizontal stride
Having support for horizontal stride allows the use of eLCDIF with a GPU
(for example) that can only output resolution sizes multiple of a power of
8. For example, 1080 is not a power of 16, so in order to support 1920x1080
output from GPUs that can produce linear buffers only in sizes multiple to 16,
this feature is needed.

3. Few minor features and bug-fixing
The addition of max-res DT property was actually needed in order to limit
the bandwidth usage of the eLCDIF block. This is need on systems where
multiple display controllers are presend and the memory bandwidth is not
enough to handle all of them at maximum capacity (like it is the case on
8MQ, where there are two display controllers: DCSS and eLCDIF).
The rest of the patches are bug-fixes.

Mirela Rabulea (1):
  drm/mxsfb: Signal mode changed when bpp changed

Robert Chiras (9):
  drm/mxsfb: Update mxsfb to support a bridge
  drm/mxsfb: Update mxsfb with additional pixel formats
  drm/mxsfb: Fix the vblank events
  dt-bindings: display: Add max-res property for mxsfb
  drm/mxsfb: Add max-res property for MXSFB
  drm/mxsfb: Update mxsfb to support LCD reset
  drm/mxsfb: Improve the axi clock usage
  drm/mxsfb: Clear OUTSTANDING_REQS bits
  drm/mxsfb: Add support for horizontal stride

 .../devicetree/bindings/display/mxsfb.txt          |   6 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 290 ++++++++++++++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 189 +++++++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  10 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 128 ++++++---
 6 files changed, 531 insertions(+), 118 deletions(-)

-- 
2.7.4

