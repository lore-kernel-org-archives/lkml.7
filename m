Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DFC2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EA2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g82o5qI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLJAbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:31:31 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45771 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:31:30 -0500
Received: by mail-pg1-f182.google.com with SMTP id b9so7565641pgk.12;
        Mon, 09 Dec 2019 16:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjPlYsXto14p5C8VyRSUAcHDdeX9MtJK0hekckR4MXo=;
        b=g82o5qI7mDhodYDhxVUVWF29yNsIXatSkuuuG6dnNOlFU4Yx6F6L/CpNU++bVnI99t
         p3KFvDen0v+7zmqvLamKhgL4Mxb5ZwgqUEXnRri3QuqjKpDDFlE/5/rSppO9XXw/xlel
         +kWMFzxa1IoV09s3d9TPMn5+8hnjWqp3nGUNuyvApOPWCdjjxjWT4G7TapPXgedS3APa
         jTnXi8qSmdrirkpmuwRQXxJWy++btMmhc8+DDgFErq0hzHhXqGA+8K4hQJBFxrAF/Dg3
         7Ufuu62XhGBnKLscX67DsmHAxJmxcuwMAnuAhZHlh20u89cMRoI93vEhFAkJCJyQ5lDv
         BKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjPlYsXto14p5C8VyRSUAcHDdeX9MtJK0hekckR4MXo=;
        b=Y8TpLXxyT3hN24/tL/AC09X7d9v7sAGlbVl+mV8Sa1PZiqdfcuSHOBsS+6zy9KBxMP
         7JzrO9vBePH+wZqb3YwqKAimeysg8TXesZgZ6XvVKk2rF8ATLKgK4RNz87JrMiXaE9PD
         wEiJ2RSKBBV+kQ0smTNv7cy8tV4eHRV9s7bk5GFSHSzkLZa4439YuMndC4WVhyhZpIpS
         /udDB+vIEfcmzsZxZNmivw75Bzw2rZYT/zrVqBGWznj7+XE2xXHgrbO8sVRrh3URyujX
         pDinDffYL1QGQfwkOw7tokSotBG3egtFN+WQg/iem2cI/piv4LhCU86N+ywHkC48MC7h
         BuVQ==
X-Gm-Message-State: APjAAAW/vXJmEakMYZQN5m82sfe9q5QXNtm9xlHhfvuIbdBzkgsKICUQ
        lDUH4/TmDqMAcwo1NTmgcAE=
X-Google-Smtp-Source: APXvYqxgCVjiBlLvOzrXkYi4DsGr7KRIgKnrMDxsZRlwIJgkioFp0j4UvaQxzZH/Ss+gYPXkrL+6Fg==
X-Received: by 2002:a63:5243:: with SMTP id s3mr20771167pgl.449.1575937889690;
        Mon, 09 Dec 2019 16:31:29 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id 5sm468157pjc.29.2019.12.09.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 16:31:29 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCHv1 1/2] dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
Date:   Mon,  9 Dec 2019 18:31:24 -0600
Message-Id: <20191210003124.32376-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add YAML dt bindings for Maxim MAX3420 UDC controller.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/usb/maxim,max3420-udc.yaml       | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
new file mode 100644
index 000000000000..cf4eec8a618e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/maxim,max3420-udc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAXIM MAX3420/1 USB Peripheral Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description: |
+  The controller provices USB2.0 compliant FullSpeed peripheral
+  implementation over the  SPI interface.
+
+  Specifications about the part can be found at:
+    http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max3420-udc
+      - maxim,max3421-udc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: udc
+      - const: vbus
+
+  spi-max-frequency:
+    maximum: 26000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+      #include <dt-bindings/gpio/gpio.h>
+      #include <dt-bindings/interrupt-controller/irq.h>
+      spi0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            udc@0 {
+                  compatible = "maxim,max3420-udc";
+                  reg = <0>;
+                  interrupt-parent = <&gpio>;
+                  interrupts = <0 IRQ_TYPE_EDGE_FALLING>, <10 IRQ_TYPE_EDGE_BOTH>;
+                  interrupt-names = "udc", "vbus";
+                  spi-max-frequency = <12500000>;
+            };
+      };
-- 
2.20.1

