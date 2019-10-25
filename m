Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1415CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C9F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yg3+cfho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJYRvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:51:43 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:45189 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfJYRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:51:42 -0400
Received: by mail-pg1-f181.google.com with SMTP id r1so1981115pgj.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h3QJdMfhJbfPOyUujEeH2uCMTYfYjj0kP8BVOZvY6vk=;
        b=yg3+cfhoMvzbNVLOYxlHpxK9zIstoIJ+vmFQRnolgRRIna9gktbKYtnBZ7RBVfRwKn
         hNHOI/2OChFg9xUnidYcX0AONc1idmHcSOFRAMx5zZgLAfR+omQFY5WcMVEQRO+8g1eP
         3uiUrvtY7t0ofUZUIevZNs/EuWWoRUXSp7eOaMHfGkS26igzuxLUnKHx7ArgeVNWWFTl
         5zepKRIYkT/HbMEWB/RIEzhUOX/IhjONMKVbB3KpOiAOs91pXkLpAwgNjikBQrkHRO7K
         C8awJpIDnRKpXJZNzDVCYoxv7jkI1DE0IzqQl0KVVx74h8VhH6pkLsqNvcVYfLSRzm/m
         /HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h3QJdMfhJbfPOyUujEeH2uCMTYfYjj0kP8BVOZvY6vk=;
        b=KTr1FUap6Gl3rTCZGWHAUjbHuNopfhg3rRWDgNWdCW4OdKThzyKoHyA0IyzF0lmxt4
         +8fsIsB8iRxl09iI8v3brwVkRZWejHSykpsJk3ZDZjtwzRIZNhBX6vbJEsd+EWeH4tzF
         XFYS3sfrBig7ALPIe3/2HRqIIl7tEELGP0oweBJfd92uqcO1rN9b5pEcXOqcajO4fhFA
         1IUdgeL3hCsQ1jSeJ1CDtAe+hYaBfxglYK7lyxUEkuk0oYdGJ5UtvQJdSWxHLkIS4F3z
         6wI+yrBitBOiCII+R4QJG8jDCND3oQQx+R8SVNpyCusE9SGs1HRVDWq2U0smKhQuL3+e
         Kzeg==
X-Gm-Message-State: APjAAAVMeG9vmVJAxLty6wpPNL5DlNIaD4ldcNd2oH1NmiRyF9Afkyte
        ce3y12GzYgY6MhhT2crRgiin
X-Google-Smtp-Source: APXvYqyoCaci5yjaMYOinOTAO7wfDp4OzDWRoNXvt7YtfSuacvKl3MyK2mJVfrQraK7kLO0cDLgpiw==
X-Received: by 2002:a65:4907:: with SMTP id p7mr5957791pgs.429.1572025901575;
        Fri, 25 Oct 2019 10:51:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7108:7f86:4131:5b00:9fc5:5eaa])
        by smtp.gmail.com with ESMTPSA id d14sm3916345pfh.36.2019.10.25.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:51:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
Date:   Fri, 25 Oct 2019 23:21:17 +0530
Message-Id: <20191025175118.13307-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025175118.13307-1-manivannan.sadhasivam@linaro.org>
References: <20191025175118.13307-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for IMX296 CMOS image sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/media/i2c/imx296.yaml | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.yaml b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
new file mode 100644
index 000000000000..646fe0236138
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx296.yaml
@@ -0,0 +1,98 @@
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
+    default: 37125000
+
+  vddo-supply:
+    description:
+      Definition of the regulator used as interface power supply.
+    maxItems: 1
+
+  vdda-supply:
+    description:
+      Definition of the regulator used as analog power supply.
+    maxItems: 1
+
+  vddd-supply:
+    description:
+      Definition of the regulator used as digital power supply.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+    maxItems: 1
+
+  # See ./video-interfaces.txt for details
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
-- 
2.17.1

