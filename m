Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50586C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F92480C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559646352;
	bh=SaCo5XTxFSdoSTx0adxdVSEm12HbPMedDe8u08eNtC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DdN/TxrZuhfuIwZimg/jTdxKvdEfbwjUGZbrV7jE2dhnP1AbiL294UbVZxL3bgVFf
	 DWdT42CO5axQmdn/nvIJ8KL6ew1UV+1APLQrHWOPGGRiI5Pi4saY+k58cjMRnQQuWP
	 MOSgzY+aZ/gQczWC+te7NWfoqeF5sFYRAnSq6mfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfFDLFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfFDLFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:05:50 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CF624805;
        Tue,  4 Jun 2019 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559646349;
        bh=SaCo5XTxFSdoSTx0adxdVSEm12HbPMedDe8u08eNtC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5fNMgk9izxyfM9pVkUnu2hvkISfTmsnkY5CdEBtScmj9rgCk3Tgag1/KlsYtzg/4
         uq0NAcr9XcMpK1ZHh0s0Mtx/h55hX4JYQzpNtA0sVnwTIagv+9ASf/xMqxU3Iib+LP
         4tk78fHhNDG9Kl6SOmC3cgVoonyWJGvhNrXL1DxE=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 2/4] dt-bindings: interrupt-controller: Update csky mpintc
Date:   Tue,  4 Jun 2019 19:05:04 +0800
Message-Id: <1559646306-18860-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559646306-18860-1-git-send-email-guoren@kernel.org>
References: <1559646306-18860-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add trigger type setting for csky,mpintc. The driver also could
support #interrupt-cells <1> and it wouldn't invalidate existing
DTs. Here we only show the complete format.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt    | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1..e134053 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -6,11 +6,16 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
 SMP soc, and it also could be used in non-SMP system.
 
 Interrupt number definition:
-
   0-15  : software irq, and we use 15 as our IPI_IRQ.
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode: (Defined in dt-bindings/interrupt-controller/irq.h)
+ IRQ_TYPE_LEVEL_HIGH (default)
+ IRQ_TYPE_LEVEL_LOW
+ IRQ_TYPE_EDGE_RISING
+ IRQ_TYPE_EDGE_FALLING
+
 =============================
 intc node bindings definition
 =============================
@@ -26,15 +31,22 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: <2>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq_num IRQ_TYPE_XXX>")
 ---------
+#include <dt-bindings/interrupt-controller/irq.h>
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		interrupt-controller;
 	};
+
+	device: device-example {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

