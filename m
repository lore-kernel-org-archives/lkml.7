Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B2F20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfCYPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:55:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:61246 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbfCYPzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:55:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="137124510"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2019 08:55:36 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/3] Documentation: dt: edac: Fix Stratix10 IRQ bindings
Date:   Mon, 25 Mar 2019 10:57:54 -0500
Message-Id: <1553529476-26181-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553529476-26181-1-git-send-email-thor.thayer@linux.intel.com>
References: <1553529476-26181-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Fix Stratix10 ECC bindings to specify only the single
bit error. On Stratix10 double bit errors are handled
as SErrors instead of interrupts.
Indicate the differences between the ARM64 and ARM32
EDAC architecture in the bindings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2 No change
v3 Add ARM64 to Stratix10 description for clarity about
   differences between Arria10 and Stratix10.
   Add Acked-by
---
 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index 5626560a6cfd..acb211c098c0 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -232,37 +232,46 @@ Example:
 		};
 	};
 
-Stratix10 SoCFPGA ECC Manager
+Stratix10 SoCFPGA ECC Manager (ARM64)
 The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
-in a shared register similar to the Arria10. However, ECC requires
-access to registers that can only be read from Secure Monitor with
-SMC calls. Therefore the device tree is slightly different.
+in a shared register similar to the Arria10. However, Stratix10 ECC
+requires access to registers that can only be read from Secure Monitor
+with SMC calls. Therefore the device tree is slightly different. Note
+that only 1 interrupt is sent in Stratix10 because the double bit errors
+are treated as SErrors in ARM64 instead of IRQs in ARM32.
 
 Required Properties:
 - compatible : Should be "altr,socfpga-s10-ecc-manager"
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
+- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
+	              containing the ECC manager registers.
+- interrupts : Should be single bit error interrupt.
 - interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
 - #interrupt-cells : must be set to 2.
+- #address-cells: must be 1
+- #size-cells: must be 1
+- ranges : standard definition, should translate from local addresses
 
 Subcomponents:
 
 SDRAM ECC
 Required Properties:
 - compatible : Should be "altr,sdram-edac-s10"
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
+- interrupts : Should be single bit error interrupt.
 
 Example:
 
 	eccmgr {
 		compatible = "altr,socfpga-s10-ecc-manager";
-		interrupts = <0 15 4>, <0 95 4>;
+		altr,sysmgr-syscon = <&sysmgr>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <0 15 4>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		ranges;
 
 		sdramedac {
 			compatible = "altr,sdram-edac-s10";
-			interrupts = <16 4>, <48 4>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-- 
2.7.4

