Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10DC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015F2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfFNIPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:15:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58366 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFNIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 315DE2005CB;
        Fri, 14 Jun 2019 10:15:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2A0A2005D2;
        Fri, 14 Jun 2019 10:15:14 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CE3B4031E;
        Fri, 14 Jun 2019 16:15:06 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, shengjiu.wang@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, daniel.baluta@nxp.com,
        daniel.baluta@gmail.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, o.rempel@pengutronix.de
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add DSP IPC binding support
Date:   Fri, 14 Jun 2019 16:16:50 +0800
Message-Id: <20190614081650.11880-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614081650.11880-1-daniel.baluta@nxp.com>
References: <20190614081650.11880-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

DSP IPC is the layer that allows the Host CPU to communicate
with DSP firmware.
DSP is part of some i.MX8 boards (e.g i.MX8QM, i.MX8QXP)

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/arm/freescale/fsl,dsp.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
new file mode 100644
index 000000000000..16d9df1d397b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX IPC DSP driver
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  IPC communication layer between Host CPU and DSP on NXP i.MX8 platforms
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-dsp
+
+  mboxes:
+    description:
+      List of phandle of 2 MU channels for TXDB, 2 MU channels for RXDB
+      (see mailbox/fsl,mu.txt)
+    maxItems: 1
+
+  mbox-names
+    description:
+      Mailboxes names
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/string"
+      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+examples:
+  - |
+    dsp {
+      compatbile = "fsl,imx-dsp";
+      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+      mboxes = <&lsio_mu13 2 0 &lsio_mu13 2 1 &lsio_mu13 3 0 &lsio_mu13 3 1>;
+    };
-- 
2.17.1

