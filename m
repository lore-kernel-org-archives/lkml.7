Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A0C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BF21850
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCMMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:25:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:62129 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfCMMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:25:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 05:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="133958974"
Received: from pg-eswbuild-angstrom-alpha.png.intel.com ([10.226.214.8])
  by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2019 05:25:52 -0700
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        chin.liang.see@intel.com, Ong@vger.kernel.org
Subject: [PATCHv14 0/3] Intel FPGA Video and Image Processing Suite
Date:   Thu, 14 Mar 2019 04:22:03 +0800
Message-Id: <20190313202206.921-1-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong, Hean Loong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and the DRM driver
patch here is allocating memory for information to be streamed from the
ARM/Linux to the display port.

Basically the driver just wraps the information such as the pixels to be
drawn by the Sodt IP FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs on
the ARM chip and the FGPA is driven by its NIOS soft core with its own
proprietary firmware.

For example the application from the ARM Linux would have to write
information on the /dev/fb0 with the information stored in the
SDRAM to be fetched by the Framebuffer 2 Soft IP and displayed
on the Display Port Monitor.


Ong Hean Loong (1):
  ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite

Ong, Hean Loong (2):
  ARM:dt-bindings:display Intel FPGA Video and Image Processing Suite
  ARM:drm ivip Intel FPGA Video and Image Processing Suite

 .../devicetree/bindings/display/altr,vip-fb2.txt   |   63 ++++
 MAINTAINERS                                        |    9 +
 arch/arm/configs/socfpga_defconfig                 |    8 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/ivip/Kconfig                       |   14 +
 drivers/gpu/drm/ivip/Makefile                      |    6 +
 drivers/gpu/drm/ivip/intel_vip_conn.c              |   93 ++++++
 drivers/gpu/drm/ivip/intel_vip_drv.c               |  335 ++++++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h               |   73 +++++
 10 files changed, 604 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h

