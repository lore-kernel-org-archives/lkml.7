Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CF2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE23B21920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S7Uvw58D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HCypB5ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbfJWJD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:03:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390773AbfJWJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:03:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92F5B60C8C; Wed, 23 Oct 2019 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571821402;
        bh=K9tw6jZeprl7ON7Tri7gB4VhamKN0dWIXfEJAxWnyxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7Uvw58DgZ6qbZyL0CsCYKJGtqJnhPgBNiY9WcK5j60hqMN+m+WGusRMMD3Cj1XlB
         DoACgBRCNqH8Ipkj1wYq5Vk7PNkgWwdGVDY7HQRcZG1eNq5DEi/yIw4Y5Z57y+Z+dd
         80yTQMRfc6S7hlIbsfkKaEKI+ZR05w33qUGnPVXI=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D84360DBC;
        Wed, 23 Oct 2019 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571821398;
        bh=K9tw6jZeprl7ON7Tri7gB4VhamKN0dWIXfEJAxWnyxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCypB5ra7Vqr86JzaAO6mWH8HDLqgA+pTELaOGO0JMoRVBj8gCydFO7sKmcrgkh/t
         6ULPOvPj9FXKaxciD04KUlCqXh17teMpzzMSq5k212w0lCfBhX+PYlnAixRJOzLmfj
         KC3Wfjvq0OxOnMPvB8LzOUQHnk9MSNfK9WIMD3DU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D84360DBC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 10/11] arm64: dts: qcom: SC7180: Add node for rpmhcc clock driver
Date:   Wed, 23 Oct 2019 14:32:18 +0530
Message-Id: <20191023090219.15603-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191023090219.15603-1-rnayak@codeaurora.org>
References: <20191023090219.15603-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

Add node for rpmhcc clock driver.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6584ac6e6c7b..f2981ada578f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -175,6 +176,9 @@
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sc7180";
 			reg = <0 0x00100000 0 0x1f0000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>;
+			clock-names = "bi_tcxo", "bi_tcxo_ao";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -425,6 +429,13 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sc7180-rpmh-clk";
+				clocks = <&xo_board>;
+				clock-names = "xo";
+				#clock-cells = <1>;
+			};
 		};
 	};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

