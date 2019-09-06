Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B362082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbfIFMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:54:30 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:61679 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404840AbfIFMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:54:28 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Sep 2019 18:18:16 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Sep 2019 18:18:15 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id CA097473A; Fri,  6 Sep 2019 18:18:13 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     asutoshd@codeaurora.org, vbadigan@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Pradeep P V K <ppvk@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC 2/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported strings
Date:   Fri,  6 Sep 2019 18:17:17 +0530
Message-Id: <1567774037-2344-3-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Bus bandwidth voting supported strings for qcom-sdhci controller.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index da4edb1..8255d92 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -39,6 +39,25 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+Optional Properties:
+* Following bus parameters are required for bus bw voting:
+- interconnects: Pairs of phandles and interconnect provider specifier
+		 to denote the edge source and destination ports of
+		 the interconnect path. Please refer to
+		 Documentation/devicetree/bindings/interconnect/
+		 for more details.
+- interconnect-names: List of interconnect path name strings sorted in the same
+		order as the interconnects property. Consumers drivers will use
+		interconnect-names to match interconnect paths with interconnect
+		specifiers. Please refer to Documentation/devicetree/bindings/
+		interconnect/ for more details.
+- qcom,msm-bus,name: string describing the bus path
+- qcom,msm-bus,num-cases: number of configurations in which sdhc can operate in
+- qcom,msm-bus,num-paths: number of paths to vote for
+- qcom,msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples for 2
+				num-paths) The number of these entries *must*
+				be same as num-cases.
+
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -56,6 +75,19 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+		interconnects = <&qnoc 50 &qnoc 512>,
+				<&qnoc 1 &qnoc 544>;
+		interconnect-names = "sdhc-ddr","cpu-sdhc";
+		qcom,msm-bus,name = "sdhc1";
+		qcom,msm-bus,num-cases = <3>;
+		qcom,msm-bus,num-paths = <2>;
+		qcom,msm-bus,vectors-KBps =
+		/* No Vote */
+		<0 0>, <0 0>,
+		/* 50 MB/s */
+		<130718 200000>, <133320 133320>,
+		/* 200 MB/s */
+		<1338562 4096000>, <1338562 4096000>;
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-- 
1.9.1

