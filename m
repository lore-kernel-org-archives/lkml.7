Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A04C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC422190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCWObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:25 -0400
Received: from asrmicro.com ([210.13.118.86]:10781 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:24 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5DEd031350;
        Sat, 23 Mar 2019 22:05:13 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxqt7029576;
        Sat, 23 Mar 2019 21:59:52 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:01:29
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH 2/7] dt-bindings: bus: add ASR8751C APB/AXI bindings
Date:   Sat, 23 Mar 2019 22:01:23 +0800
Message-ID: <1553349688-1946-3-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxqt7029576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add binding documentation for ASR8751C AXI/APB bus that are used
to interface with peripherals. AXI/APB bus follow standard AXI/APB
protocols.

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 Documentation/devicetree/bindings/bus/asr,bus.txt | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/asr,bus.txt

diff --git a/Documentation/devicetree/bindings/bus/asr,bus.txt b/Documentation/devicetree/bindings/bus/asr,bus.txt
new file mode 100644
index 0000000..cbb1b6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/asr,bus.txt
@@ -0,0 +1,42 @@
+* ASR AXI/APB Simple Bus
+
+This file documents core properties in ASR AXI and APB bus.
+
+The ASR8751C SoC has APB and AXI buses for cores to access its
+controllers, suchas i2c, sdh, rtc, clock, power management registers
+etc. Most ASR SoCs share the common architecture for buses.
+Generally APB and AXI bus have a source clock and power control, and
+clock rate can be changed and power can be shutdown in low power mode.
+
+Required properties for AXI bus:
+- compatible: should be "asr,axi-bus", "simple-bus".
+- #address-cells: could be 1, or 2
+- #size-cells: could be 1, or 2
+- reg: iomem address of AXI bus registers
+- ranges: register ranges
+
+Example:
+	axi@d4200000 {	/* AXI */
+		compatible = "asr,axi-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xd4200000 0 0x00200000>;
+		ranges = <0 0 0 0xffffffff>;
+
+	};
+
+Required properties for APB bus:
+- compatible: should be "asr,apb-bus", "simple-bus".
+- #address-cells: could be 1, or 2
+- #size-cells: could be 1, or 2
+- reg: iomem address of APB bus registers
+- ranges: register ranges
+
+Example:
+	apb@d4000000 {	/* APB */
+		compatible = "asr,apb-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xd4000000 0 0x00200000>;
+		ranges = <0 0 0 0xffffffff>;
+	};
-- 
2.7.4

