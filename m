Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E1EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9C022CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="mGR1KHmo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQ8BX9Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfHTDXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:16 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59901 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbfHTDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 278163537;
        Mon, 19 Aug 2019 23:23:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=P1jz8fwnKD8Xl
        fOMJ4PdvhOiV7IECdbznxXKaX9/fWU=; b=mGR1KHmoaEEXPl9SRVmwzqzhfZdml
        8u8rRVz+VjUSWlSZ/pu3yk/0619nby/yd5vBBi9JeOgbOByrkTEPqJI3uv1qPauO
        dUGKoZPLIH1m84HBxrFwacgsBnFTbMDyVPvtWhALzN0cNwmkWkm+Is89LSX7Mi4b
        eUBFWu81ZJrvIvsIwv7afr0/6lLVk7oMtl5xZeVevecTuFQzLCpzwlztLConDqQW
        TbacFZZ++JdrMxURTbzvnuTZdFwx5HpkNWX1dkwF1kUav0YjzIUqEJMdjesUWcoa
        wrRv+S3I75yJT1Z4FWBzp6PORqjoA9J0K+t3XMARjtef3KiaJ8GybzvZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=P1jz8fwnKD8XlfOMJ4PdvhOiV7IECdbznxXKaX9/fWU=; b=rQ8BX9Az
        O8fsmxG+UpVcJIpa5gs6ycOpj8WuD/6ZqAZAaST9Fz+50/jrqeBGaz5UPtSrAmU0
        fFOJYGMZjUtvvVtJucJ6qo2o/T+sKImq+/9KxWAxa3BEsV7lPjVN+oicuqLa+pQO
        5Ytgsj9/qMLL0VB6GA3laKyO2r/QXtyk1CIPdGRaJN2JpFtqMx4qg9Pyy1AO+TAu
        87ilh8PolUc1+NZ9IdpYTzU+zK3xqsYbBti3FN9l0Pa1sDmE9mtKeWy/sWvf9l60
        cgRRUSD0poNGMfX1OGVRrcdKNMb7+PQyGhx7qLIe5wJvpW12wCEURKnzUeqAZBMC
        0bM8xC8oBYluCA==
X-ME-Sender: <xms:oWdbXQ-9u-x9D4QAro_eyn5wyNW4kPTDwAQnuofx3kt1A9_DVuUtTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffoh
    hmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtddrudefhedrudegkedr
    udehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:oWdbXc_uw2T269062-4O0NmqjL2B3Yd2VdCBVESTNMo3JJHOXgpijw>
    <xmx:oWdbXRCVeVocSSgpmxTnmmCN9HmDPi2Lf7HTT80S1F_keYVeXerBDA>
    <xmx:oWdbXUzhbxvbG5QJdJdZEbKCqGZgrann4Q4yGpK6r9Epdhb_DZkvKQ>
    <xmx:omdbXRnCMDmdeeaBO9pyE27LdkClfTS9irKx_WIkBCsUfLKWoSVR3w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2BCD8005B;
        Mon, 19 Aug 2019 23:23:12 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/10] dt-bindings: mailbox: Add a sunxi message box binding
Date:   Mon, 19 Aug 2019 22:23:04 -0500
Message-Id: <20190820032311.6506-4-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
SoCs. Add a device tree binding for it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../mailbox/allwinner,sunxi-msgbox.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
new file mode 100644
index 000000000000..f34a1909ab2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/allwinner,sunxi-msgbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner sunxi Message Box
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description: |
+  The hardware message box on sun6i and newer sunxi SoCs is a two-user mailbox
+  controller containing 8 unidirectional FIFOs. An interrupt is raised for
+  received messages, but software must poll to know when a transmitted message
+  has been acknowledged by the remote user. Each FIFO can hold four 32-bit
+  messages; when a FIFO is full, clients must wait before more transmissions.
+
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun8i-a83t-msgbox
+              - allwinner,sun8i-h3-msgbox
+              - allwinner,sun9i-a80-msgbox
+              - allwinner,sun50i-a64-msgbox
+              - allwinner,sun50i-h6-msgbox
+          - const: allwinner,sun6i-a31-msgbox
+      - items:
+          - const: allwinner,sun6i-a31-msgbox
+
+  reg:
+    items:
+      - description: MMIO register range
+
+  clocks:
+    maxItems: 1
+    description: bus clock
+
+  resets:
+    maxItems: 1
+    description: bus reset
+
+  interrupts:
+    maxItems: 1
+    description: controller interrupt
+
+  '#mbox-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - '#mbox-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun8i-h3-ccu.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/sun8i-h3-ccu.h>
+
+    msgbox: mailbox@1c17000 {
+            compatible = "allwinner,sun8i-h3-msgbox",
+                         "allwinner,sun6i-a31-msgbox";
+            reg = <0x01c17000 0x1000>;
+            clocks = <&ccu CLK_BUS_MSGBOX>;
+            resets = <&ccu RST_BUS_MSGBOX>;
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+            #mbox-cells = <1>;
+    };
+
+...
-- 
2.21.0

