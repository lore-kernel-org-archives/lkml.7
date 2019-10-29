Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0AFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E09920663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Op9Sz4NN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Op9Sz4NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfJ2Tl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:41:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbfJ2TlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:41:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87CFF6110B; Tue, 29 Oct 2019 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572378077;
        bh=hP900jZPuqDXv7f9uVqPcMmFzU4ziySueGkarLvTxSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Op9Sz4NNHxwz3Tihx4YY592WBRRznVagwGtIk0StZzQZMgYRP3v7Ew/Zoi85/Kiwg
         EUrSKsi0temk2g6mlII8pclfg2zoWy3XHOjoWM3syIv3XiDiFxeSbrrlI6hWT1Qlm3
         109IUm1dvV7z3oHBR19DaxkWusIe8vh0AwOpFeoM=
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A18FA61067;
        Tue, 29 Oct 2019 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572378077;
        bh=hP900jZPuqDXv7f9uVqPcMmFzU4ziySueGkarLvTxSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Op9Sz4NNHxwz3Tihx4YY592WBRRznVagwGtIk0StZzQZMgYRP3v7Ew/Zoi85/Kiwg
         EUrSKsi0temk2g6mlII8pclfg2zoWy3XHOjoWM3syIv3XiDiFxeSbrrlI6hWT1Qlm3
         109IUm1dvV7z3oHBR19DaxkWusIe8vh0AwOpFeoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A18FA61067
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     bjorn.andersson@linaro.org, saipraka@codeaurora.org,
        agross@kernel.org
Cc:     tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [RFC 10/17] firmware: qcom_scm-32: Use SMC arch wrappers
Date:   Tue, 29 Oct 2019 12:40:58 -0700
Message-Id: <1572378065-4490-11-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572378065-4490-1-git-send-email-eberman@codeaurora.org>
References: <1572378065-4490-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SMC arch wrappers instead of inline assembly.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 71 ++++++++++--------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index b2805de..e6d0a87 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/qcom_scm.h>
+#include <linux/arm-smccc.h>
 #include <linux/dma-mapping.h>
 
 #include "qcom_scm.h"
@@ -121,25 +122,13 @@ static inline void *legacy_get_response_buffer(const struct legacy_response *rsp
 static u32 __qcom_scm_call_do(u32 cmd_addr)
 {
 	int context_id;
-	register u32 r0 asm("r0") = 1;
-	register u32 r1 asm("r1") = (u32)&context_id;
-	register u32 r2 asm("r2") = cmd_addr;
+	struct arm_smccc_res res;
 	do {
-		asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r0")
-			__asmeq("%2", "r1")
-			__asmeq("%3", "r2")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc	#0	@ switch to secure world\n"
-			: "=r" (r0)
-			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3", "r12");
-	} while (r0 == QCOM_SCM_INTERRUPTED);
-
-	return r0;
+		arm_smccc_smc(1, (unsigned long)&context_id, cmd_addr,
+			      0, 0, 0, 0, 0, &res);
+	} while (res.a0 == QCOM_SCM_INTERRUPTED);
+
+	return res.a0;
 }
 
 /**
@@ -236,24 +225,12 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
 {
 	int context_id;
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(LEGACY_ATOMIC(svc, cmd, 1), (unsigned long)&context_id,
+		      arg1, 0, 0, 0, 0, 0, &res);
 
-	register u32 r0 asm("r0") = LEGACY_ATOMIC(svc, cmd, 1);
-	register u32 r1 asm("r1") = (u32)&context_id;
-	register u32 r2 asm("r2") = arg1;
-
-	asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r0")
-			__asmeq("%2", "r1")
-			__asmeq("%3", "r2")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc    #0      @ switch to secure world\n"
-			: "=r" (r0)
-			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3", "r12");
-	return r0;
+	return res.a0;
 }
 
 /**
@@ -269,26 +246,12 @@ static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
 static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
 {
 	int context_id;
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(LEGACY_ATOMIC(svc, cmd, 2), (unsigned long)&context_id,
+		      arg1, arg2, 0, 0, 0, 0, &res);
 
-	register u32 r0 asm("r0") = LEGACY_ATOMIC(svc, cmd, 2);
-	register u32 r1 asm("r1") = (u32)&context_id;
-	register u32 r2 asm("r2") = arg1;
-	register u32 r3 asm("r3") = arg2;
-
-	asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r0")
-			__asmeq("%2", "r1")
-			__asmeq("%3", "r2")
-			__asmeq("%4", "r3")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc    #0      @ switch to secure world\n"
-			: "=r" (r0)
-			: "r" (r0), "r" (r1), "r" (r2), "r" (r3)
-			: "r12");
-	return r0;
+	return res.a0;
 }
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

