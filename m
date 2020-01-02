Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB598C3276F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B421655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="VPYMi8j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgABXLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:11:23 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38067 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgABXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:11:21 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CA8A32305A;
        Fri,  3 Jan 2020 00:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578006679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gD3loi1g64DkOqy+1VuWtNan16h8aW/6todYi26lvk=;
        b=VPYMi8j0f74060+tgpQEXWVIcTuk3feOIBi1upg47xkHVBZQ4vL67iE3/JIf5uA2pe/eLU
        qwIH86QGfHxAbBbrg50WcCovbO4L1juxzaMSJ2f4tq0+nTHysWlHWSXmHN7fjmUxpnXgWT
        LvdBV9qJPE3Z0UlmMHd2vY+i7b31b9c=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: clock: document the fsl-sai driver
Date:   Fri,  3 Jan 2020 00:11:00 +0100
Message-Id: <20200102231101.11834-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102231101.11834-1-michael@walle.cc>
References: <20200102231101.11834-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: CA8A32305A
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.492];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since v2:
 - add Reviewed-by tag

changes since v1:
 - dual license gpl-2.0-only and bsd-2-clause
 - add "additionalProperties: false"
 - wrap example in soc {} node with correct #address-cells and #size-cells

 .../bindings/clock/fsl,sai-clock.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
new file mode 100644
index 000000000000..8fb2060ac47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mclk: clock-mclk@f130080 {
+            compatible = "fsl,vf610-sai-clock";
+            reg = <0x0 0xf130080 0x0 0x80>;
+            #clock-cells = <0>;
+            clocks = <&parentclk>;
+        };
+    };
-- 
2.20.1

