Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CFF20644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2TM9fGrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfFXOtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:49:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:49:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so14260798wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=KpqFfKyYpHvcFHiZp299BoodwcnTKM05Y0f01Ts4g1I=;
        b=2TM9fGrpuET2vQSwF8Kyu4OpOUHVfswWR2nE9XSvtHbkMCuksPQVAAhBP1dzTIMgdJ
         1ovkZoxdkGUFLrUC+u9g+CUukV89Hq+s1PbgddRnDLpOctTSlrmbIs/Z6XsseXU/Wmhk
         YOcqoBkSscwYxQAvhNRggH2VZ8Aem5l+fUcitCeYIP8zyjPDCysegKQPFe6xU7xQ7CB5
         6wk+39Xq95bhaKOVr2R//ATT4twbGrzFLACTwgB98PjKFTXiNMwPm6StAs4HYi1Vi6W7
         i0k3f7X8bvFFB5sU81sA49JFXvAs+uxVNxpoayDAru9YerldGHGlJjOCIPyo5XR5jZI4
         0REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=KpqFfKyYpHvcFHiZp299BoodwcnTKM05Y0f01Ts4g1I=;
        b=IqOtfFMpBKo1G1u3d66jRWEqok13INzLmsjLU5TyXEYhYCrGRqqs46CEfx8KLig+Uk
         WYVl5pldodMstVGOXmkuJ7uUhQalydRdmKfGBSWcefhC69G7rlzOAl3QfXlrNXnU2t61
         iGdXuQ/J7NkvVZcbU8TmEzGm/MdZMfcY+2XQMgl/QNTyET4mQIr+drR5fQq9M2z1G7QP
         CC9kOTdxQiaz/CX9aWUgxxXm7N51kn9ANxz2w8PMdeNiX4o1UYEyj+hSQBVIREnama7t
         iG8M7/fsYx4nFLdF82oTwSFv2+2iEwqaprX8nXVRzsIbQ1RrLE1uhOUXgFfKPl9laqk4
         e5AA==
X-Gm-Message-State: APjAAAXJZ8ormzzKZH0yQhJvVzTBodrmwbOAdyXWCRt+KQfzCNyHXNYR
        OZ5HtU44mKxy7ueEDyat2PcBEA==
X-Google-Smtp-Source: APXvYqwQjPMsIr7ts1knHAlSeJPG1En3cHLU0FGlLc+8q9yfwwXEERiY4Y7jTsxhuj+qEejqaMV63w==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr33168600wra.156.1561387744583;
        Mon, 24 Jun 2019 07:49:04 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l16sm11000869wrw.42.2019.06.24.07.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:49:04 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 7/9] drm: meson: global clean-up
Date:   Mon, 24 Jun 2019 16:48:57 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86pnn382e8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to:
- Add general and TODO comments
- Respect coding style for multi-line comments
- Align macro definitions
- Remove useless macro

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c   |  2 ++
 drivers/gpu/drm/meson/meson_dw_hdmi.h   | 12 ++++++----
 drivers/gpu/drm/meson/meson_registers.h | 31 +++++++++++--------------
 drivers/gpu/drm/meson/meson_vclk.c      |  4 +++-
 drivers/gpu/drm/meson/meson_venc.c      | 10 ++++----
 5 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df3f9ddd2234..1579ff76c1ed 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -428,6 +428,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Enable internal pixclk, tmds_clk, spdif_clk, i2s_clk, cecclk */
 	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
 			       0x3, 0x3);
+
+	/* Enable cec_clk and hdcp22_tmdsclk_en */
 	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
 			       0x3 << 4, 0x3 << 4);
 
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.h b/drivers/gpu/drm/meson/meson_dw_hdmi.h
index 1b2ef043eb5c..08e1c14e4ea0 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.h
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.h
@@ -100,7 +100,8 @@
 #define HDMITX_TOP_INTR_RXSENSE_RISE	BIT(6)
 #define HDMITX_TOP_INTR_RXSENSE_FALL	BIT(7)
 
-/* Bit 14:12 RW tmds_sel: 3'b000=Output zero; 3'b001=Output normal TMDS data;
+/*
+ * Bit 14:12 RW tmds_sel: 3'b000=Output zero; 3'b001=Output normal TMDS data;
  *     3'b010=Output PRBS data; 3'b100=Output shift pattern. Default 0.
  * Bit 11: 9 RW shift_pttn_repeat: 0=New pattern every clk cycle; 1=New pattern
  *     every 2 clk cycles; ...; 7=New pattern every 8 clk cycles. Default 0.
@@ -135,7 +136,8 @@
 /* Bit  9: 0 RW tmds_clk_pttn[29:20]. Default 0. */
 #define HDMITX_TOP_TMDS_CLK_PTTN_23             (0x00B)
 
-/* Bit 1 RW shift_tmds_clk_pttn:1=Enable shifting clk pattern,
+/*
+ * Bit 1 RW shift_tmds_clk_pttn:1=Enable shifting clk pattern,
  * used when TMDS CLK rate = TMDS character rate /4. Default 0.
  * Bit 0 R  Reserved. Default 0.
  * [	1] shift_tmds_clk_pttn
@@ -143,12 +145,14 @@
  */
 #define HDMITX_TOP_TMDS_CLK_PTTN_CNTL           (0x00C)
 
-/* Bit 0 RW revocmem_wr_fail: Read back 1 to indicate Host write REVOC MEM
+/*
+ * Bit 0 RW revocmem_wr_fail: Read back 1 to indicate Host write REVOC MEM
  * failure, write 1 to clear the failure flag.  Default 0.
  */
 #define HDMITX_TOP_REVOCMEM_STAT                (0x00D)
 
-/* Bit	   1 R	filtered RxSense status
+/*
+ * Bit	   1 R	filtered RxSense status
  * Bit     0 R  filtered HPD status.
  */
 #define HDMITX_TOP_STAT0                        (0x00E)
diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 537a779492bd..3581fb3d9727 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -406,19 +406,19 @@
 #define VPP_PREBLEND_CURRENT_XY 0x1d24
 #define VPP_POSTBLEND_CURRENT_XY 0x1d25
 #define VPP_MISC 0x1d26
-#define		VPP_PREBLEND_ENABLE	BIT(6)
-#define		VPP_POSTBLEND_ENABLE	BIT(7)
-#define		VPP_OSD2_ALPHA_PREMULT	BIT(8)
-#define		VPP_OSD1_ALPHA_PREMULT	BIT(9)
-#define		VPP_VD1_POSTBLEND	BIT(10)
-#define		VPP_VD2_POSTBLEND	BIT(11)
-#define		VPP_OSD1_POSTBLEND	BIT(12)
-#define		VPP_OSD2_POSTBLEND	BIT(13)
-#define		VPP_VD1_PREBLEND	BIT(14)
-#define		VPP_VD2_PREBLEND	BIT(15)
-#define		VPP_OSD1_PREBLEND	BIT(16)
-#define		VPP_OSD2_PREBLEND	BIT(17)
-#define		VPP_COLOR_MNG_ENABLE	BIT(28)
+#define		VPP_PREBLEND_ENABLE             BIT(6)
+#define		VPP_POSTBLEND_ENABLE            BIT(7)
+#define		VPP_OSD2_ALPHA_PREMULT          BIT(8)
+#define		VPP_OSD1_ALPHA_PREMULT          BIT(9)
+#define		VPP_VD1_POSTBLEND               BIT(10)
+#define		VPP_VD2_POSTBLEND               BIT(11)
+#define		VPP_OSD1_POSTBLEND              BIT(12)
+#define		VPP_OSD2_POSTBLEND              BIT(13)
+#define		VPP_VD1_PREBLEND                BIT(14)
+#define		VPP_VD2_PREBLEND                BIT(15)
+#define		VPP_OSD1_PREBLEND               BIT(16)
+#define		VPP_OSD2_PREBLEND               BIT(17)
+#define		VPP_COLOR_MNG_ENABLE            BIT(28)
 #define VPP_OFIFO_SIZE 0x1d27
 #define		VPP_OFIFO_SIZE_MASK             GENMASK(13, 0)
 #define		VPP_OFIFO_SIZE_DEFAULT          (0xfff << 20 | 0x1000)
@@ -629,6 +629,7 @@
 #define OSD34_SCI_WH_M1 0x3d29
 #define OSD34_SCO_H_START_END 0x3d2a
 #define OSD34_SCO_V_START_END 0x3d2b
+
 /* viu2 */
 #define VIU2_ADDR_START 0x1e00
 #define VIU2_ADDR_END 0x1eff
@@ -1611,7 +1612,6 @@
 #define OSD1_AFBCD_STATUS 0x31a8
 #define OSD1_AFBCD_PIXEL_HSCOPE 0x31a9
 #define OSD1_AFBCD_PIXEL_VSCOPE 0x31aa
-#define VIU_MISC_CTRL1 0x1a07
 
 /* add for gxm and 962e dv core2 */
 #define DOLBY_CORE2A_SWAP_CTRL1	0x3434
@@ -1626,8 +1626,6 @@
 #define VPU_MAFBC_COMMAND 0x3a05
 #define VPU_MAFBC_STATUS 0x3a06
 #define VPU_MAFBC_SURFACE_CFG 0x3a07
-
-/* osd afbc on g12a */
 #define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S0 0x3a10
 #define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S0 0x3a11
 #define VPU_MAFBC_FORMAT_SPECIFIER_S0 0x3a12
@@ -1748,6 +1746,5 @@
 #define VPP_POST_BLEND_DUMMY_ALPHA 0x3969
 #define VPP_RDARB_MODE 0x3978
 #define VPP_RDARB_REQEN_SLV 0x3979
-#define VPU_RDARB_MODE_L2C1 0x279d
 
 #endif /* __MESON_REGISTERS_H */
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 26732f038d19..e7c2b439d0f7 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -495,6 +495,7 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
 		regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL, 0x0b3a0400 | m);
 
 		/* Enable and reset */
+		/* TODO: add specific macro for g12a here */
 		regmap_update_bits(priv->hhi, HHI_HDMI_PLL_CNTL,
 				   0x3 << 28, 0x3 << 28);
 
@@ -969,7 +970,8 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		meson_venci_cvbs_clock_config(priv);
 		return;
 	} else if (target == MESON_VCLK_TARGET_DMT) {
-		/* The DMT clock path is fixed after the PLL:
+		/*
+		 * The DMT clock path is fixed after the PLL:
 		 * - automatic PLL freq + OD management
 		 * - vid_pll_div = VID_PLL_DIV_5
 		 * - vclk_div = 2
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 918df02d2aef..2835133ab676 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -61,9 +61,9 @@
 /* HHI Registers */
 #define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
 #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
-#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbd offset in data sheet */
+#define HHI_VDAC_CNTL0_G12A	0x2EC /* 0xbb offset in data sheet */
 #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
-#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbe offset in data sheet */
+#define HHI_VDAC_CNTL1_G12A	0x2F0 /* 0xbc offset in data sheet */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
 
 struct meson_cvbs_enci_mode meson_cvbs_enci_pal = {
@@ -1085,7 +1085,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 		writel_relaxed(vmode->enci.video_mode,
 				priv->io_base + _REG(ENCI_VIDEO_MODE));
 
-		/* Advanced Video Mode :
+		/*
+		 * Advanced Video Mode :
 		 * Demux shifting 0x2
 		 * Blank line end at line17/22
 		 * High bandwidth Luma Filter
@@ -1599,7 +1600,8 @@ void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 	writel_relaxed(mode->video_mode,
 			priv->io_base + _REG(ENCI_VIDEO_MODE));
 
-	/* Advanced Video Mode :
+	/*
+	 * Advanced Video Mode :
 	 * Demux shifting 0x2
 	 * Blank line end at line17/22
 	 * High bandwidth Luma Filter
-- 
2.17.1

