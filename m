Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696CAC48BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31706208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N0Hda5ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfF0Tz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:55:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23418 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Tz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561665326; x=1593201326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlrSFoZF245E1zwQ107bOTMAJdrUzCCLZvF7b0tZ2tg=;
  b=N0Hda5ra4elcbn2pJZuZkSrnqR5JtbwgMBzIh3rvQJkhgGnu+4e4HABp
   Qratd7CeUBbOFJd7XsHh9axioA0m4LV06jEFaaQlgK8inhKEZqAh1sYjD
   KFI9LNkp5uOa6wctWQlU7JSkdv9UZuky2qZgrpPviTQrUAP17ftpMjUaR
   emz/fvsQaxmmxkyGLNw2Q2TIayEeMpPPlsrZYVSaTAL13fQYCXWS+zkOJ
   L/s/MObBEXMQtT9jw22X0BGoJOgxYWaO62lKq+payOCcCJgBmT53dxTGi
   HVIeImqdQvgHVe6HYbdV8TbyQ36AfFWLBdpmxdPn04RTsXiQaETIh0LCb
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,424,1557158400"; 
   d="scan'208";a="112927438"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 03:55:25 +0800
IronPort-SDR: WOD0tLMJs0KObnYYbM2LIBY2qQUzBpvT5O5RSbrvFi12//3kTOYTQLGJFOobLS8LQmK4VeBCrX
 6XkHfd8q03V8uEr25mo3eDFGL1KYGxaZS2g3VLhBiW65WLxByMwO0iStOTJRCvZ/G5arNasLzG
 UOXzdHxTO0onDq2HB/da9HEyWSyokfeTA51DoyWc0K6mkBaAym+PiFYGT4xA6C3M28Feuwvh2v
 Ys89hvieb/aGVFIYaWaqOnqxg+RiMUQpD5JT/8AFxA53N5/OK5qZHTOvt4Sn22b2LwPvus9Wwg
 TPdwRBCwQOLhL+jfNoFXOIkv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Jun 2019 12:54:38 -0700
IronPort-SDR: Encw0cfMRmKYD40WsCAOzWfG88ljamOqxNwLPBcHEyJKbCQ2JWkak/e97AZfQc+iOnNzYIPPYT
 WTYvzdgfUQ19xEq4rAIpZwneHNe4EdXoGnDevaFx3fC6KVtpI0qY7QGt7eh5OZJR69y0jev9F4
 PPK1F0iUlu+Jl7D3B/Baj9SefpxoIkKk2YZZ/PNm1Ftm/8eXkaB5ueABJcvpQVoeOgLfOlAYp9
 LwAQTXxStsP89JhTBZ5ClqDzKb0/WH2BblrNx7rzkCDqL5AzLFvTQGrEfeaoaTKWTaZIY67Kqy
 8pc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 12:55:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 2/7] dt-binding: cpu-topology: Move cpu-map to a common binding.
Date:   Thu, 27 Jun 2019 12:52:57 -0700
Message-Id: <20190627195302.28300-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627195302.28300-1-atish.patra@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu-map binding can be used to described cpu topology for both
RISC-V & ARM. It makes more sense to move the binding to document
to a common place.

The relevant discussion can be found here.
https://lkml.org/lkml/2018/11/6/19

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../topology.txt => cpu/cpu-topology.txt}     | 84 +++++++++++++++----
 1 file changed, 68 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
similarity index 86%
rename from Documentation/devicetree/bindings/arm/topology.txt
rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
index 3b8febb46dad..99918189403c 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
@@ -1,12 +1,12 @@
 ===========================================
-ARM topology binding description
+CPU topology binding description
 ===========================================
 
 ===========================================
 1 - Introduction
 ===========================================
 
-In an ARM system, the hierarchy of CPUs is defined through three entities that
+In a SMP system, the hierarchy of CPUs is defined through three entities that
 are used to describe the layout of physical CPUs in the system:
 
 - socket
@@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
 - core
 - thread
 
-The cpu nodes (bindings defined in [1]) represent the devices that
-correspond to physical CPUs and are to be mapped to the hierarchy levels.
-
 The bottom hierarchy level sits at core or thread level depending on whether
 symmetric multi-threading (SMT) is supported or not.
 
@@ -25,33 +22,31 @@ threads existing in the system and map to the hierarchy level "thread" above.
 In systems where SMT is not supported "cpu" nodes represent all cores present
 in the system and map to the hierarchy level "core" above.
 
-ARM topology bindings allow one to associate cpu nodes with hierarchical groups
+CPU topology bindings allow one to associate cpu nodes with hierarchical groups
 corresponding to the system hierarchy; syntactically they are defined as device
 tree nodes.
 
-The remainder of this document provides the topology bindings for ARM, based
-on the Devicetree Specification, available from:
+Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
+used for any other architecture as well.
 
-https://www.devicetree.org/specifications/
+The cpu nodes, as per bindings defined in [4], represent the devices that
+correspond to physical CPUs and are to be mapped to the hierarchy levels.
 
-If not stated otherwise, whenever a reference to a cpu node phandle is made its
-value must point to a cpu node compliant with the cpu node bindings as
-documented in [1].
 A topology description containing phandles to cpu nodes that are not compliant
-with bindings standardized in [1] is therefore considered invalid.
+with bindings standardized in [4] is therefore considered invalid.
 
 ===========================================
 2 - cpu-map node
 ===========================================
 
-The ARM CPU topology is defined within the cpu-map node, which is a direct
+The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
 child of the cpus node and provides a container where the actual topology
 nodes are listed.
 
 - cpu-map node
 
-	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
-			  ARM uniprocessor systems do not require a topology
+	Usage: Optional - On SMP systems provide CPUs topology to the OS.
+			  Uniprocessor systems do not require a topology
 			  description and therefore should not define a
 			  cpu-map node.
 
@@ -494,8 +489,65 @@ cpus {
 	};
 };
 
+Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
+
+{
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "sifive,fu540g", "sifive,fu500";
+	model = "sifive,hifive-unleashed-a00";
+
+	...
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			socket0 {
+				cluster0 {
+					core0 {
+						cpu = <&CPU1>;
+					};
+					core1 {
+						cpu = <&CPU2>;
+					};
+					core2 {
+						cpu0 = <&CPU2>;
+					};
+					core3 {
+						cpu0 = <&CPU3>;
+					};
+				};
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "sifive,rocket0", "riscv";
+			reg = <0x1>;
+		}
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "sifive,rocket0", "riscv";
+			reg = <0x2>;
+		}
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "sifive,rocket0", "riscv";
+			reg = <0x3>;
+		}
+		CPU4: cpu@4 {
+			device_type = "cpu";
+			compatible = "sifive,rocket0", "riscv";
+			reg = <0x4>;
+		}
+	}
+};
 ===============================================================================
 [1] ARM Linux kernel documentation
     Documentation/devicetree/bindings/arm/cpus.yaml
 [2] Devicetree NUMA binding description
     Documentation/devicetree/bindings/numa.txt
+[3] RISC-V Linux kernel documentation
+    Documentation/devicetree/bindings/riscv/cpus.txt
+[4] https://www.devicetree.org/specifications/
-- 
2.21.0

