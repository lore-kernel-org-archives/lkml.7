Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D75C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE92089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E1yMmjSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbfIJHDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:03:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfIJHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:03:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so8128327plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x8676vaAMOMU0xS9ZBzOGK+O3nkLRs05V8sfia4T0io=;
        b=E1yMmjSYYd3SJOl+n5kBSPDt6WFLc78WrSf3sphfdotTh1RZBV7Wc2tjPZQ8px9Lig
         HIziAgXnNgmbIGwEZTBIwWFVvZyQHTmvuM5p5CxbaRm5SowE78u3iYJ/VsbfSugaN8jf
         NnlXJpbwcuB2cssMweuqo0+B1jpuvP2nzsTqzmKMtrl8C7M85iNm/k7zRCX4y7EdEqf3
         zFlfzHcT4mMotiXCMV6H4wM1ZqRLhS9zy8PV7yFjQZPpFgvdpOWnMx0T6R5N5kIMCVPa
         7F2JORo1xbDQps6U/RVRm7iIU80SWnXDaFWzFmmPz8v9wdKankZFOVw9XTCgudVlGMT4
         nClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8676vaAMOMU0xS9ZBzOGK+O3nkLRs05V8sfia4T0io=;
        b=WRfaUvEp8cCKB//6OEC+GnEfaUGPCLg58g+JG8wqAo3N9w1YVGKU93yni0xsFMXbc/
         ZdhJ6DDXdh3IF2bXEUsZ7rjCLxn8o9J3CirbxY1ldTkzX0jCtSYKIRpOYz5mIC/sE/sY
         TGLoh/yleDF8FT6rmBd05Zj2kJnZBYbQFlvyFTzWgNa1m+hmRYverY/bOGtMDQJloE3I
         AI47JLi6WAWZZLpNy7V33KUR8GdrueUQi/DMnzLR2mmp1yQgME5g8VevWibifBI+sdT5
         bvFQzgKYyP7zD/oNpbb3wxYB5svfhyYvhtu+bA8gVp+EzV1SrnbKyO9RON4UbXd+Cige
         Ji5A==
X-Gm-Message-State: APjAAAWzUJ9VwRJNVVcE8rv3wsfWmOI670BFWQ7o9JJUv2Fh4k/n6Tvl
        svYLnRr6r1Kzvk4xJBEHMPZPNw==
X-Google-Smtp-Source: APXvYqzf295XBYzMkJ2GP3vZ3dUOjLqYHN6ex68DBrUFlhgOofOjYtZwSxq9PB4LXBeat1GxDUDaAw==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr29467918plo.152.1568099017311;
        Tue, 10 Sep 2019 00:03:37 -0700 (PDT)
Received: from pragneshp.open-silicon.com ([114.143.65.226])
        by smtp.gmail.com with ESMTPSA id q30sm1387383pja.18.2019.09.10.00.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 00:03:36 -0700 (PDT)
From:   Pragnesh Patel <pragnesh.patel@sifive.com>
To:     palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Convert spi-sifive binding to json-schema
Date:   Tue, 10 Sep 2019 12:32:51 +0530
Message-Id: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the spi-sifive binding to DT schema format.

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
 .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
deleted file mode 100644
index 3f5c6e4..0000000
--- a/Documentation/devicetree/bindings/spi/spi-sifive.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-SiFive SPI controller Device Tree Bindings
-------------------------------------------
-
-Required properties:
-- compatible		: Should be "sifive,<chip>-spi" and "sifive,spi<version>".
-			  Supported compatible strings are:
-			  "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
-			  onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
-			  SPI v0 IP block with no chip integration tweaks.
-			  Please refer to sifive-blocks-ip-versioning.txt for details
-- reg			: Physical base address and size of SPI registers map
-			  A second (optional) range can indicate memory mapped flash
-- interrupts		: Must contain one entry
-- interrupt-parent	: Must be core interrupt controller
-- clocks		: Must reference the frequency given to the controller
-- #address-cells	: Must be '1', indicating which CS to use
-- #size-cells		: Must be '0'
-
-Optional properties:
-- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
-- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
-
-SPI RTL that corresponds to the IP block version numbers can be found here:
-https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
-
-Example:
-	spi: spi@10040000 {
-		compatible = "sifive,fu540-c000-spi", "sifive,spi0";
-		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
-		interrupt-parent = <&plic>;
-		interrupts = <51>;
-		clocks = <&tlclk>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sifive,fifo-depth = <8>;
-		sifive,max-bits-per-word = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
new file mode 100644
index 0000000..368f5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive SPI controller
+
+maintainers:
+  - Pragnesh Patel <pragnesh.patel@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-spi
+      - const: sifive,spi0
+
+    description:
+      Should be "sifive,<chip>-spi" and "sifive,spi<version>".
+      Supported compatible strings are -
+      "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
+      onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
+      SPI v0 IP block with no chip integration tweaks.
+      Please refer to sifive-blocks-ip-versioning.txt for details
+
+      SPI RTL that corresponds to the IP block version numbers can be found here -
+      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
+
+  reg:
+    maxItems: 1
+
+    description:
+      Physical base address and size of SPI registers map
+      A second (optional) range can indicate memory mapped flash
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+    description:
+      Must reference the frequency given to the controller
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  sifive,fifo-depth:
+    description:
+      Depth of hardware queues; defaults to 8
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  sifive,max-bits-per-word:
+    description:
+      Maximum bits per word; defaults to 8
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    spi: spi@10040000 {
+      compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+      reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+      interrupt-parent = <&plic>;
+      interrupts = <51>;
+      clocks = <&tlclk>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      sifive,fifo-depth = <8>;
+      sifive,max-bits-per-word = <8>;
+    };
+
+...
-- 
2.7.4

