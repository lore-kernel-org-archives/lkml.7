Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDACA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DD020663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ob/h5JsR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ob/h5JsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfJ2TmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:42:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfJ2TlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:41:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAB776101A; Tue, 29 Oct 2019 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572378076;
        bh=xqAqpfTz0MYS2QzAykQoW/gQ3PLb9xPmN77DGBErdDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ob/h5JsRgpLBR3aGNUS0GcT65eRkobT2Qns6KK8kN4r6YoYmlQI6KxRWGNFxbLAsG
         FvCTBKysBsI92mWYxweuvSY6zXMg3GykpUhaervTnI93FAHjQqSmXCSjzMlNC1DsdS
         ZX/SQLcd73wZTbVU20opJ7a3zlP36RO7SqxJFrkQ=
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 180DE61066;
        Tue, 29 Oct 2019 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572378076;
        bh=xqAqpfTz0MYS2QzAykQoW/gQ3PLb9xPmN77DGBErdDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ob/h5JsRgpLBR3aGNUS0GcT65eRkobT2Qns6KK8kN4r6YoYmlQI6KxRWGNFxbLAsG
         FvCTBKysBsI92mWYxweuvSY6zXMg3GykpUhaervTnI93FAHjQqSmXCSjzMlNC1DsdS
         ZX/SQLcd73wZTbVU20opJ7a3zlP36RO7SqxJFrkQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 180DE61066
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.andersson@linaro.org, saipraka@codeaurora.org,
        agross@kernel.org
Cc:     tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [RFC 09/17] firmware: qcom_scm-64: Improve SMC convention detection
Date:   Tue, 29 Oct 2019 12:40:57 -0700
Message-Id: <1572378065-4490-10-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572378065-4490-1-git-send-email-eberman@codeaurora.org>
References: <1572378065-4490-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use enum to describe SMC convention.
- Improve SMC convention detection to use __qcom_scm_is_call_available
  instead of circumventing qcom_scm_call_smccc.
- Improve SMC convention detection to check that SMCCC-32 works, instead
  of just assuming it does of SMCCC-64 does not.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-64.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index c83eb1d..4d7fd3e 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -58,7 +58,13 @@ struct arm_smccc_args {
 	unsigned long a[8];
 };
 
-static u64 qcom_smccc_convention = -1;
+enum qcom_smc_convention {
+	SMC_CONVENTION_UNKNOWN,
+	SMC_CONVENTION_ARM_32,
+	SMC_CONVENTION_ARM_64,
+};
+
+static enum qcom_smc_convention qcom_smc_convention = SMC_CONVENTION_UNKNOWN;
 static DEFINE_MUTEX(qcom_scm_lock);
 
 #define QCOM_SCM_EBUSY_WAIT_MS 30
@@ -103,7 +109,9 @@ static int ___qcom_scm_call_smccc(struct device *dev,
 
 	smc.a[0] = ARM_SMCCC_CALL_VAL(
 		atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL,
-		qcom_smccc_convention,
+		(qcom_smc_convention == SMC_CONVENTION_ARM_64) ?
+			ARM_SMCCC_SMC_64 :
+			ARM_SMCCC_SMC_32,
 		desc->owner,
 		SMCCC_FUNCNUM(desc->svc, desc->cmd));
 	smc.a[1] = desc->arginfo;
@@ -117,7 +125,7 @@ static int ___qcom_scm_call_smccc(struct device *dev,
 		if (!args_virt)
 			return -ENOMEM;
 
-		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
+		if (qcom_smc_convention == SMC_CONVENTION_ARM_32) {
 			__le32 *args = args_virt;
 
 			for (i = 0; i < SMCCC_N_EXT_ARGS; i++)
@@ -579,19 +587,15 @@ int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
 
 void __qcom_scm_init(void)
 {
-	u64 cmd;
-	struct arm_smccc_res res;
-	u32 function = SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO, QCOM_INFO_IS_CALL_AVAIL);
-
 	/* First try a SMC64 call */
-	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
-				 ARM_SMCCC_OWNER_SIP, function);
-
-	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
-		      0, 0, 0, 0, 0, &res);
-
-	if (!res.a0 && res.a1)
-		qcom_smccc_convention = ARM_SMCCC_SMC_64;
-	else
-		qcom_smccc_convention = ARM_SMCCC_SMC_32;
+	qcom_smc_convention = SMC_CONVENTION_ARM_64;
+	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
+					 QCOM_INFO_IS_CALL_AVAIL) <= 0) {
+		/* Now try a SMC32 call */
+		qcom_smc_convention = SMC_CONVENTION_ARM_32;
+		if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
+						 QCOM_INFO_IS_CALL_AVAIL) <= 0) {
+			qcom_smc_convention = SMC_CONVENTION_UNKNOWN;
+		}
+	}
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

