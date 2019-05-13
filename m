Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD9C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781F7214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557741350;
	bh=oBK1biDBLmIPe322+TnzKnO2lD/uQWE4bpsvuqhkUG4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j9RTjoNfZK4cbYFhuO0BFvAQlC1I7Ryza/gfUCfh/ZlFzfTY6YzEUJ4mwE+DpnvSo
	 ITRvuIJZuozeq0/vrRpm3UkL5JzzbWOGbCc0k9ok6oxMEsyiG4mrPOhKftvISqK3mw
	 +0QR7RLI/ImYQBYRyW2LiwOljTGmOB5u5yZcjD0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfEMJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfEMJzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:55:49 -0400
Received: from localhost.localdomain (unknown [220.191.38.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C278F20989;
        Mon, 13 May 2019 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557741348;
        bh=oBK1biDBLmIPe322+TnzKnO2lD/uQWE4bpsvuqhkUG4=;
        h=From:To:Cc:Subject:Date:From;
        b=sOBwZ3NWwH7L9jResc4eBh8WTEYKs6VH3CZdSi/GPLTLNpfRkUKioVEklLhwMtFOO
         0PQzmNfqVQ2deRbfsc2GU6etbRfekKnWQnLsnap3Mo99WyVcGzhdiOi13KrNXg4V0i
         CFlidYlGSERf8+LWd1vri41qfFwwLh9vNMzMKnUk=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, guoren@kernel.org, ren_guo@c-sky.com
Subject: [PATCH V3 1/2] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Mon, 13 May 2019 17:55:38 +0800
Message-Id: <1557741339-29331-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type and priority setting for csky,mpintc. The driver also
could support #interrupt-cells <1> and it wouldn't invalidate existing
DTs. Here we only show the complete format.

Changes for V3:
 - Update commit msg about compatible

Changes for V2:
 - change #interrupt-cells to <3>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../bindings/interrupt-controller/csky,mpintc.txt   | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..dccd913 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
 SMP soc, and it also could be used in non-SMP system.
 
 Interrupt number definition:
-
   0-15  : software irq, and we use 15 as our IPI_IRQ.
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode:
+ IRQ_TYPE_LEVEL_HIGH (default)
+ IRQ_TYPE_LEVEL_LOW
+ IRQ_TYPE_EDGE_RISING
+ IRQ_TYPE_EDGE_FALLING
+
+Interrupt priority range: 0-255
+
 =============================
 intc node bindings definition
 =============================
@@ -26,15 +33,21 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: <3>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq_num IRQ_TYPE_XXX priority>")
 ---------
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <3>;
 		interrupt-controller;
 	};
+
+	device: device-example {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING 254>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

