Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5404220700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dbAKiXgM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DnmUN7VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfC0MjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:39:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfC0MjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:39:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8F236115C; Wed, 27 Mar 2019 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690350;
        bh=8D/0riTkj2w8EmCFstVvEXJuSKH46ZoGUsfPQFpiK68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbAKiXgMxKLVnG3KSVph1gmpEeadZ2qbZOcb/GrvvQtIGMfOO8UoU10m7o4JbnQis
         brCjjQvzEfPitTc/9Jynw7uupgPqyhth60OAcLKsfDJnUQch1844pm09FBJuj8a6yv
         edMdJM5W0lysQwap9AWuPdS4jxjKG9jHbSfEoeIM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD6B60FEE;
        Wed, 27 Mar 2019 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690347;
        bh=8D/0riTkj2w8EmCFstVvEXJuSKH46ZoGUsfPQFpiK68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnmUN7VI9i5DRpHJtPzJeYXrFHS30kUtW/ocFAaLs+/G4j3QdN0C/kPwf/bwFc14g
         khimANDLSp77JNQPy72ZTMRaikS+0aid5OnUI3TgY5xk6C3epG1qpUmvflSU8UAQIK
         oytmxe3ny/h/dw2FQm93fpZ1pFt+G7IMSpw+BEoE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD6B60FEE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 4/9] dt-bindings: power: Add rpm power domain bindings for qcs404
Date:   Wed, 27 Mar 2019 18:08:27 +0530
Message-Id: <20190327123832.11566-5-sibis@codeaurora.org>
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

Add RPM power domain bindings for the qcs404 family of SoC

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[sibis: Add supported rpmpd states for qcs404]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

skip adding Rob's R-b due to some additional changes
https://lore.kernel.org/lkml/20190325223343.GA27389@bogus/

 .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
 include/dt-bindings/power/qcom-rpmpd.h        | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index 980e5413d18f..172ccf940c5c 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -6,6 +6,7 @@ which then translates it into a corresponding voltage on a rail
 Required Properties:
  - compatible: Should be one of the following
 	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
+	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
 	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
  - #power-domain-cells: number of cells in Power domain specifier
 	must be 1.
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 87d9c6611682..450378662944 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -36,4 +36,26 @@
 #define MSM8996_VDDSSCX		5
 #define MSM8996_VDDSSCX_VFC	6
 
+/* QCS404 Power Domains */
+#define QCS404_VDDMX		0
+#define QCS404_VDDMX_AO		1
+#define QCS404_VDDMX_VFL	2
+#define QCS404_LPICX		3
+#define QCS404_LPICX_VFL	4
+#define QCS404_LPIMX		5
+#define QCS404_LPIMX_VFL	6
+
+/* RPM SMD Power Domain performance levels */
+#define RPM_SMD_LEVEL_RETENTION       16
+#define RPM_SMD_LEVEL_RETENTION_PLUS  32
+#define RPM_SMD_LEVEL_MIN_SVS         48
+#define RPM_SMD_LEVEL_LOW_SVS         64
+#define RPM_SMD_LEVEL_SVS             128
+#define RPM_SMD_LEVEL_SVS_PLUS        192
+#define RPM_SMD_LEVEL_NOM             256
+#define RPM_SMD_LEVEL_NOM_PLUS        320
+#define RPM_SMD_LEVEL_TURBO           384
+#define RPM_SMD_LEVEL_TURBO_NO_CPR    416
+#define RPM_SMD_LEVEL_BINNING         512
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

