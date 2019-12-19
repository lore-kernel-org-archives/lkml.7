Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB55C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CE2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="M4v4rZdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT7qZQ9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLSJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:07:24 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41915 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfLSJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:07:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C40928FF;
        Thu, 19 Dec 2019 04:07:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 19 Dec 2019 04:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=XXdtMM7vLgAct
        /8ZdLZvRsgE1myTwo/2GhT2QNhyDlY=; b=M4v4rZdhWbr9cX1QUXXwJtgzhfuqF
        iOw0EdJcP3SUy1dLy0PbMKvhHoqP3FVCYy4S2TcfeqjNXVdMtDvEBmBhNA4CdbLj
        TQxe2GKHT11KSJvVT4KUOspCkJ5i9GWM7V84WsFYD8iIoxFTaAWU9iEWd0ei5q33
        4HJ+WamrcjHqTME/rYXL/02az3sAihWzM/sSJEkrcg09PVfLQ8bvWB5eEMi40XKo
        6zYTddqyl0FBNsibBW4lC5Wa7gJ4X8ENnLrgPdkWS+DUdyFJcm0xuT6LJ9iYaPl6
        Q0Q3Wsiy6JoovuE6g/ozG4nilUXKibhjWFf6zL1Djh21DEBCRRe4Vq1vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XXdtMM7vLgAct/8ZdLZvRsgE1myTwo/2GhT2QNhyDlY=; b=UT7qZQ9A
        on3BmBsuuTrx+dfNsmwH2v49p4btyDjmNNfLxPm3febbgL4uNIxUB8A4OKoqD8Ik
        kt6i0IEYc5IT9xPF5ySCArXMtqcGFR4SxKGwjMtOBHrj5OLLJUph84rnpiMhGM+J
        RtCMeLVa9H3T+5ehtZVK6n84h4ZKqsEAtOkbHDLJBiI9o19nUIXgjF05dM+1UYWC
        wY5Dvk6osYlyhg/aF1TmODdEaBo8LKqe4dyc/8awkmnX696+wdHlHdu4rO/rpxIm
        FFC+C1bocbaWg9CBhqdw2tm7JXUSctl6anwr0An6zEs01EpJmUZVXoPERCBnPeEy
        /gawBs3VpdlBaQ==
X-ME-Sender: <xms:xz37XbfEjvVwiX2QIrsKkAVXUDW4kKVhrE3yUrUZwp_yr1zJT4aZtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogevoh
    grshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghfggfg
    sedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhr
    ghenucfkphepledtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:xz37XTPy1qD09GxIkPJd_s3qySsbYvtFR17f4VaBX3bCZSTrfoJsDw>
    <xmx:xz37XdVIV9vEUTwkrCjnK8bXPTsnvQY1psz-XMD2KqdeKffEvL2Qew>
    <xmx:xz37XU3NzmsWuS7kFAia5W6kasP4sCi0POqlGXw-qBBB0U0GmZDD3A>
    <xmx:xz37XZ4Kt-zjvxfz5AgzJSSjtt02HrdIrtNvCFWbdQoqGd7Vzx3ahg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AAACF8005A;
        Thu, 19 Dec 2019 04:07:18 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     p.zabel@pengutronix.de, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, lee.jones@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 3/3] dt-bindings: resets: Convert Allwinner legacy resets to schemas
Date:   Thu, 19 Dec 2019 10:07:12 +0100
Message-Id: <20191219090712.947490-3-maxime@cerno.tech>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219090712.947490-1-maxime@cerno.tech>
References: <20191219090712.947490-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner SoCs have a legacy set of bindings (and a framework to
support it in Linux) for their reset controllers.

Now that we have the DT validation in place, let's split into separate file
and convert the device tree bindings for those resets to schemas, and mark
them all as deprecated.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../allwinner,sun6i-a31-clock-reset.yaml      | 68 +++++++++++++++++++
 .../reset/allwinner,sunxi-clock-reset.txt     | 21 ------
 2 files changed, 68 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml b/Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml
new file mode 100644
index 000000000000..001c0d2a8c1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/allwinner,sun6i-a31-clock-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 Peripheral Reset Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+deprecated: true
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - allwinner,sun6i-a31-ahb1-reset
+          - allwinner,sun6i-a31-clock-reset
+
+  # The PRCM on the A31 and A23 will have the reg property missing,
+  # since it's set at the upper level node, and will be validated by
+  # PRCM's schema. Make sure we only validate standalone nodes.
+  required:
+    - compatible
+    - reg
+
+properties:
+  "#reset-cells":
+    const: 1
+    description: >
+      This additional argument passed to that reset controller is the
+      offset of the bit controlling this particular reset line in the
+      register.
+
+  compatible:
+    enum:
+      - allwinner,sun6i-a31-ahb1-reset
+      - allwinner,sun6i-a31-clock-reset
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#reset-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ahb1_rst: reset@1c202c0 {
+        #reset-cells = <1>;
+        compatible = "allwinner,sun6i-a31-ahb1-reset";
+        reg = <0x01c202c0 0xc>;
+    };
+
+  - |
+    apbs_rst: reset@80014b0 {
+        #reset-cells = <1>;
+        compatible = "allwinner,sun6i-a31-clock-reset";
+        reg = <0x080014b0 0x4>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
deleted file mode 100644
index 4ca66c96fe97..000000000000
--- a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Allwinner sunxi Peripheral Reset Controller
-===========================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Required properties:
-- compatible: Should be one of the following:
-  "allwinner,sun6i-a31-ahb1-reset"
-  "allwinner,sun6i-a31-clock-reset"
-- reg: should be register base and length as documented in the
-  datasheet
-- #reset-cells: 1, see below
-
-example:
-
-ahb1_rst: reset@1c202c0 {
-	#reset-cells = <1>;
-	compatible = "allwinner,sun6i-a31-ahb1-reset";
-	reg = <0x01c202c0 0xc>;
-};
-- 
2.23.0

