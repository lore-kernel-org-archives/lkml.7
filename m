Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ABD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pOO5e5bD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pDrdQayL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfCTJuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfCTJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91C2260E7A; Wed, 20 Mar 2019 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075423;
        bh=DYGp4mJemThF5cybfUDtR3jNQYuv3Ul5MNkBVbP0sSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOO5e5bDcMcTLGJ0vw3WuXXXLqQeiVshJVe8Yiv4Zui2ydXwCs+//sNLREmMmVX0p
         e5JdeafAFWbGXSQS+1FbtF2wUV+L1YzwCfGNbxbKDoRDsKFXXUQ9MYJcJkpDJM5gNW
         zVXsMIuNaeHk3dOr3sEXkqHPN7No3/muLAatDd1s=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA356072E;
        Wed, 20 Mar 2019 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075422;
        bh=DYGp4mJemThF5cybfUDtR3jNQYuv3Ul5MNkBVbP0sSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDrdQayL0GkEkOUFDOIUrv5VsiN5iIsH0FQT87oElq9a0WLvdsm6KRWZExOhxgSm+
         3kHCe4zdzEwpbGeWpcVM90HYdmQVjJShU/LUn2E3HeM06nxaOoA1PlV27Upm3u2+o6
         NubMuEsDbIY+QmKqcAOpnAbLPXaSwwgeE4I0X7Uk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA356072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 11/11] arm64: dts: sdm845: Add DSI and MDP OPP tables and power-domains
Date:   Wed, 20 Mar 2019 15:19:18 +0530
Message-Id: <20190320094918.20234-12-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OPP tables for DSI and MDP based on the perf state/clk
requirements, and add the power-domains property to specify the
scalable power domain.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a3af4a1757b4..675954fde391 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1857,6 +1857,59 @@
 			#reset-cells = <1>;
 		};
 
+		mdp_opp_table: mdp-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-19200000 {
+				opp-hz = /bits/ 64 <19200000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-171428571 {
+				opp-hz = /bits/ 64 <171428571>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-344000000 {
+				opp-hz = /bits/ 64 <344000000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-430000000 {
+				opp-hz = /bits/ 64 <430000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
+		dsi_opp_table: dsi-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-19200000 {
+				opp-hz = /bits/ 64 <19200000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-180000000 {
+				opp-hz = /bits/ 64 <180000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-275000000 {
+				opp-hz = /bits/ 64 <275000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+
+			opp-328580000 {
+				opp-hz = /bits/ 64 <328580000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-358000000 {
+				opp-hz = /bits/ 64 <358000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
+
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sdm845-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
@@ -1901,6 +1954,8 @@
 						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
 				assigned-clock-rates = <300000000>,
 						       <19200000>;
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
@@ -1947,6 +2002,8 @@
 					      "core",
 					      "iface",
 					      "bus";
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				phys = <&dsi0_phy>;
 				phy-names = "dsi";
@@ -2013,6 +2070,8 @@
 					      "core",
 					      "iface",
 					      "bus";
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SDM845_CX>;
 
 				phys = <&dsi1_phy>;
 				phy-names = "dsi";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

