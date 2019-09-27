Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553DEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF721841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kaYBd8rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfI0SoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:44:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33096 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfI0Sn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:43:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so9249445wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aeDGNakdvDCwTy0gCOMkwdHE4LANquitP3dscaSQqkM=;
        b=kaYBd8rH9bcXTFA4OPZMOwh+968cPJqFoj1MvvNeruj0/cWDGcsTCB+MHNAGiPdQHs
         6btlJ/k3MnKZr6f1FfeJA6aIdjjQz0kxPN1DljwbJmW1iXUUG9Tj2FhnbxuwcxvfZJch
         sKRCca2nV4FS3xxPw9gQ1v79iB0vUujfaodA0H0JbitwjodhDuxPteWzuheciFlZZHp+
         bq9PFerB2M4+7MsLNtfZuacAeaMNGZS1HN98HBErZA+y1Pc2IyqQoZ6JfR9t3nK5H+02
         c4fA+1j0rcQPvGNCOxxlxs0j2P+7PEiM1Bu83PooDzArubKpXFTubl+lE5Na9f2nBKgN
         HbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aeDGNakdvDCwTy0gCOMkwdHE4LANquitP3dscaSQqkM=;
        b=HwwFzABbEXW4+oWB6LJZNRRe8V9IVZ5P6AedCzOx4ULcd/9j+gwTjJ43TdV93KZFR+
         E4p3giOn0ZV8TnO5Yy01EHTNC32qJgkxL4X0cMKGuFHkKo149Rd5jgfZxcVfmrWoCFEK
         RRKNlt5c1HGbQPuhe9eOjM4KDwth2KV5mjn/9TpIcry71zKyKMP1VxAAntFAANKOLRBn
         ZenrkyVhFy17BlXiwxwPLLTbTjjeMoDabR5d2Sl4UPVdpKQwE9unEW1D5uDPvWU033VX
         Iwvyuk7hHaN8ioYquFj/x6mtvdobtpEA83WVmVv7X/UisIjOgBQZPhZ1F23WiDGj7bm5
         F3qA==
X-Gm-Message-State: APjAAAUuCv/HS27vn5YGBllBcVLRmIVKAPy9TTlDDhrrZkZQI2AGB3eW
        rzvzOzaU87WfaOvPVaFOQ24/MQ==
X-Google-Smtp-Source: APXvYqzipwsRnU6H56hrDhOIw0POLTGn5VRaLhCOHcCogfJsqaBk9g35PRYJtCTeEgddUX5Eu5Z1KA==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr8714597wmo.114.1569609836134;
        Fri, 27 Sep 2019 11:43:56 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:43:55 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 1/7] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Fri, 27 Sep 2019 20:43:46 +0200
Message-Id: <20190927184352.28759-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12A and G12B SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..f761681e4c0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Binding for Amlogic Thermal
+
+properties:
+  compatible:
+      items:
+        - enum:
+            - amlogic,g12a-cpu-thermal
+            - amlogic,g12a-ddr-thermal
+        - const: amlogic,g12a-thermal
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
+    $ref: '/schemas/types.yaml#/definitions/phandle'
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
+                compatible = "amlogic,g12a-cpu-thermal",
+                             "amlogic,g12a-thermal";
+                reg = <0xff634800 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                #thermal-sensor-cells = <0>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
-- 
2.17.1

