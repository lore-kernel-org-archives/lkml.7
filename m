Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E8C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1195520708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="gL9uuZzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKVX4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:56:41 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39321 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:56:41 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5BB3523CF6;
        Sat, 23 Nov 2019 00:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574466998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2wYKqowHZF70WSP1d52Q0JHjl6M9p6nOKp+WhorwInE=;
        b=gL9uuZzWxZDc/xSHj57mNJO4Z767FlRG9LKgWosSBtm23/8jPY57vcQo1tFsztVwmJL/3G
        +khMMww0K+XSKy643tnqhqCE5h8hetkv6TYEbJ9wSU9UFWOKacz6Wo9qfocr9qZ2xTskJQ
        udUjonqhridtPnM4RbKVQVmdZmVDa6o=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] dt-bindings: clock: document the fsl-sai driver
Date:   Sat, 23 Nov 2019 00:56:21 +0100
Message-Id: <20191122235622.8818-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 5BB3523CF6
X-Spamd-Result: default: False [6.40 / 15.00];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.661];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../bindings/clock/fsl,sai-clock.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
new file mode 100644
index 000000000000..7116c8bc24d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/fsl,sai-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SAI bitclock-as-a-clock binding
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  It is possible to use the BCLK pin of a SAI module as a generic clock
+  output. Some SoC are very constrained in their pin multiplexer
+  configuration. Eg. pins can only be changed groups. For example, on the
+  LS1028A SoC you can only enable SAIs in pairs. If you use only one SAI,
+  the second pins are wasted. Using this binding it is possible to use the
+  clock of the second SAI as a MCLK clock for an audio codec, for example.
+
+  This is a composite of a gated clock and a divider clock.
+
+properties:
+  compatible:
+    const: fsl,vf610-sai-clock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+examples:
+  - |
+    mclk: clock-mclk@f130080 {
+        compatible = "fsl,vf610-sai-clock";
+        reg = <0x0 0xf130080 0x0 0x80>;
+        #clock-cells = <0>;
+        clocks = <&parentclk>;
+    };
-- 
2.20.1

