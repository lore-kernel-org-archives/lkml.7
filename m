Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634DC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52518206DC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfKMRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:15:22 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfKMRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:18 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EBC47E0012;
        Wed, 13 Nov 2019 17:15:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 3/4] dt-bindings: mtd: Describe mtd-concat devices
Date:   Wed, 13 Nov 2019 18:15:04 +0100
Message-Id: <20191113171505.26128-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113171505.26128-1-miquel.raynal@bootlin.com>
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Frauendienst <kernel@nospam.obeliks.de>

The main use case to concatenate MTD devices is probably SPI-NOR
flashes where the number of address bits is limited to 24, which can
access a range of 16MiB. Board manufacturers might want to double the
SPI storage size by adding a second flash asserted thanks to a second
chip selects which enhances the addressing capabilities to 25 bits,
32MiB. Having two devices for twice the size is great but without more
glue, we cannot define partition boundaries spread across the two
devices. This is the gap mtd-concat intends to address.

There are two options to describe concatenated devices:
1/ One flash chip is described in the DT with two CS;
2/ Two flash chips are described in the DT with one CS each, a virtual
device is also created to describe the concatenation.

Solution 1/ presents at least 3 issues:
* The hardware description is abused;
* The concatenation only works for SPI devices (while it could be
  helpful for any MTD);
* It would require a lot of rework in the SPI core as most of the
  logic assumes there is and there always will be only one CS per
  chip.

Solution 2/ also has caveats:
* The virtual device has no hardware reality;
* Possible optimizations at the hardware level will be hard to enable
  efficiently (ie. a common direct mapping abstracted by a SPI
  memories oriented controller).

There is no easy and perfect answer to this need but it feels more
reasonable to address the problem with solution 2, with the
information/needs we have today.

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
[<miquel.raynal@bootlin.com>:
Wrote a commit message explaining what mtd-concat is.
Explained the implementation details.
Switched to yaml schema.]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/mtd-concat.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mtd-concat.yaml b/Documentation/devicetree/bindings/mtd/mtd-concat.yaml
new file mode 100644
index 000000000000..7341198575cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtd-concat.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mtd-concat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual MTD concatenation device bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    const: "mtd-concat"
+
+  devices:
+    minItems: 2
+    description: |
+      List of phandles to MTD nodes that should be concatenated (in
+      order).
+
+required:
+  - compatible
+  - devices
+
+examples:
+  - |
+    &spi {
+            flash0: flash@0 {
+	            reg = <0>;
+            };
+            flash1: flash@1 {
+	            reg = <1>;
+            };
+    };
+
+    flash {
+            compatible = "mtd-concat";
+            devices = <&flash0 &flash1>;
+
+            partitions {
+                    compatible = "fixed-partitions";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    partition@0 {
+                            label = "boot";
+                            reg = <0x0000000 0x0040000>;
+                            read-only;
+                    };
+                    partition@40000 {
+                            label = "firmware";
+                            reg = <0x0040000 0x1fc0000>;
+                    };
+            };
+    };
-- 
2.20.1

