Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F8DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE77208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hEtFsx3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfGaMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:14:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfGaMOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so44350057wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZCxLPCe1ACQErDUW8aWQ5KGtk3yR1/KdxyjnNrl959M=;
        b=hEtFsx3E+vxVxKVnkVJrIPQhq8u5k6R7R82zb8hMdxf9abXPdtLUh28KELgdxJxC7H
         fRk2y7UTqODUNIsjHz/e6c/DCcMZFDmYmRqcQer0vInc6NtYSx+JKe507QqSSmy+27sA
         si1yo3vz6FWgANa91bC16sQzkIS5vyEUgDzCdvaqR4tzTBvn61aSjX6IhW0cw61qZQPE
         NbnbApP+KE2tqktTZaEEwZ6VIEEC7DjdrKqhLyYtc/cUEbL48PcGFI70udjecD5SUYgU
         1DavhttVuzkByIzpTjIXy8Ot5Ginl8C4aNnpTVOXHvtAjoj3meueKbzIOTXOZxjIfDvF
         9LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZCxLPCe1ACQErDUW8aWQ5KGtk3yR1/KdxyjnNrl959M=;
        b=Yl11MKmZTHiCiChqJ0xzpYqhnP/uXqfNHDgVLXRlIln+AF0MNVJ9sj9QAWXU8NgjcE
         mJrq3bDbXz2XIkVPhdrwddoqWL299C8QI4/0GI7w4j3OMikiV0IXp7OIAD3DO9d3eJSL
         UBR61V4PlT9zzT2VBVkFbxLUrnoUqIMCPAnuQ+OggBqx8R4oYBjbvPLiWvQrgifd86Aq
         6G/Ss04eWpteZ+cjZQxA4gwrQ0Q8fEzyOVbi2WLlKGvWBilAk065RJYcmWrYbA+HZ8IW
         jrcxR2+qWKYXUBVoQP9BLLu7meYrib/+ORCci2dw/xbYevx5Xu3terKGjQJHt8sZC2gm
         2BMA==
X-Gm-Message-State: APjAAAW1AhR+FAsCYdiw7QgXGC4XQyk39XPUg7635capNGtgRhai87Ku
        cRTKeX91xwLoH0gRVjnnyQNvi1q8WtI=
X-Google-Smtp-Source: APXvYqyR0a3A3NknrNBLDCX+TNBWHtgAMABkJnJgH0JnXRb3PYf4C6vmioWW1jWll9xmx8tLdvDNwg==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr51394689wrm.117.1564575254371;
        Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:13 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Wed, 31 Jul 2019 14:14:04 +0200
Message-Id: <20190731121409.17285-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12 SoCs.
the G12A  and G12B SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..1e2fe84da13d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal Driver
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Amlogic Thermal driver
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12-cpu-thermal
+              - amlogic,g12-ddr-thermal
+          - enum:
+              - amlogic,g12-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  amlogic,ao-secure:
+    description: phandle to the ao-secure syscon
+    allOf:
+     - $ref: /schemas/types.yaml#/definitions/uint32
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - amlogic,ao-secure
+
+examples:
+  - |
+        cpu_temp: temperature-sensor@ff634800 {
+                compatible = "amlogic,g12-cpu-thermal",
+                             "amlogic,g12-thermal";
+                reg = <0x0 0xff634800 0x0 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                status = "okay";
+                #thermal-sensor-cells = <1>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
\ No newline at end of file
-- 
2.17.1

