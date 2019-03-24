Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448EFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A02148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KIxzftL+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jocBmcff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfCXRvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:51:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:51:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DEA261701; Sun, 24 Mar 2019 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449872;
        bh=4Y6RkaB0AykZ4q71OBhEdfBOkqirJigLfKWZ9ZQU31c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIxzftL+ltECzsD6y31oMx2B8Gq7AuqbdoSB1FMctOrPiEKlG+zC8d4IGAC4oV9hy
         jnbID/c1Mj7cIwFsUMk8lql6AYGIZqwYvd5oodgKi6rioQwWbWwlMZxVVUMHxsZ46L
         m90JVZKXlnrPqRZ8Rak3Tn2zUGoyzP+VvzVjukUA=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57C64616D3;
        Sun, 24 Mar 2019 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449862;
        bh=4Y6RkaB0AykZ4q71OBhEdfBOkqirJigLfKWZ9ZQU31c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jocBmcffEGnxj9PWxIbuu1zJwheLX2/yfsdLzZ6TrjXKC9qro9tIU8+wTsFr4yR6Y
         +sUu2jLY59P6Wo6uIz6FXGCpP91UY/Dn1XQ1Gn9yk4CRkiHPtZHdDsA0AymPix4nLB
         RrHc/1owSLrCQzJsKkNwGJX8vD491wMf4BdeYk/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57C64616D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 9/9] arm64: dts: qcom: msm8998: Add rpmpd node
Date:   Sun, 24 Mar 2019 23:20:07 +0530
Message-Id: <20190324175007.29040-10-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190324175007.29040-1-sibis@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rpmpd node on the msm8998 and define the available levels.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3fd0769fe648..b7e3e0646b9b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8998.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -272,6 +273,56 @@
 				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,msm8998-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_ret: opp1 {
+						opp-level = <RPM_SMD_LEVEL_RETENTION>;
+					};
+
+					rpmpd_opp_ret_plus: opp2 {
+						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+					};
+
+					rpmpd_opp_min_svs: opp3 {
+						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					};
+
+					rpmpd_opp_low_svs: opp4 {
+						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp5 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_plus: opp6 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmhpd_opp_nom: opp7 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_plus: opp8 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_plus: opp10 {
+						opp-level = <RPM_SMD_LEVEL_BINNING>;
+					};
+				};
+			};
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

