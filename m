Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7B320449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j++U/tue";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="drihDVGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfC0MjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:39:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0MjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:39:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B128360E73; Wed, 27 Mar 2019 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690354;
        bh=AS5I22ecQVFwq+LdlTN7wgWkEr1j5jJHQNKCvyxp5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j++U/tueIVRuIcZIQ/+Xj5lRElTIbjqR7ENRD+1R33AynBfyM07gV/ej3Syjk1YQT
         J5jZM55pmsRtm7CyPaCIWgKlEa2nDbILRTm+zPHktIl0/hX/tUF1aSw+IW6oIHL7Bw
         f8rfRSJXJe5cA1FbNL0WNBaCpI0vNmkJLLB8lWaA=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC43F60E5C;
        Wed, 27 Mar 2019 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690351;
        bh=AS5I22ecQVFwq+LdlTN7wgWkEr1j5jJHQNKCvyxp5j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drihDVGXpNvEVxjYVEac0aBpL+fh3oCNcDRq9+Mcj/3lzmMl2eG7D+sxBuChIpv2b
         /EPLtv0xFnX5XjkLgHHNOttJci+55BDpVu5Ybsr6wh0viGIAWqQvUGHwJqp2SvBLeM
         1LxnCVbPKdXpImV2fKkhp9UtU0hE7DdZtV98m8DE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC43F60E5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 5/9] soc: qcom: rpmpd: Add QCS404 power-domains
Date:   Wed, 27 Mar 2019 18:08:28 +0530
Message-Id: <20190327123832.11566-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the shared cx/mx and the low-power-island's cx and mx power-domains
found on QCS404.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[sibi: Fixup corner/vfc with vlfl/vfl]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 52 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index ca736ceb969c..238a9e02e890 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -19,11 +19,16 @@
 /* Resource types */
 #define RPMPD_SMPA 0x61706d73 /* smpa */
 #define RPMPD_LDOA 0x616f646c /* ldoa */
+#define RPMPD_RWMX 0x786d7772 /* rwmx */
+#define RPMPD_RWLC 0x636c7772 /* rwlc */
+#define RPMPD_RWLM 0x6d6c7772 /* rwlm */
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
 #define KEY_ENABLE		0x6e657773 /* swen */
 #define KEY_FLOOR_CORNER	0x636676   /* vfc */
+#define KEY_FLOOR_LEVEL		0x6c6676   /* vfl */
+#define KEY_LEVEL		0x6c766c76 /* vlvl */
 
 #define MAX_8996_RPMPD_STATE	6
 
@@ -54,6 +59,14 @@
 		.key = KEY_CORNER,					\
 	}
 
+#define DEFINE_RPMPD_LEVEL(_platform, _name, r_type, r_id)		\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = RPMPD_##r_type,				\
+		.res_id = r_id,						\
+		.key = KEY_LEVEL,					\
+	}
+
 #define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = { .name = #_name, },				\
@@ -62,6 +75,14 @@
 		.key = KEY_FLOOR_CORNER,				\
 	}
 
+#define DEFINE_RPMPD_VFL(_platform, _name, r_type, r_id)		\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = RPMPD_##r_type,				\
+		.res_id = r_id,						\
+		.key = KEY_FLOOR_LEVEL,					\
+	}
+
 struct rpmpd_req {
 	__le32 key;
 	__le32 nbytes;
@@ -114,8 +135,35 @@ static const struct rpmpd_desc msm8996_desc = {
 	.max_state = MAX_8996_RPMPD_STATE,
 };
 
+/* qcs404 RPM Power domains */
+DEFINE_RPMPD_PAIR(qcs404, vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_VFL(qcs404, vddmx_vfl, RWMX, 0);
+
+DEFINE_RPMPD_LEVEL(qcs404, vdd_lpicx, RWLC, 0);
+DEFINE_RPMPD_VFL(qcs404, vdd_lpicx_vfl, RWLC, 0);
+
+DEFINE_RPMPD_LEVEL(qcs404, vdd_lpimx, RWLM, 0);
+DEFINE_RPMPD_VFL(qcs404, vdd_lpimx_vfl, RWLM, 0);
+
+static struct rpmpd *qcs404_rpmpds[] = {
+	[QCS404_VDDMX] = &qcs404_vddmx,
+	[QCS404_VDDMX_AO] = &qcs404_vddmx_ao,
+	[QCS404_VDDMX_VFL] = &qcs404_vddmx_vfl,
+	[QCS404_LPICX] = &qcs404_vdd_lpicx,
+	[QCS404_LPICX_VFL] = &qcs404_vdd_lpicx_vfl,
+	[QCS404_LPIMX] = &qcs404_vdd_lpimx,
+	[QCS404_LPIMX_VFL] = &qcs404_vdd_lpimx_vfl,
+};
+
+static const struct rpmpd_desc qcs404_desc = {
+	.rpmpds = qcs404_rpmpds,
+	.num_pds = ARRAY_SIZE(qcs404_rpmpds),
+	.max_state = RPM_SMD_LEVEL_BINNING,
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
+	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ }
 };
 
@@ -230,7 +278,9 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 
 	pd->corner = state;
 
-	if (!pd->enabled && pd->key != KEY_FLOOR_CORNER)
+	/* Always send updates for vfc and vfl */
+	if (!pd->enabled && pd->key != KEY_FLOOR_CORNER &&
+	    pd->key != KEY_FLOOR_LEVEL)
 		goto out;
 
 	ret = rpmpd_aggregate_corner(pd);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

