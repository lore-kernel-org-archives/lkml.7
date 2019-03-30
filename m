Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C81C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3B2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCqG5BEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfC3J5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:57:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41054 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfC3J4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so4061989edc.8;
        Sat, 30 Mar 2019 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=np//AZ3F5qwYM6/Zmcdt+Tl2fVwtldI5ypddsXuEZHU=;
        b=mCqG5BEX+orBuQ4JF/CM0w3rijVq3T0gRtD66Mr7q5hfTEY7UdK/ji+/5oshc5P6Wg
         tA6GlkP7tmSS9Q7yMJLGqpddsO4vxqB+Y8cTDnw5pxm8FG8TNirxLGjb0zHS6d3nX8CJ
         wZv2lFyeDJY6rHqNGIkNKnp/O2MX/hr+gEgKVcMn6PBXW/Alxb2knF6Yvyv9mPvKdLlH
         NDPyQE8qhEo7lUN+g/8D/9T2+aZwhhYJ6iQdcGzj784DiD7pnJsBVqbSHB4wVzhjgwG/
         ClpEgCZjL/K0OPiilTe32CBy2bTd+IxJQjzMKpT5dnJADTOB7rwM8plc6Scx91i6FH9n
         anMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=np//AZ3F5qwYM6/Zmcdt+Tl2fVwtldI5ypddsXuEZHU=;
        b=sea7l3TlsAIl6/cu/TkaOnulgdpZOL5PUBvVzSPtgoy7sdJTp94AwV2lvareYOKOrk
         AxwdMlri9oaHE3bvOMMc6rvQr6NqpS0X9mU8T5EJmOcutr/lGse57sl69l+cCc99OaWO
         B88TlmyqXPCpvOPXkXbIjtVyEEIktpzJiJw5ji9B2V0QYEFBNswUC1UTQ89zFNINkGj5
         QMCj1A2xWpVLZCFoVjVenxZ3NE/YrUZdLEK1TVNBx1GRAmjNevYo9nW18NkYIuSpPpDo
         sC87veUzdEuDzFoRSWAFjiRVH2oFAjGJBU+s3pnlFrZFkSD4f4Zdtj5zn1uXnWTrUMOY
         ckXQ==
X-Gm-Message-State: APjAAAVSdgLRBpMYqgLzP9k4Oo7QBzZ2/W+zmwHJs0qGUxe4rM5c497l
        3cGCnPAz33YecQhAJnGZ0oA=
X-Google-Smtp-Source: APXvYqz/X7QjQFleNX+4gBpNFT9GgUCMXQljVWM5V3nb9FFA9SvZf+Bu5lpil3gij2dO9uHwy33bwA==
X-Received: by 2002:a17:906:2306:: with SMTP id l6mr29462254eja.27.1553939810974;
        Sat, 30 Mar 2019 02:56:50 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b34sm1087921edd.24.2019.03.30.02.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:56:50 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] drm: rockchip: introduce rk3066 hdmi
Date:   Sat, 30 Mar 2019 10:56:36 +0100
Message-Id: <20190330095639.14626-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190330095639.14626-1-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

The RK3066 HDMI TX serves as interface between a LCD Controller and
a HDMI bus. A HDMI TX consists of one HDMI transmitter controller and
one HDMI transmitter PHY. The interface has three (3) 8-bit data channels
which can be configured for a number of bus widths (8/10/12/16/20/24-bit)
and different video formats (RGB, YCbCr).

Features:
HDMI version 1.4a, HDCP revision 1.4 and
DVI version 1.0 compliant transmitter.
Supports DTV resolutions from 480i to 1080i/p HD.
Master I2C interface for a DDC connection.
HDMI TX supports multiple power save modes.
The HDMI TX input can switch between LCDC0 and LCDC1.
(Sound support is not included in this patch)

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig            |   8 +
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c      | 869 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h      | 229 ++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 6 files changed, 1110 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 1e75196f9..2cdf3b62d 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -77,4 +77,12 @@ config ROCKCHIP_RGB
 	  Some Rockchip CRTCs, like rv1108, can directly output parallel
 	  and serial RGB format to panel or connect to a conversion chip.
 	  say Y to enable its driver.
+
+config ROCKCHIP_RK3066_HDMI
+	bool "Rockchip specific extensions for RK3066 HDMI"
+	depends on DRM_ROCKCHIP
+	help
+	  This selects support for Rockchip SoC specific extensions
+	  for the RK3066 HDMI driver. If you want to enable
+	  HDMI on RK3066 based SoC, you should select this option.
 endif
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index f6fc9d5dd..524684ba7 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -15,5 +15,6 @@ rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
 rockchipdrm-$(CONFIG_ROCKCHIP_RGB) += rockchip_rgb.o
+rockchipdrm-$(CONFIG_ROCKCHIP_RK3066_HDMI) += rk3066_hdmi.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
new file mode 100644
index 000000000..dd7bd3159
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -0,0 +1,869 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ *    Zheng Yang <zhengyang@rock-chips.com>
+ */
+
+#include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "rk3066_hdmi.h"
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+#define DEFAULT_PLLA_RATE 30000000
+
+struct hdmi_data_info {
+	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
+	bool sink_is_hdmi;
+	unsigned int enc_out_format;
+	unsigned int colorimetry;
+};
+
+struct rk3066_hdmi_i2c {
+	struct i2c_adapter adap;
+
+	u8 ddc_addr;
+	u8 segment_addr;
+	u8 stat;
+
+	struct mutex i2c_lock; /* For i2c operation. */
+	struct completion cmpltn;
+};
+
+struct rk3066_hdmi {
+	struct device *dev;
+	struct drm_device *drm_dev;
+	struct regmap *grf_regmap;
+	int irq;
+	struct clk *hclk;
+	void __iomem *regs;
+
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+
+	struct rk3066_hdmi_i2c *i2c;
+	struct i2c_adapter *ddc;
+
+	unsigned int tmdsclk;
+
+	struct hdmi_data_info hdmi_data;
+	struct drm_display_mode previous_mode;
+};
+
+#define to_rk3066_hdmi(x) container_of(x, struct rk3066_hdmi, x)
+
+static inline u8 hdmi_readb(struct rk3066_hdmi *hdmi, u16 offset)
+{
+	return readl_relaxed(hdmi->regs + offset);
+}
+
+static inline void hdmi_writeb(struct rk3066_hdmi *hdmi, u16 offset, u32 val)
+{
+	writel_relaxed(val, hdmi->regs + offset);
+}
+
+static inline void hdmi_modb(struct rk3066_hdmi *hdmi, u16 offset,
+			     u32 msk, u32 val)
+{
+	u8 temp = hdmi_readb(hdmi, offset) & ~msk;
+
+	temp |= val & msk;
+	hdmi_writeb(hdmi, offset, temp);
+}
+
+static void rk3066_hdmi_i2c_init(struct rk3066_hdmi *hdmi)
+{
+	int ddc_bus_freq;
+
+	ddc_bus_freq = (hdmi->tmdsclk >> 2) / HDMI_SCL_RATE;
+
+	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
+	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
+
+	/* Clear the EDID interrupt flag and mute the interrupt. */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_EDID_MASK, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_STATUS1, HDMI_INTR_EDID_MASK);
+}
+
+static inline u8 rk3066_hdmi_get_power_mode(struct rk3066_hdmi *hdmi)
+{
+	return hdmi_readb(hdmi, HDMI_SYS_CTRL) & HDMI_SYS_POWER_MODE_MASK;
+}
+
+static void rk3066_hdmi_set_power_mode(struct rk3066_hdmi *hdmi, int mode)
+{
+	u8 current_mode, next_mode;
+	u8 i = 0;
+
+	current_mode = rk3066_hdmi_get_power_mode(hdmi);
+
+	DRM_DEV_DEBUG(hdmi->dev, "mode         :%d\n", mode);
+	DRM_DEV_DEBUG(hdmi->dev, "current_mode :%d\n", current_mode);
+
+	if (current_mode == mode)
+		return;
+
+	do {
+		if (current_mode > mode)
+			next_mode = current_mode / 2;
+		else {
+			if (current_mode < HDMI_SYS_POWER_MODE_A)
+				next_mode = HDMI_SYS_POWER_MODE_A;
+			else
+				next_mode = current_mode * 2;
+		}
+
+		DRM_DEV_DEBUG(hdmi->dev, "%d: next_mode :%d\n", i, next_mode);
+
+		if (next_mode != HDMI_SYS_POWER_MODE_D) {
+			hdmi_modb(hdmi, HDMI_SYS_CTRL,
+				  HDMI_SYS_POWER_MODE_MASK, next_mode);
+		} else {
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D |
+				    HDMI_SYS_PLL_RESET_MASK);
+			usleep_range(90, 100);
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D |
+				    HDMI_SYS_PLLB_RESET);
+			usleep_range(90, 100);
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D);
+		}
+		current_mode = next_mode;
+		i = i + 1;
+	} while ((next_mode != mode) && (i < 5));
+
+	/*
+	 * When the IP controller isn't configured with accurate video timing,
+	 * DDC_CLK should be equal to the PLLA frequency, which is 30MHz,
+	 * so we need to init the TMDS rate to the PCLK rate and reconfigure
+	 * the DDC clock.
+	 */
+	if (mode < HDMI_SYS_POWER_MODE_D)
+		hdmi->tmdsclk = DEFAULT_PLLA_RATE;
+}
+
+static int
+rk3066_hdmi_upload_frame(struct rk3066_hdmi *hdmi, int setup_rc,
+			 union hdmi_infoframe *frame, u32 frame_index,
+			 u32 mask, u32 disable, u32 enable)
+{
+	if (mask)
+		hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, disable);
+
+	hdmi_writeb(hdmi, HDMI_CP_BUF_INDEX, frame_index);
+
+	if (setup_rc >= 0) {
+		u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
+		ssize_t rc, i;
+
+		rc = hdmi_infoframe_pack(frame, packed_frame,
+					 sizeof(packed_frame));
+		if (rc < 0)
+			return rc;
+
+		for (i = 0; i < rc; i++)
+			hdmi_writeb(hdmi, HDMI_CP_BUF_ACC_HB0 + i * 4,
+				    packed_frame[i]);
+
+		if (mask)
+			hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, enable);
+	}
+
+	return setup_rc;
+}
+
+static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
+				  struct drm_display_mode *mode)
+{
+	union hdmi_infoframe frame;
+	int rc;
+
+	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
+						      &hdmi->connector, mode);
+
+	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
+		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
+	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
+		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
+	else
+		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
+
+	frame.avi.colorimetry = hdmi->hdmi_data.colorimetry;
+	frame.avi.scan_mode = HDMI_SCAN_MODE_NONE;
+
+	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
+					HDMI_INFOFRAME_AVI, 0, 0, 0);
+}
+
+static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
+					   struct drm_display_mode *mode)
+{
+	int value, vsync_offset;
+
+	/* Set the details for the external polarity and interlace mode. */
+	value = HDMI_EXT_VIDEO_SET_EN;
+	value |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
+		 HDMI_VIDEO_HSYNC_ACTIVE_HIGH : HDMI_VIDEO_HSYNC_ACTIVE_LOW;
+	value |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
+		 HDMI_VIDEO_VSYNC_ACTIVE_HIGH : HDMI_VIDEO_VSYNC_ACTIVE_LOW;
+	value |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
+		 HDMI_VIDEO_MODE_INTERLACE : HDMI_VIDEO_MODE_PROGRESSIVE;
+	if (hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3)
+		vsync_offset = 6;
+	else
+		vsync_offset = 0;
+	value |= vsync_offset << HDMI_VIDEO_VSYNC_OFFSET_SHIFT;
+	hdmi_writeb(hdmi, HDMI_EXT_VIDEO_PARA, value);
+
+	/* Set the details for the external video timing. */
+	value = mode->htotal;
+	hdmi_writeb(hdmi, HDMI_EXT_HTOTAL_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HTOTAL_H, (value >> 8) & 0xFF);
+
+	value = mode->htotal - mode->hdisplay;
+	hdmi_writeb(hdmi, HDMI_EXT_HBLANK_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HBLANK_H, (value >> 8) & 0xFF);
+
+	value = mode->htotal - mode->hsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_HDELAY_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HDELAY_H, (value >> 8) & 0xFF);
+
+	value = mode->hsync_end - mode->hsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_HDURATION_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HDURATION_H, (value >> 8) & 0xFF);
+
+	value = mode->vtotal;
+	hdmi_writeb(hdmi, HDMI_EXT_VTOTAL_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_VTOTAL_H, (value >> 8) & 0xFF);
+
+	value = mode->vtotal - mode->vdisplay;
+	hdmi_writeb(hdmi, HDMI_EXT_VBLANK_L, value & 0xFF);
+
+	value = mode->vtotal - mode->vsync_start + vsync_offset;
+	hdmi_writeb(hdmi, HDMI_EXT_VDELAY, value & 0xFF);
+
+	value = mode->vsync_end - mode->vsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_VDURATION, value & 0xFF);
+
+	return 0;
+}
+
+static void
+rk3066_hdmi_phy_write(struct rk3066_hdmi *hdmi, u16 offset, u8 value)
+{
+	hdmi_writeb(hdmi, offset, value);
+	hdmi_modb(hdmi, HDMI_SYS_CTRL,
+		  HDMI_SYS_PLL_RESET_MASK, HDMI_SYS_PLL_RESET);
+	usleep_range(90, 100);
+	hdmi_modb(hdmi, HDMI_SYS_CTRL, HDMI_SYS_PLL_RESET_MASK, 0);
+	usleep_range(900, 1000);
+}
+
+static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
+{
+	/* TMDS uses the same frequency as dclk. */
+	hdmi_writeb(hdmi, HDMI_DEEP_COLOR_MODE, 0x22);
+	/*
+	 * The semi-public documentation does not describe the hdmi registers
+	 * used by the function rk3066_hdmi_phy_write(), so we keep using
+	 * these magic values for now.
+	 */
+	if (hdmi->tmdsclk > 100000000) {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x0E);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xDA);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA1);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x22);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	} else if (hdmi->tmdsclk > 50000000) {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x06);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xCA);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA3);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	} else {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x02);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xC2);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA2);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	}
+}
+
+static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
+			     struct drm_display_mode *mode)
+{
+	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
+
+	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
+
+	if (hdmi->hdmi_data.vic == 6 || hdmi->hdmi_data.vic == 7 ||
+	    hdmi->hdmi_data.vic == 21 || hdmi->hdmi_data.vic == 22 ||
+	    hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3 ||
+	    hdmi->hdmi_data.vic == 17 || hdmi->hdmi_data.vic == 18)
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
+	else
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
+
+	hdmi->tmdsclk = mode->clock * 1000;
+
+	/* Mute video and audio output. */
+	hdmi_modb(hdmi, HDMI_VIDEO_CTRL2, HDMI_VIDEO_AUDIO_DISABLE_MASK,
+		  HDMI_AUDIO_DISABLE | HDMI_VIDEO_DISABLE);
+
+	/* Set power state to mode B. */
+	if (rk3066_hdmi_get_power_mode(hdmi) != HDMI_SYS_POWER_MODE_B)
+		rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
+
+	/* Input video mode is RGB 24 bit. Use external data enable signal. */
+	hdmi_modb(hdmi, HDMI_AV_CTRL1,
+		  HDMI_VIDEO_DE_MASK, HDMI_VIDEO_EXTERNAL_DE);
+	hdmi_writeb(hdmi, HDMI_VIDEO_CTRL1,
+		    HDMI_VIDEO_OUTPUT_RGB444 |
+		    HDMI_VIDEO_INPUT_DATA_DEPTH_8BIT |
+		    HDMI_VIDEO_INPUT_COLOR_RGB);
+	hdmi_writeb(hdmi, HDMI_DEEP_COLOR_MODE, 0x20);
+
+	rk3066_hdmi_config_video_timing(hdmi, mode);
+
+	if (hdmi->hdmi_data.sink_is_hdmi) {
+		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK,
+			  HDMI_VIDEO_MODE_HDMI);
+		rk3066_hdmi_config_avi(hdmi, mode);
+	} else {
+		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK, 0);
+	}
+
+	rk3066_hdmi_config_phy(hdmi);
+
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_E);
+
+	/*
+	 * When the IP controller is configured with accurate video
+	 * timing, the TMDS clock source should be switched to
+	 * DCLK_LCDC, so we need to init the TMDS rate to the pixel mode
+	 * clock rate and reconfigure the DDC clock.
+	 */
+	rk3066_hdmi_i2c_init(hdmi);
+
+	/* Unmute video output. */
+	hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+		  HDMI_VIDEO_AUDIO_DISABLE_MASK, HDMI_AUDIO_DISABLE);
+	return 0;
+}
+
+static void
+rk3066_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+			     struct drm_display_mode *mode,
+			     struct drm_display_mode *adj_mode)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+
+	/* Store the display mode for plugin/DPMS poweron events. */
+	memcpy(&hdmi->previous_mode, adj_mode, sizeof(hdmi->previous_mode));
+}
+
+static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+	int mux, val;
+
+	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
+	if (mux)
+		val = (HDMI_VIDEO_SEL << 16) | HDMI_VIDEO_SEL;
+	else
+		val = HDMI_VIDEO_SEL << 16;
+
+	regmap_write(hdmi->grf_regmap, GRF_SOC_CON0, val);
+
+	DRM_DEV_DEBUG(hdmi->dev, "hdmi encoder enable select: vop%s\n",
+		      (mux) ? "1" : "0");
+
+	rk3066_hdmi_setup(hdmi, &hdmi->previous_mode);
+}
+
+static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+
+	DRM_DEV_DEBUG(hdmi->dev, "hdmi encoder disable\n");
+
+	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_E) {
+		hdmi_writeb(hdmi, HDMI_VIDEO_CTRL2,
+			    HDMI_VIDEO_AUDIO_DISABLE_MASK);
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK,
+			  HDMI_AUDIO_CP_LOGIC_RESET);
+		usleep_range(500, 510);
+	}
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
+}
+
+static bool
+rk3066_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
+			       const struct drm_display_mode *mode,
+			       struct drm_display_mode *adj_mode)
+{
+	return true;
+}
+
+static int
+rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_P888;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
+static const
+struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
+	.enable       = rk3066_hdmi_encoder_enable,
+	.disable      = rk3066_hdmi_encoder_disable,
+	.mode_fixup   = rk3066_hdmi_encoder_mode_fixup,
+	.mode_set     = rk3066_hdmi_encoder_mode_set,
+	.atomic_check = rk3066_hdmi_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static enum drm_connector_status
+rk3066_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+
+	return (hdmi_readb(hdmi, HDMI_HPG_MENS_STA) & HDMI_HPG_IN_STATUS_HIGH) ?
+		connector_status_connected : connector_status_disconnected;
+}
+
+static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+	struct edid *edid;
+	int ret = 0;
+
+	if (!hdmi->ddc)
+		return 0;
+
+	edid = drm_get_edid(connector, hdmi->ddc);
+	if (edid) {
+		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
+		drm_connector_update_edid_property(connector, edid);
+		ret = drm_add_edid_modes(connector, edid);
+		kfree(edid);
+	}
+
+	return ret;
+}
+
+static enum drm_mode_status
+rk3066_hdmi_connector_mode_valid(struct drm_connector *connector,
+				 struct drm_display_mode *mode)
+{
+	u32 vic = drm_match_cea_mode(mode);
+
+	if (vic > 1)
+		return MODE_OK;
+	else
+		return MODE_BAD;
+}
+
+static struct drm_encoder *
+rk3066_hdmi_connector_best_encoder(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+
+	return &hdmi->encoder;
+}
+
+static int
+rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
+					 uint32_t maxX, uint32_t maxY)
+{
+	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+}
+
+static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs rk3066_hdmi_connector_funcs = {
+	.fill_modes = rk3066_hdmi_probe_single_connector_modes,
+	.detect = rk3066_hdmi_connector_detect,
+	.destroy = rk3066_hdmi_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const
+struct drm_connector_helper_funcs rk3066_hdmi_connector_helper_funcs = {
+	.get_modes = rk3066_hdmi_connector_get_modes,
+	.mode_valid = rk3066_hdmi_connector_mode_valid,
+	.best_encoder = rk3066_hdmi_connector_best_encoder,
+};
+
+static int
+rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
+{
+	struct drm_encoder *encoder = &hdmi->encoder;
+	struct device *dev = hdmi->dev;
+
+	encoder->possible_crtcs =
+		drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
+	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+
+	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+
+	drm_connector_helper_add(&hdmi->connector,
+				 &rk3066_hdmi_connector_helper_funcs);
+	drm_connector_init(drm, &hdmi->connector,
+			   &rk3066_hdmi_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
+
+	drm_connector_attach_encoder(&hdmi->connector, encoder);
+
+	return 0;
+}
+
+static irqreturn_t rk3066_hdmi_hardirq(int irq, void *dev_id)
+{
+	struct rk3066_hdmi *hdmi = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+	u8 interrupt;
+
+	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_A)
+		hdmi_writeb(hdmi, HDMI_SYS_CTRL, HDMI_SYS_POWER_MODE_B);
+
+	interrupt = hdmi_readb(hdmi, HDMI_INTR_STATUS1);
+	if (interrupt)
+		hdmi_writeb(hdmi, HDMI_INTR_STATUS1, interrupt);
+
+	if (interrupt & HDMI_INTR_EDID_MASK) {
+		hdmi->i2c->stat = interrupt;
+		complete(&hdmi->i2c->cmpltn);
+	}
+
+	if (interrupt & (HDMI_INTR_HOTPLUG | HDMI_INTR_MSENS))
+		ret = IRQ_WAKE_THREAD;
+
+	return ret;
+}
+
+static irqreturn_t rk3066_hdmi_irq(int irq, void *dev_id)
+{
+	struct rk3066_hdmi *hdmi = dev_id;
+
+	drm_helper_hpd_irq_event(hdmi->connector.dev);
+
+	return IRQ_HANDLED;
+}
+
+static int rk3066_hdmi_i2c_read(struct rk3066_hdmi *hdmi, struct i2c_msg *msgs)
+{
+	int length = msgs->len;
+	u8 *buf = msgs->buf;
+	int ret;
+
+	ret = wait_for_completion_timeout(&hdmi->i2c->cmpltn, HZ / 10);
+	if (!ret || hdmi->i2c->stat & HDMI_INTR_EDID_ERR)
+		return -EAGAIN;
+
+	while (length--)
+		*buf++ = hdmi_readb(hdmi, HDMI_DDC_READ_FIFO_ADDR);
+
+	return 0;
+}
+
+static int rk3066_hdmi_i2c_write(struct rk3066_hdmi *hdmi, struct i2c_msg *msgs)
+{
+	/*
+	 * The DDC module only supports read EDID message, so
+	 * we assume that each word write to this i2c adapter
+	 * should be the offset of the EDID word address.
+	 */
+	if (msgs->len != 1 ||
+	    (msgs->addr != DDC_ADDR && msgs->addr != DDC_SEGMENT_ADDR))
+		return -EINVAL;
+
+	reinit_completion(&hdmi->i2c->cmpltn);
+
+	if (msgs->addr == DDC_SEGMENT_ADDR)
+		hdmi->i2c->segment_addr = msgs->buf[0];
+	if (msgs->addr == DDC_ADDR)
+		hdmi->i2c->ddc_addr = msgs->buf[0];
+
+	/* Set edid word address 0x00/0x80. */
+	hdmi_writeb(hdmi, HDMI_EDID_WORD_ADDR, hdmi->i2c->ddc_addr);
+
+	/* Set edid segment pointer. */
+	hdmi_writeb(hdmi, HDMI_EDID_SEGMENT_POINTER, hdmi->i2c->segment_addr);
+
+	return 0;
+}
+
+static int rk3066_hdmi_i2c_xfer(struct i2c_adapter *adap,
+				struct i2c_msg *msgs, int num)
+{
+	struct rk3066_hdmi *hdmi = i2c_get_adapdata(adap);
+	struct rk3066_hdmi_i2c *i2c = hdmi->i2c;
+	int i, ret = 0;
+
+	mutex_lock(&i2c->i2c_lock);
+
+	rk3066_hdmi_i2c_init(hdmi);
+
+	/* Unmute HDMI EDID interrupt. */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1,
+		  HDMI_INTR_EDID_MASK, HDMI_INTR_EDID_MASK);
+	i2c->stat = 0;
+
+	for (i = 0; i < num; i++) {
+		DRM_DEV_DEBUG(hdmi->dev,
+			      "xfer: num: %d/%d, len: %d, flags: %#x\n",
+			      i + 1, num, msgs[i].len, msgs[i].flags);
+
+		if (msgs[i].flags & I2C_M_RD)
+			ret = rk3066_hdmi_i2c_read(hdmi, &msgs[i]);
+		else
+			ret = rk3066_hdmi_i2c_write(hdmi, &msgs[i]);
+
+		if (ret < 0)
+			break;
+	}
+
+	if (!ret)
+		ret = num;
+
+	/* Mute HDMI EDID interrupt. */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_EDID_MASK, 0);
+
+	mutex_unlock(&i2c->i2c_lock);
+
+	return ret;
+}
+
+static u32 rk3066_hdmi_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm rk3066_hdmi_algorithm = {
+	.master_xfer   = rk3066_hdmi_i2c_xfer,
+	.functionality = rk3066_hdmi_i2c_func,
+};
+
+static struct i2c_adapter *rk3066_hdmi_i2c_adapter(struct rk3066_hdmi *hdmi)
+{
+	struct i2c_adapter *adap;
+	struct rk3066_hdmi_i2c *i2c;
+	int ret;
+
+	i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&i2c->i2c_lock);
+	init_completion(&i2c->cmpltn);
+
+	adap = &i2c->adap;
+	adap->class = I2C_CLASS_DDC;
+	adap->owner = THIS_MODULE;
+	adap->dev.parent = hdmi->dev;
+	adap->dev.of_node = hdmi->dev->of_node;
+	adap->algo = &rk3066_hdmi_algorithm;
+	strlcpy(adap->name, "RK3066 HDMI", sizeof(adap->name));
+	i2c_set_adapdata(adap, hdmi);
+
+	ret = i2c_add_adapter(adap);
+	if (ret) {
+		DRM_DEV_ERROR(hdmi->dev, "cannot add %s I2C adapter\n",
+			      adap->name);
+		devm_kfree(hdmi->dev, i2c);
+		return ERR_PTR(ret);
+	}
+
+	hdmi->i2c = i2c;
+
+	DRM_DEV_DEBUG(hdmi->dev, "registered %s I2C bus driver\n", adap->name);
+
+	return adap;
+}
+
+static int rk3066_hdmi_bind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct rk3066_hdmi *hdmi;
+	struct resource *iores;
+	int irq;
+	int ret;
+
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	hdmi->dev = dev;
+	hdmi->drm_dev = drm;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -ENXIO;
+
+	hdmi->regs = devm_ioremap_resource(dev, iores);
+	if (IS_ERR(hdmi->regs))
+		return PTR_ERR(hdmi->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	hdmi->hclk = devm_clk_get(dev, "hclk");
+	if (IS_ERR(hdmi->hclk)) {
+		DRM_DEV_ERROR(dev, "unable to get HDMI hclk clock\n");
+		return PTR_ERR(hdmi->hclk);
+	}
+
+	ret = clk_prepare_enable(hdmi->hclk);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "cannot enable HDMI hclk clock: %d\n", ret);
+		return ret;
+	}
+
+	hdmi->grf_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+							   "rockchip,grf");
+	if (IS_ERR(hdmi->grf_regmap)) {
+		DRM_DEV_ERROR(dev, "unable to get rockchip,grf\n");
+		ret = PTR_ERR(hdmi->grf_regmap);
+		goto err_disable_hclk;
+	}
+
+	/* internal hclk = hdmi_hclk / 25 */
+	hdmi_writeb(hdmi, HDMI_INTERNAL_CLK_DIVIDER, 25);
+
+	hdmi->ddc = rk3066_hdmi_i2c_adapter(hdmi);
+	if (IS_ERR(hdmi->ddc)) {
+		ret = PTR_ERR(hdmi->ddc);
+		hdmi->ddc = NULL;
+		goto err_disable_hclk;
+	}
+
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
+	usleep_range(999, 1000);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_HOTPLUG);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK2, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK3, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK4, 0);
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
+
+	ret = rk3066_hdmi_register(drm, hdmi);
+	if (ret)
+		goto err_disable_i2c;
+
+	dev_set_drvdata(dev, hdmi);
+
+	ret = devm_request_threaded_irq(dev, irq, rk3066_hdmi_hardirq,
+					rk3066_hdmi_irq, IRQF_SHARED,
+					dev_name(dev), hdmi);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to request hdmi irq: %d\n", ret);
+		goto err_cleanup_hdmi;
+	}
+
+	return 0;
+
+err_cleanup_hdmi:
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+err_disable_i2c:
+	i2c_put_adapter(hdmi->ddc);
+err_disable_hclk:
+	clk_disable_unprepare(hdmi->hclk);
+
+	return ret;
+}
+
+static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
+			       void *data)
+{
+	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
+
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+
+	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->hclk);
+}
+
+static const struct component_ops rk3066_hdmi_ops = {
+	.bind   = rk3066_hdmi_bind,
+	.unbind = rk3066_hdmi_unbind,
+};
+
+static int rk3066_hdmi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &rk3066_hdmi_ops);
+}
+
+static int rk3066_hdmi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rk3066_hdmi_ops);
+
+	return 0;
+}
+
+static const struct of_device_id rk3066_hdmi_dt_ids[] = {
+	{ .compatible = "rockchip,rk3066-hdmi" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rk3066_hdmi_dt_ids);
+
+struct platform_driver rk3066_hdmi_driver = {
+	.probe  = rk3066_hdmi_probe,
+	.remove = rk3066_hdmi_remove,
+	.driver = {
+		.name = "rockchip-rk3066-hdmi",
+		.of_match_table = rk3066_hdmi_dt_ids,
+	},
+};
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.h b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
new file mode 100644
index 000000000..39a31c62a
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ *    Zheng Yang <zhengyang@rock-chips.com>
+ */
+
+#ifndef __RK3066_HDMI_H__
+#define __RK3066_HDMI_H__
+
+#define GRF_SOC_CON0				0x150
+#define HDMI_VIDEO_SEL				BIT(14)
+
+#define DDC_SEGMENT_ADDR			0x30
+#define HDMI_SCL_RATE				(50 * 1000)
+#define HDMI_MAXIMUM_INFO_FRAME_SIZE		0x11
+
+#define N_32K					0x1000
+#define N_441K					0x1880
+#define N_882K					0x3100
+#define N_1764K					0x6200
+#define N_48K					0x1800
+#define N_96K					0x3000
+#define N_192K					0x6000
+
+#define HDMI_SYS_CTRL				0x000
+#define HDMI_LR_SWAP_N3				0x004
+#define HDMI_N2					0x008
+#define HDMI_N1					0x00c
+#define HDMI_SPDIF_FS_CTS_INT3			0x010
+#define HDMI_CTS_INT2				0x014
+#define HDMI_CTS_INT1				0x018
+#define HDMI_CTS_EXT3				0x01c
+#define HDMI_CTS_EXT2				0x020
+#define HDMI_CTS_EXT1				0x024
+#define HDMI_AUDIO_CTRL1			0x028
+#define HDMI_AUDIO_CTRL2			0x02c
+#define HDMI_I2S_AUDIO_CTRL			0x030
+#define HDMI_I2S_SWAP				0x040
+#define HDMI_AUDIO_STA_BIT_CTRL1		0x044
+#define HDMI_AUDIO_STA_BIT_CTRL2		0x048
+#define HDMI_AUDIO_SRC_NUM_AND_LENGTH		0x050
+#define HDMI_AV_CTRL1				0x054
+#define HDMI_VIDEO_CTRL1			0x058
+#define HDMI_DEEP_COLOR_MODE			0x05c
+
+#define HDMI_EXT_VIDEO_PARA			0x0c0
+#define HDMI_EXT_HTOTAL_L			0x0c4
+#define HDMI_EXT_HTOTAL_H			0x0c8
+#define HDMI_EXT_HBLANK_L			0x0cc
+#define HDMI_EXT_HBLANK_H			0x0d0
+#define HDMI_EXT_HDELAY_L			0x0d4
+#define HDMI_EXT_HDELAY_H			0x0d8
+#define HDMI_EXT_HDURATION_L			0x0dc
+#define HDMI_EXT_HDURATION_H			0x0e0
+#define HDMI_EXT_VTOTAL_L			0x0e4
+#define HDMI_EXT_VTOTAL_H			0x0e8
+#define HDMI_AV_CTRL2				0x0ec
+#define HDMI_EXT_VBLANK_L			0x0f4
+#define HDMI_EXT_VBLANK_H			0x10c
+#define HDMI_EXT_VDELAY				0x0f8
+#define HDMI_EXT_VDURATION			0x0fc
+
+#define HDMI_CP_MANU_SEND_CTRL			0x100
+#define HDMI_CP_AUTO_SEND_CTRL			0x104
+#define HDMI_AUTO_CHECKSUM_OPT			0x108
+
+#define HDMI_VIDEO_CTRL2			0x114
+
+#define HDMI_PHY_OPTION				0x144
+
+#define HDMI_CP_BUF_INDEX			0x17c
+#define HDMI_CP_BUF_ACC_HB0			0x180
+#define HDMI_CP_BUF_ACC_HB1			0x184
+#define HDMI_CP_BUF_ACC_HB2			0x188
+#define HDMI_CP_BUF_ACC_PB0			0x18c
+
+#define HDMI_DDC_READ_FIFO_ADDR			0x200
+#define HDMI_DDC_BUS_FREQ_L			0x204
+#define HDMI_DDC_BUS_FREQ_H			0x208
+#define HDMI_DDC_BUS_CTRL			0x2dc
+#define HDMI_DDC_I2C_LEN			0x278
+#define HDMI_DDC_I2C_OFFSET			0x280
+#define HDMI_DDC_I2C_CTRL			0x284
+#define HDMI_DDC_I2C_READ_BUF0			0x288
+#define HDMI_DDC_I2C_READ_BUF1			0x28c
+#define HDMI_DDC_I2C_READ_BUF2			0x290
+#define HDMI_DDC_I2C_READ_BUF3			0x294
+#define HDMI_DDC_I2C_WRITE_BUF0			0x298
+#define HDMI_DDC_I2C_WRITE_BUF1			0x29c
+#define HDMI_DDC_I2C_WRITE_BUF2			0x2a0
+#define HDMI_DDC_I2C_WRITE_BUF3			0x2a4
+#define HDMI_DDC_I2C_WRITE_BUF4			0x2ac
+#define HDMI_DDC_I2C_WRITE_BUF5			0x2b0
+#define HDMI_DDC_I2C_WRITE_BUF6			0x2b4
+
+#define HDMI_INTR_MASK1				0x248
+#define HDMI_INTR_MASK2				0x24c
+#define HDMI_INTR_STATUS1			0x250
+#define HDMI_INTR_STATUS2			0x254
+#define HDMI_INTR_MASK3				0x258
+#define HDMI_INTR_MASK4				0x25c
+#define HDMI_INTR_STATUS3			0x260
+#define HDMI_INTR_STATUS4			0x264
+
+#define HDMI_HDCP_CTRL				0x2bc
+
+#define HDMI_EDID_SEGMENT_POINTER		0x310
+#define HDMI_EDID_WORD_ADDR			0x314
+#define HDMI_EDID_FIFO_ADDR			0x318
+
+#define HDMI_HPG_MENS_STA			0x37c
+
+#define HDMI_INTERNAL_CLK_DIVIDER		0x800
+
+enum {
+	/* HDMI_SYS_CTRL */
+	HDMI_SYS_POWER_MODE_MASK = 0xf0,
+	HDMI_SYS_POWER_MODE_A = 0x10,
+	HDMI_SYS_POWER_MODE_B = 0x20,
+	HDMI_SYS_POWER_MODE_D = 0x40,
+	HDMI_SYS_POWER_MODE_E = 0x80,
+	HDMI_SYS_PLL_RESET_MASK = 0x0c,
+	HDMI_SYS_PLL_RESET = 0x0c,
+	HDMI_SYS_PLLB_RESET = 0x08,
+
+	/* HDMI_LR_SWAP_N3 */
+	HDMI_AUDIO_LR_SWAP_MASK = 0xf0,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET0 = 0x10,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET1 = 0x20,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET2 = 0x40,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET3 = 0x80,
+	HDMI_AUDIO_N_19_16_MASK = 0x0f,
+
+	/* HDMI_AUDIO_CTRL1 */
+	HDMI_AUDIO_EXTERNAL_CTS = BIT(7),
+	HDMI_AUDIO_INPUT_IIS = 0,
+	HDMI_AUDIO_INPUT_SPDIF = 0x08,
+	HDMI_AUDIO_INPUT_MCLK_ACTIVE = 0x04,
+	HDMI_AUDIO_INPUT_MCLK_DEACTIVE = 0,
+	HDMI_AUDIO_INPUT_MCLK_RATE_128X = 0,
+	HDMI_AUDIO_INPUT_MCLK_RATE_256X = 1,
+	HDMI_AUDIO_INPUT_MCLK_RATE_384X = 2,
+	HDMI_AUDIO_INPUT_MCLK_RATE_512X = 3,
+
+	/* HDMI_I2S_AUDIO_CTRL */
+	HDMI_AUDIO_I2S_FORMAT_STANDARD = 0,
+	HDMI_AUDIO_I2S_CHANNEL_1_2 = 0x04,
+	HDMI_AUDIO_I2S_CHANNEL_3_4 = 0x0c,
+	HDMI_AUDIO_I2S_CHANNEL_5_6 = 0x1c,
+	HDMI_AUDIO_I2S_CHANNEL_7_8 = 0x3c,
+
+	/* HDMI_AV_CTRL1 */
+	HDMI_AUDIO_SAMPLE_FRE_MASK = 0xf0,
+	HDMI_AUDIO_SAMPLE_FRE_32000 = 0x30,
+	HDMI_AUDIO_SAMPLE_FRE_44100 = 0,
+	HDMI_AUDIO_SAMPLE_FRE_48000 = 0x20,
+	HDMI_AUDIO_SAMPLE_FRE_88200 = 0x80,
+	HDMI_AUDIO_SAMPLE_FRE_96000 = 0xa0,
+	HDMI_AUDIO_SAMPLE_FRE_176400 = 0xc0,
+	HDMI_AUDIO_SAMPLE_FRE_192000 = 0xe0,
+	HDMI_AUDIO_SAMPLE_FRE_768000 = 0x90,
+
+	HDMI_VIDEO_INPUT_FORMAT_MASK = 0x0e,
+	HDMI_VIDEO_INPUT_RGB_YCBCR444 = 0,
+	HDMI_VIDEO_INPUT_YCBCR422 = 0x02,
+	HDMI_VIDEO_DE_MASK = 0x1,
+	HDMI_VIDEO_INTERNAL_DE = 0,
+	HDMI_VIDEO_EXTERNAL_DE = 0x01,
+
+	/* HDMI_VIDEO_CTRL1 */
+	HDMI_VIDEO_OUTPUT_FORMAT_MASK = 0xc0,
+	HDMI_VIDEO_OUTPUT_RGB444 = 0,
+	HDMI_VIDEO_OUTPUT_YCBCR444 = 0x40,
+	HDMI_VIDEO_OUTPUT_YCBCR422 = 0x80,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_MASK = 0x30,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_12BIT = 0,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_10BIT = 0x10,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_8BIT = 0x30,
+	HDMI_VIDEO_INPUT_COLOR_MASK = 1,
+	HDMI_VIDEO_INPUT_COLOR_RGB = 0,
+	HDMI_VIDEO_INPUT_COLOR_YCBCR = 1,
+
+	/* HDMI_EXT_VIDEO_PARA */
+	HDMI_VIDEO_VSYNC_OFFSET_SHIFT = 4,
+	HDMI_VIDEO_VSYNC_ACTIVE_HIGH = BIT(3),
+	HDMI_VIDEO_VSYNC_ACTIVE_LOW = 0,
+	HDMI_VIDEO_HSYNC_ACTIVE_HIGH = BIT(2),
+	HDMI_VIDEO_HSYNC_ACTIVE_LOW = 0,
+	HDMI_VIDEO_MODE_INTERLACE = BIT(1),
+	HDMI_VIDEO_MODE_PROGRESSIVE = 0,
+	HDMI_EXT_VIDEO_SET_EN = BIT(0),
+
+	/* HDMI_CP_AUTO_SEND_CTRL */
+
+	/* HDMI_VIDEO_CTRL2 */
+	HDMI_VIDEO_AV_MUTE_MASK = 0xc0,
+	HDMI_VIDEO_CLR_AV_MUTE = BIT(7),
+	HDMI_VIDEO_SET_AV_MUTE = BIT(6),
+	HDMI_AUDIO_CP_LOGIC_RESET_MASK = BIT(2),
+	HDMI_AUDIO_CP_LOGIC_RESET = BIT(2),
+	HDMI_VIDEO_AUDIO_DISABLE_MASK = 0x3,
+	HDMI_AUDIO_DISABLE = BIT(1),
+	HDMI_VIDEO_DISABLE = BIT(0),
+
+	/* HDMI_CP_BUF_INDEX */
+	HDMI_INFOFRAME_VSI = 0x05,
+	HDMI_INFOFRAME_AVI = 0x06,
+	HDMI_INFOFRAME_AAI = 0x08,
+
+	/* HDMI_INTR_MASK1 */
+	/* HDMI_INTR_STATUS1 */
+	HDMI_INTR_HOTPLUG = BIT(7),
+	HDMI_INTR_MSENS = BIT(6),
+	HDMI_INTR_VSYNC = BIT(5),
+	HDMI_INTR_AUDIO_FIFO_FULL = BIT(4),
+	HDMI_INTR_EDID_MASK = 0x6,
+	HDMI_INTR_EDID_READY = BIT(2),
+	HDMI_INTR_EDID_ERR = BIT(1),
+
+	/* HDMI_HDCP_CTRL */
+	HDMI_VIDEO_MODE_MASK = BIT(1),
+	HDMI_VIDEO_MODE_HDMI = BIT(1),
+
+	/* HDMI_HPG_MENS_STA */
+	HDMI_HPG_IN_STATUS_HIGH = BIT(7),
+	HDMI_MSENS_IN_STATUS_HIGH = BIT(6),
+};
+
+#endif /* __RK3066_HDMI_H__ */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index d7fa17f12..8d7a634c1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -486,6 +486,8 @@ static int __init rockchip_drm_init(void)
 	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_rockchip_driver,
 				CONFIG_ROCKCHIP_DW_MIPI_DSI);
 	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
+	ADD_ROCKCHIP_SUB_DRIVER(rk3066_hdmi_driver,
+				CONFIG_ROCKCHIP_RK3066_HDMI);
 
 	ret = platform_register_drivers(rockchip_sub_drivers,
 					num_rockchip_sub_drivers);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index ce48568ec..e4bc4322b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -73,4 +73,5 @@ extern struct platform_driver inno_hdmi_driver;
 extern struct platform_driver rockchip_dp_driver;
 extern struct platform_driver rockchip_lvds_driver;
 extern struct platform_driver vop_platform_driver;
+extern struct platform_driver rk3066_hdmi_driver;
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
-- 
2.11.0

