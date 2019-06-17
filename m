Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66078C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2320861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560803084;
	bh=E8/JHJCTkTh2LOgMtTpO7UxOvJevez/Bt/h3d04rmok=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BftgtBMtNn4M+yEyaDFV1+U7Iyik2K2e+6zsGM/GdY22qhg4Cxr0ldvp3nRSMQdZ7
	 +SB8qqCjD20hCU+5Chwy0Qc8yT6sNn3sTke1crDG+uUFN18UEbAZ+lmjW8RYyjFTl7
	 y5JHGuN/l5URENWyIwO1X78lEYivob5xuNL5axH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfFQUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:24:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35922 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFQUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:24:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so7082670qkl.3;
        Mon, 17 Jun 2019 13:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yFGBWiYYs+LRkIy/wEHXx34ZrsVoCh+Sm8uDRzMJKA=;
        b=TOeWRd/oiVW3hkcYmJmRYFoHKp7KO8dIHOSJ9n6th96EEnyBEiON0X0rS6Z9pKqQlT
         mJeElW64yRqFa6R3CiLe/KXDcswstqYl3vLux1TJSIFVtK4nRfu/B6H7mQMK/cSDBjR2
         OBH4VZvpe6cw1tki6XbYnXPxVKtiT0J0xO4ZOiOBRU+KwACWbxKRLHKJp2MH3xKKBan0
         ehiGyvp6bdkGKRnGs+uGypNKwci9oYxsJ+SqYikg7qzEYe2iILBSbjgo4CruRvXvrtpN
         EsWTr8x2Uf57CMLivVHptnZc/S02pxoF8R83YC095r4Q22RiBkcukQ60SIiqKOiA5zce
         i/AQ==
X-Gm-Message-State: APjAAAVoXH4aClRv+6kUaDSX1FSxZ6uFuTYTvrzYMAj8DDyDJ1wa3nA3
        Ld5xDXwZ3ATj8XK939AucPA7SnM=
X-Google-Smtp-Source: APXvYqym4tiaaaEKC75gTYvTvLTaUbQ3HkBwng9/q1W7bDpnlzdEEMOfGQfJIlO/lDSdMeniGNyLzg==
X-Received: by 2002:a37:ef18:: with SMTP id j24mr89726609qkk.293.1560803080754;
        Mon, 17 Jun 2019 13:24:40 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.192])
        by smtp.googlemail.com with ESMTPSA id p31sm2084119qtk.55.2019.06.17.13.24.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:24:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] dt-bindings: arm: Convert PSCI binding to json-schema
Date:   Mon, 17 Jun 2019 14:22:38 -0600
Message-Id: <20190617202238.29042-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PSCI binding to use DT schema format.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that I didn't make cpu_suspend required for arm,psci as some 
platforms didn't have that and the spec isn't clear if optional or 
required. One board (artpec6-devboard.dts) also doesn't implement 
cpu_off.

There's also 1 board (mt8173-evb.dts) that claims 0.1, 0.2, and 1.0
compatibility. I guess that's valid, but not really clear in the binding
doc. If we want to just allow any combination of versions, the schema
for compatible could be simplified a bit.


 Documentation/arm64/booting.txt               |   2 +-
 .../devicetree/bindings/arm/arm-boards        |   2 +-
 .../devicetree/bindings/arm/idle-states.txt   |   2 +-
 .../devicetree/bindings/arm/psci.txt          | 111 ------------
 .../devicetree/bindings/arm/psci.yaml         | 163 ++++++++++++++++++
 .../translations/zh_CN/arm64/booting.txt      |   2 +-
 6 files changed, 167 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/psci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/psci.yaml

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index fbab7e21d116..1a87dee739db 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -257,7 +257,7 @@ following manner:
   processors") to bring CPUs into the kernel.
 
   The device tree should contain a 'psci' node, as described in
-  Documentation/devicetree/bindings/arm/psci.txt.
+  Documentation/devicetree/bindings/arm/psci.yaml.
 
 - Secondary CPU general-purpose register settings
   x0 = 0 (reserved for future use)
diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index abff8d834a6a..6758ece324b1 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -197,7 +197,7 @@ Required nodes:
 The description for the board must include:
    - a "psci" node describing the boot method used for the secondary CPUs.
      A detailed description of the bindings used for "psci" nodes is present
-     in the psci.txt file.
+     in the psci.yaml file.
    - a "cpus" node describing the available cores and their associated
      "enable-method"s. For more details see cpus.txt file.
 
diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 3bdbe675b9e6..326f29b270ad 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -691,7 +691,7 @@ cpus {
     Documentation/devicetree/bindings/arm/cpus.yaml
 
 [2] ARM Linux Kernel documentation - PSCI bindings
-    Documentation/devicetree/bindings/arm/psci.txt
+    Documentation/devicetree/bindings/arm/psci.yaml
 
 [3] ARM Server Base System Architecture (SBSA)
     http://infocenter.arm.com/help/index.jsp
diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
deleted file mode 100644
index a2c4f1d52492..000000000000
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-* Power State Coordination Interface (PSCI)
-
-Firmware implementing the PSCI functions described in ARM document number
-ARM DEN 0022A ("Power State Coordination Interface System Software on ARM
-processors") can be used by Linux to initiate various CPU-centric power
-operations.
-
-Issue A of the specification describes functions for CPU suspend, hotplug
-and migration of secure software.
-
-Functions are invoked by trapping to the privilege level of the PSCI
-firmware (specified as part of the binding below) and passing arguments
-in a manner similar to that specified by AAPCS:
-
-	 r0		=> 32-bit Function ID / return value
-	{r1 - r3}	=> Parameters
-
-Note that the immediate field of the trapping instruction must be set
-to #0.
-
-
-Main node required properties:
-
- - compatible    : should contain at least one of:
-
-     * "arm,psci"     : For implementations complying to PSCI versions prior
-			to 0.2.
-			For these cases function IDs must be provided.
-
-     * "arm,psci-0.2" : For implementations complying to PSCI 0.2.
-			Function IDs are not required and should be ignored by
-			an OS with PSCI 0.2 support, but are permitted to be
-			present for compatibility with existing software when
-			"arm,psci" is later in the compatible list.
-
-     * "arm,psci-1.0" : For implementations complying to PSCI 1.0.
-			PSCI 1.0 is backward compatible with PSCI 0.2 with
-			minor specification updates, as defined in the PSCI
-			specification[2].
-
- - method        : The method of calling the PSCI firmware. Permitted
-                   values are:
-
-                   "smc" : SMC #0, with the register assignments specified
-		           in this binding.
-
-                   "hvc" : HVC #0, with the register assignments specified
-		           in this binding.
-
-Main node optional properties:
-
- - cpu_suspend   : Function ID for CPU_SUSPEND operation
-
- - cpu_off       : Function ID for CPU_OFF operation
-
- - cpu_on        : Function ID for CPU_ON operation
-
- - migrate       : Function ID for MIGRATE operation
-
-Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
-state nodes, as per bindings in [1]) must specify the following properties:
-
-- arm,psci-suspend-param
-		Usage: Required for state nodes[1] if the corresponding
-                       idle-states node entry-method property is set
-                       to "psci".
-		Value type: <u32>
-		Definition: power_state parameter to pass to the PSCI
-			    suspend call.
-
-Example:
-
-Case 1: PSCI v0.1 only.
-
-	psci {
-		compatible	= "arm,psci";
-		method		= "smc";
-		cpu_suspend	= <0x95c10000>;
-		cpu_off		= <0x95c10001>;
-		cpu_on		= <0x95c10002>;
-		migrate		= <0x95c10003>;
-	};
-
-Case 2: PSCI v0.2 only
-
-	psci {
-		compatible	= "arm,psci-0.2";
-		method		= "smc";
-	};
-
-Case 3: PSCI v0.2 and PSCI v0.1.
-
-	A DTB may provide IDs for use by kernels without PSCI 0.2 support,
-	enabling firmware and hypervisors to support existing and new kernels.
-	These IDs will be ignored by kernels with PSCI 0.2 support, which will
-	use the standard PSCI 0.2 IDs exclusively.
-
-	psci {
-		compatible = "arm,psci-0.2", "arm,psci";
-		method = "hvc";
-
-		cpu_on = < arbitrary value >;
-		cpu_off = < arbitrary value >;
-
-		...
-	};
-
-[1] Kernel documentation - ARM idle states bindings
-    Documentation/devicetree/bindings/arm/idle-states.txt
-[2] Power State Coordination Interface (PSCI) specification
-    http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
new file mode 100644
index 000000000000..7abdf58b335e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/psci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power State Coordination Interface (PSCI)
+
+maintainers:
+  - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+
+description: |+
+  Firmware implementing the PSCI functions described in ARM document number
+  ARM DEN 0022A ("Power State Coordination Interface System Software on ARM
+  processors") can be used by Linux to initiate various CPU-centric power
+  operations.
+
+  Issue A of the specification describes functions for CPU suspend, hotplug
+  and migration of secure software.
+
+  Functions are invoked by trapping to the privilege level of the PSCI
+  firmware (specified as part of the binding below) and passing arguments
+  in a manner similar to that specified by AAPCS:
+
+     r0       => 32-bit Function ID / return value
+    {r1 - r3}	=> Parameters
+
+  Note that the immediate field of the trapping instruction must be set
+  to #0.
+
+  [2] Power State Coordination Interface (PSCI) specification
+    http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          For implementations complying to PSCI versions prior to 0.2.
+        const: arm,psci
+
+      - description:
+          For implementations complying to PSCI 0.2.
+        const: arm,psci-0.2
+
+      - description:
+          For implementations complying to PSCI 0.2.
+          Function IDs are not required and should be ignored by an OS with
+          PSCI 0.2 support, but are permitted to be present for compatibility
+          with existing software when "arm,psci" is later in the compatible
+          list.
+        items:
+          - const: arm,psci-0.2
+          - const: arm,psci
+
+      - description:
+          For implementations complying to PSCI 1.0.
+        const: arm,psci-1.0
+
+      - description:
+          For implementations complying to PSCI 1.0.
+          PSCI 1.0 is backward compatible with PSCI 0.2 with minor
+          specification updates, as defined in the PSCI specification[2].
+        items:
+          - const: arm,psci-1.0
+          - const: arm,psci-0.2
+
+  method:
+    description: The method of calling the PSCI firmware.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string-array
+      - enum:
+          # SMC #0, with the register assignments specified in this binding.
+          - smc
+          # HVC #0, with the register assignments specified in this binding.
+          - hvc
+
+  cpu_suspend:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Function ID for CPU_SUSPEND operation
+
+  cpu_off:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Function ID for CPU_OFF operation
+
+  cpu_on:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Function ID for CPU_ON operation
+
+  migrate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Function ID for MIGRATE operation
+
+  arm,psci-suspend-param:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      power_state parameter to pass to the PSCI suspend call.
+
+      Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie
+      idle state nodes with entry-method property is set to "psci", as per
+      bindings in [1]) must specify this property.
+
+      [1] Kernel documentation - ARM idle states bindings
+        Documentation/devicetree/bindings/arm/idle-states.txt
+
+
+required:
+  - compatible
+  - method
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,psci
+    then:
+      required:
+        - cpu_off
+        - cpu_on
+
+examples:
+  - |+
+
+    // Case 1: PSCI v0.1 only.
+
+    psci {
+      compatible      = "arm,psci";
+      method          = "smc";
+      cpu_suspend     = <0x95c10000>;
+      cpu_off         = <0x95c10001>;
+      cpu_on          = <0x95c10002>;
+      migrate         = <0x95c10003>;
+    };
+
+  - |+
+
+    // Case 2: PSCI v0.2 only
+
+    psci {
+      compatible      = "arm,psci-0.2";
+      method          = "smc";
+    };
+
+
+  - |+
+
+    // Case 3: PSCI v0.2 and PSCI v0.1.
+
+    /*
+     * A DTB may provide IDs for use by kernels without PSCI 0.2 support,
+     * enabling firmware and hypervisors to support existing and new kernels.
+     * These IDs will be ignored by kernels with PSCI 0.2 support, which will
+     * use the standard PSCI 0.2 IDs exclusively.
+     */
+
+    psci {
+      compatible = "arm,psci-0.2", "arm,psci";
+      method = "hvc";
+
+      cpu_on = <0x95c10002>;
+      cpu_off = <0x95c10001>;
+    };
+...
diff --git a/Documentation/translations/zh_CN/arm64/booting.txt b/Documentation/translations/zh_CN/arm64/booting.txt
index c1dd968c5ee9..c84f2accb173 100644
--- a/Documentation/translations/zh_CN/arm64/booting.txt
+++ b/Documentation/translations/zh_CN/arm64/booting.txt
@@ -236,7 +236,7 @@ AArch64 内核当前没有提供自解压代码，因此如果使用了压缩内
   *译者注: ARM DEN 0022A 已更新到 ARM DEN 0022C。
 
   设备树必须包含一个 ‘psci’ 节点，请参考以下文档：
-  Documentation/devicetree/bindings/arm/psci.txt
+  Documentation/devicetree/bindings/arm/psci.yaml
 
 
 - 辅助 CPU 通用寄存器设置
-- 
2.20.1

