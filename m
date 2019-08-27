Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF06C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD6C2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="W2u7El7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfH0I7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:59:52 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:59218 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfH0I7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:59:49 -0400
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 9C8734201AE6;
        Tue, 27 Aug 2019 11:54:35 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eh7vR3ekib-sYB0FNsC;
        Tue, 27 Aug 2019 11:54:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1566896075;
        bh=EFyS7rMeUv/1O17IZuGpXYP3C3ZKhieRADD/pMwZx/g=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=W2u7El7nNMhuqvl3ci41yQaAPFXFFeFne01qo4MDWr57EVVgeaDRNsLBIAbt2/kFe
         3ajWpfIcZ1GWjN7oCzNVAhAX3Bg+vlxh5HR1HXxgeiNzqf7bV8ys8uInLnZ3DRkP8q
         2fY+VFGJbryHqa7v4rC1BuNIJ5JIOrJtEJKXGQp8=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id JOqUfE8LDO-sStCc4I5;
        Tue, 27 Aug 2019 11:54:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 07/13] dt-bindings: interrupt-controller: Add Loongson-3 HTINTC
Date:   Tue, 27 Aug 2019 16:52:56 +0800
Message-Id: <20190827085302.5197-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Loongson-3 HyperTransport Interrupt controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../loongson,ls3-htintc.yaml                  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
new file mode 100644
index 000000000000..c1bc0faca656
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,ls3-htintc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson-3 HyperTransport Interrupt Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |
+  This interrupt controller is found in the Loongson-3 family of chips to transfer
+  interrupts from PCH connected on HyperTransport bus.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - loongson,ls3-htintc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+		htintc: interrupt-controller@0xEFDFB000080 {
+			compatible = "loongson,ls3-htintc";
+			reg = <0xEFD 0xFB000080 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&iointc>;
+			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+						<25 IRQ_TYPE_LEVEL_HIGH>,
+						<26 IRQ_TYPE_LEVEL_HIGH>,
+						<27 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.22.0

