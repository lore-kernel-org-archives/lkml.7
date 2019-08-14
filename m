Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1833B208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfHNIWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:22:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:61816 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNIWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:22:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="194453103"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 01:22:47 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH 2/2] dt-bindings: lantiq: Update for new SoC
Date:   Wed, 14 Aug 2019 16:22:35 +0800
Message-Id: <f901ea1aaf6272b1e538772c3c6bb17adad5d003.1565770074.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
References: <cover.1565770074.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Lightning Mountain(LGM) SoC reuses Lantiq ASC serial controller IP.
This patch updates the dt bindings to support LGM as well.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/serial/lantiq_asc.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
index 9757f0a24232..d552fd31c16c 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       items:
         - const: lantiq,asc
+        - const: intel,lgm-asc
 
   reg:
     maxItems: 1
@@ -28,6 +29,12 @@ properties:
       - description: tx or combined interrupt
       - description: rx interrupt
       - description: err interrupt
+    description:
+      For lantiq,asc compatible, it supports 3 separate
+      interrupts for tx rx & err. Whereas, for intel,lgm-asc
+      compatible, it supports combined single interrupt for 
+      all of tx, rx & err interrupts.
+
 
   clocks:
     description:
@@ -67,4 +74,14 @@ examples:
             interrupts = <112 113 114>;
     };
 
+  - |
+    asc0: serial@e0a00000 {
+            compatible = "intel,lgm-asc";
+            reg = <0xe0a00000 0x1000>;
+            interrupt-parent = <&ioapic1>;
+            interrupts = <128 1>;
+            clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
+            clock-names = "freq", "asc";
+    };
+
 ...
-- 
2.11.0

