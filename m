Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97718C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A11720815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561593769;
	bh=rlMfY/miz0FHysu/NgTzeQxcGvI5jqF3YuE8vW7HPgM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZXhuh1LOQIfcGmGlMFAEBkInTdmlS4EkV/OIfpD/6YxJ7v3baahGxHqXbQ6vqxoAN
	 k9ysaOOd4667mAoi1WGhPVTAALHcutnFXGcbUW2Djg22fFPADmuAGXi9Jgtd2AoxXp
	 617DxSET16axrm0ZiWNo3KXMUpZYYL/A+N2s+sto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF0ACr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:02:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40667 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF0ACr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:02:47 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so719830ioc.7;
        Wed, 26 Jun 2019 17:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09hyio1g1LxvqfA/yKUO9x7dtiok51AUIq6dc+7tdbY=;
        b=gT61/Adzz/wki1ZYeV/JxwCkNnnJZIPn8AbEOfdYJkt6U7nVQ3DU6QnnxarD30c7QH
         zWiTdbZGvg6uS9t7cwJqmNfDv2sviVkzBaGcArJ6XSJ4UxsoWcTTOuyHgqiC3ImTD8ji
         ybx5hgsCqRoV5khdigacgZzWgSV4splB3DvbeJL2tt7bn+YpBm5kGPhnlupigt7y4bCm
         4Bg6/4xcCy5z14t01fEkCXGb1EIkS9Ywbpl8PNWx6SjidstC2jD6GQIyyE9OgKEdg3F0
         zXnwmq2T3jhhT9L5aIQlVjGAzyCKiBmrRgxFLQnz5WZ+C1dyD1Z6bp2AmmxF/6OpiPgy
         7CwA==
X-Gm-Message-State: APjAAAUOAjXAREtlaT+adO26RuiX3bACmIJVTUHHvxRcNJNLPk7CzWfo
        /PeAP0/7EOb5QCjpohvAVsWSx/c=
X-Google-Smtp-Source: APXvYqyPle3u4b/yEniOEhTWn7clxbC02sOHt5efYiRt7UBGBiFPBRH0crTDM6LhSIPRzwujv1qvUw==
X-Received: by 2002:a6b:b987:: with SMTP id j129mr1181028iof.166.1561593765845;
        Wed, 26 Jun 2019 17:02:45 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.243])
        by smtp.googlemail.com with ESMTPSA id r5sm486520iom.42.2019.06.26.17.02.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 17:02:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] dt-bindings: arm: Limit cpus schema to only check Arm 'cpu' nodes
Date:   Wed, 26 Jun 2019 18:00:44 -0600
Message-Id: <20190627000044.12739-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching on the 'cpus' node was a bad choice because the schema is
incorrectly applied to non-Arm cpus nodes. As we now have a common cpus
schema which checks the general structure, it is also redundant to do so
in the Arm CPU schema.

The downside is one could conceivably mix different architecture's cpu
nodes or have typos in the compatible string. The latter problem pretty
much exists for every schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/cpus.yaml         | 500 ++++++++----------
 1 file changed, 231 insertions(+), 269 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 17ac2c642e68..b9c994593537 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -39,280 +39,242 @@ description: |+
   described below.
 
 properties:
-  $nodename:
-    const: cpus
-    description: Container of cpu nodes
-
-  '#address-cells':
-    enum: [1, 2]
+  reg:
+    maxItems: 1
     description: |
-      Definition depends on ARM architecture version and configuration:
+      Usage and definition depend on ARM architecture version and
+      configuration:
 
       On uniprocessor ARM architectures previous to v7
-        value must be 1, to enable a simple enumeration
-        scheme for processors that do not have a HW CPU
-        identification register.
-      On 32-bit ARM 11 MPcore, ARM v7 or later systems
-        value must be 1, that corresponds to CPUID/MPIDR
-        registers sizes.
-      On ARM v8 64-bit systems value should be set to 2,
-        that corresponds to the MPIDR_EL1 register size.
-        If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
-        in the system, #address-cells can be set to 1, since
-        MPIDR_EL1[63:32] bits are not used for CPUs
-        identification.
-
-  '#size-cells':
-    const: 0
-
-patternProperties:
-  '^cpu@[0-9a-f]+$':
-    type: object
-    properties:
-      device_type:
-        const: cpu
-
-      reg:
-        maxItems: 1
-        description: |
-          Usage and definition depend on ARM architecture version and
-          configuration:
-
-          On uniprocessor ARM architectures previous to v7
-          this property is required and must be set to 0.
-
-          On ARM 11 MPcore based systems this property is
-            required and matches the CPUID[11:0] register bits.
-
-            Bits [11:0] in the reg cell must be set to
-            bits [11:0] in CPU ID register.
-
-            All other bits in the reg cell must be set to 0.
-
-          On 32-bit ARM v7 or later systems this property is
-            required and matches the CPU MPIDR[23:0] register
-            bits.
-
-            Bits [23:0] in the reg cell must be set to
-            bits [23:0] in MPIDR.
-
-            All other bits in the reg cell must be set to 0.
-
-          On ARM v8 64-bit systems this property is required
-            and matches the MPIDR_EL1 register affinity bits.
-
-            * If cpus node's #address-cells property is set to 2
-
-              The first reg cell bits [7:0] must be set to
-              bits [39:32] of MPIDR_EL1.
-
-              The second reg cell bits [23:0] must be set to
-              bits [23:0] of MPIDR_EL1.
-
-            * If cpus node's #address-cells property is set to 1
-
-              The reg cell bits [23:0] must be set to bits [23:0]
-              of MPIDR_EL1.
-
-          All other bits in the reg cells must be set to 0.
-
-      compatible:
-        enum:
-              - arm,arm710t
-              - arm,arm720t
-              - arm,arm740t
-              - arm,arm7ej-s
-              - arm,arm7tdmi
-              - arm,arm7tdmi-s
-              - arm,arm9es
-              - arm,arm9ej-s
-              - arm,arm920t
-              - arm,arm922t
-              - arm,arm925
-              - arm,arm926e-s
-              - arm,arm926ej-s
-              - arm,arm940t
-              - arm,arm946e-s
-              - arm,arm966e-s
-              - arm,arm968e-s
-              - arm,arm9tdmi
-              - arm,arm1020e
-              - arm,arm1020t
-              - arm,arm1022e
-              - arm,arm1026ej-s
-              - arm,arm1136j-s
-              - arm,arm1136jf-s
-              - arm,arm1156t2-s
-              - arm,arm1156t2f-s
-              - arm,arm1176jzf
-              - arm,arm1176jz-s
-              - arm,arm1176jzf-s
-              - arm,arm11mpcore
-              - arm,armv8 # Only for s/w models
-              - arm,cortex-a5
-              - arm,cortex-a7
-              - arm,cortex-a8
-              - arm,cortex-a9
-              - arm,cortex-a12
-              - arm,cortex-a15
-              - arm,cortex-a17
-              - arm,cortex-a53
-              - arm,cortex-a57
-              - arm,cortex-a72
-              - arm,cortex-a73
-              - arm,cortex-m0
-              - arm,cortex-m0+
-              - arm,cortex-m1
-              - arm,cortex-m3
-              - arm,cortex-m4
-              - arm,cortex-r4
-              - arm,cortex-r5
-              - arm,cortex-r7
-              - brcm,brahma-b15
-              - brcm,brahma-b53
-              - brcm,vulcan
-              - cavium,thunder
-              - cavium,thunder2
-              - faraday,fa526
-              - intel,sa110
-              - intel,sa1100
-              - marvell,feroceon
-              - marvell,mohawk
-              - marvell,pj4a
-              - marvell,pj4b
-              - marvell,sheeva-v5
-              - marvell,sheeva-v7
-              - nvidia,tegra132-denver
-              - nvidia,tegra186-denver
-              - nvidia,tegra194-carmel
-              - qcom,krait
-              - qcom,kryo
-              - qcom,kryo385
-              - qcom,scorpion
-
-      enable-method:
-        allOf:
-          - $ref: '/schemas/types.yaml#/definitions/string'
-          - oneOf:
-            # On ARM v8 64-bit this property is required
-            - enum:
-                - psci
-                - spin-table
-            # On ARM 32-bit systems this property is optional
-            - enum:
-                - actions,s500-smp
-                - allwinner,sun6i-a31
-                - allwinner,sun8i-a23
-                - allwinner,sun9i-a80-smp
-                - allwinner,sun8i-a83t-smp
-                - amlogic,meson8-smp
-                - amlogic,meson8b-smp
-                - arm,realview-smp
-                - brcm,bcm11351-cpu-method
-                - brcm,bcm23550
-                - brcm,bcm2836-smp
-                - brcm,bcm63138
-                - brcm,bcm-nsp-smp
-                - brcm,brahma-b15
-                - marvell,armada-375-smp
-                - marvell,armada-380-smp
-                - marvell,armada-390-smp
-                - marvell,armada-xp-smp
-                - marvell,98dx3236-smp
-                - mediatek,mt6589-smp
-                - mediatek,mt81xx-tz-smp
-                - qcom,gcc-msm8660
-                - qcom,kpss-acc-v1
-                - qcom,kpss-acc-v2
-                - renesas,apmu
-                - renesas,r9a06g032-smp
-                - rockchip,rk3036-smp
-                - rockchip,rk3066-smp
-                - socionext,milbeaut-m10v-smp
-                - ste,dbx500-smp
-
-      cpu-release-addr:
-        $ref: '/schemas/types.yaml#/definitions/uint64'
-
-        description:
-          Required for systems that have an "enable-method"
-            property value of "spin-table".
-          On ARM v8 64-bit systems must be a two cell
-            property identifying a 64-bit zero-initialised
-            memory location.
-
-      cpu-idle-states:
-        $ref: '/schemas/types.yaml#/definitions/phandle-array'
-        description: |
-          List of phandles to idle state nodes supported
-          by this cpu (see ./idle-states.txt).
-
-      capacity-dmips-mhz:
-        $ref: '/schemas/types.yaml#/definitions/uint32'
-        description:
-          u32 value representing CPU capacity (see ./cpu-capacity.txt) in
-          DMIPS/MHz, relative to highest capacity-dmips-mhz
-          in the system.
-
-      dynamic-power-coefficient:
-        $ref: '/schemas/types.yaml#/definitions/uint32'
-        description:
-          A u32 value that represents the running time dynamic
-          power coefficient in units of uW/MHz/V^2. The
-          coefficient can either be calculated from power
-          measurements or derived by analysis.
-
-          The dynamic power consumption of the CPU  is
-          proportional to the square of the Voltage (V) and
-          the clock frequency (f). The coefficient is used to
-          calculate the dynamic power as below -
-
-          Pdyn = dynamic-power-coefficient * V^2 * f
-
-          where voltage is in V, frequency is in MHz.
-
-      qcom,saw:
-        $ref: '/schemas/types.yaml#/definitions/phandle'
-        description: |
-          Specifies the SAW* node associated with this CPU.
-
-          Required for systems that have an "enable-method" property
-          value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
-
-          * arm/msm/qcom,saw2.txt
-
-      qcom,acc:
-        $ref: '/schemas/types.yaml#/definitions/phandle'
-        description: |
-          Specifies the ACC* node associated with this CPU.
-
-          Required for systems that have an "enable-method" property
-          value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
-
-          * arm/msm/qcom,kpss-acc.txt
-
-      rockchip,pmu:
-        $ref: '/schemas/types.yaml#/definitions/phandle'
-        description: |
-          Specifies the syscon node controlling the cpu core power domains.
-
-          Optional for systems that have an "enable-method"
-          property value of "rockchip,rk3066-smp"
-          While optional, it is the preferred way to get access to
-          the cpu-core power-domains.
-
-    required:
-      - device_type
-      - reg
-      - compatible
-
-    dependencies:
-      cpu-release-addr: [enable-method]
-      rockchip,pmu: [enable-method]
+      this property is required and must be set to 0.
+
+      On ARM 11 MPcore based systems this property is
+        required and matches the CPUID[11:0] register bits.
+
+        Bits [11:0] in the reg cell must be set to
+        bits [11:0] in CPU ID register.
+
+        All other bits in the reg cell must be set to 0.
+
+      On 32-bit ARM v7 or later systems this property is
+        required and matches the CPU MPIDR[23:0] register
+        bits.
+
+        Bits [23:0] in the reg cell must be set to
+        bits [23:0] in MPIDR.
+
+        All other bits in the reg cell must be set to 0.
+
+      On ARM v8 64-bit systems this property is required
+        and matches the MPIDR_EL1 register affinity bits.
+
+        * If cpus node's #address-cells property is set to 2
+
+          The first reg cell bits [7:0] must be set to
+          bits [39:32] of MPIDR_EL1.
+
+          The second reg cell bits [23:0] must be set to
+          bits [23:0] of MPIDR_EL1.
+
+        * If cpus node's #address-cells property is set to 1
+
+          The reg cell bits [23:0] must be set to bits [23:0]
+          of MPIDR_EL1.
+
+      All other bits in the reg cells must be set to 0.
+
+  compatible:
+    enum:
+          - arm,arm710t
+          - arm,arm720t
+          - arm,arm740t
+          - arm,arm7ej-s
+          - arm,arm7tdmi
+          - arm,arm7tdmi-s
+          - arm,arm9es
+          - arm,arm9ej-s
+          - arm,arm920t
+          - arm,arm922t
+          - arm,arm925
+          - arm,arm926e-s
+          - arm,arm926ej-s
+          - arm,arm940t
+          - arm,arm946e-s
+          - arm,arm966e-s
+          - arm,arm968e-s
+          - arm,arm9tdmi
+          - arm,arm1020e
+          - arm,arm1020t
+          - arm,arm1022e
+          - arm,arm1026ej-s
+          - arm,arm1136j-s
+          - arm,arm1136jf-s
+          - arm,arm1156t2-s
+          - arm,arm1156t2f-s
+          - arm,arm1176jzf
+          - arm,arm1176jz-s
+          - arm,arm1176jzf-s
+          - arm,arm11mpcore
+          - arm,armv8 # Only for s/w models
+          - arm,cortex-a5
+          - arm,cortex-a7
+          - arm,cortex-a8
+          - arm,cortex-a9
+          - arm,cortex-a12
+          - arm,cortex-a15
+          - arm,cortex-a17
+          - arm,cortex-a53
+          - arm,cortex-a57
+          - arm,cortex-a72
+          - arm,cortex-a73
+          - arm,cortex-m0
+          - arm,cortex-m0+
+          - arm,cortex-m1
+          - arm,cortex-m3
+          - arm,cortex-m4
+          - arm,cortex-r4
+          - arm,cortex-r5
+          - arm,cortex-r7
+          - brcm,brahma-b15
+          - brcm,brahma-b53
+          - brcm,vulcan
+          - cavium,thunder
+          - cavium,thunder2
+          - faraday,fa526
+          - intel,sa110
+          - intel,sa1100
+          - marvell,feroceon
+          - marvell,mohawk
+          - marvell,pj4a
+          - marvell,pj4b
+          - marvell,sheeva-v5
+          - marvell,sheeva-v7
+          - nvidia,tegra132-denver
+          - nvidia,tegra186-denver
+          - nvidia,tegra194-carmel
+          - qcom,krait
+          - qcom,kryo
+          - qcom,kryo385
+          - qcom,scorpion
+
+  enable-method:
+    allOf:
+      - $ref: '/schemas/types.yaml#/definitions/string'
+      - oneOf:
+        # On ARM v8 64-bit this property is required
+        - enum:
+            - psci
+            - spin-table
+        # On ARM 32-bit systems this property is optional
+        - enum:
+            - actions,s500-smp
+            - allwinner,sun6i-a31
+            - allwinner,sun8i-a23
+            - allwinner,sun9i-a80-smp
+            - allwinner,sun8i-a83t-smp
+            - amlogic,meson8-smp
+            - amlogic,meson8b-smp
+            - arm,realview-smp
+            - brcm,bcm11351-cpu-method
+            - brcm,bcm23550
+            - brcm,bcm2836-smp
+            - brcm,bcm63138
+            - brcm,bcm-nsp-smp
+            - brcm,brahma-b15
+            - marvell,armada-375-smp
+            - marvell,armada-380-smp
+            - marvell,armada-390-smp
+            - marvell,armada-xp-smp
+            - marvell,98dx3236-smp
+            - mediatek,mt6589-smp
+            - mediatek,mt81xx-tz-smp
+            - qcom,gcc-msm8660
+            - qcom,kpss-acc-v1
+            - qcom,kpss-acc-v2
+            - renesas,apmu
+            - renesas,r9a06g032-smp
+            - rockchip,rk3036-smp
+            - rockchip,rk3066-smp
+            - socionext,milbeaut-m10v-smp
+            - ste,dbx500-smp
+
+  cpu-release-addr:
+    $ref: '/schemas/types.yaml#/definitions/uint64'
+
+    description:
+      Required for systems that have an "enable-method"
+        property value of "spin-table".
+      On ARM v8 64-bit systems must be a two cell
+        property identifying a 64-bit zero-initialised
+        memory location.
+
+  cpu-idle-states:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: |
+      List of phandles to idle state nodes supported
+      by this cpu (see ./idle-states.txt).
+
+  capacity-dmips-mhz:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      u32 value representing CPU capacity (see ./cpu-capacity.txt) in
+      DMIPS/MHz, relative to highest capacity-dmips-mhz
+      in the system.
+
+  dynamic-power-coefficient:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      A u32 value that represents the running time dynamic
+      power coefficient in units of uW/MHz/V^2. The
+      coefficient can either be calculated from power
+      measurements or derived by analysis.
+
+      The dynamic power consumption of the CPU  is
+      proportional to the square of the Voltage (V) and
+      the clock frequency (f). The coefficient is used to
+      calculate the dynamic power as below -
+
+      Pdyn = dynamic-power-coefficient * V^2 * f
+
+      where voltage is in V, frequency is in MHz.
+
+  qcom,saw:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the SAW* node associated with this CPU.
+
+      Required for systems that have an "enable-method" property
+      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+
+      * arm/msm/qcom,saw2.txt
+
+  qcom,acc:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the ACC* node associated with this CPU.
+
+      Required for systems that have an "enable-method" property
+      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
+
+      * arm/msm/qcom,kpss-acc.txt
+
+  rockchip,pmu:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the syscon node controlling the cpu core power domains.
+
+      Optional for systems that have an "enable-method"
+      property value of "rockchip,rk3066-smp"
+      While optional, it is the preferred way to get access to
+      the cpu-core power-domains.
 
 required:
-  - '#address-cells'
-  - '#size-cells'
+  - device_type
+  - reg
+  - compatible
+
+dependencies:
+  rockchip,pmu: [enable-method]
 
 examples:
   - |
-- 
2.20.1

