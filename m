Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F950C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfHUKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:17:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45680 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbfHUKQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C87CB20050D;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BB4982000A2;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 172C620612;
        Wed, 21 Aug 2019 12:16:19 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] drm/mxsfb: Update register definitions using bit manipulation defines
Date:   Wed, 21 Aug 2019 13:15:45 +0300
Message-Id: <1566382555-12102-6-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT(x) and GEN_MASK(h, l) for better representation the inside of
various registers.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_regs.h | 151 ++++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
index 71426aa..9fcb1db 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -40,66 +40,93 @@
 #define LCDC_AS_BUF			0x220
 #define LCDC_AS_NEXT_BUF		0x230
 
-#define CTRL_SFTRST			(1 << 31)
-#define CTRL_CLKGATE			(1 << 30)
-#define CTRL_BYPASS_COUNT		(1 << 19)
-#define CTRL_VSYNC_MODE			(1 << 18)
-#define CTRL_DOTCLK_MODE		(1 << 17)
-#define CTRL_DATA_SELECT		(1 << 16)
-#define CTRL_SET_BUS_WIDTH(x)		(((x) & 0x3) << 10)
-#define CTRL_GET_BUS_WIDTH(x)		(((x) >> 10) & 0x3)
-#define CTRL_BUS_WIDTH_MASK		(0x3 << 10)
-#define CTRL_SET_WORD_LENGTH(x)		(((x) & 0x3) << 8)
-#define CTRL_GET_WORD_LENGTH(x)		(((x) >> 8) & 0x3)
-#define CTRL_MASTER			(1 << 5)
-#define CTRL_DF16			(1 << 3)
-#define CTRL_DF18			(1 << 2)
-#define CTRL_DF24			(1 << 1)
-#define CTRL_RUN			(1 << 0)
-
-#define CTRL1_RECOVERY_ON_UNDERFLOW	(1 << 24)
-#define CTRL1_FIFO_CLEAR		(1 << 21)
-#define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
-#define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
-#define CTRL1_CUR_FRAME_DONE_IRQ_EN	(1 << 13)
-#define CTRL1_CUR_FRAME_DONE_IRQ	(1 << 9)
-
-#define CTRL2_OUTSTANDING_REQS__REQ_16		(4 << 21)
-
-#define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
-#define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
-#define TRANSFER_COUNT_SET_HCOUNT(x)	((x) & 0xffff)
-#define TRANSFER_COUNT_GET_HCOUNT(x)	((x) & 0xffff)
-
-#define VDCTRL0_ENABLE_PRESENT		(1 << 28)
-#define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
-#define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
-#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
-#define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
-#define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
-#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
-#define VDCTRL0_HALF_LINE		(1 << 19)
-#define VDCTRL0_HALF_LINE_MODE		(1 << 18)
-#define VDCTRL0_SET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
-#define VDCTRL0_GET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
-
-#define VDCTRL2_SET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
-#define VDCTRL2_GET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
-
-#define VDCTRL3_MUX_SYNC_SIGNALS	(1 << 29)
-#define VDCTRL3_VSYNC_ONLY		(1 << 28)
-#define SET_HOR_WAIT_CNT(x)		(((x) & 0xfff) << 16)
-#define GET_HOR_WAIT_CNT(x)		(((x) >> 16) & 0xfff)
-#define SET_VERT_WAIT_CNT(x)		((x) & 0xffff)
-#define GET_VERT_WAIT_CNT(x)		((x) & 0xffff)
-
-#define VDCTRL4_SET_DOTCLK_DLY(x)	(((x) & 0x7) << 29) /* v4 only */
-#define VDCTRL4_GET_DOTCLK_DLY(x)	(((x) >> 29) & 0x7) /* v4 only */
-#define VDCTRL4_SYNC_SIGNALS_ON		(1 << 18)
-#define SET_DOTCLK_H_VALID_DATA_CNT(x)	((x) & 0x3ffff)
-
-#define DEBUG0_HSYNC			(1 < 26)
-#define DEBUG0_VSYNC			(1 < 25)
+/* reg bit manipulation */
+#define REG_PUT(x, h, l) (((x) << (l)) & GENMASK(h, l))
+#define REG_GET(x, h, l) (((x) & GENMASK(h, l)) >> (l))
+
+#define CTRL_SFTRST			BIT(31)
+#define CTRL_CLKGATE			BIT(30)
+#define CTRL_SHIFT_DIR(x)		REG_PUT((x), 26, 26)
+#define CTRL_SHIFT_NUM(x)		REG_PUT((x), 25, 21)
+#define CTRL_BYPASS_COUNT		BIT(19)
+#define CTRL_VSYNC_MODE			BIT(18)
+#define CTRL_DOTCLK_MODE		BIT(17)
+#define CTRL_DATA_SELECT		BIT(16)
+#define CTRL_INPUT_SWIZZLE(x)		REG_PUT((x), 15, 14)
+#define CTRL_CSC_SWIZZLE(x)		REG_PUT((x), 13, 12)
+#define CTRL_SET_BUS_WIDTH(x)		REG_PUT((x), 11, 10)
+#define CTRL_GET_BUS_WIDTH(x)		REG_GET((x), 11, 10)
+#define CTRL_BUS_WIDTH_MASK		REG_PUT((0x3), 11, 10)
+#define CTRL_SET_WORD_LENGTH(x)		REG_PUT((x), 9, 8)
+#define CTRL_GET_WORD_LENGTH(x)		REG_GET((x), 9, 8)
+#define CTRL_MASTER			BIT(5)
+#define CTRL_DF16			BIT(3)
+#define CTRL_DF18			BIT(2)
+#define CTRL_DF24			BIT(1)
+#define CTRL_RUN			BIT(0)
+
+#define CTRL1_RECOVERY_ON_UNDERFLOW	BIT(24)
+#define CTRL1_FIFO_CLEAR		BIT(21)
+
+/*
+ * BYTE_PACKAGING
+ *
+ * This bitfield is used to show which data bytes in a 32-bit word area valid.
+ * Default value 0xf indicates that all bytes are valid. For 8-bit transfers,
+ * any combination in this bitfield will mean valid data is present in the
+ * corresponding bytes. In the 16-bit mode, a 16-bit half-word is valid only if
+ * adjacent bits [1:0] or [3:2] or both are 1. A value of 0x0 will mean that
+ * none of the bytes are valid and should not be used. For example, set the bit
+ * field value to 0x7 if the display data is arranged in the 24-bit unpacked
+ * format (A-R-G-B where A value does not have be transmitted).
+ */
+#define CTRL1_SET_BYTE_PACKAGING(x)	REG_PUT((x), 19, 16)
+#define CTRL1_GET_BYTE_PACKAGING(x)	REG_GET((x), 19, 16)
+
+#define CTRL1_CUR_FRAME_DONE_IRQ_EN	BIT(13)
+#define CTRL1_CUR_FRAME_DONE_IRQ	BIT(9)
+
+#define CTRL2_OUTSTANDING_REQS(x)	REG_PUT((x), 23, 21)
+#define REQ_1	0
+#define REQ_2	1
+#define REQ_4	2
+#define REQ_8	3
+#define REQ_16	4
+
+#define TRANSFER_COUNT_SET_VCOUNT(x)	REG_PUT((x), 31, 16)
+#define TRANSFER_COUNT_GET_VCOUNT(x)	REG_GET((x), 31, 16)
+#define TRANSFER_COUNT_SET_HCOUNT(x)	REG_PUT((x), 15, 0)
+#define TRANSFER_COUNT_GET_HCOUNT(x)	REG_GET((x), 15, 0)
+
+#define VDCTRL0_ENABLE_PRESENT		BIT(28)
+#define VDCTRL0_VSYNC_ACT_HIGH		BIT(27)
+#define VDCTRL0_HSYNC_ACT_HIGH		BIT(26)
+#define VDCTRL0_DOTCLK_ACT_FALLING	BIT(25)
+#define VDCTRL0_ENABLE_ACT_HIGH		BIT(24)
+#define VDCTRL0_VSYNC_PERIOD_UNIT	BIT(21)
+#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	BIT(20)
+#define VDCTRL0_HALF_LINE		BIT(19)
+#define VDCTRL0_HALF_LINE_MODE		BIT(18)
+#define VDCTRL0_SET_VSYNC_PULSE_WIDTH(x) REG_PUT((x), 17, 0)
+#define VDCTRL0_GET_VSYNC_PULSE_WIDTH(x) REG_GET((x), 17, 0)
+
+#define VDCTRL2_SET_HSYNC_PERIOD(x)	REG_PUT((x), 15, 0)
+#define VDCTRL2_GET_HSYNC_PERIOD(x)	REG_GET((x), 15, 0)
+
+#define VDCTRL3_MUX_SYNC_SIGNALS	BIT(29)
+#define VDCTRL3_VSYNC_ONLY		BIT(28)
+#define SET_HOR_WAIT_CNT(x)		REG_PUT((x), 27, 16)
+#define GET_HOR_WAIT_CNT(x)		REG_GET((x), 27, 16)
+#define SET_VERT_WAIT_CNT(x)		REG_PUT((x), 15, 0)
+#define GET_VERT_WAIT_CNT(x)		REG_GET((x), 15, 0)
+
+#define VDCTRL4_SET_DOTCLK_DLY(x)	REG_PUT((x), 31, 29) /* v4 only */
+#define VDCTRL4_GET_DOTCLK_DLY(x)	REG_GET((x), 31, 29) /* v4 only */
+#define VDCTRL4_SYNC_SIGNALS_ON		BIT(18)
+#define SET_DOTCLK_H_VALID_DATA_CNT(x)	REG_PUT((x), 17, 0)
+
+#define DEBUG0_HSYNC			BIT(26)
+#define DEBUG0_VSYNC			BIT(25)
 
 #define MXSFB_MIN_XRES			120
 #define MXSFB_MIN_YRES			120
@@ -116,7 +143,7 @@
 #define STMLCDIF_18BIT 2 /* pixel data bus to the display is of 18 bit width */
 #define STMLCDIF_24BIT 3 /* pixel data bus to the display is of 24 bit width */
 
-#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative edge sampling */
+#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	BIT(6)
+#define MXSFB_SYNC_DOTCLK_FALLING_ACT	BIT(7) /* negative edge sampling */
 
 #endif /* __MXSFB_REGS_H__ */
-- 
2.7.4

