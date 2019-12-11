Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7351C2D0C8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7335A2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZlMuCBpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfLKPuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:50:46 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46474 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbfLKPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576079437; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=eyHslJzjVa1ut29atCn8FHuMjuQZsdMV5FkGrDuakgI=;
        b=ZlMuCBpvsUIzRzP/io42tvAT+E9mKmAIajMDbtavzOClfCHRGLdx9kK95nlS7PLiRBt39g
        xcNPvErDQGRe4WZejsYe6YiJeg3d9pHm86dRc0hbqBASPxumHaY/ycKPhz5I2cpaFDPFKV
        oMfNne0EmtF17f8LxJjA3pgDINGV+co=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings: power/supply: Document generic USB charger
Date:   Wed, 11 Dec 2019 16:50:30 +0100
Message-Id: <20191211155032.167032-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about the devicetree bindings for the generic USB
charger.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Convert to YAML

 .../bindings/power/supply/usb-charger.yaml    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/usb-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/usb-charger.yaml b/Documentation/devicetree/bindings/power/supply/usb-charger.yaml
new file mode 100644
index 000000000000..dcd705df6e73
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/usb-charger.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/usb-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic USB charger driver bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+description: |
+  Devicetree bindings for a generic USB charger.
+
+  The node should be either a child of a USB node, or connect to the USB
+  node through the graph. The USB node must have the usb-role-switch property
+  set. The USB charger will report as online when the USB role is set to device,
+  and offline otherwise.
+
+properties:
+  compatible:
+    const: usb-charger
+
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |+
+    usb_charger: usb-charger {
+      compatible = "usb-charger";
+
+      port {
+        usb_charger_ep: endpoint {
+          remote-endpoint = <&usb_otg>;
+        };
+      };
+    };
-- 
2.24.0

