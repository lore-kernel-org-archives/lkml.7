Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0BD20449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DPvnXH5d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BvLwkyHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfC0Mi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:38:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfC0Mi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:38:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2F7160E75; Wed, 27 Mar 2019 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690337;
        bh=9qbE9DNsT7sHR+XIxHoeAAs2S5N1haUdw3Jt612GZno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPvnXH5dkz/zgAebQlw7oFATp0MazuVV2MUsND1knB6Oy9Gmbg89+XvrZQeqyuT2Y
         G7CAAluhFfVxb4ZyDqid3jvrVqss4erqEyO79pSNUy9hs2QJBrKbo73z97B/a0WN8/
         ztmSDW++i6M0lKXCGGnqORgC/n6NWDowAG8PWj1Q=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 031B460E75;
        Wed, 27 Mar 2019 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690336;
        bh=9qbE9DNsT7sHR+XIxHoeAAs2S5N1haUdw3Jt612GZno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvLwkyHiPxqOjfSGeB/h8Ueo1Q7QhY8BOMxKcZDAZl6a+VBSiTpw3AN2oKA+tBq9m
         CsG6DELd2zyZJ83msqPeUpbxHCX0hj2/faq744/YQYqIQYf8OfjxCWFlaisxYacc4y
         C4TYoVPvR1EOuucaV6U+7UTCNZ8L53NSdMa2y464=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 031B460E75
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 2/9] soc: qcom: rpmpd: Add support to set rpmpd state to max
Date:   Wed, 27 Mar 2019 18:08:25 +0530
Message-Id: <20190327123832.11566-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpmpd max state varies across SoCs and SoC families, add support
in the driver to make it SoC/SoC family specific

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 235d01870dd8..94015ece40e9 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -25,7 +25,7 @@
 #define KEY_ENABLE		0x6e657773 /* swen */
 #define KEY_FLOOR_CORNER	0x636676   /* vfc */
 
-#define MAX_RPMPD_STATE		6
+#define MAX_8996_RPMPD_STATE	6
 
 #define DEFINE_RPMPD_CORNER_SMPA(_platform, _name, _active, r_id)		\
 	static struct rpmpd _platform##_##_active;			\
@@ -83,12 +83,14 @@ struct rpmpd {
 	const int res_type;
 	const int res_id;
 	struct qcom_smd_rpm *rpm;
+	unsigned int max_state;
 	__le32 key;
 };
 
 struct rpmpd_desc {
 	struct rpmpd **rpmpds;
 	size_t num_pds;
+	unsigned int max_state;
 };
 
 static DEFINE_MUTEX(rpmpd_lock);
@@ -114,6 +116,7 @@ static struct rpmpd *msm8996_rpmpds[] = {
 static const struct rpmpd_desc msm8996_desc = {
 	.rpmpds = msm8996_rpmpds,
 	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
+	.max_state = MAX_8996_RPMPD_STATE,
 };
 
 static const struct of_device_id rpmpd_match_table[] = {
@@ -225,8 +228,8 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 	int ret = 0;
 	struct rpmpd *pd = domain_to_rpmpd(domain);
 
-	if (state > MAX_RPMPD_STATE)
-		state = MAX_RPMPD_STATE;
+	if (state > pd->max_state)
+		state = pd->max_state;
 
 	mutex_lock(&rpmpd_lock);
 
@@ -287,6 +290,7 @@ static int rpmpd_probe(struct platform_device *pdev)
 		}
 
 		rpmpds[i]->rpm = rpm;
+		rpmpds[i]->max_state = desc->max_state;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
 		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

