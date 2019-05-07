Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED28C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D220989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEGKyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfEGKy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 611711A25;
        Tue,  7 May 2019 03:54:26 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E5393F5AF;
        Tue,  7 May 2019 03:54:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [TEST PATCH 31/30][EDK2] edk2-platform: juno: Update ACPI CoreSight Bindings
Date:   Tue,  7 May 2019 11:52:58 +0100
Message-Id: <1557226378-10131-32-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI bindings for CoreSight components on the Juno-r0 board.
Please note that the bindings apply only for the juno-r0.
The layout on r1 and r2 are slightly different and will need
dynamic ACPI table support to be able to use a single UEFI
image.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl | 241 +++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl b/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl
index 702b057..c70e8ac 100644
--- a/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl
+++ b/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl
@@ -14,6 +14,51 @@
 
 #include "ArmPlatform.h"
 
+#define ACPI_GRAPH_REV		0
+#define ACPI_GRAPH_UUID		"ab02a46b-74c7-45a2-bd68-f7d344ef2153"
+
+#define CORESIGHT_GRAPH_UUID	"3ecbc8b6-1d0e-4fb3-8107-e627f805c6cd"
+
+#define CS_LINK_MASTER		1
+#define CS_LINK_SLAVE		0
+
+
+#define DSD_CS_GRAPH_BEGIN(_nports)			\
+        Package () {					\
+          1,		// GraphID			\
+          ToUUID(CORESIGHT_GRAPH_UUID),			\
+          _nports,
+
+#define DSD_CS_GRAPH_END				\
+	}
+
+#define DSD_GRAPH_BEGIN(_nports)			\
+     ToUUID(ACPI_GRAPH_UUID),				\
+     Package() {					\
+       ACPI_GRAPH_REV,					\
+       1,						\
+       DSD_CS_GRAPH_BEGIN(_nports)
+
+#define DSD_GRAPH_END					\
+       DSD_CS_GRAPH_END					\
+     }
+
+#define DSD_PORTS_BEGIN(_nports)			\
+   Name (_DSD,  Package () {				\
+     DSD_GRAPH_BEGIN(_nports)
+
+#define DSD_PORTS_END					\
+   DSD_GRAPH_END					\
+  })
+
+#define CS_PORT(_port, _rport, _rphandle, _dir)		\
+    Package () { _port, _rport, _rphandle, _dir}
+
+#define CS_INPUT_PORT(_port, _rport, _rphandle)		\
+    CS_PORT(_port, _rport, _rphandle, CS_LINK_SLAVE)
+#define CS_OUTPUT_PORT(_port, _rport, _rphandle)		\
+    CS_PORT(_port, _rport, _rphandle, CS_LINK_MASTER)
+
 DefinitionBlock("DsdtTable.aml", "DSDT", 1, "ARMLTD", "ARM-JUNO", EFI_ACPI_ARM_OEM_REVISION) {
   Scope(_SB) {
     //
@@ -122,15 +167,56 @@ DefinitionBlock("DsdtTable.aml", "DSDT", 1, "ARMLTD", "ARM-JUNO", EFI_ACPI_ARM_O
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+
+        Device(ETM0) { // ETM on Cluster0 CPU0
+          Name (_HID, "ARMHC500")
+          Name (_CID, "ARMHC500")
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x22040000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 0, \_SB_.CLU0.FUN0)
+          DSD_PORTS_END
+
+        } // ETM0
       }
+
       Device(CPU1) { // A57-1: Cluster 0, Cpu 1
         Name(_HID, "ACPI0007")
         Name(_UID, 5)
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+        Device(ETM1) { // ETM on Cluster0 CPU1
+          Name (_HID, "ARMHC500")
+          Name (_CID, "ARMHC500")
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x22140000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 1, \_SB_.CLU0.FUN0)
+          DSD_PORTS_END
+
+        } // ETM1
       }
+
+      Device(FUN0) {
+        Name(_HID, "ARMHC9FF")
+        Name(_CID, "ARMHC9FF")
+        Name(_CRS, ResourceTemplate() {
+          Memory32Fixed(ReadWrite, 0x220c0000, 0x1000)
+        })
+
+        DSD_PORTS_BEGIN(3)
+        CS_OUTPUT_PORT(0, 0, \_SB_.MFUN),
+        CS_INPUT_PORT(0, 0, \_SB_.CLU0.CPU0.ETM0),
+        CS_INPUT_PORT(1, 0, \_SB_.CLU0.CPU1.ETM1)
+        DSD_PORTS_END
+      } // CL0.FUN0
     }
+
     Device (CLU1) { // Cluster1 state
       Name(_HID, "ACPI0010")
       Name(_UID, 2)
@@ -208,19 +294,45 @@ DefinitionBlock("DsdtTable.aml", "DSDT", 1, "ARMLTD", "ARM-JUNO", EFI_ACPI_ARM_O
           "CorePwrDn"
         },
       })
+
       Device(CPU2) { // A53-0: Cluster 1, Cpu 0
         Name(_HID, "ACPI0007")
         Name(_UID, 0)
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+        Device(ETM2) { // ETM on Cluster1, CPU0
+          Name (_HID, "ARMHC500")
+          Name (_CID, "ARMHC500")
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x23040000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 0, \_SB_.CLU1.FUN1)
+          DSD_PORTS_END
+
+        } // ETM2
       }
+
       Device(CPU3) { // A53-1: Cluster 1, Cpu 1
         Name(_HID, "ACPI0007")
         Name(_UID, 1)
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+        Device(ETM3) { // ETM on Cluster1, CPU1
+          Name (_HID, "ARMHC500")
+          Name (_CID, "ARMHC500")
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x23140000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 1, \_SB_.CLU1.FUN1)
+          DSD_PORTS_END
+
+        } // ETM3
       }
       Device(CPU4) { // A53-2: Cluster 1, Cpu 2
         Name(_HID, "ACPI0007")
@@ -228,6 +340,18 @@ DefinitionBlock("DsdtTable.aml", "DSDT", 1, "ARMLTD", "ARM-JUNO", EFI_ACPI_ARM_O
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+        Device(ETM4) { // ETM on Cluster1, CPU2
+          Name (_HID, "ARMHC500")	// ETM
+          Name (_CID, "ARMHC500")	// ETM
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x23240000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 2, \_SB_.CLU1.FUN1)
+          DSD_PORTS_END
+
+        } // ETM4
       }
       Device(CPU5) { // A53-3: Cluster 1, Cpu 3
         Name(_HID, "ACPI0007")
@@ -235,9 +359,126 @@ DefinitionBlock("DsdtTable.aml", "DSDT", 1, "ARMLTD", "ARM-JUNO", EFI_ACPI_ARM_O
         Method (_LPI, 0, NotSerialized) {
           return(PLPI)
         }
+        Device(ETM5) { // ETM on Cluster1, CPU3
+          Name (_HID, "ARMHC500")	// ETM
+          Name (_CID, "ARMHC500")	// ETM
+          Name (_CRS, ResourceTemplate() {
+            Memory32Fixed(ReadWrite, 0x23340000, 0x1000)
+          })
+
+          DSD_PORTS_BEGIN(1)
+          CS_OUTPUT_PORT(0, 3, \_SB_.CLU1.FUN1)
+          DSD_PORTS_END
+        } // ETM5
       }
+      Device(FUN1) {
+        Name(_HID, "ARMHC9FF")
+        Name(_CID, "ARMHC9FF")
+        Name(_CRS, ResourceTemplate() {
+          Memory32Fixed(ReadWrite, 0x230c0000, 0x1000)
+        })
+
+        DSD_PORTS_BEGIN(5)
+        CS_OUTPUT_PORT(0, 1, \_SB_.MFUN),
+        CS_INPUT_PORT(0, 0, \_SB_.CLU1.CPU2.ETM2),
+        CS_INPUT_PORT(1, 0, \_SB_.CLU1.CPU3.ETM3),
+        CS_INPUT_PORT(2, 0, \_SB_.CLU1.CPU4.ETM4),
+        CS_INPUT_PORT(3, 0, \_SB_.CLU1.CPU5.ETM5)
+        DSD_PORTS_END
+      } // CL1.FUN1
     }
 
+    Device(STM0) {
+      Name(_HID, "ARMHC502")	// STM
+      Name(_CID, "ARMHC502")
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20100000, 0x1000)
+        Memory32Fixed(ReadWrite, 0x28000000, 0x1000000)
+      })
+      DSD_PORTS_BEGIN(1)
+      CS_OUTPUT_PORT(0, 2, \_SB_.MFUN)
+      DSD_PORTS_END
+    }
+
+    Device(MFUN) {
+      Name(_HID, "ARMHC9FF")	// Funnel
+      Name(_CID, "ARMHC9FF")	// Funnel
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20040000, 0x1000)
+      })
+
+      DSD_PORTS_BEGIN(4)
+      CS_OUTPUT_PORT(0, 0, \_SB_.ETF0),
+      CS_INPUT_PORT(0, 0, \_SB_.CLU0.FUN0),
+      CS_INPUT_PORT(1, 0, \_SB_.CLU1.FUN1),
+      CS_INPUT_PORT(2, 0, \_SB_.STM0)
+      DSD_PORTS_END
+
+    } // MFUN-nel
+
+    Device(ETF0) {
+      Name(_HID, "ARMHC97C")	// TMC
+      Name(_CID, "ARMHC97C")	// TMC
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20010000, 0x1000)
+      })
+
+      DSD_PORTS_BEGIN(2)
+      CS_OUTPUT_PORT(0, 1, \_SB_.RPL),
+      CS_INPUT_PORT(0, 0, \_SB_.MFUN)
+      DSD_PORTS_END
+
+    } // ETF0
+
+    Device(RPL) {
+      Name(_HID, "ARMHC98D")	// Replicator
+      Name(_CID, "ARMHC98D")	// Replicator
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20120000, 0x1000)
+      })
+
+      DSD_PORTS_BEGIN(3)
+      CS_OUTPUT_PORT(0, 0, \_SB_.TPIU),
+      CS_OUTPUT_PORT(1, 0, \_SB_.ETR),
+      CS_INPUT_PORT(0, 0, \_SB_.ETF0)
+      DSD_PORTS_END
+
+    } // RPL
+
+    Device(ETR) {
+      Name(_HID, "ARMHC97C")	// TMC
+      Name(_CID, "ARMHC97C")	// TMC
+      Name(_CCA, 0) // The ETR on this platform is not coherent
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20070000, 0x1000)
+      })
+
+      Name(_DSD, Package() {
+         DSD_GRAPH_BEGIN(1)
+         CS_INPUT_PORT(0, 1, \_SB_.RPL)
+         DSD_GRAPH_END,
+
+         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+         Package() {
+            Package(2) {"arm,scatter-gather", 1}
+         }
+      })
+
+    } // ETR
+
+    Device(TPIU) {
+      Name(_HID, "ARMHC979")	// TPIU
+      Name(_CID, "ARMHC979")	// TPIU
+      Name(_CRS, ResourceTemplate() {
+        Memory32Fixed(ReadWrite, 0x20030000, 0x1000)
+      })
+
+      DSD_PORTS_BEGIN(1)
+      CS_INPUT_PORT(0, 0, \_SB_.RPL)
+      DSD_PORTS_END
+
+    } // TPIU
+
     //
     // Keyboard and Mouse
     //
-- 
2.7.4

