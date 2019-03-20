Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0F32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eJNQlVNM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O4DZmksQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCTJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfCTJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E44D4611FC; Wed, 20 Mar 2019 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075396;
        bh=8pz9GCv+wR14deeMeTAyvCCDpED1/iT5SYYztD7lVvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJNQlVNMQTI12AsrFve/LdMdhcCYJFUtD2RNauSvfwe0IZMiTb+GFsQWYglN3iQ6U
         embaeeXfBL36RxMFteztLyS9Y6QBN7r8pWrR3eFev1xD+MKvqFpD/5uVs4VdxbJA1Z
         zGkS1UG6mdzCj8P1SwwGJ5T7nUMK5SYnf+iHC3Dc=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B762E61197;
        Wed, 20 Mar 2019 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075395;
        bh=8pz9GCv+wR14deeMeTAyvCCDpED1/iT5SYYztD7lVvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4DZmksQuyr/L5fNI154eDOGC6kLocTBNFNXl7a3aVkr7f34k76q7NWxc3SqHBvsD
         5jueceYjHBM7LIcXJvt1/mu5sBU1vYCe0n+KKA1xCNXK2Hw4pCqcUfRrnA2GuBT411
         wH4NVMopdv+aGi/EpnTyQ6qCCQ+jiP6dH+FKLw3U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B762E61197
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
Subject: [RFC v2 05/11] arm64: dts: sdm845: Add OPP table for all qup devices
Date:   Wed, 20 Mar 2019 15:19:12 +0530
Message-Id: <20190320094918.20234-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup has a requirement to vote on the performance state of the CX domain
in sdm845 devices. Add OPP tables for these and also add power-domains
property for all qup instances.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 115 +++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e4b69c74fe07..027ffe6e93e8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -409,6 +409,25 @@
 			clock-names = "core";
 		};
 
+		qup_opp_table: qup-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-19200000 {
+				opp-hz = /bits/ 64 <19200000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+			};
+
+			opp-100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				required-opps = <&rpmhpd_opp_svs>;
+			};
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x6000>;
@@ -430,6 +449,8 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -443,6 +464,8 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -454,6 +477,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -467,6 +492,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -480,6 +507,8 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -491,6 +520,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -504,6 +535,8 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -517,6 +550,8 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -528,6 +563,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -541,6 +578,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -554,6 +593,8 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -565,6 +606,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -578,6 +621,8 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -591,6 +636,8 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -602,6 +649,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -615,6 +664,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -628,6 +679,8 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -639,6 +692,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -652,6 +707,8 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -665,6 +722,8 @@
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -676,6 +735,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -689,6 +750,8 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -702,6 +765,8 @@
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -713,6 +778,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
@@ -738,6 +805,8 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -751,6 +820,8 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -762,6 +833,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -775,6 +848,8 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -788,6 +863,8 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -799,6 +876,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -812,6 +891,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -825,6 +906,8 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -836,6 +919,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -849,6 +934,8 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -862,6 +949,8 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -873,6 +962,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -886,6 +977,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -899,6 +992,8 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -910,6 +1005,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart12_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -923,6 +1020,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -936,6 +1035,8 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -947,6 +1048,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart13_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -960,6 +1063,8 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -973,6 +1078,8 @@
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -984,6 +1091,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart14_default>;
 				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -997,6 +1106,8 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -1010,6 +1121,8 @@
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -1021,6 +1134,8 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart15_default>;
 				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				power-domains = <&rpmhpd SDM845_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 		};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

