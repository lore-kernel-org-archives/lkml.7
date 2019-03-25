Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71552C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0pte6qks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfCYOSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so9193811wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZK10rnCFXqt+Crfw9BwnxCVTNqzE0J2wQ7b0jdZR1w=;
        b=0pte6qks26rkgwh2JyQRixH3uThlyHdLt5ApjLAKJlmYxLswwOYbQMmzSWCqe2f1Wg
         tcyzr8fQf3BN05U9lSEyR0z5ELDjNECxjyZAYIcrCA02aUUJosls2EtyXXyN22/jq1bS
         wuCL4UN2MzUkPJ710/NOWl74YFYVMy3nSmfmDICC7OgyJ99W9/i86qihQzsCjh9jk94l
         6OEDR7+XuMyH9+aqxkp0q1NTdiQNGPWuo7b3TzJX53XRFOYyFDVaRf9+W21lzlQDWFS6
         cw8LlQ1ijROL2iONJ5VOIHMJGjvuZsSasspsh8x9PT/4t/vDXdwAD8wJle0NOEy1Q/5j
         txxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZK10rnCFXqt+Crfw9BwnxCVTNqzE0J2wQ7b0jdZR1w=;
        b=VBYEakGiPIgurZFieA2ZowCAPVdj87za4zxX96cEAASVcOlgxO82QdTGamC4N24j8Y
         ++xGfxWOyTSHYD8q7Nzx58fEXJtgHNVwSADrwOYlO1+bfDtwpK2gmNh+g1Jkg4AbsDaQ
         +faHTZ3S4DnpES6Qm5BZc/Td9DzCBjPmMolrFc92GvAo2UvLH7ZVlbv1VkdAcm/hBrbN
         DpbG3YcRaKLWaFcXwXBUGFnxmMGEYUWyoYZmEEp7wShTsM30t7e5Awz7/uThIwkw+PpL
         Nfn7evoSxQG/rIV62mPcDAqQjUdDBgUHEraouOAexpJK25IT0tVVenWfWkhR2Nv+GNPx
         4BEw==
X-Gm-Message-State: APjAAAUjP82Es8g218ZIoTfn6Ju0yj3A6LooteGIxFMXkAZhDCvjqMq2
        C+Qn/KYfoAdlxk0CDRpB+ZskHA==
X-Google-Smtp-Source: APXvYqxzVUQ3Api5fRdnTel5ggcxEDrQCCv5IUs71urHH8LJDuShkstIAAgXqic33uaSKx3X675n1A==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr5224943wmg.109.1553523510138;
        Mon, 25 Mar 2019 07:18:30 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] drm/meson: Add registers for G12A SoC
Date:   Mon, 25 Mar 2019 15:18:15 +0100
Message-Id: <20190325141824.21259-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new VPU registers added since the
Amlogic GXM SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 247 ++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 5c7e02c703bc..cfaf90501bb1 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -216,6 +216,29 @@
 #define VIU_OSD2_FIFO_CTRL_STAT 0x1a4b
 #define VIU_OSD2_TEST_RDDATA 0x1a4c
 #define VIU_OSD2_PROT_CTRL 0x1a4e
+#define VIU_OSD2_MALI_UNPACK_CTRL 0x1abd
+#define VIU_OSD2_DIMM_CTRL 0x1acf
+
+#define VIU_OSD3_CTRL_STAT 0x3d80
+#define VIU_OSD3_CTRL_STAT2 0x3d81
+#define VIU_OSD3_COLOR_ADDR 0x3d82
+#define VIU_OSD3_COLOR 0x3d83
+#define VIU_OSD3_TCOLOR_AG0 0x3d84
+#define VIU_OSD3_TCOLOR_AG1 0x3d85
+#define VIU_OSD3_TCOLOR_AG2 0x3d86
+#define VIU_OSD3_TCOLOR_AG3 0x3d87
+#define VIU_OSD3_BLK0_CFG_W0 0x3d88
+#define VIU_OSD3_BLK0_CFG_W1 0x3d8c
+#define VIU_OSD3_BLK0_CFG_W2 0x3d90
+#define VIU_OSD3_BLK0_CFG_W3 0x3d94
+#define VIU_OSD3_BLK0_CFG_W4 0x3d98
+#define VIU_OSD3_BLK1_CFG_W4 0x3d99
+#define VIU_OSD3_BLK2_CFG_W4 0x3d9a
+#define VIU_OSD3_FIFO_CTRL_STAT 0x3d9c
+#define VIU_OSD3_TEST_RDDATA 0x3d9d
+#define VIU_OSD3_PROT_CTRL 0x3d9e
+#define VIU_OSD3_MALI_UNPACK_CTRL 0x3d9f
+#define VIU_OSD3_DIMM_CTRL 0x3da0
 
 #define VD1_IF0_GEN_REG 0x1a50
 #define VD1_IF0_CANVAS0 0x1a51
@@ -287,6 +310,27 @@
 #define VIU_OSD1_MATRIX_COEF31_32 0x1a9e
 #define VIU_OSD1_MATRIX_COEF40_41 0x1a9f
 #define VD1_IF0_GEN_REG3 0x1aa7
+
+#define VIU_OSD_BLENDO_H_START_END 0x1aa9
+#define VIU_OSD_BLENDO_V_START_END 0x1aaa
+#define VIU_OSD_BLEND_GEN_CTRL0 0x1aab
+#define VIU_OSD_BLEND_GEN_CTRL1 0x1aac
+#define VIU_OSD_BLEND_DUMMY_DATA 0x1aad
+#define VIU_OSD_BLEND_CURRENT_XY 0x1aae
+
+#define VIU_OSD2_MATRIX_CTRL 0x1ab0
+#define VIU_OSD2_MATRIX_COEF00_01 0x1ab1
+#define VIU_OSD2_MATRIX_COEF02_10 0x1ab2
+#define VIU_OSD2_MATRIX_COEF11_12 0x1ab3
+#define VIU_OSD2_MATRIX_COEF20_21 0x1ab4
+#define VIU_OSD2_MATRIX_COEF22 0x1ab5
+#define VIU_OSD2_MATRIX_OFFSET0_1 0x1ab6
+#define VIU_OSD2_MATRIX_OFFSET2 0x1ab7
+#define VIU_OSD2_MATRIX_PRE_OFFSET0_1 0x1ab8
+#define VIU_OSD2_MATRIX_PRE_OFFSET2 0x1ab9
+#define VIU_OSD2_MATRIX_PROBE_COLOR 0x1aba
+#define VIU_OSD2_MATRIX_HL_COLOR 0x1abb
+#define VIU_OSD2_MATRIX_PROBE_POS 0x1abc
 #define VIU_OSD1_EOTF_CTL 0x1ad4
 #define VIU_OSD1_EOTF_COEF00_01 0x1ad5
 #define VIU_OSD1_EOTF_COEF02_10 0x1ad6
@@ -481,6 +525,82 @@
 #define VPP_OSD_SCALE_COEF 0x1dcd
 #define VPP_INT_LINE_NUM 0x1dce
 
+#define VPP_WRAP_OSD1_MATRIX_COEF00_01 0x3d60
+#define VPP_WRAP_OSD1_MATRIX_COEF02_10 0x3d61
+#define VPP_WRAP_OSD1_MATRIX_COEF11_12 0x3d62
+#define VPP_WRAP_OSD1_MATRIX_COEF20_21 0x3d63
+#define VPP_WRAP_OSD1_MATRIX_COEF22 0x3d64
+#define VPP_WRAP_OSD1_MATRIX_COEF13_14 0x3d65
+#define VPP_WRAP_OSD1_MATRIX_COEF23_24 0x3d66
+#define VPP_WRAP_OSD1_MATRIX_COEF15_25 0x3d67
+#define VPP_WRAP_OSD1_MATRIX_CLIP 0x3d68
+#define VPP_WRAP_OSD1_MATRIX_OFFSET0_1 0x3d69
+#define VPP_WRAP_OSD1_MATRIX_OFFSET2 0x3d6a
+#define VPP_WRAP_OSD1_MATRIX_PRE_OFFSET0_1 0x3d6b
+#define VPP_WRAP_OSD1_MATRIX_PRE_OFFSET2 0x3d6c
+#define VPP_WRAP_OSD1_MATRIX_EN_CTRL 0x3d6d
+
+#define VPP_WRAP_OSD2_MATRIX_COEF00_01 0x3d70
+#define VPP_WRAP_OSD2_MATRIX_COEF02_10 0x3d71
+#define VPP_WRAP_OSD2_MATRIX_COEF11_12 0x3d72
+#define VPP_WRAP_OSD2_MATRIX_COEF20_21 0x3d73
+#define VPP_WRAP_OSD2_MATRIX_COEF22 0x3d74
+#define VPP_WRAP_OSD2_MATRIX_COEF13_14 0x3d75
+#define VPP_WRAP_OSD2_MATRIX_COEF23_24 0x3d76
+#define VPP_WRAP_OSD2_MATRIX_COEF15_25 0x3d77
+#define VPP_WRAP_OSD2_MATRIX_CLIP 0x3d78
+#define VPP_WRAP_OSD2_MATRIX_OFFSET0_1 0x3d79
+#define VPP_WRAP_OSD2_MATRIX_OFFSET2 0x3d7a
+#define VPP_WRAP_OSD2_MATRIX_PRE_OFFSET0_1 0x3d7b
+#define VPP_WRAP_OSD2_MATRIX_PRE_OFFSET2 0x3d7c
+#define VPP_WRAP_OSD2_MATRIX_EN_CTRL 0x3d7d
+
+#define VPP_WRAP_OSD3_MATRIX_COEF00_01 0x3db0
+#define VPP_WRAP_OSD3_MATRIX_COEF02_10 0x3db1
+#define VPP_WRAP_OSD3_MATRIX_COEF11_12 0x3db2
+#define VPP_WRAP_OSD3_MATRIX_COEF20_21 0x3db3
+#define VPP_WRAP_OSD3_MATRIX_COEF22 0x3db4
+#define VPP_WRAP_OSD3_MATRIX_COEF13_14 0x3db5
+#define VPP_WRAP_OSD3_MATRIX_COEF23_24 0x3db6
+#define VPP_WRAP_OSD3_MATRIX_COEF15_25 0x3db7
+#define VPP_WRAP_OSD3_MATRIX_CLIP 0x3db8
+#define VPP_WRAP_OSD3_MATRIX_OFFSET0_1 0x3db9
+#define VPP_WRAP_OSD3_MATRIX_OFFSET2 0x3dba
+#define VPP_WRAP_OSD3_MATRIX_PRE_OFFSET0_1 0x3dbb
+#define VPP_WRAP_OSD3_MATRIX_PRE_OFFSET2 0x3dbc
+#define VPP_WRAP_OSD3_MATRIX_EN_CTRL 0x3dbd
+
+/* osd2 scaler */
+#define OSD2_VSC_PHASE_STEP 0x3d00
+#define OSD2_VSC_INI_PHASE 0x3d01
+#define OSD2_VSC_CTRL0 0x3d02
+#define OSD2_HSC_PHASE_STEP 0x3d03
+#define OSD2_HSC_INI_PHASE 0x3d04
+#define OSD2_HSC_CTRL0 0x3d05
+#define OSD2_HSC_INI_PAT_CTRL 0x3d06
+#define OSD2_SC_DUMMY_DATA 0x3d07
+#define OSD2_SC_CTRL0 0x3d08
+#define OSD2_SCI_WH_M1 0x3d09
+#define OSD2_SCO_H_START_END 0x3d0a
+#define OSD2_SCO_V_START_END 0x3d0b
+#define OSD2_SCALE_COEF_IDX 0x3d18
+#define OSD2_SCALE_COEF 0x3d19
+
+/* osd34 scaler */
+#define OSD34_SCALE_COEF_IDX 0x3d1e
+#define OSD34_SCALE_COEF 0x3d1f
+#define OSD34_VSC_PHASE_STEP 0x3d20
+#define OSD34_VSC_INI_PHASE 0x3d21
+#define OSD34_VSC_CTRL0 0x3d22
+#define OSD34_HSC_PHASE_STEP 0x3d23
+#define OSD34_HSC_INI_PHASE 0x3d24
+#define OSD34_HSC_CTRL0 0x3d25
+#define OSD34_HSC_INI_PAT_CTRL 0x3d26
+#define OSD34_SC_DUMMY_DATA 0x3d27
+#define OSD34_SC_CTRL0 0x3d28
+#define OSD34_SCI_WH_M1 0x3d29
+#define OSD34_SCO_H_START_END 0x3d2a
+#define OSD34_SCO_V_START_END 0x3d2b
 /* viu2 */
 #define VIU2_ADDR_START 0x1e00
 #define VIU2_ADDR_END 0x1eff
@@ -1400,4 +1520,131 @@
 #define OSDSR_YBIC_VCOEF0 0x3149
 #define OSDSR_CBIC_VCOEF0 0x314a
 
+/* osd afbcd on gxtvbb */
+#define OSD1_AFBCD_ENABLE 0x31a0
+#define OSD1_AFBCD_MODE 0x31a1
+#define OSD1_AFBCD_SIZE_IN 0x31a2
+#define OSD1_AFBCD_HDR_PTR 0x31a3
+#define OSD1_AFBCD_FRAME_PTR 0x31a4
+#define OSD1_AFBCD_CHROMA_PTR 0x31a5
+#define OSD1_AFBCD_CONV_CTRL 0x31a6
+#define OSD1_AFBCD_STATUS 0x31a8
+#define OSD1_AFBCD_PIXEL_HSCOPE 0x31a9
+#define OSD1_AFBCD_PIXEL_VSCOPE 0x31aa
+#define VIU_MISC_CTRL1 0x1a07
+
+/* add for gxm and 962e dv core2 */
+#define DOLBY_CORE2A_SWAP_CTRL1	0x3434
+#define DOLBY_CORE2A_SWAP_CTRL2	0x3435
+
+/* osd afbc on g12a */
+#define VPU_MAFBC_BLOCK_ID 0x3a00
+#define VPU_MAFBC_IRQ_RAW_STATUS 0x3a01
+#define VPU_MAFBC_IRQ_CLEAR 0x3a02
+#define VPU_MAFBC_IRQ_MASK 0x3a03
+#define VPU_MAFBC_IRQ_STATUS 0x3a04
+#define VPU_MAFBC_COMMAND 0x3a05
+#define VPU_MAFBC_STATUS 0x3a06
+#define VPU_MAFBC_SURFACE_CFG 0x3a07
+
+/* osd afbc on g12a */
+#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S0 0x3a10
+#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S0 0x3a11
+#define VPU_MAFBC_FORMAT_SPECIFIER_S0 0x3a12
+#define VPU_MAFBC_BUFFER_WIDTH_S0 0x3a13
+#define VPU_MAFBC_BUFFER_HEIGHT_S0 0x3a14
+#define VPU_MAFBC_BOUNDING_BOX_X_START_S0 0x3a15
+#define VPU_MAFBC_BOUNDING_BOX_X_END_S0 0x3a16
+#define VPU_MAFBC_BOUNDING_BOX_Y_START_S0 0x3a17
+#define VPU_MAFBC_BOUNDING_BOX_Y_END_S0 0x3a18
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S0 0x3a19
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S0 0x3a1a
+#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S0 0x3a1b
+#define VPU_MAFBC_PREFETCH_CFG_S0 0x3a1c
+
+#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S1 0x3a30
+#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S1 0x3a31
+#define VPU_MAFBC_FORMAT_SPECIFIER_S1 0x3a32
+#define VPU_MAFBC_BUFFER_WIDTH_S1 0x3a33
+#define VPU_MAFBC_BUFFER_HEIGHT_S1 0x3a34
+#define VPU_MAFBC_BOUNDING_BOX_X_START_S1 0x3a35
+#define VPU_MAFBC_BOUNDING_BOX_X_END_S1 0x3a36
+#define VPU_MAFBC_BOUNDING_BOX_Y_START_S1 0x3a37
+#define VPU_MAFBC_BOUNDING_BOX_Y_END_S1 0x3a38
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S1 0x3a39
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S1 0x3a3a
+#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S1 0x3a3b
+#define VPU_MAFBC_PREFETCH_CFG_S1 0x3a3c
+
+#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S2 0x3a50
+#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S2 0x3a51
+#define VPU_MAFBC_FORMAT_SPECIFIER_S2 0x3a52
+#define VPU_MAFBC_BUFFER_WIDTH_S2 0x3a53
+#define VPU_MAFBC_BUFFER_HEIGHT_S2 0x3a54
+#define VPU_MAFBC_BOUNDING_BOX_X_START_S2 0x3a55
+#define VPU_MAFBC_BOUNDING_BOX_X_END_S2 0x3a56
+#define VPU_MAFBC_BOUNDING_BOX_Y_START_S2 0x3a57
+#define VPU_MAFBC_BOUNDING_BOX_Y_END_S2 0x3a58
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S2 0x3a59
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S2 0x3a5a
+#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S2 0x3a5b
+#define VPU_MAFBC_PREFETCH_CFG_S2 0x3a5c
+
+#define VPU_MAFBC_HEADER_BUF_ADDR_LOW_S3 0x3a70
+#define VPU_MAFBC_HEADER_BUF_ADDR_HIGH_S3 0x3a71
+#define VPU_MAFBC_FORMAT_SPECIFIER_S3 0x3a72
+#define VPU_MAFBC_BUFFER_WIDTH_S3 0x3a73
+#define VPU_MAFBC_BUFFER_HEIGHT_S3 0x3a74
+#define VPU_MAFBC_BOUNDING_BOX_X_START_S3 0x3a75
+#define VPU_MAFBC_BOUNDING_BOX_X_END_S3 0x3a76
+#define VPU_MAFBC_BOUNDING_BOX_Y_START_S3 0x3a77
+#define VPU_MAFBC_BOUNDING_BOX_Y_END_S3 0x3a78
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_LOW_S3 0x3a79
+#define VPU_MAFBC_OUTPUT_BUF_ADDR_HIGH_S3 0x3a7a
+#define VPU_MAFBC_OUTPUT_BUF_STRIDE_S3 0x3a7b
+#define VPU_MAFBC_PREFETCH_CFG_S3 0x3a7c
+
+#define DOLBY_PATH_CTRL 0x1a0c
+#define OSD_PATH_MISC_CTRL 0x1a0e
+#define MALI_AFBCD_TOP_CTRL 0x1a0f
+
+#define VIU_OSD_BLEND_CTRL 0x39b0
+#define VIU_OSD_BLEND_CTRL1 0x39c0
+#define VIU_OSD_BLEND_DIN0_SCOPE_H 0x39b1
+#define VIU_OSD_BLEND_DIN0_SCOPE_V 0x39b2
+#define VIU_OSD_BLEND_DIN1_SCOPE_H 0x39b3
+#define VIU_OSD_BLEND_DIN1_SCOPE_V 0x39b4
+#define VIU_OSD_BLEND_DIN2_SCOPE_H 0x39b5
+#define VIU_OSD_BLEND_DIN2_SCOPE_V 0x39b6
+#define VIU_OSD_BLEND_DIN3_SCOPE_H 0x39b7
+#define VIU_OSD_BLEND_DIN3_SCOPE_V 0x39b8
+#define VIU_OSD_BLEND_DUMMY_DATA0 0x39b9
+#define VIU_OSD_BLEND_DUMMY_ALPHA 0x39ba
+#define VIU_OSD_BLEND_BLEND0_SIZE 0x39bb
+#define VIU_OSD_BLEND_BLEND1_SIZE 0x39bc
+#define VIU_OSD_BLEND_RO_CURRENT_XY 0x39bf
+
+#define VPP_OUT_H_V_SIZE 0x1da5
+
+#define VPP_VD2_HDR_IN_SIZE 0x1df0
+#define VPP_OSD1_IN_SIZE 0x1df1
+#define VPP_GCLK_CTRL2 0x1df2
+#define VD2_PPS_DUMMY_DATA 0x1df4
+#define VPP_OSD1_BLD_H_SCOPE 0x1df5
+#define VPP_OSD1_BLD_V_SCOPE 0x1df6
+#define VPP_OSD2_BLD_H_SCOPE 0x1df7
+#define VPP_OSD2_BLD_V_SCOPE 0x1df8
+#define VPP_WRBAK_CTRL 0x1df9
+#define VPP_SLEEP_CTRL 0x1dfa
+#define VD1_BLEND_SRC_CTRL 0x1dfb
+#define VD2_BLEND_SRC_CTRL 0x1dfc
+#define OSD1_BLEND_SRC_CTRL 0x1dfd
+#define OSD2_BLEND_SRC_CTRL 0x1dfe
+
+#define VPP_POST_BLEND_BLEND_DUMMY_DATA 0x3968
+#define VPP_POST_BLEND_DUMMY_ALPHA 0x3969
+#define VPP_RDARB_MODE 0x3978
+#define VPP_RDARB_REQEN_SLV 0x3979
+#define VPU_RDARB_MODE_L2C1 0x279d
+
 #endif /* __MESON_REGISTERS_H */
-- 
2.21.0

