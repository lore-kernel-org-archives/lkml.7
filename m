Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D22C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C3D206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cQ12zMZo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ja6RsLtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGBOrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:47:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfGBOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:47:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 881E06081E; Tue,  2 Jul 2019 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562078830;
        bh=a875QKnGwzwIszrMJNfXGeU0HaUU45XcUmeyS3N1jDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ12zMZonbex9h5VC8vw1KXpbfV7aAQdKUHJhwLAK09Xax8YCoEQk7v0XsQbMiJ/3
         D6uPYtl0wohcFAwQe3xl2nwg0UH0ZEZR04xIx3uQ21ZJuAiw4RHz2x/YoE3SVS3yK4
         mXVrZ+0TogHbOi9sh6Edi4WHkgP4Oz1ssF1tAPuw=
Received: from amasule-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: amasule@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1723608FF;
        Tue,  2 Jul 2019 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562078829;
        bh=a875QKnGwzwIszrMJNfXGeU0HaUU45XcUmeyS3N1jDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja6RsLtn+dQ2Ym+pkx2LNVt9QZND+h+oGmUN0YJRFydicclS8WWXV76DEyJBgmqcF
         0WQdXoePAXYVpbx3dXOQFIUEhpv32v5LCbT1Z/yts+EfRADP0Q55q3agjYqzFSvrWd
         eih3ODC9DIpms95yc5MGsCe7e7Y1HJBnFpTbMUTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1723608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=amasule@codeaurora.org
From:   Aniket Masule <amasule@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Aniket Masule <amasule@codeaurora.org>
Subject: [PATCH v4 3/4] media: venus: Update to bitrate based clock scaling
Date:   Tue,  2 Jul 2019 20:16:26 +0530
Message-Id: <1562078787-516-4-git-send-email-amasule@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562078787-516-1-git-send-email-amasule@codeaurora.org>
References: <1562078787-516-1-git-send-email-amasule@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduced clock scaling using bitrate, preavious
calculations consider only the cycles per mb.
Also, clock scaling is now triggered before every
buffer being queued to the device. This helps in
deciding precise clock cycles required.

Signed-off-by: Aniket Masule <amasule@codeaurora.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 31 +++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 2c976e4..5726d86 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -399,17 +399,26 @@ static int scale_clocks(struct venus_inst *inst)
 	return ret;
 }
 
-static unsigned long calculate_vpp_freq(struct venus_inst *inst)
+static unsigned long calculate_inst_freq(struct venus_inst *inst,
+					 unsigned long filled_len)
 {
-	unsigned long vpp_freq = 0;
+	unsigned long vpp_freq = 0, vsp_freq = 0;
+	u64 fps = inst->fps;
 	u32 mbs_per_sec;
 
 	mbs_per_sec = load_per_instance(inst);
 	vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
 	/* 21 / 20 is overhead factor */
 	vpp_freq += vpp_freq / 20;
+	vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
 
-	return vpp_freq;
+	/* 10 / 7 is overhead factor */
+	if (inst->session_type == VIDC_SESSION_TYPE_ENC)
+		vsp_freq += (inst->controls.enc.bitrate * 10) / 7;
+	else
+		vsp_freq += ((fps * filled_len * 8) * 10) / 7;
+
+	return max(vpp_freq, vsp_freq);
 }
 
 static int scale_clocks_v4(struct venus_inst *inst)
@@ -417,13 +426,27 @@ static int scale_clocks_v4(struct venus_inst *inst)
 	struct venus_core *core = inst->core;
 	const struct freq_tbl *table = core->res->freq_tbl;
 	unsigned int num_rows = core->res->freq_tbl_size;
+	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
 	struct clk *clk = core->clks[0];
 	struct device *dev = core->dev;
 	unsigned int i;
 	unsigned long freq = 0, freq_core1 = 0, freq_core2 = 0;
+	unsigned long filled_len = 0;
+	struct venus_buffer *buf, *n;
+	struct vb2_buffer *vb;
 	int ret;
 
-	freq = calculate_vpp_freq(inst);
+	mutex_lock(&inst->lock);
+	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
+		vb = &buf->vb.vb2_buf;
+		filled_len = max(filled_len, vb2_get_plane_payload(vb, 0));
+	}
+	mutex_unlock(&inst->lock);
+
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC && !filled_len)
+		return 0;
+
+	freq = calculate_inst_freq(inst, filled_len);
 
 	if (freq > table[0].freq)
 		dev_warn(dev, "HW is overloaded, needed: %lu max: %lu\n",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

