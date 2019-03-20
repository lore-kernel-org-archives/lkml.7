Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B6F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCTMxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:53:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTMxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:53:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31E02D2D643F82DD8FDE;
        Wed, 20 Mar 2019 20:53:42 +0800 (CST)
Received: from SHA1000170415.huawei.com (100.106.92.139) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 20:53:35 +0800
From:   Wanglai Shi <shiwanglai@hisilicon.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <xuwei5@hisilicon.com>, <alexander.shishkin@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leo.yan@linaro.org>, <suzhuangluan@hisilicon.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: coresight: Support non-configurable funnel
Date:   Wed, 20 Mar 2019 20:38:08 +0800
Message-ID: <1553085490-42870-2-git-send-email-shiwanglai@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com>
References: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.106.92.139]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Document DT binding for non-configurable funnel and give an example
for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt     | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f8aff65ab921..e63ec3362af8 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -8,7 +8,8 @@ through the intermediate links connecting the source to the currently selected
 sink. Each CoreSight component device should use these properties to describe
 its hardware characteristcs.
 
-* Required properties for all components *except* non-configurable replicators:
+* Required properties for all components *except* non-configurable replicators
+  and non-configurable funnels:
 
 	* compatible: These have to be supplemented with "arm,primecell" as
 	  drivers are using the AMBA bus interface.  Possible values include:
@@ -24,7 +25,7 @@ its hardware characteristcs.
 		  discovered at boot time when the device is probed.
 			"arm,coresight-tmc", "arm,primecell";
 
-		- Trace Funnel:
+		- Trace Programmable Funnel:
 			"arm,coresight-funnel", "arm,primecell";
 
 		- Embedded Trace Macrocell (version 3.x) and
@@ -65,11 +66,12 @@ its hardware characteristcs.
 	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
 
 * Required properties for devices that don't show up on the AMBA bus, such as
-  non-configurable replicators:
+  non-configurable replicators and non-configurable funnels:
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
 		- "arm,coresight-replicator"
+		- "arm,coresight-funnel"
 
 	* port or ports: see "Graph bindings for Coresight" below.
 
@@ -200,6 +202,43 @@ Example:
 		};
 	};
 
+	funnel {
+		/*
+		 * non-configurable funnel don't show up on the AMBA
+		 * bus.  As such no need to add "arm,primecell".
+		 */
+		compatible = "arm,coresight-funnel";
+		clocks = <&crg_ctrl HI3660_PCLK>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				combo_funnel_out: endpoint {
+					remote-endpoint = <&top_funnel_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				combo_funnel_in0: endpoint {
+					remote-endpoint = <&cluster0_etf_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				combo_funnel_in1: endpoint {
+					remote-endpoint = <&cluster1_etf_out>;
+				};
+			};
+		};
+	};
+
 	funnel@20040000 {
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x20040000 0 0x1000>;
-- 
2.17.1

