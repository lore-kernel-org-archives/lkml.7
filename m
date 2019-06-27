Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF44C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9C12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riEMScns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfF0IKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:10:15 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36110 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfF0IKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:10:15 -0400
Received: by mail-wr1-f51.google.com with SMTP id n4so1418067wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fGilPlWIf25tFrsEiuvABYPV+T03b8S0tBYhKwY/uM=;
        b=riEMScnsFQVwwigZbvaAmERqPEQqKxt7CNINXhpwAE6rUeTn9/Wa6rCYH1igJhxjZO
         c9Rc2js8Xpp8+AEkxy8mOh97rOuM5Hn0LgvWEbZINZJJGy0a4DwwAhxMdO26tIt/RADS
         6dsKOcwBVR52xtxVhC7EY72qge2YHXp0+QiAmxRiWYq4OkF/LszpUAY7TtfdvhNMzTnr
         pv9Yg1/j0E4joFGdL2VeVYS5unQQ/MuiOsqV/LYKmRKEYW617XM+mRaA70Rt6Gt5KX4E
         EaEwio2Gg4WYmmbSVVciYYKKH68nZe0AgLpMveXUR6s5+X9ykCrD+bm4BG0y1k8ZXtmx
         KerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fGilPlWIf25tFrsEiuvABYPV+T03b8S0tBYhKwY/uM=;
        b=nXAnc9PiROvHOYlJISb0fi7oZ9QgVWaCx+3zi/ufRwF+waGYdkHg+wOlt99mI3PD05
         3SzcZY2m/1t/jgKtnwZE1VWxr3TxVztoMe0Iwnr+vI51jyaD5ESRDePuD6LhVOJLnbJW
         5P2fJwEb7qpnFtvycG0uvS++cYGZlSMxjzTK5YRPWO3Kq0seS9f8nbO1VeqWRna20YuD
         /gGtpNLyW7GBVB/6B57k9XscXeWrxOJ2AhdvuiOGI/mC2ozV6VMHm6KCoOdlXtscTgdj
         Z0FAnuYFtKx4FJI29OVVCq6oWrlY9N/mXg1AueTfmrX0728I+41PJOMSHBjblMWKU+2g
         cIuw==
X-Gm-Message-State: APjAAAUWmx8wPArpfbZgs9HGT1dmPRAp6WlD3umjBODT1b+oPfiCbY14
        ap27ybAm2qarnzMzPn5YEZkWX0Lux+g=
X-Google-Smtp-Source: APXvYqxk+6LJdjpRV5+DGW0E5ZH1IpunVY92U8j25vYGttI6Bgwmc+huaQvZA6WlHZB4Vh/Cwhdw8Q==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr2012876wrp.277.1561623011842;
        Thu, 27 Jun 2019 01:10:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p4sm1584832wrx.97.2019.06.27.01.10.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 01:10:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh@kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: nvmem: Add YAML schemas for the generic NVMEM bindings
Date:   Thu, 27 Jun 2019 09:09:59 +0100
Message-Id: <20190627080959.4488-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The nvmem providers and consumers have a bunch of generic properties that
are needed in a device tree. Add a YAML schemas for those.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Hi Greg,

Sorry for the delay in sending this patch, as this was a licence
change It took bit more time than expected to get approval.

Can you please consider this for 5.3 as we already had other patch
in next which reference this yaml.

Thanks,
srini

 .../bindings/nvmem/nvmem-consumer.yaml        | 45 +++++++++
 .../devicetree/bindings/nvmem/nvmem.txt       | 81 +---------------
 .../devicetree/bindings/nvmem/nvmem.yaml      | 93 +++++++++++++++++++
 3 files changed, 139 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
new file mode 100644
index 000000000000..c48b74733b68
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM (Non Volatile Memory) Consumer Device Tree Bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+select: true
+
+properties:
+  nvmem:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandle to the nvmem providers.
+
+  nvmem-cells:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandle to the nvmem data cells.
+
+  nvmem-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      Names for the each nvmem provider.
+
+  nvmem-cell-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      Names for each nvmem-cells specified.
+
+dependencies:
+  nvmem-names: [ nvmem ]
+  nvmem-cell-names: [ nvmem-cells ]
+
+examples:
+  - |
+    tsens {
+        /* ... */
+        nvmem-cells = <&tsens_calibration>;
+        nvmem-cell-names = "calibration";
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
index fd06c09b822b..46a7ef485e24 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
@@ -1,80 +1 @@
-= NVMEM(Non Volatile Memory) Data Device Tree Bindings =
-
-This binding is intended to represent the location of hardware
-configuration data stored in NVMEMs like eeprom, efuses and so on.
-
-On a significant proportion of boards, the manufacturer has stored
-some data on NVMEM, for the OS to be able to retrieve these information
-and act upon it. Obviously, the OS has to know about where to retrieve
-these data from, and where they are stored on the storage device.
-
-This document is here to document this.
-
-= Data providers =
-Contains bindings specific to provider drivers and data cells as children
-of this node.
-
-Optional properties:
- read-only: Mark the provider as read only.
-
-= Data cells =
-These are the child nodes of the provider which contain data cell
-information like offset and size in nvmem provider.
-
-Required properties:
-reg:	specifies the offset in byte within the storage device.
-
-Optional properties:
-
-bits:	Is pair of bit location and number of bits, which specifies offset
-	in bit and number of bits within the address range specified by reg property.
-	Offset takes values from 0-7.
-
-For example:
-
-	/* Provider */
-	qfprom: qfprom@700000 {
-		...
-
-		/* Data cells */
-		tsens_calibration: calib@404 {
-			reg = <0x404 0x10>;
-		};
-
-		tsens_calibration_bckp: calib_bckp@504 {
-			reg = <0x504 0x11>;
-			bits = <6 128>
-		};
-
-		pvs_version: pvs-version@6 {
-			reg = <0x6 0x2>
-			bits = <7 2>
-		};
-
-		speed_bin: speed-bin@c{
-			reg = <0xc 0x1>;
-			bits = <2 3>;
-
-		};
-		...
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells/providers.
-
-Required-properties:
-nvmem-cells: list of phandle to the nvmem data cells.
-nvmem-cell-names: names for the each nvmem-cells specified. Required if
-	nvmem-cells is used.
-
-Optional-properties:
-nvmem	: list of phandles to nvmem providers.
-nvmem-names: names for the each nvmem provider. required if nvmem is used.
-
-For example:
-
-	tsens {
-		...
-		nvmem-cells = <&tsens_calibration>;
-		nvmem-cell-names = "calibration";
-	};
+This file has been moved to nvmem.yaml and nvmem-consumer.yaml.
diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
new file mode 100644
index 000000000000..0b6ec69c9384
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM (Non Volatile Memory) Device Tree Bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding is intended to represent the location of hardware
+  configuration data stored in NVMEMs like eeprom, efuses and so on.
+
+  On a significant proportion of boards, the manufacturer has stored
+  some data on NVMEM, for the OS to be able to retrieve these
+  information and act upon it. Obviously, the OS has to know about
+  where to retrieve these data from, and where they are stored on the
+  storage device.
+
+properties:
+  $nodename:
+    pattern: "^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  read-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Mark the provider as read only.
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Offset and size in bytes within the storage device.
+
+      bits:
+        maxItems: 1
+        items:
+          items:
+            - minimum: 0
+              maximum: 7
+              description:
+                Offset in bit within the address range specified by reg.
+            - minimum: 1
+              description:
+                Size in bit within the address range specified by reg.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+      qfprom: eeprom@700000 {
+          #address-cells = <1>;
+          #size-cells = <1>;
+
+          /* ... */
+
+          /* Data cells */
+          tsens_calibration: calib@404 {
+              reg = <0x404 0x10>;
+          };
+
+          tsens_calibration_bckp: calib_bckp@504 {
+              reg = <0x504 0x11>;
+              bits = <6 128>;
+          };
+
+          pvs_version: pvs-version@6 {
+              reg = <0x6 0x2>;
+              bits = <7 2>;
+          };
+
+          speed_bin: speed-bin@c{
+              reg = <0xc 0x1>;
+              bits = <2 3>;
+          };
+      };
+
+...
-- 
2.21.0

