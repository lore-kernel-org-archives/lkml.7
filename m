Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE5C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F107F206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gX65Kar6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RR+HvFqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfLLSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:37:58 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:43896
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730455AbfLLShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576175823;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=w1SrKHHyeBDteMNP8O/IVD/2wQ7Wzg3QyRcWSjuUtGs=;
        b=gX65Kar6zKEeZlaGgZMDUZogZCg4ZGYyNqWEJ1B/QiuC2XKEyolrvg7mIT8RprdB
        Gv70DkxjtIHJ1GAS7qIB+Txjnv0kogketBQaFiR64snECcRc3oL91gOPyhOibOkSy+f
        D85rHIJ/ZwJmJpCU7gZUDa3YJ/I5S9qq0nMr1awA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576175823;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=w1SrKHHyeBDteMNP8O/IVD/2wQ7Wzg3QyRcWSjuUtGs=;
        b=RR+HvFqNuays2UpCbryg333YcZQQA56nmOf0QC6+Pt3N+y/G1Iw2rlWsyJhEJN6y
        /zuqWZJTtx8r9Ae3+pNFkzmCPSYJtaH/Qw+8jbIqJG8HNqfBv4poP2sox0ob4ZHj0UX
        Bx4MqMsFSvoFiT2W0ZRmdT4IS3OLSYayQuoqCwn8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F689C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.anderssen@linaro.org, saiprakash.ranjan@codeaurora.org,
        agross@kernel.org, swboyd@chromium.org
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/17] firmware: qcom_scm-64: Improve SMC convention detection
Date:   Thu, 12 Dec 2019 18:37:03 +0000
Message-ID: <0101016efb666acc-da7de7ae-5dc5-40e5-9a14-c1f7897767fe-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576175807-11775-1-git-send-email-eberman@codeaurora.org>
References: <1576175807-11775-1-git-send-email-eberman@codeaurora.org>
X-SES-Outgoing: 2019.12.12-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the calling convention detection to use
__qcom_scm_is_call_available() and not blindly assume 32-bit mode if
the checks fails. BUG() if neither 32-bit or 64-bit mode works.

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

