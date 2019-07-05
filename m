Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E028C4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6820989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfGEK1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:27:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52366 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfGEK1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:27:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6549B1A0782;
        Fri,  5 Jul 2019 12:27:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85C6C1A0176;
        Fri,  5 Jul 2019 12:27:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 535FD40297;
        Fri,  5 Jul 2019 18:27:06 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        leoyang.li@nxp.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaobo.xie@nxp.com, jiafei.pan@nxp.com, ran.wang_1@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 2/2] Documentation: dt: binding: rtc: add binding for ftm alarm driver
Date:   Fri,  5 Jul 2019 18:18:00 +0800
Message-Id: <20190705101800.44561-2-biwen.li@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190705101800.44561-1-biwen.li@nxp.com>
References: <20190705101800.44561-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds binding for ftm alarm driver

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../devicetree/bindings/rtc/rtc-fsl-ftm-alarm.txt  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-fsl-ftm-alarm.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-fsl-ftm-alarm.txt b/Documentation/devicetree/bindings/rtc/rtc-fsl-ftm-alarm.txt
new file mode 100644
index 0000000..0f330b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-fsl-ftm-alarm.txt
@@ -0,0 +1,33 @@
+Freescale FlexTimer Module (FTM) Alarm
+
+Required properties:
+
+- compatible : Should be "fsl,ftm-alarm" or "fsl,<chip>-ftm-alarm", the
+	       supported chips include
+	       "fsl,ls1012a-ftm-alarm"
+	       "fsl,ls1021a-ftm-alarm"
+	       "fsl,ls1028a-ftm-alarm"
+	       "fsl,ls1043a-ftm-alarm"
+	       "fsl,ls1046a-ftm-alarm"
+	       "fsl,ls1088a-ftm-alarm"
+	       "fsl,ls208xa-ftm-alarm"
+- reg : Specifies base physical address and size of the register sets for the
+  FlexTimer Module and base physical address of IP Powerdown Exception Control
+  Register.
+- reg-names: names of the mapped memory regions listed in regs property.
+  should include the following entries:
+  "ftm":    Address of the register sets for FlexTimer Module
+  "pmctrl": Address of IP Powerdown Exception Control register
+- interrupts : Should be the FlexTimer Module interrupt.
+- big-endian: If the host controller is big-endian mode, specify this property.
+  The default endian mode is little-endian.
+
+Example:
+ftm_alarm0: timer@29d0000 {
+	compatible = "fsl,ls1043a-ftm-alarm";
+	reg = <0x0 0x29d0000 0x0 0x10000>,
+	      <0x0 0x1ee2140 0x0 0x4>;
+	reg-names = "ftm", "pmctrl";
+	interrupts = <0 86 0x4>;
+	big-endian;
+};
-- 
2.7.4

