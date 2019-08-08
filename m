Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7AAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763392173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mqW3TeB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404660AbfHHWWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:22:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33389 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbfHHWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:22:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so124954578otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=eS96mV6ducJS5h+iACNl+AvdrHOnsDHfqSig0ry4nFQ=;
        b=mqW3TeB+6HPnsUv6nkJeAjTeAtV2nKYBQGPQqDw0F30cwdgnsA4N6MWal7oMeaGZxY
         s0HmYCwADnnEg1XomUKNqGVLWxfiROIvozuWNEoOtDFLAx1VBh/f2kDgURg5n/Zz/enK
         2WC/O02+5pDIFu2M8naeWv/arRoKarrSqDrewAXq6Xsv4unSwaKVWmLtJ0SwtHQVgdU+
         FO+amaW/cJZ8EKXvZlEOQrA5ZTru0ABUSWJzFDRMe8mtFtxefmZ0MmD2OHU9nWq3hcqW
         dGqyZDiUy0CpBUbY29w+NtgDV1SF3QD3U/HbXFng5/WPL+fI2OFWsW8bEIbbkaOeVYQH
         oK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=eS96mV6ducJS5h+iACNl+AvdrHOnsDHfqSig0ry4nFQ=;
        b=az3XMPXM9faAcTnL30CiWPc3cmyJYnsd2X2ak+sH/mp82tFSssxYdcIIxCpBbtx1Ow
         H/aXNIwhhiZ3jhhDiYKe8F94EvTFIWHT5VRUtNfTmvDPTeFhwm1V0cRrAIi9lBnJ48RQ
         0NALPR5OYiY4J31HIxBZLS9G7i6hqGBOD4fF2boy1KtStZPbJ0TiHyzjqWRHU9JQSV8i
         SNxIsB87R2WcPNPRwLJF9Xb//PVDupbfH01yorbyU/hOsy+xMvkHPa4wMFWQNzGQQvvm
         XMgTXlvDZa5g39qorUTTxPjMYQNjwVXG1p2GKcD8QlDkzITT2sXQ6Ur+DWzFh1rbt2T/
         4HdQ==
X-Gm-Message-State: APjAAAU+30jqbuPFseGQAdu+mn3F1scsl3RRPLe1IKzLPFeT3W108n1R
        +dEXcAmP62BVnnSb/tPWd6ovjg==
X-Google-Smtp-Source: APXvYqw9Fj3WTqn5BsMbmHDqBC6jwokH42iENqYuTEz+CcsFMrOe5X3lwXB5WVEr+mFc7iv6Kx33qQ==
X-Received: by 2002:a02:ab99:: with SMTP id t25mr18777108jan.113.1565302919353;
        Thu, 08 Aug 2019 15:21:59 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id k3sm10702979ioq.18.2019.08.08.15.21.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:21:58 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:21:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: remove obsolete cpus.txt
Message-ID: <alpine.DEB.2.21.9999.1908081520100.6414@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the now-obsolete riscv/cpus.txt DT binding document, since we
are using YAML binding documentation instead.

While doing so, transfer the explanatory text about 'harts' (with some
edits) into the YAML file, at Rob's request.

Link: https://lore.kernel.org/linux-riscv/CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com/
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/riscv/cpus.txt        | 162 ------------------
 .../devicetree/bindings/riscv/cpus.yaml       |  12 ++
 2 files changed, 12 insertions(+), 162 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/cpus.txt

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
deleted file mode 100644
index adf7b7af5dc3..000000000000
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-===================
-RISC-V CPU Bindings
-===================
-
-The device tree allows to describe the layout of CPUs in a system through
-the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
-defining properties for every cpu.
-
-Bindings for CPU nodes follow the Devicetree Specification, available from:
-
-https://www.devicetree.org/specifications/
-
-with updates for 32-bit and 64-bit RISC-V systems provided in this document.
-
-===========
-Terminology
-===========
-
-This document uses some terminology common to the RISC-V community that is not
-widely used, the definitions of which are listed here:
-
-* hart: A hardware execution context, which contains all the state mandated by
-  the RISC-V ISA: a PC and some registers.  This terminology is designed to
-  disambiguate software's view of execution contexts from any particular
-  microarchitectural implementation strategy.  For example, my Intel laptop is
-  described as having one socket with two cores, each of which has two hyper
-  threads.  Therefore this system has four harts.
-
-=====================================
-cpus and cpu node bindings definition
-=====================================
-
-The RISC-V architecture, in accordance with the Devicetree Specification,
-requires the cpus and cpu nodes to be present and contain the properties
-described below.
-
-- cpus node
-
-        Description: Container of cpu nodes
-
-        The node name must be "cpus".
-
-        A cpus node must define the following properties:
-
-        - #address-cells
-                Usage: required
-                Value type: <u32>
-                Definition: must be set to 1
-        - #size-cells
-                Usage: required
-                Value type: <u32>
-                Definition: must be set to 0
-
-- cpu node
-
-        Description: Describes a hart context
-
-        PROPERTIES
-
-        - device_type
-                Usage: required
-                Value type: <string>
-                Definition: must be "cpu"
-        - reg
-                Usage: required
-                Value type: <u32>
-                Definition: The hart ID of this CPU node
-        - compatible:
-                Usage: required
-                Value type: <stringlist>
-                Definition: must contain "riscv", may contain one of
-                            "sifive,rocket0"
-        - mmu-type:
-                Usage: optional
-                Value type: <string>
-                Definition: Specifies the CPU's MMU type.  Possible values are
-                            "riscv,sv32"
-                            "riscv,sv39"
-                            "riscv,sv48"
-        - riscv,isa:
-                Usage: required
-                Value type: <string>
-                Definition: Contains the RISC-V ISA string of this hart.  These
-                            ISA strings are defined by the RISC-V ISA manual.
-
-Example: SiFive Freedom U540G Development Kit
----------------------------------------------
-
-This system contains two harts: a hart marked as disabled that's used for
-low-level system tasks and should be ignored by Linux, and a second hart that
-Linux is allowed to run on.
-
-        cpus {
-                #address-cells = <1>;
-                #size-cells = <0>;
-                timebase-frequency = <1000000>;
-                cpu@0 {
-                        clock-frequency = <1600000000>;
-                        compatible = "sifive,rocket0", "riscv";
-                        device_type = "cpu";
-                        i-cache-block-size = <64>;
-                        i-cache-sets = <128>;
-                        i-cache-size = <16384>;
-                        next-level-cache = <&L15 &L0>;
-                        reg = <0>;
-                        riscv,isa = "rv64imac";
-                        status = "disabled";
-                        L10: interrupt-controller {
-                                #interrupt-cells = <1>;
-                                compatible = "riscv,cpu-intc";
-                                interrupt-controller;
-                        };
-                };
-                cpu@1 {
-                        clock-frequency = <1600000000>;
-                        compatible = "sifive,rocket0", "riscv";
-                        d-cache-block-size = <64>;
-                        d-cache-sets = <64>;
-                        d-cache-size = <32768>;
-                        d-tlb-sets = <1>;
-                        d-tlb-size = <32>;
-                        device_type = "cpu";
-                        i-cache-block-size = <64>;
-                        i-cache-sets = <64>;
-                        i-cache-size = <32768>;
-                        i-tlb-sets = <1>;
-                        i-tlb-size = <32>;
-                        mmu-type = "riscv,sv39";
-                        next-level-cache = <&L15 &L0>;
-                        reg = <1>;
-                        riscv,isa = "rv64imafdc";
-                        status = "okay";
-                        tlb-split;
-                        L13: interrupt-controller {
-                                #interrupt-cells = <1>;
-                                compatible = "riscv,cpu-intc";
-                                interrupt-controller;
-                        };
-                };
-        };
-
-Example: Spike ISA Simulator with 1 Hart
-----------------------------------------
-
-This device tree matches the Spike ISA golden model as run with `spike -p1`.
-
-        cpus {
-                cpu@0 {
-                        device_type = "cpu";
-                        reg = <0x00000000>;
-                        status = "okay";
-                        compatible = "riscv";
-                        riscv,isa = "rv64imafdc";
-                        mmu-type = "riscv,sv48";
-                        clock-frequency = <0x3b9aca00>;
-                        interrupt-controller {
-                                #interrupt-cells = <0x00000001>;
-                                interrupt-controller;
-                                compatible = "riscv,cpu-intc";
-                        }
-                }
-        }
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c899111aa5e3..5963af8c0c11 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -10,6 +10,18 @@ maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@sifive.com>
 
+description: |
+  This document uses some terminology common to the RISC-V community
+  that is not widely used, the definitions of which are listed here:
+
+  hart: A hardware execution context, which contains all the state
+  mandated by the RISC-V ISA: a PC and some registers.  This
+  terminology is designed to disambiguate software's view of execution
+  contexts from any particular microarchitectural implementation
+  strategy.  For example, an Intel laptop containing one socket with
+  two cores, each of which has two hyperthreads, could be described as
+  having four harts.
+
 properties:
   compatible:
     items:
-- 
2.22.0

