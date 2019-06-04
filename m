Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EDC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E92255DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFDCZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:25:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37762 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbfFDCZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:25:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08621082|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.457986-0.024733-0.517281;FP=8026422909421434835|2|2|3|0|-1|-1|-1;HT=e02c03310;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Eh75bE2_1559615109;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Eh75bE2_1559615109)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 04 Jun 2019 10:25:09 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 4/6] dt-bindings: csky: Add csky PMU bindings
Date:   Tue,  4 Jun 2019 10:23:58 +0800
Message-Id: <0ac19e3d8840bc422967653dba9c9b96f5767357.1559614824.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation to describe that how to add pmu node in
dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/csky/pmu.txt | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

diff --git a/Documentation/devicetree/bindings/csky/pmu.txt b/Documentation/devicetree/bindings/csky/pmu.txt
new file mode 100644
index 0000000..53c3b0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/pmu.txt
@@ -0,0 +1,38 @@
+============================
+C-SKY Performance Monitor Units
+============================
+
+C-SKY 8xx series cores often have a PMU for counting cpu and cache events.
+The C-SKY PMU representation in the device tree should be done as under:
+
+==============================
+PMU node bindings definition
+==============================
+
+	Description: Describes PMU
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,csky-pmu"
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be pmu irq num defined by soc
+	- count-width
+		Usage: optional
+		Value type: <u32>
+		Definition: the width of pmu counter
+
+Examples:
+---------
+
+        pmu {
+                compatible = "csky,csky-pmu";
+                interrupts = <0x17 IRQ_TYPE_EDGE_RISING>;
+                interrupt-parent = <&intc>;
+		count-width = <0x30>;
+        };
+
-- 
2.7.4

