Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2873C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4BD20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="b0jwaB9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFR18QMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCBE36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:29:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43321 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbfCBE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BFC0F22107;
        Fri,  1 Mar 2019 23:29:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iLEPvGgrt5WqP
        zIw2urRr/v4MmxlFfFvpU7UgAt2d8Q=; b=b0jwaB9m/EjN53tkICO/h2lN120sr
        lXFf0bC+/OHUH8wT6Uow6gujK+rgTNx4yNBaWEiLHpNjZPukRGi7gom6uI3RrOBs
        7ASdHwjg6zdzXwt0cPCCt65HNt9TIdltt1O7CBxb49Ch+7hqCfbuwZU2a5pyEzQh
        DFbcF7HMtlw+EsaUE6LiBkP4jZrpBcklG5ka+Ran3cY0VKO0OA+aNxqr8poT8zQO
        973lLWCzTrxDkbsVMn8pQmO1PPuhXFCwBcRYHi7XlXpHSunnRmWlQ2XJ6iFGLiTx
        3hvNLWLb5aTvurzU4u7yoxqltIQExkV+6zuLUnJIyJFTzp5kG+d8DKfog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=iLEPvGgrt5WqPzIw2urRr/v4MmxlFfFvpU7UgAt2d8Q=; b=rFR18QMM
        H95sSz+9TvR/XkJpzcOy0NGbbUwzNmhpVSRm80OoQQU9T5lf7/TxtxXneHOkdAFI
        NgAME5IlHFoe9siOh4W3hvjXW5ukjJbqfBrX/8s/bLGN8tmFQLcR4/SPqKHvjav0
        jDdf0f6Wl99nG2pXROXNCPPV1t+axQQwfvEZ13CBU8AUiNwi4KheGkGQ0esXGm5T
        LLrVtwIkVwpm45vPG5G+1nLzXL12MTBk2XEYQAmkkWNRx/owRny2WrAtQAMzQm+K
        cBlfZIjiw1OJIzhLYtL+3QljKL3mAizrGkGDZdC1xRkGt7axeoDU6/PMfgd38/HL
        r8xAiLu2TysmoA==
X-ME-Sender: <xms:wgZ6XBMnfqPHKx39ZKHDIbUGKztGG4nqvO4ScxaewCWEkOfPt_8xUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuffhomh
    grihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepjedtrddufeehrddugeekrddu
    hedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurd
    horhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wgZ6XGiVCabvda48TYYNg0mEaQzjhzITGLcoEk_u-cAOdKhmjZx0-w>
    <xmx:wgZ6XD7iTcFQJcI98znxDTXILs6dqH5Q2Qj9mi1UZgE6nWaUXwSlSw>
    <xmx:wgZ6XN29IaqzUmZ8cihfgH-08pX30qi66u-40R_Gl8bw8hk5reLAXg>
    <xmx:wgZ6XLrCxagbFbNRZU256kSVgEmZuPUvP6YouO9w5g97DLudMhbI1A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D491210328;
        Fri,  1 Mar 2019 23:29:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 03/15] dt-bindings: mailbox: Add a sunxi message box binding
Date:   Fri,  1 Mar 2019 22:29:39 -0600
Message-Id: <20190302042951.53671-4-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
SoCs. Add a device tree binding for it.

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
2.19.2

