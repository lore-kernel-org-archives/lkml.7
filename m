Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279EDC46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417125A07
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fJ5GwcBu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fJ5GwcBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfE3N66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:58:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfE3N66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:58:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEBFC60A4E; Thu, 30 May 2019 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559224736;
        bh=hGP7IswY6Ww3EU3THIoL2zY9SdpXplW17KpRi5mpIJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJ5GwcBu04mQtFTQ3ddhTQww2jDRf2ASzmNdCjXVPoZlQeesLRhfK72Nb0j8055q0
         GMa8Joj5mAjCFRmtaIYXTTW/1nwdpW/PEB8bJD3OD4I42i1zmPhpUzqxd/fXhfhywx
         cFM4HIRH9wfToX0I8Gg5u7PU1Y9j9gpJdbAB/mqY=
Received: from amasule-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: amasule@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AD7060588;
        Thu, 30 May 2019 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559224736;
        bh=hGP7IswY6Ww3EU3THIoL2zY9SdpXplW17KpRi5mpIJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJ5GwcBu04mQtFTQ3ddhTQww2jDRf2ASzmNdCjXVPoZlQeesLRhfK72Nb0j8055q0
         GMa8Joj5mAjCFRmtaIYXTTW/1nwdpW/PEB8bJD3OD4I42i1zmPhpUzqxd/fXhfhywx
         cFM4HIRH9wfToX0I8Gg5u7PU1Y9j9gpJdbAB/mqY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AD7060588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=amasule@codeaurora.org
From:   Aniket Masule <amasule@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Aniket Masule <amasule@codeaurora.org>
Subject: [PATCH 1/5] media: venus: Add codec data table
Date:   Thu, 30 May 2019 19:28:24 +0530
Message-Id: <1559224708-6039-2-git-send-email-amasule@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559224708-6039-1-git-send-email-amasule@codeaurora.org>
References: <1559224708-6039-1-git-send-email-amasule@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vpp cycles for for different types of codec
It indicates the cycles required by video hardware
to process each macroblock.

Signed-off-by: Aniket Masule <amasule@codeaurora.org>
---
 drivers/media/platform/qcom/venus/core.c | 13 +++++++++++++
 drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 7393667..e7ebea1 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -473,9 +473,22 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 	{  244800, 100000000 },	/* 1920x1080@30 */
 };
 
+static struct codec_data sdm845_codec_data[] =  {
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 125 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 125 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 125 },
+	{ V4L2_PIX_FMT_MPEG2, VIDC_SESSION_TYPE_DEC, 50 },
+	{ V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_DEC, 50 },
+	{ V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_DEC, 50 },
+	{ V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_DEC, 50 },
+	{ V4L2_PIX_FMT_VP9, VIDC_SESSION_TYPE_DEC, 50 },
+};
+
 static const struct venus_resources sdm845_res = {
 	.freq_tbl = sdm845_freq_table,
 	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
+	.codec_data = sdm845_codec_data,
+	.codec_data_size = ARRAY_SIZE(sdm845_codec_data),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
 	.max_load = 2563200,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 7a3feb5..b1a9b43 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -35,12 +35,20 @@ struct reg_val {
 	u32 value;
 };
 
+struct codec_data {
+u32 pixfmt;
+u32 session_type;
+int vpp_cycles;
+};
+
 struct venus_resources {
 	u64 dma_mask;
 	const struct freq_tbl *freq_tbl;
 	unsigned int freq_tbl_size;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
+	const struct codec_data *codec_data;
+	unsigned int codec_data_size;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
 	enum hfi_version hfi_version;
@@ -216,6 +224,12 @@ struct venus_buffer {
 	struct list_head ref_list;
 };
 
+struct clock_data {
+	u32 core_id;
+	unsigned long freq;
+	struct codec_data *codec_data;
+};
+
 #define to_venus_buffer(ptr)	container_of(ptr, struct venus_buffer, vb)
 
 /**
@@ -275,6 +289,7 @@ struct venus_inst {
 	struct list_head list;
 	struct mutex lock;
 	struct venus_core *core;
+	struct clock_data clk_data;
 	struct list_head dpbbufs;
 	struct list_head internalbufs;
 	struct list_head registeredbufs;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

