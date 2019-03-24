Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C0AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497622148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QLRft/M7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WXKHepJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfCXRvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:51:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfCXRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:51:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A31416155C; Sun, 24 Mar 2019 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449871;
        bh=8wbxkkcD4SzxnXm6moHU6tqbXyb3+8Eqzr1ZFik4pmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLRft/M7j4yr2UuOOvoymL1dh3lla4kTZcEx4OVzVd1/69qCYaupqWQd41YFLO2/q
         HvulSrLUpWF898D8Ygde/XT9xgBH/jBEkGxsCIcXLb7pOcr/wTBM+akl8rcKcotxu6
         R+3PRSwwzbJV7JvHzkSwEGXzZMG8DZmlQ3EhRZLQ=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CAD9616D3;
        Sun, 24 Mar 2019 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449857;
        bh=8wbxkkcD4SzxnXm6moHU6tqbXyb3+8Eqzr1ZFik4pmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXKHepJ1eaPCDxcEIhqxH4LBppL+A9UF03AbN1eoKOaiTlHHLDQTqB3pb9NybVK+s
         FH9NimT4PxppmlwknYCzZjI16HKPczgLod/Tl4IouvagRzP3ZgXBxUuy0JexypQC4q
         Fuhqm6ccLRGvwLB617zAbP3/Trcvocyn7jHSVmMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CAD9616D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 8/9] soc: qcom: rpmpd: Add MSM8998 power-domains
Date:   Sun, 24 Mar 2019 23:20:06 +0530
Message-Id: <20190324175007.29040-9-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190324175007.29040-1-sibis@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
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
index 60a305e9d429..bc09874a343c 100644
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
 	.max_state = MAX_RPMPD_STATE,
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

