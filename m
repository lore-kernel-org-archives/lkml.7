Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0D5CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9CB2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCdwA8cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfJ3JuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:50:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfJ3JuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:50:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id d13so1232566pfq.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cftdRVtAP8UQA9RZHk0z4GAx0m9Po/cdw/g0rW6uNcc=;
        b=wCdwA8cDhGfP5x35MPbKU+N2lcODb5ADD1ZdosQ9P1AD9v+CY/1Ivk72MjrDwA9IcY
         4keYhmYK6mey0FY84tfA6G4xJut1d3DST6qfp+zzACfPIZ3SzM3BKY3kjgzbUwOy7eaq
         CJ+FwHlqPVo8hIBr2momd3M+it81ipB5kVvz6UjGKzCC8hrDDbmMRT1tUN/Ru5h/llLo
         c0LR6zTTogqUgQ7tX2V3O/xLHlbKFYSUvjhFJ7uX2jE9nX9lEoy5+3h3cEDJ7lkEIG/c
         xOuE0kqO66JULtB2d8/H7iLZD5Tvfgd097ckzS6uEf1zutX2SXXeHMfl5guq2EUm/eCb
         00UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cftdRVtAP8UQA9RZHk0z4GAx0m9Po/cdw/g0rW6uNcc=;
        b=n0t4FDxT/2iwbui9GCjBaEE3O2TIl1n9elIyNU3g9IalM2JqQht5zPliCdPL3MJo26
         EZLd+dgz0gLgVlnwI1biD/2MQ2zK9++HHIpwxYeuPPEswpfJpMcTYHCtiuciTU+nLf0A
         oROOnPHaLjpsiGMy7oKT0Qv308DA6SjGlngpVqKpUqv/JfnxmT2ol6oGNM2mYHR9T3My
         LxYwTutDljHrEL2rpmDVhV9MtKrDyUYLnM3BJFaoql1kDOdbXHx/UVweYz3+15yHknxF
         HdqQ6LVHdn+S3uIbM0tUL3y1ZIWI0WLQXWpUghnyhierMCOA0+wjyMv+dC07ClEel908
         oxaQ==
X-Gm-Message-State: APjAAAV9ly9WYGAe+5Nbw9nYa+KbfHt1VEpeqkocXztGBvOmReO7KhD5
        aHLBKif4R0mFzsHO0BA4lJz6
X-Google-Smtp-Source: APXvYqxc4nIJKggYP3YGCmdXDUVXHR+G1fS7IEc9x7gSziWCnoF0WyDLvXL7vMZlHVfbUF4IM9KpKQ==
X-Received: by 2002:a65:6203:: with SMTP id d3mr32446041pgv.272.1572429022561;
        Wed, 30 Oct 2019 02:50:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:618e:77d9:c9fa:423a:3851:8df4])
        by smtp.gmail.com with ESMTPSA id n23sm2301329pff.137.2019.10.30.02.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:50:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
Date:   Wed, 30 Oct 2019 15:19:01 +0530
Message-Id: <20191030094902.32582-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030094902.32582-1-manivannan.sadhasivam@linaro.org>
References: <20191030094902.32582-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for IMX296 CMOS image sensor. Let's also
add MAINTAINERS entry for the binding and driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/media/i2c/imx296.yaml | 94 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.yaml b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
new file mode 100644
index 000000000000..c04ec2203268
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/imx296.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX296 1/2.8-Inch CMOS Image Sensor
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |-
+  The Sony IMX296 is a 1/2.9-Inch active pixel type CMOS Solid-state image
+  sensor with square pixel array and 1.58 M effective pixels. This chip
+  features a global shutter with variable charge-integration time. It is
+  programmable through I2C and 4-wire interfaces. The sensor output is
+  available via CSI-2 serial data output (1 Lane).
+
+properties:
+  compatible:
+    const: sony,imx296
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      Input clock for the sensor.
+    items:
+      - const: mclk
+
+  clock-frequency:
+    description:
+      Frequency of the mclk clock in Hertz.
+
+  vddo-supply:
+    description:
+      Definition of the regulator used as interface power supply.
+
+  vdda-supply:
+    description:
+      Definition of the regulator used as analog power supply.
+
+  vddd-supply:
+    description:
+      Definition of the regulator used as digital power supply.
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+    maxItems: 1
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - vddo-supply
+  - vdda-supply
+  - vddd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    imx296: camera-sensor@1a {
+        compatible = "sony,imx296";
+        reg = <0x1a>;
+        reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&camera_rear_default>;
+        clocks = <&gcc 90>;
+        clock-names = "mclk";
+        clock-frequency = <37125000>;
+        vddo-supply = <&camera_vddo_1v8>;
+        vdda-supply = <&camera_vdda_3v3>;
+        vddd-supply = <&camera_vddd_1v2>;
+
+        port {
+            imx296_ep: endpoint {
+                remote-endpoint = <&csiphy0_ep>;
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..51194bb2c392 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15140,6 +15140,14 @@ S:	Maintained
 F:	drivers/media/i2c/imx274.c
 F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
 
+SONY IMX296 SENSOR DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/imx296.c
+F:	Documentation/devicetree/bindings/media/i2c/imx296.yaml
+
 SONY IMX319 SENSOR DRIVER
 M:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

