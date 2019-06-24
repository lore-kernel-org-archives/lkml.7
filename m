Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69E4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99A2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Jwlce6dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfFXOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:49:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43089 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:48:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so14211375wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version
         :content-transfer-encoding;
        bh=nW4tFcXbHBMTIg/w5S7RfuoRl87+LKBKlyLEwJ3UoKo=;
        b=Jwlce6dniDBaSP2Iht35Dow2GECXEZLf7FwLD6a+Q8ICDyHNK9orMLs27Tu0YoAGkI
         6qPB+mlVtsEI5JdE+hBaxPSKoK6u+nMrQplViAY2fNBmpeGkAmQfqNdZ4IrvzmY054XN
         P63/GMRNCF1GDpoR72iPC452kClNoVMiD2JoUn/7Q904QPBXmmbmMPrmRj4zyZfR0GoT
         03eXJBNrApmLzw1oSIdN+PeCdoXge1+yeLLeDEgHkYvvIMGOn20lN6lVGibBfK7Eg4yc
         UCdcJUKvFH76nOfk8+dfbVFpVBhR11NUCraNJoMJQah5FsGro40h7J7cjoa3H1/8H983
         wpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nW4tFcXbHBMTIg/w5S7RfuoRl87+LKBKlyLEwJ3UoKo=;
        b=As3sMpYRS27DlR/xayL10RfXEWQElnYgVbRZ7F1eNpGyC5gQq7jDiGc8EdJFb1ZXnH
         IE27RoLCir2/nZo09PdX5iElUDVRIrdcsXNvGQFVcPpUnelsxnS0bEfafwFSk75W9BZU
         M98gY0hdBI/YoduyBGHmTCIxVv3p/Yje9FoOMoShcUu16hwmvEOT8nO0O9H/XrOZVFO+
         tQ505N5Wcmh4CEIIbpNwTSw9kHzB4Qdz5R09Sw/MU75sI32iyhLsDP1FAbtTiy0npUsq
         +zhe4Y3PlfUoY2XPcB7jMwRFyWOfj6qTzhdRhI8QmXB9YqaZXTD7f9SkqZP55lY/8YNI
         zBOg==
X-Gm-Message-State: APjAAAUMbvLhIXf4mTfqcuLXGJB6w5k8HmiM73OXFu/vB6iOiLDlM/ga
        xqQhKUAbbS85taIT8aWaeu2gRg==
X-Google-Smtp-Source: APXvYqw+YdXm1v/OThR+zY2Crq27IN7DFhjrgL9agzw9RhMlL/4pCnTVQeR7vjqzydwkYIJBLrk2Rw==
X-Received: by 2002:adf:deca:: with SMTP id i10mr282323wrn.313.1561387737765;
        Mon, 24 Jun 2019 07:48:57 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 203sm8274429wmc.30.2019.06.24.07.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:48:57 -0700 (PDT)
From:   Julien Masson <jmasson@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Julien Masson <jmasson@baylibre.com>
Subject: [PATCH 6/9] drm: meson: venc: use proper macros instead of magic
 constants
Date:   Mon, 24 Jun 2019 16:48:50 +0200
References: <86zhm782g5.fsf@baylibre.com>
Reply-To: <86zhm782g5.fsf@baylibre.com>
Message-ID: <86r27j82ef.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add new macros which are used to set the following
registers:
- ENCI_CFILT_CTRL
- ENCI_CFILT_CTRL2
- ENCI_MACV_MAX_AMP
- ENCI_VIDEO_MODE_ADV
- ENCI_VFIFO2VD_CTL
- ENCI_VIDEO_EN
- ENCP_VIDEO_MODE
- VPU_HDMI_SETTING
- VENC_UPSAMPLE_CTRL0
- VENC_UPSAMPLE_CTRL1
- VENC_UPSAMPLE_CTRL2
- VENC_VDAC_FIFO_CTRL
- VENC_VDAC_DAC0_FILT_CTRL0
- VENC_INTCTRL

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h |  51 ++++++++
 drivers/gpu/drm/meson/meson_venc.c      | 155 +++++++++++++++++++-----
 drivers/gpu/drm/meson/meson_venc_cvbs.c |   3 +-
 3 files changed, 177 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meso=
n/meson_registers.h
index 7a52aac7e28a..537a779492bd 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -742,6 +742,25 @@
 #define VENC_UPSAMPLE_CTRL0 0x1b64
 #define VENC_UPSAMPLE_CTRL1 0x1b65
 #define VENC_UPSAMPLE_CTRL2 0x1b66
+#define		VENC_UPSAMPLE_CTRL_F0_2_CLK_RATIO        BIT(0)
+#define		VENC_UPSAMPLE_CTRL_F1_EN                 BIT(5)
+#define		VENC_UPSAMPLE_CTRL_F1_UPSAMPLE_EN        BIT(6)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_HIGH_LUMA   (0x0 << 12)
+#define		VENC_UPSAMPLE_CTRL_CVBS                  (0x1 << 12)
+#define		VENC_UPSAMPLE_CTRL_S_VIDEO_LUMA          (0x2 << 12)
+#define		VENC_UPSAMPLE_CTRL_S_VIDEO_CHROMA        (0x3 << 12)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_PB          (0x4 << 12)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_PR          (0x5 << 12)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_R           (0x6 << 12)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_G           (0x7 << 12)
+#define		VENC_UPSAMPLE_CTRL_INTERLACE_B           (0x8 << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_Y         (0x9 << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_PB        (0xa << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_PR        (0xb << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_R         (0xc << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_G         (0xd << 12)
+#define		VENC_UPSAMPLE_CTRL_PROGRESSIVE_B         (0xe << 12)
+#define		VENC_UPSAMPLE_CTRL_VDAC_TEST_VALUE       (0xf << 12)
 #define TCON_INVERT_CTL 0x1b67
 #define VENC_VIDEO_PROG_MODE 0x1b68
 #define VENC_ENCI_LINE 0x1b69
@@ -750,6 +769,7 @@
 #define VENC_ENCP_PIXEL 0x1b6c
 #define VENC_STATA 0x1b6d
 #define VENC_INTCTRL 0x1b6e
+#define		VENC_INTCTRL_ENCI_LNRST_INT_EN  BIT(1)
 #define VENC_INTFLAG 0x1b6f
 #define VENC_VIDEO_TST_EN 0x1b70
 #define VENC_VIDEO_TST_MDSEL 0x1b71
@@ -760,6 +780,7 @@
 #define VENC_VIDEO_TST_CLRBAR_WIDTH 0x1b76
 #define VENC_VIDEO_TST_VDCNT_STSET 0x1b77
 #define VENC_VDAC_DACSEL0 0x1b78
+#define		VENC_VDAC_SEL_ATV_DMD           BIT(5)
 #define VENC_VDAC_DACSEL1 0x1b79
 #define VENC_VDAC_DACSEL2 0x1b7a
 #define VENC_VDAC_DACSEL3 0x1b7b
@@ -780,6 +801,7 @@
 #define VENC_VDAC_DAC5_GAINCTRL 0x1bfa
 #define VENC_VDAC_DAC5_OFFSET 0x1bfb
 #define VENC_VDAC_FIFO_CTRL 0x1bfc
+#define		VENC_VDAC_FIFO_EN_ENCI_ENABLE   BIT(13)
 #define ENCL_TCON_INVERT_CTL 0x1bfd
 #define ENCP_VIDEO_EN 0x1b80
 #define ENCP_VIDEO_SYNC_MODE 0x1b81
@@ -795,6 +817,7 @@
 #define ENCP_VIDEO_SYNC_OFFST 0x1b8b
 #define ENCP_VIDEO_MACV_OFFST 0x1b8c
 #define ENCP_VIDEO_MODE 0x1b8d
+#define		ENCP_VIDEO_MODE_DE_V_HIGH       BIT(14)
 #define ENCP_VIDEO_MODE_ADV 0x1b8e
 #define ENCP_DBG_PX_RST 0x1b90
 #define ENCP_DBG_LN_RST 0x1b91
@@ -873,6 +896,11 @@
 #define C656_FS_LNED 0x1be7
 #define ENCI_VIDEO_MODE 0x1b00
 #define ENCI_VIDEO_MODE_ADV 0x1b01
+#define		ENCI_VIDEO_MODE_ADV_DMXMD(val)          (val & 0x3)
+#define		ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22   BIT(2)
+#define		ENCI_VIDEO_MODE_ADV_YBW_MEDIUM          (0 << 4)
+#define		ENCI_VIDEO_MODE_ADV_YBW_LOW             (0x1 << 4)
+#define		ENCI_VIDEO_MODE_ADV_YBW_HIGH            (0x2 << 4)
 #define ENCI_VIDEO_FSC_ADJ 0x1b02
 #define ENCI_VIDEO_BRIGHT 0x1b03
 #define ENCI_VIDEO_CONT 0x1b04
@@ -943,13 +971,17 @@
 #define ENCI_DBG_MAXPX 0x1b4c
 #define ENCI_DBG_MAXLN 0x1b4d
 #define ENCI_MACV_MAX_AMP 0x1b50
+#define		ENCI_MACV_MAX_AMP_ENABLE_CHANGE BIT(15)
+#define		ENCI_MACV_MAX_AMP_VAL(val)      (val & 0x83ff)
 #define ENCI_MACV_PULSE_LO 0x1b51
 #define ENCI_MACV_PULSE_HI 0x1b52
 #define ENCI_MACV_BKP_MAX 0x1b53
 #define ENCI_CFILT_CTRL 0x1b54
+#define		ENCI_CFILT_CMPT_SEL_HIGH        BIT(1)
 #define ENCI_CFILT7 0x1b55
 #define ENCI_YC_DELAY 0x1b56
 #define ENCI_VIDEO_EN 0x1b57
+#define		ENCI_VIDEO_EN_ENABLE            BIT(0)
 #define ENCI_DVI_HSO_BEGIN 0x1c00
 #define ENCI_DVI_HSO_END 0x1c01
 #define ENCI_DVI_VSO_BLINE_EVN 0x1c02
@@ -961,6 +993,10 @@
 #define ENCI_DVI_VSO_END_EVN 0x1c08
 #define ENCI_DVI_VSO_END_ODD 0x1c09
 #define ENCI_CFILT_CTRL2 0x1c0a
+#define		ENCI_CFILT_CMPT_CR_DLY(delay)   (delay & 0xf)
+#define		ENCI_CFILT_CMPT_CB_DLY(delay)   ((delay & 0xf) << 4)
+#define		ENCI_CFILT_CVBS_CR_DLY(delay)   ((delay & 0xf) << 8)
+#define		ENCI_CFILT_CVBS_CB_DLY(delay)   ((delay & 0xf) << 12)
 #define ENCI_DACSEL_0 0x1c0b
 #define ENCI_DACSEL_1 0x1c0c
 #define ENCP_DACSEL_0 0x1c0d
@@ -975,6 +1011,8 @@
 #define ENCI_TST_CLRBAR_WIDTH 0x1c16
 #define ENCI_TST_VDCNT_STSET 0x1c17
 #define ENCI_VFIFO2VD_CTL 0x1c18
+#define		ENCI_VFIFO2VD_CTL_ENABLE        BIT(0)
+#define		ENCI_VFIFO2VD_CTL_VD_SEL(val)   ((val & 0xff) << 8)
 #define ENCI_VFIFO2VD_PIXEL_START 0x1c19
 #define ENCI_VFIFO2VD_PIXEL_END 0x1c1a
 #define ENCI_VFIFO2VD_LINE_TOP_START 0x1c1b
@@ -1037,6 +1075,7 @@
 #define VENC_VDAC_DAC5_FILT_CTRL0 0x1c56
 #define VENC_VDAC_DAC5_FILT_CTRL1 0x1c57
 #define VENC_VDAC_DAC0_FILT_CTRL0 0x1c58
+#define		VENC_VDAC_DAC0_FILT_CTRL0_EN    BIT(0)
 #define VENC_VDAC_DAC0_FILT_CTRL1 0x1c59
 #define VENC_VDAC_DAC1_FILT_CTRL0 0x1c5a
 #define VENC_VDAC_DAC1_FILT_CTRL1 0x1c5b
@@ -1442,6 +1481,18 @@
 #define		VIU2_SEL_VENC_ENCP	(2 << 2)
 #define		VIU2_SEL_VENC_ENCT	(3 << 2)
 #define VPU_HDMI_SETTING 0x271b
+#define		VPU_HDMI_ENCI_DATA_TO_HDMI      BIT(0)
+#define		VPU_HDMI_ENCP_DATA_TO_HDMI      BIT(1)
+#define		VPU_HDMI_INV_HSYNC              BIT(2)
+#define		VPU_HDMI_INV_VSYNC              BIT(3)
+#define		VPU_HDMI_OUTPUT_CRYCB           (0 << 5)
+#define		VPU_HDMI_OUTPUT_YCBCR           (1 << 5)
+#define		VPU_HDMI_OUTPUT_YCRCB           (2 << 5)
+#define		VPU_HDMI_OUTPUT_CBCRY           (3 << 5)
+#define		VPU_HDMI_OUTPUT_CBYCR           (4 << 5)
+#define		VPU_HDMI_OUTPUT_CRCBY           (5 << 5)
+#define		VPU_HDMI_WR_RATE(rate)          (((rate & 0x1f) - 1) << 8)
+#define		VPU_HDMI_RD_RATE(rate)          (((rate & 0x1f) - 1) << 12)
 #define ENCI_INFO_READ 0x271c
 #define ENCP_INFO_READ 0x271d
 #define ENCT_INFO_READ 0x271e
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/mes=
on_venc.c
index 7b7a0d8d737c..918df02d2aef 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -976,6 +976,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, i=
nt vic,
 	unsigned int eof_lines;
 	unsigned int sof_lines;
 	unsigned int vsync_lines;
+	u32 reg;
=20
 	/* Use VENCI for 480i and 576i and double HDMI pixels */
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
@@ -1048,8 +1049,11 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv=
, int vic,
 		unsigned int lines_f1;
=20
 		/* CVBS Filter settings */
-		writel_relaxed(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL));
-		writel_relaxed(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL2));
+		writel_relaxed(ENCI_CFILT_CMPT_SEL_HIGH | 0x10,
+			       priv->io_base + _REG(ENCI_CFILT_CTRL));
+		writel_relaxed(ENCI_CFILT_CMPT_CR_DLY(2) |
+			       ENCI_CFILT_CMPT_CB_DLY(1),
+			       priv->io_base + _REG(ENCI_CFILT_CTRL2));
=20
 		/* Digital Video Select : Interlace, clk27 clk, external */
 		writel_relaxed(0, priv->io_base + _REG(VENC_DVI_SETTING));
@@ -1071,8 +1075,9 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv,=
 int vic,
 				priv->io_base + _REG(ENCI_SYNC_VSO_ODDLN));
=20
 		/* Macrovision max amplitude change */
-		writel_relaxed(vmode->enci.macv_max_amp,
-				priv->io_base + _REG(ENCI_MACV_MAX_AMP));
+		writel_relaxed(ENCI_MACV_MAX_AMP_ENABLE_CHANGE |
+			       ENCI_MACV_MAX_AMP_VAL(vmode->enci.macv_max_amp),
+			       priv->io_base + _REG(ENCI_MACV_MAX_AMP));
=20
 		/* Video mode */
 		writel_relaxed(vmode->enci.video_prog_mode,
@@ -1088,7 +1093,10 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv=
, int vic,
 		 * Bypass luma low pass filter
 		 * No macrovision on CSYNC
 		 */
-		writel_relaxed(0x26, priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
+		writel_relaxed(ENCI_VIDEO_MODE_ADV_DMXMD(2) |
+			       ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22 |
+			       ENCI_VIDEO_MODE_ADV_YBW_HIGH,
+			       priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
=20
 		writel(vmode->enci.sch_adjust,
 				priv->io_base + _REG(ENCI_VIDEO_SCH));
@@ -1104,8 +1112,17 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv=
, int vic,
 		/* UNreset Interlaced TV Encoder */
 		writel_relaxed(0, priv->io_base + _REG(ENCI_DBG_PX_RST));
=20
-		/* Enable Vfifo2vd, Y_Cb_Y_Cr select */
-		writel_relaxed(0x4e01, priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
+		/*
+		 * Enable Vfifo2vd and set Y_Cb_Y_Cr:
+		 * Corresponding value:
+		 * Y  =3D> 00 or 10
+		 * Cb =3D> 01
+		 * Cr =3D> 11
+		 * Ex: 0x4e =3D> 01001110 would mean Cb/Y/Cr/Y
+		 */
+		writel_relaxed(ENCI_VFIFO2VD_CTL_ENABLE |
+			       ENCI_VFIFO2VD_CTL_VD_SEL(0x4e),
+			       priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
=20
 		/* Timings */
 		writel_relaxed(vmode->enci.pixel_start,
@@ -1127,7 +1144,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv,=
 int vic,
 		meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCI);
=20
 		/* Interlace video enable */
-		writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
+		writel_relaxed(ENCI_VIDEO_EN_ENABLE,
+			       priv->io_base + _REG(ENCI_VIDEO_EN));
=20
 		lines_f0 =3D mode->vtotal >> 1;
 		lines_f1 =3D lines_f0 + 1;
@@ -1374,7 +1392,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv,=
 int vic,
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
=20
 		/* Set DE signal=E2=80=99s polarity is active high */
-		writel_bits_relaxed(BIT(14), BIT(14),
+		writel_bits_relaxed(ENCP_VIDEO_MODE_DE_V_HIGH,
+				    ENCP_VIDEO_MODE_DE_V_HIGH,
 				    priv->io_base + _REG(ENCP_VIDEO_MODE));
=20
 		/* Program DE timing */
@@ -1493,13 +1512,39 @@ void meson_venc_hdmi_mode_set(struct meson_drm *pri=
v, int vic,
 		meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCP);
 	}
=20
-	writel_relaxed((use_enci ? 1 : 2) |
-		       (mode->flags & DRM_MODE_FLAG_PHSYNC ? 1 << 2 : 0) |
-		       (mode->flags & DRM_MODE_FLAG_PVSYNC ? 1 << 3 : 0) |
-		       4 << 5 |
-		       (venc_repeat ? 1 << 8 : 0) |
-		       (hdmi_repeat ? 1 << 12 : 0),
-		       priv->io_base + _REG(VPU_HDMI_SETTING));
+	/* Set VPU HDMI setting */
+	/* Select ENCP or ENCI data to HDMI */
+	if (use_enci)
+		reg =3D VPU_HDMI_ENCI_DATA_TO_HDMI;
+	else
+		reg =3D VPU_HDMI_ENCP_DATA_TO_HDMI;
+
+	/* Invert polarity of HSYNC from VENC */
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		reg |=3D VPU_HDMI_INV_HSYNC;
+
+	/* Invert polarity of VSYNC from VENC */
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		reg |=3D VPU_HDMI_INV_VSYNC;
+
+	/* Output data format: CbYCr */
+	reg |=3D VPU_HDMI_OUTPUT_CBYCR;
+
+	/*
+	 * Write rate to the async FIFO between VENC and HDMI.
+	 * One write every 2 wr_clk.
+	 */
+	if (venc_repeat)
+		reg |=3D VPU_HDMI_WR_RATE(2);
+
+	/*
+	 * Read rate to the async FIFO between VENC and HDMI.
+	 * One read every 2 wr_clk.
+	 */
+	if (hdmi_repeat)
+		reg |=3D VPU_HDMI_RD_RATE(2);
+
+	writel_relaxed(reg, priv->io_base + _REG(VPU_HDMI_SETTING));
=20
 	priv->venc.hdmi_repeat =3D hdmi_repeat;
 	priv->venc.venc_repeat =3D venc_repeat;
@@ -1512,12 +1557,17 @@ EXPORT_SYMBOL_GPL(meson_venc_hdmi_mode_set);
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode)
 {
+	u32 reg;
+
 	if (mode->mode_tag =3D=3D priv->venc.current_mode)
 		return;
=20
 	/* CVBS Filter settings */
-	writel_relaxed(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL));
-	writel_relaxed(0x12, priv->io_base + _REG(ENCI_CFILT_CTRL2));
+	writel_relaxed(ENCI_CFILT_CMPT_SEL_HIGH | 0x10,
+		       priv->io_base + _REG(ENCI_CFILT_CTRL));
+	writel_relaxed(ENCI_CFILT_CMPT_CR_DLY(2) |
+		       ENCI_CFILT_CMPT_CB_DLY(1),
+		       priv->io_base + _REG(ENCI_CFILT_CTRL2));
=20
 	/* Digital Video Select : Interlace, clk27 clk, external */
 	writel_relaxed(0, priv->io_base + _REG(VENC_DVI_SETTING));
@@ -1539,8 +1589,9 @@ void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			priv->io_base + _REG(ENCI_SYNC_VSO_ODDLN));
=20
 	/* Macrovision max amplitude change */
-	writel_relaxed(0x8100 + mode->macv_max_amp,
-			priv->io_base + _REG(ENCI_MACV_MAX_AMP));
+	writel_relaxed(ENCI_MACV_MAX_AMP_ENABLE_CHANGE |
+		       ENCI_MACV_MAX_AMP_VAL(mode->macv_max_amp),
+		       priv->io_base + _REG(ENCI_MACV_MAX_AMP));
=20
 	/* Video mode */
 	writel_relaxed(mode->video_prog_mode,
@@ -1556,7 +1607,10 @@ void meson_venci_cvbs_mode_set(struct meson_drm *pri=
v,
 	 * Bypass luma low pass filter
 	 * No macrovision on CSYNC
 	 */
-	writel_relaxed(0x26, priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
+	writel_relaxed(ENCI_VIDEO_MODE_ADV_DMXMD(2) |
+		       ENCI_VIDEO_MODE_ADV_VBICTL_LINE_17_22 |
+		       ENCI_VIDEO_MODE_ADV_YBW_HIGH,
+		       priv->io_base + _REG(ENCI_VIDEO_MODE_ADV));
=20
 	writel(mode->sch_adjust, priv->io_base + _REG(ENCI_VIDEO_SCH));
=20
@@ -1588,16 +1642,50 @@ void meson_venci_cvbs_mode_set(struct meson_drm *pr=
iv,
 	/* UNreset Interlaced TV Encoder */
 	writel_relaxed(0, priv->io_base + _REG(ENCI_DBG_PX_RST));
=20
-	/* Enable Vfifo2vd, Y_Cb_Y_Cr select */
-	writel_relaxed(0x4e01, priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
+	/*
+	 * Enable Vfifo2vd and set Y_Cb_Y_Cr:
+	 * Corresponding value:
+	 * Y  =3D> 00 or 10
+	 * Cb =3D> 01
+	 * Cr =3D> 11
+	 * Ex: 0x4e =3D> 01001110 would mean Cb/Y/Cr/Y
+	 */
+	writel_relaxed(ENCI_VFIFO2VD_CTL_ENABLE |
+		       ENCI_VFIFO2VD_CTL_VD_SEL(0x4e),
+		       priv->io_base + _REG(ENCI_VFIFO2VD_CTL));
=20
 	/* Power UP Dacs */
 	writel_relaxed(0, priv->io_base + _REG(VENC_VDAC_SETTING));
=20
 	/* Video Upsampling */
-	writel_relaxed(0x0061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL0));
-	writel_relaxed(0x4061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL1));
-	writel_relaxed(0x5061, priv->io_base + _REG(VENC_UPSAMPLE_CTRL2));
+	/*
+	 * CTRL0, CTRL1 and CTRL2:
+	 * Filter0: input data sample every 2 cloks
+	 * Filter1: filtering and upsample enable
+	 */
+	reg =3D VENC_UPSAMPLE_CTRL_F0_2_CLK_RATIO | VENC_UPSAMPLE_CTRL_F1_EN |
+		VENC_UPSAMPLE_CTRL_F1_UPSAMPLE_EN;
+
+	/*
+	 * Upsample CTRL0:
+	 * Interlace High Bandwidth Luma
+	 */
+	writel_relaxed(VENC_UPSAMPLE_CTRL_INTERLACE_HIGH_LUMA | reg,
+		       priv->io_base + _REG(VENC_UPSAMPLE_CTRL0));
+
+	/*
+	 * Upsample CTRL1:
+	 * Interlace Pb
+	 */
+	writel_relaxed(VENC_UPSAMPLE_CTRL_INTERLACE_PB | reg,
+		       priv->io_base + _REG(VENC_UPSAMPLE_CTRL1));
+
+	/*
+	 * Upsample CTRL2:
+	 * Interlace R
+	 */
+	writel_relaxed(VENC_UPSAMPLE_CTRL_INTERLACE_PR | reg,
+		       priv->io_base + _REG(VENC_UPSAMPLE_CTRL2));
=20
 	/* Select Interlace Y DACs */
 	writel_relaxed(0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
@@ -1611,14 +1699,16 @@ void meson_venci_cvbs_mode_set(struct meson_drm *pr=
iv,
 	meson_vpp_setup_mux(priv, MESON_VIU_VPP_MUX_ENCI);
=20
 	/* Enable ENCI FIFO */
-	writel_relaxed(0x2000, priv->io_base + _REG(VENC_VDAC_FIFO_CTRL));
+	writel_relaxed(VENC_VDAC_FIFO_EN_ENCI_ENABLE,
+		       priv->io_base + _REG(VENC_VDAC_FIFO_CTRL));
=20
 	/* Select ENCI DACs 0, 1, 4, and 5 */
 	writel_relaxed(0x11, priv->io_base + _REG(ENCI_DACSEL_0));
 	writel_relaxed(0x11, priv->io_base + _REG(ENCI_DACSEL_1));
=20
 	/* Interlace video enable */
-	writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
+	writel_relaxed(ENCI_VIDEO_EN_ENABLE,
+		       priv->io_base + _REG(ENCI_VIDEO_EN));
=20
 	/* Configure Video Saturation / Contrast / Brightness / Hue */
 	writel_relaxed(mode->video_saturation,
@@ -1631,7 +1721,8 @@ void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			priv->io_base + _REG(ENCI_VIDEO_HUE));
=20
 	/* Enable DAC0 Filter */
-	writel_relaxed(0x1, priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL0));
+	writel_relaxed(VENC_VDAC_DAC0_FILT_CTRL0_EN,
+		       priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL0));
 	writel_relaxed(0xfc48, priv->io_base + _REG(VENC_VDAC_DAC0_FILT_CTRL1));
=20
 	/* 0 in Macrovision register 0 */
@@ -1652,7 +1743,8 @@ unsigned int meson_venci_get_field(struct meson_drm *=
priv)
=20
 void meson_venc_enable_vsync(struct meson_drm *priv)
 {
-	writel_relaxed(2, priv->io_base + _REG(VENC_INTCTRL));
+	writel_relaxed(VENC_INTCTRL_ENCI_LNRST_INT_EN,
+		       priv->io_base + _REG(VENC_INTCTRL));
 	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), BIT(25));
 }
=20
@@ -1680,7 +1772,8 @@ void meson_venc_init(struct meson_drm *priv)
 	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0);
=20
 	/* Disable HDMI */
-	writel_bits_relaxed(0x3, 0,
+	writel_bits_relaxed(VPU_HDMI_ENCI_DATA_TO_HDMI |
+			    VPU_HDMI_ENCP_DATA_TO_HDMI, 0,
 			    priv->io_base + _REG(VPU_HDMI_SETTING));
=20
 	/* Disable all encoders */
diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meso=
n/meson_venc_cvbs.c
index 6313a519f257..7ecc6bb6c8f8 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -172,7 +172,8 @@ static void meson_venc_cvbs_encoder_enable(struct drm_e=
ncoder *encoder)
 	struct meson_drm *priv =3D meson_venc_cvbs->priv;
=20
 	/* VDAC0 source is not from ATV */
-	writel_bits_relaxed(BIT(5), 0, priv->io_base + _REG(VENC_VDAC_DACSEL0));
+	writel_bits_relaxed(VENC_VDAC_SEL_ATV_DMD, 0,
+			    priv->io_base + _REG(VENC_VDAC_DACSEL0));
=20
 	if (meson_vpu_is_compatible(priv, "amlogic,meson-gxbb-vpu")) {
 		regmap_write(priv->hhi, HHI_VDAC_CNTL0, 1);
--=20
2.17.1

