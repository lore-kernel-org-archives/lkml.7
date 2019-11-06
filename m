Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEB3C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AE214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfKFMCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:02:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfKFMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:02:43 -0500
Received: from floko.floko.floko (unknown [IPv6:2804:431:c7f1:970a:5c8b:9def:467e:dc3f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E468028FC08;
        Wed,  6 Nov 2019 12:02:17 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-media@vger.kernel.org, eddie.cai.linux@gmail.com,
        mchehab@kernel.org, heiko@sntech.de, gregkh@linuxfoundation.org,
        jeffy.chen@rock-chips.com, zyc@rock-chips.com,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@linux.intel.com, kernel@collabora.com,
        ezequiel@collabora.com, linux-arm-kernel@lists.infradead.org,
        zhengsq@rock-chips.com, Helen Koike <helen.koike@collabora.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
Subject: [PATCH v9 3/4] media: staging: rkisp1: add Rockchip ISP1 driver
Date:   Wed,  6 Nov 2019 09:01:31 -0300
Message-Id: <20191106120132.6876-4-helen.koike@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191106120132.6876-1-helen.koike@collabora.com>
References: <20191106120132.6876-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Rockchip ISP1 driver to the staging tree.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Yichong Zhong <zyc@rock-chips.com>
Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
Signed-off-by: Allon Huang <allon.huang@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
[fixed unknown entity type / switched to PIXEL_RATE]
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
[fixed compilation and run time errors regarding new v4l2 async API]
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[refactored for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

Changes in v9:
- Move to staging
- Previous patch series had a patch for file and the last commit would
add the Makefile bits to make it compile. But one file was dependent on
each other, so it doesn't make much sense to have a patch for each file
and it doesn't make it easier to review.
* capture.c
        - replace v4l2_{dgb,info,warn,err} by dev_*
* isp_stats.c
        - replace v4l2_{dgb,info,warn,err} by dev_*
        - remove LOG_ISR_EXE_TIME ifndef's
        - constify ops structs
        - s/strlcpy/strscpy
        - add missing mutex_destroy() calls in rkisp1_register_stats_vdev error path
* rkisp1:
        - replace v4l2_{dgb,info,warn,err} by dev_*
        - fix error returned in link_validate
        - remove s_power() callback
        - add regwrite/regread wrappers
        - add macros RKISP1_DEF_SRC_PAD_FMT/RKISP1_DEF_SINK_PAD_FMT
        - several minor cleanups
        - s/RKISP1_ISP_PAD_SINK([^_])/RKISP1_ISP_PAD_SINK_VIDEO\1/
        - merge tables rkisp1_isp_input_formats and rkisp1_isp_output_formats
        - in_fmt and out_fmt as pointers
        - simply struct rkisp1_isp_subdev to work correctly with try format
        - fix crop/fmt propagation
* dev.h / dev.c / regs.c / regs.h / common.h
        - replace v4l2_{dgb,info,warn,err} by dev_*
        - s/pr_info/dev_dbg
        - s/int size/unsigned int size
        - remove module param rkisp1_debug
        - coding style fixes
        - fix error in subdev_notifier_bound, check dphy before assigning to sensor->dphy
        - remove subdevs fixed size array from rkisp1_pipeline
        - remove sensors list, as it can be identified from the media topology
        - Kconfig: add COMPILE_TEST in the dependency
        - use v4l2_pipeline_pm_use and remove _isp_pipeline_s_power() and _subdev_set_power()
        - remove struct rkisp1_pipeline and retrieve pipeline information from the media framework
        - remove remaining rk3288 code
        - cache pixel rate control in sctruct sensor_async_subdev
        - remove enum rkisp1_sd_type

Please see a more complete history of changes at
https://patchwork.kernel.org/cover/11066499/

 drivers/staging/media/Kconfig                 |    2 +
 drivers/staging/media/Makefile                |    1 +
 drivers/staging/media/phy-rockchip-dphy/TODO  |    3 +
 .../bindings/media/rockchip-isp1.txt          |   71 +
 .../bindings/media/rockchip-mipi-dphy.txt     |   38 +
 .../uapi/v4l/pixfmt-meta-rkisp1-params.rst    |   23 +
 .../uapi/v4l/pixfmt-meta-rkisp1-stat.rst      |   22 +
 drivers/staging/media/rkisp1/Kconfig          |   13 +
 drivers/staging/media/rkisp1/Makefile         |    7 +
 drivers/staging/media/rkisp1/TODO             |   20 +
 drivers/staging/media/rkisp1/capture.c        | 1869 +++++++++++++++++
 drivers/staging/media/rkisp1/capture.h        |  164 ++
 drivers/staging/media/rkisp1/common.h         |   98 +
 drivers/staging/media/rkisp1/dev.c            |  439 ++++
 drivers/staging/media/rkisp1/dev.h            |   67 +
 drivers/staging/media/rkisp1/isp_params.c     | 1604 ++++++++++++++
 drivers/staging/media/rkisp1/isp_params.h     |   50 +
 drivers/staging/media/rkisp1/isp_stats.c      |  494 +++++
 drivers/staging/media/rkisp1/isp_stats.h      |   60 +
 drivers/staging/media/rkisp1/regs.c           |  224 ++
 drivers/staging/media/rkisp1/regs.h           | 1525 ++++++++++++++
 drivers/staging/media/rkisp1/rkisp1.c         | 1246 +++++++++++
 drivers/staging/media/rkisp1/rkisp1.h         |   97 +
 .../staging/media/rkisp1/uapi/rkisp1-config.h |  815 +++++++
 24 files changed, 8952 insertions(+)
 create mode 100644 drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.txt
 create mode 100644 drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
 create mode 100644 drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
 create mode 100644 drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
 create mode 100644 drivers/staging/media/rkisp1/Kconfig
 create mode 100644 drivers/staging/media/rkisp1/Makefile
 create mode 100644 drivers/staging/media/rkisp1/TODO
 create mode 100644 drivers/staging/media/rkisp1/capture.c
 create mode 100644 drivers/staging/media/rkisp1/capture.h
 create mode 100644 drivers/staging/media/rkisp1/common.h
 create mode 100644 drivers/staging/media/rkisp1/dev.c
 create mode 100644 drivers/staging/media/rkisp1/dev.h
 create mode 100644 drivers/staging/media/rkisp1/isp_params.c
 create mode 100644 drivers/staging/media/rkisp1/isp_params.h
 create mode 100644 drivers/staging/media/rkisp1/isp_stats.c
 create mode 100644 drivers/staging/media/rkisp1/isp_stats.h
 create mode 100644 drivers/staging/media/rkisp1/regs.c
 create mode 100644 drivers/staging/media/rkisp1/regs.h
 create mode 100644 drivers/staging/media/rkisp1/rkisp1.c
 create mode 100644 drivers/staging/media/rkisp1/rkisp1.h
 create mode 100644 drivers/staging/media/rkisp1/uapi/rkisp1-config.h

diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index a47484473883..db467c5c2fd2 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -40,4 +40,6 @@ source "drivers/staging/media/soc_camera/Kconfig"
 
 source "drivers/staging/media/phy-rockchip-dphy/Kconfig"
 
+source "drivers/staging/media/rkisp1/Kconfig"
+
 endif
diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index b0eae3906208..1beb9a6374b0 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_VIDEO_HANTRO)	+= hantro/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
 obj-$(CONFIG_SOC_CAMERA)	+= soc_camera/
 obj-$(CONFIG_PHY_ROCKCHIP_DPHY)		+= phy-rockchip-dphy/
+obj-$(CONFIG_VIDEO_ROCKCHIP_ISP1)	+= rkisp1/
diff --git a/drivers/staging/media/phy-rockchip-dphy/TODO b/drivers/staging/media/phy-rockchip-dphy/TODO
index 9003af535dc3..e1fda55babef 100644
--- a/drivers/staging/media/phy-rockchip-dphy/TODO
+++ b/drivers/staging/media/phy-rockchip-dphy/TODO
@@ -1,3 +1,6 @@
 The major reason for keeping this in staging is because the only driver
 who uses this is rkisp1 who is also in staging. It should be moved together
 rkisp1.
+
+Please CC patches to Linux Media <linux-media@vger.kernel.org> and
+Helen Koike <helen.koike@collabora.com>.
diff --git a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.txt b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.txt
new file mode 100644
index 000000000000..eaeb838876f5
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-isp1.txt
@@ -0,0 +1,71 @@
+Rockchip SoC Image Signal Processing unit v1
+--------------------------------------------
+
+Rockchip ISP1 is the Camera interface for the Rockchip series of SoCs
+which contains image processing, scaling, and compression funcitons.
+
+Required properties:
+- compatible: value should be one of the following
+	"rockchip,rk3288-cif-isp";
+	"rockchip,rk3399-cif-isp";
+- reg : offset and length of the register set for the device.
+- interrupts: should contain ISP interrupt.
+- clocks: phandle to the required clocks.
+- clock-names: required clock name.
+- iommus: required a iommu node.
+- phys: the phandle for the PHY port
+- phy-names: must contain "dphy"
+
+port node
+---------
+
+The device node should contain one 'ports' child node, with children 'port'
+with child 'endpoint'.
+nodes, according to the bindings defined in Documentation/devicetree/bindings/
+media/video-interfaces.txt.
+
+- endpoint(mipi):
+	- remote-endpoint: Connecting to Rockchip MIPI-DPHY,
+		which is defined in rockchip-mipi-dphy.txt.
+
+The port node must contain at least one endpoint, either parallel or mipi.
+It could have multiple endpoints, but please note the hardware don't support
+two sensors work at a time, they are supposed to work asynchronously.
+
+Device node example
+-------------------
+
+	isp0: isp0@ff910000 {
+		compatible = "rockchip,rk3399-cif-isp";
+		reg = <0x0 0xff910000 0x0 0x4000>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_ISP0>,
+			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
+			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
+		clock-names = "clk_isp",
+			      "aclk_isp", "aclk_isp_wrap",
+			      "hclk_isp", "hclk_isp_wrap";
+		power-domains = <&power RK3399_PD_ISP0>;
+		iommus = <&isp0_mmu>;
+		phys = <&dphy>;
+		phy-names = "dphy";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				mipi_in_wcam: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&wcam_out>;
+					data-lanes = <1 2>;
+				};
+
+				mipi_in_ucam: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&ucam_out>;
+					data-lanes = <1>;
+				};
+			};
+		};
+	};
diff --git a/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
new file mode 100644
index 000000000000..0a0be7b15a59
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Documentation/devicetree/bindings/media/rockchip-mipi-dphy.txt
@@ -0,0 +1,38 @@
+Rockchip SoC MIPI RX D-PHY
+--------------------------
+
+Required properties:
+- compatible: value should be one of the following
+	"rockchip,rk3288-mipi-dphy"
+	"rockchip,rk3399-mipi-dphy"
+- clocks : list of clock specifiers, corresponding to entries in
+	clock-names property;
+- clock-names: required clock name.
+- #phy-cells: Number of cells in a PHY specifier; Should be 0.
+
+MIPI RX D-PHY use registers in "general register files", it
+should be a child of the GRF.
+
+Optional properties:
+- reg: offset and length of the register set for the device.
+- rockchip,grf: MIPI TX1RX1 D-PHY not only has its own register but also
+		the GRF, so it is only necessary for MIPI TX1RX1 D-PHY.
+
+Device node example
+-------------------
+
+grf: syscon@ff770000 {
+	compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
+
+...
+
+	dphy: mipi-dphy {
+		compatible = "rockchip,rk3399-mipi-dphy";
+		clocks = <&cru SCLK_MIPIDPHY_REF>,
+			<&cru SCLK_DPHY_RX0_CFG>,
+			<&cru PCLK_VIO_GRF>;
+		clock-names = "dphy-ref", "dphy-cfg", "grf";
+		power-domains = <&power RK3399_PD_VIO>;
+		#phy-cells = <0>;
+	};
+};
diff --git a/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst b/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
new file mode 100644
index 000000000000..103b5cb79b7c
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+.. _v4l2-meta-fmt-rkisp1-params:
+
+============================
+V4L2_META_FMT_RK_ISP1_PARAMS
+============================
+
+Rockchip ISP1 Parameters Data
+
+Description
+===========
+
+This format describes input parameters for the Rockchip ISP1.
+
+It uses c-struct :c:type:`rkisp1_isp_params_cfg`, which is defined in
+the ``linux/rkisp1-config.h`` header file.
+
+The parameters consist of multiple modules.
+The module won't be updated if the corresponding bit was not set in module_*_update.
+
+.. kernel-doc:: include/uapi/linux/rkisp1-config.h
+   :functions: rkisp1_isp_params_cfg
diff --git a/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst b/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
new file mode 100644
index 000000000000..4ad303f96421
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+.. _v4l2-meta-fmt-rkisp1-stat:
+
+=============================
+V4L2_META_FMT_RK_ISP1_STAT_3A
+=============================
+
+
+Rockchip ISP1 Statistics Data
+
+Description
+===========
+
+This format describes image color statistics information generated by the Rockchip
+ISP1.
+
+It uses c-struct :c:type:`rkisp1_stat_buffer`, which is defined in
+the ``linux/rkisp1-config.h`` header file.
+
+.. kernel-doc:: include/uapi/linux/rkisp1-config.h
+   :functions: rkisp1_stat_buffer
diff --git a/drivers/staging/media/rkisp1/Kconfig b/drivers/staging/media/rkisp1/Kconfig
new file mode 100644
index 000000000000..1de53ebcd510
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_ROCKCHIP_ISP1
+	tristate "Rockchip Image Signal Processing v1 Unit driver"
+	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_FWNODE
+	select PHY_ROCKCHIP_DPHY
+	default n
+	---help---
+	  Support for ISP1 on the rockchip SoC.
diff --git a/drivers/staging/media/rkisp1/Makefile b/drivers/staging/media/rkisp1/Makefile
new file mode 100644
index 000000000000..72706e80fc8b
--- /dev/null
+++ b/drivers/staging/media/rkisp1/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_VIDEO_ROCKCHIP_ISP1) += 	rockchip-isp1.o
+rockchip-isp1-objs 	   += 	rkisp1.o \
+				dev.o \
+				regs.o \
+				isp_stats.o \
+				isp_params.o \
+				capture.o
diff --git a/drivers/staging/media/rkisp1/TODO b/drivers/staging/media/rkisp1/TODO
new file mode 100644
index 000000000000..10f2061700d8
--- /dev/null
+++ b/drivers/staging/media/rkisp1/TODO
@@ -0,0 +1,20 @@
+* Implement resizer subdevice.
+* Fix serialization on subdev ops.
+* Reject out of range hsfreq in rockchip_dphy_configure().
+* Don't use v4l2_async_notifier_parse_fwnode_endpoints_by_port().
+e.g. isp_parse_of_endpoints in drivers/media/platform/omap3isp/isp.c
+cio2_parse_firmware in drivers/media/pci/intel/ipu3/ipu3-cio2.c.
+* Fix race conditions when interrupt get delayed
+* Fix pad format size for statistics and parameters entities.
+* Cleanup link_validate to use v4l2_subdev_link_validate_default()
+* Documentation for uapi
+* Use threaded interrupt for rkisp1_stats_isr()
+* Fix reloading the module
+* Fix checkpatch errors
+
+NOTES:
+* All v4l2-compliance test must pass.
+* Stats and params can be tested with libcamera and ChromiumOS stack.
+
+Please CC patches to Linux Media <linux-media@vger.kernel.org> and
+Helen Koike <helen.koike@collabora.com>.
diff --git a/drivers/staging/media/rkisp1/capture.c b/drivers/staging/media/rkisp1/capture.c
new file mode 100644
index 000000000000..67d2c6efcd58
--- /dev/null
+++ b/drivers/staging/media/rkisp1/capture.c
@@ -0,0 +1,1869 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - V4l capture device
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-subdev.h>
+#include <media/videobuf2-dma-contig.h>
+
+#include "dev.h"
+#include "regs.h"
+
+/*
+ * NOTE:
+ * 1. There are two capture video devices in rkisp1, selfpath and mainpath
+ * 2. Two capture device have separated memory-interface/crop/scale units.
+ * 3. Besides describing stream hardware, this file also contain entries
+ *    for pipeline operations.
+ * 4. The register read/write operations in this file are put into regs.c.
+ */
+
+/*
+ * differences between selfpatch and mainpath
+ * available mp sink input: isp
+ * available sp sink input : isp, dma(TODO)
+ * available mp sink pad fmts: yuv422, raw
+ * available sp sink pad fmts: yuv422, yuv420......
+ * available mp source fmts: yuv, raw, jpeg(TODO)
+ * available sp source fmts: yuv, rgb
+ */
+
+#define CIF_ISP_REQ_BUFS_MIN 1
+#define CIF_ISP_REQ_BUFS_MAX 8
+
+#define STREAM_PAD_SINK				0
+#define STREAM_PAD_SOURCE			1
+
+#define STREAM_MAX_MP_RSZ_OUTPUT_WIDTH		4416
+#define STREAM_MAX_MP_RSZ_OUTPUT_HEIGHT		3312
+#define STREAM_MAX_SP_RSZ_OUTPUT_WIDTH		1920
+#define STREAM_MAX_SP_RSZ_OUTPUT_HEIGHT		1920
+#define STREAM_MIN_RSZ_OUTPUT_WIDTH		32
+#define STREAM_MIN_RSZ_OUTPUT_HEIGHT		16
+
+#define STREAM_MAX_MP_SP_INPUT_WIDTH STREAM_MAX_MP_RSZ_OUTPUT_WIDTH
+#define STREAM_MAX_MP_SP_INPUT_HEIGHT STREAM_MAX_MP_RSZ_OUTPUT_HEIGHT
+#define STREAM_MIN_MP_SP_INPUT_WIDTH		32
+#define STREAM_MIN_MP_SP_INPUT_HEIGHT		32
+
+/* Get xsubs and ysubs for fourcc formats
+ *
+ * @xsubs: horizontal color samples in a 4*4 matrix, for yuv
+ * @ysubs: vertical color samples in a 4*4 matrix, for yuv
+ */
+static int fcc_xysubs(u32 fcc, u32 *xsubs, u32 *ysubs)
+{
+	switch (fcc) {
+	case V4L2_PIX_FMT_GREY:
+	case V4L2_PIX_FMT_YUV444M:
+		*xsubs = 1;
+		*ysubs = 1;
+		break;
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_VYUY:
+	case V4L2_PIX_FMT_YUV422P:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+	case V4L2_PIX_FMT_YVU422M:
+		*xsubs = 2;
+		*ysubs = 1;
+		break;
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21M:
+	case V4L2_PIX_FMT_NV12M:
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		*xsubs = 2;
+		*ysubs = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mbus_code_xysubs(u32 code, u32 *xsubs, u32 *ysubs)
+{
+	switch (code) {
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+	case MEDIA_BUS_FMT_YVYU8_1X16:
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_VYUY8_1X16:
+		*xsubs = 2;
+		*ysubs = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mbus_code_sp_in_fmt(u32 code, u32 *format)
+{
+	switch (code) {
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+		*format = MI_CTRL_SP_INPUT_YUV422;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct capture_fmt mp_fmts[] = {
+	/* yuv422 */
+	{
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUVINT,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVYU,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUVINT,
+	}, {
+		.fourcc = V4L2_PIX_FMT_VYUY,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUVINT,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUV422P,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV16,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV61,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVU422M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 3,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	},
+	/* yuv420 */
+	{
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV21M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 2,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV12M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 2,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_SPLA,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUV420,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVU420,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	},
+	/* yuv444 */
+	{
+		.fourcc = V4L2_PIX_FMT_YUV444M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 3,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	},
+	/* yuv400 */
+	{
+		.fourcc = V4L2_PIX_FMT_GREY,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_MP_WRITE_YUVINT,
+	},
+	/* raw */
+	{
+		.fourcc = V4L2_PIX_FMT_SRGGB8,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 8 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG8,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 8 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG8,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 8 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR8,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 8 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 10 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG10,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 10 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG10,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 10 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR10,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 10 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 12 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG12,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 12 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG12,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 12 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR12,
+		.fmt_type = FMT_BAYER,
+		.bpp = { 12 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_MP_WRITE_RAW12,
+	},
+};
+
+static const struct capture_fmt sp_fmts[] = {
+	/* yuv422 */
+	{
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_INT,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVYU,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_INT,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_VYUY,
+		.fmt_type = FMT_YUV,
+		.bpp = { 16 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_INT,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUV422P,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV16,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV61,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVU422M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 3,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV422,
+	},
+	/* yuv420 */
+	{
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV21M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 2,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV12M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 16 },
+		.cplanes = 2,
+		.mplanes = 2,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_SPLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUV420,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YVU420,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 1,
+		.uv_swap = 1,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV420,
+	},
+	/* yuv444 */
+	{
+		.fourcc = V4L2_PIX_FMT_YUV444M,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8, 8, 8 },
+		.cplanes = 3,
+		.mplanes = 3,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV444,
+	},
+	/* yuv400 */
+	{
+		.fourcc = V4L2_PIX_FMT_GREY,
+		.fmt_type = FMT_YUV,
+		.bpp = { 8 },
+		.cplanes = 1,
+		.mplanes = 1,
+		.uv_swap = 0,
+		.write_format = MI_CTRL_SP_WRITE_INT,
+		.output_format = MI_CTRL_SP_OUTPUT_YUV400,
+	},
+	/* rgb */
+	{
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.fmt_type = FMT_RGB,
+		.bpp = { 24 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_RGB888,
+	}, {
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.fmt_type = FMT_RGB,
+		.bpp = { 16 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_RGB565,
+	}, {
+		.fourcc = V4L2_PIX_FMT_BGR666,
+		.fmt_type = FMT_RGB,
+		.bpp = { 18 },
+		.mplanes = 1,
+		.write_format = MI_CTRL_SP_WRITE_PLA,
+		.output_format = MI_CTRL_SP_OUTPUT_RGB666,
+	},
+};
+
+static struct stream_config rkisp1_mp_stream_config = {
+	.fmts = mp_fmts,
+	.fmt_size = ARRAY_SIZE(mp_fmts),
+	/* constraints */
+	.max_rsz_width = STREAM_MAX_MP_RSZ_OUTPUT_WIDTH,
+	.max_rsz_height = STREAM_MAX_MP_RSZ_OUTPUT_HEIGHT,
+	.min_rsz_width = STREAM_MIN_RSZ_OUTPUT_WIDTH,
+	.min_rsz_height = STREAM_MIN_RSZ_OUTPUT_HEIGHT,
+	/* registers */
+	.rsz = {
+		.ctrl = CIF_MRSZ_CTRL,
+		.scale_hy = CIF_MRSZ_SCALE_HY,
+		.scale_hcr = CIF_MRSZ_SCALE_HCR,
+		.scale_hcb = CIF_MRSZ_SCALE_HCB,
+		.scale_vy = CIF_MRSZ_SCALE_VY,
+		.scale_vc = CIF_MRSZ_SCALE_VC,
+		.scale_lut = CIF_MRSZ_SCALE_LUT,
+		.scale_lut_addr = CIF_MRSZ_SCALE_LUT_ADDR,
+		.scale_hy_shd = CIF_MRSZ_SCALE_HY_SHD,
+		.scale_hcr_shd = CIF_MRSZ_SCALE_HCR_SHD,
+		.scale_hcb_shd = CIF_MRSZ_SCALE_HCB_SHD,
+		.scale_vy_shd = CIF_MRSZ_SCALE_VY_SHD,
+		.scale_vc_shd = CIF_MRSZ_SCALE_VC_SHD,
+		.phase_hy = CIF_MRSZ_PHASE_HY,
+		.phase_hc = CIF_MRSZ_PHASE_HC,
+		.phase_vy = CIF_MRSZ_PHASE_VY,
+		.phase_vc = CIF_MRSZ_PHASE_VC,
+		.ctrl_shd = CIF_MRSZ_CTRL_SHD,
+		.phase_hy_shd = CIF_MRSZ_PHASE_HY_SHD,
+		.phase_hc_shd = CIF_MRSZ_PHASE_HC_SHD,
+		.phase_vy_shd = CIF_MRSZ_PHASE_VY_SHD,
+		.phase_vc_shd = CIF_MRSZ_PHASE_VC_SHD,
+	},
+	.dual_crop = {
+		.ctrl = CIF_DUAL_CROP_CTRL,
+		.yuvmode_mask = CIF_DUAL_CROP_MP_MODE_YUV,
+		.rawmode_mask = CIF_DUAL_CROP_MP_MODE_RAW,
+		.h_offset = CIF_DUAL_CROP_M_H_OFFS,
+		.v_offset = CIF_DUAL_CROP_M_V_OFFS,
+		.h_size = CIF_DUAL_CROP_M_H_SIZE,
+		.v_size = CIF_DUAL_CROP_M_V_SIZE,
+	},
+	.mi = {
+		.y_size_init = CIF_MI_MP_Y_SIZE_INIT,
+		.cb_size_init = CIF_MI_MP_CB_SIZE_INIT,
+		.cr_size_init = CIF_MI_MP_CR_SIZE_INIT,
+		.y_base_ad_init = CIF_MI_MP_Y_BASE_AD_INIT,
+		.cb_base_ad_init = CIF_MI_MP_CB_BASE_AD_INIT,
+		.cr_base_ad_init = CIF_MI_MP_CR_BASE_AD_INIT,
+		.y_offs_cnt_init = CIF_MI_MP_Y_OFFS_CNT_INIT,
+		.cb_offs_cnt_init = CIF_MI_MP_CB_OFFS_CNT_INIT,
+		.cr_offs_cnt_init = CIF_MI_MP_CR_OFFS_CNT_INIT,
+	},
+};
+
+static struct stream_config rkisp1_sp_stream_config = {
+	.fmts = sp_fmts,
+	.fmt_size = ARRAY_SIZE(sp_fmts),
+	/* constraints */
+	.max_rsz_width = STREAM_MAX_SP_RSZ_OUTPUT_WIDTH,
+	.max_rsz_height = STREAM_MAX_SP_RSZ_OUTPUT_HEIGHT,
+	.min_rsz_width = STREAM_MIN_RSZ_OUTPUT_WIDTH,
+	.min_rsz_height = STREAM_MIN_RSZ_OUTPUT_HEIGHT,
+	/* registers */
+	.rsz = {
+		.ctrl = CIF_SRSZ_CTRL,
+		.scale_hy = CIF_SRSZ_SCALE_HY,
+		.scale_hcr = CIF_SRSZ_SCALE_HCR,
+		.scale_hcb = CIF_SRSZ_SCALE_HCB,
+		.scale_vy = CIF_SRSZ_SCALE_VY,
+		.scale_vc = CIF_SRSZ_SCALE_VC,
+		.scale_lut = CIF_SRSZ_SCALE_LUT,
+		.scale_lut_addr = CIF_SRSZ_SCALE_LUT_ADDR,
+		.scale_hy_shd = CIF_SRSZ_SCALE_HY_SHD,
+		.scale_hcr_shd = CIF_SRSZ_SCALE_HCR_SHD,
+		.scale_hcb_shd = CIF_SRSZ_SCALE_HCB_SHD,
+		.scale_vy_shd = CIF_SRSZ_SCALE_VY_SHD,
+		.scale_vc_shd = CIF_SRSZ_SCALE_VC_SHD,
+		.phase_hy = CIF_SRSZ_PHASE_HY,
+		.phase_hc = CIF_SRSZ_PHASE_HC,
+		.phase_vy = CIF_SRSZ_PHASE_VY,
+		.phase_vc = CIF_SRSZ_PHASE_VC,
+		.ctrl_shd = CIF_SRSZ_CTRL_SHD,
+		.phase_hy_shd = CIF_SRSZ_PHASE_HY_SHD,
+		.phase_hc_shd = CIF_SRSZ_PHASE_HC_SHD,
+		.phase_vy_shd = CIF_SRSZ_PHASE_VY_SHD,
+		.phase_vc_shd = CIF_SRSZ_PHASE_VC_SHD,
+	},
+	.dual_crop = {
+		.ctrl = CIF_DUAL_CROP_CTRL,
+		.yuvmode_mask = CIF_DUAL_CROP_SP_MODE_YUV,
+		.rawmode_mask = CIF_DUAL_CROP_SP_MODE_RAW,
+		.h_offset = CIF_DUAL_CROP_S_H_OFFS,
+		.v_offset = CIF_DUAL_CROP_S_V_OFFS,
+		.h_size = CIF_DUAL_CROP_S_H_SIZE,
+		.v_size = CIF_DUAL_CROP_S_V_SIZE,
+	},
+	.mi = {
+		.y_size_init = CIF_MI_SP_Y_SIZE_INIT,
+		.cb_size_init = CIF_MI_SP_CB_SIZE_INIT,
+		.cr_size_init = CIF_MI_SP_CR_SIZE_INIT,
+		.y_base_ad_init = CIF_MI_SP_Y_BASE_AD_INIT,
+		.cb_base_ad_init = CIF_MI_SP_CB_BASE_AD_INIT,
+		.cr_base_ad_init = CIF_MI_SP_CR_BASE_AD_INIT,
+		.y_offs_cnt_init = CIF_MI_SP_Y_OFFS_CNT_INIT,
+		.cb_offs_cnt_init = CIF_MI_SP_CB_OFFS_CNT_INIT,
+		.cr_offs_cnt_init = CIF_MI_SP_CR_OFFS_CNT_INIT,
+	},
+};
+
+static const
+struct capture_fmt *find_fmt(struct rkisp1_stream *stream, const u32 pixelfmt)
+{
+	const struct capture_fmt *fmt;
+	unsigned int i;
+
+	for (i = 0; i < stream->config->fmt_size; i++) {
+		fmt = &stream->config->fmts[i];
+		if (fmt->fourcc == pixelfmt)
+			return fmt;
+	}
+	return NULL;
+}
+
+/* configure dual-crop unit */
+static int rkisp1_config_dcrop(struct rkisp1_stream *stream, bool async)
+{
+	struct rkisp1_device *dev = stream->ispdev;
+	struct v4l2_rect *dcrop = &stream->dcrop;
+	const struct v4l2_rect *input_win;
+
+	/* dual-crop unit get data from ISP */
+	input_win = rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					       RKISP1_ISP_PAD_SINK_VIDEO,
+					       V4L2_SUBDEV_FORMAT_ACTIVE);
+
+	if (dcrop->width == input_win->width &&
+	    dcrop->height == input_win->height &&
+	    dcrop->left == 0 && dcrop->top == 0) {
+		disable_dcrop(stream, async);
+		dev_dbg(dev->dev, "stream %d crop disabled\n", stream->id);
+		return 0;
+	}
+
+	config_dcrop(stream, dcrop, async);
+
+	dev_dbg(dev->dev, "stream %d crop: %dx%d -> %dx%d\n", stream->id,
+		input_win->width, input_win->height,
+		dcrop->width, dcrop->height);
+
+	return 0;
+}
+
+/* configure scale unit */
+static int rkisp1_config_rsz(struct rkisp1_stream *stream, bool async)
+{
+	struct rkisp1_device *dev = stream->ispdev;
+	struct v4l2_pix_format_mplane output_fmt = stream->out_fmt;
+	struct capture_fmt *output_isp_fmt = &stream->out_isp_fmt;
+	const struct rkisp1_fmt *input_isp_fmt = dev->isp_sdev.out_fmt;
+	struct v4l2_rect in_y, in_c, out_y, out_c;
+	u32 xsubs_in, ysubs_in, xsubs_out, ysubs_out;
+
+	if (input_isp_fmt->fmt_type == FMT_BAYER)
+		goto disable;
+
+	/* set input and output sizes for scale calculation */
+	in_y.width = stream->dcrop.width;
+	in_y.height = stream->dcrop.height;
+	out_y.width = output_fmt.width;
+	out_y.height = output_fmt.height;
+
+	/* The size of Cb,Cr are related to the format */
+	if (mbus_code_xysubs(input_isp_fmt->mbus_code, &xsubs_in, &ysubs_in)) {
+		dev_err(dev->dev, "Not xsubs/ysubs found\n");
+		return -EINVAL;
+	}
+	in_c.width = in_y.width / xsubs_in;
+	in_c.height = in_y.height / ysubs_in;
+
+	if (output_isp_fmt->fmt_type == FMT_YUV) {
+		fcc_xysubs(output_isp_fmt->fourcc, &xsubs_out, &ysubs_out);
+		out_c.width = out_y.width / xsubs_out;
+		out_c.height = out_y.height / ysubs_out;
+	} else {
+		out_c.width = out_y.width / xsubs_in;
+		out_c.height = out_y.height / ysubs_in;
+	}
+
+	if (in_c.width == out_c.width && in_c.height == out_c.height)
+		goto disable;
+
+	/* set RSZ input and output */
+	dev_dbg(dev->dev, "stream %d rsz/scale: %dx%d -> %dx%d\n",
+		stream->id, stream->dcrop.width, stream->dcrop.height,
+		output_fmt.width, output_fmt.height);
+	dev_dbg(dev->dev, "chroma scaling %dx%d -> %dx%d\n",
+		in_c.width, in_c.height, out_c.width, out_c.height);
+
+	/* calculate and set scale */
+	config_rsz(stream, &in_y, &in_c, &out_y, &out_c, async);
+
+	dump_rsz_regs(dev->dev, stream);
+
+	return 0;
+
+disable:
+	disable_rsz(stream, async);
+
+	return 0;
+}
+
+/***************************** stream operations*******************************/
+
+/*
+ * configure memory interface for mainpath
+ * This should only be called when stream-on
+ */
+static int mp_config_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+       /*
+	* NOTE: plane_fmt[0].sizeimage is total size of all planes for single
+	* memory plane formats, so calculate the size explicitly.
+	*/
+	mi_set_y_size(stream, stream->out_fmt.plane_fmt[0].bytesperline *
+			 stream->out_fmt.height);
+	mi_set_cb_size(stream, stream->out_fmt.plane_fmt[1].sizeimage);
+	mi_set_cr_size(stream, stream->out_fmt.plane_fmt[2].sizeimage);
+
+	mi_frame_end_int_enable(stream);
+	if (stream->out_isp_fmt.uv_swap)
+		mp_set_uv_swap(base);
+
+	config_mi_ctrl(stream);
+	mp_mi_ctrl_set_format(base, stream->out_isp_fmt.write_format);
+	mp_mi_ctrl_autoupdate_en(base);
+
+	return 0;
+}
+
+/*
+ * configure memory interface for selfpath
+ * This should only be called when stream-on
+ */
+static int sp_config_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	struct rkisp1_device *dev = stream->ispdev;
+	struct capture_fmt *output_isp_fmt = &stream->out_isp_fmt;
+	const struct rkisp1_fmt *input_isp_fmt = dev->isp_sdev.out_fmt;
+	u32 sp_in_fmt;
+
+	if (mbus_code_sp_in_fmt(input_isp_fmt->mbus_code, &sp_in_fmt)) {
+		dev_err(dev->dev, "Can't find the input format\n");
+		return -EINVAL;
+	}
+       /*
+	* NOTE: plane_fmt[0].sizeimage is total size of all planes for single
+	* memory plane formats, so calculate the size explicitly.
+	*/
+	mi_set_y_size(stream, stream->out_fmt.plane_fmt[0].bytesperline *
+		      stream->out_fmt.height);
+	mi_set_cb_size(stream, stream->out_fmt.plane_fmt[1].sizeimage);
+	mi_set_cr_size(stream, stream->out_fmt.plane_fmt[2].sizeimage);
+
+	sp_set_y_width(base, stream->out_fmt.width);
+	sp_set_y_height(base, stream->out_fmt.height);
+	sp_set_y_line_length(base, stream->u.sp.y_stride);
+
+	mi_frame_end_int_enable(stream);
+	if (output_isp_fmt->uv_swap)
+		sp_set_uv_swap(base);
+
+	config_mi_ctrl(stream);
+	sp_mi_ctrl_set_format(base, stream->out_isp_fmt.write_format |
+			      sp_in_fmt | output_isp_fmt->output_format);
+
+	sp_mi_ctrl_autoupdate_en(base);
+
+	return 0;
+}
+
+static void mp_enable_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	struct capture_fmt *isp_fmt = &stream->out_isp_fmt;
+
+	mi_ctrl_mp_disable(base);
+	if (isp_fmt->fmt_type == FMT_BAYER)
+		mi_ctrl_mpraw_enable(base);
+	else if (isp_fmt->fmt_type == FMT_YUV)
+		mi_ctrl_mpyuv_enable(base);
+}
+
+static void sp_enable_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	mi_ctrl_spyuv_enable(base);
+}
+
+static void mp_disable_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	mi_ctrl_mp_disable(base);
+}
+
+static void sp_disable_mi(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	mi_ctrl_spyuv_disable(base);
+}
+
+/* Update buffer info to memory interface, it's called in interrupt */
+static void update_mi(struct rkisp1_stream *stream)
+{
+	struct rkisp1_dummy_buffer *dummy_buf = &stream->dummy_buf;
+
+	/* The dummy space allocated by dma_alloc_coherent is used, we can
+	 * throw data to it if there is no available buffer.
+	 */
+	if (stream->next_buf) {
+		mi_set_y_addr(stream,
+			stream->next_buf->buff_addr[RKISP1_PLANE_Y]);
+		mi_set_cb_addr(stream,
+			stream->next_buf->buff_addr[RKISP1_PLANE_CB]);
+		mi_set_cr_addr(stream,
+			stream->next_buf->buff_addr[RKISP1_PLANE_CR]);
+	} else {
+		dev_dbg(stream->ispdev->dev,
+			"stream %d: to dummy buf\n", stream->id);
+		mi_set_y_addr(stream, dummy_buf->dma_addr);
+		mi_set_cb_addr(stream, dummy_buf->dma_addr);
+		mi_set_cr_addr(stream, dummy_buf->dma_addr);
+	}
+
+	mi_set_y_offset(stream, 0);
+	mi_set_cb_offset(stream, 0);
+	mi_set_cr_offset(stream, 0);
+}
+
+static void mp_stop_mi(struct rkisp1_stream *stream)
+{
+	if (!stream->streaming)
+		return;
+	mi_frame_end_int_clear(stream);
+	stream->ops->disable_mi(stream);
+}
+
+static void sp_stop_mi(struct rkisp1_stream *stream)
+{
+	if (!stream->streaming)
+		return;
+	mi_frame_end_int_clear(stream);
+	stream->ops->disable_mi(stream);
+}
+
+static struct streams_ops rkisp1_mp_streams_ops = {
+	.config_mi = mp_config_mi,
+	.enable_mi = mp_enable_mi,
+	.disable_mi = mp_disable_mi,
+	.stop_mi = mp_stop_mi,
+	.set_data_path = mp_set_data_path,
+	.is_stream_stopped = mp_is_stream_stopped,
+};
+
+static struct streams_ops rkisp1_sp_streams_ops = {
+	.config_mi = sp_config_mi,
+	.enable_mi = sp_enable_mi,
+	.disable_mi = sp_disable_mi,
+	.stop_mi = sp_stop_mi,
+	.set_data_path = sp_set_data_path,
+	.is_stream_stopped = sp_is_stream_stopped,
+};
+
+/*
+ * This function is called when a frame end comes. The next frame
+ * is processing and we should set up buffer for next-next frame,
+ * otherwise it will overflow.
+ */
+static int mi_frame_end(struct rkisp1_stream *stream)
+{
+	struct rkisp1_device *isp_dev = stream->ispdev;
+	struct rkisp1_isp_subdev *isp_sd = &isp_dev->isp_sdev;
+	struct capture_fmt *isp_fmt = &stream->out_isp_fmt;
+	unsigned long lock_flags = 0;
+	int i = 0;
+
+	if (stream->curr_buf) {
+		/* Dequeue a filled buffer */
+		for (i = 0; i < isp_fmt->mplanes; i++) {
+			u32 payload_size =
+				stream->out_fmt.plane_fmt[i].sizeimage;
+			vb2_set_plane_payload(
+				&stream->curr_buf->vb.vb2_buf, i,
+				payload_size);
+		}
+		stream->curr_buf->vb.sequence =
+				atomic_read(&isp_sd->frm_sync_seq) - 1;
+		stream->curr_buf->vb.vb2_buf.timestamp = ktime_get_ns();
+		stream->curr_buf->vb.field = V4L2_FIELD_NONE;
+		vb2_buffer_done(&stream->curr_buf->vb.vb2_buf,
+				VB2_BUF_STATE_DONE);
+	}
+
+	/* Next frame is writing to it */
+	stream->curr_buf = stream->next_buf;
+	stream->next_buf = NULL;
+
+	/* Setup an empty buffer for the next-next frame */
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+	if (!list_empty(&stream->buf_queue)) {
+		stream->next_buf = list_first_entry(&stream->buf_queue,
+					struct rkisp1_buffer, queue);
+		list_del(&stream->next_buf->queue);
+	}
+
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+
+	update_mi(stream);
+
+	return 0;
+}
+
+/***************************** vb2 operations*******************************/
+
+/*
+ * Set flags and wait, it should stop in interrupt.
+ * If it didn't, stop it by force.
+ */
+static void rkisp1_stream_stop(struct rkisp1_stream *stream)
+{
+	struct rkisp1_device *dev = stream->ispdev;
+	int ret;
+
+	stream->stopping = true;
+	ret = wait_event_timeout(stream->done,
+				 !stream->streaming,
+				 msecs_to_jiffies(1000));
+	if (!ret) {
+		dev_warn(dev->dev, "waiting on event return error %d\n", ret);
+		stream->ops->stop_mi(stream);
+		stream->stopping = false;
+		stream->streaming = false;
+	}
+	disable_dcrop(stream, true);
+	disable_rsz(stream, true);
+}
+
+/*
+ * Most of registers inside rockchip ISP1 have shadow register since
+ * they must be not changed during processing a frame.
+ * Usually, each sub-module updates its shadow register after
+ * processing the last pixel of a frame.
+ */
+static int rkisp1_start(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	struct rkisp1_device *dev = stream->ispdev;
+	struct rkisp1_stream *other = &dev->stream[stream->id ^ 1];
+	int ret;
+
+	stream->ops->set_data_path(base);
+	ret = stream->ops->config_mi(stream);
+	if (ret)
+		return ret;
+
+	/* Setup a buffer for the next frame */
+	mi_frame_end(stream);
+	stream->ops->enable_mi(stream);
+	/* It's safe to config ACTIVE and SHADOW regs for the
+	 * first stream. While when the second is starting, do NOT
+	 * force_cfg_update() because it also update the first one.
+	 *
+	 * The latter case would drop one more buf(that is 2) since
+	 * there's not buf in shadow when the second FE received. This's
+	 * also required because the second FE maybe corrupt especially
+	 * when run at 120fps.
+	 */
+	if (!other->streaming) {
+		force_cfg_update(base);
+		mi_frame_end(stream);
+	}
+	stream->streaming = true;
+
+	return 0;
+}
+
+static int rkisp1_queue_setup(struct vb2_queue *queue,
+			      unsigned int *num_buffers,
+			      unsigned int *num_planes,
+			      unsigned int sizes[],
+			      struct device *alloc_devs[])
+{
+	struct rkisp1_stream *stream = queue->drv_priv;
+	struct rkisp1_device *dev = stream->ispdev;
+	const struct v4l2_pix_format_mplane *pixm = &stream->out_fmt;
+	const struct capture_fmt *isp_fmt = &stream->out_isp_fmt;
+	unsigned int i;
+
+	if (*num_planes) {
+		if (*num_planes != isp_fmt->mplanes)
+			return -EINVAL;
+
+		for (i = 0; i < isp_fmt->mplanes; i++)
+			if (sizes[i] < pixm->plane_fmt[i].sizeimage)
+				return -EINVAL;
+	} else {
+		*num_planes = isp_fmt->mplanes;
+		for (i = 0; i < isp_fmt->mplanes; i++)
+			sizes[i] = pixm->plane_fmt[i].sizeimage;
+	}
+
+	dev_dbg(dev->dev, "%s count %d, size %d\n",
+		v4l2_type_names[queue->type], *num_buffers, sizes[0]);
+
+	return 0;
+}
+
+/*
+ * The vb2_buffer are stored in rkisp1_buffer, in order to unify
+ * mplane buffer and none-mplane buffer.
+ */
+static void rkisp1_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rkisp1_buffer *ispbuf = to_rkisp1_buffer(vbuf);
+	struct vb2_queue *queue = vb->vb2_queue;
+	struct rkisp1_stream *stream = queue->drv_priv;
+	struct capture_fmt *isp_fmt = &stream->out_isp_fmt;
+	unsigned long lock_flags = 0;
+	unsigned int i;
+
+	memset(ispbuf->buff_addr, 0, sizeof(ispbuf->buff_addr));
+	for (i = 0; i < isp_fmt->mplanes; i++)
+		ispbuf->buff_addr[i] = vb2_dma_contig_plane_dma_addr(vb, i);
+
+	/* Convert to non-MPLANE */
+	if (isp_fmt->mplanes == 1) {
+		ispbuf->buff_addr[RKISP1_PLANE_CB] =
+			ispbuf->buff_addr[RKISP1_PLANE_Y] +
+			stream->out_fmt.plane_fmt[RKISP1_PLANE_Y].bytesperline *
+			stream->out_fmt.height;
+		ispbuf->buff_addr[RKISP1_PLANE_CR] =
+			ispbuf->buff_addr[RKISP1_PLANE_CB] +
+			stream->out_fmt.plane_fmt[RKISP1_PLANE_CB].sizeimage;
+	}
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+
+	/* XXX: replace dummy to speed up  */
+	if (stream->streaming &&
+	    stream->next_buf == NULL &&
+	    atomic_read(&stream->ispdev->isp_sdev.frm_sync_seq) == 0) {
+		stream->next_buf = ispbuf;
+		update_mi(stream);
+	} else {
+		list_add_tail(&ispbuf->queue, &stream->buf_queue);
+	}
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+}
+
+static int rkisp1_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_queue *queue = vb->vb2_queue;
+	struct rkisp1_stream *stream = queue->drv_priv;
+	struct rkisp1_device *dev = stream->ispdev;
+	struct capture_fmt *isp_fmt = &stream->out_isp_fmt;
+	unsigned int i;
+
+	for (i = 0; i < isp_fmt->mplanes; i++) {
+		unsigned long size = stream->out_fmt.plane_fmt[i].sizeimage;
+
+		if (isp_fmt->mplanes > 1 && i == 0)
+			size = stream->out_fmt.plane_fmt[RKISP1_PLANE_Y].bytesperline *
+				stream->out_fmt.height;
+
+		if (vb2_plane_size(vb, i) < size) {
+			dev_err(dev->dev,
+				"User buffer too small (%ld < %ld)\n",
+				vb2_plane_size(vb, i), size);
+			return -EINVAL;
+		}
+		vb2_set_plane_payload(vb, i, size);
+	}
+
+	return 0;
+}
+
+static int rkisp1_create_dummy_buf(struct rkisp1_stream *stream)
+{
+	struct rkisp1_dummy_buffer *dummy_buf = &stream->dummy_buf;
+	struct rkisp1_device *dev = stream->ispdev;
+
+	/* get a maximum size */
+	dummy_buf->size = max3(stream->out_fmt.plane_fmt[0].bytesperline *
+		stream->out_fmt.height,
+		stream->out_fmt.plane_fmt[1].sizeimage,
+		stream->out_fmt.plane_fmt[2].sizeimage);
+
+	dummy_buf->vaddr = dma_alloc_coherent(dev->dev, dummy_buf->size,
+					      &dummy_buf->dma_addr,
+					      GFP_KERNEL);
+	if (!dummy_buf->vaddr) {
+		dev_err(dev->dev,
+			"Failed to allocate the memory for dummy buffer\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void rkisp1_destroy_dummy_buf(struct rkisp1_stream *stream)
+{
+	struct rkisp1_dummy_buffer *dummy_buf = &stream->dummy_buf;
+	struct rkisp1_device *dev = stream->ispdev;
+
+	dma_free_coherent(dev->dev, dummy_buf->size,
+			  dummy_buf->vaddr, dummy_buf->dma_addr);
+}
+
+static void rkisp1_return_all_buffers(struct rkisp1_stream *stream,
+					enum vb2_buffer_state state)
+{
+	unsigned long lock_flags = 0;
+	struct rkisp1_buffer *buf;
+
+	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
+	if (stream->curr_buf) {
+		list_add_tail(&stream->curr_buf->queue, &stream->buf_queue);
+		stream->curr_buf = NULL;
+	}
+	if (stream->next_buf) {
+		list_add_tail(&stream->next_buf->queue, &stream->buf_queue);
+		stream->next_buf = NULL;
+	}
+	while (!list_empty(&stream->buf_queue)) {
+		buf = list_first_entry(&stream->buf_queue,
+				       struct rkisp1_buffer, queue);
+		list_del(&buf->queue);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+	}
+	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
+}
+
+/*
+ * rkisp1_pipeline_sink_walk - Walk through the pipeline and call cb
+ * @from: entity at which to start pipeline walk
+ * @until: entity at which to stop pipeline walk
+ *
+ * Walk the entities chain starting at the pipeline video node and stop
+ * all subdevices in the chain.
+ *
+ * If the until argument isn't NULL, stop the pipeline walk when reaching the
+ * until entity. This is used to disable a partially started pipeline due to a
+ * subdev start error.
+ */
+static int rkisp1_pipeline_sink_walk(struct media_entity *from,
+				     struct media_entity *until,
+				     int (*cb)(struct media_entity *from,
+					       struct media_entity *curr))
+{
+	struct media_entity *entity = from;
+	struct media_pad *pad;
+	unsigned int i;
+	int ret;
+
+	while (1) {
+		pad = NULL;
+		/* Find remote source pad */
+		for (i = 0; i < entity->num_pads; i++) {
+			struct media_pad *spad = &entity->pads[i];
+
+			if (!(spad->flags & MEDIA_PAD_FL_SINK))
+				continue;
+			pad = media_entity_remote_pad(spad);
+			if (pad && is_media_entity_v4l2_subdev(pad->entity))
+				break;
+		}
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		if (entity == until)
+			break;
+
+		ret = cb(from, entity);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rkisp1_pipeline_disable_cb(struct media_entity *from,
+				      struct media_entity *curr)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(curr);
+	int ret;
+
+	ret = v4l2_subdev_call(sd, video, s_stream, false);
+	if (ret < 0) {
+		dev_err(sd->dev, "%s: could not disable stream.\n", sd->name);
+		return ret;
+	}
+	return 0;
+}
+
+static int rkisp1_pipeline_enable_cb(struct media_entity *from,
+				     struct media_entity *curr)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(curr);
+	int ret;
+
+	ret = v4l2_subdev_call(sd, video, s_stream, true);
+	if (ret < 0) {
+		dev_err(sd->dev, "%s: could not enable stream.\n", sd->name);
+		rkisp1_pipeline_sink_walk(from, curr,
+					  rkisp1_pipeline_disable_cb);
+		return ret;
+	}
+	return 0;
+}
+
+static void rkisp1_stop_streaming(struct vb2_queue *queue)
+{
+	struct rkisp1_stream *stream = queue->drv_priv;
+	struct rkisp1_vdev_node *node = &stream->vnode;
+	struct rkisp1_device *dev = stream->ispdev;
+	int ret;
+
+	rkisp1_stream_stop(stream);
+	/* call to the other devices */
+	media_pipeline_stop(&node->vdev.entity);
+	ret = rkisp1_pipeline_sink_walk(&node->vdev.entity, NULL,
+					rkisp1_pipeline_disable_cb);
+	if (ret < 0)
+		dev_err(dev->dev, "pipeline stream-off failed error:%d\n", ret);
+
+	/* release buffers */
+	rkisp1_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
+
+	ret = pm_runtime_put(dev->dev);
+	if (ret < 0)
+		dev_err(dev->dev, "power down failed error:%d\n", ret);
+
+	ret = v4l2_pipeline_pm_use(&node->vdev.entity, 0);
+	if (ret < 0)
+		dev_err(dev->dev, "pipeline close failed error:%d\n", ret);
+
+	rkisp1_destroy_dummy_buf(stream);
+}
+
+static int rkisp1_stream_start(struct rkisp1_stream *stream)
+{
+	struct rkisp1_device *dev = stream->ispdev;
+	struct rkisp1_stream *other = &dev->stream[stream->id ^ 1];
+	bool async = false;
+	int ret;
+
+	if (other->streaming)
+		async = true;
+
+	ret = rkisp1_config_rsz(stream, async);
+	if (ret < 0) {
+		dev_err(dev->dev, "config rsz failed with error %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * can't be async now, otherwise the latter started stream fails to
+	 * produce mi interrupt.
+	 */
+	ret = rkisp1_config_dcrop(stream, false);
+	if (ret < 0) {
+		dev_err(dev->dev, "config dcrop failed with error %d\n", ret);
+		return ret;
+	}
+
+	return rkisp1_start(stream);
+}
+
+static int
+rkisp1_start_streaming(struct vb2_queue *queue, unsigned int count)
+{
+	struct rkisp1_stream *stream = queue->drv_priv;
+	struct rkisp1_device *dev = stream->ispdev;
+	struct media_entity *entity = &stream->vnode.vdev.entity;
+	int ret = -EINVAL;
+
+	if (WARN_ON(stream->streaming))
+		goto return_queued_buf;
+
+	ret = rkisp1_create_dummy_buf(stream);
+	if (ret < 0)
+		goto return_queued_buf;
+
+	/* power up */
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "power up failed %d\n", ret);
+		goto destroy_dummy_buf;
+	}
+	ret = v4l2_pipeline_pm_use(entity, 1);
+	if (ret < 0) {
+		dev_err(dev->dev, "open cif pipeline failed %d\n", ret);
+		goto close_pipe;
+	}
+
+	/* configure stream hardware to start */
+	ret = rkisp1_stream_start(stream);
+	if (ret < 0) {
+		dev_err(dev->dev, "start streaming failed\n");
+		goto power_down;
+	}
+
+	/* start sub-devices */
+	ret = rkisp1_pipeline_sink_walk(entity, NULL,
+					rkisp1_pipeline_enable_cb);
+	if (ret < 0)
+		goto stop_stream;
+
+	ret = media_pipeline_start(entity, &dev->pipe);
+	if (ret < 0) {
+		dev_err(dev->dev, "start pipeline failed %d\n", ret);
+		goto pipe_stream_off;
+	}
+
+	return 0;
+
+pipe_stream_off:
+	rkisp1_pipeline_sink_walk(entity, NULL, rkisp1_pipeline_disable_cb);
+stop_stream:
+	rkisp1_stream_stop(stream);
+power_down:
+	pm_runtime_put(dev->dev);
+close_pipe:
+	v4l2_pipeline_pm_use(entity, 0);
+destroy_dummy_buf:
+	rkisp1_destroy_dummy_buf(stream);
+return_queued_buf:
+	rkisp1_return_all_buffers(stream, VB2_BUF_STATE_QUEUED);
+
+	return ret;
+}
+
+static struct vb2_ops rkisp1_vb2_ops = {
+	.queue_setup = rkisp1_queue_setup,
+	.buf_queue = rkisp1_buf_queue,
+	.buf_prepare = rkisp1_buf_prepare,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.stop_streaming = rkisp1_stop_streaming,
+	.start_streaming = rkisp1_start_streaming,
+};
+
+static int rkisp_init_vb2_queue(struct vb2_queue *q,
+				struct rkisp1_stream *stream,
+				enum v4l2_buf_type buf_type)
+{
+	struct rkisp1_vdev_node *node;
+
+	node = queue_to_node(q);
+
+	q->type = buf_type;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
+	q->drv_priv = stream;
+	q->ops = &rkisp1_vb2_ops;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->buf_struct_size = sizeof(struct rkisp1_buffer);
+	q->min_buffers_needed = CIF_ISP_REQ_BUFS_MIN;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &node->vlock;
+	q->dev = stream->ispdev->dev;
+
+	return vb2_queue_init(q);
+}
+
+static void rkisp1_set_fmt(struct rkisp1_stream *stream,
+			   struct v4l2_pix_format_mplane *pixm,
+			   bool try)
+{
+	const struct capture_fmt *fmt;
+	const struct stream_config *config = stream->config;
+	struct rkisp1_stream *other_stream =
+			&stream->ispdev->stream[!stream->id];
+	unsigned int i, planes, imagsize = 0;
+	u32 xsubs = 1, ysubs = 1;
+
+	fmt = find_fmt(stream, pixm->pixelformat);
+	if (!fmt) {
+		fmt = config->fmts;
+		pixm->pixelformat = fmt->fourcc;
+	}
+
+	/* do checks on resolution */
+	pixm->width = clamp_t(u32, pixm->width, config->min_rsz_width,
+			      config->max_rsz_width);
+	pixm->height = clamp_t(u32, pixm->height, config->min_rsz_height,
+			      config->max_rsz_height);
+	pixm->num_planes = fmt->mplanes;
+	pixm->field = V4L2_FIELD_NONE;
+	pixm->colorspace = V4L2_COLORSPACE_DEFAULT;
+	pixm->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+
+	/* can not change quantization when stream-on */
+	if (other_stream->streaming)
+		pixm->quantization = other_stream->out_fmt.quantization;
+	/* output full range by default, take effect in isp_params */
+	else if (!pixm->quantization ||
+		 pixm->quantization > V4L2_QUANTIZATION_LIM_RANGE)
+		pixm->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+
+	/* calculate size */
+	fcc_xysubs(fmt->fourcc, &xsubs, &ysubs);
+	planes = fmt->cplanes ? fmt->cplanes : fmt->mplanes;
+	for (i = 0; i < planes; i++) {
+		struct v4l2_plane_pix_format *plane_fmt;
+		int width, height, bytesperline;
+
+		plane_fmt = pixm->plane_fmt + i;
+		width = pixm->width / (i ? xsubs : 1);
+		height = pixm->height / (i ? ysubs : 1);
+
+		bytesperline = width * DIV_ROUND_UP(fmt->bpp[i], 8);
+		/* stride is only available for sp stream and y plane */
+		if (stream->id != RKISP1_STREAM_SP || i != 0 ||
+		    plane_fmt->bytesperline < bytesperline)
+			plane_fmt->bytesperline = bytesperline;
+
+		plane_fmt->sizeimage = plane_fmt->bytesperline * height;
+
+		imagsize += plane_fmt->sizeimage;
+	}
+
+	/* convert to non-MPLANE format.
+	 * it's important since we want to unify none-MPLANE
+	 * and MPLANE.
+	 */
+	if (fmt->mplanes == 1)
+		pixm->plane_fmt[0].sizeimage = imagsize;
+
+	if (!try) {
+		stream->out_isp_fmt = *fmt;
+		stream->out_fmt = *pixm;
+
+		if (stream->id == RKISP1_STREAM_SP) {
+			stream->u.sp.y_stride =
+				pixm->plane_fmt[0].bytesperline /
+				DIV_ROUND_UP(fmt->bpp[0], 8);
+		} else {
+			stream->u.mp.raw_enable = (fmt->fmt_type == FMT_BAYER);
+		}
+		dev_dbg(stream->ispdev->dev,
+			"%s: stream: %d req(%d, %d) out(%d, %d)\n", __func__,
+			stream->id, pixm->width, pixm->height,
+			stream->out_fmt.width, stream->out_fmt.height);
+	}
+}
+
+/************************* v4l2_file_operations***************************/
+void rkisp1_stream_init(struct rkisp1_device *dev, u32 id)
+{
+	struct rkisp1_stream *stream = &dev->stream[id];
+	struct v4l2_pix_format_mplane pixm;
+
+	memset(stream, 0, sizeof(*stream));
+	stream->id = id;
+	stream->ispdev = dev;
+
+	INIT_LIST_HEAD(&stream->buf_queue);
+	init_waitqueue_head(&stream->done);
+	spin_lock_init(&stream->vbq_lock);
+	if (stream->id == RKISP1_STREAM_SP) {
+		stream->ops = &rkisp1_sp_streams_ops;
+		stream->config = &rkisp1_sp_stream_config;
+	} else {
+		stream->ops = &rkisp1_mp_streams_ops;
+		stream->config = &rkisp1_mp_stream_config;
+	}
+
+	stream->streaming = false;
+
+	memset(&pixm, 0, sizeof(pixm));
+	pixm.pixelformat = V4L2_PIX_FMT_YUYV;
+	pixm.width = RKISP1_DEFAULT_WIDTH;
+	pixm.height = RKISP1_DEFAULT_HEIGHT;
+	rkisp1_set_fmt(stream, &pixm, false);
+
+	stream->dcrop.left = 0;
+	stream->dcrop.top = 0;
+	stream->dcrop.width = RKISP1_DEFAULT_WIDTH;
+	stream->dcrop.height = RKISP1_DEFAULT_HEIGHT;
+}
+
+static const struct v4l2_file_operations rkisp1_fops = {
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vb2_fop_poll,
+	.mmap = vb2_fop_mmap,
+};
+
+/*
+ * mp and sp v4l2_ioctl_ops
+ */
+
+static int rkisp1_try_fmt_vid_cap_mplane(struct file *file, void *fh,
+					 struct v4l2_format *f)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+
+	rkisp1_set_fmt(stream, &f->fmt.pix_mp, true);
+
+	return 0;
+}
+
+static int rkisp1_enum_fmt_vid_cap_mplane(struct file *file, void *priv,
+					  struct v4l2_fmtdesc *f)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+	const struct capture_fmt *fmt = NULL;
+
+	if (f->index >= stream->config->fmt_size)
+		return -EINVAL;
+
+	fmt = &stream->config->fmts[f->index];
+	f->pixelformat = fmt->fourcc;
+
+	return 0;
+}
+
+static int rkisp1_s_fmt_vid_cap_mplane(struct file *file,
+				       void *priv, struct v4l2_format *f)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+	struct video_device *vdev = &stream->vnode.vdev;
+	struct rkisp1_vdev_node *node = vdev_to_node(vdev);
+	struct rkisp1_device *dev = stream->ispdev;
+
+	if (vb2_is_busy(&node->buf_queue)) {
+		dev_err(dev->dev, "%s queue busy\n", __func__);
+		return -EBUSY;
+	}
+
+	rkisp1_set_fmt(stream, &f->fmt.pix_mp, false);
+
+	return 0;
+}
+
+static int rkisp1_g_fmt_vid_cap_mplane(struct file *file, void *fh,
+				       struct v4l2_format *f)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+
+	f->fmt.pix_mp = stream->out_fmt;
+
+	return 0;
+}
+
+static int rkisp1_g_selection(struct file *file, void *prv,
+			      struct v4l2_selection *sel)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+	struct rkisp1_device *dev = stream->ispdev;
+	struct v4l2_rect *dcrop = &stream->dcrop;
+	const struct v4l2_rect *input_win;
+
+	if (sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	input_win = rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					       RKISP1_ISP_PAD_SINK_VIDEO,
+					       V4L2_SUBDEV_FORMAT_ACTIVE);
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.width = input_win->width;
+		sel->r.height = input_win->height;
+		sel->r.left = 0;
+		sel->r.top = 0;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		sel->r = *dcrop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct v4l2_rect *rkisp1_update_crop(struct rkisp1_stream *stream,
+					    struct v4l2_rect *sel,
+					    const struct v4l2_rect *in)
+{
+	/* Not crop for MP bayer raw data */
+	if (stream->id == RKISP1_STREAM_MP &&
+	    stream->out_isp_fmt.fmt_type == FMT_BAYER) {
+		sel->left = 0;
+		sel->top = 0;
+		sel->width = in->width;
+		sel->height = in->height;
+		return sel;
+	}
+
+	sel->left = ALIGN(sel->left, 2);
+	sel->width = ALIGN(sel->width, 2);
+	sel->left = clamp_t(u32, sel->left, 0,
+			    in->width - STREAM_MIN_MP_SP_INPUT_WIDTH);
+	sel->top = clamp_t(u32, sel->top, 0,
+			   in->height - STREAM_MIN_MP_SP_INPUT_HEIGHT);
+	sel->width = clamp_t(u32, sel->width, STREAM_MIN_MP_SP_INPUT_WIDTH,
+			     in->width - sel->left);
+	sel->height = clamp_t(u32, sel->height, STREAM_MIN_MP_SP_INPUT_HEIGHT,
+			      in->height - sel->top);
+	return sel;
+}
+
+static int rkisp1_s_selection(struct file *file, void *prv,
+			      struct v4l2_selection *sel)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+	struct video_device *vdev = &stream->vnode.vdev;
+	struct rkisp1_vdev_node *node = vdev_to_node(vdev);
+	struct rkisp1_device *dev = stream->ispdev;
+	struct v4l2_rect *dcrop = &stream->dcrop;
+	const struct v4l2_rect *input_win;
+
+	if (sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	if (vb2_is_busy(&node->buf_queue)) {
+		dev_err(dev->dev, "%s queue busy\n", __func__);
+		return -EBUSY;
+	}
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	if (sel->flags != 0)
+		return -EINVAL;
+
+	input_win = rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					       RKISP1_ISP_PAD_SINK_VIDEO,
+					       V4L2_SUBDEV_FORMAT_ACTIVE);
+
+	if (sel->target == V4L2_SEL_TGT_CROP) {
+		*dcrop = *rkisp1_update_crop(stream, &sel->r, input_win);
+		dev_dbg(dev->dev,
+			"stream %d crop(%d,%d)/%dx%d\n", stream->id,
+			dcrop->left, dcrop->top, dcrop->width, dcrop->height);
+	}
+
+	return 0;
+}
+
+static int rkisp1_querycap(struct file *file, void *priv,
+			   struct v4l2_capability *cap)
+{
+	struct rkisp1_stream *stream = video_drvdata(file);
+	struct device *dev = stream->ispdev->dev;
+
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
+	strscpy(cap->card, dev->driver->name, sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: " DRIVER_NAME, sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int rkisp1_vdev_link_validate(struct media_link *link)
+{
+	struct video_device *vdev =
+		media_entity_to_video_device(link->sink->entity);
+	struct rkisp1_stream *stream = video_get_drvdata(vdev);
+	struct rkisp1_isp_subdev *isp_sd = &stream->ispdev->isp_sdev;
+	const struct v4l2_mbus_framefmt *ispsd_frm;
+	u16 isp_quant, cap_quant;
+
+	if (stream->out_isp_fmt.fmt_type != isp_sd->out_fmt->fmt_type) {
+		dev_err(isp_sd->sd.dev,
+			"format type mismatch in link '%s:%d->%s:%d'\n",
+			link->source->entity->name, link->source->index,
+			link->sink->entity->name, link->sink->index);
+		return -EPIPE;
+	}
+
+	ispsd_frm = rkisp1_isp_sd_get_pad_fmt(isp_sd, NULL,
+					      RKISP1_ISP_PAD_SINK_VIDEO,
+					      V4L2_SUBDEV_FORMAT_ACTIVE);
+
+	/*
+	 * TODO: we are considering default quantization as full range. Check if
+	 * we can do this or not.
+	 */
+	cap_quant = stream->out_fmt.quantization;
+	isp_quant = ispsd_frm->quantization;
+
+	if (cap_quant == V4L2_QUANTIZATION_DEFAULT)
+		cap_quant = V4L2_QUANTIZATION_FULL_RANGE;
+	if (isp_quant == V4L2_QUANTIZATION_DEFAULT)
+		isp_quant = V4L2_QUANTIZATION_FULL_RANGE;
+	if (cap_quant != isp_quant) {
+		dev_err(isp_sd->sd.dev,
+			"quantization mismatch in link '%s:%d->%s:%d'\n",
+			link->source->entity->name, link->source->index,
+			link->sink->entity->name, link->sink->index);
+		return -EPIPE;
+	}
+
+	return 0;
+}
+
+static const struct media_entity_operations rkisp1_isp_vdev_media_ops = {
+	.link_validate = rkisp1_vdev_link_validate,
+};
+
+static const struct v4l2_ioctl_ops rkisp1_v4l2_ioctl_ops = {
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_try_fmt_vid_cap_mplane = rkisp1_try_fmt_vid_cap_mplane,
+	.vidioc_s_fmt_vid_cap_mplane = rkisp1_s_fmt_vid_cap_mplane,
+	.vidioc_g_fmt_vid_cap_mplane = rkisp1_g_fmt_vid_cap_mplane,
+	.vidioc_enum_fmt_vid_cap = rkisp1_enum_fmt_vid_cap_mplane,
+	.vidioc_s_selection = rkisp1_s_selection,
+	.vidioc_g_selection = rkisp1_g_selection,
+	.vidioc_querycap = rkisp1_querycap,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static void rkisp1_unregister_stream_vdev(struct rkisp1_stream *stream)
+{
+	media_entity_cleanup(&stream->vnode.vdev.entity);
+	video_unregister_device(&stream->vnode.vdev);
+}
+
+void rkisp1_unregister_stream_vdevs(struct rkisp1_device *dev)
+{
+	struct rkisp1_stream *mp_stream = &dev->stream[RKISP1_STREAM_MP];
+	struct rkisp1_stream *sp_stream = &dev->stream[RKISP1_STREAM_SP];
+
+	rkisp1_unregister_stream_vdev(mp_stream);
+	rkisp1_unregister_stream_vdev(sp_stream);
+}
+
+static int rkisp1_register_stream_vdev(struct rkisp1_stream *stream)
+{
+	struct rkisp1_device *dev = stream->ispdev;
+	struct v4l2_device *v4l2_dev = &dev->v4l2_dev;
+	struct video_device *vdev = &stream->vnode.vdev;
+	struct rkisp1_vdev_node *node;
+	int ret;
+
+	strscpy(vdev->name,
+		stream->id == RKISP1_STREAM_SP ? SP_VDEV_NAME : MP_VDEV_NAME,
+		sizeof(vdev->name));
+	node = vdev_to_node(vdev);
+	mutex_init(&node->vlock);
+
+	vdev->ioctl_ops = &rkisp1_v4l2_ioctl_ops;
+	vdev->release = video_device_release_empty;
+	vdev->fops = &rkisp1_fops;
+	vdev->minor = -1;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->lock = &node->vlock;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
+				V4L2_CAP_STREAMING;
+	vdev->entity.ops = &rkisp1_isp_vdev_media_ops;
+	video_set_drvdata(vdev, stream);
+	vdev->vfl_dir = VFL_DIR_RX;
+	node->pad.flags = MEDIA_PAD_FL_SINK;
+
+	rkisp_init_vb2_queue(&node->buf_queue, stream,
+			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	vdev->queue = &node->buf_queue;
+
+	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	if (ret < 0) {
+		dev_err(dev->dev,
+			"video_register_device failed with error %d\n", ret);
+		return ret;
+	}
+
+	ret = media_entity_pads_init(&vdev->entity, 1, &node->pad);
+	if (ret < 0)
+		goto unreg;
+
+	return 0;
+unreg:
+	video_unregister_device(vdev);
+	return ret;
+}
+
+int rkisp1_register_stream_vdevs(struct rkisp1_device *dev)
+{
+	struct rkisp1_stream *stream;
+	unsigned int i, j;
+	int ret;
+
+	for (i = 0; i < RKISP1_MAX_STREAM; i++) {
+		stream = &dev->stream[i];
+		stream->ispdev = dev;
+		ret = rkisp1_register_stream_vdev(stream);
+		if (ret < 0)
+			goto err;
+	}
+
+	return 0;
+err:
+	for (j = 0; j < i; j++) {
+		stream = &dev->stream[j];
+		rkisp1_unregister_stream_vdev(stream);
+	}
+
+	return ret;
+}
+
+/****************  Interrupter Handler ****************/
+
+void rkisp1_mi_isr(struct rkisp1_device *dev)
+{
+	unsigned int i;
+	u32 status;
+
+	status = readl(dev->base_addr + CIF_MI_MIS);
+	if (!status)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(dev->stream); ++i) {
+		struct rkisp1_stream *stream = &dev->stream[i];
+
+		if (!(status & CIF_MI_FRAME(stream)))
+			continue;
+
+		mi_frame_end_int_clear(stream);
+
+		if (stream->stopping) {
+			/*
+			 * Make sure stream is actually stopped, whose state
+			 * can be read from the shadow register, before
+			 * wake_up() thread which would immediately free all
+			 * frame buffers. stop_mi() takes effect at the next
+			 * frame end that sync the configurations to shadow
+			 * regs.
+			 */
+			if (stream->ops->is_stream_stopped(dev->base_addr)) {
+				stream->stopping = false;
+				stream->streaming = false;
+				wake_up(&stream->done);
+			} else {
+				stream->ops->stop_mi(stream);
+			}
+		} else {
+			mi_frame_end(stream);
+		}
+	}
+}
diff --git a/drivers/staging/media/rkisp1/capture.h b/drivers/staging/media/rkisp1/capture.h
new file mode 100644
index 000000000000..099b709e60d7
--- /dev/null
+++ b/drivers/staging/media/rkisp1/capture.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - V4l capture device header
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_PATH_VIDEO_H
+#define _RKISP1_PATH_VIDEO_H
+
+#include "common.h"
+
+struct rkisp1_stream;
+
+/*
+ * @fourcc: pixel format
+ * @mbus_code: pixel format over bus
+ * @fmt_type: helper filed for pixel format
+ * @bpp: bits per pixel
+ * @bayer_pat: bayer patten type
+ * @cplanes: number of colour planes
+ * @mplanes: number of stored memory planes
+ * @uv_swap: if cb cr swaped, for yuv
+ * @write_format: defines how YCbCr self picture data is written to memory
+ * @input_format: defines sp input format
+ * @output_format: defines sp output format
+ */
+struct capture_fmt {
+	u32 fourcc;
+	u32 mbus_code;
+	u8 fmt_type;
+	u8 cplanes;
+	u8 mplanes;
+	u8 uv_swap;
+	u32 write_format;
+	u32 output_format;
+	u8 bpp[VIDEO_MAX_PLANES];
+};
+
+enum rkisp1_sp_inp {
+	RKISP1_SP_INP_ISP,
+	RKISP1_SP_INP_DMA_SP,
+	RKISP1_SP_INP_MAX
+};
+
+struct rkisp1_stream_sp {
+	int y_stride;
+	enum rkisp1_sp_inp input_sel;
+};
+
+struct rkisp1_stream_mp {
+	bool raw_enable;
+};
+
+/* Different config between selfpath and mainpath */
+struct stream_config {
+	const struct capture_fmt *fmts;
+	int fmt_size;
+	/* constrains */
+	const int max_rsz_width;
+	const int max_rsz_height;
+	const int min_rsz_width;
+	const int min_rsz_height;
+	/* registers */
+	struct {
+		u32 ctrl;
+		u32 ctrl_shd;
+		u32 scale_hy;
+		u32 scale_hcr;
+		u32 scale_hcb;
+		u32 scale_vy;
+		u32 scale_vc;
+		u32 scale_lut;
+		u32 scale_lut_addr;
+		u32 scale_hy_shd;
+		u32 scale_hcr_shd;
+		u32 scale_hcb_shd;
+		u32 scale_vy_shd;
+		u32 scale_vc_shd;
+		u32 phase_hy;
+		u32 phase_hc;
+		u32 phase_vy;
+		u32 phase_vc;
+		u32 phase_hy_shd;
+		u32 phase_hc_shd;
+		u32 phase_vy_shd;
+		u32 phase_vc_shd;
+	} rsz;
+	struct {
+		u32 ctrl;
+		u32 yuvmode_mask;
+		u32 rawmode_mask;
+		u32 h_offset;
+		u32 v_offset;
+		u32 h_size;
+		u32 v_size;
+	} dual_crop;
+	struct {
+		u32 y_size_init;
+		u32 cb_size_init;
+		u32 cr_size_init;
+		u32 y_base_ad_init;
+		u32 cb_base_ad_init;
+		u32 cr_base_ad_init;
+		u32 y_offs_cnt_init;
+		u32 cb_offs_cnt_init;
+		u32 cr_offs_cnt_init;
+	} mi;
+};
+
+/* Different reg ops between selfpath and mainpath */
+struct streams_ops {
+	int (*config_mi)(struct rkisp1_stream *stream);
+	void (*stop_mi)(struct rkisp1_stream *stream);
+	void (*enable_mi)(struct rkisp1_stream *stream);
+	void (*disable_mi)(struct rkisp1_stream *stream);
+	void (*set_data_path)(void __iomem *base);
+	bool (*is_stream_stopped)(void __iomem *base);
+};
+
+/*
+ * struct rkisp1_stream - ISP capture video device
+ *
+ * @out_isp_fmt: output ISP format
+ * @out_fmt: output buffer size
+ * @dcrop: coordinates of dual-crop
+ *
+ * @vbq_lock: lock to protect buf_queue
+ * @buf_queue: queued buffer list
+ * @dummy_buf: dummy space to store dropped data
+ *
+ * rkisp1 use shadowsock registers, so it need two buffer at a time
+ * @curr_buf: the buffer used for current frame
+ * @next_buf: the buffer used for next frame
+ */
+struct rkisp1_stream {
+	unsigned id:1;
+	struct rkisp1_device *ispdev;
+	struct rkisp1_vdev_node vnode;
+	struct capture_fmt out_isp_fmt;
+	struct v4l2_pix_format_mplane out_fmt;
+	struct v4l2_rect dcrop;
+	struct streams_ops *ops;
+	struct stream_config *config;
+	spinlock_t vbq_lock;
+	struct list_head buf_queue;
+	struct rkisp1_dummy_buffer dummy_buf;
+	struct rkisp1_buffer *curr_buf;
+	struct rkisp1_buffer *next_buf;
+	bool streaming;
+	bool stopping;
+	wait_queue_head_t done;
+	union {
+		struct rkisp1_stream_sp sp;
+		struct rkisp1_stream_mp mp;
+	} u;
+};
+
+void rkisp1_unregister_stream_vdevs(struct rkisp1_device *dev);
+int rkisp1_register_stream_vdevs(struct rkisp1_device *dev);
+void rkisp1_mi_isr(struct rkisp1_device *dev);
+void rkisp1_stream_init(struct rkisp1_device *dev, u32 id);
+
+#endif /* _RKISP1_PATH_VIDEO_H */
diff --git a/drivers/staging/media/rkisp1/common.h b/drivers/staging/media/rkisp1/common.h
new file mode 100644
index 000000000000..a6aa627b0456
--- /dev/null
+++ b/drivers/staging/media/rkisp1/common.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - Common definitions
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_COMMON_H
+#define _RKISP1_COMMON_H
+
+#include <linux/mutex.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/videobuf2-v4l2.h>
+
+/* TODO: FIXME: changing the default resolution to higher values causes the
+ * stream to stall.
+ * The capture node gets the crop bounds from the isp source pad crop size, but
+ * if the user updates isp source pad crop size and start streaming, the capture
+ * doesn't detect the new crop bounds, and if the isp source pad crop size is
+ * smaller then the capture crop size, the stream doesn't work.
+ */
+#define RKISP1_DEFAULT_WIDTH		800
+#define RKISP1_DEFAULT_HEIGHT		600
+
+#define RKISP1_MAX_STREAM		2
+#define RKISP1_STREAM_MP		0
+#define RKISP1_STREAM_SP		1
+
+#define RKISP1_PLANE_Y			0
+#define RKISP1_PLANE_CB			1
+#define RKISP1_PLANE_CR			2
+
+/* One structure per video node */
+struct rkisp1_vdev_node {
+	struct vb2_queue buf_queue;
+	/* vfd lock */
+	struct mutex vlock;
+	struct video_device vdev;
+	struct media_pad pad;
+};
+
+enum rkisp1_fmt_pix_type {
+	FMT_YUV,
+	FMT_RGB,
+	FMT_BAYER,
+	FMT_JPEG,
+	FMT_MAX
+};
+
+enum rkisp1_fmt_raw_pat_type {
+	RAW_RGGB = 0,
+	RAW_GRBG,
+	RAW_GBRG,
+	RAW_BGGR,
+};
+
+struct rkisp1_buffer {
+	struct vb2_v4l2_buffer vb;
+	struct list_head queue;
+	union {
+		u32 buff_addr[VIDEO_MAX_PLANES];
+		void *vaddr[VIDEO_MAX_PLANES];
+	};
+};
+
+struct rkisp1_dummy_buffer {
+	void *vaddr;
+	dma_addr_t dma_addr;
+	u32 size;
+};
+
+static inline
+struct rkisp1_vdev_node *vdev_to_node(struct video_device *vdev)
+{
+	return container_of(vdev, struct rkisp1_vdev_node, vdev);
+}
+
+static inline struct rkisp1_vdev_node *queue_to_node(struct vb2_queue *q)
+{
+	return container_of(q, struct rkisp1_vdev_node, buf_queue);
+}
+
+static inline struct rkisp1_buffer *to_rkisp1_buffer(struct vb2_v4l2_buffer *vb)
+{
+	return container_of(vb, struct rkisp1_buffer, vb);
+}
+
+static inline struct vb2_queue *to_vb2_queue(struct file *file)
+{
+	struct rkisp1_vdev_node *vnode = video_drvdata(file);
+
+	return &vnode->buf_queue;
+}
+
+#endif /* _RKISP1_COMMON_H */
diff --git a/drivers/staging/media/rkisp1/dev.c b/drivers/staging/media/rkisp1/dev.c
new file mode 100644
index 000000000000..22e9d8b41c7a
--- /dev/null
+++ b/drivers/staging/media/rkisp1/dev.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - Base driver
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+#include <media/v4l2-fwnode.h>
+
+#include "common.h"
+#include "regs.h"
+
+struct isp_match_data {
+	const char * const *clks;
+	unsigned int size;
+};
+
+/***************************** media controller *******************************/
+/* See http://opensource.rock-chips.com/wiki_Rockchip-isp1 for Topology */
+
+static int rkisp1_create_links(struct rkisp1_device *dev)
+{
+	struct media_entity *source, *sink;
+	unsigned int flags, source_pad;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	/* sensor links */
+	list_for_each_entry(sd, &dev->v4l2_dev.subdevs, list) {
+		if (sd == &dev->isp_sdev.sd)
+			continue;
+
+		ret = media_entity_get_fwnode_pad(&sd->entity, sd->fwnode,
+						  MEDIA_PAD_FL_SOURCE);
+		if (ret < 0) {
+			dev_err(sd->dev, "failed to find src pad for %s\n",
+				sd->name);
+			return ret;
+		}
+		source_pad = ret;
+
+		ret = media_create_pad_link(
+				&sd->entity, source_pad,
+				&dev->isp_sdev.sd.entity,
+				RKISP1_ISP_PAD_SINK_VIDEO,
+				list_is_first(&sd->list,
+					      &dev->v4l2_dev.subdevs) ?
+				MEDIA_LNK_FL_ENABLED : 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* params links */
+	source = &dev->params_vdev.vnode.vdev.entity;
+	sink = &dev->isp_sdev.sd.entity;
+	flags = MEDIA_LNK_FL_ENABLED;
+	ret = media_create_pad_link(source, 0, sink,
+				    RKISP1_ISP_PAD_SINK_PARAMS, flags);
+	if (ret < 0)
+		return ret;
+
+	/* create ISP internal links */
+	/* SP links */
+	source = &dev->isp_sdev.sd.entity;
+	sink = &dev->stream[RKISP1_STREAM_SP].vnode.vdev.entity;
+	ret = media_create_pad_link(source, RKISP1_ISP_PAD_SOURCE_VIDEO,
+				    sink, 0, flags);
+	if (ret < 0)
+		return ret;
+
+	/* MP links */
+	source = &dev->isp_sdev.sd.entity;
+	sink = &dev->stream[RKISP1_STREAM_MP].vnode.vdev.entity;
+	ret = media_create_pad_link(source, RKISP1_ISP_PAD_SOURCE_VIDEO,
+				    sink, 0, flags);
+	if (ret < 0)
+		return ret;
+
+	/* 3A stats links */
+	source = &dev->isp_sdev.sd.entity;
+	sink = &dev->stats_vdev.vnode.vdev.entity;
+	return media_create_pad_link(source, RKISP1_ISP_PAD_SOURCE_STATS,
+				     sink, 0, flags);
+}
+
+static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
+                                struct v4l2_subdev *sd,
+                                struct v4l2_async_subdev *asd)
+{
+	struct rkisp1_device *isp_dev = container_of(notifier,
+						     struct rkisp1_device,
+						     notifier);
+	struct sensor_async_subdev *s_asd = container_of(asd,
+					struct sensor_async_subdev, asd);
+
+	s_asd->pixel_rate_ctrl = v4l2_ctrl_find(sd->ctrl_handler,
+						V4L2_CID_PIXEL_RATE);
+	s_asd->sd = sd;
+	s_asd->dphy = devm_phy_get(isp_dev->dev, "dphy");
+	if (IS_ERR(s_asd->dphy)) {
+		if (PTR_ERR(s_asd->dphy) != -EPROBE_DEFER)
+			dev_err(isp_dev->dev, "Couldn't get the MIPI D-PHY\n");
+		return PTR_ERR(s_asd->dphy);
+	}
+
+	phy_init(s_asd->dphy);
+
+	return 0;
+}
+
+static void subdev_notifier_unbind(struct v4l2_async_notifier *notifier,
+				   struct v4l2_subdev *sd,
+				   struct v4l2_async_subdev *asd)
+{
+	struct sensor_async_subdev *s_asd = container_of(asd,
+					struct sensor_async_subdev, asd);
+
+	phy_exit(s_asd->dphy);
+}
+
+static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct rkisp1_device *dev = container_of(notifier, struct rkisp1_device,
+						 notifier);
+	int ret;
+
+	mutex_lock(&dev->media_dev.graph_mutex);
+	ret = rkisp1_create_links(dev);
+	if (ret < 0)
+		goto unlock;
+	ret = v4l2_device_register_subdev_nodes(&dev->v4l2_dev);
+	if (ret < 0)
+		goto unlock;
+
+	dev_info(dev->dev, "Async subdev notifier completed\n");
+
+unlock:
+	mutex_unlock(&dev->media_dev.graph_mutex);
+	return ret;
+}
+
+static int rkisp1_fwnode_parse(struct device *dev,
+			       struct v4l2_fwnode_endpoint *vep,
+			       struct v4l2_async_subdev *asd)
+{
+	struct sensor_async_subdev *s_asd =
+			container_of(asd, struct sensor_async_subdev, asd);
+
+	if (vep->bus_type != V4L2_MBUS_CSI2_DPHY) {
+		dev_err(dev, "Only CSI2 bus type is currently supported\n");
+		return -EINVAL;
+	}
+
+	if (vep->base.port != 0) {
+		dev_err(dev, "The ISP has only port 0\n");
+		return -EINVAL;
+	}
+
+	s_asd->mbus.type = vep->bus_type;
+	s_asd->mbus.flags = vep->bus.mipi_csi2.flags;
+	s_asd->lanes = vep->bus.mipi_csi2.num_data_lanes;
+
+	switch (vep->bus.mipi_csi2.num_data_lanes) {
+	case 1:
+		s_asd->mbus.flags |= V4L2_MBUS_CSI2_1_LANE;
+		break;
+	case 2:
+		s_asd->mbus.flags |= V4L2_MBUS_CSI2_2_LANE;
+		break;
+	case 3:
+		s_asd->mbus.flags |= V4L2_MBUS_CSI2_3_LANE;
+		break;
+	case 4:
+		s_asd->mbus.flags |= V4L2_MBUS_CSI2_4_LANE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_async_notifier_operations subdev_notifier_ops = {
+	.bound = subdev_notifier_bound,
+	.unbind = subdev_notifier_unbind,
+	.complete = subdev_notifier_complete,
+};
+
+static int isp_subdev_notifier(struct rkisp1_device *isp_dev)
+{
+	struct v4l2_async_notifier *ntf = &isp_dev->notifier;
+	struct device *dev = isp_dev->dev;
+	int ret;
+
+	v4l2_async_notifier_init(ntf);
+
+	ret = v4l2_async_notifier_parse_fwnode_endpoints_by_port(
+		dev, ntf, sizeof(struct sensor_async_subdev), 0,
+		rkisp1_fwnode_parse);
+	if (ret < 0)
+		return ret;
+
+	if (list_empty(&ntf->asd_list))
+		return -ENODEV;	/* no endpoint */
+
+	ntf->ops = &subdev_notifier_ops;
+
+	return v4l2_async_notifier_register(&isp_dev->v4l2_dev, ntf);
+}
+
+/***************************** platform device *******************************/
+
+static int rkisp1_register_platform_subdevs(struct rkisp1_device *dev)
+{
+	int ret;
+
+	ret = rkisp1_register_isp_subdev(dev, &dev->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	rkisp1_stream_init(dev, RKISP1_STREAM_SP);
+	rkisp1_stream_init(dev, RKISP1_STREAM_MP);
+
+	ret = rkisp1_register_stream_vdevs(dev);
+	if (ret < 0)
+		goto err_unreg_isp_subdev;
+
+	ret = rkisp1_register_stats_vdev(&dev->stats_vdev, &dev->v4l2_dev, dev);
+	if (ret < 0)
+		goto err_unreg_stream_vdev;
+
+	ret = rkisp1_register_params_vdev(&dev->params_vdev, &dev->v4l2_dev,
+					  dev);
+	if (ret < 0)
+		goto err_unreg_stats_vdev;
+
+	ret = isp_subdev_notifier(dev);
+	if (ret < 0) {
+		dev_err(dev->dev,
+			"Failed to register subdev notifier(%d)\n", ret);
+		goto err_unreg_params_vdev;
+	}
+
+	return 0;
+err_unreg_params_vdev:
+	rkisp1_unregister_params_vdev(&dev->params_vdev);
+err_unreg_stats_vdev:
+	rkisp1_unregister_stats_vdev(&dev->stats_vdev);
+err_unreg_stream_vdev:
+	rkisp1_unregister_stream_vdevs(dev);
+err_unreg_isp_subdev:
+	rkisp1_unregister_isp_subdev(dev);
+	return ret;
+}
+
+static const char * const rk3399_isp_clks[] = {
+	"clk_isp",
+	"aclk_isp",
+	"hclk_isp",
+	"aclk_isp_wrap",
+	"hclk_isp_wrap",
+};
+
+static const struct isp_match_data rk3399_isp_clk_data = {
+	.clks = rk3399_isp_clks,
+	.size = ARRAY_SIZE(rk3399_isp_clks),
+};
+
+static const struct of_device_id rkisp1_plat_of_match[] = {
+	{
+		.compatible = "rockchip,rk3399-cif-isp",
+		.data = &rk3399_isp_clk_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rkisp1_plat_of_match);
+
+static irqreturn_t rkisp1_irq_handler(int irq, void *ctx)
+{
+	struct device *dev = ctx;
+	struct rkisp1_device *rkisp1_dev = dev_get_drvdata(dev);
+
+	rkisp1_isp_isr(rkisp1_dev);
+	rkisp1_mipi_isr(rkisp1_dev);
+	rkisp1_mi_isr(rkisp1_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int rkisp1_plat_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct isp_match_data *clk_data;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct rkisp1_device *isp_dev;
+	struct v4l2_device *v4l2_dev;
+	unsigned int i;
+	int ret, irq;
+
+	match = of_match_node(rkisp1_plat_of_match, node);
+	isp_dev = devm_kzalloc(dev, sizeof(*isp_dev), GFP_KERNEL);
+	if (!isp_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, isp_dev);
+	isp_dev->dev = dev;
+
+	isp_dev->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(isp_dev->base_addr))
+		return PTR_ERR(isp_dev->base_addr);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, rkisp1_irq_handler, IRQF_SHARED,
+			       dev_driver_string(dev), dev);
+	if (ret < 0) {
+		dev_err(dev, "request irq failed: %d\n", ret);
+		return ret;
+	}
+
+	isp_dev->irq = irq;
+	clk_data = match->data;
+
+	for (i = 0; i < clk_data->size; i++)
+		isp_dev->clks[i].id = clk_data->clks[i];
+	ret = devm_clk_bulk_get(dev, clk_data->size, isp_dev->clks);
+	if (ret)
+		return ret;
+	isp_dev->clk_size = clk_data->size;
+
+	strscpy(isp_dev->media_dev.model, "rkisp1",
+		sizeof(isp_dev->media_dev.model));
+	isp_dev->media_dev.dev = &pdev->dev;
+	strscpy(isp_dev->media_dev.bus_info,
+		"platform: " DRIVER_NAME, sizeof(isp_dev->media_dev.bus_info));
+	media_device_init(&isp_dev->media_dev);
+
+	v4l2_dev = &isp_dev->v4l2_dev;
+	v4l2_dev->mdev = &isp_dev->media_dev;
+	strscpy(v4l2_dev->name, "rkisp1", sizeof(v4l2_dev->name));
+
+	ret = v4l2_device_register(isp_dev->dev, &isp_dev->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = media_device_register(&isp_dev->media_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register media device: %d\n", ret);
+		goto err_unreg_v4l2_dev;
+	}
+
+	/* create & register platform subdev (from of_node) */
+	ret = rkisp1_register_platform_subdevs(isp_dev);
+	if (ret < 0)
+		goto err_unreg_media_dev;
+
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_unreg_media_dev:
+	media_device_unregister(&isp_dev->media_dev);
+err_unreg_v4l2_dev:
+	v4l2_device_unregister(&isp_dev->v4l2_dev);
+	return ret;
+}
+
+static int rkisp1_plat_remove(struct platform_device *pdev)
+{
+	struct rkisp1_device *isp_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	media_device_unregister(&isp_dev->media_dev);
+	v4l2_async_notifier_unregister(&isp_dev->notifier);
+	v4l2_async_notifier_cleanup(&isp_dev->notifier);
+	v4l2_device_unregister(&isp_dev->v4l2_dev);
+	rkisp1_unregister_params_vdev(&isp_dev->params_vdev);
+	rkisp1_unregister_stats_vdev(&isp_dev->stats_vdev);
+	rkisp1_unregister_stream_vdevs(isp_dev);
+	rkisp1_unregister_isp_subdev(isp_dev);
+
+	return 0;
+}
+
+static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
+{
+	struct rkisp1_device *isp_dev = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(isp_dev->clk_size, isp_dev->clks);
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
+{
+	struct rkisp1_device *isp_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return ret;
+	ret = clk_bulk_prepare_enable(isp_dev->clk_size, isp_dev->clks);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct dev_pm_ops rkisp1_plat_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(rkisp1_runtime_suspend, rkisp1_runtime_resume, NULL)
+};
+
+static struct platform_driver rkisp1_plat_drv = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(rkisp1_plat_of_match),
+		.pm = &rkisp1_plat_pm_ops,
+	},
+	.probe = rkisp1_plat_probe,
+	.remove = rkisp1_plat_remove,
+};
+
+module_platform_driver(rkisp1_plat_drv);
+MODULE_AUTHOR("Rockchip Camera/ISP team");
+MODULE_DESCRIPTION("Rockchip ISP1 platform driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/staging/media/rkisp1/dev.h b/drivers/staging/media/rkisp1/dev.h
new file mode 100644
index 000000000000..fc59da8902fb
--- /dev/null
+++ b/drivers/staging/media/rkisp1/dev.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - Base driver
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_DEV_H
+#define _RKISP1_DEV_H
+
+#include <linux/clk.h>
+
+#include "capture.h"
+#include "rkisp1.h"
+#include "isp_params.h"
+#include "isp_stats.h"
+
+#define DRIVER_NAME "rkisp1"
+#define ISP_VDEV_NAME DRIVER_NAME  "_ispdev"
+#define SP_VDEV_NAME DRIVER_NAME   "_selfpath"
+#define MP_VDEV_NAME DRIVER_NAME   "_mainpath"
+#define DMA_VDEV_NAME DRIVER_NAME  "_dmapath"
+
+#define RKISP1_MAX_BUS_CLK	8
+
+/*
+ * struct sensor_async_subdev - Sensor information
+ * @mbus: media bus configuration
+ */
+struct sensor_async_subdev {
+	struct v4l2_async_subdev asd;
+	struct v4l2_mbus_config mbus;
+	unsigned int lanes;
+	struct v4l2_subdev *sd;
+	struct v4l2_ctrl *pixel_rate_ctrl;
+	struct phy *dphy;
+};
+
+/*
+ * struct rkisp1_device - ISP platform device
+ * @base_addr: base register address
+ * @active_sensor: sensor in-use, set when streaming on
+ * @isp_sdev: ISP sub-device
+ * @rkisp1_stream: capture video device
+ * @stats_vdev: ISP statistics output device
+ * @params_vdev: ISP input parameters device
+ */
+struct rkisp1_device {
+	void __iomem *base_addr;
+	int irq;
+	struct device *dev;
+	unsigned int clk_size;
+	struct clk_bulk_data clks[RKISP1_MAX_BUS_CLK];
+	struct v4l2_device v4l2_dev;
+	struct v4l2_ctrl_handler ctrl_handler;
+	struct media_device media_dev;
+	struct v4l2_async_notifier notifier;
+	struct sensor_async_subdev *active_sensor;
+	struct rkisp1_isp_subdev isp_sdev;
+	struct rkisp1_stream stream[RKISP1_MAX_STREAM];
+	struct rkisp1_isp_stats_vdev stats_vdev;
+	struct rkisp1_isp_params_vdev params_vdev;
+	struct media_pipeline pipe;
+	struct vb2_alloc_ctx *alloc_ctx;
+};
+
+#endif
diff --git a/drivers/staging/media/rkisp1/isp_params.c b/drivers/staging/media/rkisp1/isp_params.c
new file mode 100644
index 000000000000..8f1f4a41b8f4
--- /dev/null
+++ b/drivers/staging/media/rkisp1/isp_params.c
@@ -0,0 +1,1604 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - Params subdevice
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <media/v4l2-common.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-vmalloc.h>	/* for ISP params */
+
+#include "dev.h"
+#include "regs.h"
+
+#define RKISP1_ISP_PARAMS_REQ_BUFS_MIN	2
+#define RKISP1_ISP_PARAMS_REQ_BUFS_MAX	8
+
+#define BLS_START_H_MAX_IS_VALID(val)	((val) < CIFISP_BLS_START_H_MAX)
+#define BLS_STOP_H_MAX_IS_VALID(val)	((val) < CIFISP_BLS_STOP_H_MAX)
+
+#define BLS_START_V_MAX_IS_VALID(val)	((val) < CIFISP_BLS_START_V_MAX)
+#define BLS_STOP_V_MAX_IS_VALID(val)	((val) < CIFISP_BLS_STOP_V_MAX)
+
+#define BLS_SAMPLE_MAX_IS_VALID(val)	((val) < CIFISP_BLS_SAMPLES_MAX)
+
+#define BLS_FIX_SUB_IS_VALID(val)	\
+	((val) > (s16) CIFISP_BLS_FIX_SUB_MIN && (val) < CIFISP_BLS_FIX_SUB_MAX)
+
+#define RKISP1_ISP_DPCC_LINE_THRESH(n)	(CIF_ISP_DPCC_LINE_THRESH_1 + 0x14 * (n))
+#define RKISP1_ISP_DPCC_LINE_MAD_FAC(n) (CIF_ISP_DPCC_LINE_MAD_FAC_1 + 0x14 * (n))
+#define RKISP1_ISP_DPCC_PG_FAC(n)	(CIF_ISP_DPCC_PG_FAC_1 + 0x14 * (n))
+#define RKISP1_ISP_DPCC_RND_THRESH(n)	(CIF_ISP_DPCC_RND_THRESH_1 + 0x14 * (n))
+#define RKISP1_ISP_DPCC_RG_FAC(n)	(CIF_ISP_DPCC_RG_FAC_1 + 0x14 * (n))
+#define RKISP1_ISP_CC_COEFF(n)		(CIF_ISP_CC_COEFF_0 + (n) * 4)
+
+static inline void rkisp1_iowrite32(struct rkisp1_isp_params_vdev *params_vdev,
+				    u32 value, u32 addr)
+{
+	iowrite32(value, params_vdev->dev->base_addr + addr);
+}
+
+static inline u32 rkisp1_ioread32(struct rkisp1_isp_params_vdev *params_vdev,
+				  u32 addr)
+{
+	return ioread32(params_vdev->dev->base_addr + addr);
+}
+
+static inline void isp_param_set_bits(struct rkisp1_isp_params_vdev
+					     *params_vdev,
+				      u32 reg, u32 bit_mask)
+{
+	u32 val;
+
+	val = rkisp1_ioread32(params_vdev, reg);
+	rkisp1_iowrite32(params_vdev, val | bit_mask, reg);
+}
+
+static inline void isp_param_clear_bits(struct rkisp1_isp_params_vdev
+					       *params_vdev,
+					u32 reg, u32 bit_mask)
+{
+	u32 val;
+
+	val = rkisp1_ioread32(params_vdev, reg);
+	rkisp1_iowrite32(params_vdev, val & ~bit_mask, reg);
+}
+
+/* ISP BP interface function */
+static void dpcc_config(struct rkisp1_isp_params_vdev *params_vdev,
+			const struct cifisp_dpcc_config *arg)
+{
+	unsigned int i;
+	u32 mode;
+
+	/* avoid to override the old enable value */
+	mode = rkisp1_ioread32(params_vdev, CIF_ISP_DPCC_MODE);
+	mode &= CIF_ISP_DPCC_ENA;
+	mode |= arg->mode & ~CIF_ISP_DPCC_ENA;
+	rkisp1_iowrite32(params_vdev, mode, CIF_ISP_DPCC_MODE);
+	rkisp1_iowrite32(params_vdev, arg->output_mode,
+			 CIF_ISP_DPCC_OUTPUT_MODE);
+	rkisp1_iowrite32(params_vdev, arg->set_use, CIF_ISP_DPCC_SET_USE);
+
+	rkisp1_iowrite32(params_vdev, arg->methods[0].method,
+			 CIF_ISP_DPCC_METHODS_SET_1);
+	rkisp1_iowrite32(params_vdev, arg->methods[1].method,
+			 CIF_ISP_DPCC_METHODS_SET_2);
+	rkisp1_iowrite32(params_vdev, arg->methods[2].method,
+			 CIF_ISP_DPCC_METHODS_SET_3);
+	for (i = 0; i < CIFISP_DPCC_METHODS_MAX; i++) {
+		rkisp1_iowrite32(params_vdev, arg->methods[i].line_thresh,
+				 RKISP1_ISP_DPCC_LINE_THRESH(i));
+		rkisp1_iowrite32(params_vdev, arg->methods[i].line_mad_fac,
+				 RKISP1_ISP_DPCC_LINE_MAD_FAC(i));
+		rkisp1_iowrite32(params_vdev, arg->methods[i].pg_fac,
+				 RKISP1_ISP_DPCC_PG_FAC(i));
+		rkisp1_iowrite32(params_vdev, arg->methods[i].rnd_thresh,
+				 RKISP1_ISP_DPCC_RND_THRESH(i));
+		rkisp1_iowrite32(params_vdev, arg->methods[i].rg_fac,
+				 RKISP1_ISP_DPCC_RG_FAC(i));
+	}
+
+	rkisp1_iowrite32(params_vdev, arg->rnd_offs, CIF_ISP_DPCC_RND_OFFS);
+	rkisp1_iowrite32(params_vdev, arg->ro_limits, CIF_ISP_DPCC_RO_LIMITS);
+}
+
+/* ISP black level subtraction interface function */
+static void bls_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_bls_config *arg)
+{
+	/* avoid to override the old enable value */
+	u32 new_control;
+
+	new_control = rkisp1_ioread32(params_vdev, CIF_ISP_BLS_CTRL);
+	new_control &= CIF_ISP_BLS_ENA;
+	/* fixed subtraction values */
+	if (!arg->enable_auto) {
+		const struct cifisp_bls_fixed_val *pval = &arg->fixed_val;
+
+		switch (params_vdev->raw_type) {
+		case RAW_BGGR:
+			rkisp1_iowrite32(params_vdev,
+					 pval->r, CIF_ISP_BLS_D_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gr, CIF_ISP_BLS_C_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gb, CIF_ISP_BLS_B_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->b, CIF_ISP_BLS_A_FIXED);
+			break;
+		case RAW_GBRG:
+			rkisp1_iowrite32(params_vdev,
+					 pval->r, CIF_ISP_BLS_C_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gr, CIF_ISP_BLS_D_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gb, CIF_ISP_BLS_A_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->b, CIF_ISP_BLS_B_FIXED);
+			break;
+		case RAW_GRBG:
+			rkisp1_iowrite32(params_vdev,
+					 pval->r, CIF_ISP_BLS_B_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gr, CIF_ISP_BLS_A_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gb, CIF_ISP_BLS_D_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->b, CIF_ISP_BLS_C_FIXED);
+			break;
+		case RAW_RGGB:
+			rkisp1_iowrite32(params_vdev,
+					 pval->r, CIF_ISP_BLS_A_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gr, CIF_ISP_BLS_B_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->gb, CIF_ISP_BLS_C_FIXED);
+			rkisp1_iowrite32(params_vdev,
+					 pval->b, CIF_ISP_BLS_D_FIXED);
+			break;
+		default:
+			break;
+		}
+
+	} else {
+		if (arg->en_windows & BIT(1)) {
+			rkisp1_iowrite32(params_vdev, arg->bls_window2.h_offs,
+					 CIF_ISP_BLS_H2_START);
+			rkisp1_iowrite32(params_vdev, arg->bls_window2.h_size,
+					 CIF_ISP_BLS_H2_STOP);
+			rkisp1_iowrite32(params_vdev, arg->bls_window2.v_offs,
+					 CIF_ISP_BLS_V2_START);
+			rkisp1_iowrite32(params_vdev, arg->bls_window2.v_size,
+					 CIF_ISP_BLS_V2_STOP);
+			new_control |= CIF_ISP_BLS_WINDOW_2;
+		}
+
+		if (arg->en_windows & BIT(0)) {
+			rkisp1_iowrite32(params_vdev, arg->bls_window1.h_offs,
+					 CIF_ISP_BLS_H1_START);
+			rkisp1_iowrite32(params_vdev, arg->bls_window1.h_size,
+					 CIF_ISP_BLS_H1_STOP);
+			rkisp1_iowrite32(params_vdev, arg->bls_window1.v_offs,
+					 CIF_ISP_BLS_V1_START);
+			rkisp1_iowrite32(params_vdev, arg->bls_window1.v_size,
+					 CIF_ISP_BLS_V1_STOP);
+			new_control |= CIF_ISP_BLS_WINDOW_1;
+		}
+
+		rkisp1_iowrite32(params_vdev, arg->bls_samples,
+				 CIF_ISP_BLS_SAMPLES);
+
+		new_control |= CIF_ISP_BLS_MODE_MEASURED;
+	}
+	rkisp1_iowrite32(params_vdev, new_control, CIF_ISP_BLS_CTRL);
+}
+
+/* ISP LS correction interface function */
+static void
+__lsc_correct_matrix_config(struct rkisp1_isp_params_vdev *params_vdev,
+			    const struct cifisp_lsc_config *pconfig)
+{
+	unsigned int isp_lsc_status, sram_addr, isp_lsc_table_sel;
+	unsigned int i, j, data;
+
+	isp_lsc_status = rkisp1_ioread32(params_vdev, CIF_ISP_LSC_STATUS);
+
+	/* CIF_ISP_LSC_TABLE_ADDRESS_153 = ( 17 * 18 ) >> 1 */
+	sram_addr = (isp_lsc_status & CIF_ISP_LSC_ACTIVE_TABLE) ?
+		     CIF_ISP_LSC_TABLE_ADDRESS_0 :
+		     CIF_ISP_LSC_TABLE_ADDRESS_153;
+	rkisp1_iowrite32(params_vdev, sram_addr, CIF_ISP_LSC_R_TABLE_ADDR);
+	rkisp1_iowrite32(params_vdev, sram_addr, CIF_ISP_LSC_GR_TABLE_ADDR);
+	rkisp1_iowrite32(params_vdev, sram_addr, CIF_ISP_LSC_GB_TABLE_ADDR);
+	rkisp1_iowrite32(params_vdev, sram_addr, CIF_ISP_LSC_B_TABLE_ADDR);
+
+	/* program data tables (table size is 9 * 17 = 153) */
+	for (i = 0; i < CIF_ISP_LSC_SECTORS_MAX * CIF_ISP_LSC_SECTORS_MAX;
+	     i += CIF_ISP_LSC_SECTORS_MAX) {
+		/*
+		 * 17 sectors with 2 values in one DWORD = 9
+		 * DWORDs (2nd value of last DWORD unused)
+		 */
+		for (j = 0; j < CIF_ISP_LSC_SECTORS_MAX - 1; j += 2) {
+			data = CIF_ISP_LSC_TABLE_DATA(
+					pconfig->r_data_tbl[i + j],
+					pconfig->r_data_tbl[i + j + 1]);
+			rkisp1_iowrite32(params_vdev, data,
+					 CIF_ISP_LSC_R_TABLE_DATA);
+
+			data = CIF_ISP_LSC_TABLE_DATA(
+					pconfig->gr_data_tbl[i + j],
+					pconfig->gr_data_tbl[i + j + 1]);
+			rkisp1_iowrite32(params_vdev, data,
+					 CIF_ISP_LSC_GR_TABLE_DATA);
+
+			data = CIF_ISP_LSC_TABLE_DATA(
+					pconfig->gb_data_tbl[i + j],
+					pconfig->gb_data_tbl[i + j + 1]);
+			rkisp1_iowrite32(params_vdev, data,
+					 CIF_ISP_LSC_GB_TABLE_DATA);
+
+			data = CIF_ISP_LSC_TABLE_DATA(
+					pconfig->b_data_tbl[i + j],
+					pconfig->b_data_tbl[i + j + 1]);
+			rkisp1_iowrite32(params_vdev, data,
+					 CIF_ISP_LSC_B_TABLE_DATA);
+		}
+		data = CIF_ISP_LSC_TABLE_DATA(
+				pconfig->r_data_tbl[i + j],
+				0);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_R_TABLE_DATA);
+
+		data = CIF_ISP_LSC_TABLE_DATA(
+				pconfig->gr_data_tbl[i + j],
+				0);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_GR_TABLE_DATA);
+
+		data = CIF_ISP_LSC_TABLE_DATA(
+				pconfig->gb_data_tbl[i + j],
+				0);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_GB_TABLE_DATA);
+
+		data = CIF_ISP_LSC_TABLE_DATA(
+				pconfig->b_data_tbl[i + j],
+				0);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_B_TABLE_DATA);
+	}
+	isp_lsc_table_sel = (isp_lsc_status & CIF_ISP_LSC_ACTIVE_TABLE) ?
+				CIF_ISP_LSC_TABLE_0 : CIF_ISP_LSC_TABLE_1;
+	rkisp1_iowrite32(params_vdev, isp_lsc_table_sel, CIF_ISP_LSC_TABLE_SEL);
+}
+
+static void lsc_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_lsc_config *arg)
+{
+	unsigned int i, data;
+	u32 lsc_ctrl;
+
+	/* To config must be off , store the current status firstly */
+	lsc_ctrl = rkisp1_ioread32(params_vdev, CIF_ISP_LSC_CTRL);
+	isp_param_clear_bits(params_vdev, CIF_ISP_LSC_CTRL,
+			     CIF_ISP_LSC_CTRL_ENA);
+	__lsc_correct_matrix_config(params_vdev, arg);
+
+	for (i = 0; i < 4; i++) {
+		/* program x size tables */
+		data = CIF_ISP_LSC_SECT_SIZE(arg->x_size_tbl[i * 2],
+					arg->x_size_tbl[i * 2 + 1]);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_XSIZE_01 + i * 4);
+
+		/* program x grad tables */
+		data = CIF_ISP_LSC_SECT_SIZE(arg->x_grad_tbl[i * 2],
+					arg->x_grad_tbl[i * 2 + 1]);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_XGRAD_01 + i * 4);
+
+		/* program y size tables */
+		data = CIF_ISP_LSC_SECT_SIZE(arg->y_size_tbl[i * 2],
+					arg->y_size_tbl[i * 2 + 1]);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_YSIZE_01 + i * 4);
+
+		/* program y grad tables */
+		data = CIF_ISP_LSC_SECT_SIZE(arg->y_grad_tbl[i * 2],
+					arg->y_grad_tbl[i * 2 + 1]);
+		rkisp1_iowrite32(params_vdev, data,
+				 CIF_ISP_LSC_YGRAD_01 + i * 4);
+	}
+
+	/* restore the lsc ctrl status */
+	if (lsc_ctrl & CIF_ISP_LSC_CTRL_ENA) {
+		isp_param_set_bits(params_vdev,
+				   CIF_ISP_LSC_CTRL,
+				   CIF_ISP_LSC_CTRL_ENA);
+	} else {
+		isp_param_clear_bits(params_vdev,
+				     CIF_ISP_LSC_CTRL,
+				     CIF_ISP_LSC_CTRL_ENA);
+	}
+}
+
+/* ISP Filtering function */
+static void flt_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_flt_config *arg)
+{
+	u32 filt_mode;
+
+	rkisp1_iowrite32(params_vdev, arg->thresh_bl0, CIF_ISP_FILT_THRESH_BL0);
+	rkisp1_iowrite32(params_vdev, arg->thresh_bl1, CIF_ISP_FILT_THRESH_BL1);
+	rkisp1_iowrite32(params_vdev, arg->thresh_sh0, CIF_ISP_FILT_THRESH_SH0);
+	rkisp1_iowrite32(params_vdev, arg->thresh_sh1, CIF_ISP_FILT_THRESH_SH1);
+	rkisp1_iowrite32(params_vdev, arg->fac_bl0, CIF_ISP_FILT_FAC_BL0);
+	rkisp1_iowrite32(params_vdev, arg->fac_bl1, CIF_ISP_FILT_FAC_BL1);
+	rkisp1_iowrite32(params_vdev, arg->fac_mid, CIF_ISP_FILT_FAC_MID);
+	rkisp1_iowrite32(params_vdev, arg->fac_sh0, CIF_ISP_FILT_FAC_SH0);
+	rkisp1_iowrite32(params_vdev, arg->fac_sh1, CIF_ISP_FILT_FAC_SH1);
+	rkisp1_iowrite32(params_vdev, arg->lum_weight, CIF_ISP_FILT_LUM_WEIGHT);
+
+	rkisp1_iowrite32(params_vdev, (arg->mode ? CIF_ISP_FLT_MODE_DNR : 0) |
+			 CIF_ISP_FLT_CHROMA_V_MODE(arg->chr_v_mode) |
+			 CIF_ISP_FLT_CHROMA_H_MODE(arg->chr_h_mode) |
+			 CIF_ISP_FLT_GREEN_STAGE1(arg->grn_stage1),
+			 CIF_ISP_FILT_MODE);
+
+	/* avoid to override the old enable value */
+	filt_mode = rkisp1_ioread32(params_vdev, CIF_ISP_FILT_MODE);
+	filt_mode &= CIF_ISP_FLT_ENA;
+	if (arg->mode)
+		filt_mode |= CIF_ISP_FLT_MODE_DNR;
+	filt_mode |= CIF_ISP_FLT_CHROMA_V_MODE(arg->chr_v_mode) |
+				 CIF_ISP_FLT_CHROMA_H_MODE(arg->chr_h_mode) |
+				 CIF_ISP_FLT_GREEN_STAGE1(arg->grn_stage1);
+	rkisp1_iowrite32(params_vdev, filt_mode, CIF_ISP_FILT_MODE);
+}
+
+/* ISP demosaic interface function */
+static int bdm_config(struct rkisp1_isp_params_vdev *params_vdev,
+		      const struct cifisp_bdm_config *arg)
+{
+	u32 bdm_th;
+
+	/* avoid to override the old enable value */
+	bdm_th = rkisp1_ioread32(params_vdev, CIF_ISP_DEMOSAIC);
+	bdm_th &= CIF_ISP_DEMOSAIC_BYPASS;
+	bdm_th |= arg->demosaic_th & ~CIF_ISP_DEMOSAIC_BYPASS;
+	/* set demosaic threshold */
+	rkisp1_iowrite32(params_vdev, bdm_th, CIF_ISP_DEMOSAIC);
+	return 0;
+}
+
+/* ISP GAMMA correction interface function */
+static void sdg_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_sdg_config *arg)
+{
+	unsigned int i;
+
+	rkisp1_iowrite32(params_vdev,
+			 arg->xa_pnts.gamma_dx0, CIF_ISP_GAMMA_DX_LO);
+	rkisp1_iowrite32(params_vdev,
+			 arg->xa_pnts.gamma_dx1, CIF_ISP_GAMMA_DX_HI);
+
+	for (i = 0; i < CIFISP_DEGAMMA_CURVE_SIZE; i++) {
+		rkisp1_iowrite32(params_vdev, arg->curve_r.gamma_y[i],
+				 CIF_ISP_GAMMA_R_Y0 + i * 4);
+		rkisp1_iowrite32(params_vdev, arg->curve_g.gamma_y[i],
+				 CIF_ISP_GAMMA_G_Y0 + i * 4);
+		rkisp1_iowrite32(params_vdev, arg->curve_b.gamma_y[i],
+				 CIF_ISP_GAMMA_B_Y0 + i * 4);
+	}
+}
+
+/* ISP GAMMA correction interface function */
+static void goc_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_goc_config *arg)
+{
+	unsigned int i;
+
+	isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+			     CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA);
+	rkisp1_iowrite32(params_vdev, arg->mode, CIF_ISP_GAMMA_OUT_MODE);
+
+	for (i = 0; i < CIFISP_GAMMA_OUT_MAX_SAMPLES; i++)
+		rkisp1_iowrite32(params_vdev, arg->gamma_y[i],
+				 CIF_ISP_GAMMA_OUT_Y_0 + i * 4);
+}
+
+/* ISP Cross Talk */
+static void ctk_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_ctk_config *arg)
+{
+	rkisp1_iowrite32(params_vdev, arg->coeff0, CIF_ISP_CT_COEFF_0);
+	rkisp1_iowrite32(params_vdev, arg->coeff1, CIF_ISP_CT_COEFF_1);
+	rkisp1_iowrite32(params_vdev, arg->coeff2, CIF_ISP_CT_COEFF_2);
+	rkisp1_iowrite32(params_vdev, arg->coeff3, CIF_ISP_CT_COEFF_3);
+	rkisp1_iowrite32(params_vdev, arg->coeff4, CIF_ISP_CT_COEFF_4);
+	rkisp1_iowrite32(params_vdev, arg->coeff5, CIF_ISP_CT_COEFF_5);
+	rkisp1_iowrite32(params_vdev, arg->coeff6, CIF_ISP_CT_COEFF_6);
+	rkisp1_iowrite32(params_vdev, arg->coeff7, CIF_ISP_CT_COEFF_7);
+	rkisp1_iowrite32(params_vdev, arg->coeff8, CIF_ISP_CT_COEFF_8);
+	rkisp1_iowrite32(params_vdev, arg->ct_offset_r, CIF_ISP_CT_OFFSET_R);
+	rkisp1_iowrite32(params_vdev, arg->ct_offset_g, CIF_ISP_CT_OFFSET_G);
+	rkisp1_iowrite32(params_vdev, arg->ct_offset_b, CIF_ISP_CT_OFFSET_B);
+}
+
+static void ctk_enable(struct rkisp1_isp_params_vdev *params_vdev, bool en)
+{
+	if (en)
+		return;
+
+	/* Write back the default values. */
+	rkisp1_iowrite32(params_vdev, 0x80, CIF_ISP_CT_COEFF_0);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_1);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_2);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_3);
+	rkisp1_iowrite32(params_vdev, 0x80, CIF_ISP_CT_COEFF_4);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_5);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_6);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_COEFF_7);
+	rkisp1_iowrite32(params_vdev, 0x80, CIF_ISP_CT_COEFF_8);
+
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_OFFSET_R);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_OFFSET_G);
+	rkisp1_iowrite32(params_vdev, 0, CIF_ISP_CT_OFFSET_B);
+}
+
+/* ISP White Balance Mode */
+static void awb_meas_config(struct rkisp1_isp_params_vdev *params_vdev,
+			    const struct cifisp_awb_meas_config *arg)
+{
+	u32 reg_val = 0;
+	/* based on the mode,configure the awb module */
+	if (arg->awb_mode == CIFISP_AWB_MODE_YCBCR) {
+		/* Reference Cb and Cr */
+		rkisp1_iowrite32(params_vdev,
+				 CIF_ISP_AWB_REF_CR_SET(arg->awb_ref_cr) |
+				 arg->awb_ref_cb, CIF_ISP_AWB_REF);
+		/* Yc Threshold */
+		rkisp1_iowrite32(params_vdev,
+				 CIF_ISP_AWB_MAX_Y_SET(arg->max_y) |
+				 CIF_ISP_AWB_MIN_Y_SET(arg->min_y) |
+				 CIF_ISP_AWB_MAX_CS_SET(arg->max_csum) |
+				 arg->min_c, CIF_ISP_AWB_THRESH);
+	}
+
+	reg_val = rkisp1_ioread32(params_vdev, CIF_ISP_AWB_PROP);
+	if (arg->enable_ymax_cmp)
+		reg_val |= CIF_ISP_AWB_YMAX_CMP_EN;
+	else
+		reg_val &= ~CIF_ISP_AWB_YMAX_CMP_EN;
+	rkisp1_iowrite32(params_vdev, reg_val, CIF_ISP_AWB_PROP);
+
+	/* window offset */
+	rkisp1_iowrite32(params_vdev,
+			 arg->awb_wnd.v_offs, CIF_ISP_AWB_WND_V_OFFS);
+	rkisp1_iowrite32(params_vdev,
+			 arg->awb_wnd.h_offs, CIF_ISP_AWB_WND_H_OFFS);
+	/* AWB window size */
+	rkisp1_iowrite32(params_vdev,
+			 arg->awb_wnd.v_size, CIF_ISP_AWB_WND_V_SIZE);
+	rkisp1_iowrite32(params_vdev,
+			 arg->awb_wnd.h_size, CIF_ISP_AWB_WND_H_SIZE);
+	/* Number of frames */
+	rkisp1_iowrite32(params_vdev,
+			 arg->frames, CIF_ISP_AWB_FRAMES);
+}
+
+static void awb_meas_enable(struct rkisp1_isp_params_vdev *params_vdev,
+			    const struct cifisp_awb_meas_config *arg, bool en)
+{
+	u32 reg_val = rkisp1_ioread32(params_vdev, CIF_ISP_AWB_PROP);
+
+	/* switch off */
+	reg_val &= CIF_ISP_AWB_MODE_MASK_NONE;
+
+	if (en) {
+		if (arg->awb_mode == CIFISP_AWB_MODE_RGB)
+			reg_val |= CIF_ISP_AWB_MODE_RGB_EN;
+		else
+			reg_val |= CIF_ISP_AWB_MODE_YCBCR_EN;
+
+		rkisp1_iowrite32(params_vdev, reg_val, CIF_ISP_AWB_PROP);
+
+		/* Measurements require AWB block be active. */
+		/* TODO: need to enable here ? awb_gain_enable has done this */
+		isp_param_set_bits(params_vdev, CIF_ISP_CTRL,
+				   CIF_ISP_CTRL_ISP_AWB_ENA);
+	} else {
+		rkisp1_iowrite32(params_vdev,
+				 reg_val, CIF_ISP_AWB_PROP);
+		isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+				     CIF_ISP_CTRL_ISP_AWB_ENA);
+	}
+}
+
+static void awb_gain_config(struct rkisp1_isp_params_vdev *params_vdev,
+			    const struct cifisp_awb_gain_config *arg)
+{
+	rkisp1_iowrite32(params_vdev,
+			 CIF_ISP_AWB_GAIN_R_SET(arg->gain_green_r) |
+			 arg->gain_green_b, CIF_ISP_AWB_GAIN_G);
+
+	rkisp1_iowrite32(params_vdev, CIF_ISP_AWB_GAIN_R_SET(arg->gain_red) |
+			 arg->gain_blue, CIF_ISP_AWB_GAIN_RB);
+}
+
+static void aec_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_aec_config *arg)
+{
+	unsigned int block_hsize, block_vsize;
+	u32 exp_ctrl;
+
+	/* avoid to override the old enable value */
+	exp_ctrl = rkisp1_ioread32(params_vdev, CIF_ISP_EXP_CTRL);
+	exp_ctrl &= CIF_ISP_EXP_ENA;
+	if (arg->autostop)
+		exp_ctrl |= CIF_ISP_EXP_CTRL_AUTOSTOP;
+	if (arg->mode == CIFISP_EXP_MEASURING_MODE_1)
+		exp_ctrl |= CIF_ISP_EXP_CTRL_MEASMODE_1;
+	rkisp1_iowrite32(params_vdev, exp_ctrl, CIF_ISP_EXP_CTRL);
+
+	rkisp1_iowrite32(params_vdev,
+			 arg->meas_window.h_offs, CIF_ISP_EXP_H_OFFSET);
+	rkisp1_iowrite32(params_vdev,
+			 arg->meas_window.v_offs, CIF_ISP_EXP_V_OFFSET);
+
+	block_hsize = arg->meas_window.h_size / CIF_ISP_EXP_COLUMN_NUM - 1;
+	block_vsize = arg->meas_window.v_size / CIF_ISP_EXP_ROW_NUM - 1;
+
+	rkisp1_iowrite32(params_vdev, CIF_ISP_EXP_H_SIZE_SET(block_hsize),
+			 CIF_ISP_EXP_H_SIZE);
+	rkisp1_iowrite32(params_vdev, CIF_ISP_EXP_V_SIZE_SET(block_vsize),
+			 CIF_ISP_EXP_V_SIZE);
+}
+
+static void cproc_config(struct rkisp1_isp_params_vdev *params_vdev,
+			 const struct cifisp_cproc_config *arg)
+{
+	struct cifisp_isp_other_cfg *cur_other_cfg =
+						&params_vdev->cur_params.others;
+	struct cifisp_ie_config *cur_ie_config = &cur_other_cfg->ie_config;
+	u32 effect = cur_ie_config->effect;
+	u32 quantization = params_vdev->quantization;
+
+	rkisp1_iowrite32(params_vdev, arg->contrast, CIF_C_PROC_CONTRAST);
+	rkisp1_iowrite32(params_vdev, arg->hue, CIF_C_PROC_HUE);
+	rkisp1_iowrite32(params_vdev, arg->sat, CIF_C_PROC_SATURATION);
+	rkisp1_iowrite32(params_vdev, arg->brightness, CIF_C_PROC_BRIGHTNESS);
+
+	if (quantization != V4L2_QUANTIZATION_FULL_RANGE ||
+	    effect != V4L2_COLORFX_NONE) {
+		isp_param_clear_bits(params_vdev, CIF_C_PROC_CTRL,
+				     CIF_C_PROC_YOUT_FULL |
+				     CIF_C_PROC_YIN_FULL |
+				     CIF_C_PROC_COUT_FULL);
+	} else {
+		isp_param_set_bits(params_vdev, CIF_C_PROC_CTRL,
+				   CIF_C_PROC_YOUT_FULL |
+				   CIF_C_PROC_YIN_FULL |
+				   CIF_C_PROC_COUT_FULL);
+	}
+}
+
+static void hst_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_hst_config *arg)
+{
+	unsigned int block_hsize, block_vsize;
+	static const u32 hist_weight_regs[] = {
+		CIF_ISP_HIST_WEIGHT_00TO30, CIF_ISP_HIST_WEIGHT_40TO21,
+		CIF_ISP_HIST_WEIGHT_31TO12, CIF_ISP_HIST_WEIGHT_22TO03,
+		CIF_ISP_HIST_WEIGHT_13TO43, CIF_ISP_HIST_WEIGHT_04TO34,
+		CIF_ISP_HIST_WEIGHT_44,
+	};
+	const u8 *weight;
+	unsigned int i;
+	u32 hist_prop;
+
+	/* avoid to override the old enable value */
+	hist_prop = rkisp1_ioread32(params_vdev, CIF_ISP_HIST_PROP);
+	hist_prop &= CIF_ISP_HIST_PROP_MODE_MASK;
+	hist_prop |= CIF_ISP_HIST_PREDIV_SET(arg->histogram_predivider);
+	rkisp1_iowrite32(params_vdev, hist_prop, CIF_ISP_HIST_PROP);
+	rkisp1_iowrite32(params_vdev,
+			arg->meas_window.h_offs,
+			CIF_ISP_HIST_H_OFFS);
+	rkisp1_iowrite32(params_vdev,
+			arg->meas_window.v_offs,
+			CIF_ISP_HIST_V_OFFS);
+
+	block_hsize = arg->meas_window.h_size / CIF_ISP_HIST_COLUMN_NUM - 1;
+	block_vsize = arg->meas_window.v_size / CIF_ISP_HIST_ROW_NUM - 1;
+
+	rkisp1_iowrite32(params_vdev, block_hsize, CIF_ISP_HIST_H_SIZE);
+	rkisp1_iowrite32(params_vdev, block_vsize, CIF_ISP_HIST_V_SIZE);
+
+	weight = arg->hist_weight;
+	for (i = 0; i < ARRAY_SIZE(hist_weight_regs); ++i, weight += 4)
+		rkisp1_iowrite32(params_vdev, CIF_ISP_HIST_WEIGHT_SET(
+				 weight[0], weight[1], weight[2], weight[3]),
+				 hist_weight_regs[i]);
+}
+
+static void hst_enable(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_hst_config *arg, bool en)
+{
+	if (en)	{
+		u32 hist_prop = rkisp1_ioread32(params_vdev, CIF_ISP_HIST_PROP);
+
+		hist_prop &= ~CIF_ISP_HIST_PROP_MODE_MASK;
+		hist_prop |= arg->mode;
+		isp_param_set_bits(params_vdev, CIF_ISP_HIST_PROP, hist_prop);
+	} else {
+		isp_param_clear_bits(params_vdev, CIF_ISP_HIST_PROP,
+				CIF_ISP_HIST_PROP_MODE_MASK);
+	}
+}
+
+static void afm_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_afc_config *arg)
+{
+	size_t num_of_win = min_t(size_t, ARRAY_SIZE(arg->afm_win),
+				  arg->num_afm_win);
+	u32 afm_ctrl = rkisp1_ioread32(params_vdev, CIF_ISP_AFM_CTRL);
+	unsigned int i;
+
+	/* Switch off to configure. */
+	isp_param_clear_bits(params_vdev, CIF_ISP_AFM_CTRL, CIF_ISP_AFM_ENA);
+
+	for (i = 0; i < num_of_win; i++) {
+		rkisp1_iowrite32(params_vdev,
+				 CIF_ISP_AFM_WINDOW_X(arg->afm_win[i].h_offs) |
+				 CIF_ISP_AFM_WINDOW_Y(arg->afm_win[i].v_offs),
+				 CIF_ISP_AFM_LT_A + i * 8);
+		rkisp1_iowrite32(params_vdev,
+				 CIF_ISP_AFM_WINDOW_X(arg->afm_win[i].h_size +
+						      arg->afm_win[i].h_offs) |
+				 CIF_ISP_AFM_WINDOW_Y(arg->afm_win[i].v_size +
+						      arg->afm_win[i].v_offs),
+				 CIF_ISP_AFM_RB_A + i * 8);
+	}
+	rkisp1_iowrite32(params_vdev, arg->thres, CIF_ISP_AFM_THRES);
+	rkisp1_iowrite32(params_vdev, arg->var_shift, CIF_ISP_AFM_VAR_SHIFT);
+	/* restore afm status */
+	rkisp1_iowrite32(params_vdev, afm_ctrl, CIF_ISP_AFM_CTRL);
+}
+
+static void ie_config(struct rkisp1_isp_params_vdev *params_vdev,
+		      const struct cifisp_ie_config *arg)
+{
+	u32 eff_ctrl;
+
+	eff_ctrl = rkisp1_ioread32(params_vdev, CIF_IMG_EFF_CTRL);
+	eff_ctrl &= ~CIF_IMG_EFF_CTRL_MODE_MASK;
+
+	if (params_vdev->quantization == V4L2_QUANTIZATION_FULL_RANGE)
+		eff_ctrl |= CIF_IMG_EFF_CTRL_YCBCR_FULL;
+
+	switch (arg->effect) {
+	case V4L2_COLORFX_SEPIA:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_SEPIA;
+		break;
+	case V4L2_COLORFX_SET_CBCR:
+		rkisp1_iowrite32(params_vdev, arg->eff_tint, CIF_IMG_EFF_TINT);
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_SEPIA;
+		break;
+		/*
+		 * Color selection is similar to water color(AQUA):
+		 * grayscale + selected color w threshold
+		 */
+	case V4L2_COLORFX_AQUA:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_COLOR_SEL;
+		rkisp1_iowrite32(params_vdev, arg->color_sel,
+				 CIF_IMG_EFF_COLOR_SEL);
+		break;
+	case V4L2_COLORFX_EMBOSS:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_EMBOSS;
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_1,
+				 CIF_IMG_EFF_MAT_1);
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_2,
+				 CIF_IMG_EFF_MAT_2);
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_3,
+				 CIF_IMG_EFF_MAT_3);
+		break;
+	case V4L2_COLORFX_SKETCH:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_SKETCH;
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_3,
+				 CIF_IMG_EFF_MAT_3);
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_4,
+				 CIF_IMG_EFF_MAT_4);
+		rkisp1_iowrite32(params_vdev, arg->eff_mat_5,
+				 CIF_IMG_EFF_MAT_5);
+		break;
+	case V4L2_COLORFX_BW:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_BLACKWHITE;
+		break;
+	case V4L2_COLORFX_NEGATIVE:
+		eff_ctrl |= CIF_IMG_EFF_CTRL_MODE_NEGATIVE;
+		break;
+	default:
+		break;
+	}
+
+	rkisp1_iowrite32(params_vdev, eff_ctrl, CIF_IMG_EFF_CTRL);
+}
+
+static void ie_enable(struct rkisp1_isp_params_vdev *params_vdev, bool en)
+{
+	if (en) {
+		isp_param_set_bits(params_vdev, CIF_ICCL, CIF_ICCL_IE_CLK);
+		rkisp1_iowrite32(params_vdev, CIF_IMG_EFF_CTRL_ENABLE,
+				 CIF_IMG_EFF_CTRL);
+		isp_param_set_bits(params_vdev, CIF_IMG_EFF_CTRL,
+				   CIF_IMG_EFF_CTRL_CFG_UPD);
+	} else {
+		isp_param_clear_bits(params_vdev, CIF_IMG_EFF_CTRL,
+				     CIF_IMG_EFF_CTRL_ENABLE);
+		isp_param_clear_bits(params_vdev, CIF_ICCL, CIF_ICCL_IE_CLK);
+	}
+}
+
+static void csm_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       bool full_range)
+{
+	static const u16 full_range_coeff[] = {
+		0x0026, 0x004b, 0x000f,
+		0x01ea, 0x01d6, 0x0040,
+		0x0040, 0x01ca, 0x01f6
+	};
+	static const u16 limited_range_coeff[] = {
+		0x0021, 0x0040, 0x000d,
+		0x01ed, 0x01db, 0x0038,
+		0x0038, 0x01d1, 0x01f7,
+	};
+	unsigned int i;
+
+	if (full_range) {
+		for (i = 0; i < ARRAY_SIZE(full_range_coeff); i++)
+			rkisp1_iowrite32(params_vdev, full_range_coeff[i],
+					 CIF_ISP_CC_COEFF_0 + i * 4);
+
+		isp_param_set_bits(params_vdev, CIF_ISP_CTRL,
+				   CIF_ISP_CTRL_ISP_CSM_Y_FULL_ENA |
+				   CIF_ISP_CTRL_ISP_CSM_C_FULL_ENA);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(limited_range_coeff); i++)
+			rkisp1_iowrite32(params_vdev, limited_range_coeff[i],
+					 CIF_ISP_CC_COEFF_0 + i * 4);
+
+		isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+				     CIF_ISP_CTRL_ISP_CSM_Y_FULL_ENA |
+				     CIF_ISP_CTRL_ISP_CSM_C_FULL_ENA);
+	}
+}
+
+/* ISP De-noise Pre-Filter(DPF) function */
+static void dpf_config(struct rkisp1_isp_params_vdev *params_vdev,
+		       const struct cifisp_dpf_config *arg)
+{
+	unsigned int isp_dpf_mode, spatial_coeff, i;
+
+	switch (arg->gain.mode) {
+	case CIFISP_DPF_GAIN_USAGE_NF_GAINS:
+		isp_dpf_mode = CIF_ISP_DPF_MODE_USE_NF_GAIN |
+				CIF_ISP_DPF_MODE_AWB_GAIN_COMP;
+		break;
+	case CIFISP_DPF_GAIN_USAGE_LSC_GAINS:
+		isp_dpf_mode = CIF_ISP_DPF_MODE_LSC_GAIN_COMP;
+		break;
+	case CIFISP_DPF_GAIN_USAGE_NF_LSC_GAINS:
+		isp_dpf_mode = CIF_ISP_DPF_MODE_USE_NF_GAIN |
+				CIF_ISP_DPF_MODE_AWB_GAIN_COMP |
+				CIF_ISP_DPF_MODE_LSC_GAIN_COMP;
+		break;
+	case CIFISP_DPF_GAIN_USAGE_AWB_GAINS:
+		isp_dpf_mode = CIF_ISP_DPF_MODE_AWB_GAIN_COMP;
+		break;
+	case CIFISP_DPF_GAIN_USAGE_AWB_LSC_GAINS:
+		isp_dpf_mode = CIF_ISP_DPF_MODE_LSC_GAIN_COMP |
+				CIF_ISP_DPF_MODE_AWB_GAIN_COMP;
+		break;
+	case CIFISP_DPF_GAIN_USAGE_DISABLED:
+	default:
+		isp_dpf_mode = 0;
+		break;
+	}
+
+	if (arg->nll.scale_mode == CIFISP_NLL_SCALE_LOGARITHMIC)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_NLL_SEGMENTATION;
+	if (arg->rb_flt.fltsize == CIFISP_DPF_RB_FILTERSIZE_9x9)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_RB_FLTSIZE_9x9;
+	if (!arg->rb_flt.r_enable)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_R_FLT_DIS;
+	if (!arg->rb_flt.b_enable)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_B_FLT_DIS;
+	if (!arg->g_flt.gb_enable)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_GB_FLT_DIS;
+	if (!arg->g_flt.gr_enable)
+		isp_dpf_mode |= CIF_ISP_DPF_MODE_GR_FLT_DIS;
+
+	isp_param_set_bits(params_vdev, CIF_ISP_DPF_MODE, isp_dpf_mode);
+	rkisp1_iowrite32(params_vdev, arg->gain.nf_b_gain,
+			 CIF_ISP_DPF_NF_GAIN_B);
+	rkisp1_iowrite32(params_vdev, arg->gain.nf_r_gain,
+			 CIF_ISP_DPF_NF_GAIN_R);
+	rkisp1_iowrite32(params_vdev, arg->gain.nf_gb_gain,
+			 CIF_ISP_DPF_NF_GAIN_GB);
+	rkisp1_iowrite32(params_vdev, arg->gain.nf_gr_gain,
+			 CIF_ISP_DPF_NF_GAIN_GR);
+
+	for (i = 0; i < CIFISP_DPF_MAX_NLF_COEFFS; i++) {
+		rkisp1_iowrite32(params_vdev, arg->nll.coeff[i],
+				 CIF_ISP_DPF_NULL_COEFF_0 + i * 4);
+	}
+
+	spatial_coeff = arg->g_flt.spatial_coeff[0] |
+			(arg->g_flt.spatial_coeff[1] << 8) |
+			(arg->g_flt.spatial_coeff[2] << 16) |
+			(arg->g_flt.spatial_coeff[3] << 24);
+	rkisp1_iowrite32(params_vdev, spatial_coeff,
+			 CIF_ISP_DPF_S_WEIGHT_G_1_4);
+
+	spatial_coeff = arg->g_flt.spatial_coeff[4] |
+			(arg->g_flt.spatial_coeff[5] << 8);
+	rkisp1_iowrite32(params_vdev, spatial_coeff,
+			 CIF_ISP_DPF_S_WEIGHT_G_5_6);
+
+	spatial_coeff = arg->rb_flt.spatial_coeff[0] |
+			(arg->rb_flt.spatial_coeff[1] << 8) |
+			(arg->rb_flt.spatial_coeff[2] << 16) |
+			(arg->rb_flt.spatial_coeff[3] << 24);
+	rkisp1_iowrite32(params_vdev, spatial_coeff,
+			 CIF_ISP_DPF_S_WEIGHT_RB_1_4);
+
+	spatial_coeff = arg->rb_flt.spatial_coeff[4] |
+			(arg->rb_flt.spatial_coeff[5] << 8);
+	rkisp1_iowrite32(params_vdev, spatial_coeff,
+			CIF_ISP_DPF_S_WEIGHT_RB_5_6);
+}
+
+static void dpf_strength_config(struct rkisp1_isp_params_vdev *params_vdev,
+				const struct cifisp_dpf_strength_config *arg)
+{
+	rkisp1_iowrite32(params_vdev, arg->b, CIF_ISP_DPF_STRENGTH_B);
+	rkisp1_iowrite32(params_vdev, arg->g, CIF_ISP_DPF_STRENGTH_G);
+	rkisp1_iowrite32(params_vdev, arg->r, CIF_ISP_DPF_STRENGTH_R);
+}
+
+static __maybe_unused
+void __isp_isr_other_config(struct rkisp1_isp_params_vdev *params_vdev,
+			    const struct rkisp1_isp_params_cfg *new_params)
+{
+	unsigned int module_en_update, module_cfg_update, module_ens;
+
+	module_en_update = new_params->module_en_update;
+	module_cfg_update = new_params->module_cfg_update;
+	module_ens = new_params->module_ens;
+
+	if ((module_en_update & CIFISP_MODULE_DPCC) ||
+	    (module_cfg_update & CIFISP_MODULE_DPCC)) {
+		/*update dpc config */
+		if ((module_cfg_update & CIFISP_MODULE_DPCC))
+			dpcc_config(params_vdev,
+				    &new_params->others.dpcc_config);
+
+		if (module_en_update & CIFISP_MODULE_DPCC) {
+			if (!!(module_ens & CIFISP_MODULE_DPCC))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_DPCC_MODE,
+						   CIF_ISP_DPCC_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_DPCC_MODE,
+						     CIF_ISP_DPCC_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_BLS) ||
+	    (module_cfg_update & CIFISP_MODULE_BLS)) {
+		/* update bls config */
+		if ((module_cfg_update & CIFISP_MODULE_BLS))
+			bls_config(params_vdev, &new_params->others.bls_config);
+
+		if (module_en_update & CIFISP_MODULE_BLS) {
+			if (!!(module_ens & CIFISP_MODULE_BLS))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_BLS_CTRL,
+						   CIF_ISP_BLS_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_BLS_CTRL,
+						     CIF_ISP_BLS_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_SDG) ||
+	    (module_cfg_update & CIFISP_MODULE_SDG)) {
+		/* update sdg config */
+		if ((module_cfg_update & CIFISP_MODULE_SDG))
+			sdg_config(params_vdev, &new_params->others.sdg_config);
+
+		if (module_en_update & CIFISP_MODULE_SDG) {
+			if (!!(module_ens & CIFISP_MODULE_SDG))
+				isp_param_set_bits(params_vdev,
+						CIF_ISP_CTRL,
+						CIF_ISP_CTRL_ISP_GAMMA_IN_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						CIF_ISP_CTRL,
+						CIF_ISP_CTRL_ISP_GAMMA_IN_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_LSC) ||
+	    (module_cfg_update & CIFISP_MODULE_LSC)) {
+		/* update lsc config */
+		if ((module_cfg_update & CIFISP_MODULE_LSC))
+			lsc_config(params_vdev, &new_params->others.lsc_config);
+
+		if (module_en_update & CIFISP_MODULE_LSC) {
+			if (!!(module_ens & CIFISP_MODULE_LSC))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_LSC_CTRL,
+						   CIF_ISP_LSC_CTRL_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_LSC_CTRL,
+						     CIF_ISP_LSC_CTRL_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_AWB_GAIN) ||
+	    (module_cfg_update & CIFISP_MODULE_AWB_GAIN)) {
+		/* update awb gains */
+		if ((module_cfg_update & CIFISP_MODULE_AWB_GAIN))
+			awb_gain_config(params_vdev,
+					&new_params->others.awb_gain_config);
+
+		if (module_en_update & CIFISP_MODULE_AWB_GAIN) {
+			if (!!(module_ens & CIFISP_MODULE_AWB_GAIN))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_CTRL,
+						   CIF_ISP_CTRL_ISP_AWB_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_CTRL,
+						     CIF_ISP_CTRL_ISP_AWB_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_BDM) ||
+	    (module_cfg_update & CIFISP_MODULE_BDM)) {
+		/* update bdm config */
+		if ((module_cfg_update & CIFISP_MODULE_BDM))
+			bdm_config(params_vdev, &new_params->others.bdm_config);
+
+		if (module_en_update & CIFISP_MODULE_BDM) {
+			if (!!(module_ens & CIFISP_MODULE_BDM))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_DEMOSAIC,
+						   CIF_ISP_DEMOSAIC_BYPASS);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_DEMOSAIC,
+						     CIF_ISP_DEMOSAIC_BYPASS);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_FLT) ||
+	    (module_cfg_update & CIFISP_MODULE_FLT)) {
+		/* update filter config */
+		if ((module_cfg_update & CIFISP_MODULE_FLT))
+			flt_config(params_vdev, &new_params->others.flt_config);
+
+		if (module_en_update & CIFISP_MODULE_FLT) {
+			if (!!(module_ens & CIFISP_MODULE_FLT))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_FILT_MODE,
+						   CIF_ISP_FLT_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_FILT_MODE,
+						     CIF_ISP_FLT_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_CTK) ||
+	    (module_cfg_update & CIFISP_MODULE_CTK)) {
+		/* update ctk config */
+		if ((module_cfg_update & CIFISP_MODULE_CTK))
+			ctk_config(params_vdev, &new_params->others.ctk_config);
+
+		if (module_en_update & CIFISP_MODULE_CTK)
+			ctk_enable(params_vdev,
+				   !!(module_ens & CIFISP_MODULE_CTK));
+	}
+
+	if ((module_en_update & CIFISP_MODULE_GOC) ||
+	    (module_cfg_update & CIFISP_MODULE_GOC)) {
+		/* update goc config */
+		if ((module_cfg_update & CIFISP_MODULE_GOC))
+			goc_config(params_vdev, &new_params->others.goc_config);
+
+		if (module_en_update & CIFISP_MODULE_GOC) {
+			if (!!(module_ens & CIFISP_MODULE_GOC))
+				isp_param_set_bits(params_vdev,
+						CIF_ISP_CTRL,
+						CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						CIF_ISP_CTRL,
+						CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_CPROC) ||
+	    (module_cfg_update & CIFISP_MODULE_CPROC)) {
+		/* update cproc config */
+		if ((module_cfg_update & CIFISP_MODULE_CPROC)) {
+			cproc_config(params_vdev,
+				     &new_params->others.cproc_config);
+
+		}
+
+		if (module_en_update & CIFISP_MODULE_CPROC) {
+			if (!!(module_ens & CIFISP_MODULE_CPROC))
+				isp_param_set_bits(params_vdev,
+						   CIF_C_PROC_CTRL,
+						   CIF_C_PROC_CTR_ENABLE);
+			else
+				isp_param_clear_bits(params_vdev,
+						   CIF_C_PROC_CTRL,
+						   CIF_C_PROC_CTR_ENABLE);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_IE) ||
+	    (module_cfg_update & CIFISP_MODULE_IE)) {
+		/* update ie config */
+		if ((module_cfg_update & CIFISP_MODULE_IE))
+			ie_config(params_vdev, &new_params->others.ie_config);
+
+		if (module_en_update & CIFISP_MODULE_IE)
+			ie_enable(params_vdev,
+				   !!(module_ens & CIFISP_MODULE_IE));
+	}
+
+	if ((module_en_update & CIFISP_MODULE_DPF) ||
+	    (module_cfg_update & CIFISP_MODULE_DPF)) {
+		/* update dpf  config */
+		if ((module_cfg_update & CIFISP_MODULE_DPF))
+			dpf_config(params_vdev, &new_params->others.dpf_config);
+
+		if (module_en_update & CIFISP_MODULE_DPF) {
+			if (!!(module_ens & CIFISP_MODULE_DPF))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_DPF_MODE,
+						   CIF_ISP_DPF_MODE_EN);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_DPF_MODE,
+						     CIF_ISP_DPF_MODE_EN);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_DPF_STRENGTH) ||
+	    (module_cfg_update & CIFISP_MODULE_DPF_STRENGTH)) {
+		/* update dpf strength config */
+		dpf_strength_config(params_vdev,
+				    &new_params->others.dpf_strength_config);
+	}
+}
+
+static __maybe_unused
+void __isp_isr_meas_config(struct rkisp1_isp_params_vdev *params_vdev,
+			   struct  rkisp1_isp_params_cfg *new_params)
+{
+	unsigned int module_en_update, module_cfg_update, module_ens;
+
+	module_en_update = new_params->module_en_update;
+	module_cfg_update = new_params->module_cfg_update;
+	module_ens = new_params->module_ens;
+
+	if ((module_en_update & CIFISP_MODULE_AWB) ||
+	    (module_cfg_update & CIFISP_MODULE_AWB)) {
+		/* update awb config */
+		if ((module_cfg_update & CIFISP_MODULE_AWB))
+			awb_meas_config(params_vdev,
+					&new_params->meas.awb_meas_config);
+
+		if (module_en_update & CIFISP_MODULE_AWB)
+			awb_meas_enable(params_vdev,
+					&new_params->meas.awb_meas_config,
+					!!(module_ens & CIFISP_MODULE_AWB));
+	}
+
+	if ((module_en_update & CIFISP_MODULE_AFC) ||
+	    (module_cfg_update & CIFISP_MODULE_AFC)) {
+		/* update afc config */
+		if ((module_cfg_update & CIFISP_MODULE_AFC))
+			afm_config(params_vdev, &new_params->meas.afc_config);
+
+		if (module_en_update & CIFISP_MODULE_AFC) {
+			if (!!(module_ens & CIFISP_MODULE_AFC))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_AFM_CTRL,
+						   CIF_ISP_AFM_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_AFM_CTRL,
+						     CIF_ISP_AFM_ENA);
+		}
+	}
+
+	if ((module_en_update & CIFISP_MODULE_HST) ||
+	    (module_cfg_update & CIFISP_MODULE_HST)) {
+		/* update hst config */
+		if ((module_cfg_update & CIFISP_MODULE_HST))
+			hst_config(params_vdev, &new_params->meas.hst_config);
+
+		if (module_en_update & CIFISP_MODULE_HST)
+			hst_enable(params_vdev,
+				   &new_params->meas.hst_config,
+				   !!(module_ens & CIFISP_MODULE_HST));
+	}
+
+	if ((module_en_update & CIFISP_MODULE_AEC) ||
+	    (module_cfg_update & CIFISP_MODULE_AEC)) {
+		/* update aec config */
+		if ((module_cfg_update & CIFISP_MODULE_AEC))
+			aec_config(params_vdev, &new_params->meas.aec_config);
+
+		if (module_en_update & CIFISP_MODULE_AEC) {
+			if (!!(module_ens & CIFISP_MODULE_AEC))
+				isp_param_set_bits(params_vdev,
+						   CIF_ISP_EXP_CTRL,
+						   CIF_ISP_EXP_ENA);
+			else
+				isp_param_clear_bits(params_vdev,
+						     CIF_ISP_EXP_CTRL,
+						     CIF_ISP_EXP_ENA);
+		}
+	}
+}
+
+void rkisp1_params_isr(struct rkisp1_device *dev, u32 isp_mis)
+{
+	struct rkisp1_isp_params_vdev *params_vdev = &dev->params_vdev;
+	struct rkisp1_isp_params_cfg *new_params;
+	struct rkisp1_buffer *cur_buf = NULL;
+	unsigned int cur_frame_id = -1;
+
+	cur_frame_id = atomic_read(&dev->isp_sdev.frm_sync_seq) - 1;
+
+	spin_lock(&params_vdev->config_lock);
+	if (!params_vdev->streamon) {
+		spin_unlock(&params_vdev->config_lock);
+		return;
+	}
+
+	/* get one empty buffer */
+	if (!list_empty(&params_vdev->params))
+		cur_buf = list_first_entry(&params_vdev->params,
+					   struct rkisp1_buffer, queue);
+	spin_unlock(&params_vdev->config_lock);
+
+	if (!cur_buf)
+		return;
+
+	new_params = (struct rkisp1_isp_params_cfg *)(cur_buf->vaddr[0]);
+
+	if (isp_mis & CIF_ISP_FRAME) {
+		u32 isp_ctrl;
+
+		__isp_isr_other_config(params_vdev, new_params);
+		__isp_isr_meas_config(params_vdev, new_params);
+
+		/* update shadow register immediately */
+		isp_ctrl = rkisp1_ioread32(params_vdev, CIF_ISP_CTRL);
+		isp_ctrl |= CIF_ISP_CTRL_ISP_CFG_UPD;
+		rkisp1_iowrite32(params_vdev, isp_ctrl, CIF_ISP_CTRL);
+
+		spin_lock(&params_vdev->config_lock);
+		list_del(&cur_buf->queue);
+		spin_unlock(&params_vdev->config_lock);
+
+		cur_buf->vb.sequence = cur_frame_id;
+		vb2_buffer_done(&cur_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	}
+}
+
+static const struct cifisp_awb_meas_config awb_params_default_config = {
+	{
+		0, 0, RKISP1_DEFAULT_WIDTH, RKISP1_DEFAULT_HEIGHT
+	},
+	CIFISP_AWB_MODE_YCBCR, 200, 30, 20, 20, 0, 128, 128
+};
+
+static const struct cifisp_aec_config aec_params_default_config = {
+	CIFISP_EXP_MEASURING_MODE_0,
+	CIFISP_EXP_CTRL_AUTOSTOP_0,
+	{
+		RKISP1_DEFAULT_WIDTH >> 2, RKISP1_DEFAULT_HEIGHT >> 2,
+		RKISP1_DEFAULT_WIDTH >> 1, RKISP1_DEFAULT_HEIGHT >> 1
+	}
+};
+
+static const struct cifisp_hst_config hst_params_default_config = {
+	CIFISP_HISTOGRAM_MODE_RGB_COMBINED,
+	3,
+	{
+		RKISP1_DEFAULT_WIDTH >> 2, RKISP1_DEFAULT_HEIGHT >> 2,
+		RKISP1_DEFAULT_WIDTH >> 1, RKISP1_DEFAULT_HEIGHT >> 1
+	},
+	{
+		0, /* To be filled in with 0x01 at runtime. */
+	}
+};
+
+static const struct cifisp_afc_config afc_params_default_config = {
+	1,
+	{
+		{
+			300, 225, 200, 150
+		}
+	},
+	4,
+	14
+};
+
+static
+void rkisp1_params_config_parameter(struct rkisp1_isp_params_vdev *params_vdev)
+{
+	struct cifisp_hst_config hst = hst_params_default_config;
+
+	spin_lock(&params_vdev->config_lock);
+
+	awb_meas_config(params_vdev, &awb_params_default_config);
+	awb_meas_enable(params_vdev, &awb_params_default_config, true);
+
+	aec_config(params_vdev, &aec_params_default_config);
+	isp_param_set_bits(params_vdev, CIF_ISP_EXP_CTRL, CIF_ISP_EXP_ENA);
+
+	afm_config(params_vdev, &afc_params_default_config);
+	isp_param_set_bits(params_vdev, CIF_ISP_AFM_CTRL, CIF_ISP_AFM_ENA);
+
+	memset(hst.hist_weight, 0x01, sizeof(hst.hist_weight));
+	hst_config(params_vdev, &hst);
+	isp_param_set_bits(params_vdev, CIF_ISP_HIST_PROP,
+			   ~CIF_ISP_HIST_PROP_MODE_MASK |
+			   hst_params_default_config.mode);
+
+	/* set the  range */
+	if (params_vdev->quantization == V4L2_QUANTIZATION_FULL_RANGE)
+		csm_config(params_vdev, true);
+	else
+		csm_config(params_vdev, false);
+
+	/* override the default things */
+	__isp_isr_other_config(params_vdev, &params_vdev->cur_params);
+	__isp_isr_meas_config(params_vdev, &params_vdev->cur_params);
+
+	spin_unlock(&params_vdev->config_lock);
+}
+
+/* Not called when the camera active, thus not isr protection. */
+void rkisp1_params_configure_isp(struct rkisp1_isp_params_vdev *params_vdev,
+				 const struct rkisp1_fmt *in_fmt,
+				 enum v4l2_quantization quantization)
+{
+	params_vdev->quantization = quantization;
+	params_vdev->raw_type = in_fmt->bayer_pat;
+	rkisp1_params_config_parameter(params_vdev);
+}
+
+/* Not called when the camera active, thus not isr protection. */
+void rkisp1_params_disable_isp(struct rkisp1_isp_params_vdev *params_vdev)
+{
+	isp_param_clear_bits(params_vdev, CIF_ISP_DPCC_MODE, CIF_ISP_DPCC_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_LSC_CTRL,
+			     CIF_ISP_LSC_CTRL_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_BLS_CTRL, CIF_ISP_BLS_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+			     CIF_ISP_CTRL_ISP_GAMMA_IN_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+			     CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_DEMOSAIC,
+			     CIF_ISP_DEMOSAIC_BYPASS);
+	isp_param_clear_bits(params_vdev, CIF_ISP_FILT_MODE, CIF_ISP_FLT_ENA);
+	awb_meas_enable(params_vdev, NULL, false);
+	isp_param_clear_bits(params_vdev, CIF_ISP_CTRL,
+			     CIF_ISP_CTRL_ISP_AWB_ENA);
+	isp_param_clear_bits(params_vdev, CIF_ISP_EXP_CTRL, CIF_ISP_EXP_ENA);
+	ctk_enable(params_vdev, false);
+	isp_param_clear_bits(params_vdev, CIF_C_PROC_CTRL,
+			     CIF_C_PROC_CTR_ENABLE);
+	hst_enable(params_vdev, NULL, false);
+	isp_param_clear_bits(params_vdev, CIF_ISP_AFM_CTRL, CIF_ISP_AFM_ENA);
+	ie_enable(params_vdev, false);
+	isp_param_clear_bits(params_vdev, CIF_ISP_DPF_MODE,
+			     CIF_ISP_DPF_MODE_EN);
+}
+
+static int rkisp1_params_enum_fmt_meta_out(struct file *file, void *priv,
+					   struct v4l2_fmtdesc *f)
+{
+	struct video_device *video = video_devdata(file);
+	struct rkisp1_isp_params_vdev *params_vdev = video_get_drvdata(video);
+
+	if (f->index > 0 || f->type != video->queue->type)
+		return -EINVAL;
+
+	f->pixelformat = params_vdev->vdev_fmt.fmt.meta.dataformat;
+
+	return 0;
+}
+
+static int rkisp1_params_g_fmt_meta_out(struct file *file, void *fh,
+					struct v4l2_format *f)
+{
+	struct video_device *video = video_devdata(file);
+	struct rkisp1_isp_params_vdev *params_vdev = video_get_drvdata(video);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->queue->type)
+		return -EINVAL;
+
+	memset(meta, 0, sizeof(*meta));
+	meta->dataformat = params_vdev->vdev_fmt.fmt.meta.dataformat;
+	meta->buffersize = params_vdev->vdev_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static int rkisp1_params_querycap(struct file *file,
+				  void *priv, struct v4l2_capability *cap)
+{
+	struct video_device *vdev = video_devdata(file);
+
+	strscpy(cap->driver, DRIVER_NAME, sizeof(cap->driver));
+	strscpy(cap->card, vdev->name, sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: " DRIVER_NAME, sizeof(cap->bus_info));
+
+	return 0;
+}
+
+/* ISP params video device IOCTLs */
+static const struct v4l2_ioctl_ops rkisp1_params_ioctl = {
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_enum_fmt_meta_out = rkisp1_params_enum_fmt_meta_out,
+	.vidioc_g_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
+	.vidioc_s_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
+	.vidioc_try_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
+	.vidioc_querycap = rkisp1_params_querycap,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static int rkisp1_params_vb2_queue_setup(struct vb2_queue *vq,
+					 unsigned int *num_buffers,
+					 unsigned int *num_planes,
+					 unsigned int sizes[],
+					 struct device *alloc_devs[])
+{
+	struct rkisp1_isp_params_vdev *params_vdev = vq->drv_priv;
+
+	*num_buffers = clamp_t(u32, *num_buffers,
+			       RKISP1_ISP_PARAMS_REQ_BUFS_MIN,
+			       RKISP1_ISP_PARAMS_REQ_BUFS_MAX);
+
+	*num_planes = 1;
+
+	sizes[0] = sizeof(struct rkisp1_isp_params_cfg);
+
+	INIT_LIST_HEAD(&params_vdev->params);
+	params_vdev->first_params = true;
+
+	return 0;
+}
+
+static void rkisp1_params_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rkisp1_buffer *params_buf = to_rkisp1_buffer(vbuf);
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct rkisp1_isp_params_vdev *params_vdev = vq->drv_priv;
+	struct rkisp1_isp_params_cfg *new_params;
+	unsigned long flags;
+
+	unsigned int cur_frame_id = -1;
+
+	cur_frame_id =
+		atomic_read(&params_vdev->dev->isp_sdev.frm_sync_seq) - 1;
+
+	if (params_vdev->first_params) {
+		new_params = (struct rkisp1_isp_params_cfg *)
+			(vb2_plane_vaddr(vb, 0));
+		vbuf->sequence = cur_frame_id;
+		vb2_buffer_done(&params_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		params_vdev->first_params = false;
+		params_vdev->cur_params = *new_params;
+		return;
+	}
+
+	params_buf->vaddr[0] = vb2_plane_vaddr(vb, 0);
+	spin_lock_irqsave(&params_vdev->config_lock, flags);
+	list_add_tail(&params_buf->queue, &params_vdev->params);
+	spin_unlock_irqrestore(&params_vdev->config_lock, flags);
+}
+
+static int rkisp1_params_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	if (vb2_plane_size(vb, 0) < sizeof(struct rkisp1_isp_params_cfg))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct rkisp1_isp_params_cfg));
+
+	return 0;
+}
+
+static void rkisp1_params_vb2_stop_streaming(struct vb2_queue *vq)
+{
+	struct rkisp1_isp_params_vdev *params_vdev = vq->drv_priv;
+	struct rkisp1_buffer *buf;
+	unsigned long flags;
+	unsigned int i;
+
+	/* stop params input firstly */
+	spin_lock_irqsave(&params_vdev->config_lock, flags);
+	params_vdev->streamon = false;
+	spin_unlock_irqrestore(&params_vdev->config_lock, flags);
+
+	for (i = 0; i < RKISP1_ISP_PARAMS_REQ_BUFS_MAX; i++) {
+		spin_lock_irqsave(&params_vdev->config_lock, flags);
+		if (!list_empty(&params_vdev->params)) {
+			buf = list_first_entry(&params_vdev->params,
+					       struct rkisp1_buffer, queue);
+			list_del(&buf->queue);
+			spin_unlock_irqrestore(&params_vdev->config_lock,
+					       flags);
+		} else {
+			spin_unlock_irqrestore(&params_vdev->config_lock,
+					       flags);
+			break;
+		}
+
+		if (buf)
+			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		buf = NULL;
+	}
+}
+
+static int
+rkisp1_params_vb2_start_streaming(struct vb2_queue *queue, unsigned int count)
+{
+	struct rkisp1_isp_params_vdev *params_vdev = queue->drv_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&params_vdev->config_lock, flags);
+	params_vdev->streamon = true;
+	spin_unlock_irqrestore(&params_vdev->config_lock, flags);
+
+	return 0;
+}
+
+static struct vb2_ops rkisp1_params_vb2_ops = {
+	.queue_setup = rkisp1_params_vb2_queue_setup,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.buf_queue = rkisp1_params_vb2_buf_queue,
+	.buf_prepare = rkisp1_params_vb2_buf_prepare,
+	.start_streaming = rkisp1_params_vb2_start_streaming,
+	.stop_streaming = rkisp1_params_vb2_stop_streaming,
+
+};
+
+struct v4l2_file_operations rkisp1_params_fops = {
+	.mmap = vb2_fop_mmap,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vb2_fop_poll,
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release
+};
+
+static int
+rkisp1_params_init_vb2_queue(struct vb2_queue *q,
+			     struct rkisp1_isp_params_vdev *params_vdev)
+{
+	struct rkisp1_vdev_node *node;
+
+	node = queue_to_node(q);
+
+	q->type = V4L2_BUF_TYPE_META_OUTPUT;
+	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	q->drv_priv = params_vdev;
+	q->ops = &rkisp1_params_vb2_ops;
+	q->mem_ops = &vb2_vmalloc_memops;
+	q->buf_struct_size = sizeof(struct rkisp1_buffer);
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &node->vlock;
+
+	return vb2_queue_init(q);
+}
+
+static void rkisp1_init_params_vdev(struct rkisp1_isp_params_vdev *params_vdev)
+{
+	params_vdev->vdev_fmt.fmt.meta.dataformat =
+		V4L2_META_FMT_RK_ISP1_PARAMS;
+	params_vdev->vdev_fmt.fmt.meta.buffersize =
+		sizeof(struct rkisp1_isp_params_cfg);
+}
+
+int rkisp1_register_params_vdev(struct rkisp1_isp_params_vdev *params_vdev,
+				struct v4l2_device *v4l2_dev,
+				struct rkisp1_device *dev)
+{
+	struct rkisp1_vdev_node *node = &params_vdev->vnode;
+	struct video_device *vdev = &node->vdev;
+	int ret;
+
+	params_vdev->dev = dev;
+	mutex_init(&node->vlock);
+	spin_lock_init(&params_vdev->config_lock);
+
+	strscpy(vdev->name, "rkisp1-input-params", sizeof(vdev->name));
+
+	video_set_drvdata(vdev, params_vdev);
+	vdev->ioctl_ops = &rkisp1_params_ioctl;
+	vdev->fops = &rkisp1_params_fops;
+	vdev->release = video_device_release_empty;
+	/*
+	 * Provide a mutex to v4l2 core. It will be used
+	 * to protect all fops and v4l2 ioctls.
+	 */
+	vdev->lock = &node->vlock;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->queue = &node->buf_queue;
+	vdev->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_META_OUTPUT;
+	vdev->vfl_dir = VFL_DIR_TX;
+	rkisp1_params_init_vb2_queue(vdev->queue, params_vdev);
+	rkisp1_init_params_vdev(params_vdev);
+	video_set_drvdata(vdev, params_vdev);
+
+	node->pad.flags = MEDIA_PAD_FL_SOURCE;
+	ret = media_entity_pads_init(&vdev->entity, 1, &node->pad);
+	if (ret < 0)
+		goto err_release_queue;
+	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	if (ret < 0) {
+		dev_err(&vdev->dev,
+			"could not register Video for Linux device\n");
+		goto err_cleanup_media_entity;
+	}
+	return 0;
+err_cleanup_media_entity:
+	media_entity_cleanup(&vdev->entity);
+err_release_queue:
+	vb2_queue_release(vdev->queue);
+	return ret;
+}
+
+void rkisp1_unregister_params_vdev(struct rkisp1_isp_params_vdev *params_vdev)
+{
+	struct rkisp1_vdev_node *node = &params_vdev->vnode;
+	struct video_device *vdev = &node->vdev;
+
+	video_unregister_device(vdev);
+	media_entity_cleanup(&vdev->entity);
+	vb2_queue_release(vdev->queue);
+}
diff --git a/drivers/staging/media/rkisp1/isp_params.h b/drivers/staging/media/rkisp1/isp_params.h
new file mode 100644
index 000000000000..f3a2b1628a52
--- /dev/null
+++ b/drivers/staging/media/rkisp1/isp_params.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - Params subdevice header
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_ISP_H
+#define _RKISP1_ISP_H
+
+#include "uapi/rkisp1-config.h"
+
+#include "common.h"
+
+/*
+ * struct rkisp1_isp_subdev - ISP input parameters device
+ *
+ * @cur_params: Current ISP parameters
+ * @first_params: the first params should take effect immediately
+ */
+struct rkisp1_isp_params_vdev {
+	struct rkisp1_vdev_node vnode;
+	struct rkisp1_device *dev;
+
+	spinlock_t config_lock;
+	struct list_head params;
+	struct rkisp1_isp_params_cfg cur_params;
+	struct v4l2_format vdev_fmt;
+	bool streamon;
+	bool first_params;
+
+	enum v4l2_quantization quantization;
+	enum rkisp1_fmt_raw_pat_type raw_type;
+};
+
+/* config params before ISP streaming */
+void rkisp1_params_configure_isp(struct rkisp1_isp_params_vdev *params_vdev,
+				 const struct rkisp1_fmt *in_fmt,
+				 enum v4l2_quantization quantization);
+void rkisp1_params_disable_isp(struct rkisp1_isp_params_vdev *params_vdev);
+
+int rkisp1_register_params_vdev(struct rkisp1_isp_params_vdev *params_vdev,
+				struct v4l2_device *v4l2_dev,
+				struct rkisp1_device *dev);
+
+void rkisp1_unregister_params_vdev(struct rkisp1_isp_params_vdev *params_vdev);
+
+void rkisp1_params_isr(struct rkisp1_device *dev, u32 isp_mis);
+
+#endif /* _RKISP1_ISP_H */
diff --git a/drivers/staging/media/rkisp1/isp_stats.c b/drivers/staging/media/rkisp1/isp_stats.c
new file mode 100644
index 000000000000..3c124cbbbc6f
--- /dev/null
+++ b/drivers/staging/media/rkisp1/isp_stats.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - Stats subdevice
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <media/v4l2-common.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-vmalloc.h>	/* for ISP statistics */
+
+#include "dev.h"
+#include "regs.h"
+
+#define RKISP1_ISP_STATS_REQ_BUFS_MIN 2
+#define RKISP1_ISP_STATS_REQ_BUFS_MAX 8
+
+static int rkisp1_stats_enum_fmt_meta_cap(struct file *file, void *priv,
+					  struct v4l2_fmtdesc *f)
+{
+	struct video_device *video = video_devdata(file);
+	struct rkisp1_isp_stats_vdev *stats_vdev = video_get_drvdata(video);
+
+	if (f->index > 0 || f->type != video->queue->type)
+		return -EINVAL;
+
+	f->pixelformat = stats_vdev->vdev_fmt.fmt.meta.dataformat;
+	return 0;
+}
+
+static int rkisp1_stats_g_fmt_meta_cap(struct file *file, void *priv,
+				       struct v4l2_format *f)
+{
+	struct video_device *video = video_devdata(file);
+	struct rkisp1_isp_stats_vdev *stats_vdev = video_get_drvdata(video);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->queue->type)
+		return -EINVAL;
+
+	memset(meta, 0, sizeof(*meta));
+	meta->dataformat = stats_vdev->vdev_fmt.fmt.meta.dataformat;
+	meta->buffersize = stats_vdev->vdev_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static int rkisp1_stats_querycap(struct file *file,
+				 void *priv, struct v4l2_capability *cap)
+{
+	struct video_device *vdev = video_devdata(file);
+
+	strscpy(cap->driver, DRIVER_NAME, sizeof(cap->driver));
+	strscpy(cap->card, vdev->name, sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: " DRIVER_NAME, sizeof(cap->bus_info));
+
+	return 0;
+}
+
+/* ISP video device IOCTLs */
+static const struct v4l2_ioctl_ops rkisp1_stats_ioctl = {
+	.vidioc_reqbufs = vb2_ioctl_reqbufs,
+	.vidioc_querybuf = vb2_ioctl_querybuf,
+	.vidioc_create_bufs = vb2_ioctl_create_bufs,
+	.vidioc_qbuf = vb2_ioctl_qbuf,
+	.vidioc_dqbuf = vb2_ioctl_dqbuf,
+	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
+	.vidioc_expbuf = vb2_ioctl_expbuf,
+	.vidioc_streamon = vb2_ioctl_streamon,
+	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_enum_fmt_meta_cap = rkisp1_stats_enum_fmt_meta_cap,
+	.vidioc_g_fmt_meta_cap = rkisp1_stats_g_fmt_meta_cap,
+	.vidioc_s_fmt_meta_cap = rkisp1_stats_g_fmt_meta_cap,
+	.vidioc_try_fmt_meta_cap = rkisp1_stats_g_fmt_meta_cap,
+	.vidioc_querycap = rkisp1_stats_querycap,
+	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
+};
+
+static const struct v4l2_file_operations rkisp1_stats_fops = {
+	.mmap = vb2_fop_mmap,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vb2_fop_poll,
+	.open = v4l2_fh_open,
+	.release = vb2_fop_release
+};
+
+static int rkisp1_stats_vb2_queue_setup(struct vb2_queue *vq,
+					unsigned int *num_buffers,
+					unsigned int *num_planes,
+					unsigned int sizes[],
+					struct device *alloc_devs[])
+{
+	struct rkisp1_isp_stats_vdev *stats_vdev = vq->drv_priv;
+
+	*num_planes = 1;
+
+	*num_buffers = clamp_t(u32, *num_buffers, RKISP1_ISP_STATS_REQ_BUFS_MIN,
+			       RKISP1_ISP_STATS_REQ_BUFS_MAX);
+
+	sizes[0] = sizeof(struct rkisp1_stat_buffer);
+
+	INIT_LIST_HEAD(&stats_vdev->stat);
+
+	return 0;
+}
+
+static void rkisp1_stats_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct rkisp1_buffer *stats_buf = to_rkisp1_buffer(vbuf);
+	struct vb2_queue *vq = vb->vb2_queue;
+	struct rkisp1_isp_stats_vdev *stats_dev = vq->drv_priv;
+
+	stats_buf->vaddr[0] = vb2_plane_vaddr(vb, 0);
+
+	mutex_lock(&stats_dev->wq_lock);
+	list_add_tail(&stats_buf->queue, &stats_dev->stat);
+	mutex_unlock(&stats_dev->wq_lock);
+}
+
+static int rkisp1_stats_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	if (vb2_plane_size(vb, 0) < sizeof(struct rkisp1_stat_buffer))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct rkisp1_stat_buffer));
+
+	return 0;
+}
+
+static void rkisp1_stats_vb2_stop_streaming(struct vb2_queue *vq)
+{
+	struct rkisp1_isp_stats_vdev *stats_vdev = vq->drv_priv;
+	struct rkisp1_buffer *buf;
+	unsigned long flags;
+	unsigned int i;
+
+	/* Make sure no new work queued in isr before draining wq */
+	spin_lock_irqsave(&stats_vdev->irq_lock, flags);
+	stats_vdev->streamon = false;
+	spin_unlock_irqrestore(&stats_vdev->irq_lock, flags);
+
+	drain_workqueue(stats_vdev->readout_wq);
+
+	mutex_lock(&stats_vdev->wq_lock);
+	for (i = 0; i < RKISP1_ISP_STATS_REQ_BUFS_MAX; i++) {
+		if (list_empty(&stats_vdev->stat))
+			break;
+		buf = list_first_entry(&stats_vdev->stat,
+				       struct rkisp1_buffer, queue);
+		list_del(&buf->queue);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	mutex_unlock(&stats_vdev->wq_lock);
+}
+
+static int
+rkisp1_stats_vb2_start_streaming(struct vb2_queue *queue,
+				 unsigned int count)
+{
+	struct rkisp1_isp_stats_vdev *stats_vdev = queue->drv_priv;
+
+	stats_vdev->streamon = true;
+
+	return 0;
+}
+
+static const struct vb2_ops rkisp1_stats_vb2_ops = {
+	.queue_setup = rkisp1_stats_vb2_queue_setup,
+	.buf_queue = rkisp1_stats_vb2_buf_queue,
+	.buf_prepare = rkisp1_stats_vb2_buf_prepare,
+	.wait_prepare = vb2_ops_wait_prepare,
+	.wait_finish = vb2_ops_wait_finish,
+	.stop_streaming = rkisp1_stats_vb2_stop_streaming,
+	.start_streaming = rkisp1_stats_vb2_start_streaming,
+};
+
+static int rkisp1_stats_init_vb2_queue(struct vb2_queue *q,
+				       struct rkisp1_isp_stats_vdev *stats_vdev)
+{
+	struct rkisp1_vdev_node *node;
+
+	node = queue_to_node(q);
+
+	q->type = V4L2_BUF_TYPE_META_CAPTURE;
+	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	q->drv_priv = stats_vdev;
+	q->ops = &rkisp1_stats_vb2_ops;
+	q->mem_ops = &vb2_vmalloc_memops;
+	q->buf_struct_size = sizeof(struct rkisp1_buffer);
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->lock = &node->vlock;
+
+	return vb2_queue_init(q);
+}
+
+static void rkisp1_stats_get_awb_meas(struct rkisp1_isp_stats_vdev *stats_vdev,
+				      struct rkisp1_stat_buffer *pbuf)
+{
+	/* Protect against concurrent access from ISR? */
+	u32 reg_val;
+
+	pbuf->meas_type |= CIFISP_STAT_AWB;
+	reg_val = readl(stats_vdev->dev->base_addr + CIF_ISP_AWB_WHITE_CNT);
+	pbuf->params.awb.awb_mean[0].cnt = CIF_ISP_AWB_GET_PIXEL_CNT(reg_val);
+	reg_val = readl(stats_vdev->dev->base_addr + CIF_ISP_AWB_MEAN);
+
+	pbuf->params.awb.awb_mean[0].mean_cr_or_r =
+		CIF_ISP_AWB_GET_MEAN_CR_R(reg_val);
+	pbuf->params.awb.awb_mean[0].mean_cb_or_b =
+		CIF_ISP_AWB_GET_MEAN_CB_B(reg_val);
+	pbuf->params.awb.awb_mean[0].mean_y_or_g =
+		CIF_ISP_AWB_GET_MEAN_Y_G(reg_val);
+}
+
+static void rkisp1_stats_get_aec_meas(struct rkisp1_isp_stats_vdev *stats_vdev,
+				      struct rkisp1_stat_buffer *pbuf)
+{
+	void __iomem *addr = stats_vdev->dev->base_addr + CIF_ISP_EXP_MEAN_00;
+	unsigned int i;
+
+	pbuf->meas_type |= CIFISP_STAT_AUTOEXP;
+	for (i = 0; i < CIFISP_AE_MEAN_MAX; i++)
+		pbuf->params.ae.exp_mean[i] = (u8)readl(addr + i * 4);
+}
+
+static void rkisp1_stats_get_afc_meas(struct rkisp1_isp_stats_vdev *stats_vdev,
+				      struct rkisp1_stat_buffer *pbuf)
+{
+	void __iomem *base_addr;
+	struct cifisp_af_stat *af;
+
+	pbuf->meas_type = CIFISP_STAT_AFM_FIN;
+
+	af = &pbuf->params.af;
+	base_addr = stats_vdev->dev->base_addr;
+	af->window[0].sum = readl(base_addr + CIF_ISP_AFM_SUM_A);
+	af->window[0].lum = readl(base_addr + CIF_ISP_AFM_LUM_A);
+	af->window[1].sum = readl(base_addr + CIF_ISP_AFM_SUM_B);
+	af->window[1].lum = readl(base_addr + CIF_ISP_AFM_LUM_B);
+	af->window[2].sum = readl(base_addr + CIF_ISP_AFM_SUM_C);
+	af->window[2].lum = readl(base_addr + CIF_ISP_AFM_LUM_C);
+}
+
+static void rkisp1_stats_get_hst_meas(struct rkisp1_isp_stats_vdev *stats_vdev,
+				      struct rkisp1_stat_buffer *pbuf)
+{
+	void __iomem *addr = stats_vdev->dev->base_addr + CIF_ISP_HIST_BIN_0;
+	unsigned int i;
+
+	pbuf->meas_type |= CIFISP_STAT_HIST;
+	for (i = 0; i < CIFISP_HIST_BIN_N_MAX; i++)
+		pbuf->params.hist.hist_bins[i] = readl(addr + (i * 4));
+}
+
+static void rkisp1_stats_get_bls_meas(struct rkisp1_isp_stats_vdev *stats_vdev,
+				      struct rkisp1_stat_buffer *pbuf)
+{
+	struct rkisp1_device *dev = stats_vdev->dev;
+	const struct rkisp1_fmt *in_fmt = dev->isp_sdev.in_fmt;
+	void __iomem *base = stats_vdev->dev->base_addr;
+	struct cifisp_bls_meas_val *bls_val;
+
+	bls_val = &pbuf->params.ae.bls_val;
+	if (in_fmt->bayer_pat == RAW_BGGR) {
+		bls_val->meas_b = readl(base + CIF_ISP_BLS_A_MEASURED);
+		bls_val->meas_gb = readl(base + CIF_ISP_BLS_B_MEASURED);
+		bls_val->meas_gr = readl(base + CIF_ISP_BLS_C_MEASURED);
+		bls_val->meas_r = readl(base + CIF_ISP_BLS_D_MEASURED);
+	} else if (in_fmt->bayer_pat == RAW_GBRG) {
+		bls_val->meas_gb = readl(base + CIF_ISP_BLS_A_MEASURED);
+		bls_val->meas_b = readl(base + CIF_ISP_BLS_B_MEASURED);
+		bls_val->meas_r = readl(base + CIF_ISP_BLS_C_MEASURED);
+		bls_val->meas_gr = readl(base + CIF_ISP_BLS_D_MEASURED);
+	} else if (in_fmt->bayer_pat == RAW_GRBG) {
+		bls_val->meas_gr = readl(base + CIF_ISP_BLS_A_MEASURED);
+		bls_val->meas_r = readl(base + CIF_ISP_BLS_B_MEASURED);
+		bls_val->meas_b = readl(base + CIF_ISP_BLS_C_MEASURED);
+		bls_val->meas_gb = readl(base + CIF_ISP_BLS_D_MEASURED);
+	} else if (in_fmt->bayer_pat == RAW_RGGB) {
+		bls_val->meas_r = readl(base + CIF_ISP_BLS_A_MEASURED);
+		bls_val->meas_gr = readl(base + CIF_ISP_BLS_B_MEASURED);
+		bls_val->meas_gb = readl(base + CIF_ISP_BLS_C_MEASURED);
+		bls_val->meas_b = readl(base + CIF_ISP_BLS_D_MEASURED);
+	}
+}
+
+static void
+rkisp1_stats_send_measurement(struct rkisp1_isp_stats_vdev *stats_vdev,
+			      struct rkisp1_isp_readout_work *meas_work)
+{
+	struct rkisp1_stat_buffer *cur_stat_buf;
+	struct rkisp1_buffer *cur_buf = NULL;
+	unsigned int cur_frame_id = -1;
+	u64 timestamp = ktime_get_ns();
+
+	cur_frame_id = atomic_read(&stats_vdev->dev->isp_sdev.frm_sync_seq) - 1;
+	if (cur_frame_id != meas_work->frame_id) {
+		dev_warn(stats_vdev->dev->dev,
+			 "Measurement late(%d, %d)\n",
+			 cur_frame_id, meas_work->frame_id);
+		cur_frame_id = meas_work->frame_id;
+	}
+
+	mutex_lock(&stats_vdev->wq_lock);
+	/* get one empty buffer */
+	if (!list_empty(&stats_vdev->stat)) {
+		cur_buf = list_first_entry(&stats_vdev->stat,
+					   struct rkisp1_buffer, queue);
+		list_del(&cur_buf->queue);
+	}
+	mutex_unlock(&stats_vdev->wq_lock);
+
+	if (!cur_buf)
+		return;
+
+	cur_stat_buf =
+		(struct rkisp1_stat_buffer *)(cur_buf->vaddr[0]);
+
+	if (meas_work->isp_ris & CIF_ISP_AWB_DONE) {
+		rkisp1_stats_get_awb_meas(stats_vdev, cur_stat_buf);
+		cur_stat_buf->meas_type |= CIFISP_STAT_AWB;
+	}
+
+	if (meas_work->isp_ris & CIF_ISP_AFM_FIN) {
+		rkisp1_stats_get_afc_meas(stats_vdev, cur_stat_buf);
+		cur_stat_buf->meas_type |= CIFISP_STAT_AFM_FIN;
+	}
+
+	if (meas_work->isp_ris & CIF_ISP_EXP_END) {
+		rkisp1_stats_get_aec_meas(stats_vdev, cur_stat_buf);
+		rkisp1_stats_get_bls_meas(stats_vdev, cur_stat_buf);
+		cur_stat_buf->meas_type |= CIFISP_STAT_AUTOEXP;
+	}
+
+	if (meas_work->isp_ris & CIF_ISP_HIST_MEASURE_RDY) {
+		rkisp1_stats_get_hst_meas(stats_vdev, cur_stat_buf);
+		cur_stat_buf->meas_type |= CIFISP_STAT_HIST;
+	}
+
+	vb2_set_plane_payload(&cur_buf->vb.vb2_buf, 0,
+			      sizeof(struct rkisp1_stat_buffer));
+	cur_buf->vb.sequence = cur_frame_id;
+	cur_buf->vb.vb2_buf.timestamp = timestamp;
+	vb2_buffer_done(&cur_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+}
+
+static void rkisp1_stats_readout_work(struct work_struct *work)
+{
+	struct rkisp1_isp_readout_work *readout_work = container_of(work,
+						struct rkisp1_isp_readout_work,
+						work);
+	struct rkisp1_isp_stats_vdev *stats_vdev = readout_work->stats_vdev;
+
+	if (readout_work->readout == RKISP1_ISP_READOUT_MEAS)
+		rkisp1_stats_send_measurement(stats_vdev, readout_work);
+
+	kfree(readout_work);
+}
+
+int rkisp1_stats_isr(struct rkisp1_isp_stats_vdev *stats_vdev, u32 isp_ris)
+{
+	unsigned int cur_frame_id =
+		atomic_read(&stats_vdev->dev->isp_sdev.frm_sync_seq) - 1;
+	struct rkisp1_isp_readout_work *work;
+	unsigned int isp_mis_tmp = 0;
+
+	spin_lock(&stats_vdev->irq_lock);
+
+	writel((CIF_ISP_AWB_DONE | CIF_ISP_AFM_FIN | CIF_ISP_EXP_END |
+		CIF_ISP_HIST_MEASURE_RDY),
+		stats_vdev->dev->base_addr + CIF_ISP_ICR);
+
+	isp_mis_tmp = readl(stats_vdev->dev->base_addr + CIF_ISP_MIS);
+	if (isp_mis_tmp &
+		(CIF_ISP_AWB_DONE | CIF_ISP_AFM_FIN |
+		 CIF_ISP_EXP_END | CIF_ISP_HIST_MEASURE_RDY))
+		dev_err(stats_vdev->dev->dev, "isp icr 3A info err: 0x%x\n",
+			isp_mis_tmp);
+
+	if (!stats_vdev->streamon)
+		goto unlock;
+	if (isp_ris & (CIF_ISP_AWB_DONE | CIF_ISP_AFM_FIN | CIF_ISP_EXP_END |
+		CIF_ISP_HIST_MEASURE_RDY)) {
+		work = (struct rkisp1_isp_readout_work *)
+			kzalloc(sizeof(struct rkisp1_isp_readout_work),
+				GFP_ATOMIC);
+		if (work) {
+			INIT_WORK(&work->work,
+				  rkisp1_stats_readout_work);
+			work->readout = RKISP1_ISP_READOUT_MEAS;
+			work->stats_vdev = stats_vdev;
+			work->frame_id = cur_frame_id;
+			work->isp_ris = isp_ris;
+			if (!queue_work(stats_vdev->readout_wq,
+					&work->work))
+				kfree(work);
+		} else {
+			dev_err(stats_vdev->dev->dev,
+				"Could not allocate work\n");
+		}
+	}
+
+unlock:
+	spin_unlock(&stats_vdev->irq_lock);
+
+	return 0;
+}
+
+static void rkisp1_init_stats_vdev(struct rkisp1_isp_stats_vdev *stats_vdev)
+{
+	stats_vdev->vdev_fmt.fmt.meta.dataformat =
+		V4L2_META_FMT_RK_ISP1_STAT_3A;
+	stats_vdev->vdev_fmt.fmt.meta.buffersize =
+		sizeof(struct rkisp1_stat_buffer);
+}
+
+int rkisp1_register_stats_vdev(struct rkisp1_isp_stats_vdev *stats_vdev,
+			       struct v4l2_device *v4l2_dev,
+			       struct rkisp1_device *dev)
+{
+	struct rkisp1_vdev_node *node = &stats_vdev->vnode;
+	struct video_device *vdev = &node->vdev;
+	unsigned int ret;
+
+	stats_vdev->dev = dev;
+	mutex_init(&stats_vdev->wq_lock);
+	mutex_init(&node->vlock);
+	INIT_LIST_HEAD(&stats_vdev->stat);
+	spin_lock_init(&stats_vdev->irq_lock);
+
+	strscpy(vdev->name, "rkisp1-statistics", sizeof(vdev->name));
+
+	video_set_drvdata(vdev, stats_vdev);
+	vdev->ioctl_ops = &rkisp1_stats_ioctl;
+	vdev->fops = &rkisp1_stats_fops;
+	vdev->release = video_device_release_empty;
+	vdev->lock = &node->vlock;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->queue = &node->buf_queue;
+	vdev->device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
+	vdev->vfl_dir =  VFL_DIR_RX;
+	rkisp1_stats_init_vb2_queue(vdev->queue, stats_vdev);
+	rkisp1_init_stats_vdev(stats_vdev);
+	video_set_drvdata(vdev, stats_vdev);
+
+	node->pad.flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&vdev->entity, 1, &node->pad);
+	if (ret < 0)
+		goto err_release_queue;
+
+	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	if (ret < 0) {
+		dev_err(&vdev->dev,
+			"could not register Video for Linux device\n");
+		goto err_cleanup_media_entity;
+	}
+
+	stats_vdev->readout_wq = alloc_workqueue("measurement_queue",
+					        WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+
+	if (!stats_vdev->readout_wq) {
+		ret = -ENOMEM;
+		goto err_unreg_vdev;
+	}
+
+	return 0;
+
+err_unreg_vdev:
+	video_unregister_device(vdev);
+err_cleanup_media_entity:
+	media_entity_cleanup(&vdev->entity);
+err_release_queue:
+	vb2_queue_release(vdev->queue);
+	mutex_destroy(&node->vlock);
+	mutex_destroy(&stats_vdev->wq_lock);
+	return ret;
+}
+
+void rkisp1_unregister_stats_vdev(struct rkisp1_isp_stats_vdev *stats_vdev)
+{
+	struct rkisp1_vdev_node *node = &stats_vdev->vnode;
+	struct video_device *vdev = &node->vdev;
+
+	destroy_workqueue(stats_vdev->readout_wq);
+	video_unregister_device(vdev);
+	media_entity_cleanup(&vdev->entity);
+	vb2_queue_release(vdev->queue);
+	mutex_destroy(&node->vlock);
+	mutex_destroy(&stats_vdev->wq_lock);
+}
diff --git a/drivers/staging/media/rkisp1/isp_stats.h b/drivers/staging/media/rkisp1/isp_stats.h
new file mode 100644
index 000000000000..34e4fe8b4305
--- /dev/null
+++ b/drivers/staging/media/rkisp1/isp_stats.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - Stats subdevice header
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_ISP_STATS_H
+#define _RKISP1_ISP_STATS_H
+
+#include "uapi/rkisp1-config.h"
+
+#include "common.h"
+
+struct rkisp1_isp_stats_vdev;
+
+enum rkisp1_isp_readout_cmd {
+	RKISP1_ISP_READOUT_MEAS,
+	RKISP1_ISP_READOUT_META,
+};
+
+struct rkisp1_isp_readout_work {
+	struct work_struct work;
+	struct rkisp1_isp_stats_vdev *stats_vdev;
+
+	unsigned int frame_id;
+	unsigned int isp_ris;
+	enum rkisp1_isp_readout_cmd readout;
+	struct vb2_buffer *vb;
+};
+
+/*
+ * struct rkisp1_isp_stats_vdev - ISP Statistics device
+ *
+ * @irq_lock: buffer queue lock
+ * @stat: stats buffer list
+ * @readout_wq: workqueue for statistics information read
+ */
+struct rkisp1_isp_stats_vdev {
+	struct rkisp1_vdev_node vnode;
+	struct rkisp1_device *dev;
+
+	spinlock_t irq_lock;
+	struct list_head stat;
+	struct v4l2_format vdev_fmt;
+	bool streamon;
+
+	struct workqueue_struct *readout_wq;
+	struct mutex wq_lock;
+};
+
+int rkisp1_stats_isr(struct rkisp1_isp_stats_vdev *stats_vdev, u32 isp_ris);
+
+int rkisp1_register_stats_vdev(struct rkisp1_isp_stats_vdev *stats_vdev,
+			       struct v4l2_device *v4l2_dev,
+			       struct rkisp1_device *dev);
+
+void rkisp1_unregister_stats_vdev(struct rkisp1_isp_stats_vdev *stats_vdev);
+
+#endif /* _RKISP1_ISP_STATS_H */
diff --git a/drivers/staging/media/rkisp1/regs.c b/drivers/staging/media/rkisp1/regs.c
new file mode 100644
index 000000000000..8017e826bb3d
--- /dev/null
+++ b/drivers/staging/media/rkisp1/regs.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - Registers
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <media/v4l2-common.h>
+
+#include "regs.h"
+
+void disable_dcrop(struct rkisp1_stream *stream, bool async)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *dc_ctrl_addr = base + stream->config->dual_crop.ctrl;
+	u32 dc_ctrl = readl(dc_ctrl_addr);
+	u32 mask = ~(stream->config->dual_crop.yuvmode_mask |
+			stream->config->dual_crop.rawmode_mask);
+	u32 val = dc_ctrl & mask;
+
+	if (async)
+		val |= CIF_DUAL_CROP_GEN_CFG_UPD;
+	else
+		val |= CIF_DUAL_CROP_CFG_UPD;
+	writel(val, dc_ctrl_addr);
+}
+
+void
+config_dcrop(struct rkisp1_stream *stream, struct v4l2_rect *rect, bool async)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *dc_ctrl_addr = base + stream->config->dual_crop.ctrl;
+	u32 dc_ctrl = readl(dc_ctrl_addr);
+
+	writel(rect->left, base + stream->config->dual_crop.h_offset);
+	writel(rect->top, base + stream->config->dual_crop.v_offset);
+	writel(rect->width, base + stream->config->dual_crop.h_size);
+	writel(rect->height, base + stream->config->dual_crop.v_size);
+	dc_ctrl |= stream->config->dual_crop.yuvmode_mask;
+	if (async)
+		dc_ctrl |= CIF_DUAL_CROP_GEN_CFG_UPD;
+	else
+		dc_ctrl |= CIF_DUAL_CROP_CFG_UPD;
+	writel(dc_ctrl, dc_ctrl_addr);
+}
+
+void dump_rsz_regs(struct device *dev, struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	dev_dbg(dev,
+		"RSZ_CTRL 0x%08x/0x%08x\n"
+		"RSZ_SCALE_HY %d/%d\n"
+		"RSZ_SCALE_HCB %d/%d\n"
+		"RSZ_SCALE_HCR %d/%d\n"
+		"RSZ_SCALE_VY %d/%d\n"
+		"RSZ_SCALE_VC %d/%d\n"
+		"RSZ_PHASE_HY %d/%d\n"
+		"RSZ_PHASE_HC %d/%d\n"
+		"RSZ_PHASE_VY %d/%d\n"
+		"RSZ_PHASE_VC %d/%d\n",
+		readl(base + stream->config->rsz.ctrl),
+		readl(base + stream->config->rsz.ctrl_shd),
+		readl(base + stream->config->rsz.scale_hy),
+		readl(base + stream->config->rsz.scale_hy_shd),
+		readl(base + stream->config->rsz.scale_hcb),
+		readl(base + stream->config->rsz.scale_hcb_shd),
+		readl(base + stream->config->rsz.scale_hcr),
+		readl(base + stream->config->rsz.scale_hcr_shd),
+		readl(base + stream->config->rsz.scale_vy),
+		readl(base + stream->config->rsz.scale_vy_shd),
+		readl(base + stream->config->rsz.scale_vc),
+		readl(base + stream->config->rsz.scale_vc_shd),
+		readl(base + stream->config->rsz.phase_hy),
+		readl(base + stream->config->rsz.phase_hy_shd),
+		readl(base + stream->config->rsz.phase_hc),
+		readl(base + stream->config->rsz.phase_hc_shd),
+		readl(base + stream->config->rsz.phase_vy),
+		readl(base + stream->config->rsz.phase_vy_shd),
+		readl(base + stream->config->rsz.phase_vc),
+		readl(base + stream->config->rsz.phase_vc_shd));
+}
+
+static void update_rsz_shadow(struct rkisp1_stream *stream, bool async)
+{
+	void __iomem *addr =
+		stream->ispdev->base_addr + stream->config->rsz.ctrl;
+	u32 ctrl_cfg = readl(addr);
+
+	if (async)
+		writel(CIF_RSZ_CTRL_CFG_UPD_AUTO | ctrl_cfg, addr);
+	else
+		writel(CIF_RSZ_CTRL_CFG_UPD | ctrl_cfg, addr);
+}
+
+static void set_scale(struct rkisp1_stream *stream, struct v4l2_rect *in_y,
+		      struct v4l2_rect *in_c, struct v4l2_rect *out_y,
+		      struct v4l2_rect *out_c)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *scale_hy_addr = base + stream->config->rsz.scale_hy;
+	void __iomem *scale_hcr_addr = base + stream->config->rsz.scale_hcr;
+	void __iomem *scale_hcb_addr = base + stream->config->rsz.scale_hcb;
+	void __iomem *scale_vy_addr = base + stream->config->rsz.scale_vy;
+	void __iomem *scale_vc_addr = base + stream->config->rsz.scale_vc;
+	void __iomem *rsz_ctrl_addr = base + stream->config->rsz.ctrl;
+	u32 scale_hy, scale_hc, scale_vy, scale_vc, rsz_ctrl = 0;
+
+	if (in_y->width < out_y->width) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_HY_ENABLE |
+				CIF_RSZ_CTRL_SCALE_HY_UP;
+		scale_hy = ((in_y->width - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(out_y->width - 1);
+		writel(scale_hy, scale_hy_addr);
+	} else if (in_y->width > out_y->width) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_HY_ENABLE;
+		scale_hy = ((out_y->width - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(in_y->width - 1) + 1;
+		writel(scale_hy, scale_hy_addr);
+	}
+	if (in_c->width < out_c->width) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_HC_ENABLE |
+				CIF_RSZ_CTRL_SCALE_HC_UP;
+		scale_hc = ((in_c->width - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(out_c->width - 1);
+		writel(scale_hc, scale_hcb_addr);
+		writel(scale_hc, scale_hcr_addr);
+	} else if (in_c->width > out_c->width) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_HC_ENABLE;
+		scale_hc = ((out_c->width - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(in_c->width - 1) + 1;
+		writel(scale_hc, scale_hcb_addr);
+		writel(scale_hc, scale_hcr_addr);
+	}
+
+	if (in_y->height < out_y->height) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_VY_ENABLE |
+				CIF_RSZ_CTRL_SCALE_VY_UP;
+		scale_vy = ((in_y->height - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(out_y->height - 1);
+		writel(scale_vy, scale_vy_addr);
+	} else if (in_y->height > out_y->height) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_VY_ENABLE;
+		scale_vy = ((out_y->height - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(in_y->height - 1) + 1;
+		writel(scale_vy, scale_vy_addr);
+	}
+
+	if (in_c->height < out_c->height) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_VC_ENABLE |
+				CIF_RSZ_CTRL_SCALE_VC_UP;
+		scale_vc = ((in_c->height - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(out_c->height - 1);
+		writel(scale_vc, scale_vc_addr);
+	} else if (in_c->height > out_c->height) {
+		rsz_ctrl |= CIF_RSZ_CTRL_SCALE_VC_ENABLE;
+		scale_vc = ((out_c->height - 1) * CIF_RSZ_SCALER_FACTOR) /
+				(in_c->height - 1) + 1;
+		writel(scale_vc, scale_vc_addr);
+	}
+
+	writel(rsz_ctrl, rsz_ctrl_addr);
+}
+
+void config_rsz(struct rkisp1_stream *stream, struct v4l2_rect *in_y,
+		struct v4l2_rect *in_c, struct v4l2_rect *out_y,
+		struct v4l2_rect *out_c, bool async)
+{
+	void __iomem *base_addr = stream->ispdev->base_addr;
+	unsigned int i;
+
+	/* No phase offset */
+	writel(0, base_addr + stream->config->rsz.phase_hy);
+	writel(0, base_addr + stream->config->rsz.phase_hc);
+	writel(0, base_addr + stream->config->rsz.phase_vy);
+	writel(0, base_addr + stream->config->rsz.phase_vc);
+
+	/* Linear interpolation */
+	for (i = 0; i < 64; i++) {
+		writel(i, base_addr + stream->config->rsz.scale_lut_addr);
+		writel(i, base_addr + stream->config->rsz.scale_lut);
+	}
+
+	set_scale(stream, in_y, in_c, out_y, out_c);
+
+	update_rsz_shadow(stream, async);
+}
+
+void disable_rsz(struct rkisp1_stream *stream, bool async)
+{
+	writel(0, stream->ispdev->base_addr + stream->config->rsz.ctrl);
+
+	if (!async)
+		update_rsz_shadow(stream, async);
+}
+
+void config_mi_ctrl(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *addr = base + CIF_MI_CTRL;
+	u32 reg;
+
+	reg = readl(addr) & ~GENMASK(17, 16);
+	writel(reg | CIF_MI_CTRL_BURST_LEN_LUM_64, addr);
+	reg = readl(addr) & ~GENMASK(19, 18);
+	writel(reg | CIF_MI_CTRL_BURST_LEN_CHROM_64, addr);
+	reg = readl(addr);
+	writel(reg | CIF_MI_CTRL_INIT_BASE_EN, addr);
+	reg = readl(addr);
+	writel(reg | CIF_MI_CTRL_INIT_OFFSET_EN, addr);
+}
+
+bool mp_is_stream_stopped(void __iomem *base)
+{
+	int en;
+
+	en = CIF_MI_CTRL_SHD_MP_IN_ENABLED | CIF_MI_CTRL_SHD_RAW_OUT_ENABLED;
+	return !(readl(base + CIF_MI_CTRL_SHD) & en);
+}
+
+bool sp_is_stream_stopped(void __iomem *base)
+{
+	return !(readl(base + CIF_MI_CTRL_SHD) & CIF_MI_CTRL_SHD_SP_IN_ENABLED);
+}
diff --git a/drivers/staging/media/rkisp1/regs.h b/drivers/staging/media/rkisp1/regs.h
new file mode 100644
index 000000000000..619dd9edb4e4
--- /dev/null
+++ b/drivers/staging/media/rkisp1/regs.h
@@ -0,0 +1,1525 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - Registers header
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_REGS_H
+#define _RKISP1_REGS_H
+#include "dev.h"
+
+/* ISP_CTRL */
+#define CIF_ISP_CTRL_ISP_ENABLE			BIT(0)
+#define CIF_ISP_CTRL_ISP_MODE_RAW_PICT		(0 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_ITU656		(1 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_ITU601		(2 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_BAYER_ITU601	(3 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_DATA_MODE		(4 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_BAYER_ITU656	(5 << 1)
+#define CIF_ISP_CTRL_ISP_MODE_RAW_PICT_ITU656	(6 << 1)
+#define CIF_ISP_CTRL_ISP_INFORM_ENABLE		BIT(4)
+#define CIF_ISP_CTRL_ISP_GAMMA_IN_ENA		BIT(6)
+#define CIF_ISP_CTRL_ISP_AWB_ENA		BIT(7)
+#define CIF_ISP_CTRL_ISP_CFG_UPD_PERMANENT	BIT(8)
+#define CIF_ISP_CTRL_ISP_CFG_UPD		BIT(9)
+#define CIF_ISP_CTRL_ISP_GEN_CFG_UPD		BIT(10)
+#define CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA		BIT(11)
+#define CIF_ISP_CTRL_ISP_FLASH_MODE_ENA		BIT(12)
+#define CIF_ISP_CTRL_ISP_CSM_Y_FULL_ENA		BIT(13)
+#define CIF_ISP_CTRL_ISP_CSM_C_FULL_ENA		BIT(14)
+
+/* ISP_ACQ_PROP */
+#define CIF_ISP_ACQ_PROP_POS_EDGE		BIT(0)
+#define CIF_ISP_ACQ_PROP_HSYNC_LOW		BIT(1)
+#define CIF_ISP_ACQ_PROP_VSYNC_LOW		BIT(2)
+#define CIF_ISP_ACQ_PROP_BAYER_PAT_RGGB		(0 << 3)
+#define CIF_ISP_ACQ_PROP_BAYER_PAT_GRBG		(1 << 3)
+#define CIF_ISP_ACQ_PROP_BAYER_PAT_GBRG		(2 << 3)
+#define CIF_ISP_ACQ_PROP_BAYER_PAT_BGGR		(3 << 3)
+#define CIF_ISP_ACQ_PROP_BAYER_PAT(pat)		((pat) << 3)
+#define CIF_ISP_ACQ_PROP_YCBYCR			(0 << 7)
+#define CIF_ISP_ACQ_PROP_YCRYCB			(1 << 7)
+#define CIF_ISP_ACQ_PROP_CBYCRY			(2 << 7)
+#define CIF_ISP_ACQ_PROP_CRYCBY			(3 << 7)
+#define CIF_ISP_ACQ_PROP_FIELD_SEL_ALL		(0 << 9)
+#define CIF_ISP_ACQ_PROP_FIELD_SEL_EVEN		(1 << 9)
+#define CIF_ISP_ACQ_PROP_FIELD_SEL_ODD		(2 << 9)
+#define CIF_ISP_ACQ_PROP_IN_SEL_12B		(0 << 12)
+#define CIF_ISP_ACQ_PROP_IN_SEL_10B_ZERO	(1 << 12)
+#define CIF_ISP_ACQ_PROP_IN_SEL_10B_MSB		(2 << 12)
+#define CIF_ISP_ACQ_PROP_IN_SEL_8B_ZERO		(3 << 12)
+#define CIF_ISP_ACQ_PROP_IN_SEL_8B_MSB		(4 << 12)
+
+/* VI_DPCL */
+#define CIF_VI_DPCL_DMA_JPEG			(0 << 0)
+#define CIF_VI_DPCL_MP_MUX_MRSZ_MI		(1 << 0)
+#define CIF_VI_DPCL_MP_MUX_MRSZ_JPEG		(2 << 0)
+#define CIF_VI_DPCL_CHAN_MODE_MP		(1 << 2)
+#define CIF_VI_DPCL_CHAN_MODE_SP		(2 << 2)
+#define CIF_VI_DPCL_CHAN_MODE_MPSP		(3 << 2)
+#define CIF_VI_DPCL_DMA_SW_SPMUX		(0 << 4)
+#define CIF_VI_DPCL_DMA_SW_SI			(1 << 4)
+#define CIF_VI_DPCL_DMA_SW_IE			(2 << 4)
+#define CIF_VI_DPCL_DMA_SW_JPEG			(3 << 4)
+#define CIF_VI_DPCL_DMA_SW_ISP			(4 << 4)
+#define CIF_VI_DPCL_IF_SEL_PARALLEL		(0 << 8)
+#define CIF_VI_DPCL_IF_SEL_SMIA			(1 << 8)
+#define CIF_VI_DPCL_IF_SEL_MIPI			(2 << 8)
+#define CIF_VI_DPCL_DMA_IE_MUX_DMA		BIT(10)
+#define CIF_VI_DPCL_DMA_SP_MUX_DMA		BIT(11)
+
+/* ISP_IMSC - ISP_MIS - ISP_RIS - ISP_ICR - ISP_ISR */
+#define CIF_ISP_OFF				BIT(0)
+#define CIF_ISP_FRAME				BIT(1)
+#define CIF_ISP_DATA_LOSS			BIT(2)
+#define CIF_ISP_PIC_SIZE_ERROR			BIT(3)
+#define CIF_ISP_AWB_DONE			BIT(4)
+#define CIF_ISP_FRAME_IN			BIT(5)
+#define CIF_ISP_V_START				BIT(6)
+#define CIF_ISP_H_START				BIT(7)
+#define CIF_ISP_FLASH_ON			BIT(8)
+#define CIF_ISP_FLASH_OFF			BIT(9)
+#define CIF_ISP_SHUTTER_ON			BIT(10)
+#define CIF_ISP_SHUTTER_OFF			BIT(11)
+#define CIF_ISP_AFM_SUM_OF			BIT(12)
+#define CIF_ISP_AFM_LUM_OF			BIT(13)
+#define CIF_ISP_AFM_FIN				BIT(14)
+#define CIF_ISP_HIST_MEASURE_RDY		BIT(15)
+#define CIF_ISP_FLASH_CAP			BIT(17)
+#define CIF_ISP_EXP_END				BIT(18)
+#define CIF_ISP_VSM_END				BIT(19)
+
+/* ISP_ERR */
+#define CIF_ISP_ERR_INFORM_SIZE			BIT(0)
+#define CIF_ISP_ERR_IS_SIZE			BIT(1)
+#define CIF_ISP_ERR_OUTFORM_SIZE		BIT(2)
+
+/* MI_CTRL */
+#define CIF_MI_CTRL_MP_ENABLE			(1 << 0)
+#define CIF_MI_CTRL_SP_ENABLE			(2 << 0)
+#define CIF_MI_CTRL_JPEG_ENABLE			(4 << 0)
+#define CIF_MI_CTRL_RAW_ENABLE			(8 << 0)
+#define CIF_MI_CTRL_HFLIP			BIT(4)
+#define CIF_MI_CTRL_VFLIP			BIT(5)
+#define CIF_MI_CTRL_ROT				BIT(6)
+#define CIF_MI_BYTE_SWAP			BIT(7)
+#define CIF_MI_SP_Y_FULL_YUV2RGB		BIT(8)
+#define CIF_MI_SP_CBCR_FULL_YUV2RGB		BIT(9)
+#define CIF_MI_SP_422NONCOSITEED		BIT(10)
+#define CIF_MI_MP_PINGPONG_ENABEL		BIT(11)
+#define CIF_MI_SP_PINGPONG_ENABEL		BIT(12)
+#define CIF_MI_MP_AUTOUPDATE_ENABLE		BIT(13)
+#define CIF_MI_SP_AUTOUPDATE_ENABLE		BIT(14)
+#define CIF_MI_LAST_PIXEL_SIG_ENABLE		BIT(15)
+#define CIF_MI_CTRL_BURST_LEN_LUM_16		(0 << 16)
+#define CIF_MI_CTRL_BURST_LEN_LUM_32		(1 << 16)
+#define CIF_MI_CTRL_BURST_LEN_LUM_64		(2 << 16)
+#define CIF_MI_CTRL_BURST_LEN_CHROM_16		(0 << 18)
+#define CIF_MI_CTRL_BURST_LEN_CHROM_32		(1 << 18)
+#define CIF_MI_CTRL_BURST_LEN_CHROM_64		(2 << 18)
+#define CIF_MI_CTRL_INIT_BASE_EN		BIT(20)
+#define CIF_MI_CTRL_INIT_OFFSET_EN		BIT(21)
+#define MI_CTRL_MP_WRITE_YUV_PLA_OR_RAW8	(0 << 22)
+#define MI_CTRL_MP_WRITE_YUV_SPLA		(1 << 22)
+#define MI_CTRL_MP_WRITE_YUVINT			(2 << 22)
+#define MI_CTRL_MP_WRITE_RAW12			(2 << 22)
+#define MI_CTRL_SP_WRITE_PLA			(0 << 24)
+#define MI_CTRL_SP_WRITE_SPLA			(1 << 24)
+#define MI_CTRL_SP_WRITE_INT			(2 << 24)
+#define MI_CTRL_SP_INPUT_YUV400			(0 << 26)
+#define MI_CTRL_SP_INPUT_YUV420			(1 << 26)
+#define MI_CTRL_SP_INPUT_YUV422			(2 << 26)
+#define MI_CTRL_SP_INPUT_YUV444			(3 << 26)
+#define MI_CTRL_SP_OUTPUT_YUV400		(0 << 28)
+#define MI_CTRL_SP_OUTPUT_YUV420		(1 << 28)
+#define MI_CTRL_SP_OUTPUT_YUV422		(2 << 28)
+#define MI_CTRL_SP_OUTPUT_YUV444		(3 << 28)
+#define MI_CTRL_SP_OUTPUT_RGB565		(4 << 28)
+#define MI_CTRL_SP_OUTPUT_RGB666		(5 << 28)
+#define MI_CTRL_SP_OUTPUT_RGB888		(6 << 28)
+
+#define MI_CTRL_MP_FMT_MASK			GENMASK(23, 22)
+#define MI_CTRL_SP_FMT_MASK			GENMASK(30, 24)
+
+/* MI_INIT */
+#define CIF_MI_INIT_SKIP			BIT(2)
+#define CIF_MI_INIT_SOFT_UPD			BIT(4)
+
+/* MI_CTRL_SHD */
+#define CIF_MI_CTRL_SHD_MP_IN_ENABLED		BIT(0)
+#define CIF_MI_CTRL_SHD_SP_IN_ENABLED		BIT(1)
+#define CIF_MI_CTRL_SHD_JPEG_IN_ENABLED		BIT(2)
+#define CIF_MI_CTRL_SHD_RAW_IN_ENABLED		BIT(3)
+#define CIF_MI_CTRL_SHD_MP_OUT_ENABLED		BIT(16)
+#define CIF_MI_CTRL_SHD_SP_OUT_ENABLED		BIT(17)
+#define CIF_MI_CTRL_SHD_JPEG_OUT_ENABLED	BIT(18)
+#define CIF_MI_CTRL_SHD_RAW_OUT_ENABLED		BIT(19)
+
+/* RSZ_CTRL */
+#define CIF_RSZ_CTRL_SCALE_HY_ENABLE		BIT(0)
+#define CIF_RSZ_CTRL_SCALE_HC_ENABLE		BIT(1)
+#define CIF_RSZ_CTRL_SCALE_VY_ENABLE		BIT(2)
+#define CIF_RSZ_CTRL_SCALE_VC_ENABLE		BIT(3)
+#define CIF_RSZ_CTRL_SCALE_HY_UP		BIT(4)
+#define CIF_RSZ_CTRL_SCALE_HC_UP		BIT(5)
+#define CIF_RSZ_CTRL_SCALE_VY_UP		BIT(6)
+#define CIF_RSZ_CTRL_SCALE_VC_UP		BIT(7)
+#define CIF_RSZ_CTRL_CFG_UPD			BIT(8)
+#define CIF_RSZ_CTRL_CFG_UPD_AUTO		BIT(9)
+#define CIF_RSZ_SCALER_FACTOR			BIT(16)
+
+/* MI_IMSC - MI_MIS - MI_RIS - MI_ICR - MI_ISR */
+#define CIF_MI_FRAME(stream)			BIT((stream)->id)
+#define CIF_MI_MBLK_LINE			BIT(2)
+#define CIF_MI_FILL_MP_Y			BIT(3)
+#define CIF_MI_WRAP_MP_Y			BIT(4)
+#define CIF_MI_WRAP_MP_CB			BIT(5)
+#define CIF_MI_WRAP_MP_CR			BIT(6)
+#define CIF_MI_WRAP_SP_Y			BIT(7)
+#define CIF_MI_WRAP_SP_CB			BIT(8)
+#define CIF_MI_WRAP_SP_CR			BIT(9)
+#define CIF_MI_DMA_READY			BIT(11)
+
+/* MI_STATUS */
+#define CIF_MI_STATUS_MP_Y_FIFO_FULL		BIT(0)
+#define CIF_MI_STATUS_SP_Y_FIFO_FULL		BIT(4)
+
+/* MI_DMA_CTRL */
+#define CIF_MI_DMA_CTRL_BURST_LEN_LUM_16	(0 << 0)
+#define CIF_MI_DMA_CTRL_BURST_LEN_LUM_32	(1 << 0)
+#define CIF_MI_DMA_CTRL_BURST_LEN_LUM_64	(2 << 0)
+#define CIF_MI_DMA_CTRL_BURST_LEN_CHROM_16	(0 << 2)
+#define CIF_MI_DMA_CTRL_BURST_LEN_CHROM_32	(1 << 2)
+#define CIF_MI_DMA_CTRL_BURST_LEN_CHROM_64	(2 << 2)
+#define CIF_MI_DMA_CTRL_READ_FMT_PLANAR		(0 << 4)
+#define CIF_MI_DMA_CTRL_READ_FMT_SPLANAR	(1 << 4)
+#define CIF_MI_DMA_CTRL_FMT_YUV400		(0 << 6)
+#define CIF_MI_DMA_CTRL_FMT_YUV420		(1 << 6)
+#define CIF_MI_DMA_CTRL_READ_FMT_PACKED		(2 << 4)
+#define CIF_MI_DMA_CTRL_FMT_YUV422		(2 << 6)
+#define CIF_MI_DMA_CTRL_FMT_YUV444		(3 << 6)
+#define CIF_MI_DMA_CTRL_BYTE_SWAP		BIT(8)
+#define CIF_MI_DMA_CTRL_CONTINUOUS_ENA		BIT(9)
+#define CIF_MI_DMA_CTRL_RGB_BAYER_NO		(0 << 12)
+#define CIF_MI_DMA_CTRL_RGB_BAYER_8BIT		(1 << 12)
+#define CIF_MI_DMA_CTRL_RGB_BAYER_16BIT		(2 << 12)
+/* MI_DMA_START */
+#define CIF_MI_DMA_START_ENABLE			BIT(0)
+/* MI_XTD_FORMAT_CTRL  */
+#define CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP	BIT(0)
+#define CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP	BIT(1)
+#define CIF_MI_XTD_FMT_CTRL_DMA_CB_CR_SWAP	BIT(2)
+
+/* CCL */
+#define CIF_CCL_CIF_CLK_DIS			BIT(2)
+/* ICCL */
+#define CIF_ICCL_ISP_CLK			BIT(0)
+#define CIF_ICCL_CP_CLK				BIT(1)
+#define CIF_ICCL_RES_2				BIT(2)
+#define CIF_ICCL_MRSZ_CLK			BIT(3)
+#define CIF_ICCL_SRSZ_CLK			BIT(4)
+#define CIF_ICCL_JPEG_CLK			BIT(5)
+#define CIF_ICCL_MI_CLK				BIT(6)
+#define CIF_ICCL_RES_7				BIT(7)
+#define CIF_ICCL_IE_CLK				BIT(8)
+#define CIF_ICCL_SIMP_CLK			BIT(9)
+#define CIF_ICCL_SMIA_CLK			BIT(10)
+#define CIF_ICCL_MIPI_CLK			BIT(11)
+#define CIF_ICCL_DCROP_CLK			BIT(12)
+/* IRCL */
+#define CIF_IRCL_ISP_SW_RST			BIT(0)
+#define CIF_IRCL_CP_SW_RST			BIT(1)
+#define CIF_IRCL_YCS_SW_RST			BIT(2)
+#define CIF_IRCL_MRSZ_SW_RST			BIT(3)
+#define CIF_IRCL_SRSZ_SW_RST			BIT(4)
+#define CIF_IRCL_JPEG_SW_RST			BIT(5)
+#define CIF_IRCL_MI_SW_RST			BIT(6)
+#define CIF_IRCL_CIF_SW_RST			BIT(7)
+#define CIF_IRCL_IE_SW_RST			BIT(8)
+#define CIF_IRCL_SI_SW_RST			BIT(9)
+#define CIF_IRCL_MIPI_SW_RST			BIT(11)
+
+/* C_PROC_CTR */
+#define CIF_C_PROC_CTR_ENABLE			BIT(0)
+#define CIF_C_PROC_YOUT_FULL			BIT(1)
+#define CIF_C_PROC_YIN_FULL			BIT(2)
+#define CIF_C_PROC_COUT_FULL			BIT(3)
+#define CIF_C_PROC_CTRL_RESERVED		0xFFFFFFFE
+#define CIF_C_PROC_CONTRAST_RESERVED		0xFFFFFF00
+#define CIF_C_PROC_BRIGHTNESS_RESERVED		0xFFFFFF00
+#define CIF_C_PROC_HUE_RESERVED			0xFFFFFF00
+#define CIF_C_PROC_SATURATION_RESERVED		0xFFFFFF00
+#define CIF_C_PROC_MACC_RESERVED		0xE000E000
+#define CIF_C_PROC_TONE_RESERVED		0xF000
+/* DUAL_CROP_CTRL */
+#define CIF_DUAL_CROP_MP_MODE_BYPASS		(0 << 0)
+#define CIF_DUAL_CROP_MP_MODE_YUV		(1 << 0)
+#define CIF_DUAL_CROP_MP_MODE_RAW		(2 << 0)
+#define CIF_DUAL_CROP_SP_MODE_BYPASS		(0 << 2)
+#define CIF_DUAL_CROP_SP_MODE_YUV		(1 << 2)
+#define CIF_DUAL_CROP_SP_MODE_RAW		(2 << 2)
+#define CIF_DUAL_CROP_CFG_UPD_PERMANENT		BIT(4)
+#define CIF_DUAL_CROP_CFG_UPD			BIT(5)
+#define CIF_DUAL_CROP_GEN_CFG_UPD		BIT(6)
+
+/* IMG_EFF_CTRL */
+#define CIF_IMG_EFF_CTRL_ENABLE			BIT(0)
+#define CIF_IMG_EFF_CTRL_MODE_BLACKWHITE	(0 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_NEGATIVE		(1 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_SEPIA		(2 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_COLOR_SEL		(3 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_EMBOSS		(4 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_SKETCH		(5 << 1)
+#define CIF_IMG_EFF_CTRL_MODE_SHARPEN		(6 << 1)
+#define CIF_IMG_EFF_CTRL_CFG_UPD		BIT(4)
+#define CIF_IMG_EFF_CTRL_YCBCR_FULL		BIT(5)
+
+#define CIF_IMG_EFF_CTRL_MODE_BLACKWHITE_SHIFT	0
+#define CIF_IMG_EFF_CTRL_MODE_NEGATIVE_SHIFT	1
+#define CIF_IMG_EFF_CTRL_MODE_SEPIA_SHIFT	2
+#define CIF_IMG_EFF_CTRL_MODE_COLOR_SEL_SHIFT	3
+#define CIF_IMG_EFF_CTRL_MODE_EMBOSS_SHIFT	4
+#define CIF_IMG_EFF_CTRL_MODE_SKETCH_SHIFT	5
+#define CIF_IMG_EFF_CTRL_MODE_SHARPEN_SHIFT	6
+#define CIF_IMG_EFF_CTRL_MODE_MASK		0xE
+
+/* IMG_EFF_COLOR_SEL */
+#define CIF_IMG_EFF_COLOR_RGB			0
+#define CIF_IMG_EFF_COLOR_B			(1 << 0)
+#define CIF_IMG_EFF_COLOR_G			(2 << 0)
+#define CIF_IMG_EFF_COLOR_GB			(3 << 0)
+#define CIF_IMG_EFF_COLOR_R			(4 << 0)
+#define CIF_IMG_EFF_COLOR_RB			(5 << 0)
+#define CIF_IMG_EFF_COLOR_RG			(6 << 0)
+#define CIF_IMG_EFF_COLOR_RGB2			(7 << 0)
+
+/* MIPI_CTRL */
+#define CIF_MIPI_CTRL_OUTPUT_ENA		BIT(0)
+#define CIF_MIPI_CTRL_SHUTDOWNLANES(a)		(((a) & 0xF) << 8)
+#define CIF_MIPI_CTRL_NUM_LANES(a)		(((a) & 0x3) << 12)
+#define CIF_MIPI_CTRL_ERR_SOT_HS_SKIP		BIT(16)
+#define CIF_MIPI_CTRL_ERR_SOT_SYNC_HS_SKIP	BIT(17)
+#define CIF_MIPI_CTRL_CLOCKLANE_ENA		BIT(18)
+
+/* MIPI_DATA_SEL */
+#define CIF_MIPI_DATA_SEL_VC(a)			(((a) & 0x3) << 6)
+#define CIF_MIPI_DATA_SEL_DT(a)			(((a) & 0x3F) << 0)
+/* MIPI DATA_TYPE */
+#define CIF_CSI2_DT_YUV420_8b			0x18
+#define CIF_CSI2_DT_YUV420_10b			0x19
+#define CIF_CSI2_DT_YUV422_8b			0x1E
+#define CIF_CSI2_DT_YUV422_10b			0x1F
+#define CIF_CSI2_DT_RGB565			0x22
+#define CIF_CSI2_DT_RGB666			0x23
+#define CIF_CSI2_DT_RGB888			0x24
+#define CIF_CSI2_DT_RAW8			0x2A
+#define CIF_CSI2_DT_RAW10			0x2B
+#define CIF_CSI2_DT_RAW12			0x2C
+
+/* MIPI_IMSC, MIPI_RIS, MIPI_MIS, MIPI_ICR, MIPI_ISR */
+#define CIF_MIPI_SYNC_FIFO_OVFLW(a)		(((a) & 0xF) << 0)
+#define CIF_MIPI_ERR_SOT(a)			(((a) & 0xF) << 4)
+#define CIF_MIPI_ERR_SOT_SYNC(a)		(((a) & 0xF) << 8)
+#define CIF_MIPI_ERR_EOT_SYNC(a)		(((a) & 0xF) << 12)
+#define CIF_MIPI_ERR_CTRL(a)			(((a) & 0xF) << 16)
+#define CIF_MIPI_ERR_PROTOCOL			BIT(20)
+#define CIF_MIPI_ERR_ECC1			BIT(21)
+#define CIF_MIPI_ERR_ECC2			BIT(22)
+#define CIF_MIPI_ERR_CS				BIT(23)
+#define CIF_MIPI_FRAME_END			BIT(24)
+#define CIF_MIPI_ADD_DATA_OVFLW			BIT(25)
+#define CIF_MIPI_ADD_DATA_WATER_MARK		BIT(26)
+
+#define CIF_MIPI_ERR_CSI  (CIF_MIPI_ERR_PROTOCOL | \
+	CIF_MIPI_ERR_ECC1 | \
+	CIF_MIPI_ERR_ECC2 | \
+	CIF_MIPI_ERR_CS)
+
+#define CIF_MIPI_ERR_DPHY  (CIF_MIPI_ERR_SOT(3) | \
+	CIF_MIPI_ERR_SOT_SYNC(3) | \
+	CIF_MIPI_ERR_EOT_SYNC(3) | \
+	CIF_MIPI_ERR_CTRL(3))
+
+/* SUPER_IMPOSE */
+#define CIF_SUPER_IMP_CTRL_NORMAL_MODE		BIT(0)
+#define CIF_SUPER_IMP_CTRL_REF_IMG_MEM		BIT(1)
+#define CIF_SUPER_IMP_CTRL_TRANSP_DIS		BIT(2)
+
+/* ISP HISTOGRAM CALCULATION : ISP_HIST_PROP */
+#define CIF_ISP_HIST_PROP_MODE_DIS		(0 << 0)
+#define CIF_ISP_HIST_PROP_MODE_RGB		(1 << 0)
+#define CIF_ISP_HIST_PROP_MODE_RED		(2 << 0)
+#define CIF_ISP_HIST_PROP_MODE_GREEN		(3 << 0)
+#define CIF_ISP_HIST_PROP_MODE_BLUE		(4 << 0)
+#define CIF_ISP_HIST_PROP_MODE_LUM		(5 << 0)
+#define CIF_ISP_HIST_PROP_MODE_MASK		0x7
+#define CIF_ISP_HIST_PREDIV_SET(x)		(((x) & 0x7F) << 3)
+#define CIF_ISP_HIST_WEIGHT_SET(v0, v1, v2, v3)	\
+				     (((v0) & 0x1F) | (((v1) & 0x1F) << 8)  |\
+				     (((v2) & 0x1F) << 16) | \
+				     (((v3) & 0x1F) << 24))
+
+#define CIF_ISP_HIST_WINDOW_OFFSET_RESERVED	0xFFFFF000
+#define CIF_ISP_HIST_WINDOW_SIZE_RESERVED	0xFFFFF800
+#define CIF_ISP_HIST_WEIGHT_RESERVED		0xE0E0E0E0
+#define CIF_ISP_MAX_HIST_PREDIVIDER		0x0000007F
+#define CIF_ISP_HIST_ROW_NUM			5
+#define CIF_ISP_HIST_COLUMN_NUM			5
+
+/* AUTO FOCUS MEASUREMENT:  ISP_AFM_CTRL */
+#define ISP_AFM_CTRL_ENABLE			BIT(0)
+
+/* SHUTTER CONTROL */
+#define CIF_ISP_SH_CTRL_SH_ENA			BIT(0)
+#define CIF_ISP_SH_CTRL_REP_EN			BIT(1)
+#define CIF_ISP_SH_CTRL_SRC_SH_TRIG		BIT(2)
+#define CIF_ISP_SH_CTRL_EDGE_POS		BIT(3)
+#define CIF_ISP_SH_CTRL_POL_LOW			BIT(4)
+
+/* FLASH MODULE */
+/* ISP_FLASH_CMD */
+#define CIF_FLASH_CMD_PRELIGHT_ON		BIT(0)
+#define CIF_FLASH_CMD_FLASH_ON			BIT(1)
+#define CIF_FLASH_CMD_PRE_FLASH_ON		BIT(2)
+/* ISP_FLASH_CONFIG */
+#define CIF_FLASH_CONFIG_PRELIGHT_END		BIT(0)
+#define CIF_FLASH_CONFIG_VSYNC_POS		BIT(1)
+#define CIF_FLASH_CONFIG_PRELIGHT_LOW		BIT(2)
+#define CIF_FLASH_CONFIG_SRC_FL_TRIG		BIT(3)
+#define CIF_FLASH_CONFIG_DELAY(a)		(((a) & 0xF) << 4)
+
+/* Demosaic:  ISP_DEMOSAIC */
+#define CIF_ISP_DEMOSAIC_BYPASS			BIT(10)
+#define CIF_ISP_DEMOSAIC_TH(x)			((x) & 0xFF)
+
+/* AWB */
+/* ISP_AWB_PROP */
+#define CIF_ISP_AWB_YMAX_CMP_EN			BIT(2)
+#define CIFISP_AWB_YMAX_READ(x)			(((x) >> 2) & 1)
+#define CIF_ISP_AWB_MODE_RGB_EN			((1 << 31) | (0x2 << 0))
+#define CIF_ISP_AWB_MODE_YCBCR_EN		((0 << 31) | (0x2 << 0))
+#define CIF_ISP_AWB_MODE_YCBCR_EN		((0 << 31) | (0x2 << 0))
+#define CIF_ISP_AWB_MODE_MASK_NONE		0xFFFFFFFC
+#define CIF_ISP_AWB_MODE_READ(x)		((x) & 3)
+/* ISP_AWB_GAIN_RB, ISP_AWB_GAIN_G  */
+#define CIF_ISP_AWB_GAIN_R_SET(x)		(((x) & 0x3FF) << 16)
+#define CIF_ISP_AWB_GAIN_R_READ(x)		(((x) >> 16) & 0x3FF)
+#define CIF_ISP_AWB_GAIN_B_SET(x)		((x) & 0x3FFF)
+#define CIF_ISP_AWB_GAIN_B_READ(x)		((x) & 0x3FFF)
+/* ISP_AWB_REF */
+#define CIF_ISP_AWB_REF_CR_SET(x)		(((x) & 0xFF) << 8)
+#define CIF_ISP_AWB_REF_CR_READ(x)		(((x) >> 8) & 0xFF)
+#define CIF_ISP_AWB_REF_CB_READ(x)		((x) & 0xFF)
+/* ISP_AWB_THRESH */
+#define CIF_ISP_AWB_MAX_CS_SET(x)		(((x) & 0xFF) << 8)
+#define CIF_ISP_AWB_MAX_CS_READ(x)		(((x) >> 8) & 0xFF)
+#define CIF_ISP_AWB_MIN_C_READ(x)		((x) & 0xFF)
+#define CIF_ISP_AWB_MIN_Y_SET(x)		(((x) & 0xFF) << 16)
+#define CIF_ISP_AWB_MIN_Y_READ(x)		(((x) >> 16) & 0xFF)
+#define CIF_ISP_AWB_MAX_Y_SET(x)		(((x) & 0xFF) << 24)
+#define CIF_ISP_AWB_MAX_Y_READ(x)		(((x) >> 24) & 0xFF)
+/* ISP_AWB_MEAN */
+#define CIF_ISP_AWB_GET_MEAN_CR_R(x)		((x) & 0xFF)
+#define CIF_ISP_AWB_GET_MEAN_CB_B(x)		(((x) >> 8) & 0xFF)
+#define CIF_ISP_AWB_GET_MEAN_Y_G(x)		(((x) >> 16) & 0xFF)
+/* ISP_AWB_WHITE_CNT */
+#define CIF_ISP_AWB_GET_PIXEL_CNT(x)		((x) & 0x3FFFFFF)
+
+#define CIF_ISP_AWB_GAINS_MAX_VAL		0x000003FF
+#define CIF_ISP_AWB_WINDOW_OFFSET_MAX		0x00000FFF
+#define CIF_ISP_AWB_WINDOW_MAX_SIZE		0x00001FFF
+#define CIF_ISP_AWB_CBCR_MAX_REF		0x000000FF
+#define CIF_ISP_AWB_THRES_MAX_YC		0x000000FF
+
+/* AE */
+/* ISP_EXP_CTRL */
+#define CIF_ISP_EXP_ENA				BIT(0)
+#define CIF_ISP_EXP_CTRL_AUTOSTOP		BIT(1)
+/*
+ *'1' luminance calculation according to  Y=(R+G+B) x 0.332 (85/256)
+ *'0' luminance calculation according to Y=16+0.25R+0.5G+0.1094B
+ */
+#define CIF_ISP_EXP_CTRL_MEASMODE_1		BIT(31)
+
+/* ISP_EXP_H_SIZE */
+#define CIF_ISP_EXP_H_SIZE_SET(x)		((x) & 0x7FF)
+#define CIF_ISP_EXP_HEIGHT_MASK			0x000007FF
+/* ISP_EXP_V_SIZE : vertical size must be a multiple of 2). */
+#define CIF_ISP_EXP_V_SIZE_SET(x)		((x) & 0x7FE)
+
+/* ISP_EXP_H_OFFSET */
+#define CIF_ISP_EXP_H_OFFSET_SET(x)		((x) & 0x1FFF)
+#define CIF_ISP_EXP_MAX_HOFFS			2424
+/* ISP_EXP_V_OFFSET */
+#define CIF_ISP_EXP_V_OFFSET_SET(x)		((x) & 0x1FFF)
+#define CIF_ISP_EXP_MAX_VOFFS			1806
+
+#define CIF_ISP_EXP_ROW_NUM			5
+#define CIF_ISP_EXP_COLUMN_NUM			5
+#define CIF_ISP_EXP_NUM_LUMA_REGS \
+	(CIF_ISP_EXP_ROW_NUM * CIF_ISP_EXP_COLUMN_NUM)
+#define CIF_ISP_EXP_BLOCK_MAX_HSIZE		516
+#define CIF_ISP_EXP_BLOCK_MIN_HSIZE		35
+#define CIF_ISP_EXP_BLOCK_MAX_VSIZE		390
+#define CIF_ISP_EXP_BLOCK_MIN_VSIZE		28
+#define CIF_ISP_EXP_MAX_HSIZE	\
+	(CIF_ISP_EXP_BLOCK_MAX_HSIZE * CIF_ISP_EXP_COLUMN_NUM + 1)
+#define CIF_ISP_EXP_MIN_HSIZE	\
+	(CIF_ISP_EXP_BLOCK_MIN_HSIZE * CIF_ISP_EXP_COLUMN_NUM + 1)
+#define CIF_ISP_EXP_MAX_VSIZE	\
+	(CIF_ISP_EXP_BLOCK_MAX_VSIZE * CIF_ISP_EXP_ROW_NUM + 1)
+#define CIF_ISP_EXP_MIN_VSIZE	\
+	(CIF_ISP_EXP_BLOCK_MIN_VSIZE * CIF_ISP_EXP_ROW_NUM + 1)
+
+/* LSC: ISP_LSC_CTRL */
+#define CIF_ISP_LSC_CTRL_ENA			BIT(0)
+#define CIF_ISP_LSC_SECT_SIZE_RESERVED		0xFC00FC00
+#define CIF_ISP_LSC_GRAD_RESERVED		0xF000F000
+#define CIF_ISP_LSC_SAMPLE_RESERVED		0xF000F000
+#define CIF_ISP_LSC_SECTORS_MAX			17
+#define CIF_ISP_LSC_TABLE_DATA(v0, v1)     \
+	(((v0) & 0xFFF) | (((v1) & 0xFFF) << 12))
+#define CIF_ISP_LSC_SECT_SIZE(v0, v1)      \
+	(((v0) & 0xFFF) | (((v1) & 0xFFF) << 16))
+#define CIF_ISP_LSC_GRAD_SIZE(v0, v1)      \
+	(((v0) & 0xFFF) | (((v1) & 0xFFF) << 16))
+
+/* LSC: ISP_LSC_TABLE_SEL */
+#define CIF_ISP_LSC_TABLE_0			0
+#define CIF_ISP_LSC_TABLE_1			1
+
+/* LSC: ISP_LSC_STATUS */
+#define CIF_ISP_LSC_ACTIVE_TABLE		BIT(1)
+#define CIF_ISP_LSC_TABLE_ADDRESS_0		0
+#define CIF_ISP_LSC_TABLE_ADDRESS_153		153
+
+/* FLT */
+/* ISP_FILT_MODE */
+#define CIF_ISP_FLT_ENA				BIT(0)
+
+/*
+ * 0: green filter static mode (active filter factor = FILT_FAC_MID)
+ * 1: dynamic noise reduction/sharpen Default
+ */
+#define CIF_ISP_FLT_MODE_DNR			BIT(1)
+#define CIF_ISP_FLT_MODE_MAX			1
+#define CIF_ISP_FLT_CHROMA_V_MODE(x)		(((x) & 0x3) << 4)
+#define CIF_ISP_FLT_CHROMA_H_MODE(x)		(((x) & 0x3) << 6)
+#define CIF_ISP_FLT_CHROMA_MODE_MAX		3
+#define CIF_ISP_FLT_GREEN_STAGE1(x)		(((x) & 0xF) << 8)
+#define CIF_ISP_FLT_GREEN_STAGE1_MAX		8
+#define CIF_ISP_FLT_THREAD_RESERVED		0xFFFFFC00
+#define CIF_ISP_FLT_FAC_RESERVED		0xFFFFFFC0
+#define CIF_ISP_FLT_LUM_WEIGHT_RESERVED		0xFFF80000
+
+#define CIF_ISP_CTK_COEFF_RESERVED		0xFFFFF800
+#define CIF_ISP_XTALK_OFFSET_RESERVED		0xFFFFF000
+
+/* GOC */
+#define CIF_ISP_GAMMA_OUT_MODE_EQU		BIT(0)
+#define CIF_ISP_GOC_MODE_MAX			1
+#define CIF_ISP_GOC_RESERVED			0xFFFFF800
+/* ISP_CTRL BIT 11*/
+#define CIF_ISP_CTRL_ISP_GAMMA_OUT_ENA_READ(x)	(((x) >> 11) & 1)
+
+/* DPCC */
+/* ISP_DPCC_MODE */
+#define CIF_ISP_DPCC_ENA			BIT(0)
+#define CIF_ISP_DPCC_MODE_MAX			0x07
+#define CIF_ISP_DPCC_OUTPUTMODE_MAX		0x0F
+#define CIF_ISP_DPCC_SETUSE_MAX			0x0F
+#define CIF_ISP_DPCC_METHODS_SET_RESERVED	0xFFFFE000
+#define CIF_ISP_DPCC_LINE_THRESH_RESERVED	0xFFFF0000
+#define CIF_ISP_DPCC_LINE_MAD_FAC_RESERVED	0xFFFFC0C0
+#define CIF_ISP_DPCC_PG_FAC_RESERVED		0xFFFFC0C0
+#define CIF_ISP_DPCC_RND_THRESH_RESERVED	0xFFFF0000
+#define CIF_ISP_DPCC_RG_FAC_RESERVED		0xFFFFC0C0
+#define CIF_ISP_DPCC_RO_LIMIT_RESERVED		0xFFFFF000
+#define CIF_ISP_DPCC_RND_OFFS_RESERVED		0xFFFFF000
+
+/* BLS */
+/* ISP_BLS_CTRL */
+#define CIF_ISP_BLS_ENA				BIT(0)
+#define CIF_ISP_BLS_MODE_MEASURED		BIT(1)
+#define CIF_ISP_BLS_MODE_FIXED			0
+#define CIF_ISP_BLS_WINDOW_1			(1 << 2)
+#define CIF_ISP_BLS_WINDOW_2			(2 << 2)
+
+/* GAMMA-IN */
+#define CIFISP_DEGAMMA_X_RESERVED	\
+	((1 << 31) | (1 << 27) | (1 << 23) | (1 << 19) |\
+	(1 << 15) | (1 << 11) | (1 << 7) | (1 << 3))
+#define CIFISP_DEGAMMA_Y_RESERVED               0xFFFFF000
+
+/* AFM */
+#define CIF_ISP_AFM_ENA				BIT(0)
+#define CIF_ISP_AFM_THRES_RESERVED		0xFFFF0000
+#define CIF_ISP_AFM_VAR_SHIFT_RESERVED		0xFFF8FFF8
+#define CIF_ISP_AFM_WINDOW_X_RESERVED		0xE000
+#define CIF_ISP_AFM_WINDOW_Y_RESERVED		0xF000
+#define CIF_ISP_AFM_WINDOW_X_MIN		0x5
+#define CIF_ISP_AFM_WINDOW_Y_MIN		0x2
+#define CIF_ISP_AFM_WINDOW_X(x)			(((x) & 0x1FFF) << 16)
+#define CIF_ISP_AFM_WINDOW_Y(x)			((x) & 0x1FFF)
+
+/* DPF */
+#define CIF_ISP_DPF_MODE_EN			BIT(0)
+#define CIF_ISP_DPF_MODE_B_FLT_DIS		BIT(1)
+#define CIF_ISP_DPF_MODE_GB_FLT_DIS		BIT(2)
+#define CIF_ISP_DPF_MODE_GR_FLT_DIS		BIT(3)
+#define CIF_ISP_DPF_MODE_R_FLT_DIS		BIT(4)
+#define CIF_ISP_DPF_MODE_RB_FLTSIZE_9x9		BIT(5)
+#define CIF_ISP_DPF_MODE_NLL_SEGMENTATION	BIT(6)
+#define CIF_ISP_DPF_MODE_AWB_GAIN_COMP		BIT(7)
+#define CIF_ISP_DPF_MODE_LSC_GAIN_COMP		BIT(8)
+#define CIF_ISP_DPF_MODE_USE_NF_GAIN		BIT(9)
+#define CIF_ISP_DPF_NF_GAIN_RESERVED		0xFFFFF000
+#define CIF_ISP_DPF_SPATIAL_COEFF_MAX		0x1F
+#define CIF_ISP_DPF_NLL_COEFF_N_MAX		0x3FF
+
+/* =================================================================== */
+/*                            CIF Registers                            */
+/* =================================================================== */
+#define CIF_CTRL_BASE			0x00000000
+#define CIF_CCL				(CIF_CTRL_BASE + 0x00000000)
+#define CIF_VI_ID			(CIF_CTRL_BASE + 0x00000008)
+#define CIF_ICCL			(CIF_CTRL_BASE + 0x00000010)
+#define CIF_IRCL			(CIF_CTRL_BASE + 0x00000014)
+#define CIF_VI_DPCL			(CIF_CTRL_BASE + 0x00000018)
+
+#define CIF_IMG_EFF_BASE		0x00000200
+#define CIF_IMG_EFF_CTRL		(CIF_IMG_EFF_BASE + 0x00000000)
+#define CIF_IMG_EFF_COLOR_SEL		(CIF_IMG_EFF_BASE + 0x00000004)
+#define CIF_IMG_EFF_MAT_1		(CIF_IMG_EFF_BASE + 0x00000008)
+#define CIF_IMG_EFF_MAT_2		(CIF_IMG_EFF_BASE + 0x0000000C)
+#define CIF_IMG_EFF_MAT_3		(CIF_IMG_EFF_BASE + 0x00000010)
+#define CIF_IMG_EFF_MAT_4		(CIF_IMG_EFF_BASE + 0x00000014)
+#define CIF_IMG_EFF_MAT_5		(CIF_IMG_EFF_BASE + 0x00000018)
+#define CIF_IMG_EFF_TINT		(CIF_IMG_EFF_BASE + 0x0000001C)
+#define CIF_IMG_EFF_CTRL_SHD		(CIF_IMG_EFF_BASE + 0x00000020)
+#define CIF_IMG_EFF_SHARPEN		(CIF_IMG_EFF_BASE + 0x00000024)
+
+#define CIF_SUPER_IMP_BASE		0x00000300
+#define CIF_SUPER_IMP_CTRL		(CIF_SUPER_IMP_BASE + 0x00000000)
+#define CIF_SUPER_IMP_OFFSET_X		(CIF_SUPER_IMP_BASE + 0x00000004)
+#define CIF_SUPER_IMP_OFFSET_Y		(CIF_SUPER_IMP_BASE + 0x00000008)
+#define CIF_SUPER_IMP_COLOR_Y		(CIF_SUPER_IMP_BASE + 0x0000000C)
+#define CIF_SUPER_IMP_COLOR_CB		(CIF_SUPER_IMP_BASE + 0x00000010)
+#define CIF_SUPER_IMP_COLOR_CR		(CIF_SUPER_IMP_BASE + 0x00000014)
+
+#define CIF_ISP_BASE			0x00000400
+#define CIF_ISP_CTRL			(CIF_ISP_BASE + 0x00000000)
+#define CIF_ISP_ACQ_PROP		(CIF_ISP_BASE + 0x00000004)
+#define CIF_ISP_ACQ_H_OFFS		(CIF_ISP_BASE + 0x00000008)
+#define CIF_ISP_ACQ_V_OFFS		(CIF_ISP_BASE + 0x0000000C)
+#define CIF_ISP_ACQ_H_SIZE		(CIF_ISP_BASE + 0x00000010)
+#define CIF_ISP_ACQ_V_SIZE		(CIF_ISP_BASE + 0x00000014)
+#define CIF_ISP_ACQ_NR_FRAMES		(CIF_ISP_BASE + 0x00000018)
+#define CIF_ISP_GAMMA_DX_LO		(CIF_ISP_BASE + 0x0000001C)
+#define CIF_ISP_GAMMA_DX_HI		(CIF_ISP_BASE + 0x00000020)
+#define CIF_ISP_GAMMA_R_Y0		(CIF_ISP_BASE + 0x00000024)
+#define CIF_ISP_GAMMA_R_Y1		(CIF_ISP_BASE + 0x00000028)
+#define CIF_ISP_GAMMA_R_Y2		(CIF_ISP_BASE + 0x0000002C)
+#define CIF_ISP_GAMMA_R_Y3		(CIF_ISP_BASE + 0x00000030)
+#define CIF_ISP_GAMMA_R_Y4		(CIF_ISP_BASE + 0x00000034)
+#define CIF_ISP_GAMMA_R_Y5		(CIF_ISP_BASE + 0x00000038)
+#define CIF_ISP_GAMMA_R_Y6		(CIF_ISP_BASE + 0x0000003C)
+#define CIF_ISP_GAMMA_R_Y7		(CIF_ISP_BASE + 0x00000040)
+#define CIF_ISP_GAMMA_R_Y8		(CIF_ISP_BASE + 0x00000044)
+#define CIF_ISP_GAMMA_R_Y9		(CIF_ISP_BASE + 0x00000048)
+#define CIF_ISP_GAMMA_R_Y10		(CIF_ISP_BASE + 0x0000004C)
+#define CIF_ISP_GAMMA_R_Y11		(CIF_ISP_BASE + 0x00000050)
+#define CIF_ISP_GAMMA_R_Y12		(CIF_ISP_BASE + 0x00000054)
+#define CIF_ISP_GAMMA_R_Y13		(CIF_ISP_BASE + 0x00000058)
+#define CIF_ISP_GAMMA_R_Y14		(CIF_ISP_BASE + 0x0000005C)
+#define CIF_ISP_GAMMA_R_Y15		(CIF_ISP_BASE + 0x00000060)
+#define CIF_ISP_GAMMA_R_Y16		(CIF_ISP_BASE + 0x00000064)
+#define CIF_ISP_GAMMA_G_Y0		(CIF_ISP_BASE + 0x00000068)
+#define CIF_ISP_GAMMA_G_Y1		(CIF_ISP_BASE + 0x0000006C)
+#define CIF_ISP_GAMMA_G_Y2		(CIF_ISP_BASE + 0x00000070)
+#define CIF_ISP_GAMMA_G_Y3		(CIF_ISP_BASE + 0x00000074)
+#define CIF_ISP_GAMMA_G_Y4		(CIF_ISP_BASE + 0x00000078)
+#define CIF_ISP_GAMMA_G_Y5		(CIF_ISP_BASE + 0x0000007C)
+#define CIF_ISP_GAMMA_G_Y6		(CIF_ISP_BASE + 0x00000080)
+#define CIF_ISP_GAMMA_G_Y7		(CIF_ISP_BASE + 0x00000084)
+#define CIF_ISP_GAMMA_G_Y8		(CIF_ISP_BASE + 0x00000088)
+#define CIF_ISP_GAMMA_G_Y9		(CIF_ISP_BASE + 0x0000008C)
+#define CIF_ISP_GAMMA_G_Y10		(CIF_ISP_BASE + 0x00000090)
+#define CIF_ISP_GAMMA_G_Y11		(CIF_ISP_BASE + 0x00000094)
+#define CIF_ISP_GAMMA_G_Y12		(CIF_ISP_BASE + 0x00000098)
+#define CIF_ISP_GAMMA_G_Y13		(CIF_ISP_BASE + 0x0000009C)
+#define CIF_ISP_GAMMA_G_Y14		(CIF_ISP_BASE + 0x000000A0)
+#define CIF_ISP_GAMMA_G_Y15		(CIF_ISP_BASE + 0x000000A4)
+#define CIF_ISP_GAMMA_G_Y16		(CIF_ISP_BASE + 0x000000A8)
+#define CIF_ISP_GAMMA_B_Y0		(CIF_ISP_BASE + 0x000000AC)
+#define CIF_ISP_GAMMA_B_Y1		(CIF_ISP_BASE + 0x000000B0)
+#define CIF_ISP_GAMMA_B_Y2		(CIF_ISP_BASE + 0x000000B4)
+#define CIF_ISP_GAMMA_B_Y3		(CIF_ISP_BASE + 0x000000B8)
+#define CIF_ISP_GAMMA_B_Y4		(CIF_ISP_BASE + 0x000000BC)
+#define CIF_ISP_GAMMA_B_Y5		(CIF_ISP_BASE + 0x000000C0)
+#define CIF_ISP_GAMMA_B_Y6		(CIF_ISP_BASE + 0x000000C4)
+#define CIF_ISP_GAMMA_B_Y7		(CIF_ISP_BASE + 0x000000C8)
+#define CIF_ISP_GAMMA_B_Y8		(CIF_ISP_BASE + 0x000000CC)
+#define CIF_ISP_GAMMA_B_Y9		(CIF_ISP_BASE + 0x000000D0)
+#define CIF_ISP_GAMMA_B_Y10		(CIF_ISP_BASE + 0x000000D4)
+#define CIF_ISP_GAMMA_B_Y11		(CIF_ISP_BASE + 0x000000D8)
+#define CIF_ISP_GAMMA_B_Y12		(CIF_ISP_BASE + 0x000000DC)
+#define CIF_ISP_GAMMA_B_Y13		(CIF_ISP_BASE + 0x000000E0)
+#define CIF_ISP_GAMMA_B_Y14		(CIF_ISP_BASE + 0x000000E4)
+#define CIF_ISP_GAMMA_B_Y15		(CIF_ISP_BASE + 0x000000E8)
+#define CIF_ISP_GAMMA_B_Y16		(CIF_ISP_BASE + 0x000000EC)
+#define CIF_ISP_AWB_PROP		(CIF_ISP_BASE + 0x00000110)
+#define CIF_ISP_AWB_WND_H_OFFS		(CIF_ISP_BASE + 0x00000114)
+#define CIF_ISP_AWB_WND_V_OFFS		(CIF_ISP_BASE + 0x00000118)
+#define CIF_ISP_AWB_WND_H_SIZE		(CIF_ISP_BASE + 0x0000011C)
+#define CIF_ISP_AWB_WND_V_SIZE		(CIF_ISP_BASE + 0x00000120)
+#define CIF_ISP_AWB_FRAMES		(CIF_ISP_BASE + 0x00000124)
+#define CIF_ISP_AWB_REF			(CIF_ISP_BASE + 0x00000128)
+#define CIF_ISP_AWB_THRESH		(CIF_ISP_BASE + 0x0000012C)
+#define CIF_ISP_AWB_GAIN_G		(CIF_ISP_BASE + 0x00000138)
+#define CIF_ISP_AWB_GAIN_RB		(CIF_ISP_BASE + 0x0000013C)
+#define CIF_ISP_AWB_WHITE_CNT		(CIF_ISP_BASE + 0x00000140)
+#define CIF_ISP_AWB_MEAN		(CIF_ISP_BASE + 0x00000144)
+#define CIF_ISP_CC_COEFF_0		(CIF_ISP_BASE + 0x00000170)
+#define CIF_ISP_CC_COEFF_1		(CIF_ISP_BASE + 0x00000174)
+#define CIF_ISP_CC_COEFF_2		(CIF_ISP_BASE + 0x00000178)
+#define CIF_ISP_CC_COEFF_3		(CIF_ISP_BASE + 0x0000017C)
+#define CIF_ISP_CC_COEFF_4		(CIF_ISP_BASE + 0x00000180)
+#define CIF_ISP_CC_COEFF_5		(CIF_ISP_BASE + 0x00000184)
+#define CIF_ISP_CC_COEFF_6		(CIF_ISP_BASE + 0x00000188)
+#define CIF_ISP_CC_COEFF_7		(CIF_ISP_BASE + 0x0000018C)
+#define CIF_ISP_CC_COEFF_8		(CIF_ISP_BASE + 0x00000190)
+#define CIF_ISP_OUT_H_OFFS		(CIF_ISP_BASE + 0x00000194)
+#define CIF_ISP_OUT_V_OFFS		(CIF_ISP_BASE + 0x00000198)
+#define CIF_ISP_OUT_H_SIZE		(CIF_ISP_BASE + 0x0000019C)
+#define CIF_ISP_OUT_V_SIZE		(CIF_ISP_BASE + 0x000001A0)
+#define CIF_ISP_DEMOSAIC		(CIF_ISP_BASE + 0x000001A4)
+#define CIF_ISP_FLAGS_SHD		(CIF_ISP_BASE + 0x000001A8)
+#define CIF_ISP_OUT_H_OFFS_SHD		(CIF_ISP_BASE + 0x000001AC)
+#define CIF_ISP_OUT_V_OFFS_SHD		(CIF_ISP_BASE + 0x000001B0)
+#define CIF_ISP_OUT_H_SIZE_SHD		(CIF_ISP_BASE + 0x000001B4)
+#define CIF_ISP_OUT_V_SIZE_SHD		(CIF_ISP_BASE + 0x000001B8)
+#define CIF_ISP_IMSC			(CIF_ISP_BASE + 0x000001BC)
+#define CIF_ISP_RIS			(CIF_ISP_BASE + 0x000001C0)
+#define CIF_ISP_MIS			(CIF_ISP_BASE + 0x000001C4)
+#define CIF_ISP_ICR			(CIF_ISP_BASE + 0x000001C8)
+#define CIF_ISP_ISR			(CIF_ISP_BASE + 0x000001CC)
+#define CIF_ISP_CT_COEFF_0		(CIF_ISP_BASE + 0x000001D0)
+#define CIF_ISP_CT_COEFF_1		(CIF_ISP_BASE + 0x000001D4)
+#define CIF_ISP_CT_COEFF_2		(CIF_ISP_BASE + 0x000001D8)
+#define CIF_ISP_CT_COEFF_3		(CIF_ISP_BASE + 0x000001DC)
+#define CIF_ISP_CT_COEFF_4		(CIF_ISP_BASE + 0x000001E0)
+#define CIF_ISP_CT_COEFF_5		(CIF_ISP_BASE + 0x000001E4)
+#define CIF_ISP_CT_COEFF_6		(CIF_ISP_BASE + 0x000001E8)
+#define CIF_ISP_CT_COEFF_7		(CIF_ISP_BASE + 0x000001EC)
+#define CIF_ISP_CT_COEFF_8		(CIF_ISP_BASE + 0x000001F0)
+#define CIF_ISP_GAMMA_OUT_MODE		(CIF_ISP_BASE + 0x000001F4)
+#define CIF_ISP_GAMMA_OUT_Y_0		(CIF_ISP_BASE + 0x000001F8)
+#define CIF_ISP_GAMMA_OUT_Y_1		(CIF_ISP_BASE + 0x000001FC)
+#define CIF_ISP_GAMMA_OUT_Y_2		(CIF_ISP_BASE + 0x00000200)
+#define CIF_ISP_GAMMA_OUT_Y_3		(CIF_ISP_BASE + 0x00000204)
+#define CIF_ISP_GAMMA_OUT_Y_4		(CIF_ISP_BASE + 0x00000208)
+#define CIF_ISP_GAMMA_OUT_Y_5		(CIF_ISP_BASE + 0x0000020C)
+#define CIF_ISP_GAMMA_OUT_Y_6		(CIF_ISP_BASE + 0x00000210)
+#define CIF_ISP_GAMMA_OUT_Y_7		(CIF_ISP_BASE + 0x00000214)
+#define CIF_ISP_GAMMA_OUT_Y_8		(CIF_ISP_BASE + 0x00000218)
+#define CIF_ISP_GAMMA_OUT_Y_9		(CIF_ISP_BASE + 0x0000021C)
+#define CIF_ISP_GAMMA_OUT_Y_10		(CIF_ISP_BASE + 0x00000220)
+#define CIF_ISP_GAMMA_OUT_Y_11		(CIF_ISP_BASE + 0x00000224)
+#define CIF_ISP_GAMMA_OUT_Y_12		(CIF_ISP_BASE + 0x00000228)
+#define CIF_ISP_GAMMA_OUT_Y_13		(CIF_ISP_BASE + 0x0000022C)
+#define CIF_ISP_GAMMA_OUT_Y_14		(CIF_ISP_BASE + 0x00000230)
+#define CIF_ISP_GAMMA_OUT_Y_15		(CIF_ISP_BASE + 0x00000234)
+#define CIF_ISP_GAMMA_OUT_Y_16		(CIF_ISP_BASE + 0x00000238)
+#define CIF_ISP_ERR			(CIF_ISP_BASE + 0x0000023C)
+#define CIF_ISP_ERR_CLR			(CIF_ISP_BASE + 0x00000240)
+#define CIF_ISP_FRAME_COUNT		(CIF_ISP_BASE + 0x00000244)
+#define CIF_ISP_CT_OFFSET_R		(CIF_ISP_BASE + 0x00000248)
+#define CIF_ISP_CT_OFFSET_G		(CIF_ISP_BASE + 0x0000024C)
+#define CIF_ISP_CT_OFFSET_B		(CIF_ISP_BASE + 0x00000250)
+
+#define CIF_ISP_FLASH_BASE		0x00000660
+#define CIF_ISP_FLASH_CMD		(CIF_ISP_FLASH_BASE + 0x00000000)
+#define CIF_ISP_FLASH_CONFIG		(CIF_ISP_FLASH_BASE + 0x00000004)
+#define CIF_ISP_FLASH_PREDIV		(CIF_ISP_FLASH_BASE + 0x00000008)
+#define CIF_ISP_FLASH_DELAY		(CIF_ISP_FLASH_BASE + 0x0000000C)
+#define CIF_ISP_FLASH_TIME		(CIF_ISP_FLASH_BASE + 0x00000010)
+#define CIF_ISP_FLASH_MAXP		(CIF_ISP_FLASH_BASE + 0x00000014)
+
+#define CIF_ISP_SH_BASE			0x00000680
+#define CIF_ISP_SH_CTRL			(CIF_ISP_SH_BASE + 0x00000000)
+#define CIF_ISP_SH_PREDIV		(CIF_ISP_SH_BASE + 0x00000004)
+#define CIF_ISP_SH_DELAY		(CIF_ISP_SH_BASE + 0x00000008)
+#define CIF_ISP_SH_TIME			(CIF_ISP_SH_BASE + 0x0000000C)
+
+#define CIF_C_PROC_BASE			0x00000800
+#define CIF_C_PROC_CTRL			(CIF_C_PROC_BASE + 0x00000000)
+#define CIF_C_PROC_CONTRAST		(CIF_C_PROC_BASE + 0x00000004)
+#define CIF_C_PROC_BRIGHTNESS		(CIF_C_PROC_BASE + 0x00000008)
+#define CIF_C_PROC_SATURATION		(CIF_C_PROC_BASE + 0x0000000C)
+#define CIF_C_PROC_HUE			(CIF_C_PROC_BASE + 0x00000010)
+
+#define CIF_DUAL_CROP_BASE		0x00000880
+#define CIF_DUAL_CROP_CTRL		(CIF_DUAL_CROP_BASE + 0x00000000)
+#define CIF_DUAL_CROP_M_H_OFFS		(CIF_DUAL_CROP_BASE + 0x00000004)
+#define CIF_DUAL_CROP_M_V_OFFS		(CIF_DUAL_CROP_BASE + 0x00000008)
+#define CIF_DUAL_CROP_M_H_SIZE		(CIF_DUAL_CROP_BASE + 0x0000000C)
+#define CIF_DUAL_CROP_M_V_SIZE		(CIF_DUAL_CROP_BASE + 0x00000010)
+#define CIF_DUAL_CROP_S_H_OFFS		(CIF_DUAL_CROP_BASE + 0x00000014)
+#define CIF_DUAL_CROP_S_V_OFFS		(CIF_DUAL_CROP_BASE + 0x00000018)
+#define CIF_DUAL_CROP_S_H_SIZE		(CIF_DUAL_CROP_BASE + 0x0000001C)
+#define CIF_DUAL_CROP_S_V_SIZE		(CIF_DUAL_CROP_BASE + 0x00000020)
+#define CIF_DUAL_CROP_M_H_OFFS_SHD	(CIF_DUAL_CROP_BASE + 0x00000024)
+#define CIF_DUAL_CROP_M_V_OFFS_SHD	(CIF_DUAL_CROP_BASE + 0x00000028)
+#define CIF_DUAL_CROP_M_H_SIZE_SHD	(CIF_DUAL_CROP_BASE + 0x0000002C)
+#define CIF_DUAL_CROP_M_V_SIZE_SHD	(CIF_DUAL_CROP_BASE + 0x00000030)
+#define CIF_DUAL_CROP_S_H_OFFS_SHD	(CIF_DUAL_CROP_BASE + 0x00000034)
+#define CIF_DUAL_CROP_S_V_OFFS_SHD	(CIF_DUAL_CROP_BASE + 0x00000038)
+#define CIF_DUAL_CROP_S_H_SIZE_SHD	(CIF_DUAL_CROP_BASE + 0x0000003C)
+#define CIF_DUAL_CROP_S_V_SIZE_SHD	(CIF_DUAL_CROP_BASE + 0x00000040)
+
+#define CIF_MRSZ_BASE			0x00000C00
+#define CIF_MRSZ_CTRL			(CIF_MRSZ_BASE + 0x00000000)
+#define CIF_MRSZ_SCALE_HY		(CIF_MRSZ_BASE + 0x00000004)
+#define CIF_MRSZ_SCALE_HCB		(CIF_MRSZ_BASE + 0x00000008)
+#define CIF_MRSZ_SCALE_HCR		(CIF_MRSZ_BASE + 0x0000000C)
+#define CIF_MRSZ_SCALE_VY		(CIF_MRSZ_BASE + 0x00000010)
+#define CIF_MRSZ_SCALE_VC		(CIF_MRSZ_BASE + 0x00000014)
+#define CIF_MRSZ_PHASE_HY		(CIF_MRSZ_BASE + 0x00000018)
+#define CIF_MRSZ_PHASE_HC		(CIF_MRSZ_BASE + 0x0000001C)
+#define CIF_MRSZ_PHASE_VY		(CIF_MRSZ_BASE + 0x00000020)
+#define CIF_MRSZ_PHASE_VC		(CIF_MRSZ_BASE + 0x00000024)
+#define CIF_MRSZ_SCALE_LUT_ADDR		(CIF_MRSZ_BASE + 0x00000028)
+#define CIF_MRSZ_SCALE_LUT		(CIF_MRSZ_BASE + 0x0000002C)
+#define CIF_MRSZ_CTRL_SHD		(CIF_MRSZ_BASE + 0x00000030)
+#define CIF_MRSZ_SCALE_HY_SHD		(CIF_MRSZ_BASE + 0x00000034)
+#define CIF_MRSZ_SCALE_HCB_SHD		(CIF_MRSZ_BASE + 0x00000038)
+#define CIF_MRSZ_SCALE_HCR_SHD		(CIF_MRSZ_BASE + 0x0000003C)
+#define CIF_MRSZ_SCALE_VY_SHD		(CIF_MRSZ_BASE + 0x00000040)
+#define CIF_MRSZ_SCALE_VC_SHD		(CIF_MRSZ_BASE + 0x00000044)
+#define CIF_MRSZ_PHASE_HY_SHD		(CIF_MRSZ_BASE + 0x00000048)
+#define CIF_MRSZ_PHASE_HC_SHD		(CIF_MRSZ_BASE + 0x0000004C)
+#define CIF_MRSZ_PHASE_VY_SHD		(CIF_MRSZ_BASE + 0x00000050)
+#define CIF_MRSZ_PHASE_VC_SHD		(CIF_MRSZ_BASE + 0x00000054)
+
+#define CIF_SRSZ_BASE			0x00001000
+#define CIF_SRSZ_CTRL			(CIF_SRSZ_BASE + 0x00000000)
+#define CIF_SRSZ_SCALE_HY		(CIF_SRSZ_BASE + 0x00000004)
+#define CIF_SRSZ_SCALE_HCB		(CIF_SRSZ_BASE + 0x00000008)
+#define CIF_SRSZ_SCALE_HCR		(CIF_SRSZ_BASE + 0x0000000C)
+#define CIF_SRSZ_SCALE_VY		(CIF_SRSZ_BASE + 0x00000010)
+#define CIF_SRSZ_SCALE_VC		(CIF_SRSZ_BASE + 0x00000014)
+#define CIF_SRSZ_PHASE_HY		(CIF_SRSZ_BASE + 0x00000018)
+#define CIF_SRSZ_PHASE_HC		(CIF_SRSZ_BASE + 0x0000001C)
+#define CIF_SRSZ_PHASE_VY		(CIF_SRSZ_BASE + 0x00000020)
+#define CIF_SRSZ_PHASE_VC		(CIF_SRSZ_BASE + 0x00000024)
+#define CIF_SRSZ_SCALE_LUT_ADDR		(CIF_SRSZ_BASE + 0x00000028)
+#define CIF_SRSZ_SCALE_LUT		(CIF_SRSZ_BASE + 0x0000002C)
+#define CIF_SRSZ_CTRL_SHD		(CIF_SRSZ_BASE + 0x00000030)
+#define CIF_SRSZ_SCALE_HY_SHD		(CIF_SRSZ_BASE + 0x00000034)
+#define CIF_SRSZ_SCALE_HCB_SHD		(CIF_SRSZ_BASE + 0x00000038)
+#define CIF_SRSZ_SCALE_HCR_SHD		(CIF_SRSZ_BASE + 0x0000003C)
+#define CIF_SRSZ_SCALE_VY_SHD		(CIF_SRSZ_BASE + 0x00000040)
+#define CIF_SRSZ_SCALE_VC_SHD		(CIF_SRSZ_BASE + 0x00000044)
+#define CIF_SRSZ_PHASE_HY_SHD		(CIF_SRSZ_BASE + 0x00000048)
+#define CIF_SRSZ_PHASE_HC_SHD		(CIF_SRSZ_BASE + 0x0000004C)
+#define CIF_SRSZ_PHASE_VY_SHD		(CIF_SRSZ_BASE + 0x00000050)
+#define CIF_SRSZ_PHASE_VC_SHD		(CIF_SRSZ_BASE + 0x00000054)
+
+#define CIF_MI_BASE			0x00001400
+#define CIF_MI_CTRL			(CIF_MI_BASE + 0x00000000)
+#define CIF_MI_INIT			(CIF_MI_BASE + 0x00000004)
+#define CIF_MI_MP_Y_BASE_AD_INIT	(CIF_MI_BASE + 0x00000008)
+#define CIF_MI_MP_Y_SIZE_INIT		(CIF_MI_BASE + 0x0000000C)
+#define CIF_MI_MP_Y_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000010)
+#define CIF_MI_MP_Y_OFFS_CNT_START	(CIF_MI_BASE + 0x00000014)
+#define CIF_MI_MP_Y_IRQ_OFFS_INIT	(CIF_MI_BASE + 0x00000018)
+#define CIF_MI_MP_CB_BASE_AD_INIT	(CIF_MI_BASE + 0x0000001C)
+#define CIF_MI_MP_CB_SIZE_INIT		(CIF_MI_BASE + 0x00000020)
+#define CIF_MI_MP_CB_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000024)
+#define CIF_MI_MP_CB_OFFS_CNT_START	(CIF_MI_BASE + 0x00000028)
+#define CIF_MI_MP_CR_BASE_AD_INIT	(CIF_MI_BASE + 0x0000002C)
+#define CIF_MI_MP_CR_SIZE_INIT		(CIF_MI_BASE + 0x00000030)
+#define CIF_MI_MP_CR_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000034)
+#define CIF_MI_MP_CR_OFFS_CNT_START	(CIF_MI_BASE + 0x00000038)
+#define CIF_MI_SP_Y_BASE_AD_INIT	(CIF_MI_BASE + 0x0000003C)
+#define CIF_MI_SP_Y_SIZE_INIT		(CIF_MI_BASE + 0x00000040)
+#define CIF_MI_SP_Y_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000044)
+#define CIF_MI_SP_Y_OFFS_CNT_START	(CIF_MI_BASE + 0x00000048)
+#define CIF_MI_SP_Y_LLENGTH		(CIF_MI_BASE + 0x0000004C)
+#define CIF_MI_SP_CB_BASE_AD_INIT	(CIF_MI_BASE + 0x00000050)
+#define CIF_MI_SP_CB_SIZE_INIT		(CIF_MI_BASE + 0x00000054)
+#define CIF_MI_SP_CB_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000058)
+#define CIF_MI_SP_CB_OFFS_CNT_START	(CIF_MI_BASE + 0x0000005C)
+#define CIF_MI_SP_CR_BASE_AD_INIT	(CIF_MI_BASE + 0x00000060)
+#define CIF_MI_SP_CR_SIZE_INIT		(CIF_MI_BASE + 0x00000064)
+#define CIF_MI_SP_CR_OFFS_CNT_INIT	(CIF_MI_BASE + 0x00000068)
+#define CIF_MI_SP_CR_OFFS_CNT_START	(CIF_MI_BASE + 0x0000006C)
+#define CIF_MI_BYTE_CNT			(CIF_MI_BASE + 0x00000070)
+#define CIF_MI_CTRL_SHD			(CIF_MI_BASE + 0x00000074)
+#define CIF_MI_MP_Y_BASE_AD_SHD		(CIF_MI_BASE + 0x00000078)
+#define CIF_MI_MP_Y_SIZE_SHD		(CIF_MI_BASE + 0x0000007C)
+#define CIF_MI_MP_Y_OFFS_CNT_SHD	(CIF_MI_BASE + 0x00000080)
+#define CIF_MI_MP_Y_IRQ_OFFS_SHD	(CIF_MI_BASE + 0x00000084)
+#define CIF_MI_MP_CB_BASE_AD_SHD	(CIF_MI_BASE + 0x00000088)
+#define CIF_MI_MP_CB_SIZE_SHD		(CIF_MI_BASE + 0x0000008C)
+#define CIF_MI_MP_CB_OFFS_CNT_SHD	(CIF_MI_BASE + 0x00000090)
+#define CIF_MI_MP_CR_BASE_AD_SHD	(CIF_MI_BASE + 0x00000094)
+#define CIF_MI_MP_CR_SIZE_SHD		(CIF_MI_BASE + 0x00000098)
+#define CIF_MI_MP_CR_OFFS_CNT_SHD	(CIF_MI_BASE + 0x0000009C)
+#define CIF_MI_SP_Y_BASE_AD_SHD		(CIF_MI_BASE + 0x000000A0)
+#define CIF_MI_SP_Y_SIZE_SHD		(CIF_MI_BASE + 0x000000A4)
+#define CIF_MI_SP_Y_OFFS_CNT_SHD	(CIF_MI_BASE + 0x000000A8)
+#define CIF_MI_SP_CB_BASE_AD_SHD	(CIF_MI_BASE + 0x000000B0)
+#define CIF_MI_SP_CB_SIZE_SHD		(CIF_MI_BASE + 0x000000B4)
+#define CIF_MI_SP_CB_OFFS_CNT_SHD	(CIF_MI_BASE + 0x000000B8)
+#define CIF_MI_SP_CR_BASE_AD_SHD	(CIF_MI_BASE + 0x000000BC)
+#define CIF_MI_SP_CR_SIZE_SHD		(CIF_MI_BASE + 0x000000C0)
+#define CIF_MI_SP_CR_OFFS_CNT_SHD	(CIF_MI_BASE + 0x000000C4)
+#define CIF_MI_DMA_Y_PIC_START_AD	(CIF_MI_BASE + 0x000000C8)
+#define CIF_MI_DMA_Y_PIC_WIDTH		(CIF_MI_BASE + 0x000000CC)
+#define CIF_MI_DMA_Y_LLENGTH		(CIF_MI_BASE + 0x000000D0)
+#define CIF_MI_DMA_Y_PIC_SIZE		(CIF_MI_BASE + 0x000000D4)
+#define CIF_MI_DMA_CB_PIC_START_AD	(CIF_MI_BASE + 0x000000D8)
+#define CIF_MI_DMA_CR_PIC_START_AD	(CIF_MI_BASE + 0x000000E8)
+#define CIF_MI_IMSC			(CIF_MI_BASE + 0x000000F8)
+#define CIF_MI_RIS			(CIF_MI_BASE + 0x000000FC)
+#define CIF_MI_MIS			(CIF_MI_BASE + 0x00000100)
+#define CIF_MI_ICR			(CIF_MI_BASE + 0x00000104)
+#define CIF_MI_ISR			(CIF_MI_BASE + 0x00000108)
+#define CIF_MI_STATUS			(CIF_MI_BASE + 0x0000010C)
+#define CIF_MI_STATUS_CLR		(CIF_MI_BASE + 0x00000110)
+#define CIF_MI_SP_Y_PIC_WIDTH		(CIF_MI_BASE + 0x00000114)
+#define CIF_MI_SP_Y_PIC_HEIGHT		(CIF_MI_BASE + 0x00000118)
+#define CIF_MI_SP_Y_PIC_SIZE		(CIF_MI_BASE + 0x0000011C)
+#define CIF_MI_DMA_CTRL			(CIF_MI_BASE + 0x00000120)
+#define CIF_MI_DMA_START		(CIF_MI_BASE + 0x00000124)
+#define CIF_MI_DMA_STATUS		(CIF_MI_BASE + 0x00000128)
+#define CIF_MI_PIXEL_COUNT		(CIF_MI_BASE + 0x0000012C)
+#define CIF_MI_MP_Y_BASE_AD_INIT2	(CIF_MI_BASE + 0x00000130)
+#define CIF_MI_MP_CB_BASE_AD_INIT2	(CIF_MI_BASE + 0x00000134)
+#define CIF_MI_MP_CR_BASE_AD_INIT2	(CIF_MI_BASE + 0x00000138)
+#define CIF_MI_SP_Y_BASE_AD_INIT2	(CIF_MI_BASE + 0x0000013C)
+#define CIF_MI_SP_CB_BASE_AD_INIT2	(CIF_MI_BASE + 0x00000140)
+#define CIF_MI_SP_CR_BASE_AD_INIT2	(CIF_MI_BASE + 0x00000144)
+#define CIF_MI_XTD_FORMAT_CTRL		(CIF_MI_BASE + 0x00000148)
+
+#define CIF_SMIA_BASE			0x00001A00
+#define CIF_SMIA_CTRL			(CIF_SMIA_BASE + 0x00000000)
+#define CIF_SMIA_STATUS			(CIF_SMIA_BASE + 0x00000004)
+#define CIF_SMIA_IMSC			(CIF_SMIA_BASE + 0x00000008)
+#define CIF_SMIA_RIS			(CIF_SMIA_BASE + 0x0000000C)
+#define CIF_SMIA_MIS			(CIF_SMIA_BASE + 0x00000010)
+#define CIF_SMIA_ICR			(CIF_SMIA_BASE + 0x00000014)
+#define CIF_SMIA_ISR			(CIF_SMIA_BASE + 0x00000018)
+#define CIF_SMIA_DATA_FORMAT_SEL	(CIF_SMIA_BASE + 0x0000001C)
+#define CIF_SMIA_SOF_EMB_DATA_LINES	(CIF_SMIA_BASE + 0x00000020)
+#define CIF_SMIA_EMB_HSTART		(CIF_SMIA_BASE + 0x00000024)
+#define CIF_SMIA_EMB_HSIZE		(CIF_SMIA_BASE + 0x00000028)
+#define CIF_SMIA_EMB_VSTART		(CIF_SMIA_BASE + 0x0000002c)
+#define CIF_SMIA_NUM_LINES		(CIF_SMIA_BASE + 0x00000030)
+#define CIF_SMIA_EMB_DATA_FIFO		(CIF_SMIA_BASE + 0x00000034)
+#define CIF_SMIA_EMB_DATA_WATERMARK	(CIF_SMIA_BASE + 0x00000038)
+
+#define CIF_MIPI_BASE			0x00001C00
+#define CIF_MIPI_CTRL			(CIF_MIPI_BASE + 0x00000000)
+#define CIF_MIPI_STATUS			(CIF_MIPI_BASE + 0x00000004)
+#define CIF_MIPI_IMSC			(CIF_MIPI_BASE + 0x00000008)
+#define CIF_MIPI_RIS			(CIF_MIPI_BASE + 0x0000000C)
+#define CIF_MIPI_MIS			(CIF_MIPI_BASE + 0x00000010)
+#define CIF_MIPI_ICR			(CIF_MIPI_BASE + 0x00000014)
+#define CIF_MIPI_ISR			(CIF_MIPI_BASE + 0x00000018)
+#define CIF_MIPI_CUR_DATA_ID		(CIF_MIPI_BASE + 0x0000001C)
+#define CIF_MIPI_IMG_DATA_SEL		(CIF_MIPI_BASE + 0x00000020)
+#define CIF_MIPI_ADD_DATA_SEL_1		(CIF_MIPI_BASE + 0x00000024)
+#define CIF_MIPI_ADD_DATA_SEL_2		(CIF_MIPI_BASE + 0x00000028)
+#define CIF_MIPI_ADD_DATA_SEL_3		(CIF_MIPI_BASE + 0x0000002C)
+#define CIF_MIPI_ADD_DATA_SEL_4		(CIF_MIPI_BASE + 0x00000030)
+#define CIF_MIPI_ADD_DATA_FIFO		(CIF_MIPI_BASE + 0x00000034)
+#define CIF_MIPI_FIFO_FILL_LEVEL	(CIF_MIPI_BASE + 0x00000038)
+#define CIF_MIPI_COMPRESSED_MODE	(CIF_MIPI_BASE + 0x0000003C)
+#define CIF_MIPI_FRAME			(CIF_MIPI_BASE + 0x00000040)
+#define CIF_MIPI_GEN_SHORT_DT		(CIF_MIPI_BASE + 0x00000044)
+#define CIF_MIPI_GEN_SHORT_8_9		(CIF_MIPI_BASE + 0x00000048)
+#define CIF_MIPI_GEN_SHORT_A_B		(CIF_MIPI_BASE + 0x0000004C)
+#define CIF_MIPI_GEN_SHORT_C_D		(CIF_MIPI_BASE + 0x00000050)
+#define CIF_MIPI_GEN_SHORT_E_F		(CIF_MIPI_BASE + 0x00000054)
+
+#define CIF_ISP_AFM_BASE		0x00002000
+#define CIF_ISP_AFM_CTRL		(CIF_ISP_AFM_BASE + 0x00000000)
+#define CIF_ISP_AFM_LT_A		(CIF_ISP_AFM_BASE + 0x00000004)
+#define CIF_ISP_AFM_RB_A		(CIF_ISP_AFM_BASE + 0x00000008)
+#define CIF_ISP_AFM_LT_B		(CIF_ISP_AFM_BASE + 0x0000000C)
+#define CIF_ISP_AFM_RB_B		(CIF_ISP_AFM_BASE + 0x00000010)
+#define CIF_ISP_AFM_LT_C		(CIF_ISP_AFM_BASE + 0x00000014)
+#define CIF_ISP_AFM_RB_C		(CIF_ISP_AFM_BASE + 0x00000018)
+#define CIF_ISP_AFM_THRES		(CIF_ISP_AFM_BASE + 0x0000001C)
+#define CIF_ISP_AFM_VAR_SHIFT		(CIF_ISP_AFM_BASE + 0x00000020)
+#define CIF_ISP_AFM_SUM_A		(CIF_ISP_AFM_BASE + 0x00000024)
+#define CIF_ISP_AFM_SUM_B		(CIF_ISP_AFM_BASE + 0x00000028)
+#define CIF_ISP_AFM_SUM_C		(CIF_ISP_AFM_BASE + 0x0000002C)
+#define CIF_ISP_AFM_LUM_A		(CIF_ISP_AFM_BASE + 0x00000030)
+#define CIF_ISP_AFM_LUM_B		(CIF_ISP_AFM_BASE + 0x00000034)
+#define CIF_ISP_AFM_LUM_C		(CIF_ISP_AFM_BASE + 0x00000038)
+
+#define CIF_ISP_LSC_BASE		0x00002200
+#define CIF_ISP_LSC_CTRL		(CIF_ISP_LSC_BASE + 0x00000000)
+#define CIF_ISP_LSC_R_TABLE_ADDR	(CIF_ISP_LSC_BASE + 0x00000004)
+#define CIF_ISP_LSC_GR_TABLE_ADDR	(CIF_ISP_LSC_BASE + 0x00000008)
+#define CIF_ISP_LSC_B_TABLE_ADDR	(CIF_ISP_LSC_BASE + 0x0000000C)
+#define CIF_ISP_LSC_GB_TABLE_ADDR	(CIF_ISP_LSC_BASE + 0x00000010)
+#define CIF_ISP_LSC_R_TABLE_DATA	(CIF_ISP_LSC_BASE + 0x00000014)
+#define CIF_ISP_LSC_GR_TABLE_DATA	(CIF_ISP_LSC_BASE + 0x00000018)
+#define CIF_ISP_LSC_B_TABLE_DATA	(CIF_ISP_LSC_BASE + 0x0000001C)
+#define CIF_ISP_LSC_GB_TABLE_DATA	(CIF_ISP_LSC_BASE + 0x00000020)
+#define CIF_ISP_LSC_XGRAD_01		(CIF_ISP_LSC_BASE + 0x00000024)
+#define CIF_ISP_LSC_XGRAD_23		(CIF_ISP_LSC_BASE + 0x00000028)
+#define CIF_ISP_LSC_XGRAD_45		(CIF_ISP_LSC_BASE + 0x0000002C)
+#define CIF_ISP_LSC_XGRAD_67		(CIF_ISP_LSC_BASE + 0x00000030)
+#define CIF_ISP_LSC_YGRAD_01		(CIF_ISP_LSC_BASE + 0x00000034)
+#define CIF_ISP_LSC_YGRAD_23		(CIF_ISP_LSC_BASE + 0x00000038)
+#define CIF_ISP_LSC_YGRAD_45		(CIF_ISP_LSC_BASE + 0x0000003C)
+#define CIF_ISP_LSC_YGRAD_67		(CIF_ISP_LSC_BASE + 0x00000040)
+#define CIF_ISP_LSC_XSIZE_01		(CIF_ISP_LSC_BASE + 0x00000044)
+#define CIF_ISP_LSC_XSIZE_23		(CIF_ISP_LSC_BASE + 0x00000048)
+#define CIF_ISP_LSC_XSIZE_45		(CIF_ISP_LSC_BASE + 0x0000004C)
+#define CIF_ISP_LSC_XSIZE_67		(CIF_ISP_LSC_BASE + 0x00000050)
+#define CIF_ISP_LSC_YSIZE_01		(CIF_ISP_LSC_BASE + 0x00000054)
+#define CIF_ISP_LSC_YSIZE_23		(CIF_ISP_LSC_BASE + 0x00000058)
+#define CIF_ISP_LSC_YSIZE_45		(CIF_ISP_LSC_BASE + 0x0000005C)
+#define CIF_ISP_LSC_YSIZE_67		(CIF_ISP_LSC_BASE + 0x00000060)
+#define CIF_ISP_LSC_TABLE_SEL		(CIF_ISP_LSC_BASE + 0x00000064)
+#define CIF_ISP_LSC_STATUS		(CIF_ISP_LSC_BASE + 0x00000068)
+
+#define CIF_ISP_IS_BASE			0x00002300
+#define CIF_ISP_IS_CTRL			(CIF_ISP_IS_BASE + 0x00000000)
+#define CIF_ISP_IS_RECENTER		(CIF_ISP_IS_BASE + 0x00000004)
+#define CIF_ISP_IS_H_OFFS		(CIF_ISP_IS_BASE + 0x00000008)
+#define CIF_ISP_IS_V_OFFS		(CIF_ISP_IS_BASE + 0x0000000C)
+#define CIF_ISP_IS_H_SIZE		(CIF_ISP_IS_BASE + 0x00000010)
+#define CIF_ISP_IS_V_SIZE		(CIF_ISP_IS_BASE + 0x00000014)
+#define CIF_ISP_IS_MAX_DX		(CIF_ISP_IS_BASE + 0x00000018)
+#define CIF_ISP_IS_MAX_DY		(CIF_ISP_IS_BASE + 0x0000001C)
+#define CIF_ISP_IS_DISPLACE		(CIF_ISP_IS_BASE + 0x00000020)
+#define CIF_ISP_IS_H_OFFS_SHD		(CIF_ISP_IS_BASE + 0x00000024)
+#define CIF_ISP_IS_V_OFFS_SHD		(CIF_ISP_IS_BASE + 0x00000028)
+#define CIF_ISP_IS_H_SIZE_SHD		(CIF_ISP_IS_BASE + 0x0000002C)
+#define CIF_ISP_IS_V_SIZE_SHD		(CIF_ISP_IS_BASE + 0x00000030)
+
+#define CIF_ISP_HIST_BASE		0x00002400
+
+#define CIF_ISP_HIST_PROP		(CIF_ISP_HIST_BASE + 0x00000000)
+#define CIF_ISP_HIST_H_OFFS		(CIF_ISP_HIST_BASE + 0x00000004)
+#define CIF_ISP_HIST_V_OFFS		(CIF_ISP_HIST_BASE + 0x00000008)
+#define CIF_ISP_HIST_H_SIZE		(CIF_ISP_HIST_BASE + 0x0000000C)
+#define CIF_ISP_HIST_V_SIZE		(CIF_ISP_HIST_BASE + 0x00000010)
+#define CIF_ISP_HIST_BIN_0		(CIF_ISP_HIST_BASE + 0x00000014)
+#define CIF_ISP_HIST_BIN_1		(CIF_ISP_HIST_BASE + 0x00000018)
+#define CIF_ISP_HIST_BIN_2		(CIF_ISP_HIST_BASE + 0x0000001C)
+#define CIF_ISP_HIST_BIN_3		(CIF_ISP_HIST_BASE + 0x00000020)
+#define CIF_ISP_HIST_BIN_4		(CIF_ISP_HIST_BASE + 0x00000024)
+#define CIF_ISP_HIST_BIN_5		(CIF_ISP_HIST_BASE + 0x00000028)
+#define CIF_ISP_HIST_BIN_6		(CIF_ISP_HIST_BASE + 0x0000002C)
+#define CIF_ISP_HIST_BIN_7		(CIF_ISP_HIST_BASE + 0x00000030)
+#define CIF_ISP_HIST_BIN_8		(CIF_ISP_HIST_BASE + 0x00000034)
+#define CIF_ISP_HIST_BIN_9		(CIF_ISP_HIST_BASE + 0x00000038)
+#define CIF_ISP_HIST_BIN_10		(CIF_ISP_HIST_BASE + 0x0000003C)
+#define CIF_ISP_HIST_BIN_11		(CIF_ISP_HIST_BASE + 0x00000040)
+#define CIF_ISP_HIST_BIN_12		(CIF_ISP_HIST_BASE + 0x00000044)
+#define CIF_ISP_HIST_BIN_13		(CIF_ISP_HIST_BASE + 0x00000048)
+#define CIF_ISP_HIST_BIN_14		(CIF_ISP_HIST_BASE + 0x0000004C)
+#define CIF_ISP_HIST_BIN_15		(CIF_ISP_HIST_BASE + 0x00000050)
+#define CIF_ISP_HIST_WEIGHT_00TO30	(CIF_ISP_HIST_BASE + 0x00000054)
+#define CIF_ISP_HIST_WEIGHT_40TO21	(CIF_ISP_HIST_BASE + 0x00000058)
+#define CIF_ISP_HIST_WEIGHT_31TO12	(CIF_ISP_HIST_BASE + 0x0000005C)
+#define CIF_ISP_HIST_WEIGHT_22TO03	(CIF_ISP_HIST_BASE + 0x00000060)
+#define CIF_ISP_HIST_WEIGHT_13TO43	(CIF_ISP_HIST_BASE + 0x00000064)
+#define CIF_ISP_HIST_WEIGHT_04TO34	(CIF_ISP_HIST_BASE + 0x00000068)
+#define CIF_ISP_HIST_WEIGHT_44		(CIF_ISP_HIST_BASE + 0x0000006C)
+
+#define CIF_ISP_FILT_BASE		0x00002500
+#define CIF_ISP_FILT_MODE		(CIF_ISP_FILT_BASE + 0x00000000)
+#define CIF_ISP_FILT_THRESH_BL0		(CIF_ISP_FILT_BASE + 0x00000028)
+#define CIF_ISP_FILT_THRESH_BL1		(CIF_ISP_FILT_BASE + 0x0000002c)
+#define CIF_ISP_FILT_THRESH_SH0		(CIF_ISP_FILT_BASE + 0x00000030)
+#define CIF_ISP_FILT_THRESH_SH1		(CIF_ISP_FILT_BASE + 0x00000034)
+#define CIF_ISP_FILT_LUM_WEIGHT		(CIF_ISP_FILT_BASE + 0x00000038)
+#define CIF_ISP_FILT_FAC_SH1		(CIF_ISP_FILT_BASE + 0x0000003c)
+#define CIF_ISP_FILT_FAC_SH0		(CIF_ISP_FILT_BASE + 0x00000040)
+#define CIF_ISP_FILT_FAC_MID		(CIF_ISP_FILT_BASE + 0x00000044)
+#define CIF_ISP_FILT_FAC_BL0		(CIF_ISP_FILT_BASE + 0x00000048)
+#define CIF_ISP_FILT_FAC_BL1		(CIF_ISP_FILT_BASE + 0x0000004C)
+
+#define CIF_ISP_CAC_BASE		0x00002580
+#define CIF_ISP_CAC_CTRL		(CIF_ISP_CAC_BASE + 0x00000000)
+#define CIF_ISP_CAC_COUNT_START		(CIF_ISP_CAC_BASE + 0x00000004)
+#define CIF_ISP_CAC_A			(CIF_ISP_CAC_BASE + 0x00000008)
+#define CIF_ISP_CAC_B			(CIF_ISP_CAC_BASE + 0x0000000C)
+#define CIF_ISP_CAC_C			(CIF_ISP_CAC_BASE + 0x00000010)
+#define CIF_ISP_X_NORM			(CIF_ISP_CAC_BASE + 0x00000014)
+#define CIF_ISP_Y_NORM			(CIF_ISP_CAC_BASE + 0x00000018)
+
+#define CIF_ISP_EXP_BASE		0x00002600
+#define CIF_ISP_EXP_CTRL		(CIF_ISP_EXP_BASE + 0x00000000)
+#define CIF_ISP_EXP_H_OFFSET		(CIF_ISP_EXP_BASE + 0x00000004)
+#define CIF_ISP_EXP_V_OFFSET		(CIF_ISP_EXP_BASE + 0x00000008)
+#define CIF_ISP_EXP_H_SIZE		(CIF_ISP_EXP_BASE + 0x0000000C)
+#define CIF_ISP_EXP_V_SIZE		(CIF_ISP_EXP_BASE + 0x00000010)
+#define CIF_ISP_EXP_MEAN_00		(CIF_ISP_EXP_BASE + 0x00000014)
+#define CIF_ISP_EXP_MEAN_10		(CIF_ISP_EXP_BASE + 0x00000018)
+#define CIF_ISP_EXP_MEAN_20		(CIF_ISP_EXP_BASE + 0x0000001c)
+#define CIF_ISP_EXP_MEAN_30		(CIF_ISP_EXP_BASE + 0x00000020)
+#define CIF_ISP_EXP_MEAN_40		(CIF_ISP_EXP_BASE + 0x00000024)
+#define CIF_ISP_EXP_MEAN_01		(CIF_ISP_EXP_BASE + 0x00000028)
+#define CIF_ISP_EXP_MEAN_11		(CIF_ISP_EXP_BASE + 0x0000002c)
+#define CIF_ISP_EXP_MEAN_21		(CIF_ISP_EXP_BASE + 0x00000030)
+#define CIF_ISP_EXP_MEAN_31		(CIF_ISP_EXP_BASE + 0x00000034)
+#define CIF_ISP_EXP_MEAN_41		(CIF_ISP_EXP_BASE + 0x00000038)
+#define CIF_ISP_EXP_MEAN_02		(CIF_ISP_EXP_BASE + 0x0000003c)
+#define CIF_ISP_EXP_MEAN_12		(CIF_ISP_EXP_BASE + 0x00000040)
+#define CIF_ISP_EXP_MEAN_22		(CIF_ISP_EXP_BASE + 0x00000044)
+#define CIF_ISP_EXP_MEAN_32		(CIF_ISP_EXP_BASE + 0x00000048)
+#define CIF_ISP_EXP_MEAN_42		(CIF_ISP_EXP_BASE + 0x0000004c)
+#define CIF_ISP_EXP_MEAN_03		(CIF_ISP_EXP_BASE + 0x00000050)
+#define CIF_ISP_EXP_MEAN_13		(CIF_ISP_EXP_BASE + 0x00000054)
+#define CIF_ISP_EXP_MEAN_23		(CIF_ISP_EXP_BASE + 0x00000058)
+#define CIF_ISP_EXP_MEAN_33		(CIF_ISP_EXP_BASE + 0x0000005c)
+#define CIF_ISP_EXP_MEAN_43		(CIF_ISP_EXP_BASE + 0x00000060)
+#define CIF_ISP_EXP_MEAN_04		(CIF_ISP_EXP_BASE + 0x00000064)
+#define CIF_ISP_EXP_MEAN_14		(CIF_ISP_EXP_BASE + 0x00000068)
+#define CIF_ISP_EXP_MEAN_24		(CIF_ISP_EXP_BASE + 0x0000006c)
+#define CIF_ISP_EXP_MEAN_34		(CIF_ISP_EXP_BASE + 0x00000070)
+#define CIF_ISP_EXP_MEAN_44		(CIF_ISP_EXP_BASE + 0x00000074)
+
+#define CIF_ISP_BLS_BASE		0x00002700
+#define CIF_ISP_BLS_CTRL		(CIF_ISP_BLS_BASE + 0x00000000)
+#define CIF_ISP_BLS_SAMPLES		(CIF_ISP_BLS_BASE + 0x00000004)
+#define CIF_ISP_BLS_H1_START		(CIF_ISP_BLS_BASE + 0x00000008)
+#define CIF_ISP_BLS_H1_STOP		(CIF_ISP_BLS_BASE + 0x0000000c)
+#define CIF_ISP_BLS_V1_START		(CIF_ISP_BLS_BASE + 0x00000010)
+#define CIF_ISP_BLS_V1_STOP		(CIF_ISP_BLS_BASE + 0x00000014)
+#define CIF_ISP_BLS_H2_START		(CIF_ISP_BLS_BASE + 0x00000018)
+#define CIF_ISP_BLS_H2_STOP		(CIF_ISP_BLS_BASE + 0x0000001c)
+#define CIF_ISP_BLS_V2_START		(CIF_ISP_BLS_BASE + 0x00000020)
+#define CIF_ISP_BLS_V2_STOP		(CIF_ISP_BLS_BASE + 0x00000024)
+#define CIF_ISP_BLS_A_FIXED		(CIF_ISP_BLS_BASE + 0x00000028)
+#define CIF_ISP_BLS_B_FIXED		(CIF_ISP_BLS_BASE + 0x0000002c)
+#define CIF_ISP_BLS_C_FIXED		(CIF_ISP_BLS_BASE + 0x00000030)
+#define CIF_ISP_BLS_D_FIXED		(CIF_ISP_BLS_BASE + 0x00000034)
+#define CIF_ISP_BLS_A_MEASURED		(CIF_ISP_BLS_BASE + 0x00000038)
+#define CIF_ISP_BLS_B_MEASURED		(CIF_ISP_BLS_BASE + 0x0000003c)
+#define CIF_ISP_BLS_C_MEASURED		(CIF_ISP_BLS_BASE + 0x00000040)
+#define CIF_ISP_BLS_D_MEASURED		(CIF_ISP_BLS_BASE + 0x00000044)
+
+#define CIF_ISP_DPF_BASE		0x00002800
+#define CIF_ISP_DPF_MODE		(CIF_ISP_DPF_BASE + 0x00000000)
+#define CIF_ISP_DPF_STRENGTH_R		(CIF_ISP_DPF_BASE + 0x00000004)
+#define CIF_ISP_DPF_STRENGTH_G		(CIF_ISP_DPF_BASE + 0x00000008)
+#define CIF_ISP_DPF_STRENGTH_B		(CIF_ISP_DPF_BASE + 0x0000000C)
+#define CIF_ISP_DPF_S_WEIGHT_G_1_4	(CIF_ISP_DPF_BASE + 0x00000010)
+#define CIF_ISP_DPF_S_WEIGHT_G_5_6	(CIF_ISP_DPF_BASE + 0x00000014)
+#define CIF_ISP_DPF_S_WEIGHT_RB_1_4	(CIF_ISP_DPF_BASE + 0x00000018)
+#define CIF_ISP_DPF_S_WEIGHT_RB_5_6	(CIF_ISP_DPF_BASE + 0x0000001C)
+#define CIF_ISP_DPF_NULL_COEFF_0	(CIF_ISP_DPF_BASE + 0x00000020)
+#define CIF_ISP_DPF_NULL_COEFF_1	(CIF_ISP_DPF_BASE + 0x00000024)
+#define CIF_ISP_DPF_NULL_COEFF_2	(CIF_ISP_DPF_BASE + 0x00000028)
+#define CIF_ISP_DPF_NULL_COEFF_3	(CIF_ISP_DPF_BASE + 0x0000002C)
+#define CIF_ISP_DPF_NULL_COEFF_4	(CIF_ISP_DPF_BASE + 0x00000030)
+#define CIF_ISP_DPF_NULL_COEFF_5	(CIF_ISP_DPF_BASE + 0x00000034)
+#define CIF_ISP_DPF_NULL_COEFF_6	(CIF_ISP_DPF_BASE + 0x00000038)
+#define CIF_ISP_DPF_NULL_COEFF_7	(CIF_ISP_DPF_BASE + 0x0000003C)
+#define CIF_ISP_DPF_NULL_COEFF_8	(CIF_ISP_DPF_BASE + 0x00000040)
+#define CIF_ISP_DPF_NULL_COEFF_9	(CIF_ISP_DPF_BASE + 0x00000044)
+#define CIF_ISP_DPF_NULL_COEFF_10	(CIF_ISP_DPF_BASE + 0x00000048)
+#define CIF_ISP_DPF_NULL_COEFF_11	(CIF_ISP_DPF_BASE + 0x0000004C)
+#define CIF_ISP_DPF_NULL_COEFF_12	(CIF_ISP_DPF_BASE + 0x00000050)
+#define CIF_ISP_DPF_NULL_COEFF_13	(CIF_ISP_DPF_BASE + 0x00000054)
+#define CIF_ISP_DPF_NULL_COEFF_14	(CIF_ISP_DPF_BASE + 0x00000058)
+#define CIF_ISP_DPF_NULL_COEFF_15	(CIF_ISP_DPF_BASE + 0x0000005C)
+#define CIF_ISP_DPF_NULL_COEFF_16	(CIF_ISP_DPF_BASE + 0x00000060)
+#define CIF_ISP_DPF_NF_GAIN_R		(CIF_ISP_DPF_BASE + 0x00000064)
+#define CIF_ISP_DPF_NF_GAIN_GR		(CIF_ISP_DPF_BASE + 0x00000068)
+#define CIF_ISP_DPF_NF_GAIN_GB		(CIF_ISP_DPF_BASE + 0x0000006C)
+#define CIF_ISP_DPF_NF_GAIN_B		(CIF_ISP_DPF_BASE + 0x00000070)
+
+#define CIF_ISP_DPCC_BASE		0x00002900
+#define CIF_ISP_DPCC_MODE		(CIF_ISP_DPCC_BASE + 0x00000000)
+#define CIF_ISP_DPCC_OUTPUT_MODE	(CIF_ISP_DPCC_BASE + 0x00000004)
+#define CIF_ISP_DPCC_SET_USE		(CIF_ISP_DPCC_BASE + 0x00000008)
+#define CIF_ISP_DPCC_METHODS_SET_1	(CIF_ISP_DPCC_BASE + 0x0000000C)
+#define CIF_ISP_DPCC_METHODS_SET_2	(CIF_ISP_DPCC_BASE + 0x00000010)
+#define CIF_ISP_DPCC_METHODS_SET_3	(CIF_ISP_DPCC_BASE + 0x00000014)
+#define CIF_ISP_DPCC_LINE_THRESH_1	(CIF_ISP_DPCC_BASE + 0x00000018)
+#define CIF_ISP_DPCC_LINE_MAD_FAC_1	(CIF_ISP_DPCC_BASE + 0x0000001C)
+#define CIF_ISP_DPCC_PG_FAC_1		(CIF_ISP_DPCC_BASE + 0x00000020)
+#define CIF_ISP_DPCC_RND_THRESH_1	(CIF_ISP_DPCC_BASE + 0x00000024)
+#define CIF_ISP_DPCC_RG_FAC_1		(CIF_ISP_DPCC_BASE + 0x00000028)
+#define CIF_ISP_DPCC_LINE_THRESH_2	(CIF_ISP_DPCC_BASE + 0x0000002C)
+#define CIF_ISP_DPCC_LINE_MAD_FAC_2	(CIF_ISP_DPCC_BASE + 0x00000030)
+#define CIF_ISP_DPCC_PG_FAC_2		(CIF_ISP_DPCC_BASE + 0x00000034)
+#define CIF_ISP_DPCC_RND_THRESH_2	(CIF_ISP_DPCC_BASE + 0x00000038)
+#define CIF_ISP_DPCC_RG_FAC_2		(CIF_ISP_DPCC_BASE + 0x0000003C)
+#define CIF_ISP_DPCC_LINE_THRESH_3	(CIF_ISP_DPCC_BASE + 0x00000040)
+#define CIF_ISP_DPCC_LINE_MAD_FAC_3	(CIF_ISP_DPCC_BASE + 0x00000044)
+#define CIF_ISP_DPCC_PG_FAC_3		(CIF_ISP_DPCC_BASE + 0x00000048)
+#define CIF_ISP_DPCC_RND_THRESH_3	(CIF_ISP_DPCC_BASE + 0x0000004C)
+#define CIF_ISP_DPCC_RG_FAC_3		(CIF_ISP_DPCC_BASE + 0x00000050)
+#define CIF_ISP_DPCC_RO_LIMITS		(CIF_ISP_DPCC_BASE + 0x00000054)
+#define CIF_ISP_DPCC_RND_OFFS		(CIF_ISP_DPCC_BASE + 0x00000058)
+#define CIF_ISP_DPCC_BPT_CTRL		(CIF_ISP_DPCC_BASE + 0x0000005C)
+#define CIF_ISP_DPCC_BPT_NUMBER		(CIF_ISP_DPCC_BASE + 0x00000060)
+#define CIF_ISP_DPCC_BPT_ADDR		(CIF_ISP_DPCC_BASE + 0x00000064)
+#define CIF_ISP_DPCC_BPT_DATA		(CIF_ISP_DPCC_BASE + 0x00000068)
+
+#define CIF_ISP_WDR_BASE		0x00002A00
+#define CIF_ISP_WDR_CTRL		(CIF_ISP_WDR_BASE + 0x00000000)
+#define CIF_ISP_WDR_TONECURVE_1		(CIF_ISP_WDR_BASE + 0x00000004)
+#define CIF_ISP_WDR_TONECURVE_2		(CIF_ISP_WDR_BASE + 0x00000008)
+#define CIF_ISP_WDR_TONECURVE_3		(CIF_ISP_WDR_BASE + 0x0000000C)
+#define CIF_ISP_WDR_TONECURVE_4		(CIF_ISP_WDR_BASE + 0x00000010)
+#define CIF_ISP_WDR_TONECURVE_YM_0	(CIF_ISP_WDR_BASE + 0x00000014)
+#define CIF_ISP_WDR_TONECURVE_YM_1	(CIF_ISP_WDR_BASE + 0x00000018)
+#define CIF_ISP_WDR_TONECURVE_YM_2	(CIF_ISP_WDR_BASE + 0x0000001C)
+#define CIF_ISP_WDR_TONECURVE_YM_3	(CIF_ISP_WDR_BASE + 0x00000020)
+#define CIF_ISP_WDR_TONECURVE_YM_4	(CIF_ISP_WDR_BASE + 0x00000024)
+#define CIF_ISP_WDR_TONECURVE_YM_5	(CIF_ISP_WDR_BASE + 0x00000028)
+#define CIF_ISP_WDR_TONECURVE_YM_6	(CIF_ISP_WDR_BASE + 0x0000002C)
+#define CIF_ISP_WDR_TONECURVE_YM_7	(CIF_ISP_WDR_BASE + 0x00000030)
+#define CIF_ISP_WDR_TONECURVE_YM_8	(CIF_ISP_WDR_BASE + 0x00000034)
+#define CIF_ISP_WDR_TONECURVE_YM_9	(CIF_ISP_WDR_BASE + 0x00000038)
+#define CIF_ISP_WDR_TONECURVE_YM_10	(CIF_ISP_WDR_BASE + 0x0000003C)
+#define CIF_ISP_WDR_TONECURVE_YM_11	(CIF_ISP_WDR_BASE + 0x00000040)
+#define CIF_ISP_WDR_TONECURVE_YM_12	(CIF_ISP_WDR_BASE + 0x00000044)
+#define CIF_ISP_WDR_TONECURVE_YM_13	(CIF_ISP_WDR_BASE + 0x00000048)
+#define CIF_ISP_WDR_TONECURVE_YM_14	(CIF_ISP_WDR_BASE + 0x0000004C)
+#define CIF_ISP_WDR_TONECURVE_YM_15	(CIF_ISP_WDR_BASE + 0x00000050)
+#define CIF_ISP_WDR_TONECURVE_YM_16	(CIF_ISP_WDR_BASE + 0x00000054)
+#define CIF_ISP_WDR_TONECURVE_YM_17	(CIF_ISP_WDR_BASE + 0x00000058)
+#define CIF_ISP_WDR_TONECURVE_YM_18	(CIF_ISP_WDR_BASE + 0x0000005C)
+#define CIF_ISP_WDR_TONECURVE_YM_19	(CIF_ISP_WDR_BASE + 0x00000060)
+#define CIF_ISP_WDR_TONECURVE_YM_20	(CIF_ISP_WDR_BASE + 0x00000064)
+#define CIF_ISP_WDR_TONECURVE_YM_21	(CIF_ISP_WDR_BASE + 0x00000068)
+#define CIF_ISP_WDR_TONECURVE_YM_22	(CIF_ISP_WDR_BASE + 0x0000006C)
+#define CIF_ISP_WDR_TONECURVE_YM_23	(CIF_ISP_WDR_BASE + 0x00000070)
+#define CIF_ISP_WDR_TONECURVE_YM_24	(CIF_ISP_WDR_BASE + 0x00000074)
+#define CIF_ISP_WDR_TONECURVE_YM_25	(CIF_ISP_WDR_BASE + 0x00000078)
+#define CIF_ISP_WDR_TONECURVE_YM_26	(CIF_ISP_WDR_BASE + 0x0000007C)
+#define CIF_ISP_WDR_TONECURVE_YM_27	(CIF_ISP_WDR_BASE + 0x00000080)
+#define CIF_ISP_WDR_TONECURVE_YM_28	(CIF_ISP_WDR_BASE + 0x00000084)
+#define CIF_ISP_WDR_TONECURVE_YM_29	(CIF_ISP_WDR_BASE + 0x00000088)
+#define CIF_ISP_WDR_TONECURVE_YM_30	(CIF_ISP_WDR_BASE + 0x0000008C)
+#define CIF_ISP_WDR_TONECURVE_YM_31	(CIF_ISP_WDR_BASE + 0x00000090)
+#define CIF_ISP_WDR_TONECURVE_YM_32	(CIF_ISP_WDR_BASE + 0x00000094)
+#define CIF_ISP_WDR_OFFSET		(CIF_ISP_WDR_BASE + 0x00000098)
+#define CIF_ISP_WDR_DELTAMIN		(CIF_ISP_WDR_BASE + 0x0000009C)
+#define CIF_ISP_WDR_TONECURVE_1_SHD	(CIF_ISP_WDR_BASE + 0x000000A0)
+#define CIF_ISP_WDR_TONECURVE_2_SHD	(CIF_ISP_WDR_BASE + 0x000000A4)
+#define CIF_ISP_WDR_TONECURVE_3_SHD	(CIF_ISP_WDR_BASE + 0x000000A8)
+#define CIF_ISP_WDR_TONECURVE_4_SHD	(CIF_ISP_WDR_BASE + 0x000000AC)
+#define CIF_ISP_WDR_TONECURVE_YM_0_SHD	(CIF_ISP_WDR_BASE + 0x000000B0)
+#define CIF_ISP_WDR_TONECURVE_YM_1_SHD	(CIF_ISP_WDR_BASE + 0x000000B4)
+#define CIF_ISP_WDR_TONECURVE_YM_2_SHD	(CIF_ISP_WDR_BASE + 0x000000B8)
+#define CIF_ISP_WDR_TONECURVE_YM_3_SHD	(CIF_ISP_WDR_BASE + 0x000000BC)
+#define CIF_ISP_WDR_TONECURVE_YM_4_SHD	(CIF_ISP_WDR_BASE + 0x000000C0)
+#define CIF_ISP_WDR_TONECURVE_YM_5_SHD	(CIF_ISP_WDR_BASE + 0x000000C4)
+#define CIF_ISP_WDR_TONECURVE_YM_6_SHD	(CIF_ISP_WDR_BASE + 0x000000C8)
+#define CIF_ISP_WDR_TONECURVE_YM_7_SHD	(CIF_ISP_WDR_BASE + 0x000000CC)
+#define CIF_ISP_WDR_TONECURVE_YM_8_SHD	(CIF_ISP_WDR_BASE + 0x000000D0)
+#define CIF_ISP_WDR_TONECURVE_YM_9_SHD	(CIF_ISP_WDR_BASE + 0x000000D4)
+#define CIF_ISP_WDR_TONECURVE_YM_10_SHD	(CIF_ISP_WDR_BASE + 0x000000D8)
+#define CIF_ISP_WDR_TONECURVE_YM_11_SHD	(CIF_ISP_WDR_BASE + 0x000000DC)
+#define CIF_ISP_WDR_TONECURVE_YM_12_SHD	(CIF_ISP_WDR_BASE + 0x000000E0)
+#define CIF_ISP_WDR_TONECURVE_YM_13_SHD	(CIF_ISP_WDR_BASE + 0x000000E4)
+#define CIF_ISP_WDR_TONECURVE_YM_14_SHD	(CIF_ISP_WDR_BASE + 0x000000E8)
+#define CIF_ISP_WDR_TONECURVE_YM_15_SHD	(CIF_ISP_WDR_BASE + 0x000000EC)
+#define CIF_ISP_WDR_TONECURVE_YM_16_SHD	(CIF_ISP_WDR_BASE + 0x000000F0)
+#define CIF_ISP_WDR_TONECURVE_YM_17_SHD	(CIF_ISP_WDR_BASE + 0x000000F4)
+#define CIF_ISP_WDR_TONECURVE_YM_18_SHD	(CIF_ISP_WDR_BASE + 0x000000F8)
+#define CIF_ISP_WDR_TONECURVE_YM_19_SHD	(CIF_ISP_WDR_BASE + 0x000000FC)
+#define CIF_ISP_WDR_TONECURVE_YM_20_SHD	(CIF_ISP_WDR_BASE + 0x00000100)
+#define CIF_ISP_WDR_TONECURVE_YM_21_SHD	(CIF_ISP_WDR_BASE + 0x00000104)
+#define CIF_ISP_WDR_TONECURVE_YM_22_SHD	(CIF_ISP_WDR_BASE + 0x00000108)
+#define CIF_ISP_WDR_TONECURVE_YM_23_SHD	(CIF_ISP_WDR_BASE + 0x0000010C)
+#define CIF_ISP_WDR_TONECURVE_YM_24_SHD	(CIF_ISP_WDR_BASE + 0x00000110)
+#define CIF_ISP_WDR_TONECURVE_YM_25_SHD	(CIF_ISP_WDR_BASE + 0x00000114)
+#define CIF_ISP_WDR_TONECURVE_YM_26_SHD	(CIF_ISP_WDR_BASE + 0x00000118)
+#define CIF_ISP_WDR_TONECURVE_YM_27_SHD	(CIF_ISP_WDR_BASE + 0x0000011C)
+#define CIF_ISP_WDR_TONECURVE_YM_28_SHD	(CIF_ISP_WDR_BASE + 0x00000120)
+#define CIF_ISP_WDR_TONECURVE_YM_29_SHD	(CIF_ISP_WDR_BASE + 0x00000124)
+#define CIF_ISP_WDR_TONECURVE_YM_30_SHD	(CIF_ISP_WDR_BASE + 0x00000128)
+#define CIF_ISP_WDR_TONECURVE_YM_31_SHD	(CIF_ISP_WDR_BASE + 0x0000012C)
+#define CIF_ISP_WDR_TONECURVE_YM_32_SHD	(CIF_ISP_WDR_BASE + 0x00000130)
+
+#define CIF_ISP_VSM_BASE		0x00002F00
+#define CIF_ISP_VSM_MODE		(CIF_ISP_VSM_BASE + 0x00000000)
+#define CIF_ISP_VSM_H_OFFS		(CIF_ISP_VSM_BASE + 0x00000004)
+#define CIF_ISP_VSM_V_OFFS		(CIF_ISP_VSM_BASE + 0x00000008)
+#define CIF_ISP_VSM_H_SIZE		(CIF_ISP_VSM_BASE + 0x0000000C)
+#define CIF_ISP_VSM_V_SIZE		(CIF_ISP_VSM_BASE + 0x00000010)
+#define CIF_ISP_VSM_H_SEGMENTS		(CIF_ISP_VSM_BASE + 0x00000014)
+#define CIF_ISP_VSM_V_SEGMENTS		(CIF_ISP_VSM_BASE + 0x00000018)
+#define CIF_ISP_VSM_DELTA_H		(CIF_ISP_VSM_BASE + 0x0000001C)
+#define CIF_ISP_VSM_DELTA_V		(CIF_ISP_VSM_BASE + 0x00000020)
+
+void disable_dcrop(struct rkisp1_stream *stream, bool async);
+void config_dcrop(struct rkisp1_stream *stream, struct v4l2_rect *rect,
+		  bool async);
+
+void dump_rsz_regs(struct device *dev, struct rkisp1_stream *stream);
+void disable_rsz(struct rkisp1_stream *stream, bool async);
+void config_rsz(struct rkisp1_stream *stream, struct v4l2_rect *in_y,
+		struct v4l2_rect *in_c, struct v4l2_rect *out_y,
+		struct v4l2_rect *out_c, bool async);
+
+void config_mi_ctrl(struct rkisp1_stream *stream);
+
+void mp_clr_frame_end_int(void __iomem *base);
+void sp_clr_frame_end_int(void __iomem *base);
+
+bool mp_is_frame_end_int_masked(void __iomem *base);
+bool sp_is_frame_end_int_masked(void __iomem *base);
+bool mp_is_stream_stopped(void __iomem *base);
+bool sp_is_stream_stopped(void __iomem *base);
+
+static inline void mi_set_y_size(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.y_size_init);
+}
+
+static inline void mi_set_cb_size(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cb_size_init);
+}
+
+static inline void mi_set_cr_size(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cr_size_init);
+}
+
+static inline void mi_set_y_addr(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.y_base_ad_init);
+}
+
+static inline void mi_set_cb_addr(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cb_base_ad_init);
+}
+
+static inline void mi_set_cr_addr(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cr_base_ad_init);
+}
+
+static inline void mi_set_y_offset(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.y_offs_cnt_init);
+}
+
+static inline void mi_set_cb_offset(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cb_offs_cnt_init);
+}
+
+static inline void mi_set_cr_offset(struct rkisp1_stream *stream, int val)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+
+	writel(val, base + stream->config->mi.cr_offs_cnt_init);
+}
+
+static inline void mi_frame_end_int_enable(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *addr = base + CIF_MI_IMSC;
+
+	writel(CIF_MI_FRAME(stream) | readl(addr), addr);
+}
+
+static inline void mi_frame_end_int_disable(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *addr = base + CIF_MI_IMSC;
+
+	writel(~CIF_MI_FRAME(stream) & readl(addr), addr);
+}
+
+static inline void mi_frame_end_int_clear(struct rkisp1_stream *stream)
+{
+	void __iomem *base = stream->ispdev->base_addr;
+	void __iomem *addr = base + CIF_MI_ICR;
+
+	writel(CIF_MI_FRAME(stream), addr);
+}
+
+static inline void mp_set_chain_mode(void __iomem *base)
+{
+	u32 dpcl = readl(base + CIF_VI_DPCL);
+
+	dpcl |= CIF_VI_DPCL_CHAN_MODE_MP;
+	writel(dpcl, base + CIF_VI_DPCL);
+}
+
+static inline void sp_set_chain_mode(void __iomem *base)
+{
+	u32 dpcl = readl(base + CIF_VI_DPCL);
+
+	dpcl |= CIF_VI_DPCL_CHAN_MODE_SP;
+	writel(dpcl, base + CIF_VI_DPCL);
+}
+
+static inline void mp_set_data_path(void __iomem *base)
+{
+	u32 dpcl = readl(base + CIF_VI_DPCL);
+
+	dpcl = dpcl | CIF_VI_DPCL_CHAN_MODE_MP | CIF_VI_DPCL_MP_MUX_MRSZ_MI;
+	writel(dpcl, base + CIF_VI_DPCL);
+}
+
+static inline void sp_set_data_path(void __iomem *base)
+{
+	u32 dpcl = readl(base + CIF_VI_DPCL);
+
+	dpcl |= CIF_VI_DPCL_CHAN_MODE_SP;
+	writel(dpcl, base + CIF_VI_DPCL);
+}
+
+static inline void mp_set_uv_swap(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_XTD_FORMAT_CTRL;
+	u32 reg = readl(addr) & ~BIT(0);
+
+	writel(reg | CIF_MI_XTD_FMT_CTRL_MP_CB_CR_SWAP, addr);
+}
+
+static inline void sp_set_uv_swap(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_XTD_FORMAT_CTRL;
+	u32 reg = readl(addr) & ~BIT(1);
+
+	writel(reg | CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP, addr);
+}
+
+static inline void sp_set_y_width(void __iomem *base, u32 val)
+{
+	writel(val, base + CIF_MI_SP_Y_PIC_WIDTH);
+}
+
+static inline void sp_set_y_height(void __iomem *base, u32 val)
+{
+	writel(val, base + CIF_MI_SP_Y_PIC_HEIGHT);
+}
+
+static inline void sp_set_y_line_length(void __iomem *base, u32 val)
+{
+	writel(val, base + CIF_MI_SP_Y_LLENGTH);
+}
+
+static inline void mp_mi_ctrl_set_format(void __iomem *base, u32 val)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+	u32 reg = readl(addr) & ~MI_CTRL_MP_FMT_MASK;
+
+	writel(reg | val, addr);
+}
+
+static inline void sp_mi_ctrl_set_format(void __iomem *base, u32 val)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+	u32 reg = readl(addr) & ~MI_CTRL_SP_FMT_MASK;
+
+	writel(reg | val, addr);
+}
+
+static inline void mi_ctrl_mpyuv_enable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(CIF_MI_CTRL_MP_ENABLE | readl(addr), addr);
+}
+
+static inline void mi_ctrl_mpyuv_disable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(~CIF_MI_CTRL_MP_ENABLE & readl(addr), addr);
+}
+
+static inline void mi_ctrl_mp_disable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(~(CIF_MI_CTRL_MP_ENABLE | CIF_MI_CTRL_RAW_ENABLE) & readl(addr),
+	       addr);
+}
+
+static inline void mi_ctrl_spyuv_enable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(CIF_MI_CTRL_SP_ENABLE | readl(addr), addr);
+}
+
+static inline void mi_ctrl_spyuv_disable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(~CIF_MI_CTRL_SP_ENABLE & readl(addr), addr);
+}
+
+static inline void mi_ctrl_sp_disable(void __iomem *base)
+{
+	mi_ctrl_spyuv_disable(base);
+}
+
+static inline void mi_ctrl_mpraw_enable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(CIF_MI_CTRL_RAW_ENABLE | readl(addr), addr);
+}
+
+static inline void mi_ctrl_mpraw_disable(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(~CIF_MI_CTRL_RAW_ENABLE & readl(addr), addr);
+}
+
+static inline void mp_mi_ctrl_autoupdate_en(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(readl(addr) | CIF_MI_MP_AUTOUPDATE_ENABLE, addr);
+}
+
+static inline void sp_mi_ctrl_autoupdate_en(void __iomem *base)
+{
+	void __iomem *addr = base + CIF_MI_CTRL;
+
+	writel(readl(addr) | CIF_MI_SP_AUTOUPDATE_ENABLE, addr);
+}
+
+static inline void force_cfg_update(void __iomem *base)
+{
+	writel(CIF_MI_INIT_SOFT_UPD, base + CIF_MI_INIT);
+}
+
+#endif /* _RKISP1_REGS_H */
diff --git a/drivers/staging/media/rkisp1/rkisp1.c b/drivers/staging/media/rkisp1/rkisp1.c
new file mode 100644
index 000000000000..954bff30a91f
--- /dev/null
+++ b/drivers/staging/media/rkisp1/rkisp1.c
@@ -0,0 +1,1246 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Rockchip ISP1 Driver - ISP Subdevice
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#include <linux/iopoll.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <linux/vmalloc.h>
+#include <media/v4l2-event.h>
+
+#include "common.h"
+#include "regs.h"
+
+#define CIF_ISP_INPUT_W_MAX		4032
+#define CIF_ISP_INPUT_H_MAX		3024
+#define CIF_ISP_INPUT_W_MIN		32
+#define CIF_ISP_INPUT_H_MIN		32
+#define CIF_ISP_OUTPUT_W_MAX		CIF_ISP_INPUT_W_MAX
+#define CIF_ISP_OUTPUT_H_MAX		CIF_ISP_INPUT_H_MAX
+#define CIF_ISP_OUTPUT_W_MIN		CIF_ISP_INPUT_W_MIN
+#define CIF_ISP_OUTPUT_H_MIN		CIF_ISP_INPUT_H_MIN
+
+#define RKISP1_DEF_SINK_PAD_FMT MEDIA_BUS_FMT_SRGGB10_1X10
+#define RKISP1_DEF_SRC_PAD_FMT MEDIA_BUS_FMT_YUYV8_2X8
+
+/*
+ * NOTE: MIPI controller and input MUX are also configured in this file,
+ * because ISP Subdev is not only describe ISP submodule(input size,format,
+ * output size, format), but also a virtual route device.
+ */
+
+/*
+ * There are many variables named with format/frame in below code,
+ * please see here for their meaning.
+ *
+ * Cropping regions of ISP
+ *
+ * +---------------------------------------------------------+
+ * | Sensor image                                            |
+ * | +---------------------------------------------------+   |
+ * | | ISP_ACQ (for black level)                         |   |
+ * | | in_frm                                            |   |
+ * | | +--------------------------------------------+    |   |
+ * | | |    ISP_OUT                                 |    |   |
+ * | | |    in_crop                                 |    |   |
+ * | | |    +---------------------------------+     |    |   |
+ * | | |    |   ISP_IS                        |     |    |   |
+ * | | |    |   rkisp1_isp_subdev: out_crop   |     |    |   |
+ * | | |    +---------------------------------+     |    |   |
+ * | | +--------------------------------------------+    |   |
+ * | +---------------------------------------------------+   |
+ * +---------------------------------------------------------+
+ */
+
+static inline struct rkisp1_device *sd_to_isp_dev(struct v4l2_subdev *sd)
+{
+	return container_of(sd->v4l2_dev, struct rkisp1_device, v4l2_dev);
+}
+
+/* Get sensor by enabled media link */
+static struct v4l2_subdev *get_remote_sensor(struct v4l2_subdev *sd)
+{
+	struct media_pad *local, *remote;
+	struct media_entity *sensor_me;
+
+	local = &sd->entity.pads[RKISP1_ISP_PAD_SINK_VIDEO];
+	remote = media_entity_remote_pad(local);
+	if (!remote) {
+		dev_warn(sd->dev, "No link between isp and sensor\n");
+		return NULL;
+	}
+
+	sensor_me = remote->entity;
+	return media_entity_to_v4l2_subdev(sensor_me);
+}
+
+/****************  register operations ****************/
+
+static inline void regwrite(struct rkisp1_device *dev, u32 val,
+			    unsigned int addr)
+{
+	writel(val, dev->base_addr + addr);
+}
+
+static inline u32 regread(struct rkisp1_device *dev, unsigned int addr)
+{
+	return readl(dev->base_addr + addr);
+}
+
+struct v4l2_mbus_framefmt *
+rkisp1_isp_sd_get_pad_fmt(struct rkisp1_isp_subdev *isp_sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  unsigned int pad, u32 which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&isp_sd->sd, cfg, pad);
+	else
+		return v4l2_subdev_get_try_format(&isp_sd->sd,
+						  isp_sd->pad_cfg, pad);
+}
+
+struct v4l2_rect *rkisp1_isp_sd_get_pad_crop(struct rkisp1_isp_subdev *isp_sd,
+					     struct v4l2_subdev_pad_config *cfg,
+					     unsigned int pad, u32 which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&isp_sd->sd, cfg, pad);
+	else
+		return v4l2_subdev_get_try_crop(&isp_sd->sd,
+						isp_sd->pad_cfg, pad);
+}
+
+/*
+ * Image Stabilization.
+ * This should only be called when configuring CIF
+ * or at the frame end interrupt
+ */
+static void rkisp1_config_ism(struct rkisp1_device *dev)
+{
+	struct v4l2_rect *out_crop =
+		rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					   RKISP1_ISP_PAD_SOURCE_VIDEO,
+					   V4L2_SUBDEV_FORMAT_ACTIVE);
+	u32 val;
+
+	regwrite(dev, 0, CIF_ISP_IS_RECENTER);
+	regwrite(dev, 0, CIF_ISP_IS_MAX_DX);
+	regwrite(dev, 0, CIF_ISP_IS_MAX_DY);
+	regwrite(dev, 0, CIF_ISP_IS_DISPLACE);
+	regwrite(dev, out_crop->left, CIF_ISP_IS_H_OFFS);
+	regwrite(dev, out_crop->top, CIF_ISP_IS_V_OFFS);
+	regwrite(dev, out_crop->width, CIF_ISP_IS_H_SIZE);
+	regwrite(dev, out_crop->height, CIF_ISP_IS_V_SIZE);
+
+	/* IS(Image Stabilization) is always on, working as output crop */
+	regwrite(dev, 1, CIF_ISP_IS_CTRL);
+	val = regread(dev, CIF_ISP_CTRL);
+	val |= CIF_ISP_CTRL_ISP_CFG_UPD;
+	regwrite(dev, val, CIF_ISP_CTRL);
+}
+
+/*
+ * configure ISP blocks with input format, size......
+ */
+static int rkisp1_config_isp(struct rkisp1_device *dev)
+{
+	u32 isp_ctrl = 0, irq_mask = 0, acq_mult = 0, signal = 0;
+	const struct rkisp1_fmt *out_fmt, *in_fmt;
+	struct v4l2_rect *out_crop, *in_crop;
+	struct sensor_async_subdev *sensor;
+	struct v4l2_mbus_framefmt *in_frm;
+
+	sensor = dev->active_sensor;
+	in_fmt = dev->isp_sdev.in_fmt;
+	out_fmt = dev->isp_sdev.out_fmt;
+	in_frm = rkisp1_isp_sd_get_pad_fmt(&dev->isp_sdev, NULL,
+					   RKISP1_ISP_PAD_SINK_VIDEO,
+					   V4L2_SUBDEV_FORMAT_ACTIVE);
+	out_crop = rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					      RKISP1_ISP_PAD_SOURCE_VIDEO,
+					      V4L2_SUBDEV_FORMAT_ACTIVE);
+	in_crop = rkisp1_isp_sd_get_pad_crop(&dev->isp_sdev, NULL,
+					     RKISP1_ISP_PAD_SINK_VIDEO,
+					     V4L2_SUBDEV_FORMAT_ACTIVE);
+
+	if (in_fmt->fmt_type == FMT_BAYER) {
+		acq_mult = 1;
+		if (out_fmt->fmt_type == FMT_BAYER) {
+			if (sensor->mbus.type == V4L2_MBUS_BT656)
+				isp_ctrl =
+					CIF_ISP_CTRL_ISP_MODE_RAW_PICT_ITU656;
+			else
+				isp_ctrl =
+					CIF_ISP_CTRL_ISP_MODE_RAW_PICT;
+		} else {
+			regwrite(dev, CIF_ISP_DEMOSAIC_TH(0xc),
+				 CIF_ISP_DEMOSAIC);
+
+			if (sensor->mbus.type == V4L2_MBUS_BT656)
+				isp_ctrl = CIF_ISP_CTRL_ISP_MODE_BAYER_ITU656;
+			else
+				isp_ctrl = CIF_ISP_CTRL_ISP_MODE_BAYER_ITU601;
+		}
+	} else if (in_fmt->fmt_type == FMT_YUV) {
+		acq_mult = 2;
+		if (sensor->mbus.type == V4L2_MBUS_CSI2_DPHY) {
+			isp_ctrl = CIF_ISP_CTRL_ISP_MODE_ITU601;
+		} else {
+			if (sensor->mbus.type == V4L2_MBUS_BT656)
+				isp_ctrl = CIF_ISP_CTRL_ISP_MODE_ITU656;
+			else
+				isp_ctrl = CIF_ISP_CTRL_ISP_MODE_ITU601;
+
+		}
+
+		irq_mask |= CIF_ISP_DATA_LOSS;
+	}
+
+	/* Set up input acquisition properties */
+	if (sensor->mbus.type == V4L2_MBUS_BT656 ||
+	    sensor->mbus.type == V4L2_MBUS_PARALLEL) {
+		if (sensor->mbus.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+			signal = CIF_ISP_ACQ_PROP_POS_EDGE;
+	}
+
+	if (sensor->mbus.type == V4L2_MBUS_PARALLEL) {
+		if (sensor->mbus.flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			signal |= CIF_ISP_ACQ_PROP_VSYNC_LOW;
+
+		if (sensor->mbus.flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+			signal |= CIF_ISP_ACQ_PROP_HSYNC_LOW;
+	}
+
+	regwrite(dev, isp_ctrl, CIF_ISP_CTRL);
+	regwrite(dev, signal | in_fmt->yuv_seq |
+		 CIF_ISP_ACQ_PROP_BAYER_PAT(in_fmt->bayer_pat) |
+		 CIF_ISP_ACQ_PROP_FIELD_SEL_ALL, CIF_ISP_ACQ_PROP);
+	regwrite(dev, 0, CIF_ISP_ACQ_NR_FRAMES);
+
+	/* Acquisition Size */
+	regwrite(dev, 0, CIF_ISP_ACQ_H_OFFS);
+	regwrite(dev, 0, CIF_ISP_ACQ_V_OFFS);
+	regwrite(dev, acq_mult * in_frm->width, CIF_ISP_ACQ_H_SIZE);
+	regwrite(dev, in_frm->height, CIF_ISP_ACQ_V_SIZE);
+
+	/* ISP Out Area */
+	regwrite(dev, in_crop->left, CIF_ISP_OUT_H_OFFS);
+	regwrite(dev, in_crop->top, CIF_ISP_OUT_V_OFFS);
+	regwrite(dev, in_crop->width, CIF_ISP_OUT_H_SIZE);
+	regwrite(dev, in_crop->height, CIF_ISP_OUT_V_SIZE);
+
+	/* interrupt mask */
+	irq_mask |= CIF_ISP_FRAME | CIF_ISP_V_START | CIF_ISP_PIC_SIZE_ERROR |
+		    CIF_ISP_FRAME_IN;
+	regwrite(dev, irq_mask, CIF_ISP_IMSC);
+
+	if (out_fmt->fmt_type == FMT_BAYER) {
+		rkisp1_params_disable_isp(&dev->params_vdev);
+	} else {
+		struct v4l2_mbus_framefmt *out_frm;
+
+		out_frm = rkisp1_isp_sd_get_pad_fmt(&dev->isp_sdev, NULL,
+						    RKISP1_ISP_PAD_SINK_VIDEO,
+						    V4L2_SUBDEV_FORMAT_ACTIVE);
+		rkisp1_params_configure_isp(&dev->params_vdev, in_fmt,
+					    out_frm->quantization);
+	}
+
+	return 0;
+}
+
+static int rkisp1_config_dvp(struct rkisp1_device *dev)
+{
+	const struct rkisp1_fmt *in_fmt = dev->isp_sdev.in_fmt;
+	u32 val, input_sel;
+
+	switch (in_fmt->bus_width) {
+	case 8:
+		input_sel = CIF_ISP_ACQ_PROP_IN_SEL_8B_ZERO;
+		break;
+	case 10:
+		input_sel = CIF_ISP_ACQ_PROP_IN_SEL_10B_ZERO;
+		break;
+	case 12:
+		input_sel = CIF_ISP_ACQ_PROP_IN_SEL_12B;
+		break;
+	default:
+		dev_err(dev->dev, "Invalid bus width\n");
+		return -EINVAL;
+	}
+
+	val = regread(dev, CIF_ISP_ACQ_PROP);
+	regwrite(dev, val | input_sel, CIF_ISP_ACQ_PROP);
+
+	return 0;
+}
+
+static int rkisp1_config_mipi(struct rkisp1_device *dev)
+{
+	const struct rkisp1_fmt *in_fmt = dev->isp_sdev.in_fmt;
+	unsigned int lanes;
+	u32 mipi_ctrl;
+
+	/*
+	 * dev->active_sensor->mbus is set in isp or d-phy notifier_bound function
+	 */
+	switch (dev->active_sensor->mbus.flags & V4L2_MBUS_CSI2_LANES) {
+	case V4L2_MBUS_CSI2_4_LANE:
+		lanes = 4;
+		break;
+	case V4L2_MBUS_CSI2_3_LANE:
+		lanes = 3;
+		break;
+	case V4L2_MBUS_CSI2_2_LANE:
+		lanes = 2;
+		break;
+	case V4L2_MBUS_CSI2_1_LANE:
+		lanes = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mipi_ctrl = CIF_MIPI_CTRL_NUM_LANES(lanes - 1) |
+		    CIF_MIPI_CTRL_SHUTDOWNLANES(0xf) |
+		    CIF_MIPI_CTRL_ERR_SOT_SYNC_HS_SKIP |
+		    CIF_MIPI_CTRL_CLOCKLANE_ENA;
+
+	regwrite(dev, mipi_ctrl, CIF_MIPI_CTRL);
+
+	/* Configure Data Type and Virtual Channel */
+	regwrite(dev, CIF_MIPI_DATA_SEL_DT(in_fmt->mipi_dt) |
+		 CIF_MIPI_DATA_SEL_VC(0),
+		 CIF_MIPI_IMG_DATA_SEL);
+
+	/* Clear MIPI interrupts */
+	regwrite(dev, ~0, CIF_MIPI_ICR);
+	/*
+	 * Disable CIF_MIPI_ERR_DPHY interrupt here temporary for
+	 * isp bus may be dead when switch isp.
+	 */
+	regwrite(dev,
+		 CIF_MIPI_FRAME_END | CIF_MIPI_ERR_CSI | CIF_MIPI_ERR_DPHY |
+		 CIF_MIPI_SYNC_FIFO_OVFLW(0x03) | CIF_MIPI_ADD_DATA_OVFLW,
+		 CIF_MIPI_IMSC);
+
+	dev_dbg(dev->dev, "\n  MIPI_CTRL 0x%08x\n"
+		"  MIPI_IMG_DATA_SEL 0x%08x\n"
+		"  MIPI_STATUS 0x%08x\n"
+		"  MIPI_IMSC 0x%08x\n",
+		regread(dev, CIF_MIPI_CTRL),
+		regread(dev, CIF_MIPI_IMG_DATA_SEL),
+		regread(dev, CIF_MIPI_STATUS),
+		regread(dev, CIF_MIPI_IMSC));
+
+	return 0;
+}
+
+/* Configure MUX */
+static int rkisp1_config_path(struct rkisp1_device *dev)
+{
+	struct sensor_async_subdev *sensor = dev->active_sensor;
+	u32 dpcl = regread(dev, CIF_VI_DPCL);
+	int ret = 0;
+
+	if (sensor->mbus.type == V4L2_MBUS_BT656 ||
+	    sensor->mbus.type == V4L2_MBUS_PARALLEL) {
+		ret = rkisp1_config_dvp(dev);
+		dpcl |= CIF_VI_DPCL_IF_SEL_PARALLEL;
+	} else if (sensor->mbus.type == V4L2_MBUS_CSI2_DPHY) {
+		ret = rkisp1_config_mipi(dev);
+		dpcl |= CIF_VI_DPCL_IF_SEL_MIPI;
+	}
+
+	regwrite(dev, dpcl, CIF_VI_DPCL);
+
+	return ret;
+}
+
+/* Hardware configure Entry */
+static int rkisp1_config_cif(struct rkisp1_device *dev)
+{
+	u32 cif_id;
+	int ret;
+
+	dev_dbg(dev->dev, "SP streaming = %d, MP streaming = %d\n",
+		dev->stream[RKISP1_STREAM_SP].streaming,
+		dev->stream[RKISP1_STREAM_MP].streaming);
+
+	cif_id = regread(dev, CIF_VI_ID);
+	dev_dbg(dev->dev, "CIF_ID 0x%08x\n", cif_id);
+
+	ret = rkisp1_config_isp(dev);
+	if (ret < 0)
+		return ret;
+	ret = rkisp1_config_path(dev);
+	if (ret < 0)
+		return ret;
+	rkisp1_config_ism(dev);
+
+	return 0;
+}
+
+/* Mess register operations to stop ISP */
+static int rkisp1_isp_stop(struct rkisp1_device *dev)
+{
+	u32 val;
+
+	dev_dbg(dev->dev, "SP streaming = %d, MP streaming = %d\n",
+		dev->stream[RKISP1_STREAM_SP].streaming,
+		dev->stream[RKISP1_STREAM_MP].streaming);
+
+	/*
+	 * ISP(mi) stop in mi frame end -> Stop ISP(mipi) ->
+	 * Stop ISP(isp) ->wait for ISP isp off
+	 */
+	/* stop and clear MI, MIPI, and ISP interrupts */
+	regwrite(dev, 0, CIF_MIPI_IMSC);
+	regwrite(dev, ~0, CIF_MIPI_ICR);
+
+	regwrite(dev, 0, CIF_ISP_IMSC);
+	regwrite(dev, ~0, CIF_ISP_ICR);
+
+	regwrite(dev, 0, CIF_MI_IMSC);
+	regwrite(dev, ~0, CIF_MI_ICR);
+	val = regread(dev, CIF_MIPI_CTRL);
+	regwrite(dev, val & (~CIF_MIPI_CTRL_OUTPUT_ENA), CIF_MIPI_CTRL);
+	/* stop ISP */
+	val = regread(dev, CIF_ISP_CTRL);
+	val &= ~(CIF_ISP_CTRL_ISP_INFORM_ENABLE | CIF_ISP_CTRL_ISP_ENABLE);
+	regwrite(dev, val, CIF_ISP_CTRL);
+
+	val = regread(dev, CIF_ISP_CTRL);
+	regwrite(dev, val | CIF_ISP_CTRL_ISP_CFG_UPD, CIF_ISP_CTRL);
+
+	readx_poll_timeout(readl, dev->base_addr + CIF_ISP_RIS,
+			   val, val & CIF_ISP_OFF, 20, 100);
+	dev_dbg(dev->dev,
+		"streaming(MP:%d, SP:%d), MI_CTRL:%x, ISP_CTRL:%x, MIPI_CTRL:%x\n",
+		dev->stream[RKISP1_STREAM_SP].streaming,
+		dev->stream[RKISP1_STREAM_MP].streaming,
+		regread(dev, CIF_MI_CTRL),
+		regread(dev, CIF_ISP_CTRL),
+		regread(dev, CIF_MIPI_CTRL));
+
+	regwrite(dev, CIF_IRCL_MIPI_SW_RST | CIF_IRCL_ISP_SW_RST, CIF_IRCL);
+	regwrite(dev, 0x0, CIF_IRCL);
+
+	return 0;
+}
+
+static void rkisp1_config_clk(struct rkisp1_device *dev)
+{
+	u32 val = CIF_ICCL_ISP_CLK | CIF_ICCL_CP_CLK | CIF_ICCL_MRSZ_CLK |
+		  CIF_ICCL_SRSZ_CLK | CIF_ICCL_JPEG_CLK | CIF_ICCL_MI_CLK |
+		  CIF_ICCL_IE_CLK | CIF_ICCL_MIPI_CLK | CIF_ICCL_DCROP_CLK;
+
+	regwrite(dev, val, CIF_ICCL);
+}
+
+/* Mess register operations to start ISP */
+static int rkisp1_isp_start(struct rkisp1_device *dev)
+{
+	struct sensor_async_subdev *sensor = dev->active_sensor;
+	u32 val;
+
+	dev_dbg(dev->dev, "SP streaming = %d, MP streaming = %d\n",
+		dev->stream[RKISP1_STREAM_SP].streaming,
+		dev->stream[RKISP1_STREAM_MP].streaming);
+
+	rkisp1_config_clk(dev);
+
+	/* Activate MIPI */
+	if (sensor->mbus.type == V4L2_MBUS_CSI2_DPHY) {
+		val = regread(dev, CIF_MIPI_CTRL);
+		regwrite(dev, val | CIF_MIPI_CTRL_OUTPUT_ENA, CIF_MIPI_CTRL);
+	}
+	/* Activate ISP */
+	val = regread(dev, CIF_ISP_CTRL);
+	val |= CIF_ISP_CTRL_ISP_CFG_UPD | CIF_ISP_CTRL_ISP_ENABLE |
+	       CIF_ISP_CTRL_ISP_INFORM_ENABLE;
+	regwrite(dev, val, CIF_ISP_CTRL);
+
+	/* XXX: Is the 1000us too long?
+	 * CIF spec says to wait for sufficient time after enabling
+	 * the MIPI interface and before starting the sensor output.
+	 */
+	usleep_range(1000, 1200);
+
+	dev_dbg(dev->dev,
+		"SP streaming = %d, MP streaming = %d MI_CTRL 0x%08x\n"
+		"  ISP_CTRL 0x%08x MIPI_CTRL 0x%08x\n",
+		dev->stream[RKISP1_STREAM_SP].streaming,
+		dev->stream[RKISP1_STREAM_MP].streaming,
+		regread(dev, CIF_MI_CTRL),
+		regread(dev, CIF_ISP_CTRL),
+		regread(dev, CIF_MIPI_CTRL));
+
+	return 0;
+}
+
+/***************************** ISP sub-devs *******************************/
+
+static const struct rkisp1_fmt rkisp1_isp_formats[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.fmt_type	= FMT_YUV,
+		.direction	= RKISP1_DIR_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW10,
+		.bayer_pat	= RAW_RGGB,
+		.bus_width	= 10,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW10,
+		.bayer_pat	= RAW_BGGR,
+		.bus_width	= 10,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW10,
+		.bayer_pat	= RAW_GBRG,
+		.bus_width	= 10,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW10,
+		.bayer_pat	= RAW_GRBG,
+		.bus_width	= 10,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW12,
+		.bayer_pat	= RAW_RGGB,
+		.bus_width	= 12,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW12,
+		.bayer_pat	= RAW_BGGR,
+		.bus_width	= 12,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW12,
+		.bayer_pat	= RAW_GBRG,
+		.bus_width	= 12,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW12,
+		.bayer_pat	= RAW_GRBG,
+		.bus_width	= 12,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW8,
+		.bayer_pat	= RAW_RGGB,
+		.bus_width	= 8,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW8,
+		.bayer_pat	= RAW_BGGR,
+		.bus_width	= 8,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW8,
+		.bayer_pat	= RAW_GBRG,
+		.bus_width	= 8,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.fmt_type	= FMT_BAYER,
+		.mipi_dt	= CIF_CSI2_DT_RAW8,
+		.bayer_pat	= RAW_GRBG,
+		.bus_width	= 8,
+		.direction	= RKISP1_DIR_IN_OUT,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.fmt_type	= FMT_YUV,
+		.mipi_dt	= CIF_CSI2_DT_YUV422_8b,
+		.yuv_seq	= CIF_ISP_ACQ_PROP_YCBYCR,
+		.bus_width	= 16,
+		.direction	= RKISP1_DIR_IN,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.fmt_type	= FMT_YUV,
+		.mipi_dt	= CIF_CSI2_DT_YUV422_8b,
+		.yuv_seq	= CIF_ISP_ACQ_PROP_YCRYCB,
+		.bus_width	= 16,
+		.direction	= RKISP1_DIR_IN,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.fmt_type	= FMT_YUV,
+		.mipi_dt	= CIF_CSI2_DT_YUV422_8b,
+		.yuv_seq	= CIF_ISP_ACQ_PROP_CBYCRY,
+		.bus_width	= 16,
+		.direction	= RKISP1_DIR_IN,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.fmt_type	= FMT_YUV,
+		.mipi_dt	= CIF_CSI2_DT_YUV422_8b,
+		.yuv_seq	= CIF_ISP_ACQ_PROP_CRYCBY,
+		.bus_width	= 16,
+		.direction	= RKISP1_DIR_IN,
+	},
+};
+
+static const struct rkisp1_fmt *find_fmt(u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rkisp1_isp_formats); i++) {
+		const struct rkisp1_fmt *fmt = &rkisp1_isp_formats[i];
+
+		if (fmt->mbus_code == mbus_code)
+			return fmt;
+	}
+
+	return NULL;
+}
+
+static int rkisp1_isp_sd_enum_mbus_code(struct v4l2_subdev *sd,
+					struct v4l2_subdev_pad_config *cfg,
+					struct v4l2_subdev_mbus_code_enum *code)
+{
+	unsigned int i, dir;
+	int pos = 0;
+
+	if (code->pad == RKISP1_ISP_PAD_SINK_VIDEO) {
+		dir = RKISP1_DIR_IN;
+	} else if (code->pad == RKISP1_ISP_PAD_SOURCE_VIDEO) {
+		dir = RKISP1_DIR_OUT;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+		code->code = MEDIA_BUS_FMT_FIXED;
+		return 0;
+	}
+
+	if (code->index >= ARRAY_SIZE(rkisp1_isp_formats))
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(rkisp1_isp_formats); i++) {
+		const struct rkisp1_fmt *fmt = &rkisp1_isp_formats[i];
+
+		if (fmt->direction & dir)
+			pos++;
+
+		if (code->index == pos - 1) {
+			code->code = fmt->mbus_code;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int rkisp1_isp_sd_init_config(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_pad_config *cfg)
+{
+	struct v4l2_rect *mf_in_crop, *mf_out_crop;
+	struct v4l2_mbus_framefmt *mf_in, *mf_out;
+
+	mf_in = v4l2_subdev_get_try_format(sd, cfg, RKISP1_ISP_PAD_SINK_VIDEO);
+	mf_in->width = RKISP1_DEFAULT_WIDTH;
+	mf_in->height = RKISP1_DEFAULT_HEIGHT;
+	mf_in->field = V4L2_FIELD_NONE;
+	mf_in->code = RKISP1_DEF_SINK_PAD_FMT;
+
+	mf_in_crop = v4l2_subdev_get_try_crop(sd, cfg, RKISP1_ISP_PAD_SINK_VIDEO);
+	mf_in_crop->width = RKISP1_DEFAULT_WIDTH;
+	mf_in_crop->height = RKISP1_DEFAULT_HEIGHT;
+	mf_in_crop->left = 0;
+	mf_in_crop->top = 0;
+
+	mf_out = v4l2_subdev_get_try_format(sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_VIDEO);
+	*mf_out = *mf_in;
+	mf_out->code = RKISP1_DEF_SRC_PAD_FMT;
+	mf_out->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+
+	mf_out_crop = v4l2_subdev_get_try_crop(sd, cfg,
+					       RKISP1_ISP_PAD_SOURCE_VIDEO);
+	*mf_out_crop = *mf_in_crop;
+
+	mf_in = v4l2_subdev_get_try_format(sd, cfg, RKISP1_ISP_PAD_SINK_PARAMS);
+	mf_out = v4l2_subdev_get_try_format(sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_STATS);
+	/*
+	 * NOTE: setting a format here doesn't make much sense
+	 * but v4l2-compliance complains
+	 */
+	mf_in->width = RKISP1_DEFAULT_WIDTH;
+	mf_in->height = RKISP1_DEFAULT_HEIGHT;
+	mf_in->field = V4L2_FIELD_NONE;
+	mf_in->code = MEDIA_BUS_FMT_FIXED;
+	*mf_out = *mf_in;
+
+	return 0;
+}
+
+static void rkisp1_isp_sd_set_out_crop(struct rkisp1_isp_subdev *isp_sd,
+				       struct v4l2_subdev_pad_config *cfg,
+				       struct v4l2_rect *r, unsigned int which)
+{
+	const struct v4l2_rect *in_crop;
+	struct v4l2_rect *out_crop;
+
+	out_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_VIDEO,
+					    which);
+
+	out_crop->left = ALIGN(r->left, 2);
+	out_crop->width = ALIGN(r->width, 2);
+	out_crop->top = r->top;
+	out_crop->height = r->height;
+
+	in_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					     RKISP1_ISP_PAD_SINK_VIDEO, which);
+
+	out_crop->left = clamp_t(u32, out_crop->left, 0, in_crop->width);
+	out_crop->top = clamp_t(u32, out_crop->top, 0, in_crop->height);
+	out_crop->width = clamp_t(u32, out_crop->width,
+				  CIF_ISP_OUTPUT_W_MIN,
+				  in_crop->width - out_crop->left);
+	out_crop->height = clamp_t(u32, out_crop->height,
+				   CIF_ISP_OUTPUT_H_MIN,
+				   in_crop->height - out_crop->top);
+}
+
+static void rkisp1_isp_sd_set_out_fmt(struct rkisp1_isp_subdev *isp_sd,
+				      struct v4l2_subdev_pad_config *cfg,
+				      struct v4l2_mbus_framefmt *format,
+				      unsigned int which)
+{
+	struct v4l2_mbus_framefmt *out_fmt;
+	const struct rkisp1_fmt *rk_fmt;
+	const struct v4l2_rect *in_crop;
+
+	out_fmt = rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_VIDEO,
+					    which);
+	in_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					     RKISP1_ISP_PAD_SINK_VIDEO, which);
+
+	/*
+	 * TODO: check if other fields besides width/height/quantization are
+	 * also configurable. If yes, then accept them from userspace.
+	 */
+	out_fmt->code = format->code;
+	rk_fmt = find_fmt(out_fmt->code);
+	if (!rk_fmt) {
+		out_fmt->code = RKISP1_DEF_SRC_PAD_FMT;
+		rk_fmt = find_fmt(out_fmt->code);
+	}
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		isp_sd->out_fmt = rk_fmt;
+	/* window size is set in s_selection */
+	out_fmt->width  = in_crop->width;
+	out_fmt->height = in_crop->height;
+	/* TODO: validate quantization value */
+	out_fmt->quantization = format->quantization;
+	/* full range by default */
+	if (!out_fmt->quantization)
+		out_fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+
+	*format = *out_fmt;
+}
+
+static void rkisp1_isp_sd_set_in_crop(struct rkisp1_isp_subdev *isp_sd,
+				      struct v4l2_subdev_pad_config *cfg,
+				      struct v4l2_rect *r, unsigned int which)
+{
+	struct v4l2_mbus_framefmt *in_fmt, *out_fmt;
+	struct v4l2_rect *in_crop, *out_crop;
+
+	in_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					    RKISP1_ISP_PAD_SINK_VIDEO,
+					    which);
+
+	in_crop->left = ALIGN(r->left, 2);
+	in_crop->width = ALIGN(r->width, 2);
+	in_crop->top = r->top;
+	in_crop->height = r->height;
+
+	in_fmt = rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg,
+					     RKISP1_ISP_PAD_SINK_VIDEO, which);
+
+	in_crop->left = clamp_t(u32, in_crop->left, 0, in_fmt->width);
+	in_crop->top = clamp_t(u32, in_crop->top, 0, in_fmt->height);
+	in_crop->width = clamp_t(u32, in_crop->width, CIF_ISP_INPUT_W_MIN,
+				 in_fmt->width - in_crop->left);
+	in_crop->height = clamp_t(u32, in_crop->height,
+				  CIF_ISP_INPUT_H_MIN,
+				  in_fmt->height - in_crop->top);
+
+	/* Update source crop and format */
+	out_fmt = rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_VIDEO, which);
+	rkisp1_isp_sd_set_out_fmt(isp_sd, cfg, out_fmt, which);
+
+	out_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					    RKISP1_ISP_PAD_SOURCE_VIDEO, which);
+	rkisp1_isp_sd_set_out_crop(isp_sd, cfg, out_crop, which);
+}
+
+static void rkisp1_isp_sd_set_in_fmt(struct rkisp1_isp_subdev *isp_sd,
+				     struct v4l2_subdev_pad_config *cfg,
+				     struct v4l2_mbus_framefmt *format,
+				     unsigned int which)
+{
+	struct v4l2_mbus_framefmt *in_fmt;
+	const struct rkisp1_fmt *rk_fmt;
+	struct v4l2_rect *in_crop;
+
+	in_fmt = rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg,
+					   RKISP1_ISP_PAD_SINK_VIDEO, which);
+
+	/*
+	 * TODO: check if other fields besides width/height/quantization are
+	 * also configurable. If yes, then accept them from userspace.
+	 */
+	in_fmt->code = format->code;
+	rk_fmt = find_fmt(in_fmt->code);
+	if (!rk_fmt) {
+		in_fmt->code = RKISP1_DEF_SINK_PAD_FMT;
+		rk_fmt = find_fmt(in_fmt->code);
+	}
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		isp_sd->in_fmt = rk_fmt;
+	in_fmt->width = clamp_t(u32, format->width,
+				CIF_ISP_INPUT_W_MIN,
+				CIF_ISP_INPUT_W_MAX);
+	in_fmt->height = clamp_t(u32, format->height,
+				 CIF_ISP_INPUT_H_MIN,
+				 CIF_ISP_INPUT_H_MAX);
+
+	*format = *in_fmt;
+
+	/* Update sink crop */
+	in_crop = rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+					     RKISP1_ISP_PAD_SINK_VIDEO, which);
+	rkisp1_isp_sd_set_in_crop(isp_sd, cfg, in_crop, which);
+}
+
+static int rkisp1_isp_sd_get_fmt(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_pad_config *cfg,
+				 struct v4l2_subdev_format *fmt)
+{
+	struct rkisp1_isp_subdev *isp_sd = sd_to_isp_sd(sd);
+
+	fmt->format = *rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg, fmt->pad,
+						 fmt->which);
+	return 0;
+}
+
+static int rkisp1_isp_sd_set_fmt(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_pad_config *cfg,
+				 struct v4l2_subdev_format *fmt)
+{
+	struct rkisp1_isp_subdev *isp_sd = sd_to_isp_sd(sd);
+
+	if (fmt->pad == RKISP1_ISP_PAD_SINK_VIDEO)
+		rkisp1_isp_sd_set_in_fmt(isp_sd, cfg, &fmt->format, fmt->which);
+	else if (fmt->pad == RKISP1_ISP_PAD_SOURCE_VIDEO)
+		rkisp1_isp_sd_set_out_fmt(isp_sd, cfg, &fmt->format,
+					  fmt->which);
+	else
+		fmt->format = *rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg, fmt->pad,
+							 fmt->which);
+
+	return 0;
+}
+
+
+static int rkisp1_isp_sd_get_selection(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_pad_config *cfg,
+				       struct v4l2_subdev_selection *sel)
+{
+	struct rkisp1_isp_subdev *isp_sd = sd_to_isp_sd(sd);
+
+	if (sel->pad != RKISP1_ISP_PAD_SOURCE_VIDEO &&
+	    sel->pad != RKISP1_ISP_PAD_SINK_VIDEO)
+		return -EINVAL;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		if (sel->pad == RKISP1_ISP_PAD_SINK_VIDEO) {
+			struct v4l2_mbus_framefmt *__format;
+
+			__format = rkisp1_isp_sd_get_pad_fmt(isp_sd, cfg,
+							     sel->pad,
+							     sel->which);
+			sel->r.height = __format->height;
+			sel->r.width = __format->width;
+			sel->r.left = 0;
+			sel->r.top = 0;
+		} else {
+			sel->r = *rkisp1_isp_sd_get_pad_crop(isp_sd, cfg,
+						RKISP1_ISP_PAD_SINK_VIDEO,
+						sel->which);
+		}
+		break;
+	case V4L2_SEL_TGT_CROP:
+		sel->r = *rkisp1_isp_sd_get_pad_crop(isp_sd, cfg, sel->pad,
+						     sel->which);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int rkisp1_isp_sd_set_selection(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_pad_config *cfg,
+				       struct v4l2_subdev_selection *sel)
+{
+	struct rkisp1_isp_subdev *isp_sd = sd_to_isp_sd(sd);
+	struct rkisp1_device *dev = sd_to_isp_dev(sd);
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	dev_dbg(dev->dev, "%s: pad: %d sel(%d,%d)/%dx%d\n", __func__, sel->pad,
+		sel->r.left, sel->r.top, sel->r.width, sel->r.height);
+
+	if (sel->pad == RKISP1_ISP_PAD_SINK_VIDEO)
+		rkisp1_isp_sd_set_in_crop(isp_sd, cfg, &sel->r, sel->which);
+	else if (sel->pad == RKISP1_ISP_PAD_SOURCE_VIDEO)
+		rkisp1_isp_sd_set_out_crop(isp_sd, cfg, &sel->r, sel->which);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mipi_csi2_s_stream_start(struct rkisp1_isp_subdev *isp_sd,
+				    struct sensor_async_subdev *sensor)
+{
+	union phy_configure_opts opts = { 0 };
+	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
+	s64 pixel_clock;
+
+	if (!sensor->pixel_rate_ctrl) {
+		dev_warn(sensor->sd->dev, "No pixel rate control in subdev\n");
+		return -EPIPE;
+	}
+
+	pixel_clock = v4l2_ctrl_g_ctrl_int64(sensor->pixel_rate_ctrl);
+	if (!pixel_clock) {
+		dev_err(sensor->sd->dev, "Invalid pixel rate value\n");
+		return -EINVAL;
+	}
+
+	phy_mipi_dphy_get_default_config(pixel_clock, isp_sd->in_fmt->bus_width,
+					 sensor->lanes, cfg);
+	phy_set_mode(sensor->dphy, PHY_MODE_MIPI_DPHY);
+	phy_configure(sensor->dphy, &opts);
+	phy_power_on(sensor->dphy);
+
+	return 0;
+}
+
+static void mipi_csi2_s_stream_stop(struct sensor_async_subdev *sensor)
+{
+	phy_power_off(sensor->dphy);
+}
+
+static int rkisp1_isp_sd_s_stream(struct v4l2_subdev *sd, int on)
+{
+	struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
+	struct v4l2_subdev *sensor_sd;
+	int ret = 0;
+
+	if (!on) {
+		ret = rkisp1_isp_stop(isp_dev);
+		if (ret < 0)
+			return ret;
+		mipi_csi2_s_stream_stop(isp_dev->active_sensor);
+		return 0;
+	}
+
+	sensor_sd = get_remote_sensor(sd);
+	if (!sensor_sd)
+		return -ENODEV;
+	isp_dev->active_sensor = container_of(sensor_sd->asd,
+					      struct sensor_async_subdev, asd);
+
+	atomic_set(&isp_dev->isp_sdev.frm_sync_seq, 0);
+	ret = rkisp1_config_cif(isp_dev);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: support other interfaces */
+	if (isp_dev->active_sensor->mbus.type != V4L2_MBUS_CSI2_DPHY)
+		return -EINVAL;
+
+	ret = mipi_csi2_s_stream_start(&isp_dev->isp_sdev,
+				       isp_dev->active_sensor);
+	if (ret < 0)
+		return ret;
+
+	ret = rkisp1_isp_start(isp_dev);
+	if (ret)
+		mipi_csi2_s_stream_stop(isp_dev->active_sensor);
+
+	return ret;
+}
+
+static int rkisp1_subdev_link_validate(struct media_link *link)
+{
+	if (link->sink->index == RKISP1_ISP_PAD_SINK_PARAMS)
+		return 0;
+
+	return v4l2_subdev_link_validate(link);
+}
+
+static int rkisp1_subdev_fmt_link_validate(struct v4l2_subdev *sd,
+					struct media_link *link,
+					struct v4l2_subdev_format *source_fmt,
+					struct v4l2_subdev_format *sink_fmt)
+{
+	if (source_fmt->format.code != sink_fmt->format.code)
+		return -EPIPE;
+
+	/* Crop is available */
+	if (source_fmt->format.width < sink_fmt->format.width ||
+	    source_fmt->format.height < sink_fmt->format.height)
+		return -EPIPE;
+
+	return 0;
+}
+
+static void rkisp1_isp_queue_event_sof(struct rkisp1_isp_subdev *isp)
+{
+	struct v4l2_event event = {
+		.type = V4L2_EVENT_FRAME_SYNC,
+		.u.frame_sync.frame_sequence =
+			atomic_inc_return(&isp->frm_sync_seq) - 1,
+	};
+	v4l2_event_queue(isp->sd.devnode, &event);
+}
+
+static int rkisp1_isp_sd_subs_evt(struct v4l2_subdev *sd, struct v4l2_fh *fh,
+				  struct v4l2_event_subscription *sub)
+{
+	if (sub->type != V4L2_EVENT_FRAME_SYNC)
+		return -EINVAL;
+
+	/* V4L2_EVENT_FRAME_SYNC doesn't require an id, so zero should be set */
+	if (sub->id != 0)
+		return -EINVAL;
+
+	return v4l2_event_subscribe(fh, sub, 0, NULL);
+}
+
+static const struct v4l2_subdev_pad_ops rkisp1_isp_sd_pad_ops = {
+	.enum_mbus_code = rkisp1_isp_sd_enum_mbus_code,
+	.get_selection = rkisp1_isp_sd_get_selection,
+	.set_selection = rkisp1_isp_sd_set_selection,
+	.init_cfg = rkisp1_isp_sd_init_config,
+	.get_fmt = rkisp1_isp_sd_get_fmt,
+	.set_fmt = rkisp1_isp_sd_set_fmt,
+	.link_validate = rkisp1_subdev_fmt_link_validate,
+};
+
+static const struct media_entity_operations rkisp1_isp_sd_media_ops = {
+	.link_validate = rkisp1_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_video_ops rkisp1_isp_sd_video_ops = {
+	.s_stream = rkisp1_isp_sd_s_stream,
+};
+
+static const struct v4l2_subdev_core_ops rkisp1_isp_core_ops = {
+	.subscribe_event = rkisp1_isp_sd_subs_evt,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_ops rkisp1_isp_sd_ops = {
+	.core = &rkisp1_isp_core_ops,
+	.video = &rkisp1_isp_sd_video_ops,
+	.pad = &rkisp1_isp_sd_pad_ops,
+};
+
+int rkisp1_register_isp_subdev(struct rkisp1_device *isp_dev,
+			       struct v4l2_device *v4l2_dev)
+{
+	struct media_pad *pads = isp_dev->isp_sdev.pads;
+	struct v4l2_subdev *sd = &isp_dev->isp_sdev.sd;
+	int ret;
+
+	v4l2_subdev_init(sd, &rkisp1_isp_sd_ops);
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
+	sd->entity.ops = &rkisp1_isp_sd_media_ops;
+	strscpy(sd->name, "rkisp1-isp-subdev", sizeof(sd->name));
+
+	pads[RKISP1_ISP_PAD_SINK_VIDEO].flags =
+		MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+	pads[RKISP1_ISP_PAD_SINK_PARAMS].flags = MEDIA_PAD_FL_SINK;
+	pads[RKISP1_ISP_PAD_SOURCE_VIDEO].flags = MEDIA_PAD_FL_SOURCE;
+	pads[RKISP1_ISP_PAD_SOURCE_STATS].flags = MEDIA_PAD_FL_SOURCE;
+	isp_dev->isp_sdev.in_fmt = find_fmt(RKISP1_DEF_SINK_PAD_FMT);
+	isp_dev->isp_sdev.out_fmt = find_fmt(RKISP1_DEF_SRC_PAD_FMT);
+	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+	ret = media_entity_pads_init(&sd->entity, RKISP1_ISP_PAD_MAX, pads);
+	if (ret < 0)
+		return ret;
+
+	sd->owner = THIS_MODULE;
+	v4l2_set_subdevdata(sd, isp_dev);
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		dev_err(sd->dev, "Failed to register isp subdev\n");
+		goto err_cleanup_media_entity;
+	}
+
+	rkisp1_isp_sd_init_config(sd, isp_dev->isp_sdev.pad_cfg);
+	return 0;
+
+err_cleanup_media_entity:
+	media_entity_cleanup(&sd->entity);
+
+	return ret;
+}
+
+void rkisp1_unregister_isp_subdev(struct rkisp1_device *isp_dev)
+{
+	struct v4l2_subdev *sd = &isp_dev->isp_sdev.sd;
+
+	v4l2_device_unregister_subdev(sd);
+	media_entity_cleanup(&sd->entity);
+}
+
+/****************  Interrupter Handlers ****************/
+
+void rkisp1_mipi_isr(struct rkisp1_device *dev)
+{
+	u32 val, status;
+
+	status = regread(dev, CIF_MIPI_MIS);
+	if (!status)
+		return;
+
+	regwrite(dev, ~0, CIF_MIPI_ICR);
+
+	/*
+	 * Disable DPHY errctrl interrupt, because this dphy
+	 * erctrl signal is asserted until the next changes
+	 * of line state. This time is may be too long and cpu
+	 * is hold in this interrupt.
+	 */
+	if (status & CIF_MIPI_ERR_CTRL(0x0f)) {
+		val = regread(dev, CIF_MIPI_IMSC);
+		regwrite(dev, val & ~CIF_MIPI_ERR_CTRL(0x0f), CIF_MIPI_IMSC);
+		dev->isp_sdev.dphy_errctrl_disabled = true;
+	}
+
+	/*
+	 * Enable DPHY errctrl interrupt again, if mipi have receive
+	 * the whole frame without any error.
+	 */
+	if (status == CIF_MIPI_FRAME_END) {
+		/*
+		 * Enable DPHY errctrl interrupt again, if mipi have receive
+		 * the whole frame without any error.
+		 */
+		if (dev->isp_sdev.dphy_errctrl_disabled) {
+			val = regread(dev, CIF_MIPI_IMSC);
+			val |= CIF_MIPI_ERR_CTRL(0x0f);
+			regwrite(dev, val, CIF_MIPI_IMSC);
+			dev->isp_sdev.dphy_errctrl_disabled = false;
+		}
+	} else {
+		dev_warn(dev->dev, "MIPI status error: 0x%08x\n", status);
+	}
+}
+
+void rkisp1_isp_isr(struct rkisp1_device *dev)
+{
+	u32 status, status_aux, isp_err;
+
+	status = regread(dev, CIF_ISP_MIS);
+	if (!status)
+		return;
+
+	/* start edge of v_sync */
+	if (status & CIF_ISP_V_START) {
+		rkisp1_isp_queue_event_sof(&dev->isp_sdev);
+
+		regwrite(dev, CIF_ISP_V_START, CIF_ISP_ICR);
+		status_aux = regread(dev, CIF_ISP_MIS);
+		if (status_aux & CIF_ISP_V_START)
+			dev_err(dev->dev, "isp icr v_statr err: 0x%x\n",
+				status_aux);
+	}
+
+	if (status & CIF_ISP_PIC_SIZE_ERROR) {
+		/* Clear pic_size_error */
+		regwrite(dev, CIF_ISP_PIC_SIZE_ERROR, CIF_ISP_ICR);
+		isp_err = regread(dev, CIF_ISP_ERR);
+		dev_err(dev->dev, "CIF_ISP_PIC_SIZE_ERROR (0x%08x)", isp_err);
+		regwrite(dev, isp_err, CIF_ISP_ERR_CLR);
+	} else if (status & CIF_ISP_DATA_LOSS) {
+		/* Clear data_loss */
+		regwrite(dev, CIF_ISP_DATA_LOSS, CIF_ISP_ICR);
+		dev_err(dev->dev, "CIF_ISP_DATA_LOSS\n");
+		regwrite(dev, CIF_ISP_DATA_LOSS, CIF_ISP_ICR);
+	}
+
+	/* sampled input frame is complete */
+	if (status & CIF_ISP_FRAME_IN) {
+		regwrite(dev, CIF_ISP_FRAME_IN, CIF_ISP_ICR);
+		status_aux = regread(dev, CIF_ISP_MIS);
+		if (status_aux & CIF_ISP_FRAME_IN)
+			dev_err(dev->dev, "isp icr frame_in err: 0x%x\n",
+				status_aux);
+	}
+
+	/* frame was completely put out */
+	if (status & CIF_ISP_FRAME) {
+		u32 isp_ris = 0;
+		/* Clear Frame In (ISP) */
+		regwrite(dev, CIF_ISP_FRAME, CIF_ISP_ICR);
+		status_aux = regread(dev, CIF_ISP_MIS);
+		if (status_aux & CIF_ISP_FRAME)
+			dev_err(dev->dev,
+				"isp icr frame end err: 0x%x\n", status_aux);
+
+		isp_ris = regread(dev, CIF_ISP_RIS);
+		if (isp_ris & (CIF_ISP_AWB_DONE | CIF_ISP_AFM_FIN |
+			       CIF_ISP_EXP_END | CIF_ISP_HIST_MEASURE_RDY))
+			rkisp1_stats_isr(&dev->stats_vdev, isp_ris);
+	}
+
+	/*
+	 * Then update changed configs. Some of them involve
+	 * lot of register writes. Do those only one per frame.
+	 * Do the updates in the order of the processing flow.
+	 */
+	rkisp1_params_isr(dev, status);
+}
diff --git a/drivers/staging/media/rkisp1/rkisp1.h b/drivers/staging/media/rkisp1/rkisp1.h
new file mode 100644
index 000000000000..0c37710a365b
--- /dev/null
+++ b/drivers/staging/media/rkisp1/rkisp1.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 Driver - ISP Subdevice header
+ *
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _RKISP1_H
+#define _RKISP1_H
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-subdev.h>
+
+#include "common.h"
+
+struct rkisp1_stream;
+
+#define RKISP1_DIR_OUT BIT(0)
+#define RKISP1_DIR_IN BIT(1)
+#define RKISP1_DIR_IN_OUT (RKISP1_DIR_IN | RKISP1_DIR_OUT)
+
+/*
+ * struct rkisp1_fmt - ISP pad format
+ *
+ * Translate mbus_code to hardware format values
+ *
+ * @bus_width: used for parallel
+ */
+struct rkisp1_fmt {
+	u32 mbus_code;
+	u8 fmt_type;
+	u32 mipi_dt;
+	u32 yuv_seq;
+	u8 bus_width;
+	enum rkisp1_fmt_raw_pat_type bayer_pat;
+	unsigned int direction;
+};
+
+enum rkisp1_isp_pad {
+	RKISP1_ISP_PAD_SINK_VIDEO,
+	RKISP1_ISP_PAD_SINK_PARAMS,
+	RKISP1_ISP_PAD_SOURCE_VIDEO,
+	RKISP1_ISP_PAD_SOURCE_STATS,
+	RKISP1_ISP_PAD_MAX
+};
+
+/*
+ * struct rkisp1_isp_subdev - ISP sub-device
+ *
+ * See Cropping regions of ISP in rkisp1.c for details
+ * @in_frm: input size, don't have to be equal to sensor size
+ * @in_fmt: input format
+ * @in_crop: crop for sink pad
+ * @out_fmt: output format
+ * @out_crop: output size
+ *
+ * @dphy_errctrl_disabled : if dphy errctrl is disabled (avoid endless interrupt)
+ * @frm_sync_seq: frame sequence, to sync frame_id between video devices.
+ * @quantization: output quantization
+ *
+ * TODO: remember to document all the fields after refactoring
+ */
+struct rkisp1_isp_subdev {
+	struct v4l2_subdev sd;
+	struct media_pad pads[RKISP1_ISP_PAD_MAX];
+	struct v4l2_subdev_pad_config pad_cfg[RKISP1_ISP_PAD_MAX];
+	const struct rkisp1_fmt *in_fmt;
+	const struct rkisp1_fmt *out_fmt;
+	bool dphy_errctrl_disabled;
+	atomic_t frm_sync_seq;
+
+};
+
+struct v4l2_mbus_framefmt *
+rkisp1_isp_sd_get_pad_fmt(struct rkisp1_isp_subdev *isp_sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  unsigned int pad, u32 which);
+
+struct v4l2_rect *rkisp1_isp_sd_get_pad_crop(struct rkisp1_isp_subdev *isp_sd,
+					     struct v4l2_subdev_pad_config *cfg,
+					     unsigned int pad, u32 which);
+
+int rkisp1_register_isp_subdev(struct rkisp1_device *isp_dev,
+			       struct v4l2_device *v4l2_dev);
+
+void rkisp1_unregister_isp_subdev(struct rkisp1_device *isp_dev);
+
+void rkisp1_mipi_isr(struct rkisp1_device *dev);
+
+void rkisp1_isp_isr(struct rkisp1_device *dev);
+
+static inline struct rkisp1_isp_subdev *sd_to_isp_sd(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct rkisp1_isp_subdev, sd);
+}
+
+#endif /* _RKISP1_H */
diff --git a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
new file mode 100644
index 000000000000..e9bc64ab9853
--- /dev/null
+++ b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
@@ -0,0 +1,815 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Rockchip ISP1 userspace API
+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
+ */
+
+/*
+ * TODO: Improve documentation, mostly regarding abbreviation and hardware
+ * specificities. Reference: "REF_01 - ISP_user_manual, Rev 2.57" (not public)
+ */
+
+#ifndef _UAPI_RKISP1_CONFIG_H
+#define _UAPI_RKISP1_CONFIG_H
+
+#include <linux/types.h>
+
+#define CIFISP_MODULE_DPCC		BIT(0)
+#define CIFISP_MODULE_BLS		BIT(1)
+#define CIFISP_MODULE_SDG		BIT(2)
+#define CIFISP_MODULE_HST		BIT(3)
+#define CIFISP_MODULE_LSC		BIT(4)
+#define CIFISP_MODULE_AWB_GAIN		BIT(5)
+#define CIFISP_MODULE_FLT		BIT(6)
+#define CIFISP_MODULE_BDM		BIT(7)
+#define CIFISP_MODULE_CTK		BIT(8)
+#define CIFISP_MODULE_GOC		BIT(9)
+#define CIFISP_MODULE_CPROC		BIT(10)
+#define CIFISP_MODULE_AFC		BIT(11)
+#define CIFISP_MODULE_AWB		BIT(12)
+#define CIFISP_MODULE_IE		BIT(13)
+#define CIFISP_MODULE_AEC		BIT(14)
+#define CIFISP_MODULE_WDR		BIT(15)
+#define CIFISP_MODULE_DPF		BIT(16)
+#define CIFISP_MODULE_DPF_STRENGTH	BIT(17)
+
+#define CIFISP_CTK_COEFF_MAX            0x100
+#define CIFISP_CTK_OFFSET_MAX           0x800
+
+#define CIFISP_AE_MEAN_MAX              25
+#define CIFISP_HIST_BIN_N_MAX           16
+#define CIFISP_AFM_MAX_WINDOWS          3
+#define CIFISP_DEGAMMA_CURVE_SIZE       17
+
+#define CIFISP_BDM_MAX_TH               0xff
+
+/*
+ * Black level compensation
+ */
+/* maximum value for horizontal start address */
+#define CIFISP_BLS_START_H_MAX             0x00000fff
+/* maximum value for horizontal stop address */
+#define CIFISP_BLS_STOP_H_MAX              0x00000fff
+/* maximum value for vertical start address */
+#define CIFISP_BLS_START_V_MAX             0x00000fff
+/* maximum value for vertical stop address */
+#define CIFISP_BLS_STOP_V_MAX              0x00000fff
+/* maximum is 2^18 = 262144*/
+#define CIFISP_BLS_SAMPLES_MAX             0x00000012
+/* maximum value for fixed black level */
+#define CIFISP_BLS_FIX_SUB_MAX             0x00000fff
+/* minimum value for fixed black level */
+#define CIFISP_BLS_FIX_SUB_MIN             0xfffff000
+/* 13 bit range (signed)*/
+#define CIFISP_BLS_FIX_MASK                0x00001fff
+
+/*
+ * Automatic white balance measurments
+ */
+#define CIFISP_AWB_MAX_GRID                1
+#define CIFISP_AWB_MAX_FRAMES              7
+
+/*
+ * Gamma out
+ */
+/* Maximum number of color samples supported */
+#define CIFISP_GAMMA_OUT_MAX_SAMPLES       17
+
+/*
+ * Lens shade correction
+ */
+#define CIFISP_LSC_GRAD_TBL_SIZE           8
+#define CIFISP_LSC_SIZE_TBL_SIZE           8
+/*
+ * The following matches the tuning process,
+ * not the max capabilities of the chip.
+ * Last value unused.
+ */
+#define	CIFISP_LSC_DATA_TBL_SIZE           290
+
+/*
+ * Histogram calculation
+ */
+/* Last 3 values unused. */
+#define CIFISP_HISTOGRAM_WEIGHT_GRIDS_SIZE 28
+
+/*
+ * Defect Pixel Cluster Correction
+ */
+#define CIFISP_DPCC_METHODS_MAX       3
+
+/*
+ * Denoising pre filter
+ */
+#define CIFISP_DPF_MAX_NLF_COEFFS      17
+#define CIFISP_DPF_MAX_SPATIAL_COEFFS  6
+
+/*
+ * Measurement types
+ */
+#define CIFISP_STAT_AWB           (1 << 0)
+#define CIFISP_STAT_AUTOEXP       (1 << 1)
+#define CIFISP_STAT_AFM_FIN       (1 << 2)
+#define CIFISP_STAT_HIST          (1 << 3)
+
+enum cifisp_histogram_mode {
+	CIFISP_HISTOGRAM_MODE_DISABLE,
+	CIFISP_HISTOGRAM_MODE_RGB_COMBINED,
+	CIFISP_HISTOGRAM_MODE_R_HISTOGRAM,
+	CIFISP_HISTOGRAM_MODE_G_HISTOGRAM,
+	CIFISP_HISTOGRAM_MODE_B_HISTOGRAM,
+	CIFISP_HISTOGRAM_MODE_Y_HISTOGRAM
+};
+
+enum cifisp_awb_mode_type {
+	CIFISP_AWB_MODE_MANUAL,
+	CIFISP_AWB_MODE_RGB,
+	CIFISP_AWB_MODE_YCBCR
+};
+
+enum cifisp_flt_mode {
+	CIFISP_FLT_STATIC_MODE,
+	CIFISP_FLT_DYNAMIC_MODE
+};
+
+/**
+ * enum cifisp_exp_ctrl_autostop - stop modes
+ * @CIFISP_EXP_CTRL_AUTOSTOP_0: continuous measurement
+ * @CIFISP_EXP_CTRL_AUTOSTOP_1: stop measuring after a complete frame
+ */
+enum cifisp_exp_ctrl_autostop {
+	CIFISP_EXP_CTRL_AUTOSTOP_0 = 0,
+	CIFISP_EXP_CTRL_AUTOSTOP_1 = 1,
+};
+
+/**
+ * enum cifisp_exp_meas_mode - Exposure measure mode
+ * @CIFISP_EXP_MEASURING_MODE_0: Y = 16 + 0.25R + 0.5G + 0.1094B
+ * @CIFISP_EXP_MEASURING_MODE_1: Y = (R + G + B) x (85/256)
+ */
+enum cifisp_exp_meas_mode {
+	CIFISP_EXP_MEASURING_MODE_0,
+	CIFISP_EXP_MEASURING_MODE_1,
+};
+
+/*---------- PART1: Input Parameters ------------*/
+
+struct cifisp_window {
+	__u16 h_offs;
+	__u16 v_offs;
+	__u16 h_size;
+	__u16 v_size;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_bls_fixed_val - BLS fixed subtraction values
+ *
+ * The values will be subtracted from the sensor
+ * values. Therefore a negative value means addition instead of subtraction!
+ *
+ * @r: Fixed (signed!) subtraction value for Bayer pattern R
+ * @gr: Fixed (signed!) subtraction value for Bayer pattern Gr
+ * @gb: Fixed (signed!) subtraction value for Bayer pattern Gb
+ * @b: Fixed (signed!) subtraction value for Bayer pattern B
+ */
+struct cifisp_bls_fixed_val {
+	__s16 r;
+	__s16 gr;
+	__s16 gb;
+	__s16 b;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_bls_config - Configuration used by black level subtraction
+ *
+ * @enable_auto: Automatic mode activated means that the measured values
+ *		 are subtracted. Otherwise the fixed subtraction
+ *		 values will be subtracted.
+ * @en_windows: enabled window
+ * @bls_window1: Measurement window 1 size
+ * @bls_window2: Measurement window 2 size
+ * @bls_samples: Set amount of measured pixels for each Bayer position
+ *		 (A, B,C and D) to 2^bls_samples.
+ * @cifisp_bls_fixed_val: Fixed subtraction values
+ */
+struct cifisp_bls_config {
+	__u8 enable_auto;
+	__u8 en_windows;
+	struct cifisp_window bls_window1;
+	struct cifisp_window bls_window2;
+	__u8 bls_samples;
+	struct cifisp_bls_fixed_val fixed_val;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpcc_methods_config - Methods Configuration used by DPCC
+ *
+ * Methods Configuration used by Defect Pixel Cluster Correction
+ *
+ * @method: Method enable bits
+ * @line_thresh: Line threshold
+ * @line_mad_fac: Line MAD factor
+ * @pg_fac: Peak gradient factor
+ * @rnd_thresh: Rank Neighbor Difference threshold
+ * @rg_fac: Rank gradient factor
+ */
+struct cifisp_dpcc_methods_config {
+	__u32 method;
+	__u32 line_thresh;
+	__u32 line_mad_fac;
+	__u32 pg_fac;
+	__u32 rnd_thresh;
+	__u32 rg_fac;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpcc_config - Configuration used by DPCC
+ *
+ * Configuration used by Defect Pixel Cluster Correction
+ *
+ * @mode: dpcc output mode
+ * @output_mode: whether use hard coded methods
+ * @set_use: stage1 methods set
+ * @methods: methods config
+ * @ro_limits: rank order limits
+ * @rnd_offs: differential rank offsets for rank neighbor difference
+ */
+struct cifisp_dpcc_config {
+	__u32 mode;
+	__u32 output_mode;
+	__u32 set_use;
+	struct cifisp_dpcc_methods_config methods[CIFISP_DPCC_METHODS_MAX];
+	__u32 ro_limits;
+	__u32 rnd_offs;
+} __attribute__ ((packed));
+
+struct cifisp_gamma_corr_curve {
+	__u16 gamma_y[CIFISP_DEGAMMA_CURVE_SIZE];
+} __attribute__ ((packed));
+
+struct cifisp_gamma_curve_x_axis_pnts {
+	__u32 gamma_dx0;
+	__u32 gamma_dx1;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_sdg_config - Configuration used by sensor degamma
+ *
+ * @curve_x: gamma curve point definition axis for x
+ * @xa_pnts: x increments
+ */
+struct cifisp_sdg_config {
+	struct cifisp_gamma_corr_curve curve_r;
+	struct cifisp_gamma_corr_curve curve_g;
+	struct cifisp_gamma_corr_curve curve_b;
+	struct cifisp_gamma_curve_x_axis_pnts xa_pnts;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_lsc_config - Configuration used by Lens shading correction
+ *
+ * refer to REF_01 for details
+ */
+struct cifisp_lsc_config {
+	__u32 r_data_tbl[CIFISP_LSC_DATA_TBL_SIZE];
+	__u32 gr_data_tbl[CIFISP_LSC_DATA_TBL_SIZE];
+	__u32 gb_data_tbl[CIFISP_LSC_DATA_TBL_SIZE];
+	__u32 b_data_tbl[CIFISP_LSC_DATA_TBL_SIZE];
+
+	__u32 x_grad_tbl[CIFISP_LSC_GRAD_TBL_SIZE];
+	__u32 y_grad_tbl[CIFISP_LSC_GRAD_TBL_SIZE];
+
+	__u32 x_size_tbl[CIFISP_LSC_SIZE_TBL_SIZE];
+	__u32 y_size_tbl[CIFISP_LSC_SIZE_TBL_SIZE];
+	__u16 config_width;
+	__u16 config_height;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_ie_config - Configuration used by image effects
+ *
+ * @eff_mat_1: 3x3 Matrix Coefficients for Emboss Effect 1
+ * @eff_mat_2: 3x3 Matrix Coefficients for Emboss Effect 2
+ * @eff_mat_3: 3x3 Matrix Coefficients for Emboss 3/Sketch 1
+ * @eff_mat_4: 3x3 Matrix Coefficients for Sketch Effect 2
+ * @eff_mat_5: 3x3 Matrix Coefficients for Sketch Effect 3
+ * @eff_tint: Chrominance increment values of tint (used for sepia effect)
+ */
+struct cifisp_ie_config {
+	__u16 effect;
+	__u16 color_sel;
+	__u16 eff_mat_1;
+	__u16 eff_mat_2;
+	__u16 eff_mat_3;
+	__u16 eff_mat_4;
+	__u16 eff_mat_5;
+	__u16 eff_tint;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_cproc_config - Configuration used by Color Processing
+ *
+ * @c_out_range: Chrominance pixel clipping range at output.
+ *		 (0 for limit, 1 for full)
+ * @y_in_range: Luminance pixel clipping range at output.
+ * @y_out_range: Luminance pixel clipping range at output.
+ * @contrast: 00~ff, 0.0~1.992
+ * @brightness: 80~7F, -128~+127
+ * @sat: saturation, 00~FF, 0.0~1.992
+ * @hue: 80~7F, -90~+87.188
+ */
+struct cifisp_cproc_config {
+	__u8 c_out_range;
+	__u8 y_in_range;
+	__u8 y_out_range;
+	__u8 contrast;
+	__u8 brightness;
+	__u8 sat;
+	__u8 hue;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_awb_meas_config - Configuration used by auto white balance
+ *
+ * @awb_wnd: white balance measurement window (in pixels)
+ *	     (from enum cifisp_awb_mode_type)
+ * @max_y: only pixels values < max_y contribute to awb measurement, set to 0
+ *	   to disable this feature
+ * @min_y: only pixels values > min_y contribute to awb measurement
+ * @max_csum: Chrominance sum maximum value, only consider pixels with Cb+Cr,
+ *	      smaller than threshold for awb measurements
+ * @min_c: Chrominance minimum value, only consider pixels with Cb/Cr
+ *	   each greater than threshold value for awb measurements
+ * @frames: number of frames - 1 used for mean value calculation
+ *	    (ucFrames=0 means 1 Frame)
+ * @awb_ref_cr: reference Cr value for AWB regulation, target for AWB
+ * @awb_ref_cb: reference Cb value for AWB regulation, target for AWB
+ */
+struct cifisp_awb_meas_config {
+	/*
+	 * Note: currently the h and v offsets are mapped to grid offsets
+	 */
+	struct cifisp_window awb_wnd;
+	__u32 awb_mode;
+	__u8 max_y;
+	__u8 min_y;
+	__u8 max_csum;
+	__u8 min_c;
+	__u8 frames;
+	__u8 awb_ref_cr;
+	__u8 awb_ref_cb;
+	__u8 enable_ymax_cmp;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_awb_gain_config - Configuration used by auto white balance gain
+ *
+ * out_data_x = ( AWB_GEAIN_X * in_data + 128) >> 8
+ */
+struct cifisp_awb_gain_config {
+	__u16 gain_red;
+	__u16 gain_green_r;
+	__u16 gain_blue;
+	__u16 gain_green_b;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_flt_config - Configuration used by ISP filtering
+ *
+ * @mode: ISP_FILT_MODE register fields (from enum cifisp_flt_mode)
+ * @grn_stage1: ISP_FILT_MODE register fields
+ * @chr_h_mode: ISP_FILT_MODE register fields
+ * @chr_v_mode: ISP_FILT_MODE register fields
+ *
+ * refer to REF_01 for details.
+ */
+
+struct cifisp_flt_config {
+	__u32 mode;
+	__u8 grn_stage1;
+	__u8 chr_h_mode;
+	__u8 chr_v_mode;
+	__u32 thresh_bl0;
+	__u32 thresh_bl1;
+	__u32 thresh_sh0;
+	__u32 thresh_sh1;
+	__u32 lum_weight;
+	__u32 fac_sh1;
+	__u32 fac_sh0;
+	__u32 fac_mid;
+	__u32 fac_bl0;
+	__u32 fac_bl1;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_bdm_config - Configuration used by Bayer DeMosaic
+ *
+ * @demosaic_th: threshod for bayer demosaicing texture detection
+ */
+struct cifisp_bdm_config {
+	__u8 demosaic_th;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_ctk_config - Configuration used by Cross Talk correction
+ *
+ * @coeff: color correction matrix
+ * @ct_offset_b: offset for the crosstalk correction matrix
+ */
+struct cifisp_ctk_config {
+	__u16 coeff0;
+	__u16 coeff1;
+	__u16 coeff2;
+	__u16 coeff3;
+	__u16 coeff4;
+	__u16 coeff5;
+	__u16 coeff6;
+	__u16 coeff7;
+	__u16 coeff8;
+	__u16 ct_offset_r;
+	__u16 ct_offset_g;
+	__u16 ct_offset_b;
+} __attribute__ ((packed));
+
+enum cifisp_goc_mode {
+	CIFISP_GOC_MODE_LOGARITHMIC,
+	CIFISP_GOC_MODE_EQUIDISTANT
+};
+
+/**
+ * struct cifisp_goc_config - Configuration used by Gamma Out correction
+ *
+ * @mode: goc mode (from enum cifisp_goc_mode)
+ * @gamma_y: gamma out curve y-axis for all color components
+ */
+struct cifisp_goc_config {
+	__u32 mode;
+	__u16 gamma_y[CIFISP_GAMMA_OUT_MAX_SAMPLES];
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_hst_config - Configuration used by Histogram
+ *
+ * @mode: histogram mode (from enum cifisp_histogram_mode)
+ * @histogram_predivider: process every stepsize pixel, all other pixels are
+ *			  skipped
+ * @meas_window: coordinates of the measure window
+ * @hist_weight: weighting factor for sub-windows
+ */
+struct cifisp_hst_config {
+	__u32 mode;
+	__u8 histogram_predivider;
+	struct cifisp_window meas_window;
+	__u8 hist_weight[CIFISP_HISTOGRAM_WEIGHT_GRIDS_SIZE];
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_aec_config - Configuration used by Auto Exposure Control
+ *
+ * @mode: Exposure measure mode (from enum cifisp_exp_meas_mode)
+ * @autostop: stop mode (from enum cifisp_exp_ctrl_autostop)
+ * @meas_window: coordinates of the measure window
+ */
+struct cifisp_aec_config {
+	__u32 mode;
+	__u32 autostop;
+	struct cifisp_window meas_window;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_afc_config - Configuration used by Auto Focus Control
+ *
+ * @num_afm_win: max CIFISP_AFM_MAX_WINDOWS
+ * @afm_win: coordinates of the meas window
+ * @thres: threshold used for minimizing the influence of noise
+ * @var_shift: the number of bits for the shift operation at the end of the
+ *	       calculation chain.
+ */
+struct cifisp_afc_config {
+	__u8 num_afm_win;
+	struct cifisp_window afm_win[CIFISP_AFM_MAX_WINDOWS];
+	__u32 thres;
+	__u32 var_shift;
+} __attribute__ ((packed));
+
+/**
+ * enum cifisp_dpf_gain_usage - dpf gain usage
+ * @CIFISP_DPF_GAIN_USAGE_DISABLED: don't use any gains in preprocessing stage
+ * @CIFISP_DPF_GAIN_USAGE_NF_GAINS: use only the noise function gains from
+ *				    registers DPF_NF_GAIN_R, ...
+ * @CIFISP_DPF_GAIN_USAGE_LSC_GAINS:  use only the gains from LSC module
+ * @CIFISP_DPF_GAIN_USAGE_NF_LSC_GAINS: use the noise function gains and the
+ *					gains from LSC module
+ * @CIFISP_DPF_GAIN_USAGE_AWB_GAINS: use only the gains from AWB module
+ * @CIFISP_DPF_GAIN_USAGE_AWB_LSC_GAINS: use the gains from AWB and LSC module
+ * @CIFISP_DPF_GAIN_USAGE_MAX: upper border (only for an internal evaluation)
+ */
+enum cifisp_dpf_gain_usage {
+	CIFISP_DPF_GAIN_USAGE_DISABLED,
+	CIFISP_DPF_GAIN_USAGE_NF_GAINS,
+	CIFISP_DPF_GAIN_USAGE_LSC_GAINS,
+	CIFISP_DPF_GAIN_USAGE_NF_LSC_GAINS,
+	CIFISP_DPF_GAIN_USAGE_AWB_GAINS,
+	CIFISP_DPF_GAIN_USAGE_AWB_LSC_GAINS,
+	CIFISP_DPF_GAIN_USAGE_MAX
+};
+
+/**
+ * enum cifisp_dpf_rb_filtersize - Red and blue filter sizes
+ * @CIFISP_DPF_RB_FILTERSIZE_13x9: red and blue filter kernel size 13x9
+ *				   (means 7x5 active pixel)
+ * @CIFISP_DPF_RB_FILTERSIZE_9x9: red and blue filter kernel size 9x9
+ *				   (means 5x5 active pixel)
+ */
+enum cifisp_dpf_rb_filtersize {
+	CIFISP_DPF_RB_FILTERSIZE_13x9,
+	CIFISP_DPF_RB_FILTERSIZE_9x9,
+};
+
+/**
+ * enum cifisp_dpf_nll_scale_mode - dpf noise level scale mode
+ * @CIFISP_NLL_SCALE_LINEAR: use a linear scaling
+ * @CIFISP_NLL_SCALE_LOGARITHMIC: use a logarithmic scaling
+ */
+enum cifisp_dpf_nll_scale_mode {
+	CIFISP_NLL_SCALE_LINEAR,
+	CIFISP_NLL_SCALE_LOGARITHMIC,
+};
+
+/**
+ * struct cifisp_dpf_nll - Noise level lookup
+ *
+ * @coeff: Noise level Lookup coefficient
+ * @scale_mode: dpf noise level scale mode (from enum cifisp_dpf_nll_scale_mode)
+ */
+struct cifisp_dpf_nll {
+	__u16 coeff[CIFISP_DPF_MAX_NLF_COEFFS];
+	__u32 scale_mode;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpf_rb_flt - Red blue filter config
+ *
+ * @fltsize: The filter size for the red and blue pixels
+ *	     (from enum cifisp_dpf_rb_filtersize)
+ * @spatial_coeff: Spatial weights
+ * @r_enable: enable filter processing for red pixels
+ * @b_enable: enable filter processing for blue pixels
+ */
+struct cifisp_dpf_rb_flt {
+	__u32 fltsize;
+	__u8 spatial_coeff[CIFISP_DPF_MAX_SPATIAL_COEFFS];
+	__u8 r_enable;
+	__u8 b_enable;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpf_g_flt - Green filter Configuration
+ *
+ * @spatial_coeff: Spatial weights
+ * @gr_enable: enable filter processing for green pixels in green/red lines
+ * @gb_enable: enable filter processing for green pixels in green/blue lines
+ */
+struct cifisp_dpf_g_flt {
+	__u8 spatial_coeff[CIFISP_DPF_MAX_SPATIAL_COEFFS];
+	__u8 gr_enable;
+	__u8 gb_enable;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpf_gain - Noise function Configuration
+ *
+ * @mode: dpf gain usage  (from enum cifisp_dpf_gain_usage)
+ * @nf_r_gain: Noise function Gain that replaces the AWB gain for red pixels
+ * @nf_b_gain: Noise function Gain that replaces the AWB gain for blue pixels
+ * @nf_gr_gain: Noise function Gain that replaces the AWB gain
+ *		for green pixels in a red line
+ * @nf_gb_gain: Noise function Gain that replaces the AWB gain
+ *		for green pixels in a blue line
+ */
+struct cifisp_dpf_gain {
+	__u32 mode;
+	__u16 nf_r_gain;
+	__u16 nf_b_gain;
+	__u16 nf_gr_gain;
+	__u16 nf_gb_gain;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpf_config - Configuration used by De-noising pre-filter
+ *
+ * @gain: noise function gain
+ * @g_flt: green filter config
+ * @rb_flt: red blue filter config
+ * @nll: noise level lookup
+ */
+struct cifisp_dpf_config {
+	struct cifisp_dpf_gain gain;
+	struct cifisp_dpf_g_flt g_flt;
+	struct cifisp_dpf_rb_flt rb_flt;
+	struct cifisp_dpf_nll nll;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_dpf_strength_config - strength of the filter
+ *
+ * @r: filter strength of the RED filter
+ * @g: filter strength of the GREEN filter
+ * @b: filter strength of the BLUE filter
+ */
+struct cifisp_dpf_strength_config {
+	__u8 r;
+	__u8 g;
+	__u8 b;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_isp_other_cfg - Parameters for some blocks in rockchip isp1
+ *
+ * @dpcc_config: Defect Pixel Cluster Correction config
+ * @bls_config: Black Level Subtraction config
+ * @sdg_config: sensor degamma config
+ * @lsc_config: Lens Shade config
+ * @awb_gain_config: Auto White balance gain config
+ * @flt_config: filter config
+ * @bdm_config: demosaic config
+ * @ctk_config: cross talk config
+ * @goc_config: gamma out config
+ * @bls_config: black level subtraction config
+ * @dpf_config: De-noising pre-filter config
+ * @dpf_strength_config: dpf strength config
+ * @cproc_config: color process config
+ * @ie_config: image effects config
+ */
+struct cifisp_isp_other_cfg {
+	struct cifisp_dpcc_config dpcc_config;
+	struct cifisp_bls_config bls_config;
+	struct cifisp_sdg_config sdg_config;
+	struct cifisp_lsc_config lsc_config;
+	struct cifisp_awb_gain_config awb_gain_config;
+	struct cifisp_flt_config flt_config;
+	struct cifisp_bdm_config bdm_config;
+	struct cifisp_ctk_config ctk_config;
+	struct cifisp_goc_config goc_config;
+	struct cifisp_dpf_config dpf_config;
+	struct cifisp_dpf_strength_config dpf_strength_config;
+	struct cifisp_cproc_config cproc_config;
+	struct cifisp_ie_config ie_config;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_isp_meas_cfg - Rockchip ISP1 Measure Parameters
+ *
+ * @awb_meas_config: auto white balance config
+ * @hst_config: histogram config
+ * @aec_config: auto exposure config
+ * @afc_config: auto focus config
+ */
+struct cifisp_isp_meas_cfg {
+	struct cifisp_awb_meas_config awb_meas_config;
+	struct cifisp_hst_config hst_config;
+	struct cifisp_aec_config aec_config;
+	struct cifisp_afc_config afc_config;
+} __attribute__ ((packed));
+
+/**
+ * struct rkisp1_isp_params_cfg - Rockchip ISP1 Input Parameters Meta Data
+ *
+ * @module_en_update: mask the enable bits of which module should be updated
+ * @module_ens: mask the enable value of each module, only update the module
+ *		which correspond bit was set in module_en_update
+ * @module_cfg_update: mask the config bits of which module should be updated
+ * @meas: measurement config
+ * @others: other config
+ */
+struct rkisp1_isp_params_cfg {
+	__u32 module_en_update;
+	__u32 module_ens;
+	__u32 module_cfg_update;
+
+	struct cifisp_isp_meas_cfg meas;
+	struct cifisp_isp_other_cfg others;
+} __attribute__ ((packed));
+
+/*---------- PART2: Measurement Statistics ------------*/
+
+/**
+ * struct cifisp_awb_meas - AWB measured values
+ *
+ * @cnt: White pixel count, number of "white pixels" found during last
+ *	 measurement
+ * @mean_y_or_g: Mean value of Y within window and frames,
+ *		 Green if RGB is selected.
+ * @mean_cb_or_b: Mean value of Cb within window and frames,
+ *		  Blue if RGB is selected.
+ * @mean_cr_or_r: Mean value of Cr within window and frames,
+ *		  Red if RGB is selected.
+ */
+struct cifisp_awb_meas {
+	__u32 cnt;
+	__u8 mean_y_or_g;
+	__u8 mean_cb_or_b;
+	__u8 mean_cr_or_r;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_awb_stat - statistics automatic white balance data
+ *
+ * @awb_mean: Mean measured data
+ */
+struct cifisp_awb_stat {
+	struct cifisp_awb_meas awb_mean[CIFISP_AWB_MAX_GRID];
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_bls_meas_val - BLS measured values
+ *
+ * @meas_r: Mean measured value for Bayer pattern R
+ * @meas_gr: Mean measured value for Bayer pattern Gr
+ * @meas_gb: Mean measured value for Bayer pattern Gb
+ * @meas_b: Mean measured value for Bayer pattern B
+ */
+struct cifisp_bls_meas_val {
+	__u16 meas_r;
+	__u16 meas_gr;
+	__u16 meas_gb;
+	__u16 meas_b;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_ae_stat - statistics auto exposure data
+ *
+ * @exp_mean: Mean luminance value of block xx
+ * @bls_val:  BLS measured values
+ *
+ * Image is divided into 5x5 blocks.
+ */
+struct cifisp_ae_stat {
+	__u8 exp_mean[CIFISP_AE_MEAN_MAX];
+	struct cifisp_bls_meas_val bls_val;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_af_meas_val - AF measured values
+ *
+ * @sum: sharpness, refer to REF_01 for definition
+ * @lum: luminance, refer to REF_01 for definition
+ */
+struct cifisp_af_meas_val {
+	__u32 sum;
+	__u32 lum;
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_af_stat - statistics auto focus data
+ *
+ * @window: AF measured value of window x
+ *
+ * The module measures the sharpness in 3 windows of selectable size via
+ * register settings(ISP_AFM_*_A/B/C)
+ */
+struct cifisp_af_stat {
+	struct cifisp_af_meas_val window[CIFISP_AFM_MAX_WINDOWS];
+} __attribute__ ((packed));
+
+/**
+ * struct cifisp_hist_stat - statistics histogram data
+ *
+ * @hist_bins: measured bin counters
+ *
+ * Measurement window divided into 25 sub-windows, set
+ * with ISP_HIST_XXX
+ */
+struct cifisp_hist_stat {
+	__u16 hist_bins[CIFISP_HIST_BIN_N_MAX];
+} __attribute__ ((packed));
+
+/**
+ * struct rkisp1_stat_buffer - Rockchip ISP1 Statistics Data
+ *
+ * @cifisp_awb_stat: statistics data for automatic white balance
+ * @cifisp_ae_stat: statistics data for auto exposure
+ * @cifisp_af_stat: statistics data for auto focus
+ * @cifisp_hist_stat: statistics histogram data
+ */
+struct cifisp_stat {
+	struct cifisp_awb_stat awb;
+	struct cifisp_ae_stat ae;
+	struct cifisp_af_stat af;
+	struct cifisp_hist_stat hist;
+} __attribute__ ((packed));
+
+/**
+ * struct rkisp1_stat_buffer - Rockchip ISP1 Statistics Meta Data
+ *
+ * @meas_type: measurement types (CIFISP_STAT_ definitions)
+ * @frame_id: frame ID for sync
+ * @params: statistics data
+ */
+struct rkisp1_stat_buffer {
+	__u32 meas_type;
+	__u32 frame_id;
+	struct cifisp_stat params;
+} __attribute__ ((packed));
+
+#endif /* _UAPI_RKISP1_CONFIG_H */
-- 
2.22.0

