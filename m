Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35533C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A4214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GUnnAwXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKPRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 12:08:56 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39550 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfKPRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 12:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1573924132; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=H4fn2K8qNbR81iqS2OPnELmE3eh646O9s3d/5Chkcoo=;
        b=GUnnAwXp5Msy6zoKocdrgp1NzW2BfJyvXJ0Usr23BxB4SWnoUgtB0/20CPCugjOvpv+fEC
        iNBDZQ4+T0ww/FXSHcNcw6QDPaTn4oh4CACGwZR9lmOnwZcWOtdZmgCE8pOMsN1Zuskl1O
        MGyNXN18X3jWcsl0MZVEbruXl3LyjWw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/4] dt-bindings: Document JZ47xx VPU auxiliary processor
Date:   Sat, 16 Nov 2019 18:08:43 +0100
Message-Id: <20191116170846.67220-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
Ingenic is a second Xburst MIPS CPU very similar to the main core.
This document describes the devicetree bindings for this auxiliary
processor.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Update TCSM0 address in example
    v3: Change node name to 'video-decoder'

 .../bindings/remoteproc/ingenic,vpu.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
new file mode 100644
index 000000000000..54566e941869
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
@@ -0,0 +1,36 @@
+* Ingenic JZ47xx auxiliary processor
+
+Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from Ingenic
+is a second Xburst MIPS CPU very similar to the main core.
+This document describes the devicetree bindings for this auxiliary processor.
+
+Required properties:
+- compatible: Should be "ingenic,jz4770-vpu-rproc"
+- reg: Must contain the registers location and length for:
+  * the auxiliary processor,
+  * the Tightly Coupled Shared Memory 0 (TCSM0),
+  * the Tightly Coupled Shared Memory 1 (TCSM1),
+  * the shared SRAM.
+- reg-names: Must contain "aux", "tcsm0", "tcsm1", "sram".
+- clocks: Clock specifier for the AUX and VPU clocks.
+- clock-names: Must contain "aux", "vpu".
+- interrupts: Interrupt specifier for the VPU hardware block.
+
+Example:
+
+vpu: video-decoder@132a0000 {
+	compatible = "ingenic,jz4770-vpu-rproc";
+
+	reg = <0x132a0000 0x20 /* AUX */
+		   0x132b0000 0x4000 /* TCSM0 */
+		   0x132c0000 0xc000 /* TCSM1 */
+		   0x132f0000 0x7000 /* SRAM */
+	>;
+	reg-names = "aux", "tcsm0", "tcsm1", "sram";
+
+	clocks = <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;
+	clock-names = "aux", "vpu";
+
+	interrupt-parent = <&cpuintc>;
+	interrupts = <3>;
+};
-- 
2.24.0

