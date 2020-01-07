Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21382C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BFA2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="C2FzS/tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgAGVTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:19:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:62193 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729099AbgAGVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578431090; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qEXV/iywVQyO4ljBrZwbRmWzmF5kjR9oqrWaD1wc3uU=; b=C2FzS/twjsl627BY4mJXRWuYrpzV/jdWKcyiwSVArptTiQ9R5HMw4fLGSFDzp7sqib3Ob+YI
 3W6+/3n6T93mrRA64D80AT4pJb0B2WQ+qlpymvWCRMtsgqZdPS+p6D1bKYkhuMt4ft/3hqau
 I0sd5WitjIKr6AIUrdJpaVnLSdo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e14f26c.7fc02c3c30d8-smtp-out-n01;
 Tue, 07 Jan 2020 21:04:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07EFEC447B1; Tue,  7 Jan 2020 21:04:43 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EDE5C447AB;
        Tue,  7 Jan 2020 21:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EDE5C447AB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        swboyd@chromium.org, Stephan Gerhold <stephan@gerhold.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/17] firmware: qcom_scm-64: Improve SMC convention detection
Date:   Tue,  7 Jan 2020 13:04:17 -0800
Message-Id: <1578431066-19600-9-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the calling convention detection to use
__qcom_scm_is_call_available() and not blindly assume 32-bit mode if
the checks fails. BUG() if neither 32-bit or 64-bit mode works.

Change-Id: I66beec550d05afde6c680d256183e8ad207d7268
Tested-by: Brian Masney <masneyb@onstation.org> # arm32
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-64.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 3ae171a..6bc7f69 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -336,21 +336,34 @@ int __qcom_scm_ocmem_unlock(struct device *dev, uint32_t id, uint32_t offset,
 
 void __qcom_scm_init(void)
 {
-	u64 cmd;
-	struct arm_smccc_res res;
-	u32 fnid = SCM_SMC_FNID(QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL);
-
-	/* First try a SMC64 call */
-	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
-				 ARM_SMCCC_OWNER_SIP, fnid);
-
-	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
-		      0, 0, 0, 0, 0, &res);
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_INFO,
+		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
+		.args[0] = SCM_SMC_FNID(QCOM_SCM_SVC_INFO,
+					QCOM_SCM_INFO_IS_CALL_AVAIL) |
+			   (ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT),
+		.arginfo = QCOM_SCM_ARGS(1),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+	int ret;
 
-	if (!res.a0 && res.a1)
-		qcom_smccc_convention = ARM_SMCCC_SMC_64;
-	else
-		qcom_smccc_convention = ARM_SMCCC_SMC_32;
+	qcom_smccc_convention = ARM_SMCCC_SMC_64;
+	// Device isn't required as there is only one argument - no device
+	// needed to dma_map_single to secure world
+	ret = qcom_scm_call_atomic(NULL, &desc, &res);
+	if (!ret && res.result[0] == 1)
+		goto out;
+
+	qcom_smccc_convention = ARM_SMCCC_SMC_32;
+	ret = qcom_scm_call_atomic(NULL, &desc, &res);
+	if (!ret && res.result[0] == 1)
+		goto out;
+
+	qcom_smccc_convention = -1;
+	BUG();
+out:
+	pr_info("QCOM SCM SMC Convention: %lld\n", qcom_smccc_convention);
 }
 
 bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
