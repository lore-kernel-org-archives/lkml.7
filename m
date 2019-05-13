Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D4C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF97B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XQjfCPD5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rp0gszvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfEMKU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:20:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfEMKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:20:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AEDF76115D; Mon, 13 May 2019 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557742855;
        bh=UXI5aOJAovwTCn4b4Ku7WbQH/PEWiqh8TRq5o7PQsDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQjfCPD5YpoVHkSfRyKxS0pLgNGjxP3BZGIyN2Gm3TsMIWOr9ZQoMIQKdqLYWoXUf
         VOcgMSVbMRxpae6GDi1951BuTtrZV0/Rm+4jtsYgoieamhT5LQNBnNhEaXa6RfsvbG
         d3jbPYf+ldNXXg+uUN4EKsvLydTVUF29/DpUJzwk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8B2E6115D;
        Mon, 13 May 2019 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557742854;
        bh=UXI5aOJAovwTCn4b4Ku7WbQH/PEWiqh8TRq5o7PQsDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rp0gszvNgmg+4CIBDXNkYoxwbOAvBbvpEN1Ylp3j68uDw8qMeyhcQiVKSM8oScgrB
         zVJcPjzPL8tRX37n9rA6VeVInWSFV7dnE41rnwSTOo1O78zZh+o91hKlk+Pz0macht
         vYbF+keG19Omz6XYYaKVaypMhwjt4yx1Q7Qd/Ts0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8B2E6115D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        marc.w.gonzalez@free.fr, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 6/9] arm64: dts: qcom: qcs404: Add rpmpd node
Date:   Mon, 13 May 2019 15:50:12 +0530
Message-Id: <20190513102015.26551-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513102015.26551-1-sibis@codeaurora.org>
References: <20190513102015.26551-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the rpmpd node on the qcs404 and define the available levels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[sibis: fixup available levels]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..d1484480c237 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -230,6 +231,60 @@
 				compatible = "qcom,rpmcc-qcs404";
 				#clock-cells = <1>;
 			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,qcs404-rpmpd";
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
+					rpmpd_opp_svs: opp5 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmpd_opp_svs_plus: opp6 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmpd_opp_nom: opp7 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmpd_opp_nom_plus: opp8 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmpd_opp_turbo: opp9 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmpd_opp_turbo_no_cpr: opp10 {
+						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+					};
+
+					rpmpd_opp_turbo_plus: opp11 {
+						opp-level = <RPM_SMD_LEVEL_BINNING>;
+					};
+				};
+			};
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

