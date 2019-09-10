Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277FDC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BCE2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393931AbfIJPe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:34:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54427 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfIJPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:34:26 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6A030240002;
        Tue, 10 Sep 2019 15:34:23 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 0/2] drm: LogiCVC display controller support
Date:   Tue, 10 Sep 2019 17:34:07 +0200
Message-Id: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the LogiCVC display controller.
The controller is a bit unusual since it is usually loaded as
programmable logic on Xilinx FPGAs or Zynq-7000 SoCs.
More details are presented on the main commit for the driver.

More information about the controller is available on the dedicated
web page: https://www.logicbricks.com/Products/logiCVC-ML.aspx

Cheers!

Paul Kocialkowski (2):
  dt-bindings: display: Add xylon logicvc bindings documentation
  drm: Add support for the LogiCVC display controller

 .../bindings/display/xylon,logicvc.txt        | 188 ++++++
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/logicvc/Kconfig               |   8 +
 drivers/gpu/drm/logicvc/Makefile              |   4 +
 drivers/gpu/drm/logicvc/logicvc_crtc.c        | 272 ++++++++
 drivers/gpu/drm/logicvc/logicvc_crtc.h        |  25 +
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 457 ++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_drm.h         |  60 ++
 drivers/gpu/drm/logicvc/logicvc_interface.c   | 235 +++++++
 drivers/gpu/drm/logicvc/logicvc_interface.h   |  32 +
 drivers/gpu/drm/logicvc/logicvc_layer.c       | 594 ++++++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.h       |  65 ++
 drivers/gpu/drm/logicvc/logicvc_mode.c        | 103 +++
 drivers/gpu/drm/logicvc/logicvc_mode.h        |  15 +
 drivers/gpu/drm/logicvc/logicvc_of.c          | 204 ++++++
 drivers/gpu/drm/logicvc/logicvc_of.h          |  28 +
 drivers/gpu/drm/logicvc/logicvc_regs.h        |  88 +++
 18 files changed, 2381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt
 create mode 100644 drivers/gpu/drm/logicvc/Kconfig
 create mode 100644 drivers/gpu/drm/logicvc/Makefile
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_regs.h

-- 
2.23.0

