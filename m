Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EDCC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D3021993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NLjOKntL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfGVCb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:31:58 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37192 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfGVCb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563762715; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=W4Y3xNv8DzGeNbpxDkocLZEsOwkzbTg/G7OrEllTF/c=;
        b=NLjOKntL3Kzim+iZ5XNGr5PfQ4EJPM51BlW52U9IuigpRFYVqe1BqnQNiq8qL5CeM3dl9e
        dpaBULyfwAB58wkqpiBl2FuHOWkZUJNxjW6e7zrB8dDt4uIZZ4e1zPcjzCmvj86yahLtmy
        WkhInAClnHeD1rz0icZzgsexKsGejBA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] dt-bindings: Document JZ47xx VPU auxiliary processor
Date:   Sun, 21 Jul 2019 22:31:38 -0400
Message-Id: <20190722023140.14701-1-paul@crapouillou.net>
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
 .../bindings/remoteproc/ingenic,vpu.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
new file mode 100644
index 000000000000..fde86ad5a008
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
+vpu: cpu@132a0000 {
+	compatible = "ingenic,jz4770-vpu-rproc";
+
+	reg = <0x132a0000 0x20 /* AUX */
+		   0xf4000000 0x4000 /* TCSM0 */
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
2.21.0.593.g511ec345e18

