Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A4C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A279D2467C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="MpdAbp6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kceOdyq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLOEZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:00 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60597 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfLOEY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:24:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 140D85A7A;
        Sat, 14 Dec 2019 23:24:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=JjsSHv7y+xoC9
        wzCPjhtQRaN9GgsGgC2WECk087F2qk=; b=MpdAbp6oqXAMC/ICQ2LIy9FhX10LT
        stCeOkYbnHUzid3iDKZBU5XJgaBWxguNem1ZGqi3Jpxd9iXlKpwI3RuGRm6do5h8
        MIO6bWiyBMz0H8jm0opl9Lwc/lG0tljYBGvUhexeyNYYn/oe2W3GUoqL3jclS2NW
        tqt9+7PkHyFRcQbWC7L8FistNaC6S6qMOXs6K1wEtFwEvLPCkIeaXzuqUTvaUt4v
        mujkZJquV34U2YQhq3QahRxINcT03aibiYpUfPjrfA56I6rdsb1v51b3cAluKwvD
        p4oKQ1+hDHMO3sv/LzIyFQASsyCumDEXgOP+1BaPEygzia9oJQDm4jOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JjsSHv7y+xoC9wzCPjhtQRaN9GgsGgC2WECk087F2qk=; b=kceOdyq1
        H6uAiE4SFfBvu8sMeVhzzcsPHmLeBJhIhh16hMeE9IUcJelL1cSFzPNmW2gpaI/I
        EZuh16ERwPCQizWSiqNL9caCe9srNNNccLt+ubCH1z28oR7oRgSt6v9NWs1QRK9/
        rl83K/nB7ZRJt5z0G+4oVfQHZWnUb+tNhm/FA9hXLYfdfpwxYFi72AGV4OfKZtXZ
        zu+uqsf9rZkhEeZvTB+SUfBxxmTpMHpknl4gire75K9r2zx/FZTDBP6P7nt/7Tc2
        Q0RecB2o4Wj4Vi7a0/kHuL5z9tcrzi2yE4GCMc7y511q1n1crkfSmCC2eT1wYlCa
        CfrNtUd7cozaOw==
X-ME-Sender: <xms:mrX1XdkBphMUTKsDbZK4p1Uw2V_Fl3F5ie8ld692zVxrSVyxiSr2Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffoh
    hmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtddrudefhedrudegkedr
    udehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mrX1XQHJQn3YAI8-oHleirrxRX0Ark_cku1EQ53vDhhL1N8ScNR_dQ>
    <xmx:mrX1XYX6-VYZ_edwWIj6yfkEgHEt4njFVTTzOuYMY9n5F2MxN_w5vQ>
    <xmx:mrX1XaQIe5GhWZSvzXut_7k1s7frshEPgAeCjo2lSsYqgpGAxkx-cQ>
    <xmx:m7X1Xc8ql89hyosemHSgtJ_lN2Ha5yHEAkOpxKBXpOvf9pE9RkFuiA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2777F80062;
        Sat, 14 Dec 2019 23:24:58 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 2/8] dt-bindings: mailbox: Add a sun6i message box binding
Date:   Sat, 14 Dec 2019 22:24:49 -0600
Message-Id: <20191215042455.51001-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
sun50i SoCs. Add a device tree binding for it. As it has only been
tested on the A83T, A64, H3/H5, and H6 SoCs, only those compatibles are
included.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
new file mode 100644
index 000000000000..dd746e07acfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/allwinner,sun6i-a31-msgbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner sunxi Message Box
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description: |
+  The hardware message box on sun6i, sun8i, sun9i, and sun50i SoCs is a
+  two-user mailbox controller containing 8 unidirectional FIFOs. An interrupt
+  is raised for received messages, but software must poll to know when a
+  transmitted message has been acknowledged by the remote user. Each FIFO can
+  hold four 32-bit messages; when a FIFO is full, clients must wait before
+  attempting more transmissions.
+
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - allwinner,sun8i-a83t-msgbox
+          - allwinner,sun8i-h3-msgbox
+          - allwinner,sun50i-a64-msgbox
+          - allwinner,sun50i-h6-msgbox
+      - const: allwinner,sun6i-a31-msgbox
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
+additionalProperties: false
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
2.23.0

