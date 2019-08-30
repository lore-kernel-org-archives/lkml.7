Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F721726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfH3J1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:27:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50538 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfH3J1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:27:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C9E9D1A03CC;
        Fri, 30 Aug 2019 11:27:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 395DE1A00A9;
        Fri, 30 Aug 2019 11:27:26 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B845402D7;
        Fri, 30 Aug 2019 17:27:20 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [1/2] dt-bindings: rtc: pcf85263/pcf85363: add some properties
Date:   Fri, 30 Aug 2019 17:17:19 +0800
Message-Id: <20190830091720.41156-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some properties for pcf85263/pcf85363 as follows:
  - interrupt-output-pin: string type
  - quartz-load-capacitance: integer type
  - quartz-drive-strength: integer type
  - quartz-low-jitter: bool type
  - wakeup-source: bool type

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../devicetree/bindings/rtc/pcf85363.txt      | 31 +++++++++++++++++++
 include/dt-bindings/rtc/pcf85363.h            | 15 +++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 include/dt-bindings/rtc/pcf85363.h

diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
index 94adc1cf93d9..d83359990bd7 100644
--- a/Documentation/devicetree/bindings/rtc/pcf85363.txt
+++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
@@ -8,10 +8,41 @@ Required properties:
 Optional properties:
 - interrupts: IRQ line for the RTC (not implemented).
 
+- interrupt-output-pin: The interrupt output pin must be
+  "NONE", "INTA" or "INTB", default value is "NONE"
+
+- quartz-load-capacitance: The internal capacitor to select for the quartz:
+	PCF85263_QUARTZCAP_7pF		[0]
+	PCF85263_QUARTZCAP_6pF		[1]
+	PCF85263_QUARTZCAP_12p5pF	[2] DEFAULT
+
+- quartz-drive-strength: Drive strength for the quartz:
+	PCF85263_QUARTZDRIVE_NORMAL	[0] DEFAULT
+	PCF85263_QUARTZDRIVE_LOW	[1]
+	PCF85263_QUARTZDRIVE_HIGH	[2]
+
+- quartz-low-jitter: Boolean property, if present enables low jitter mode
+  which reduces jitter at the cost of increased power consumption.
+
+- wakeup-source: Boolean property, mark the chip as a wakeup source,
+  independently of the availability of an IRQ line connected to the SoC.
+  This is useful if the IRQ line is connected to a PMIC or other circuit
+  that can power up the device rather than to a normal SOC interrupt.
+
 Example:
 
 pcf85363: pcf85363@51 {
 	compatible = "nxp,pcf85363";
 	reg = <0x51>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+	#include <dt-bindings/rtc/pcf85363.h>
+	wakeup-source;
+	interrupt-output-pin = "INTA";
+	quartz-load-capacitance = <PCF85363_QUARTZCAP_12p5pF>;
+	quartz-drive-strength = <PCF85363_QUARTZDRIVE_LOW>;
+	quartz-low-jitter;
 };
 
diff --git a/include/dt-bindings/rtc/pcf85363.h b/include/dt-bindings/rtc/pcf85363.h
new file mode 100644
index 000000000000..2c06c28eb5ff
--- /dev/null
+++ b/include/dt-bindings/rtc/pcf85363.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_RTC_PCF85363_H
+#define _DT_BINDINGS_RTC_PCF85363_H
+
+/* Quartz capacitance */
+#define PCF85363_QUARTZCAP_7pF		0
+#define PCF85363_QUARTZCAP_6pF		1
+#define PCF85363_QUARTZCAP_12p5pF	2
+
+/* Quartz drive strength */
+#define PCF85363_QUARTZDRIVE_NORMAL	0
+#define PCF85363_QUARTZDRIVE_LOW	1
+#define PCF85363_QUARTZDRIVE_HIGH	2
+
+#endif /* _DT_BINDINGS_RTC_PCF85363_H */
-- 
2.17.1

