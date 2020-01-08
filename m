Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39AAC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B420656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvW80tsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgAHUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgAHUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so4942996wrh.5;
        Wed, 08 Jan 2020 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HAVtrrvP7lMDn+z4yW5t1+0ZMAlAWmibvRDN72JzVdg=;
        b=fvW80tsxmitYEBvGtuh21m8wnBrE83VykidXd3KTI0rxQr60hgtOGRLWtAgjGRdeSO
         ZsRWTtQ02MuMnIsoiUmBaJpGUxV1cStx+zM1VnKo62bXNajzo4DGa5tyqaWhJlvyunGn
         PPcjQo11qmTC+Jjg8VnDzQpYw240eF2tRX7QhBqxq2X77Bvevr0h3cnpGnSLucGwGqu4
         NeZ8g8I5QTPHgNTGPznEcq4Vs++QwEPJ6yCN3ke8la8QHoifR+iUp+vPBM0TSQofpGIO
         +tf2wJ9uuEfsKuTLtLkXDn/e3Tl03vRVdSzJufN+Nhd+ctQwX2QSzffJWD8WE5rgcqhr
         U50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HAVtrrvP7lMDn+z4yW5t1+0ZMAlAWmibvRDN72JzVdg=;
        b=Q5jgevGZ0+88GfYPqNMYGiFrrFAPiwiB7ZTCn/Znl3QLMMnLZBZwIox3eUgE+vk4lW
         NW93wOBY4meXlpqZ7A+R5ZXMxnmxkMBRIk7UXMfDlvuMBisfzTOz0F6692VuUyzvBuqd
         RtcS0UyjM6UEcIZe0bZtglC/ze29xReQBtmKj+fFarCLyFY+FU6ZLc+nL/kKNv3GhYkJ
         Cds+ONET9g7KHZ+/kOcFdiSX8hgLPP5CPgS+351VV7EGRKQLEkZcdiByNXfFd1BZ6qIS
         3h7S5vqNP1ikVZwTvZNYFJrPA65ImZjiey5JZKBuzwEO8ci0lBmwbbBKzS3N8+xjbyoO
         +Tow==
X-Gm-Message-State: APjAAAXI0cI4eH5W7iU8kHGGGVxzqG+k86lQKvbYU4g7lfGCeW/9UOJm
        EBSr84p5jFMnbD6yOE9Srcc=
X-Google-Smtp-Source: APXvYqxULPp2fA/trb8q4KJWfPyDdsD0Vv2qlG337KA4yMv9O2EsWOqRDwrpvkD0urJEQL8otamhMQ==
X-Received: by 2002:a5d:6b47:: with SMTP id x7mr1025519wrw.277.1578516827246;
        Wed, 08 Jan 2020 12:53:47 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:46 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 01/10] dt-bindings: mtd: add rockchip nand controller bindings
Date:   Wed,  8 Jan 2020 21:53:29 +0100
Message-Id: <20200108205338.11369-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Rockchip NAND controller bindings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/mtd/rockchip,nandc.yaml    | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml

diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
new file mode 100644
index 000000000..573d1a580
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/rockchip,nandc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip NAND Controller Device Tree Bindings
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,nandc-v6
+      - rockchip,nandc-v9
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:
+        - const: hclk_nandc
+      - items:
+        - const: clk_nandc
+        - const: hclk_nandc
+
+patternProperties:
+  "^nand@[a-f0-9]+$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      nand-is-boot-medium: true
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    nandc: nand-controller@10500000 {
+      compatible = "rockchip,nandc-v6";
+      reg = <0x10500000 0x4000>;
+      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru HCLK_NANDC0>;
+      clock-names = "hclk_nandc";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+        nand-is-boot-medium;
+      };
+    };
+
+...
-- 
2.11.0

