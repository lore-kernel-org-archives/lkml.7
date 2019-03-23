Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F1C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FDD2192B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfCWOba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:30 -0400
Received: from asrmicro.com ([210.13.118.86]:52492 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWOb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:29 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5Ho1031353;
        Sat, 23 Mar 2019 22:05:17 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxqkA029579;
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
Subject: [PATCH 3/7] dt-bindings: clocks: add ASR8751C bindings
Date:   Sat, 23 Mar 2019 22:01:24 +0800
Message-ID: <1553349688-1946-4-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxqkA029579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add binding documentation for ASR8751C clocks, which are general gating
fixed rate and fixed ratio clocks derived from system PLL, external
oscillator. These clocks control registers are distributed on different
sub-controller-unit on SoCs, like APMU, MPMU, CIU etc.

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 .../devicetree/bindings/clock/asr,clock.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/asr,clock.txt

diff --git a/Documentation/devicetree/bindings/clock/asr,clock.txt b/Documentation/devicetree/bindings/clock/asr,clock.txt
new file mode 100644
index 0000000..93082a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/asr,clock.txt
@@ -0,0 +1,31 @@
+* Clock Controller of ASR8751C SoCs
+
+clock subsystem generates and supplies clock to various controllers within the
+ASR8751C SoC.
+
+Required Properties:
+
+- compatible: should be "asr,8751c-clock"
+
+- reg: iomem address and length of the clock subsystem. There are 7 places in
+  SOC has clock control logic: "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu",
+  "ddrc".
+- reg-names: register names of each sub control logic.
+- interrupts : Should be the interrupt number
+- #clock-cells: should be 1.
+
+Example:
+
+	soc_clocks: clocks@d4050000{
+		compatible = "asr,8751c-clock";
+		reg = <0x0 0xd4050000 0x0 0x209c>,
+		      <0x0 0xd4282800 0x0 0x400>,
+		      <0x0 0xd4015000 0x0 0x1000>,
+		      <0x0 0xd4090000 0x0 0x1000>,
+		      <0x0 0xd4282c00 0x0 0x400>,
+		      <0x0 0xd8440000 0x0 0x98>,
+		      <0x0 0xd4200000 0x0 0x4280>;
+		reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc";
+		interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+		#clock-cells = <1>;
+	};
-- 
2.7.4

