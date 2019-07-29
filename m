Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AD4C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006062073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Gu9Dk3bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfG2Sbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:31:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50154 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2Sbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564425090; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=O3w8PXHkIBNKZhUI3wzeeU0BnBNZ9vkkvKlnL8v4w5U=;
        b=Gu9Dk3bSPJpXpgP4oUOaw3JmLdQaLNLK4ZrS1OqEYh7vR+/r2gMs2INKwd/V7WLpTViRhj
        SeWau5itBdqYHGj6vimyUzvkTJQFyPfQbC9Gu1qCK6Hwc/qK6/XWjZDjZo6yJeqOOYsgzI
        +vD/a15wnhkzYGJTBwmUE6OcNFyyej0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings: Document JZ47xx VPU auxiliary processor
Date:   Mon, 29 Jul 2019 14:31:07 -0400
Message-Id: <20190729183109.18283-1-paul@crapouillou.net>
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

 .../bindings/remoteproc/ingenic,vpu.txt       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
new file mode 100644
index 000000000000..576f9e582780
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
2.21.0.593.g511ec345e18

