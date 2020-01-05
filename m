Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD9C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1062C20678
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt8o+iUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAEWzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:55:52 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36326 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:55:51 -0500
Received: by mail-pg1-f172.google.com with SMTP id k3so25992647pgc.3;
        Sun, 05 Jan 2020 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW2uboRnXvfhL7FVns0D8fckxqyy6VZHvjNPojQU+3g=;
        b=pt8o+iULt5aNLrFM0Q+RqLx0k89+ZHEM1hI4yfylYr9EzhMOfX8iBK8KOXAuiLpNa3
         o/Ot6Y/1iAhxF+beubVxJriC/O3vMYx13BazvRn+Kgz2FWd/ZytfCQjKUX520YqSE73G
         o2/G5pmSUf5lvNd1xX06gTDfV+Cs0Q2AOD8k+ZMKnYXUeLKbQ3RmzGOKI4WjXJQIeyQ1
         yOXs5/TdvUoQRCtxVTlnxkCi2ImH2o3381RPP7o6brkKW0wKl7AU7lorjx6OOsgflKrn
         7Bi9SslFv62FvbLZcqqBWDTaWt2TNJLl6KU6iUPmwy4h9ZazNcGz982IdiaGgxZsj5HH
         6adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW2uboRnXvfhL7FVns0D8fckxqyy6VZHvjNPojQU+3g=;
        b=fgm+5zsD0JcWYm9V9BFb0Z7x02KljQY0sBJTTds4ROp7Rk8PoCl5ut2sfzR2iOc/za
         aVxIuEmmhGxDFFfORJ/IqM0/ZnWcu2q0lzYDmupuN8CZVrQRJW+dix2j/nymNRaKUUoF
         m8LCmIaDqo+0W8706ZnEzfTKUdNHLS8mYBC5RY+rr9zjcEChWHnRheVjNvuzpZEw5pAz
         0B0B1FFjNqrN0PrC8RZj2EC5A+ANeJL3ggWvFzrtGooex7mju7J+3eUF5F1+7w/DRuxz
         oL2ilqQm/MEdlLfFUfhmDUIwIJ6ekbuuk3l1TsbPl2f7zap1CerKAsfIpcfNwgY/GQkT
         aZ7w==
X-Gm-Message-State: APjAAAVkQR25CWRTSnxvBGAolE4vqKtTpv+AZ1th/ZxHKqA0Hh0rzi4S
        748k78DcDhoK/mvi3q7QM4k=
X-Google-Smtp-Source: APXvYqzvW+HTOJr5b72nj9RJFcdIKg2L2CTqYXhIKDjg2rU5qr2L4NG/5Sdt604iaViDYA7gAQQQbw==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr104372619pfh.124.1578264951178;
        Sun, 05 Jan 2020 14:55:51 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id l186sm70564400pge.31.2020.01.05.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 14:55:50 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
Date:   Sun,  5 Jan 2020 16:55:47 -0600
Message-Id: <20200105225547.21672-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105225509.21590-1-jassisinghbrar@gmail.com>
References: <20200105225509.21590-1-jassisinghbrar@gmail.com>
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
 .../bindings/usb/maxim,max3420-udc.yaml       | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
new file mode 100644
index 000000000000..4241d38d5864
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+  implementation over the SPI interface.
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
+    items:
+      - description: usb irq from max3420
+      - description: vbus detection irq
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: udc
+      - const: vbus
+    minItems: 1
+    maxItems: 2
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
+additionalProperties: false
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

