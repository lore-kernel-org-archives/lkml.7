Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68668C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F62253E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbfGWIlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:41:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55784 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388556AbfGWIlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:41:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A55A3200275;
        Tue, 23 Jul 2019 10:41:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9669E200134;
        Tue, 23 Jul 2019 10:41:13 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D182C205DD;
        Tue, 23 Jul 2019 10:41:12 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     m.felsch@pengutronix.de, shawnguo@kernel.org
Cc:     mark.rutland@arm.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        anson.huang@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com, robh+dt@kernel.org,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 5/5] dt-bindings: dsp: fsl: Add DSP core binding support
Date:   Tue, 23 Jul 2019 11:41:04 +0300
Message-Id: <20190723084104.12639-6-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723084104.12639-1-daniel.baluta@nxp.com>
References: <20190723084104.12639-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the DSP device tree node.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
new file mode 100644
index 000000000000..d112486eda0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8 DSP core
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  Some boards from i.MX8 family contain a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-dsp
+
+  reg:
+    description: Should contain register location and length
+
+  clocks:
+    items:
+      - description: ipg clock
+      - description: ocram clock
+      - description: core clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ocram
+      - const: core
+
+  power-domains:
+    description:
+      List of phandle and PM domain specifier as documented in
+      Documentation/devicetree/bindings/power/power_domain.txt
+    maxItems: 4
+  mboxes:
+    description:
+      List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
+      (see mailbox/fsl,mu.txt)
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+  memory-region:
+    description:
+       phandle to a node describing reserved memory (System RAM memory)
+       used by DSP (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - mboxes
+  - mbox-names
+  - memory-region
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/clock/imx8-clock.h>
+    dsp@596e8000 {
+        compatbile = "fsl,imx8qxp-dsp";
+        reg = <0x596e8000 0x88000>;
+        clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
+                 <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+        clock-names = "ipg", "ocram", "core";
+        power-domains = <&pd IMX_SC_R_MU_13A>,
+                        <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_DSP>,
+                        <&pd IMX_SC_R_DSP_RAM>;
+        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+        mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
+    };
-- 
2.17.1

