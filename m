Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B02063A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+Xx44+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLWLeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:34:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39101 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfLWLeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:34:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so12360977lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGNJV+T/A2yMDmvoIRAZ3Ql5cKw3jiqTHheiep1uASM=;
        b=L+Xx44+xy4TzpWKtoIwgaNNH/yTRbuPriWG9QbxPJyBxX7mULjNFxigFq5JG+t1YzS
         wAJ/gSRov1f1TRE7A+jcMu0gKC6q4khJjod2wikRz+YMJ+/6x9v5qsxtRcMysln/gd4H
         ug9bSLHqjVL5qg3hci8IZcYC2jM/JAn20QP0Ywwj/2Y77IVRrbRJ7r0sWISodZsHZcdp
         Du/CB2EHEAIfzlC0eGtDI0gEmAV6h8polyNvOdMZQKZeriyB0uDXbBEor8qzRfbquILQ
         kvoVRXsA8eHxtkgP5SD2H6+t3FfkKNsHUvh4Ab1EvHy1M6cU/kOXVNOefIlLv6k4ilzw
         9Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGNJV+T/A2yMDmvoIRAZ3Ql5cKw3jiqTHheiep1uASM=;
        b=cCQdvrEU/m6kTjNha8OyulxgOcJ7qZdEDYSdjHtlxhR2MZjfifvpgIiYy3RqnsZred
         xzidqUlA3Lu0QhAe3eoxCtof6k2SxhLXVhWP39z6/llfN5T/ieUR2bL4XYxU/QkNh3O9
         UBYo0XrGSPJ8zlQOf4a4HIU+14KAsniMPxh68RER+toxOuwf50KyIO5blKF0R2Wti13B
         CEykBjXRg23W43Gej/7yLaI6SeFjW8tvhXob8J2+Zb0vW0HBV+zfOpMyUVe2YMHdz5Eo
         AM/CX304HZ/r2t8ImX7/gHQoH7NhO9ZrxBGJXFVSegdHA9VRJ8Eyu++hAXuCtfh3f/MK
         18Jg==
X-Gm-Message-State: APjAAAUgZYI6FKK0ar2j009Pw3SOPSBUTpw/aR9XGIcN9eHfCUguFnY5
        EwEWj/af9k/aHb2RAzYA2vL7Xg==
X-Google-Smtp-Source: APXvYqz7h1RykQF1g+byqzrOT7pDVhYouaeY9czj/k7nfD3mNW0uZWQscbeNbGLBquV7jZbJWAZFRQ==
X-Received: by 2002:a19:ae18:: with SMTP id f24mr16960812lfc.155.1577100840504;
        Mon, 23 Dec 2019 03:34:00 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id g15sm8381500ljk.8.2019.12.23.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 03:34:00 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 10/12] venus: core: add sdm845-v2 DT compatible and resource struct
Date:   Mon, 23 Dec 2019 13:33:09 +0200
Message-Id: <20191223113311.20602-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
References: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use dynamic video codec assignment add a new sdm845-v2
DT compatible and new venus_resource structure to cover the binding
where all pmdomains and clocks are under the venus_core control.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index a20ab00a8068..c7525d951e92 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -495,10 +495,37 @@ static const struct venus_resources sdm845_res = {
 	.fwname = "qcom/venus-5.2/venus.mdt",
 };
 
+static const struct venus_resources sdm845_res_v2 = {
+	.freq_tbl = sdm845_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
+	.bw_tbl_enc = sdm845_bw_table_enc,
+	.bw_tbl_enc_size = ARRAY_SIZE(sdm845_bw_table_enc),
+	.bw_tbl_dec = sdm845_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
+	.codec_freq_data = sdm845_codec_freq_data,
+	.codec_freq_data_size = ARRAY_SIZE(sdm845_codec_freq_data),
+	.clks = {"core", "iface", "bus" },
+	.clks_num = 3,
+	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
+	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
+	.vcodec_clks_num = 2,
+	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
+	.vcodec_pmdomains_num = 3,
+	.vcodec_num = 2,
+	.max_load = 3110400,	/* 4096x2160@90 */
+	.hfi_version = HFI_VERSION_4XX,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.dma_mask = 0xe0000000 - 1,
+	.fwname = "qcom/venus-5.2/venus.mdt",
+};
+
 static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
 	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
+	{ .compatible = "qcom,sdm845-venus-v2", .data = &sdm845_res_v2, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);
-- 
2.17.1

