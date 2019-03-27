Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3642087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DFDPyT5O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RSbramrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfC0Mja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:39:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0Mj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:39:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 028FF6119D; Wed, 27 Mar 2019 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690368;
        bh=By7rcB5q3Tg7NBvIbCF2Wa15XI+aD80ZWPdBZcV9UrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFDPyT5OBsrTpKQX1AmtvSNUZRiL4UVd8d9rpNFW7CD6rYFC41u7a+e28e99iEUoq
         tYmZulPnaYr5wIhQWqqp27BqBw7rB411EbKjwB1O7MCLngVkuqbFIywfTEfz9BmqhK
         T4rdJ5hBP/LDgrY4JCLj+lXTQKNA+2m5KGMSITS4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93EDA611BF;
        Wed, 27 Mar 2019 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690365;
        bh=By7rcB5q3Tg7NBvIbCF2Wa15XI+aD80ZWPdBZcV9UrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSbramrrt9KL0CYtPuUBthA+b2trFsaHqM1UqEUHvuQyWf0DVu0TSPEH5IbrIutce
         urmmBNuJe60Tul4qo9YT7mparAp3xAYaY6Bla+CA2+USRdXnmBPm/BaS7VnoVt+/OZ
         vP6zNrM8V4fo8JQNRfWH841moWXviTY8mP7icq6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93EDA611BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 8/9] soc: qcom: rpmpd: Add MSM8998 power-domains
Date:   Wed, 27 Mar 2019 18:08:31 +0530
Message-Id: <20190327123832.11566-9-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the shared cx/mx and sensor sub-system's cx and mx
power-domains found on MSM8998.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 238a9e02e890..706a3f63038e 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -19,9 +19,12 @@
 /* Resource types */
 #define RPMPD_SMPA 0x61706d73 /* smpa */
 #define RPMPD_LDOA 0x616f646c /* ldoa */
+#define RPMPD_RWCX 0x78637772 /* rwcx */
 #define RPMPD_RWMX 0x786d7772 /* rwmx */
 #define RPMPD_RWLC 0x636c7772 /* rwlc */
 #define RPMPD_RWLM 0x6d6c7772 /* rwlm */
+#define RPMPD_RWSC 0x63737772 /* rwsc */
+#define RPMPD_RWSM 0x6d737772 /* rwsm */
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
@@ -135,6 +138,38 @@ static const struct rpmpd_desc msm8996_desc = {
 	.max_state = MAX_8996_RPMPD_STATE,
 };
 
+/* msm8998 RPM Power domains */
+DEFINE_RPMPD_PAIR(msm8998, vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_VFL(msm8998, vddcx_vfl, RWCX, 0);
+
+DEFINE_RPMPD_PAIR(msm8998, vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_VFL(msm8998, vddmx_vfl, RWMX, 0);
+
+DEFINE_RPMPD_LEVEL(msm8998, vdd_ssccx, RWSC, 0);
+DEFINE_RPMPD_VFL(msm8998, vdd_ssccx_vfl, RWSC, 0);
+
+DEFINE_RPMPD_LEVEL(msm8998, vdd_sscmx, RWSM, 0);
+DEFINE_RPMPD_VFL(msm8998, vdd_sscmx_vfl, RWSM, 0);
+
+static struct rpmpd *msm8998_rpmpds[] = {
+	[MSM8998_VDDCX] =		&msm8998_vddcx,
+	[MSM8998_VDDCX_AO] =		&msm8998_vddcx_ao,
+	[MSM8998_VDDCX_VFL] =		&msm8998_vddcx_vfl,
+	[MSM8998_VDDMX] =		&msm8998_vddmx,
+	[MSM8998_VDDMX_AO] =		&msm8998_vddmx_ao,
+	[MSM8998_VDDMX_VFL] =		&msm8998_vddmx_vfl,
+	[MSM8998_SSCCX] =		&msm8998_vdd_ssccx,
+	[MSM8998_SSCCX_VFL] =		&msm8998_vdd_ssccx_vfl,
+	[MSM8998_SSCMX] =		&msm8998_vdd_sscmx,
+	[MSM8998_SSCMX_VFL] =		&msm8998_vdd_sscmx_vfl,
+};
+
+static const struct rpmpd_desc msm8998_desc = {
+	.rpmpds = msm8998_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8998_rpmpds),
+	.max_state = RPM_SMD_LEVEL_BINNING,
+};
+
 /* qcs404 RPM Power domains */
 DEFINE_RPMPD_PAIR(qcs404, vddmx, vddmx_ao, RWMX, LEVEL, 0);
 DEFINE_RPMPD_VFL(qcs404, vddmx_vfl, RWMX, 0);
@@ -163,6 +198,7 @@ static const struct rpmpd_desc qcs404_desc = {
 
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
+	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ }
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

