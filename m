Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0556D22513
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TjhbK4O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfGWK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:26:36 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:39818 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730141AbfGWK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:26:33 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 334DAC018D;
        Tue, 23 Jul 2019 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563877593; bh=9EQdLFPCKtMvNPp2+VskSltaXSuqOCA6tYIGyuKj/eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjhbK4O4Y4vQSRWm8bRpyvrgR9/6eL6pp3pX0mtSUq6kLI18Dld5+p9Y5IBD0iet8
         CgKSh/4hQnHCFB03fma5I3yiK3LN7wmD1ENVN1FNir/5SgNXmvoYZk4CMHxWnQ2hw2
         S8ZCojfMPAMvo5RXJ4Wnh0EdO+MrvdFi2wO2BLe0sk+tBUAmdC9R2c7jOY/JVLaiuo
         43jbbdSmqbBPd9t5RJbLnZx94sKRX/4HTXy78Z7AjlyuNFUXtgT5bJcbFs53t8Qy+b
         aCsmGL8gwngaAoABIqZDceGAgM5UzrNSKDwNnlYdrfRAwwfF6lT4dTvZomzUN5NaIu
         /0PIdLNCzQJBw==
Received: from de02arcdev1.internal.synopsys.com (de02arcdev1.internal.synopsys.com [10.225.22.192])
        by mailhost.synopsys.com (Postfix) with ESMTP id F2776A005E;
        Tue, 23 Jul 2019 10:26:30 +0000 (UTC)
From:   Mischa Jonker <Mischa.Jonker@synopsys.com>
To:     Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: [PATCH 2/2] dt-bindings: IDU-intc: Add support for edge-triggered interrupts
Date:   Tue, 23 Jul 2019 12:26:06 +0200
Message-Id: <20190723102606.309089-2-mischa.jonker@synopsys.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190723102606.309089-1-mischa.jonker@synopsys.com>
References: <20190723102606.309089-1-mischa.jonker@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the documentation for supporting  a optional extra interrupt
cell to specify edge vs level triggered.

Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
---
 .../interrupt-controller/snps,archs-idu-intc.txt   | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
index 09fc02b..a5c1db9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
@@ -1,20 +1,30 @@
 * ARC-HS Interrupt Distribution Unit
 
-  This optional 2nd level interrupt controller can be used in SMP configurations for
-  dynamic IRQ routing, load balancing of common/external IRQs towards core intc.
+  This optional 2nd level interrupt controller can be used in SMP configurations
+  for dynamic IRQ routing, load balancing of common/external IRQs towards core
+  intc.
 
 Properties:
 
 - compatible: "snps,archs-idu-intc"
 - interrupt-controller: This is an interrupt controller.
-- #interrupt-cells: Must be <1>.
-
-  Value of the cell specifies the "common" IRQ from peripheral to IDU. Number N
-  of the particular interrupt line of IDU corresponds to the line N+24 of the
-  core interrupt controller.
-
-  intc accessed via the special ARC AUX register interface, hence "reg" property
-  is not specified.
+- #interrupt-cells: Must be <1> or <2>.
+
+  Value of the first cell specifies the "common" IRQ from peripheral to IDU.
+  Number N of the particular interrupt line of IDU corresponds to the line N+24
+  of the core interrupt controller.
+
+  The (optional) second cell specifies any of the following flags:
+    - bits[3:0] trigger type and level flags
+        1 = low-to-high edge triggered
+        2 = NOT SUPPORTED (high-to-low edge triggered)
+        4 = active high level-sensitive <<< DEFAULT
+        8 = NOT SUPPORTED (active low level-sensitive)
+  When no second cell is specified, the interrupt is assumed to be level
+  sensitive.
+
+  The interrupt controller is accessed via the special ARC AUX register
+  interface, hence "reg" property is not specified.
 
 Example:
 	core_intc: core-interrupt-controller {
-- 
2.8.3

