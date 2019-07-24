Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76200C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDB0229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cCpiPXF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfGXMHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:07:09 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:47286 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbfGXMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:07:07 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 54B66C1BE9;
        Wed, 24 Jul 2019 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563970027; bh=9yLr3tHkJx37O0E/j4hIar6/6qoO+IpYNGwETfHlldA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCpiPXF0AwsV7qgl0JUT5rMuBZUMTpVIf40gtQSj8H/6VvDmDEmYf3Ay1fSje8Kd3
         PHQ0pROrmGyKjL1Wy2VyrO6vCSWqLWiiHHazBire7O1wIDUYh+uaogDsI4cp1r0Ul7
         BCvTNwBe21KHWjvJcs2XhB2w/H10YHQDAJXR/6Y1jNY+FEhoQ40JWJJI4vahmrlCiF
         8H5oyQZGQSL653hIQQu8eGIXAMRVnnDMwCLALwmeYHnkSkAg4WoUIgikcjrvTbK7hV
         qCT8s97qLGD2plBUyj/IonY5FmGVQJhDl6F7RKB1CKib8s4CYMvsLedIObevANHx97
         02BYz6DaB3NJg==
Received: from de02arcdev1.internal.synopsys.com (de02arcdev1.internal.synopsys.com [10.225.22.192])
        by mailhost.synopsys.com (Postfix) with ESMTP id 22187A005C;
        Wed, 24 Jul 2019 12:07:06 +0000 (UTC)
From:   Mischa Jonker <Mischa.Jonker@synopsys.com>
To:     Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: [PATCH v2 3/3] dt-bindings: IDU-intc: Add support for edge-triggered interrupts
Date:   Wed, 24 Jul 2019 14:04:36 +0200
Message-Id: <20190724120436.8537-3-mischa.jonker@synopsys.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190724120436.8537-1-mischa.jonker@synopsys.com>
References: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
 <20190724120436.8537-1-mischa.jonker@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the documentation for supporting an optional extra interrupt
cell to specify edge vs level triggered.

Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
---
 .../interrupt-controller/snps,archs-idu-intc.txt      | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
index c5a1c7b..a5c1db9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,archs-idu-intc.txt
@@ -8,11 +8,20 @@ Properties:
 
 - compatible: "snps,archs-idu-intc"
 - interrupt-controller: This is an interrupt controller.
-- #interrupt-cells: Must be <1>.
-
-  Value of the cell specifies the "common" IRQ from peripheral to IDU. Number N
-  of the particular interrupt line of IDU corresponds to the line N+24 of the
-  core interrupt controller.
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
 
   The interrupt controller is accessed via the special ARC AUX register
   interface, hence "reg" property is not specified.
-- 
2.8.3

