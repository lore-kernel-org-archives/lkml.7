Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249C0233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nkBdHU1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfIAHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 03:12:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36105 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfIAHMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 03:12:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so5192053plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vKTwNtpfVl/ofq1lszN6uNSXidoJKzu+EuY1m89tIBg=;
        b=nkBdHU1bLcqhB0Pu13xor/HRU8pRbyHtm401VWyDRE09OfgA47ny3+8CsXdIm62QgZ
         6sHuK8HnBmweVy81dP9vA2W6dmBiqC1Wb2mwfWlx3HwjwizUmBrxbTuqmLrYh5IQwUOg
         IeW4PL+tq0zAmAdoH6vgWAyB2sWk8xxbWIW1BwIQWmrP6XANhXQsPToLBlSxOdm11P/L
         TzcS/bG13nyF32qDIcsfaZk/QGb96vFzNz5+5Sno225zTqGNgLp80wKsvaWlFFr1wYY+
         xpoqw0Ig04OhxhMkl+ckQhegRFM6pm1FtEXAlVhDyqCnen3hY4gdIqwBMcg3kQMN082o
         tX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vKTwNtpfVl/ofq1lszN6uNSXidoJKzu+EuY1m89tIBg=;
        b=W6BIQyLlzB4hoKyAgEIQxtfB7v8dxRY45xGCslJbCNlqTrAgMmsfaz1DmwH3QDUgRn
         F2FVP8g3Unipq3V0vxPD5TJek5+SFzybiOBeSMOkciLG4vzB4wx3Y5Vpeez/cxmKYmAo
         0RbCu5u7YptzKOqwHWxLktzZFW5e4pQa8k9HhPKmtld3RryArgVYaK+BxH/52TpDL4lp
         rQXZVQ85ShtkpBgEv2fvjIUF4ud/CzOUnHm61X++tf3PUv4ebY6JL2uIZ+EAIwrKg7BH
         4ic2NiiX1n8Xjdbb6pDswXfeMvYplEsK9bCixHORLA9+gIw60noO6KxGvsLVu4/5HVDL
         L+Eg==
X-Gm-Message-State: APjAAAW8c1SD9wor1ZMUagZWZxwf2QxM23ppuDcXdmZyoglKFnNnOdeM
        5UFrQyzwy3weJShxBHDS02vpdA==
X-Google-Smtp-Source: APXvYqwQny1Nmrz/C5sgtbnJWlSSGimvrNW83Dy1il6BLDq9WjeTfmJnQVGgEdpz2lT6oF5Pw/kQ/g==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr25329995plb.59.1567321921847;
        Sun, 01 Sep 2019 00:12:01 -0700 (PDT)
Received: from localhost.localdomain ([103.81.243.14])
        by smtp.gmail.com with ESMTPSA id b185sm6968998pfg.14.2019.09.01.00.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Sep 2019 00:12:01 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
Date:   Sun,  1 Sep 2019 12:39:21 +0530
Message-Id: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the riscv,sifive-serial binding to DT schema using json-schema.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
 .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
deleted file mode 100644
index c86b1e5..0000000
--- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-SiFive asynchronous serial interface (UART)
-
-Required properties:
-
-- compatible: should be something similar to
-	      "sifive,<chip>-uart" for the UART as integrated
-	      on a particular chip, and "sifive,uart<version>" for the
-	      general UART IP block programming model.	Supported
-	      compatible strings as of the date of this writing are:
-	      "sifive,fu540-c000-uart" for the SiFive UART v0 as
-	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
-	      for the SiFive UART v0 IP block with no chip integration
-	      tweaks (if any)
-- reg: address and length of the register space
-- interrupts: Should contain the UART interrupt identifier
-- clocks: Should contain a clock identifier for the UART's parent clock
-
-
-UART HDL that corresponds to the IP block version numbers can be found
-here:
-
-https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
-
-
-Example:
-
-uart0: serial@10010000 {
-	compatible = "sifive,fu540-c000-uart", "sifive,uart0";
-	interrupt-parent = <&plic0>;
-	interrupts = <80>;
-	reg = <0x0 0x10010000 0x0 0x1000>;
-	clocks = <&prci PRCI_CLK_TLCLK>;
-};
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
new file mode 100644
index 0000000..56fa935
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive asynchronous serial interface (UART)
+
+maintainers:
+  - Pragnesh Patel <pragnesh.patel@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sifive,fu540-c000-uart
+      - sifive,uart0
+
+    description:
+      Should be something similar to "sifive,<chip>-uart"
+      for the UART as integrated on a particular chip,
+      and "sifive,uart<version>" for the general UART IP
+      block programming model.
+
+      UART HDL that corresponds to the IP block version
+      numbers can be found here -
+
+      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/clock/sifive-fu540-prci.h>
+      serial@10010000 {
+        compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+        interrupt-parent = <&plic0>;
+        interrupts = <80>;
+        reg = <0x0 0x10010000 0x0 0x1000>;
+        clocks = <&prci PRCI_CLK_TLCLK>;
+      };
+
+...
-- 
2.7.4

