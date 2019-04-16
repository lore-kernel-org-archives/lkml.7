Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2CE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383438;
	bh=Gslzi4w9ZZupNNjsR2UPWOwSgWDltL/GnrVY8TjBV9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVl1MUnxV8N4UJczw0IWkR+b+oHNBu3uHeXHkQoArjJBYBL5a+CLOaMrhkhMVBjTZ
	 zYiOE4UxGT/OFbpJlJLddR8OHPGCW+BMud2M/34h5/ZyHh9xh2UIEIvJwjXpvY4ZrY
	 bw43LGHyA3nij8bOxX8zVhdbcWjiRbjTY9dbZH8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfDPC5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:57:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfDPC4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CNTC8pVWt0vVqLlNE6vb61PuRfrJ8oJayzFsJMmAkhI=; b=Xfc0t8kFSwJ14Hdr+oIjnb7nzJ
        203DxXbwAkt/pF4Y8dEtwABaGZI8Gl/PNqWCJCLjrihEQ20SRK4+8XdJJzHkmHS6+o6aAapxbUIXt
        2VFzsKB7LxLPEhn5vvoNX+3D9ZSJe8X91rAQaDc3WWNn2q4WAsyBobGMk2R1vcqL8M7B5mxP7ZYlI
        ztNJYactRj5J06JHO+6J5Nxqx9s5pruqomAB+YvE0A116hKtkEL00Pa6JpQwjTvtAvAGohMper4pu
        Cy4NV8FH9DO9d8zdZMMnbUrZv5VSNHIAoj0cgGfhs8K2I3tXmHE9VXxcADOWk7dq/YaRBujYHyh0/
        WqL/gb2w==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGw-0007ap-4M; Tue, 16 Apr 2019 02:56:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001py-Ai; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 51/57] docs: arm: convert text files to ReST format
Date:   Mon, 15 Apr 2019 23:56:16 -0300
Message-Id: <6b85584016b0641c8b47987ab5c04c4b93b196bc.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts ARM the text files to ReST, preparing them to be an
architecture book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/arm/Booting                     |  71 ++-
 Documentation/arm/IXP4xx                      |  61 +-
 Documentation/arm/Interrupts                  |  86 +--
 Documentation/arm/Marvell/README              | 537 ++++++++++--------
 Documentation/arm/Microchip/README            |  63 +-
 Documentation/arm/Netwinder                   |  59 +-
 Documentation/arm/OMAP/DSS                    | 112 ++--
 Documentation/arm/OMAP/README                 |   7 +
 Documentation/arm/OMAP/omap_pm                |  55 +-
 Documentation/arm/Porting                     |  14 +-
 Documentation/arm/README                      |  50 +-
 Documentation/arm/SA1100/ADSBitsy             |  14 +-
 Documentation/arm/SA1100/Assabet              | 185 +++---
 Documentation/arm/SA1100/Brutus               |  45 +-
 Documentation/arm/SA1100/CERF                 |  10 +-
 Documentation/arm/SA1100/FreeBird             |  26 +-
 Documentation/arm/SA1100/GraphicsClient       |  46 +-
 Documentation/arm/SA1100/GraphicsMaster       |  13 +-
 Documentation/arm/SA1100/HUW_WEBPANEL         |   8 +-
 Documentation/arm/SA1100/Itsy                 |  14 +-
 Documentation/arm/SA1100/LART                 |   3 +-
 Documentation/arm/SA1100/PLEB                 |   6 +-
 Documentation/arm/SA1100/Pangolin             |  10 +-
 Documentation/arm/SA1100/Tifon                |   4 +-
 Documentation/arm/SA1100/Yopy                 |   5 +-
 Documentation/arm/SA1100/empeg                |   2 -
 Documentation/arm/SA1100/nanoEngine           |   6 +-
 Documentation/arm/SA1100/serial_UART          |  60 +-
 Documentation/arm/SPEAr/overview.txt          |  20 +-
 Documentation/arm/Samsung-S3C24XX/CPUfreq.txt |   5 +-
 .../arm/Samsung-S3C24XX/EB2410ITX.txt         |   5 +-
 Documentation/arm/Samsung-S3C24XX/GPIO.txt    |  21 +-
 Documentation/arm/Samsung-S3C24XX/H1940.txt   |   5 +-
 Documentation/arm/Samsung-S3C24XX/NAND.txt    |   6 +-
 .../arm/Samsung-S3C24XX/Overview.txt          |  15 +-
 Documentation/arm/Samsung-S3C24XX/S3C2412.txt |   5 +-
 Documentation/arm/Samsung-S3C24XX/S3C2413.txt |   7 +-
 .../arm/Samsung-S3C24XX/SMDK2440.txt          |   5 +-
 Documentation/arm/Samsung-S3C24XX/Suspend.txt |  20 +-
 .../arm/Samsung-S3C24XX/USB-Host.txt          |  16 +-
 .../arm/Samsung/Bootloader-interface.txt      |  27 +-
 Documentation/arm/Samsung/GPIO.txt            |   5 +-
 Documentation/arm/Samsung/Overview.txt        |  11 +-
 Documentation/arm/Setup                       |  49 +-
 Documentation/arm/VFP/release-notes.txt       |   4 +-
 .../arm/cluster-pm-race-avoidance.txt         | 177 +++---
 Documentation/arm/firmware.txt                |  14 +-
 Documentation/arm/kernel_mode_neon.txt        |   3 +
 Documentation/arm/kernel_user_helpers.txt     |  79 +--
 Documentation/arm/keystone/Overview.txt       |  47 +-
 Documentation/arm/keystone/knav-qmss.txt      |   6 +-
 Documentation/arm/mem_alignment               |  11 +-
 Documentation/arm/memory.txt                  |   9 +-
 Documentation/arm/nwfpe/NOTES                 |   3 +
 Documentation/arm/nwfpe/README                |  10 +-
 Documentation/arm/nwfpe/README.FPE            |  24 +-
 Documentation/arm/nwfpe/TODO                  |  47 +-
 Documentation/arm/pxa/mfp.txt                 | 106 ++--
 Documentation/arm/sti/overview.txt            |  21 +-
 Documentation/arm/sti/stih407-overview.txt    |   9 +-
 Documentation/arm/sti/stih415-overview.txt    |   8 +-
 Documentation/arm/sti/stih416-overview.txt    |   5 +-
 Documentation/arm/sti/stih418-overview.txt    |   9 +-
 .../arm/stm32/stm32f429-overview.rst          |   5 +-
 .../arm/stm32/stm32f746-overview.rst          |   5 +-
 .../arm/stm32/stm32f769-overview.rst          |   5 +-
 .../arm/stm32/stm32h743-overview.rst          |   5 +-
 .../arm/stm32/stm32mp157-overview.rst         |   1 +
 Documentation/arm/sunxi/README                |  98 +++-
 Documentation/arm/sunxi/clocks.txt            |   7 +-
 Documentation/arm/swp_emulation               |  24 +-
 Documentation/arm/tcm.txt                     |  54 +-
 Documentation/arm/uefi.txt                    |  39 +-
 Documentation/arm/vlocks.txt                  |   9 +-
 Documentation/index.rst                       |   1 +
 75 files changed, 1532 insertions(+), 1107 deletions(-)
 delete mode 100644 Documentation/arm/SA1100/empeg

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index f1f965ce93d6..4babb6c6ae1e 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -1,7 +1,9 @@
-			Booting ARM Linux
-			=================
+=================
+Booting ARM Linux
+=================
 
 Author:	Russell King
+
 Date  : 18 May 2002
 
 The following documentation is relevant to 2.4.18-rmk6 and beyond.
@@ -25,8 +27,10 @@ following:
 1. Setup and initialise RAM
 ---------------------------
 
-Existing boot loaders:		MANDATORY
-New boot loaders:		MANDATORY
+Existing boot loaders:
+	MANDATORY
+New boot loaders:
+	MANDATORY
 
 The boot loader is expected to find and initialise all RAM that the
 kernel will use for volatile data storage in the system.  It performs
@@ -39,8 +43,10 @@ sees fit.)
 2. Initialise one serial port
 -----------------------------
 
-Existing boot loaders:		OPTIONAL, RECOMMENDED
-New boot loaders:		OPTIONAL, RECOMMENDED
+Existing boot loaders:
+	OPTIONAL, RECOMMENDED
+New boot loaders:
+	OPTIONAL, RECOMMENDED
 
 The boot loader should initialise and enable one serial port on the
 target.  This allows the kernel serial driver to automatically detect
@@ -57,8 +63,10 @@ serial format options as described in
 3. Detect the machine type
 --------------------------
 
-Existing boot loaders:		OPTIONAL
-New boot loaders:		MANDATORY except for DT-only platforms
+Existing boot loaders:
+	OPTIONAL
+New boot loaders:
+	MANDATORY except for DT-only platforms
 
 The boot loader should detect the machine type its running on by some
 method.  Whether this is a hard coded value or some algorithm that
@@ -74,8 +82,10 @@ necessary, but assures that it will not match any existing types.
 4. Setup boot data
 ------------------
 
-Existing boot loaders:		OPTIONAL, HIGHLY RECOMMENDED
-New boot loaders:		MANDATORY
+Existing boot loaders:
+	OPTIONAL, HIGHLY RECOMMENDED
+New boot loaders:
+	MANDATORY
 
 The boot loader must provide either a tagged list or a dtb image for
 passing configuration data to the kernel.  The physical address of the
@@ -97,15 +107,15 @@ entirety; some tags behave as the former, others the latter.
 
 The boot loader must pass at a minimum the size and location of
 the system memory, and root filesystem location.  Therefore, the
-minimum tagged list should look:
+minimum tagged list should look::
 
-	+-----------+
-base ->	| ATAG_CORE |  |
-	+-----------+  |
-	| ATAG_MEM  |  | increasing address
-	+-----------+  |
-	| ATAG_NONE |  |
-	+-----------+  v
+		+-----------+
+  base ->	| ATAG_CORE |  |
+		+-----------+  |
+		| ATAG_MEM  |  | increasing address
+		+-----------+  |
+		| ATAG_NONE |  |
+		+-----------+  v
 
 The tagged list should be stored in system RAM.
 
@@ -134,8 +144,10 @@ A safe location is just above the 128MiB boundary from start of RAM.
 5. Load initramfs.
 ------------------
 
-Existing boot loaders:		OPTIONAL
-New boot loaders:		OPTIONAL
+Existing boot loaders:
+	OPTIONAL
+New boot loaders:
+	OPTIONAL
 
 If an initramfs is in use then, as with the dtb, it must be placed in
 a region of memory where the kernel decompressor will not overwrite it
@@ -149,8 +161,10 @@ recommended above.
 6. Calling the kernel image
 ---------------------------
 
-Existing boot loaders:		MANDATORY
-New boot loaders:		MANDATORY
+Existing boot loaders:
+	MANDATORY
+New boot loaders:
+	MANDATORY
 
 There are two options for calling the kernel zImage.  If the zImage
 is stored in flash, and is linked correctly to be run from flash,
@@ -174,12 +188,14 @@ In any case, the following conditions must be met:
   you many hours of debug.
 
 - CPU register settings
-  r0 = 0,
-  r1 = machine type number discovered in (3) above.
-  r2 = physical address of tagged list in system RAM, or
-       physical address of device tree block (dtb) in system RAM
+
+  - r0 = 0,
+  - r1 = machine type number discovered in (3) above.
+  - r2 = physical address of tagged list in system RAM, or
+    physical address of device tree block (dtb) in system RAM
 
 - CPU mode
+
   All forms of interrupts must be disabled (IRQs and FIQs)
 
   For CPUs which do not include the ARM virtualization extensions, the
@@ -195,8 +211,11 @@ In any case, the following conditions must be met:
   entered in SVC mode.
 
 - Caches, MMUs
+
   The MMU must be off.
+
   Instruction cache may be on or off.
+
   Data cache must be off.
 
   If the kernel is entered in HYP mode, the above requirements apply to
diff --git a/Documentation/arm/IXP4xx b/Documentation/arm/IXP4xx
index e48b74de6ac0..a57235616294 100644
--- a/Documentation/arm/IXP4xx
+++ b/Documentation/arm/IXP4xx
@@ -1,6 +1,6 @@
-
--------------------------------------------------------------------------
+===========================================================
 Release Notes for Linux on Intel's IXP4xx Network Processor
+===========================================================
 
 Maintained by Deepak Saxena <dsaxena@plexity.net>
 -------------------------------------------------------------------------
@@ -8,7 +8,7 @@ Maintained by Deepak Saxena <dsaxena@plexity.net>
 1. Overview
 
 Intel's IXP4xx network processor is a highly integrated SOC that
-is targeted for network applications, though it has become popular 
+is targeted for network applications, though it has become popular
 in industrial control and other areas due to low cost and power
 consumption. The IXP4xx family currently consists of several processors
 that support different network offload functions such as encryption,
@@ -20,7 +20,7 @@ For more information on the various versions of the CPU, see:
 
    http://developer.intel.com/design/network/products/npfamily/ixp4xx.htm
 
-Intel also made the IXCP1100 CPU for sometime which is an IXP4xx 
+Intel also made the IXCP1100 CPU for sometime which is an IXP4xx
 stripped of much of the network intelligence.
 
 2. Linux Support
@@ -31,7 +31,7 @@ Linux currently supports the following features on the IXP4xx chips:
 - PCI interface
 - Flash access (MTD/JFFS)
 - I2C through GPIO on IXP42x
-- GPIO for input/output/interrupts 
+- GPIO for input/output/interrupts
   See arch/arm/mach-ixp4xx/include/mach/platform.h for access functions.
 - Timers (watchdog, OS)
 
@@ -45,7 +45,7 @@ require the use of Intel's proprietary CSR software:
 If you need to use any of the above, you need to download Intel's
 software from:
 
-   http://developer.intel.com/design/network/products/npfamily/ixp425.htm    
+   http://developer.intel.com/design/network/products/npfamily/ixp425.htm
 
 DO NOT POST QUESTIONS TO THE LINUX MAILING LISTS REGARDING THE PROPRIETARY
 SOFTWARE.
@@ -53,14 +53,14 @@ SOFTWARE.
 There are several websites that provide directions/pointers on using
 Intel's software:
 
-   http://sourceforge.net/projects/ixp4xx-osdg/
-   Open Source Developer's Guide for using uClinux and the Intel libraries 
+   - http://sourceforge.net/projects/ixp4xx-osdg/
+     Open Source Developer's Guide for using uClinux and the Intel libraries
 
-http://gatewaymaker.sourceforge.net/ 
-   Simple one page summary of building a gateway using an IXP425 and Linux
+   - http://gatewaymaker.sourceforge.net/
+     Simple one page summary of building a gateway using an IXP425 and Linux
 
-http://ixp425.sourceforge.net/
-   ATM device driver for IXP425 that relies on Intel's libraries
+   - http://ixp425.sourceforge.net/
+     ATM device driver for IXP425 that relies on Intel's libraries
 
 3. Known Issues/Limitations
 
@@ -70,7 +70,7 @@ The IXP4xx family allows for up to 256MB of memory but the PCI interface
 can only expose 64MB of that memory to the PCI bus. This means that if
 you are running with > 64MB, all PCI buffers outside of the accessible
 range will be bounced using the routines in arch/arm/common/dmabounce.c.
-   
+
 3b. Limited outbound PCI window
 
 IXP4xx provides two methods of accessing PCI memory space:
@@ -79,15 +79,15 @@ IXP4xx provides two methods of accessing PCI memory space:
    To access PCI via this space, we simply ioremap() the BAR
    into the kernel and we can use the standard read[bwl]/write[bwl]
    macros. This is the preffered method due to speed but it
-   limits the system to just 64MB of PCI memory. This can be 
+   limits the system to just 64MB of PCI memory. This can be
    problamatic if using video cards and other memory-heavy devices.
-          
-2) If > 64MB of memory space is required, the IXP4xx can be 
-   configured to use indirect registers to access PCI This allows 
-   for up to 128MB (0x48000000 to 0x4fffffff) of memory on the bus. 
-   The disadvantage of this is that every PCI access requires 
-   three local register accesses plus a spinlock, but in some 
-   cases the performance hit is acceptable. In addition, you cannot 
+
+2) If > 64MB of memory space is required, the IXP4xx can be
+   configured to use indirect registers to access PCI This allows
+   for up to 128MB (0x48000000 to 0x4fffffff) of memory on the bus.
+   The disadvantage of this is that every PCI access requires
+   three local register accesses plus a spinlock, but in some
+   cases the performance hit is acceptable. In addition, you cannot
    mmap() PCI devices in this case due to the indirect nature
    of the PCI window.
 
@@ -96,14 +96,14 @@ you need more PCI memory, enable the IXP4XX_INDIRECT_PCI config option.
 
 3c. GPIO as Interrupts
 
-Currently the code only handles level-sensitive GPIO interrupts 
+Currently the code only handles level-sensitive GPIO interrupts
 
 4. Supported platforms
 
 ADI Engineering Coyote Gateway Reference Platform
 http://www.adiengineering.com/productsCoyote.html
 
-   The ADI Coyote platform is reference design for those building 
+   The ADI Coyote platform is reference design for those building
    small residential/office gateways. One NPE is connected to a 10/100
    interface, one to 4-port 10/100 switch, and the third to and ADSL
    interface. In addition, it also supports to POTs interfaces connected
@@ -119,9 +119,9 @@ http://www.gateworks.com/support/overview.php
    the expansion bus.
 
 Intel IXDP425 Development Platform
-http://www.intel.com/design/network/products/npfamily/ixdpg425.htm  
+http://www.intel.com/design/network/products/npfamily/ixdpg425.htm
 
-   This is Intel's standard reference platform for the IXDP425 and is 
+   This is Intel's standard reference platform for the IXDP425 and is
    also known as the Richfield board. It contains 4 PCI slots, 16MB
    of flash, two 10/100 ports and one ADSL port.
 
@@ -161,11 +161,12 @@ The IXP4xx work has been funded by Intel Corp. and MontaVista Software, Inc.
 
 The following people have contributed patches/comments/etc:
 
-Lennerty Buytenhek
-Lutz Jaenicke
-Justin Mayfield
-Robert E. Ranslam
-[I know I've forgotten others, please email me to be added] 
+- Lennerty Buytenhek
+- Lutz Jaenicke
+- Justin Mayfield
+- Robert E. Ranslam
+
+[I know I've forgotten others, please email me to be added]
 
 -------------------------------------------------------------------------
 
diff --git a/Documentation/arm/Interrupts b/Documentation/arm/Interrupts
index f09ab1b90ef1..2ae70e0e9732 100644
--- a/Documentation/arm/Interrupts
+++ b/Documentation/arm/Interrupts
@@ -1,8 +1,10 @@
-2.5.2-rmk5
-----------
+==========
+Interrupts
+==========
 
-This is the first kernel that contains a major shake up of some of the
-major architecture-specific subsystems.
+2.5.2-rmk5:
+  This is the first kernel that contains a major shake up of some of the
+  major architecture-specific subsystems.
 
 Firstly, it contains some pretty major changes to the way we handle the
 MMU TLB.  Each MMU TLB variant is now handled completely separately -
@@ -18,7 +20,7 @@ Unfortunately, this means that machine types that touch the irq_desc[]
 array (basically all machine types) will break, and this means every
 machine type that we currently have.
 
-Lets take an example.  On the Assabet with Neponset, we have:
+Lets take an example.  On the Assabet with Neponset, we have::
 
                   GPIO25                 IRR:2
         SA1100 ------------> Neponset -----------> SA1111
@@ -48,42 +50,47 @@ the irqdesc array).  This doesn't have to be a real "IC"; indeed the
 SA11x0 IRQs are handled by two separate "chip" structures, one for
 GPIO0-10, and another for all the rest.  It is just a container for
 the various operations (maybe this'll change to a better name).
-This structure has the following operations:
+This structure has the following operations::
 
-struct irqchip {
-        /*
-         * Acknowledge the IRQ.
-         * If this is a level-based IRQ, then it is expected to mask the IRQ
-         * as well.
-         */
-        void (*ack)(unsigned int irq);
-        /*
-         * Mask the IRQ in hardware.
-         */
-        void (*mask)(unsigned int irq);
-        /*
-         * Unmask the IRQ in hardware.
-         */
-        void (*unmask)(unsigned int irq);
-        /*
-         * Re-run the IRQ
-         */
-        void (*rerun)(unsigned int irq);
-        /*
-         * Set the type of the IRQ.
-         */
-        int (*type)(unsigned int irq, unsigned int, type);
-};
+  struct irqchip {
+          /*
+           * Acknowledge the IRQ.
+           * If this is a level-based IRQ, then it is expected to mask the IRQ
+           * as well.
+           */
+          void (*ack)(unsigned int irq);
+          /*
+           * Mask the IRQ in hardware.
+           */
+          void (*mask)(unsigned int irq);
+          /*
+           * Unmask the IRQ in hardware.
+           */
+          void (*unmask)(unsigned int irq);
+          /*
+           * Re-run the IRQ
+           */
+          void (*rerun)(unsigned int irq);
+          /*
+           * Set the type of the IRQ.
+           */
+          int (*type)(unsigned int irq, unsigned int, type);
+  };
 
-ack    - required.  May be the same function as mask for IRQs
+ack
+       - required.  May be the same function as mask for IRQs
          handled by do_level_IRQ.
-mask   - required.
-unmask - required.
-rerun  - optional.  Not required if you're using do_level_IRQ for all
+mask
+       - required.
+unmask
+       - required.
+rerun
+       - optional.  Not required if you're using do_level_IRQ for all
          IRQs that use this 'irqchip'.  Generally expected to re-trigger
          the hardware IRQ if possible.  If not, may call the handler
 	 directly.
-type   - optional.  If you don't support changing the type of an IRQ,
+type
+       - optional.  If you don't support changing the type of an IRQ,
          it should be null so people can detect if they are unable to
          set the IRQ type.
 
@@ -109,6 +116,7 @@ manipulation, nor state tracking.  This is useful for things like the
 SMC9196 and USAR above.
 
 So, what's changed?
+===================
 
 1. Machine implementations must not write to the irqdesc array.
 
@@ -118,24 +126,19 @@ So, what's changed?
    absolutely necessary.
 
         set_irq_chip(irq,chip)
-
                 Set the mask/unmask methods for handling this IRQ
 
         set_irq_handler(irq,handler)
-
                 Set the handler for this IRQ (level, edge, simple)
 
         set_irq_chained_handler(irq,handler)
-
                 Set a "chained" handler for this IRQ - automatically
                 enables this IRQ (eg, Neponset and SA1111 handlers).
 
         set_irq_flags(irq,flags)
-
                 Set the valid/probe/noautoenable flags.
 
         set_irq_type(irq,type)
-
                 Set active the IRQ edge(s)/level.  This replaces the
                 SA1111 INTPOL manipulation, and the set_GPIO_IRQ_edge()
                 function.  Type should be one of IRQ_TYPE_xxx defined in
@@ -158,10 +161,9 @@ So, what's changed?
    be re-checked for pending events.  (see the Neponset IRQ handler for
    details).
 
-7. fixup_irq() is gone, as is arch/arm/mach-*/include/mach/irq.h
+7. fixup_irq() is gone, as is `arch/arm/mach-*/include/mach/irq.h`
 
 Please note that this will not solve all problems - some of them are
 hardware based.  Mixing level-based and edge-based IRQs on the same
 parent signal (eg neponset) is one such area where a software based
 solution can't provide the full answer to low IRQ latency.
-
diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index 56ada27c53be..16ab2eb085b8 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -1,3 +1,4 @@
+================
 ARM Marvell SoCs
 ================
 
@@ -12,221 +13,309 @@ Orion family
 ------------
 
   Flavors:
-        88F5082
-        88F5181
-        88F5181L
-        88F5182
-               Datasheet               : http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
-               Programmer's User Guide : http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
-               User Manual             : http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
-        88F5281
-               Datasheet               : http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
-        88F6183
-  Core: Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
-  Linux kernel mach directory: arch/arm/mach-orion5x
-  Linux kernel plat directory: arch/arm/plat-orion
+        - 88F5082
+        - 88F5181
+        - 88F5181L
+        - 88F5182
+
+               - Datasheet: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
+               - Programmer's User Guide: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
+               - User Manual: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
+        - 88F5281
+
+               - Datasheet: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
+        - 88F6183
+  Core:
+	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
+  Linux kernel mach directory:
+	arch/arm/mach-orion5x
+  Linux kernel plat directory:
+	arch/arm/plat-orion
 
 Kirkwood family
 ---------------
 
   Flavors:
-        88F6282 a.k.a Armada 300
-                Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
-        88F6283 a.k.a Armada 310
-                Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
-        88F6190
-                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-003_WEB.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-        88F6192
-                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-        88F6182
-        88F6180
-                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-        88F6281
-                Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
-  Homepage: http://www.marvell.com/embedded-processors/kirkwood/
-  Core: Feroceon 88fr131 ARMv5 compatible
-  Linux kernel mach directory: arch/arm/mach-mvebu
-  Linux kernel plat directory: none
+        - 88F6282 a.k.a Armada 300
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+        - 88F6283 a.k.a Armada 310
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+        - 88F6190
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-003_WEB.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        - 88F6192
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        - 88F6182
+        - 88F6180
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        - 88F6281
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+  Homepage:
+	http://www.marvell.com/embedded-processors/kirkwood/
+  Core:
+	Feroceon 88fr131 ARMv5 compatible
+  Linux kernel mach directory:
+	arch/arm/mach-mvebu
+  Linux kernel plat directory:
+	none
 
 Discovery family
 ----------------
 
   Flavors:
-        MV78100
-                Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100-003_WEB.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
-        MV78200
-                Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200-002_WEB.pdf
-                Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
-                Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
-        MV76100
+        - MV78100
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100-003_WEB.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+        - MV78200
+
+                - Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200-002_WEB.pdf
+                - Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
+                - Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+        - MV76100
+
                 Not supported by the Linux kernel.
 
-  Core: Feroceon 88fr571-vd ARMv5 compatible
+  Core:
+	Feroceon 88fr571-vd ARMv5 compatible
 
-  Linux kernel mach directory: arch/arm/mach-mv78xx0
-  Linux kernel plat directory: arch/arm/plat-orion
+  Linux kernel mach directory:
+	arch/arm/mach-mv78xx0
+  Linux kernel plat directory:
+	arch/arm/plat-orion
 
 EBU Armada family
 -----------------
 
   Armada 370 Flavors:
-        88F6710
-        88F6707
-        88F6W11
-    Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
-    Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
-    Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
-    Core: Sheeva ARMv7 compatible PJ4B
+        - 88F6710
+        - 88F6707
+        - 88F6W11
+
+    - Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+    - Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
+    - Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+
+  Core:
+	Sheeva ARMv7 compatible PJ4B
 
   Armada 375 Flavors:
-	88F6720
-    Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
-    Core: ARM Cortex-A9
+	- 88F6720
+
+    - Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+
+  Core:
+	ARM Cortex-A9
 
   Armada 38x Flavors:
-	88F6810	Armada 380
-	88F6820 Armada 385
-	88F6828 Armada 388
-    Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
-    Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
-    Core: ARM Cortex-A9
+	- 88F6810	Armada 380
+	- 88F6820 Armada 385
+	- 88F6828 Armada 388
+
+    - Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
+    - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
+
+  Core:
+	ARM Cortex-A9
 
   Armada 39x Flavors:
-	88F6920 Armada 390
-	88F6928 Armada 398
-    Product infos: http://www.marvell.com/embedded-processors/armada-39x/
-    Core: ARM Cortex-A9
+	- 88F6920 Armada 390
+	- 88F6928 Armada 398
+
+    - Product infos: http://www.marvell.com/embedded-processors/armada-39x/
+
+  Core:
+	ARM Cortex-A9
 
   Armada XP Flavors:
-        MV78230
-        MV78260
-        MV78460
-    NOTE: not to be confused with the non-SMP 78xx0 SoCs
-    Product Brief: http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
-    Functional Spec: http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
-    Hardware Specs:
-      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
-      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
-      http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
-    Core: Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
-
-  Linux kernel mach directory: arch/arm/mach-mvebu
-  Linux kernel plat directory: none
+        - MV78230
+        - MV78260
+        - MV78460
+
+    NOTE:
+	not to be confused with the non-SMP 78xx0 SoCs
+
+    Product Brief:
+	http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
+
+    Functional Spec:
+	http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
+
+    - Hardware Specs:
+
+        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
+        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
+        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
+
+  Core:
+	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
+
+  Linux kernel mach directory:
+	arch/arm/mach-mvebu
+  Linux kernel plat directory:
+	none
 
 EBU Armada family ARMv8
 -----------------------
 
   Armada 3710/3720 Flavors:
-	88F3710
-	88F3720
-	Core: ARM Cortex A53 (ARMv8)
+	- 88F3710
+	- 88F3720
 
-	Homepage: http://www.marvell.com/embedded-processors/armada-3700/
-	Product Brief: http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
-	Device tree files: arch/arm64/boot/dts/marvell/armada-37*
+  Core:
+	ARM Cortex A53 (ARMv8)
+
+  Homepage:
+	http://www.marvell.com/embedded-processors/armada-3700/
+
+  Product Brief:
+	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+
+  Device tree files:
+	arch/arm64/boot/dts/marvell/armada-37*
 
   Armada 7K Flavors:
-	88F7020 (AP806 Dual + one CP110)
-	88F7040 (AP806 Quad + one CP110)
-	Core: ARM Cortex A72
-
-	Homepage: http://www.marvell.com/embedded-processors/armada-70xx/
-	Product Brief: http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pdf
-		       http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pdf
-	Device tree files: arch/arm64/boot/dts/marvell/armada-70*
+	  - 88F7020 (AP806 Dual + one CP110)
+	  - 88F7040 (AP806 Quad + one CP110)
+
+  Core: ARM Cortex A72
+
+  Homepage:
+	http://www.marvell.com/embedded-processors/armada-70xx/
+
+  Product Brief:
+	  - http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pdf
+	  - http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pdf
+
+  Device tree files:
+	arch/arm64/boot/dts/marvell/armada-70*
 
   Armada 8K Flavors:
-	88F8020 (AP806 Dual + two CP110)
-	88F8040 (AP806 Quad + two CP110)
-	Core: ARM Cortex A72
+	- 88F8020 (AP806 Dual + two CP110)
+	- 88F8040 (AP806 Quad + two CP110)
+  Core:
+	ARM Cortex A72
 
-	Homepage: http://www.marvell.com/embedded-processors/armada-80xx/
-	Product Brief: http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2016.pdf
-		       http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2016.pdf
-	Device tree files: arch/arm64/boot/dts/marvell/armada-80*
+  Homepage:
+	http://www.marvell.com/embedded-processors/armada-80xx/
+
+  Product Brief:
+	  - http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2016.pdf
+	  - http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2016.pdf
+
+  Device tree files:
+	arch/arm64/boot/dts/marvell/armada-80*
 
 Avanta family
 -------------
 
   Flavors:
-       88F6510
-       88F6530P
-       88F6550
-       88F6560
-  Homepage     : http://www.marvell.com/broadband/
-  Product Brief: http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
+       - 88F6510
+       - 88F6530P
+       - 88F6550
+       - 88F6560
+
+  Homepage:
+	http://www.marvell.com/broadband/
+
+  Product Brief:
+	http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
+
   No public datasheet available.
 
-  Core: ARMv5 compatible
+  Core:
+	ARMv5 compatible
 
-  Linux kernel mach directory: no code in mainline yet, planned for the future
-  Linux kernel plat directory: no code in mainline yet, planned for the future
+  Linux kernel mach directory:
+	no code in mainline yet, planned for the future
+  Linux kernel plat directory:
+	no code in mainline yet, planned for the future
 
 Storage family
 --------------
 
   Armada SP:
-	88RC1580
-    Product infos: http://www.marvell.com/storage/armada-sp/
-    Core: Sheeva ARMv7 comatible Quad-core PJ4C
-    (not supported in upstream Linux kernel)
+	- 88RC1580
+
+  Product infos:
+	http://www.marvell.com/storage/armada-sp/
+
+  Core:
+	Sheeva ARMv7 comatible Quad-core PJ4C
+
+  (not supported in upstream Linux kernel)
 
 Dove family (application processor)
 -----------------------------------
 
   Flavors:
-        88AP510 a.k.a Armada 510
-                Product Brief   : http://www.marvell.com/application-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
-                Hardware Spec   : http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Hardware-Spec.pdf
-                Functional Spec : http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
-  Homepage: http://www.marvell.com/application-processors/armada-500/
-  Core: ARMv7 compatible
-
-  Directory: arch/arm/mach-mvebu (DT enabled platforms)
-             arch/arm/mach-dove (non-DT enabled platforms)
+        - 88AP510 a.k.a Armada 510
+
+   Product Brief:
+	http://www.marvell.com/application-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
+
+   Hardware Spec:
+	http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Hardware-Spec.pdf
+
+  Functional Spec:
+	http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
+
+  Homepage:
+	http://www.marvell.com/application-processors/armada-500/
+
+  Core:
+	ARMv7 compatible
+
+  Directory:
+	- arch/arm/mach-mvebu (DT enabled platforms)
+        - arch/arm/mach-dove (non-DT enabled platforms)
 
 PXA 2xx/3xx/93x/95x family
 --------------------------
 
   Flavors:
-        PXA21x, PXA25x, PXA26x
-             Application processor only
-             Core: ARMv5 XScale1 core
-        PXA270, PXA271, PXA272
-             Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
-             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
-             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
-             Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
-             Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
-             Application processor only
-             Core: ARMv5 XScale2 core
-        PXA300, PXA310, PXA320
-             PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
-             PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
-             PXA 320 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
-             Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
-             Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
-             Specifications        : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
-             Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
-             Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
-             Application processor only
-             Core: ARMv5 XScale3 core
-        PXA930, PXA935
-             Application processor with Communication processor
-             Core: ARMv5 XScale3 core
-        PXA955
-             Application processor with Communication processor
-             Core: ARMv7 compatible Sheeva PJ4 core
+        - PXA21x, PXA25x, PXA26x
+             - Application processor only
+             - Core: ARMv5 XScale1 core
+        - PXA270, PXA271, PXA272
+             - Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
+             - Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
+             - Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
+             - Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
+             - Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
+             - Application processor only
+             - Core: ARMv5 XScale2 core
+        - PXA300, PXA310, PXA320
+             - PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
+             - PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
+             - PXA 320 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
+             - Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
+             - Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
+             - Specifications        : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
+             - Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
+             - Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+             - Application processor only
+             - Core: ARMv5 XScale3 core
+        - PXA930, PXA935
+             - Application processor with Communication processor
+             - Core: ARMv5 XScale3 core
+        - PXA955
+             - Application processor with Communication processor
+             - Core: ARMv7 compatible Sheeva PJ4 core
 
    Comments:
 
@@ -239,48 +328,50 @@ PXA 2xx/3xx/93x/95x family
       common with the other (Kirkwood, Dove, etc.) families of Marvell
       SoCs, except with the MMP/MMP2 family of SoCs.
 
-   Linux kernel mach directory: arch/arm/mach-pxa
-   Linux kernel plat directory: arch/arm/plat-pxa
+   Linux kernel mach directory:
+	arch/arm/mach-pxa
+   Linux kernel plat directory:
+	arch/arm/plat-pxa
 
 MMP/MMP2/MMP3 family (communication processor)
------------------------------------------
+----------------------------------------------
 
    Flavors:
-        PXA168, a.k.a Armada 168
-             Homepage             : http://www.marvell.com/application-processors/armada-100/armada-168.jsp
-             Product brief        : http://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
-             Hardware manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
-             Software manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
-             Specification update : http://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
-             Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
-             App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
-             Application processor only
-             Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
-        PXA910/PXA920
-             Homepage             : http://www.marvell.com/communication-processors/pxa910/
-             Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
-             Application processor with Communication processor
-             Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
-        PXA688, a.k.a. MMP2, a.k.a Armada 610
-             Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
-             Application processor only
-             Core: ARMv7 compatible Sheeva PJ4 88sv581x core
-	PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
-	     Product Brief	  : http://www.marvell.com/application-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
-	     Application processor only
-	     Core: Dual-core ARMv7 compatible Sheeva PJ4C core
-	PXA960/PXA968/PXA978 (Linux support not upstream)
-	     Application processor with Communication Processor
-	     Core: ARMv7 compatible Sheeva PJ4 core
-	PXA986/PXA988 (Linux support not upstream)
-	     Application processor with Communication Processor
-	     Core: Dual-core ARMv7 compatible Sheeva PJ4B-MP core
-	PXA1088/PXA1920 (Linux support not upstream)
-	     Application processor with Communication Processor
-	     Core: quad-core ARMv7 Cortex-A7
-	PXA1908/PXA1928/PXA1936
-	     Application processor with Communication Processor
-	     Core: multi-core ARMv8 Cortex-A53
+        - PXA168, a.k.a Armada 168
+             - Homepage             : http://www.marvell.com/application-processors/armada-100/armada-168.jsp
+             - Product brief        : http://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
+             - Hardware manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
+             - Software manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
+             - Specification update : http://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
+             - Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
+             - App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
+             - Application processor only
+             - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
+        - PXA910/PXA920
+             - Homepage             : http://www.marvell.com/communication-processors/pxa910/
+             - Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
+             - Application processor with Communication processor
+             - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
+        - PXA688, a.k.a. MMP2, a.k.a Armada 610
+             - Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
+             - Application processor only
+             - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
+	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
+	     - Product Brief	  : http://www.marvell.com/application-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+	     - Application processor only
+	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
+	- PXA960/PXA968/PXA978 (Linux support not upstream)
+	     - Application processor with Communication Processor
+	     - Core: ARMv7 compatible Sheeva PJ4 core
+	- PXA986/PXA988 (Linux support not upstream)
+	     - Application processor with Communication Processor
+	     - Core: Dual-core ARMv7 compatible Sheeva PJ4B-MP core
+	- PXA1088/PXA1920 (Linux support not upstream)
+	     - Application processor with Communication Processor
+	     - Core: quad-core ARMv7 Cortex-A7
+	- PXA1908/PXA1928/PXA1936
+	     - Application processor with Communication Processor
+	     - Core: multi-core ARMv8 Cortex-A53
 
    Comments:
 
@@ -292,33 +383,35 @@ MMP/MMP2/MMP3 family (communication processor)
       common with the other (Kirkwood, Dove, etc.) families of Marvell
       SoCs, except with the PXA family of SoCs listed above.
 
-   Linux kernel mach directory: arch/arm/mach-mmp
-   Linux kernel plat directory: arch/arm/plat-pxa
+   Linux kernel mach directory:
+	arch/arm/mach-mmp
+   Linux kernel plat directory:
+	arch/arm/plat-pxa
 
 Berlin family (Multimedia Solutions)
 -------------------------------------
 
-  Flavors:
-	88DE3010, Armada 1000 (no Linux support)
-		Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
-	88DE3005, Armada 1500 Mini
-		Design name:	BG2CD
-		Core:		ARM Cortex-A9, PL310 L2CC
-	88DE3006, Armada 1500 Mini Plus
-		Design name:	BG2CDP
-		Core:		Dual Core ARM Cortex-A7
-	88DE3100, Armada 1500
-		Design name:	BG2
-		Core:		Marvell PJ4B-MP (ARMv7), Tauros3 L2CC
-	88DE3114, Armada 1500 Pro
-		Design name:	BG2Q
-		Core:		Quad Core ARM Cortex-A9, PL310 L2CC
-	88DE3214, Armada 1500 Pro 4K
-		Design name:	BG3
-		Core:		ARM Cortex-A15, CA15 integrated L2CC
-	88DE3218, ARMADA 1500 Ultra
-		Core:		ARM Cortex-A53
+  - Flavors:
+	- 88DE3010, Armada 1000 (no Linux support)
+		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
+		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
+	- 88DE3005, Armada 1500 Mini
+		- Design name:	BG2CD
+		- Core:		ARM Cortex-A9, PL310 L2CC
+	- 88DE3006, Armada 1500 Mini Plus
+		- Design name:	BG2CDP
+		- Core:		Dual Core ARM Cortex-A7
+	- 88DE3100, Armada 1500
+		- Design name:	BG2
+		- Core:		Marvell PJ4B-MP (ARMv7), Tauros3 L2CC
+	- 88DE3114, Armada 1500 Pro
+		- Design name:	BG2Q
+		- Core:		Quad Core ARM Cortex-A9, PL310 L2CC
+	- 88DE3214, Armada 1500 Pro 4K
+		- Design name:	BG3
+		- Core:		ARM Cortex-A15, CA15 integrated L2CC
+	- 88DE3218, ARMADA 1500 Ultra
+		- Core:		ARM Cortex-A53
 
   Homepage: https://www.synaptics.com/products/multimedia-solutions
   Directory: arch/arm/mach-berlin
@@ -387,9 +480,9 @@ Long-term plans
 Credits
 -------
 
- Maen Suleiman <maen@marvell.com>
- Lior Amsalem <alior@marvell.com>
- Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- Andrew Lunn <andrew@lunn.ch>
- Nicolas Pitre <nico@fluxnic.net>
- Eric Miao <eric.y.miao@gmail.com>
+- Maen Suleiman <maen@marvell.com>
+- Lior Amsalem <alior@marvell.com>
+- Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+- Andrew Lunn <andrew@lunn.ch>
+- Nicolas Pitre <nico@fluxnic.net>
+- Eric Miao <eric.y.miao@gmail.com>
diff --git a/Documentation/arm/Microchip/README b/Documentation/arm/Microchip/README
index a366f37d38f1..c9a44c98e868 100644
--- a/Documentation/arm/Microchip/README
+++ b/Documentation/arm/Microchip/README
@@ -1,3 +1,4 @@
+=============================
 ARM Microchip SoCs (aka AT91)
 =============================
 
@@ -22,32 +23,46 @@ the Microchip website: http://www.microchip.com.
   Flavors:
     * ARM 920 based SoC
       - at91rm9200
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
 
     * ARM 926 based SoCs
       - at91sam9260
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
 
       - at91sam9xe
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
 
       - at91sam9261
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
 
       - at91sam9263
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
 
       - at91sam9rl
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
 
       - at91sam9g20
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
 
       - at91sam9g45 family
@@ -55,7 +70,9 @@ the Microchip website: http://www.microchip.com.
         - at91sam9g46
         - at91sam9m10
         - at91sam9m11 (device superset)
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
 
       - at91sam9x5 family (aka "The 5 series")
@@ -64,33 +81,44 @@ the Microchip website: http://www.microchip.com.
         - at91sam9g35
         - at91sam9x25
         - at91sam9x35
-        + Datasheet (can be considered as covering the whole family)
+
+          * Datasheet (can be considered as covering the whole family)
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
 
       - at91sam9n12
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
 
     * ARM Cortex-A5 based SoCs
       - sama5d3 family
+
         - sama5d31
         - sama5d33
         - sama5d34
         - sama5d35
         - sama5d36 (device superset)
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet.pdf
 
     * ARM Cortex-A5 + NEON based SoCs
       - sama5d4 family
+
         - sama5d41
         - sama5d42
         - sama5d43
         - sama5d44 (device superset)
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
 
       - sama5d2 family
+
         - sama5d21
         - sama5d22
         - sama5d23
@@ -98,11 +126,14 @@ the Microchip website: http://www.microchip.com.
         - sama5d26
         - sama5d27 (device superset)
         - sama5d28 (device superset + environmental monitors)
-        + Datasheet
+
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
 
     * ARM Cortex-M7 MCUs
       - sams70 family
+
         - sams70j19
         - sams70j20
         - sams70j21
@@ -114,6 +145,7 @@ the Microchip website: http://www.microchip.com.
         - sams70q21
 
       - samv70 family
+
         - samv70j19
         - samv70j20
         - samv70n19
@@ -122,6 +154,7 @@ the Microchip website: http://www.microchip.com.
         - samv70q20
 
       - samv71 family
+
         - samv71j19
         - samv71j20
         - samv71j21
@@ -132,7 +165,8 @@ the Microchip website: http://www.microchip.com.
         - samv71q20
         - samv71q21
 
-        + Datasheet
+          * Datasheet
+
           http://ww1.microchip.com/downloads/en/DeviceDoc/60001527A.pdf
 
 
@@ -157,6 +191,7 @@ definition of a "Stable" binding/ABI.
 This statement will be removed by AT91 MAINTAINERS when appropriate.
 
 Naming conventions and best practice:
+
 - SoCs Device Tree Source Include files are named after the official name of
   the product (at91sam9g20.dtsi or sama5d33.dtsi for instance).
 - Device Tree Source Include files (.dtsi) are used to collect common nodes that can be
diff --git a/Documentation/arm/Netwinder b/Documentation/arm/Netwinder
index f1b457fbd3de..8eab66caa2ac 100644
--- a/Documentation/arm/Netwinder
+++ b/Documentation/arm/Netwinder
@@ -1,3 +1,4 @@
+================================
 NetWinder specific documentation
 ================================
 
@@ -8,44 +9,47 @@ DC21285 PCI bridge, with PC-type hardware glued around it.
 Port usage
 ==========
 
-Min    - Max	Description
----------------------------
-0x0000 - 0x000f	DMA1
-0x0020 - 0x0021	PIC1
-0x0060 - 0x006f	Keyboard
-0x0070 - 0x007f	RTC
-0x0080 - 0x0087	DMA1
-0x0088 - 0x008f	DMA2
-0x00a0 - 0x00a3	PIC2
-0x00c0 - 0x00df	DMA2
-0x0180 - 0x0187	IRDA
-0x01f0 - 0x01f6	ide0
+=======  ====== ===============================
+Min      Max	Description
+=======  ====== ===============================
+0x0000   0x000f	DMA1
+0x0020   0x0021	PIC1
+0x0060   0x006f	Keyboard
+0x0070   0x007f	RTC
+0x0080   0x0087	DMA1
+0x0088   0x008f	DMA2
+0x00a0   0x00a3	PIC2
+0x00c0   0x00df	DMA2
+0x0180   0x0187	IRDA
+0x01f0   0x01f6	ide0
 0x0201		Game port
 0x0203		RWA010 configuration read
-0x0220 - ?	SoundBlaster
-0x0250 - ?	WaveArtist
+0x0220   ?	SoundBlaster
+0x0250   ?	WaveArtist
 0x0279		RWA010 configuration index
-0x02f8 - 0x02ff	Serial ttyS1
-0x0300 - 0x031f	Ether10
+0x02f8   0x02ff	Serial ttyS1
+0x0300   0x031f	Ether10
 0x0338		GPIO1
 0x033a		GPIO2
-0x0370 - 0x0371	W83977F configuration registers
-0x0388 - ?	AdLib
-0x03c0 - 0x03df	VGA
+0x0370   0x0371	W83977F configuration registers
+0x0388   ?	AdLib
+0x03c0   0x03df	VGA
 0x03f6		ide0
-0x03f8 - 0x03ff	Serial ttyS0
-0x0400 - 0x0408	DC21143
-0x0480 - 0x0487	DMA1
-0x0488 - 0x048f	DMA2
+0x03f8   0x03ff	Serial ttyS0
+0x0400   0x0408	DC21143
+0x0480   0x0487	DMA1
+0x0488   0x048f	DMA2
 0x0a79		RWA010 configuration write
-0xe800 - 0xe80f	ide0/ide1 BM DMA
+0xe800   0xe80f	ide0/ide1 BM DMA
+=======  ====== ===============================
 
 
 Interrupt usage
 ===============
 
+======= ======= ========================
 IRQ	type	Description
----------------------------
+======= ======= ========================
  0	ISA	100Hz timer
  1	ISA	Keyboard
  2	ISA	cascade
@@ -62,12 +66,14 @@ IRQ	type	Description
 13	ISA
 14	ISA	hda1
 15	ISA
+======= ======= ========================
 
 DMA usage
 =========
 
+======= ======= ===========
 DMA	type	Description
----------------------------
+======= ======= ===========
  0	ISA	IRDA
  1	ISA
  2	ISA	cascade
@@ -76,3 +82,4 @@ DMA	type	Description
  5	ISA
  6	ISA
  7	ISA	WaveArtist
+======= ======= ===========
diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 4484e021290e..a40c4d9c717a 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -1,5 +1,6 @@
+=========================
 OMAP2/3 Display Subsystem
--------------------------
+=========================
 
 This is an almost total rewrite of the OMAP FB driver in drivers/video/omap
 (let's call it DSS1). The main differences between DSS1 and DSS2 are DSI,
@@ -190,6 +191,8 @@ trans_key_value			transparency color key (RGB24)
 default_color			default background color (RGB24)
 
 /sys/devices/platform/omapdss/display? directory:
+
+=============== =============================================================
 ctrl_name	Controller name
 mirror		0=off, 1=on
 update_mode	0=off, 1=auto, 2=manual
@@ -202,6 +205,7 @@ timings		Display timings (pixclock,xres/hfp/hbp/hsw,yres/vfp/vbp/vsw)
 panel_name
 tear_elim	Tearing elimination 0=off, 1=on
 output_type	Output type (video encoder only): "composite" or "svideo"
+=============== =============================================================
 
 There are also some debugfs files at <debugfs>/omapdss/ which show information
 about clocks and registers.
@@ -209,22 +213,22 @@ about clocks and registers.
 Examples
 --------
 
-The following definitions have been made for the examples below:
+The following definitions have been made for the examples below::
 
-ovl0=/sys/devices/platform/omapdss/overlay0
-ovl1=/sys/devices/platform/omapdss/overlay1
-ovl2=/sys/devices/platform/omapdss/overlay2
+	ovl0=/sys/devices/platform/omapdss/overlay0
+	ovl1=/sys/devices/platform/omapdss/overlay1
+	ovl2=/sys/devices/platform/omapdss/overlay2
 
-mgr0=/sys/devices/platform/omapdss/manager0
-mgr1=/sys/devices/platform/omapdss/manager1
+	mgr0=/sys/devices/platform/omapdss/manager0
+	mgr1=/sys/devices/platform/omapdss/manager1
 
-lcd=/sys/devices/platform/omapdss/display0
-dvi=/sys/devices/platform/omapdss/display1
-tv=/sys/devices/platform/omapdss/display2
+	lcd=/sys/devices/platform/omapdss/display0
+	dvi=/sys/devices/platform/omapdss/display1
+	tv=/sys/devices/platform/omapdss/display2
 
-fb0=/sys/class/graphics/fb0
-fb1=/sys/class/graphics/fb1
-fb2=/sys/class/graphics/fb2
+	fb0=/sys/class/graphics/fb0
+	fb1=/sys/class/graphics/fb1
+	fb2=/sys/class/graphics/fb2
 
 Default setup on OMAP3 SDP
 --------------------------
@@ -232,55 +236,59 @@ Default setup on OMAP3 SDP
 Here's the default setup on OMAP3 SDP board. All planes go to LCD. DVI
 and TV-out are not in use. The columns from left to right are:
 framebuffers, overlays, overlay managers, displays. Framebuffers are
-handled by omapfb, and the rest by the DSS.
+handled by omapfb, and the rest by the DSS::
 
-FB0 --- GFX  -\            DVI
-FB1 --- VID1 --+- LCD ---- LCD
-FB2 --- VID2 -/   TV ----- TV
+	FB0 --- GFX  -\            DVI
+	FB1 --- VID1 --+- LCD ---- LCD
+	FB2 --- VID2 -/   TV ----- TV
 
 Example: Switch from LCD to DVI
-----------------------
-
-w=`cat $dvi/timings | cut -d "," -f 2 | cut -d "/" -f 1`
-h=`cat $dvi/timings | cut -d "," -f 3 | cut -d "/" -f 1`
-
-echo "0" > $lcd/enabled
-echo "" > $mgr0/display
-fbset -fb /dev/fb0 -xres $w -yres $h -vxres $w -vyres $h
-# at this point you have to switch the dvi/lcd dip-switch from the omap board
-echo "dvi" > $mgr0/display
-echo "1" > $dvi/enabled
-
-After this the configuration looks like:
-
-FB0 --- GFX  -\         -- DVI
-FB1 --- VID1 --+- LCD -/   LCD
-FB2 --- VID2 -/   TV ----- TV
-
-Example: Clone GFX overlay to LCD and TV
 -------------------------------
 
-w=`cat $tv/timings | cut -d "," -f 2 | cut -d "/" -f 1`
-h=`cat $tv/timings | cut -d "," -f 3 | cut -d "/" -f 1`
+::
 
-echo "0" > $ovl0/enabled
-echo "0" > $ovl1/enabled
+	w=`cat $dvi/timings | cut -d "," -f 2 | cut -d "/" -f 1`
+	h=`cat $dvi/timings | cut -d "," -f 3 | cut -d "/" -f 1`
 
-echo "" > $fb1/overlays
-echo "0,1" > $fb0/overlays
+	echo "0" > $lcd/enabled
+	echo "" > $mgr0/display
+	fbset -fb /dev/fb0 -xres $w -yres $h -vxres $w -vyres $h
+	# at this point you have to switch the dvi/lcd dip-switch from the omap board
+	echo "dvi" > $mgr0/display
+	echo "1" > $dvi/enabled
 
-echo "$w,$h" > $ovl1/output_size
-echo "tv" > $ovl1/manager
+After this the configuration looks like:::
 
-echo "1" > $ovl0/enabled
-echo "1" > $ovl1/enabled
+	FB0 --- GFX  -\         -- DVI
+	FB1 --- VID1 --+- LCD -/   LCD
+	FB2 --- VID2 -/   TV ----- TV
 
-echo "1" > $tv/enabled
+Example: Clone GFX overlay to LCD and TV
+----------------------------------------
 
-After this the configuration looks like (only relevant parts shown):
+::
 
-FB0 +-- GFX  ---- LCD ---- LCD
-     \- VID1 ---- TV  ---- TV
+	w=`cat $tv/timings | cut -d "," -f 2 | cut -d "/" -f 1`
+	h=`cat $tv/timings | cut -d "," -f 3 | cut -d "/" -f 1`
+
+	echo "0" > $ovl0/enabled
+	echo "0" > $ovl1/enabled
+
+	echo "" > $fb1/overlays
+	echo "0,1" > $fb0/overlays
+
+	echo "$w,$h" > $ovl1/output_size
+	echo "tv" > $ovl1/manager
+
+	echo "1" > $ovl0/enabled
+	echo "1" > $ovl1/enabled
+
+	echo "1" > $tv/enabled
+
+After this the configuration looks like (only relevant parts shown)::
+
+	FB0 +-- GFX  ---- LCD ---- LCD
+	\- VID1 ---- TV  ---- TV
 
 Misc notes
 ----------
@@ -351,12 +359,14 @@ TODO
 DSS locking
 
 Error checking
+
 - Lots of checks are missing or implemented just as BUG()
 
 System DMA update for DSI
+
 - Can be used for RGB16 and RGB24P modes. Probably not for RGB24U (how
   to skip the empty byte?)
 
 OMAP1 support
+
 - Not sure if needed
-
diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index 90c6c57d61e8..f440c0f4613f 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -1,7 +1,13 @@
+============
+OMAP history
+============
+
 This file contains documentation for running mainline
 kernel on omaps.
 
+======		======================================================
 KERNEL		NEW DEPENDENCIES
+======		======================================================
 v4.3+		Update is needed for custom .config files to make sure
 		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
 		properly.
@@ -9,3 +15,4 @@ v4.3+		Update is needed for custom .config files to make sure
 v4.18+		Update is needed for custom .config files to make sure
 		CONFIG_MMC_SDHCI_OMAP is enabled for all MMC instances
 		to work in DRA7 and K2G based boards.
+======		======================================================
diff --git a/Documentation/arm/OMAP/omap_pm b/Documentation/arm/OMAP/omap_pm
index 4ae915a9f899..a335e4c8ce2c 100644
--- a/Documentation/arm/OMAP/omap_pm
+++ b/Documentation/arm/OMAP/omap_pm
@@ -1,4 +1,4 @@
-
+=====================
 The OMAP PM interface
 =====================
 
@@ -31,19 +31,24 @@ Drivers need to express PM parameters which:
 This document proposes the OMAP PM interface, including the following
 five power management functions for driver code:
 
-1. Set the maximum MPU wakeup latency:
+1. Set the maximum MPU wakeup latency::
+
    (*pdata->set_max_mpu_wakeup_lat)(struct device *dev, unsigned long t)
 
-2. Set the maximum device wakeup latency:
+2. Set the maximum device wakeup latency::
+
    (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t)
 
-3. Set the maximum system DMA transfer start latency (CORE pwrdm):
+3. Set the maximum system DMA transfer start latency (CORE pwrdm)::
+
    (*pdata->set_max_sdma_lat)(struct device *dev, long t)
 
-4. Set the minimum bus throughput needed by a device:
+4. Set the minimum bus throughput needed by a device::
+
    (*pdata->set_min_bus_tput)(struct device *dev, u8 agent_id, unsigned long r)
 
-5. Return the number of times the device has lost context
+5. Return the number of times the device has lost context::
+
    (*pdata->get_dev_context_loss_count)(struct device *dev)
 
 
@@ -65,12 +70,13 @@ Driver usage of the OMAP PM functions
 
 As the 'pdata' in the above examples indicates, these functions are
 exposed to drivers through function pointers in driver .platform_data
-structures.  The function pointers are initialized by the board-*.c
+structures.  The function pointers are initialized by the `board-*.c`
 files to point to the corresponding OMAP PM functions:
-.set_max_dev_wakeup_lat will point to
-omap_pm_set_max_dev_wakeup_lat(), etc.  Other architectures which do
-not support these functions should leave these function pointers set
-to NULL.  Drivers should use the following idiom:
+
+- set_max_dev_wakeup_lat will point to
+  omap_pm_set_max_dev_wakeup_lat(), etc.  Other architectures which do
+  not support these functions should leave these function pointers set
+  to NULL.  Drivers should use the following idiom::
 
         if (pdata->set_max_dev_wakeup_lat)
             (*pdata->set_max_dev_wakeup_lat)(dev, t);
@@ -81,7 +87,7 @@ becomes accessible.  To accomplish this, driver writers should use the
 set_max_mpu_wakeup_lat() function to constrain the MPU wakeup
 latency, and the set_max_dev_wakeup_lat() function to constrain the
 device wakeup latency (from clk_enable() to accessibility).  For
-example,
+example::
 
         /* Limit MPU wakeup latency */
         if (pdata->set_max_mpu_wakeup_lat)
@@ -116,17 +122,17 @@ specialized cases to convert that input information (OPPs/MPU
 frequency) into the form that the underlying power management
 implementation needs:
 
-6. (*pdata->dsp_get_opp_table)(void)
+6. `(*pdata->dsp_get_opp_table)(void)`
 
-7. (*pdata->dsp_set_min_opp)(u8 opp_id)
+7. `(*pdata->dsp_set_min_opp)(u8 opp_id)`
 
-8. (*pdata->dsp_get_opp)(void)
+8. `(*pdata->dsp_get_opp)(void)`
 
-9. (*pdata->cpu_get_freq_table)(void)
+9. `(*pdata->cpu_get_freq_table)(void)`
 
-10. (*pdata->cpu_set_freq)(unsigned long f)
+10. `(*pdata->cpu_set_freq)(unsigned long f)`
 
-11. (*pdata->cpu_get_freq)(void)
+11. `(*pdata->cpu_get_freq)(void)`
 
 Customizing OPP for platform
 ============================
@@ -134,12 +140,15 @@ Defining CONFIG_PM should enable OPP layer for the silicon
 and the registration of OPP table should take place automatically.
 However, in special cases, the default OPP table may need to be
 tweaked, for e.g.:
+
  * enable default OPPs which are disabled by default, but which
    could be enabled on a platform
  * Disable an unsupported OPP on the platform
  * Define and add a custom opp table entry
-in these cases, the board file needs to do additional steps as follows:
-arch/arm/mach-omapx/board-xyz.c
+   in these cases, the board file needs to do additional steps as follows:
+
+arch/arm/mach-omapx/board-xyz.c::
+
 	#include "pm.h"
 	....
 	static void __init omap_xyz_init_irq(void)
@@ -150,5 +159,7 @@ arch/arm/mach-omapx/board-xyz.c
 		/* Do customization to the defaults */
 		....
 	}
-NOTE: omapx_opp_init will be omap3_opp_init or as required
-based on the omap family.
+
+NOTE:
+  omapx_opp_init will be omap3_opp_init or as required
+  based on the omap family.
diff --git a/Documentation/arm/Porting b/Documentation/arm/Porting
index a492233931b9..bd21958bdb2d 100644
--- a/Documentation/arm/Porting
+++ b/Documentation/arm/Porting
@@ -1,3 +1,7 @@
+=======
+Porting
+=======
+
 Taken from list archive at http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2001-July/004064.html
 
 Initial definitions
@@ -89,8 +93,7 @@ DATAADDR
 	Virtual address for the kernel data segment.  Must not be defined
 	when using the decompressor.
 
-VMALLOC_START
-VMALLOC_END
+VMALLOC_START / VMALLOC_END
 	Virtual addresses bounding the vmalloc() area.  There must not be
 	any static mappings in this area; vmalloc will overwrite them.
 	The addresses must also be in the kernel segment (see above).
@@ -107,13 +110,13 @@ Architecture Specific Macros
 ----------------------------
 
 BOOT_MEM(pram,pio,vio)
-	`pram' specifies the physical start address of RAM.  Must always
+	`pram` specifies the physical start address of RAM.  Must always
 	be present, and should be the same as PHYS_OFFSET.
 
-	`pio' is the physical address of an 8MB region containing IO for
+	`pio` is the physical address of an 8MB region containing IO for
 	use with the debugging macros in arch/arm/kernel/debug-armv.S.
 
-	`vio' is the virtual address of the 8MB debugging region.
+	`vio` is the virtual address of the 8MB debugging region.
 
 	It is expected that the debugging region will be re-initialised
 	by the architecture specific code later in the code (via the
@@ -132,4 +135,3 @@ MAPIO(func)
 
 INITIRQ(func)
 	Machine specific function to initialise interrupts.
-
diff --git a/Documentation/arm/README b/Documentation/arm/README
index 9d1e5b2c92e6..2edc509df92a 100644
--- a/Documentation/arm/README
+++ b/Documentation/arm/README
@@ -1,5 +1,6 @@
-			   ARM Linux 2.6
-			   =============
+=======================
+ARM Linux 2.6 and upper
+=======================
 
     Please check <ftp://ftp.arm.linux.org.uk/pub/armlinux> for
     updates.
@@ -18,22 +19,28 @@ Compilation of kernel
   line as detailed below.
 
   If you wish to cross-compile, then alter the following lines in the top
-  level make file:
+  level make file::
 
     ARCH = <whatever>
-	with
+
+  with::
+
     ARCH = arm
 
-	and
+  and::
 
     CROSS_COMPILE=
-	to
+
+  to::
+
     CROSS_COMPILE=<your-path-to-your-compiler-without-gcc>
-	eg.
+
+  eg.::
+
     CROSS_COMPILE=arm-linux-
 
-  Do a 'make config', followed by 'make Image' to build the kernel 
-  (arch/arm/boot/Image).  A compressed image can be built by doing a 
+  Do a 'make config', followed by 'make Image' to build the kernel
+  (arch/arm/boot/Image).  A compressed image can be built by doing a
   'make zImage' instead of 'make Image'.
 
 
@@ -46,7 +53,7 @@ Bug reports etc
 
   Bug reports should be sent to linux-arm-kernel@lists.arm.linux.org.uk,
   or submitted through the web form at
-  http://www.arm.linux.org.uk/developer/ 
+  http://www.arm.linux.org.uk/developer/
 
   When sending bug reports, please ensure that they contain all relevant
   information, eg. the kernel messages that were printed before/during
@@ -60,11 +67,13 @@ Include files
   which are there to reduce the clutter in the top-level directory.  These
   directories, and their purpose is listed below:
 
-   arch-*	machine/platform specific header files
-   hardware	driver-internal ARM specific data structures/definitions
-   mach		descriptions of generic ARM to specific machine interfaces
-   proc-*	processor dependent header files (currently only two
+  ============= ==========================================================
+   `arch-*`	machine/platform specific header files
+   `hardware`	driver-internal ARM specific data structures/definitions
+   `mach`	descriptions of generic ARM to specific machine interfaces
+   `proc-*`	processor dependent header files (currently only two
 		categories)
+  ============= ==========================================================
 
 
 Machine/Platform support
@@ -129,7 +138,7 @@ ST506 hard drives
   HDC base to the source.
 
   As of 31/3/96 it works with two drives (you should get the ADFS
-  *configure harddrive set to 2). I've got an internal 20MB and a great
+  `*configure` harddrive set to 2). I've got an internal 20MB and a great
   big external 5.25" FH 64MB drive (who could ever want more :-) ).
 
   I've just got 240K/s off it (a dd with bs=128k); thats about half of what
@@ -149,13 +158,13 @@ ST506 hard drives
   are welcome.
 
 
-CONFIG_MACH_ and CONFIG_ARCH_
------------------------------
+`CONFIG_MACH_` and `CONFIG_ARCH_`
+---------------------------------
   A change was made in 2003 to the macro names for new machines.
-  Historically, CONFIG_ARCH_ was used for the bonafide architecture,
+  Historically, `CONFIG_ARCH_` was used for the bonafide architecture,
   e.g. SA1100, as well as implementations of the architecture,
   e.g. Assabet.  It was decided to change the implementation macros
-  to read CONFIG_MACH_ for clarity.  Moreover, a retroactive fixup has
+  to read `CONFIG_MACH_` for clarity.  Moreover, a retroactive fixup has
   not been made because it would complicate patching.
 
   Previous registrations may be found online.
@@ -163,7 +172,7 @@ CONFIG_MACH_ and CONFIG_ARCH_
     <http://www.arm.linux.org.uk/developer/machines/>
 
 Kernel entry (head.S)
---------------------------
+---------------------
   The initial entry into the kernel is via head.S, which uses machine
   independent code.  The machine is selected by the value of 'r1' on
   entry, which must be kept unique.
@@ -201,4 +210,5 @@ Kernel entry (head.S)
   platform is DT-only, you do not need a registered machine type.
 
 ---
+
 Russell King (15/03/2004)
diff --git a/Documentation/arm/SA1100/ADSBitsy b/Documentation/arm/SA1100/ADSBitsy
index f9f62e8c0719..c179cb26b682 100644
--- a/Documentation/arm/SA1100/ADSBitsy
+++ b/Documentation/arm/SA1100/ADSBitsy
@@ -1,4 +1,7 @@
+===============================
 ADS Bitsy Single Board Computer
+===============================
+
 (It is different from Bitsy(iPAQ) of Compaq)
 
 For more details, contact Applied Data Systems or see
@@ -15,7 +18,9 @@ The kernel zImage is linked to be loaded and executed at 0xc0400000.
 Linux can  be used with the ADS BootLoader that ships with the
 newer rev boards. See their documentation on how to load Linux.
 
-Supported peripherals:
+Supported peripherals
+=====================
+
 - SA1100 LCD frame buffer (8/16bpp...sort of)
 - SA1111 USB Master
 - SA1100 serial port
@@ -25,10 +30,13 @@ Supported peripherals:
 - serial ports (ttyS[0-2])
   - ttyS0 is default for serial console
 
-To do:
+To do
+=====
+
 - everything else!  :-)
 
-Notes:
+Notes
+=====
 
 - The flash on board is divided into 3 partitions.
   You should be careful to use flash on board.
diff --git a/Documentation/arm/SA1100/Assabet b/Documentation/arm/SA1100/Assabet
index e08a6739e72c..3e704831c311 100644
--- a/Documentation/arm/SA1100/Assabet
+++ b/Documentation/arm/SA1100/Assabet
@@ -1,3 +1,4 @@
+============================================
 The Intel Assabet (SA-1110 evaluation) board
 ============================================
 
@@ -11,7 +12,7 @@ http://www.cs.cmu.edu/~wearable/software/assabet.html
 Building the kernel
 -------------------
 
-To build the kernel with current defaults:
+To build the kernel with current defaults::
 
 	make assabet_config
 	make oldconfig
@@ -51,9 +52,9 @@ Brief examples on how to boot Linux with RedBoot are shown below.  But first
 you need to have RedBoot installed in your flash memory.  A known to work
 precompiled RedBoot binary is available from the following location:
 
-ftp://ftp.netwinder.org/users/n/nico/
-ftp://ftp.arm.linux.org.uk/pub/linux/arm/people/nico/
-ftp://ftp.handhelds.org/pub/linux/arm/sa-1100-patches/
+- ftp://ftp.netwinder.org/users/n/nico/
+- ftp://ftp.arm.linux.org.uk/pub/linux/arm/people/nico/
+- ftp://ftp.handhelds.org/pub/linux/arm/sa-1100-patches/
 
 Look for redboot-assabet*.tgz.  Some installation infos are provided in
 redboot-assabet*.txt.
@@ -71,12 +72,12 @@ Socket Communications Inc.), you should strongly consider using it for TFTP
 file transfers.  You must insert it before RedBoot runs since it can't detect
 it dynamically.
 
-To initialize the flash directory:
+To initialize the flash directory::
 
 	fis init -f
 
 To initialize the non-volatile settings, like whether you want to use BOOTP or
-a static IP address, etc, use this command:
+a static IP address, etc, use this command::
 
 	fconfig -i
 
@@ -85,15 +86,15 @@ Writing a kernel image into flash
 ---------------------------------
 
 First, the kernel image must be loaded into RAM.  If you have the zImage file
-available on a TFTP server:
+available on a TFTP server::
 
 	load zImage -r -b 0x100000
 
-If you rather want to use Y-Modem upload over the serial port:
+If you rather want to use Y-Modem upload over the serial port::
 
 	load -m ymodem -r -b 0x100000
 
-To write it to flash:
+To write it to flash::
 
 	fis create "Linux kernel" -b 0x100000 -l 0xc0000
 
@@ -102,18 +103,18 @@ Booting the kernel
 ------------------
 
 The kernel still requires a filesystem to boot.  A ramdisk image can be loaded
-as follows:
+as follows::
 
 	load ramdisk_image.gz -r -b 0x800000
 
 Again, Y-Modem upload can be used instead of TFTP by replacing the file name
 by '-y ymodem'.
 
-Now the kernel can be retrieved from flash like this:
+Now the kernel can be retrieved from flash like this::
 
 	fis load "Linux kernel"
 
-or loaded as described previously.  To boot the kernel:
+or loaded as described previously.  To boot the kernel::
 
 	exec -b 0x100000 -l 0xc0000
 
@@ -134,35 +135,35 @@ creating JFFS/JFFS2 images is available from the same site.
 For instance, a sample JFFS2 image can be retrieved from the same FTP sites
 mentioned below for the precompiled RedBoot image.
 
-To load this file:
+To load this file::
 
 	load sample_img.jffs2 -r -b 0x100000
 
-The result should look like:
+The result should look like::
 
-RedBoot> load sample_img.jffs2 -r -b 0x100000
-Raw file loaded 0x00100000-0x00377424
+	RedBoot> load sample_img.jffs2 -r -b 0x100000
+	Raw file loaded 0x00100000-0x00377424
 
-Now we must know the size of the unallocated flash:
+Now we must know the size of the unallocated flash::
 
 	fis free
 
-Result:
+Result::
 
-RedBoot> fis free
-  0x500E0000 .. 0x503C0000
+	RedBoot> fis free
+	  0x500E0000 .. 0x503C0000
 
 The values above may be different depending on the size of the filesystem and
 the type of flash.  See their usage below as an example and take care of
 substituting yours appropriately.
 
-We must determine some values:
+We must determine some values::
 
-size of unallocated flash:	0x503c0000 - 0x500e0000 = 0x2e0000
-size of the filesystem image:	0x00377424 - 0x00100000 = 0x277424
+	size of unallocated flash:	0x503c0000 - 0x500e0000 = 0x2e0000
+	size of the filesystem image:	0x00377424 - 0x00100000 = 0x277424
 
 We want to fit the filesystem image of course, but we also want to give it all
-the remaining flash space as well.  To write it:
+the remaining flash space as well.  To write it::
 
 	fis unlock -f 0x500E0000 -l 0x2e0000
 	fis erase -f 0x500E0000 -l 0x2e0000
@@ -171,32 +172,32 @@ the remaining flash space as well.  To write it:
 
 Now the filesystem is associated to a MTD "partition" once Linux has discovered
 what they are in the boot process.  From Redboot, the 'fis list' command
-displays them:
+displays them::
 
-RedBoot> fis list
-Name              FLASH addr  Mem addr    Length      Entry point
-RedBoot           0x50000000  0x50000000  0x00020000  0x00000000
-RedBoot config    0x503C0000  0x503C0000  0x00020000  0x00000000
-FIS directory     0x503E0000  0x503E0000  0x00020000  0x00000000
-Linux kernel      0x50020000  0x00100000  0x000C0000  0x00000000
-JFFS2             0x500E0000  0x500E0000  0x002E0000  0x00000000
+	RedBoot> fis list
+	Name              FLASH addr  Mem addr    Length      Entry point
+	RedBoot           0x50000000  0x50000000  0x00020000  0x00000000
+	RedBoot config    0x503C0000  0x503C0000  0x00020000  0x00000000
+	FIS directory     0x503E0000  0x503E0000  0x00020000  0x00000000
+	Linux kernel      0x50020000  0x00100000  0x000C0000  0x00000000
+	JFFS2             0x500E0000  0x500E0000  0x002E0000  0x00000000
 
-However Linux should display something like:
+However Linux should display something like::
 
-SA1100 flash: probing 32-bit flash bus
-SA1100 flash: Found 2 x16 devices at 0x0 in 32-bit mode
-Using RedBoot partition definition
-Creating 5 MTD partitions on "SA1100 flash":
-0x00000000-0x00020000 : "RedBoot"
-0x00020000-0x000e0000 : "Linux kernel"
-0x000e0000-0x003c0000 : "JFFS2"
-0x003c0000-0x003e0000 : "RedBoot config"
-0x003e0000-0x00400000 : "FIS directory"
+	SA1100 flash: probing 32-bit flash bus
+	SA1100 flash: Found 2 x16 devices at 0x0 in 32-bit mode
+	Using RedBoot partition definition
+	Creating 5 MTD partitions on "SA1100 flash":
+	0x00000000-0x00020000 : "RedBoot"
+	0x00020000-0x000e0000 : "Linux kernel"
+	0x000e0000-0x003c0000 : "JFFS2"
+	0x003c0000-0x003e0000 : "RedBoot config"
+	0x003e0000-0x00400000 : "FIS directory"
 
 What's important here is the position of the partition we are interested in,
 which is the third one.  Within Linux, this correspond to /dev/mtdblock2.
 Therefore to boot Linux with the kernel and its root filesystem in flash, we
-need this RedBoot command:
+need this RedBoot command::
 
 	fis load "Linux kernel"
 	exec -b 0x100000 -l 0xc0000 -c "root=/dev/mtdblock2"
@@ -218,21 +219,21 @@ time the Assabet is rebooted.  Therefore it's possible to automate the boot
 process using RedBoot's scripting capability.
 
 For example, I use this to boot Linux with both the kernel and the ramdisk
-images retrieved from a TFTP server on the network:
+images retrieved from a TFTP server on the network::
 
-RedBoot> fconfig
-Run script at boot: false true
-Boot script:
-Enter script, terminate with empty line
->> load zImage -r -b 0x100000
->> load ramdisk_ks.gz -r -b 0x800000
->> exec -b 0x100000 -l 0xc0000
->>
-Boot script timeout (1000ms resolution): 3
-Use BOOTP for network configuration: true
-GDB connection port: 9000
-Network debug at boot time: false
-Update RedBoot non-volatile configuration - are you sure (y/n)? y
+	RedBoot> fconfig
+	Run script at boot: false true
+	Boot script:
+	Enter script, terminate with empty line
+	>> load zImage -r -b 0x100000
+	>> load ramdisk_ks.gz -r -b 0x800000
+	>> exec -b 0x100000 -l 0xc0000
+	>>
+	Boot script timeout (1000ms resolution): 3
+	Use BOOTP for network configuration: true
+	GDB connection port: 9000
+	Network debug at boot time: false
+	Update RedBoot non-volatile configuration - are you sure (y/n)? y
 
 Then, rebooting the Assabet is just a matter of waiting for the login prompt.
 
@@ -240,6 +241,7 @@ Then, rebooting the Assabet is just a matter of waiting for the login prompt.
 
 Nicolas Pitre
 nico@fluxnic.net
+
 June 12, 2001
 
 
@@ -249,52 +251,51 @@ Status of peripherals in -rmk tree (updated 14/10/2001)
 Assabet:
  Serial ports:
   Radio:		TX, RX, CTS, DSR, DCD, RI
-   PM:			Not tested.
-  COM:			TX, RX, CTS, DSR, DCD, RTS, DTR, PM
-   PM:			Not tested.
-  I2C:			Implemented, not fully tested.
-  L3:			Fully tested, pass.
-   PM:			Not tested.
+   - PM:		Not tested.
+   - COM:		TX, RX, CTS, DSR, DCD, RTS, DTR, PM
+   - PM:		Not tested.
+   - I2C:		Implemented, not fully tested.
+   - L3:		Fully tested, pass.
+   - PM:		Not tested.
 
  Video:
-  LCD:			Fully tested.  PM
-			(LCD doesn't like being blanked with
-			 neponset connected)
-  Video out:		Not fully
+  - LCD:		Fully tested.  PM
+
+   (LCD doesn't like being blanked with neponset connected)
+
+  - Video out:		Not fully
 
  Audio:
   UDA1341:
-   Playback:		Fully tested, pass.
-   Record:		Implemented, not tested.
-   PM:			Not tested.
+  -  Playback:		Fully tested, pass.
+  -  Record:		Implemented, not tested.
+  -  PM:			Not tested.
 
   UCB1200:
-   Audio play:		Implemented, not heavily tested.
-   Audio rec:		Implemented, not heavily tested.
-   Telco audio play:	Implemented, not heavily tested.
-   Telco audio rec:	Implemented, not heavily tested.
-   POTS control:	No
-   Touchscreen:		Yes
-   PM:			Not tested.
+  -  Audio play:	Implemented, not heavily tested.
+  -  Audio rec:		Implemented, not heavily tested.
+  -  Telco audio play:	Implemented, not heavily tested.
+  -  Telco audio rec:	Implemented, not heavily tested.
+  -  POTS control:	No
+  -  Touchscreen:	Yes
+  -  PM:		Not tested.
 
  Other:
-  PCMCIA:
-   LPE:			Fully tested, pass.
-  USB:			No
-  IRDA:
-   SIR:			Fully tested, pass.
-   FIR:			Fully tested, pass.
-   PM:			Not tested.
+  - PCMCIA:
+  - LPE:		Fully tested, pass.
+  - USB:		No
+  - IRDA:
+  - SIR:		Fully tested, pass.
+  - FIR:		Fully tested, pass.
+  - PM:			Not tested.
 
 Neponset:
  Serial ports:
-  COM1,2:	TX, RX, CTS, DSR, DCD, RTS, DTR
-   PM:			Not tested.
-  USB:			Implemented, not heavily tested.
-  PCMCIA:		Implemented, not heavily tested.
-   PM:			Not tested.
-  CF:			Implemented, not heavily tested.
-   PM:			Not tested.
+  - COM1,2:		TX, RX, CTS, DSR, DCD, RTS, DTR
+  - PM:			Not tested.
+  - USB:		Implemented, not heavily tested.
+  - PCMCIA:		Implemented, not heavily tested.
+  - CF:			Implemented, not heavily tested.
+  - PM:			Not tested.
 
 More stuff can be found in the -np (Nicolas Pitre's) tree.
-
diff --git a/Documentation/arm/SA1100/Brutus b/Documentation/arm/SA1100/Brutus
index 6a3aa95e9bfd..e1a23bee6d44 100644
--- a/Documentation/arm/SA1100/Brutus
+++ b/Documentation/arm/SA1100/Brutus
@@ -1,9 +1,13 @@
-Brutus is an evaluation platform for the SA1100 manufactured by Intel.  
+======
+Brutus
+======
+
+Brutus is an evaluation platform for the SA1100 manufactured by Intel.
 For more details, see:
 
 http://developer.intel.com
 
-To compile for Brutus, you must issue the following commands:
+To compile for Brutus, you must issue the following commands::
 
 	make brutus_config
 	make config
@@ -16,25 +20,23 @@ must be loaded at 0xc0008000 in Brutus's memory and execution started at
 entry.
 
 But prior to execute the kernel, a ramdisk image must also be loaded in
-memory.  Use memory address 0xd8000000 for this.  Note that the file 
+memory.  Use memory address 0xd8000000 for this.  Note that the file
 containing the (compressed) ramdisk image must not exceed 4 MB.
 
 Typically, you'll need angelboot to load the kernel.
-The following angelboot.opt file should be used:
+The following angelboot.opt file should be used::
 
------ begin angelboot.opt -----
-base 0xc0008000
-entry 0xc0008000
-r0 0x00000000
-r1 0x00000010
-device /dev/ttyS0
-options "9600 8N1"
-baud 115200
-otherfile ramdisk_img.gz
-otherbase 0xd8000000
------ end angelboot.opt -----
+	base 0xc0008000
+	entry 0xc0008000
+	r0 0x00000000
+	r1 0x00000010
+	device /dev/ttyS0
+	options "9600 8N1"
+	baud 115200
+	otherfile ramdisk_img.gz
+	otherbase 0xd8000000
 
-Then load the kernel and ramdisk with:
+Then load the kernel and ramdisk with::
 
 	angelboot -f angelboot.opt zImage
 
@@ -44,14 +46,16 @@ console is provided through the second Brutus serial port. To access it,
 you may use minicom configured with /dev/ttyS1, 9600 baud, 8N1, no flow
 control.
 
-Currently supported:
+Currently supported
+===================
+
 	- RS232 serial ports
 	- audio output
 	- LCD screen
 	- keyboard
-	
-The actual Brutus support may not be complete without extra patches. 
-If such patches exist, they should be found from 
+
+The actual Brutus support may not be complete without extra patches.
+If such patches exist, they should be found from
 ftp.netwinder.org/users/n/nico.
 
 A full PCMCIA support is still missing, although it's possible to hack
@@ -63,4 +67,3 @@ Any contribution is welcome.
 Please send patches to nico@fluxnic.net
 
 Have Fun !
-
diff --git a/Documentation/arm/SA1100/CERF b/Documentation/arm/SA1100/CERF
index b3d845301ef1..7fa71b609bf9 100644
--- a/Documentation/arm/SA1100/CERF
+++ b/Documentation/arm/SA1100/CERF
@@ -1,3 +1,7 @@
+==============
+CerfBoard/Cube
+==============
+
 *** The StrongARM version of the CerfBoard/Cube has been discontinued ***
 
 The Intrinsyc CerfBoard is a StrongARM 1110-based computer on a board
@@ -9,7 +13,9 @@ Intrinsyc website, http://www.intrinsyc.com.
 This document describes the support in the Linux kernel for the
 Intrinsyc CerfBoard.
 
-Supported in this version:
+Supported in this version
+=========================
+
    - CompactFlash+ slot (select PCMCIA in General Setup and any options
      that may be required)
    - Onboard Crystal CS8900 Ethernet controller (Cerf CS8900A support in
@@ -19,7 +25,7 @@ Supported in this version:
 In order to get this kernel onto your Cerf, you need a server that runs
 both BOOTP and TFTP. Detailed instructions should have come with your
 evaluation kit on how to use the bootloader. This series of commands
-will suffice:
+will suffice::
 
    make ARCH=arm CROSS_COMPILE=arm-linux- cerfcube_defconfig
    make ARCH=arm CROSS_COMPILE=arm-linux- zImage
diff --git a/Documentation/arm/SA1100/FreeBird b/Documentation/arm/SA1100/FreeBird
index ab9193663b2b..81043d0c6d64 100644
--- a/Documentation/arm/SA1100/FreeBird
+++ b/Documentation/arm/SA1100/FreeBird
@@ -1,21 +1,25 @@
+========
+Freebird
+========
+
 Freebird-1.1 is produced by Legend(C), Inc.
-http://web.archive.org/web/*/http://www.legend.com.cn
+`http://web.archive.org/web/*/http://www.legend.com.cn`
 and software/linux maintained by Coventive(C), Inc.
 (http://www.coventive.com)
 
 Based on the Nicolas's strongarm kernel tree.
 
-===============================================================
 Maintainer:
 
-Chester Kuo <chester@coventive.com>
-	    <chester@linux.org.tw>
+Chester Kuo
+	- <chester@coventive.com>
+	- <chester@linux.org.tw>
 
-Author :
-Tim wu <timwu@coventive.com>
-CIH <cih@coventive.com>
-Eric Peng <ericpeng@coventive.com>
-Jeff Lee <jeff_lee@coventive.com>
-Allen Cheng
-Tony Liu <tonyliu@coventive.com>
+Author:
 
+- Tim wu <timwu@coventive.com>
+- CIH <cih@coventive.com>
+- Eric Peng <ericpeng@coventive.com>
+- Jeff Lee <jeff_lee@coventive.com>
+- Allen Cheng
+- Tony Liu <tonyliu@coventive.com>
diff --git a/Documentation/arm/SA1100/GraphicsClient b/Documentation/arm/SA1100/GraphicsClient
index 867bb35943af..a73d61c3ce91 100644
--- a/Documentation/arm/SA1100/GraphicsClient
+++ b/Documentation/arm/SA1100/GraphicsClient
@@ -1,9 +1,11 @@
+=============================================
 ADS GraphicsClient Plus Single Board Computer
+=============================================
 
 For more details, contact Applied Data Systems or see
 http://www.applieddata.net/products.html
 
-The original Linux support for this product has been provided by 
+The original Linux support for this product has been provided by
 Nicolas Pitre <nico@fluxnic.net>. Continued development work by
 Woojung Huh <whuh@applieddata.net>
 
@@ -14,8 +16,8 @@ board supports MTD/JFFS, so you could also mount something on there.
 Use 'make graphicsclient_config' before any 'make config'.  This will set up
 defaults for GraphicsClient Plus support.
 
-The kernel zImage is linked to be loaded and executed at 0xc0200000.  
-Also the following registers should have the specified values upon entry:
+The kernel zImage is linked to be loaded and executed at 0xc0200000.
+Also the following registers should have the specified values upon entry::
 
 	r0 = 0
 	r1 = 29	(this is the GraphicsClient architecture number)
@@ -31,23 +33,21 @@ as outlined below.  In any case, if you're planning on deploying
 something en masse, you should probably get the newer board.
 
 If using Angel on the older boards, here is a typical angel.opt option file
-if the kernel is loaded through the Angel Debug Monitor:
+if the kernel is loaded through the Angel Debug Monitor::
 
------ begin angelboot.opt -----
-base 0xc0200000
-entry 0xc0200000
-r0 0x00000000
-r1 0x0000001d
-device /dev/ttyS1
-options "38400 8N1"
-baud 115200
-#otherfile ramdisk.gz
-#otherbase 0xc0800000
-exec minicom
------ end angelboot.opt -----
+	base 0xc0200000
+	entry 0xc0200000
+	r0 0x00000000
+	r1 0x0000001d
+	device /dev/ttyS1
+	options "38400 8N1"
+	baud 115200
+	#otherfile ramdisk.gz
+	#otherbase 0xc0800000
+	exec minicom
 
 Then the kernel (and ramdisk if otherfile/otherbase lines above are
-uncommented) would be loaded with:
+uncommented) would be loaded with::
 
 	angelboot -f angelboot.opt zImage
 
@@ -59,7 +59,9 @@ If any other bootloader is used, ensure it accomplish the same, especially
 for r0/r1 register values before jumping into the kernel.
 
 
-Supported peripherals:
+Supported peripherals
+=====================
+
 - SA1100 LCD frame buffer (8/16bpp...sort of)
 - on-board SMC 92C96 ethernet NIC
 - SA1100 serial port
@@ -74,11 +76,14 @@ Supported peripherals:
   See http://www.eurotech-inc.com/linux-sbc.asp for IOCTL documentation
   and example user space code. ps/2 keybd is multiplexed through this driver
 
-To do:
+To do
+=====
+
 - UCB1200 audio with new ucb_generic layer
 - everything else!  :-)
 
-Notes:
+Notes
+=====
 
 - The flash on board is divided into 3 partitions.  mtd0 is where
   the ADS boot ROM and zImage is stored.  It's been marked as
@@ -95,4 +100,3 @@ Notes:
   fixed soon.
 
 Any contribution can be sent to nico@fluxnic.net and will be greatly welcome!
-
diff --git a/Documentation/arm/SA1100/GraphicsMaster b/Documentation/arm/SA1100/GraphicsMaster
index 9145088a0ba2..e39892514f0c 100644
--- a/Documentation/arm/SA1100/GraphicsMaster
+++ b/Documentation/arm/SA1100/GraphicsMaster
@@ -1,4 +1,6 @@
+========================================
 ADS GraphicsMaster Single Board Computer
+========================================
 
 For more details, contact Applied Data Systems or see
 http://www.applieddata.net/products.html
@@ -15,7 +17,9 @@ The kernel zImage is linked to be loaded and executed at 0xc0400000.
 Linux can  be used with the ADS BootLoader that ships with the
 newer rev boards. See their documentation on how to load Linux.
 
-Supported peripherals:
+Supported peripherals
+=====================
+
 - SA1100 LCD frame buffer (8/16bpp...sort of)
 - SA1111 USB Master
 - on-board SMC 92C96 ethernet NIC
@@ -31,10 +35,13 @@ Supported peripherals:
   See http://www.eurotech-inc.com/linux-sbc.asp for IOCTL documentation
   and example user space code. ps/2 keybd is multiplexed through this driver
 
-To do:
+To do
+=====
+
 - everything else!  :-)
 
-Notes:
+Notes
+=====
 
 - The flash on board is divided into 3 partitions.  mtd0 is where
   the zImage is stored.  It's been marked as read-only to keep you
diff --git a/Documentation/arm/SA1100/HUW_WEBPANEL b/Documentation/arm/SA1100/HUW_WEBPANEL
index fd56b48d4833..1dc7ccb165f0 100644
--- a/Documentation/arm/SA1100/HUW_WEBPANEL
+++ b/Documentation/arm/SA1100/HUW_WEBPANEL
@@ -1,9 +1,14 @@
+=======================
+Hoeft & Wessel Webpanel
+=======================
+
 The HUW_WEBPANEL is a product of the german company Hoeft & Wessel AG
 
 If you want more information, please visit
 http://www.hoeft-wessel.de
 
-To build the kernel:
+To build the kernel::
+
 	make huw_webpanel_config
 	make oldconfig
 	[accept all defaults]
@@ -14,4 +19,3 @@ Roman Jordan         jor@hoeft-wessel.de
 Christoph Schulz    schu@hoeft-wessel.de
 
 2000/12/18/
-
diff --git a/Documentation/arm/SA1100/Itsy b/Documentation/arm/SA1100/Itsy
index 44b94997fa0d..f49896ba3ef1 100644
--- a/Documentation/arm/SA1100/Itsy
+++ b/Documentation/arm/SA1100/Itsy
@@ -1,3 +1,7 @@
+====
+Itsy
+====
+
 Itsy is a research project done by the Western Research Lab, and Systems
 Research Center in Palo Alto, CA. The Itsy project is one of several
 research projects at Compaq that are related to pocket computing.
@@ -7,6 +11,7 @@ For more information, see:
 	http://www.hpl.hp.com/downloads/crl/itsy/
 
 Notes on initial 2.4 Itsy support (8/27/2000) :
+
 The port was done on an Itsy version 1.5 machine with a daughtercard with
 64 Meg of DRAM and 32 Meg of Flash. The initial work includes support for
 serial console (to see what you're doing).  No other devices have been
@@ -18,8 +23,10 @@ Finally, you will need to cd to arch/arm/boot/tools and execute a make there
 to build the params-itsy program used to boot the kernel.
 
 In order to install the port of 2.4 to the itsy, You will need to set the
-configuration parameters in the monitor as follows:
-Arg 1:0x08340000, Arg2: 0xC0000000, Arg3:18 (0x12), Arg4:0
+configuration parameters in the monitor as follows::
+
+	Arg 1:0x08340000, Arg2: 0xC0000000, Arg3:18 (0x12), Arg4:0
+
 Make sure the start-routine address is set to 0x00060000.
 
 Next, flash the params-itsy program to 0x00060000 ("p 1 0x00060000" in the
@@ -29,7 +36,8 @@ flash menu)  Flash the kernel in arch/arm/boot/zImage into 0x08340000
 handhelds.org.
 
 The serial connection we established was at:
- 8-bit data, no parity, 1 stop bit(s), 115200.00 b/s. in the monitor, in the
+
+8-bit data, no parity, 1 stop bit(s), 115200.00 b/s. in the monitor, in the
 params-itsy program, and in the kernel itself.  This can be changed, but
 not easily. The monitor parameters are easily changed, the params program
 setup is assembly outl's, and the kernel is a configuration item specific to
diff --git a/Documentation/arm/SA1100/LART b/Documentation/arm/SA1100/LART
index 6d412b685598..94c0568d1095 100644
--- a/Documentation/arm/SA1100/LART
+++ b/Documentation/arm/SA1100/LART
@@ -1,5 +1,6 @@
+====================================
 Linux Advanced Radio Terminal (LART)
-------------------------------------
+====================================
 
 The LART is a small (7.5 x 10cm) SA-1100 board, designed for embedded
 applications. It has 32 MB DRAM, 4MB Flash ROM, double RS232 and all
diff --git a/Documentation/arm/SA1100/PLEB b/Documentation/arm/SA1100/PLEB
index b9c8a631a351..d5b732967aa3 100644
--- a/Documentation/arm/SA1100/PLEB
+++ b/Documentation/arm/SA1100/PLEB
@@ -1,3 +1,7 @@
+====
+PLEB
+====
+
 The PLEB project was started as a student initiative at the School of
 Computer Science and Engineering, University of New South Wales to make a
 pocket computer capable of running the Linux Kernel.
@@ -7,5 +11,3 @@ PLEB support has yet to be fully integrated.
 For more information, see:
 
 	http://www.cse.unsw.edu.au
-
-
diff --git a/Documentation/arm/SA1100/Pangolin b/Documentation/arm/SA1100/Pangolin
index 077a6120e129..f0c5c1618553 100644
--- a/Documentation/arm/SA1100/Pangolin
+++ b/Documentation/arm/SA1100/Pangolin
@@ -1,16 +1,22 @@
+========
+Pangolin
+========
+
 Pangolin is a StrongARM 1110-based evaluation platform produced
 by Dialogue Technology (http://www.dialogue.com.tw/).
 It has EISA slots for ease of configuration with SDRAM/Flash
 memory card, USB/Serial/Audio card, Compact Flash card,
 PCMCIA/IDE card and TFT-LCD card.
 
-To compile for Pangolin, you must issue the following commands:
+To compile for Pangolin, you must issue the following commands::
 
 	make pangolin_config
 	make oldconfig
 	make zImage
 
-Supported peripherals:
+Supported peripherals
+=====================
+
 - SA1110 serial port (UART1/UART2/UART3)
 - flash memory access
 - compact flash driver
diff --git a/Documentation/arm/SA1100/Tifon b/Documentation/arm/SA1100/Tifon
index dd1934d9c851..c26e910b9ea7 100644
--- a/Documentation/arm/SA1100/Tifon
+++ b/Documentation/arm/SA1100/Tifon
@@ -1,7 +1,7 @@
+=====
 Tifon
------
+=====
 
 More info has to come...
 
 Contact: Peter Danielsson <peter.danielsson@era-t.ericsson.se>
-
diff --git a/Documentation/arm/SA1100/Yopy b/Documentation/arm/SA1100/Yopy
index e14f16d836ac..5b35a5f61a44 100644
--- a/Documentation/arm/SA1100/Yopy
+++ b/Documentation/arm/SA1100/Yopy
@@ -1,2 +1,5 @@
-See http://www.yopydeveloper.org for more.
+====
+Yopy
+====
 
+See http://www.yopydeveloper.org for more.
diff --git a/Documentation/arm/SA1100/empeg b/Documentation/arm/SA1100/empeg
deleted file mode 100644
index 4ece4849a42c..000000000000
--- a/Documentation/arm/SA1100/empeg
+++ /dev/null
@@ -1,2 +0,0 @@
-See ../empeg/README
-
diff --git a/Documentation/arm/SA1100/nanoEngine b/Documentation/arm/SA1100/nanoEngine
index 48a7934f95f6..47f1a14cf98a 100644
--- a/Documentation/arm/SA1100/nanoEngine
+++ b/Documentation/arm/SA1100/nanoEngine
@@ -1,11 +1,11 @@
+==========
 nanoEngine
-----------
+==========
 
-"nanoEngine" is a SA1110 based single board computer from 
+"nanoEngine" is a SA1110 based single board computer from
 Bright Star Engineering Inc.  See www.brightstareng.com/arm
 for more info.
 (Ref: Stuart Adams <sja@brightstareng.com>)
 
 Also visit Larry Doolittle's "Linux for the nanoEngine" site:
 http://www.brightstareng.com/arm/nanoeng.htm
-
diff --git a/Documentation/arm/SA1100/serial_UART b/Documentation/arm/SA1100/serial_UART
index a63966f1d083..ea983642b9be 100644
--- a/Documentation/arm/SA1100/serial_UART
+++ b/Documentation/arm/SA1100/serial_UART
@@ -1,31 +1,35 @@
-The SA1100 serial port had its major/minor numbers officially assigned:
+==================
+SA1100 serial port
+==================
 
-> Date: Sun, 24 Sep 2000 21:40:27 -0700
-> From: H. Peter Anvin <hpa@transmeta.com>
-> To: Nicolas Pitre <nico@CAM.ORG>
-> Cc: Device List Maintainer <device@lanana.org>
-> Subject: Re: device
-> 
-> Okay.  Note that device numbers 204 and 205 are used for "low density
-> serial devices", so you will have a range of minors on those majors (the
-> tty device layer handles this just fine, so you don't have to worry about
-> doing anything special.)
-> 
-> So your assignments are:
-> 
-> 204 char        Low-density serial ports
->                   5 = /dev/ttySA0               SA1100 builtin serial port 0
->                   6 = /dev/ttySA1               SA1100 builtin serial port 1
->                   7 = /dev/ttySA2               SA1100 builtin serial port 2
-> 
-> 205 char        Low-density serial ports (alternate device)
->                   5 = /dev/cusa0                Callout device for ttySA0
->                   6 = /dev/cusa1                Callout device for ttySA1
->                   7 = /dev/cusa2                Callout device for ttySA2
->
+The SA1100 serial port had its major/minor numbers officially assigned::
+
+  > Date: Sun, 24 Sep 2000 21:40:27 -0700
+  > From: H. Peter Anvin <hpa@transmeta.com>
+  > To: Nicolas Pitre <nico@CAM.ORG>
+  > Cc: Device List Maintainer <device@lanana.org>
+  > Subject: Re: device
+  >
+  > Okay.  Note that device numbers 204 and 205 are used for "low density
+  > serial devices", so you will have a range of minors on those majors (the
+  > tty device layer handles this just fine, so you don't have to worry about
+  > doing anything special.)
+  >
+  > So your assignments are:
+  >
+  > 204 char        Low-density serial ports
+  >                   5 = /dev/ttySA0               SA1100 builtin serial port 0
+  >                   6 = /dev/ttySA1               SA1100 builtin serial port 1
+  >                   7 = /dev/ttySA2               SA1100 builtin serial port 2
+  >
+  > 205 char        Low-density serial ports (alternate device)
+  >                   5 = /dev/cusa0                Callout device for ttySA0
+  >                   6 = /dev/cusa1                Callout device for ttySA1
+  >                   7 = /dev/cusa2                Callout device for ttySA2
+  >
 
 You must create those inodes in /dev on the root filesystem used
-by your SA1100-based device:
+by your SA1100-based device::
 
 	mknod ttySA0 c 204 5
 	mknod ttySA1 c 204 6
@@ -37,11 +41,11 @@ by your SA1100-based device:
 In addition to the creation of the appropriate device nodes above, you
 must ensure your user space applications make use of the correct device
 name. The classic example is the content of the /etc/inittab file where
-you might have a getty process started on ttyS0.  In this case:
+you might have a getty process started on ttyS0.
+
+In this case:
 
 - replace occurrences of ttyS0 with ttySA0, ttyS1 with ttySA1, etc.
 
 - don't forget to add 'ttySA0', 'console', or the appropriate tty name
   in /etc/securetty for root to be allowed to login as well.
-
-
diff --git a/Documentation/arm/SPEAr/overview.txt b/Documentation/arm/SPEAr/overview.txt
index 1b049be6c84f..8a1a87aca427 100644
--- a/Documentation/arm/SPEAr/overview.txt
+++ b/Documentation/arm/SPEAr/overview.txt
@@ -1,5 +1,6 @@
-			SPEAr ARM Linux Overview
-			==========================
+========================
+SPEAr ARM Linux Overview
+========================
 
 Introduction
 ------------
@@ -30,17 +31,18 @@ Introduction
 		- SPEAr1340 (SOC)
 			- SPEAr1340 Evaluation Board
 
-  Configuration
-  -------------
+Configuration
+-------------
 
   A generic configuration is provided for each machine, and can be used as the
-  default by
+  default by::
+
 	make spear13xx_defconfig
 	make spear3xx_defconfig
 	make spear6xx_defconfig
 
-  Layout
-  ------
+Layout
+------
 
   The common files for multiple machine families (SPEAr3xx, SPEAr6xx and
   SPEAr13xx) are located in the platform code contained in arch/arm/plat-spear
@@ -57,7 +59,7 @@ Introduction
   support Flattened Device Tree.
 
 
-  Document Author
-  ---------------
+Document Author
+---------------
 
   Viresh Kumar <vireshk@kernel.org>, (c) 2010-2012 ST Microelectronics
diff --git a/Documentation/arm/Samsung-S3C24XX/CPUfreq.txt b/Documentation/arm/Samsung-S3C24XX/CPUfreq.txt
index fa968aa99d67..2ddc26c03b1f 100644
--- a/Documentation/arm/Samsung-S3C24XX/CPUfreq.txt
+++ b/Documentation/arm/Samsung-S3C24XX/CPUfreq.txt
@@ -1,5 +1,6 @@
-		S3C24XX CPUfreq support
-		=======================
+=======================
+S3C24XX CPUfreq support
+=======================
 
 Introduction
 ------------
diff --git a/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt b/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt
index b87292e05f2f..7863c93652f8 100644
--- a/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt
+++ b/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt
@@ -1,5 +1,6 @@
-		Simtec Electronics EB2410ITX (BAST)
-		===================================
+===================================
+Simtec Electronics EB2410ITX (BAST)
+===================================
 
 	http://www.simtec.co.uk/products/EB2410ITX/
 
diff --git a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
index e8f918b96123..021930591ace 100644
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
@@ -1,5 +1,6 @@
-			S3C24XX GPIO Control
-			====================
+====================
+S3C24XX GPIO Control
+====================
 
 Introduction
 ------------
@@ -26,16 +27,16 @@ GPIOLIB
   listed below will be removed (they may be marked as __deprecated
   in the near future).
 
-  The following functions now either have a s3c_ specific variant
+  The following functions now either have a `s3c_` specific variant
   or are merged into gpiolib. See the definitions in
   arch/arm/plat-samsung/include/plat/gpio-cfg.h:
 
-  s3c2410_gpio_setpin()		gpio_set_value() or gpio_direction_output()
-  s3c2410_gpio_getpin()		gpio_get_value() or gpio_direction_input()
-  s3c2410_gpio_getirq()		gpio_to_irq()
-  s3c2410_gpio_cfgpin()		s3c_gpio_cfgpin()
-  s3c2410_gpio_getcfg()		s3c_gpio_getcfg()
-  s3c2410_gpio_pullup()		s3c_gpio_setpull()
+  - s3c2410_gpio_setpin()	gpio_set_value() or gpio_direction_output()
+  - s3c2410_gpio_getpin()	gpio_get_value() or gpio_direction_input()
+  - s3c2410_gpio_getirq()	gpio_to_irq()
+  - s3c2410_gpio_cfgpin()	s3c_gpio_cfgpin()
+  - s3c2410_gpio_getcfg()	s3c_gpio_getcfg()
+  - s3c2410_gpio_pullup()	s3c_gpio_setpull()
 
 
 GPIOLIB conversion
@@ -77,7 +78,7 @@ out s3c2410 API, then here are some notes on the process.
 6) s3c2410_gpio_getirq() should be directly replaceable with the
    gpio_to_irq() call.
 
-The s3c2410_gpio and gpio_ calls have always operated on the same gpio
+The s3c2410_gpio and `gpio_` calls have always operated on the same gpio
 numberspace, so there is no problem with converting the gpio numbering
 between the calls.
 
diff --git a/Documentation/arm/Samsung-S3C24XX/H1940.txt b/Documentation/arm/Samsung-S3C24XX/H1940.txt
index b738859b1fc0..62a562c178e3 100644
--- a/Documentation/arm/Samsung-S3C24XX/H1940.txt
+++ b/Documentation/arm/Samsung-S3C24XX/H1940.txt
@@ -1,5 +1,6 @@
-		HP IPAQ H1940
-		=============
+=============
+HP IPAQ H1940
+=============
 
 http://www.handhelds.org/projects/h1940.html
 
diff --git a/Documentation/arm/Samsung-S3C24XX/NAND.txt b/Documentation/arm/Samsung-S3C24XX/NAND.txt
index bc478a3409b8..938995694ee7 100644
--- a/Documentation/arm/Samsung-S3C24XX/NAND.txt
+++ b/Documentation/arm/Samsung-S3C24XX/NAND.txt
@@ -1,5 +1,6 @@
-			S3C24XX NAND Support
-			====================
+====================
+S3C24XX NAND Support
+====================
 
 Introduction
 ------------
@@ -27,4 +28,3 @@ Document Author
 ---------------
 
 Ben Dooks, Copyright 2007 Simtec Electronics
-
diff --git a/Documentation/arm/Samsung-S3C24XX/Overview.txt b/Documentation/arm/Samsung-S3C24XX/Overview.txt
index 00d3c3141e21..0d8e59df7512 100644
--- a/Documentation/arm/Samsung-S3C24XX/Overview.txt
+++ b/Documentation/arm/Samsung-S3C24XX/Overview.txt
@@ -1,5 +1,6 @@
-			S3C24XX ARM Linux Overview
-			==========================
+==========================
+S3C24XX ARM Linux Overview
+==========================
 
 
 
@@ -276,18 +277,18 @@ Platform Data
        kmalloc()s an area of memory, and copies the __initdata
        and then sets the relevant device's platform data. Making
        the function `__init` takes care of ensuring it is discarded
-       with the rest of the initialisation code
+       with the rest of the initialisation code::
 
-       static __init void s3c24xx_xxx_set_platdata(struct xxx_data *pd)
-       {
-           struct s3c2410_xxx_mach_info *npd;
+         static __init void s3c24xx_xxx_set_platdata(struct xxx_data *pd)
+         {
+             struct s3c2410_xxx_mach_info *npd;
 
 	   npd = kmalloc(sizeof(struct s3c2410_xxx_mach_info), GFP_KERNEL);
 	   if (npd) {
 	      memcpy(npd, pd, sizeof(struct s3c2410_xxx_mach_info));
 	      s3c_device_xxx.dev.platform_data = npd;
 	   } else {
-              printk(KERN_ERR "no memory for xxx platform data\n");
+                printk(KERN_ERR "no memory for xxx platform data\n");
 	   }
 	}
 
diff --git a/Documentation/arm/Samsung-S3C24XX/S3C2412.txt b/Documentation/arm/Samsung-S3C24XX/S3C2412.txt
index dc1fd362d3c1..68b985fc6bf4 100644
--- a/Documentation/arm/Samsung-S3C24XX/S3C2412.txt
+++ b/Documentation/arm/Samsung-S3C24XX/S3C2412.txt
@@ -1,5 +1,6 @@
-		S3C2412 ARM Linux Overview
-		==========================
+==========================
+S3C2412 ARM Linux Overview
+==========================
 
 Introduction
 ------------
diff --git a/Documentation/arm/Samsung-S3C24XX/S3C2413.txt b/Documentation/arm/Samsung-S3C24XX/S3C2413.txt
index 909bdc7dd7b5..1f51e207fc46 100644
--- a/Documentation/arm/Samsung-S3C24XX/S3C2413.txt
+++ b/Documentation/arm/Samsung-S3C24XX/S3C2413.txt
@@ -1,5 +1,6 @@
-		S3C2413 ARM Linux Overview
-		==========================
+==========================
+S3C2413 ARM Linux Overview
+==========================
 
 Introduction
 ------------
@@ -10,7 +11,7 @@ Introduction
 
 
 Camera Interface
----------------
+----------------
 
   This block is currently not supported.
 
diff --git a/Documentation/arm/Samsung-S3C24XX/SMDK2440.txt b/Documentation/arm/Samsung-S3C24XX/SMDK2440.txt
index 429390bd4684..524fd0b4afaf 100644
--- a/Documentation/arm/Samsung-S3C24XX/SMDK2440.txt
+++ b/Documentation/arm/Samsung-S3C24XX/SMDK2440.txt
@@ -1,5 +1,6 @@
-		Samsung/Meritech SMDK2440
-		=========================
+=========================
+Samsung/Meritech SMDK2440
+=========================
 
 Introduction
 ------------
diff --git a/Documentation/arm/Samsung-S3C24XX/Suspend.txt b/Documentation/arm/Samsung-S3C24XX/Suspend.txt
index cb4f0c0cdf9d..b4f3ae9fe76e 100644
--- a/Documentation/arm/Samsung-S3C24XX/Suspend.txt
+++ b/Documentation/arm/Samsung-S3C24XX/Suspend.txt
@@ -1,5 +1,6 @@
-			S3C24XX Suspend Support
-			=======================
+=======================
+S3C24XX Suspend Support
+=======================
 
 
 Introduction
@@ -57,16 +58,16 @@ Machine Support
   and will end up initialising all compiled machines' pm init!
 
   The following is an example of code used for testing wakeup from
-  an falling edge on IRQ_EINT0:
+  an falling edge on IRQ_EINT0::
 
 
-static irqreturn_t button_irq(int irq, void *pw)
-{
+    static irqreturn_t button_irq(int irq, void *pw)
+    {
 	return IRQ_HANDLED;
-}
+    }
 
-statuc void __init machine_init(void)
-{
+    statuc void __init machine_init(void)
+    {
 	...
 
 	request_irq(IRQ_EINT0, button_irq, IRQF_TRIGGER_FALLING,
@@ -75,7 +76,7 @@ statuc void __init machine_init(void)
 	enable_irq_wake(IRQ_EINT0);
 
 	s3c_pm_init();
-}
+    }
 
 
 Debugging
@@ -134,4 +135,3 @@ Document Author
 ---------------
 
 Ben Dooks, Copyright 2004 Simtec Electronics
-
diff --git a/Documentation/arm/Samsung-S3C24XX/USB-Host.txt b/Documentation/arm/Samsung-S3C24XX/USB-Host.txt
index f82b1faefad5..c84268bd1884 100644
--- a/Documentation/arm/Samsung-S3C24XX/USB-Host.txt
+++ b/Documentation/arm/Samsung-S3C24XX/USB-Host.txt
@@ -1,5 +1,6 @@
-			S3C24XX USB Host support
-			========================
+========================
+S3C24XX USB Host support
+========================
 
 
 
@@ -13,7 +14,7 @@ Configuration
 
   Enable at least the following kernel options:
 
-  menuconfig:
+  menuconfig::
 
    Device Drivers  --->
      USB support  --->
@@ -22,8 +23,9 @@ Configuration
 
 
   .config:
-    CONFIG_USB
-    CONFIG_USB_OHCI_HCD
+
+    - CONFIG_USB
+    - CONFIG_USB_OHCI_HCD
 
 
   Once these options are configured, the standard set of USB device
@@ -60,17 +62,14 @@ Platform Data
   The ports are numbered 0 and 1.
 
   power_control:
-
     Called to enable or disable the power on the port.
 
   enable_oc:
-
     Called to enable or disable the over-current monitoring.
     This should claim or release the resources being used to
     check the power condition on the port, such as an IRQ.
 
   report_oc:
-
     The OHCI driver fills this field in for the over-current code
     to call when there is a change to the over-current state on
     an port. The ports argument is a bitmask of 1 bit per port,
@@ -80,7 +79,6 @@ Platform Data
     ensure this is called correctly.
 
   port[x]:
-
     This is struct describes each port, 0 or 1. The platform driver
     should set the flags field of each port to S3C_HCDFLG_USED if
     the port is enabled.
diff --git a/Documentation/arm/Samsung/Bootloader-interface.txt b/Documentation/arm/Samsung/Bootloader-interface.txt
index d17ed518a7ea..a56f325dae78 100644
--- a/Documentation/arm/Samsung/Bootloader-interface.txt
+++ b/Documentation/arm/Samsung/Bootloader-interface.txt
@@ -1,7 +1,9 @@
-      Interface between kernel and boot loaders on Exynos boards
-      ==========================================================
+==========================================================
+Interface between kernel and boot loaders on Exynos boards
+==========================================================
 
 Author: Krzysztof Kozlowski
+
 Date  : 6 June 2015
 
 The document tries to describe currently used interface between Linux kernel
@@ -17,8 +19,10 @@ executing kernel.
 1. Non-Secure mode
 
 Address:      sysram_ns_base_addr
+
+============= ============================================ ==================
 Offset        Value                                        Purpose
-=============================================================================
+============= ============================================ ==================
 0x08          exynos_cpu_resume_ns, mcpm_entry_point       System suspend
 0x0c          0x00000bad (Magic cookie)                    System suspend
 0x1c          exynos4_secondary_startup                    Secondary CPU boot
@@ -27,22 +31,28 @@ Offset        Value                                        Purpose
 0x24          exynos_cpu_resume_ns                         AFTR
 0x28 + 4*cpu  0x8 (Magic cookie, Exynos3250)               AFTR
 0x28          0x0 or last value during resume (Exynos542x) System suspend
+============= ============================================ ==================
 
 
 2. Secure mode
 
 Address:      sysram_base_addr
+
+============= ============================================ ==================
 Offset        Value                                        Purpose
-=============================================================================
+============= ============================================ ==================
 0x00          exynos4_secondary_startup                    Secondary CPU boot
 0x04          exynos4_secondary_startup (Exynos542x)       Secondary CPU boot
 4*cpu         exynos4_secondary_startup (Exynos4412)       Secondary CPU boot
 0x20          exynos_cpu_resume (Exynos4210 r1.0)          AFTR
 0x24          0xfcba0d10 (Magic cookie, Exynos4210 r1.0)   AFTR
+============= ============================================ ==================
 
 Address:      pmu_base_addr
+
+============= ============================================ ==================
 Offset        Value                                        Purpose
-=============================================================================
+============= ============================================ ==================
 0x0800        exynos_cpu_resume                            AFTR, suspend
 0x0800        mcpm_entry_point (Exynos542x with MCPM)      AFTR, suspend
 0x0804        0xfcba0d10 (Magic cookie)                    AFTR
@@ -50,15 +60,18 @@ Offset        Value                                        Purpose
 0x0814        exynos4_secondary_startup (Exynos4210 r1.1)  Secondary CPU boot
 0x0818        0xfcba0d10 (Magic cookie, Exynos4210 r1.1)   AFTR
 0x081C        exynos_cpu_resume (Exynos4210 r1.1)          AFTR
-
+============= ============================================ ==================
 
 3. Other (regardless of secure/non-secure mode)
 
 Address:      pmu_base_addr
+
+============= =============================== ===============================
 Offset        Value                           Purpose
-=============================================================================
+============= =============================== ===============================
 0x0908        Non-zero                        Secondary CPU boot up indicator
                                               on Exynos3250 and Exynos542x
+============= =============================== ===============================
 
 
 4. Glossary
diff --git a/Documentation/arm/Samsung/GPIO.txt b/Documentation/arm/Samsung/GPIO.txt
index 795adfd88081..37f991f8076d 100644
--- a/Documentation/arm/Samsung/GPIO.txt
+++ b/Documentation/arm/Samsung/GPIO.txt
@@ -1,5 +1,6 @@
-		Samsung GPIO implementation
-		===========================
+===========================
+Samsung GPIO implementation
+===========================
 
 Introduction
 ------------
diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
index 8f7309bad460..98164270ae40 100644
--- a/Documentation/arm/Samsung/Overview.txt
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -1,5 +1,6 @@
-		Samsung ARM Linux Overview
-		==========================
+==========================
+Samsung ARM Linux Overview
+==========================
 
 Introduction
 ------------
@@ -32,8 +33,10 @@ Configuration
   A number of configurations are supplied, as there is no current way of
   unifying all the SoCs into one kernel.
 
-  s5pc110_defconfig - S5PC110 specific default configuration
-  s5pv210_defconfig - S5PV210 specific default configuration
+  s5pc110_defconfig
+	- S5PC110 specific default configuration
+  s5pv210_defconfig
+	- S5PV210 specific default configuration
 
 
 Layout
diff --git a/Documentation/arm/Setup b/Documentation/arm/Setup
index 0cb1e64bde80..8e12ef3fb9a7 100644
--- a/Documentation/arm/Setup
+++ b/Documentation/arm/Setup
@@ -1,5 +1,6 @@
+=============================================
 Kernel initialisation parameters on ARM Linux
----------------------------------------------
+=============================================
 
 The following document describes the kernel initialisation parameter
 structure, otherwise known as 'struct param_struct' which is used
@@ -14,12 +15,10 @@ There are a lot of parameters listed in there, and they are described
 below:
 
  page_size
-
    This parameter must be set to the page size of the machine, and
    will be checked by the kernel.
 
  nr_pages
-
    This is the total number of pages of memory in the system.  If
    the memory is banked, then this should contain the total number
    of pages in the system.
@@ -28,24 +27,22 @@ below:
    include this information.
 
  ramdisk_size
-
    This is now obsolete, and should not be used.
 
  flags
-
    Various kernel flags, including:
-    bit 0 - 1 = mount root read only
-    bit 1 - unused
-    bit 2 - 0 = load ramdisk
-    bit 3 - 0 = prompt for ramdisk
+
+    =====   ========================
+    bit 0   1 = mount root read only
+    bit 1   unused
+    bit 2   0 = load ramdisk
+    bit 3   0 = prompt for ramdisk
+    =====   ========================
 
  rootdev
-
    major/minor number pair of device to mount as the root filesystem.
 
- video_num_cols
- video_num_rows
-
+ video_num_cols / video_num_rows
    These two together describe the character size of the dummy console,
    or VGA console character size.  They should not be used for any other
    purpose.
@@ -54,66 +51,50 @@ below:
    the equivalent character size of your fbcon display.  This then allows
    all the bootup messages to be displayed correctly.
 
- video_x
- video_y
-
+ video_x / video_y
    This describes the character position of cursor on VGA console, and
    is otherwise unused. (should not be used for other console types, and
    should not be used for other purposes).
 
  memc_control_reg
-
    MEMC chip control register for Acorn Archimedes and Acorn A5000
    based machines.  May be used differently by different architectures.
 
  sounddefault
-
    Default sound setting on Acorn machines.  May be used differently by
    different architectures.
 
  adfsdrives
-
    Number of ADFS/MFM disks.  May be used differently by different
    architectures.
 
- bytes_per_char_h
- bytes_per_char_v
-
+ bytes_per_char_h / bytes_per_char_v
    These are now obsolete, and should not be used.
 
  pages_in_bank[4]
-
    Number of pages in each bank of the systems memory (used for RiscPC).
    This is intended to be used on systems where the physical memory
    is non-contiguous from the processors point of view.
 
  pages_in_vram
-
    Number of pages in VRAM (used on Acorn RiscPC).  This value may also
    be used by loaders if the size of the video RAM can't be obtained
    from the hardware.
 
- initrd_start
- initrd_size
-
+ initrd_start / initrd_size
    This describes the kernel virtual start address and size of the
    initial ramdisk.
 
  rd_start
-
    Start address in sectors of the ramdisk image on a floppy disk.
 
  system_rev
-
    system revision number.
 
- system_serial_low
- system_serial_high
-
+ system_serial_low / system_serial_high
    system 64-bit serial number
 
  mem_fclk_21285
-
    The speed of the external oscillator to the 21285 (footbridge),
    which control's the speed of the memory bus, timer & serial port.
    Depending upon the speed of the cpu its value can be between
@@ -121,9 +102,7 @@ below:
    then a value of 50 Mhz is the default on 21285 architectures.
 
  paths[8][128]
-
    These are now obsolete, and should not be used.
 
  commandline
-
    Kernel command line parameters.  Details can be found elsewhere.
diff --git a/Documentation/arm/VFP/release-notes.txt b/Documentation/arm/VFP/release-notes.txt
index 28a2795705ca..c6b04937cee3 100644
--- a/Documentation/arm/VFP/release-notes.txt
+++ b/Documentation/arm/VFP/release-notes.txt
@@ -1,7 +1,9 @@
+===============================================
 Release notes for Linux Kernel VFP support code
------------------------------------------------
+===============================================
 
 Date: 	20 May 2004
+
 Author:	Russell King
 
 This is the first release of the Linux Kernel VFP support code.  It
diff --git a/Documentation/arm/cluster-pm-race-avoidance.txt b/Documentation/arm/cluster-pm-race-avoidance.txt
index 750b6fc24af9..aa58603d3f28 100644
--- a/Documentation/arm/cluster-pm-race-avoidance.txt
+++ b/Documentation/arm/cluster-pm-race-avoidance.txt
@@ -1,3 +1,4 @@
+=========================================================
 Cluster-wide Power-up/power-down race avoidance algorithm
 =========================================================
 
@@ -46,10 +47,12 @@ Basic model
 
 Each cluster and CPU is assigned a state, as follows:
 
-	DOWN
-	COMING_UP
-	UP
-	GOING_DOWN
+	- DOWN
+	- COMING_UP
+	- UP
+	- GOING_DOWN
+
+::
 
 	    +---------> UP ----------+
 	    |                        v
@@ -60,18 +63,22 @@ Each cluster and CPU is assigned a state, as follows:
 	    +--------- DOWN <--------+
 
 
-DOWN:	The CPU or cluster is not coherent, and is either powered off or
+DOWN:
+	The CPU or cluster is not coherent, and is either powered off or
 	suspended, or is ready to be powered off or suspended.
 
-COMING_UP: The CPU or cluster has committed to moving to the UP state.
+COMING_UP:
+	The CPU or cluster has committed to moving to the UP state.
 	It may be part way through the process of initialisation and
 	enabling coherency.
 
-UP:	The CPU or cluster is active and coherent at the hardware
+UP:
+	The CPU or cluster is active and coherent at the hardware
 	level.  A CPU in this state is not necessarily being used
 	actively by the kernel.
 
-GOING_DOWN: The CPU or cluster has committed to moving to the DOWN
+GOING_DOWN:
+	The CPU or cluster has committed to moving to the DOWN
 	state.  It may be part way through the process of teardown and
 	coherency exit.
 
@@ -86,8 +93,8 @@ CPUs in the cluster simultaneously modifying the state.  The cluster-
 level states are described in the "Cluster state" section.
 
 To help distinguish the CPU states from cluster states in this
-discussion, the state names are given a CPU_ prefix for the CPU states,
-and a CLUSTER_ or INBOUND_ prefix for the cluster states.
+discussion, the state names are given a `CPU_` prefix for the CPU states,
+and a `CLUSTER_` or `INBOUND_` prefix for the cluster states.
 
 
 CPU state
@@ -101,10 +108,12 @@ This means that CPUs fit the basic model closely.
 
 The algorithm defines the following states for each CPU in the system:
 
-	CPU_DOWN
-	CPU_COMING_UP
-	CPU_UP
-	CPU_GOING_DOWN
+	- CPU_DOWN
+	- CPU_COMING_UP
+	- CPU_UP
+	- CPU_GOING_DOWN
+
+::
 
 	 cluster setup and
 	CPU setup complete          policy decision
@@ -130,17 +139,17 @@ requirement for any external event to happen.
 
 
 CPU_DOWN:
-
 	A CPU reaches the CPU_DOWN state when it is ready for
 	power-down.  On reaching this state, the CPU will typically
 	power itself down or suspend itself, via a WFI instruction or a
 	firmware call.
 
-	Next state:	CPU_COMING_UP
-	Conditions:	none
+	Next state:
+		CPU_COMING_UP
+	Conditions:
+		none
 
 	Trigger events:
-
 		a) an explicit hardware power-up operation, resulting
 		   from a policy decision on another CPU;
 
@@ -148,15 +157,17 @@ CPU_DOWN:
 
 
 CPU_COMING_UP:
-
 	A CPU cannot start participating in hardware coherency until the
 	cluster is set up and coherent.  If the cluster is not ready,
 	then the CPU will wait in the CPU_COMING_UP state until the
 	cluster has been set up.
 
-	Next state:	CPU_UP
-	Conditions:	The CPU's parent cluster must be in CLUSTER_UP.
-	Trigger events:	Transition of the parent cluster to CLUSTER_UP.
+	Next state:
+		CPU_UP
+	Conditions:
+		The CPU's parent cluster must be in CLUSTER_UP.
+	Trigger events:
+		Transition of the parent cluster to CLUSTER_UP.
 
 	Refer to the "Cluster state" section for a description of the
 	CLUSTER_UP state.
@@ -178,20 +189,25 @@ CPU_UP:
 	The CPU remains in this state until an explicit policy decision
 	is made to shut down or suspend the CPU.
 
-	Next state:	CPU_GOING_DOWN
-	Conditions:	none
-	Trigger events:	explicit policy decision
+	Next state:
+		CPU_GOING_DOWN
+	Conditions:
+		none
+	Trigger events:
+		explicit policy decision
 
 
 CPU_GOING_DOWN:
-
 	While in this state, the CPU exits coherency, including any
 	operations required to achieve this (such as cleaning data
 	caches).
 
-	Next state:	CPU_DOWN
-	Conditions:	local CPU teardown complete
-	Trigger events:	(spontaneous)
+	Next state:
+		CPU_DOWN
+	Conditions:
+		local CPU teardown complete
+	Trigger events:
+		(spontaneous)
 
 
 Cluster state
@@ -212,20 +228,20 @@ independently of the CPU which is tearing down the cluster.  For this
 reason, the cluster state is split into two parts:
 
 	"cluster" state: The global state of the cluster; or the state
-		on the outbound side:
+	on the outbound side:
 
-		CLUSTER_DOWN
-		CLUSTER_UP
-		CLUSTER_GOING_DOWN
+		- CLUSTER_DOWN
+		- CLUSTER_UP
+		- CLUSTER_GOING_DOWN
 
 	"inbound" state: The state of the cluster on the inbound side.
 
-		INBOUND_NOT_COMING_UP
-		INBOUND_COMING_UP
+		- INBOUND_NOT_COMING_UP
+		- INBOUND_COMING_UP
 
 
 	The different pairings of these states results in six possible
-	states for the cluster as a whole:
+	states for the cluster as a whole::
 
 	                            CLUSTER_UP
 	          +==========> INBOUND_NOT_COMING_UP -------------+
@@ -284,11 +300,12 @@ reason, the cluster state is split into two parts:
 
 
 CLUSTER_DOWN/INBOUND_NOT_COMING_UP:
+	Next state:
+		CLUSTER_DOWN/INBOUND_COMING_UP (inbound)
+	Conditions:
+		none
 
-	Next state:	CLUSTER_DOWN/INBOUND_COMING_UP (inbound)
-	Conditions:	none
 	Trigger events:
-
 		a) an explicit hardware power-up operation, resulting
 		   from a policy decision on another CPU;
 
@@ -306,9 +323,12 @@ CLUSTER_DOWN/INBOUND_COMING_UP:
 	setup to enable other CPUs in the cluster to enter coherency
 	safely.
 
-	Next state:	CLUSTER_UP/INBOUND_COMING_UP (inbound)
-	Conditions:	cluster-level setup and hardware coherency complete
-	Trigger events:	(spontaneous)
+	Next state:
+		CLUSTER_UP/INBOUND_COMING_UP (inbound)
+	Conditions:
+		cluster-level setup and hardware coherency complete
+	Trigger events:
+		(spontaneous)
 
 
 CLUSTER_UP/INBOUND_COMING_UP:
@@ -321,9 +341,12 @@ CLUSTER_UP/INBOUND_COMING_UP:
 	CLUSTER_UP/INBOUND_NOT_COMING_UP.  All other CPUs on the cluster
 	should consider treat these two states as equivalent.
 
-	Next state:	CLUSTER_UP/INBOUND_NOT_COMING_UP (inbound)
-	Conditions:	none
-	Trigger events:	(spontaneous)
+	Next state:
+		CLUSTER_UP/INBOUND_NOT_COMING_UP (inbound)
+	Conditions:
+		none
+	Trigger events:
+		(spontaneous)
 
 
 CLUSTER_UP/INBOUND_NOT_COMING_UP:
@@ -335,9 +358,12 @@ CLUSTER_UP/INBOUND_NOT_COMING_UP:
 	The cluster will remain in this state until a policy decision is
 	made to power the cluster down.
 
-	Next state:	CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP (outbound)
-	Conditions:	none
-	Trigger events:	policy decision to power down the cluster
+	Next state:
+		CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP (outbound)
+	Conditions:
+		none
+	Trigger events:
+		policy decision to power down the cluster
 
 
 CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP:
@@ -359,13 +385,16 @@ CLUSTER_GOING_DOWN/INBOUND_NOT_COMING_UP:
 	Next states:
 
 	CLUSTER_DOWN/INBOUND_NOT_COMING_UP (outbound)
-		Conditions:	cluster torn down and ready to power off
-		Trigger events:	(spontaneous)
+		Conditions:
+			cluster torn down and ready to power off
+		Trigger events:
+			(spontaneous)
 
 	CLUSTER_GOING_DOWN/INBOUND_COMING_UP (inbound)
-		Conditions:	none
-		Trigger events:
+		Conditions:
+			none
 
+		Trigger events:
 			a) an explicit hardware power-up operation,
 			   resulting from a policy decision on another
 			   CPU;
@@ -396,13 +425,19 @@ CLUSTER_GOING_DOWN/INBOUND_COMING_UP:
 	Next states:
 
 	CLUSTER_UP/INBOUND_COMING_UP (outbound)
-		Conditions:	cluster-level setup and hardware
+		Conditions:
+				cluster-level setup and hardware
 				coherency complete
-		Trigger events:	(spontaneous)
+
+		Trigger events:
+				(spontaneous)
 
 	CLUSTER_DOWN/INBOUND_COMING_UP (outbound)
-		Conditions:	cluster torn down and ready to power off
-		Trigger events:	(spontaneous)
+		Conditions:
+			cluster torn down and ready to power off
+
+		Trigger events:
+			(spontaneous)
 
 
 Last man and First man selection
@@ -452,30 +487,30 @@ Implementation:
 	arch/arm/common/mcpm_entry.c (everything else):
 
 	__mcpm_cpu_going_down() signals the transition of a CPU to the
-		CPU_GOING_DOWN state.
+	CPU_GOING_DOWN state.
 
 	__mcpm_cpu_down() signals the transition of a CPU to the CPU_DOWN
-		state.
+	state.
 
 	A CPU transitions to CPU_COMING_UP and then to CPU_UP via the
-		low-level power-up code in mcpm_head.S.  This could
-		involve CPU-specific setup code, but in the current
-		implementation it does not.
+	low-level power-up code in mcpm_head.S.  This could
+	involve CPU-specific setup code, but in the current
+	implementation it does not.
 
 	__mcpm_outbound_enter_critical() and __mcpm_outbound_leave_critical()
-		handle transitions from CLUSTER_UP to CLUSTER_GOING_DOWN
-		and from there to CLUSTER_DOWN or back to CLUSTER_UP (in
-		the case of an aborted cluster power-down).
+	handle transitions from CLUSTER_UP to CLUSTER_GOING_DOWN
+	and from there to CLUSTER_DOWN or back to CLUSTER_UP (in
+	the case of an aborted cluster power-down).
 
-		These functions are more complex than the __mcpm_cpu_*()
-		functions due to the extra inter-CPU coordination which
-		is needed for safe transitions at the cluster level.
+	These functions are more complex than the __mcpm_cpu_*()
+	functions due to the extra inter-CPU coordination which
+	is needed for safe transitions at the cluster level.
 
 	A cluster transitions from CLUSTER_DOWN back to CLUSTER_UP via
-		the low-level power-up code in mcpm_head.S.  This
-		typically involves platform-specific setup code,
-		provided by the platform-specific power_up_setup
-		function registered via mcpm_sync_init.
+	the low-level power-up code in mcpm_head.S.  This
+	typically involves platform-specific setup code,
+	provided by the platform-specific power_up_setup
+	function registered via mcpm_sync_init.
 
 Deep topologies:
 
diff --git a/Documentation/arm/firmware.txt b/Documentation/arm/firmware.txt
index 7f175dbb427e..efd844baec1d 100644
--- a/Documentation/arm/firmware.txt
+++ b/Documentation/arm/firmware.txt
@@ -1,5 +1,7 @@
-Interface for registering and calling firmware-specific operations for ARM.
-----
+==========================================================================
+Interface for registering and calling firmware-specific operations for ARM
+==========================================================================
+
 Written by Tomasz Figa <t.figa@samsung.com>
 
 Some boards are running with secure firmware running in TrustZone secure
@@ -9,7 +11,7 @@ operations and call them when needed.
 
 Firmware operations can be specified by filling in a struct firmware_ops
 with appropriate callbacks and then registering it with register_firmware_ops()
-function.
+function::
 
 	void register_firmware_ops(const struct firmware_ops *ops)
 
@@ -19,7 +21,7 @@ and its members can be found in arch/arm/include/asm/firmware.h header.
 There is a default, empty set of operations provided, so there is no need to
 set anything if platform does not require firmware operations.
 
-To call a firmware operation, a helper macro is provided
+To call a firmware operation, a helper macro is provided::
 
 	#define call_firmware_op(op, ...)				\
 		((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : (-ENOSYS))
@@ -28,7 +30,7 @@ the macro checks if the operation is provided and calls it or otherwise returns
 -ENOSYS to signal that given operation is not available (for example, to allow
 fallback to legacy operation).
 
-Example of registering firmware operations:
+Example of registering firmware operations::
 
 	/* board file */
 
@@ -56,7 +58,7 @@ Example of registering firmware operations:
 		register_firmware_ops(&platformX_firmware_ops);
 	}
 
-Example of using a firmware operation:
+Example of using a firmware operation::
 
 	/* some platform code, e.g. SMP initialization */
 
diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
index b9e060c5b61e..9bfb71a2a9b9 100644
--- a/Documentation/arm/kernel_mode_neon.txt
+++ b/Documentation/arm/kernel_mode_neon.txt
@@ -1,3 +1,4 @@
+================
 Kernel mode NEON
 ================
 
@@ -86,6 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
 
 Therefore, the recommended and only supported way of using NEON/VFP in the
 kernel is by adhering to the following rules:
+
 * isolate the NEON code in a separate compilation unit and compile it with
   '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
 * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
@@ -115,6 +117,7 @@ NEON intrinsics
 NEON intrinsics are also supported. However, as code using NEON intrinsics
 relies on the GCC header <arm_neon.h>, (which #includes <stdint.h>), you should
 observe the following in addition to the rules above:
+
 * Compile the unit containing the NEON intrinsics with '-ffreestanding' so GCC
   uses its builtin version of <stdint.h> (this is a C99 header which the kernel
   does not supply);
diff --git a/Documentation/arm/kernel_user_helpers.txt b/Documentation/arm/kernel_user_helpers.txt
index 5673594717cf..eb6f3d916622 100644
--- a/Documentation/arm/kernel_user_helpers.txt
+++ b/Documentation/arm/kernel_user_helpers.txt
@@ -1,3 +1,4 @@
+============================
 Kernel-provided User Helpers
 ============================
 
@@ -43,7 +44,7 @@ kuser_helper_version
 
 Location:	0xffff0ffc
 
-Reference declaration:
+Reference declaration::
 
   extern int32_t __kuser_helper_version;
 
@@ -53,17 +54,17 @@ Definition:
   running kernel.  User space may read this to determine the availability
   of a particular helper.
 
-Usage example:
+Usage example::
 
-#define __kuser_helper_version (*(int32_t *)0xffff0ffc)
+  #define __kuser_helper_version (*(int32_t *)0xffff0ffc)
 
-void check_kuser_version(void)
-{
+  void check_kuser_version(void)
+  {
 	if (__kuser_helper_version < 2) {
 		fprintf(stderr, "can't do atomic operations, kernel too old\n");
 		abort();
 	}
-}
+  }
 
 Notes:
 
@@ -77,7 +78,7 @@ kuser_get_tls
 
 Location:	0xffff0fe0
 
-Reference prototype:
+Reference prototype::
 
   void * __kuser_get_tls(void);
 
@@ -97,16 +98,16 @@ Definition:
 
   Get the TLS value as previously set via the __ARM_NR_set_tls syscall.
 
-Usage example:
+Usage example::
 
-typedef void * (__kuser_get_tls_t)(void);
-#define __kuser_get_tls (*(__kuser_get_tls_t *)0xffff0fe0)
+  typedef void * (__kuser_get_tls_t)(void);
+  #define __kuser_get_tls (*(__kuser_get_tls_t *)0xffff0fe0)
 
-void foo()
-{
+  void foo()
+  {
 	void *tls = __kuser_get_tls();
 	printf("TLS = %p\n", tls);
-}
+  }
 
 Notes:
 
@@ -117,7 +118,7 @@ kuser_cmpxchg
 
 Location:	0xffff0fc0
 
-Reference prototype:
+Reference prototype::
 
   int __kuser_cmpxchg(int32_t oldval, int32_t newval, volatile int32_t *ptr);
 
@@ -139,18 +140,18 @@ Clobbered registers:
 
 Definition:
 
-  Atomically store newval in *ptr only if *ptr is equal to oldval.
-  Return zero if *ptr was changed or non-zero if no exchange happened.
-  The C flag is also set if *ptr was changed to allow for assembly
+  Atomically store newval in `*ptr` only if `*ptr` is equal to oldval.
+  Return zero if `*ptr` was changed or non-zero if no exchange happened.
+  The C flag is also set if `*ptr` was changed to allow for assembly
   optimization in the calling code.
 
-Usage example:
+Usage example::
 
-typedef int (__kuser_cmpxchg_t)(int oldval, int newval, volatile int *ptr);
-#define __kuser_cmpxchg (*(__kuser_cmpxchg_t *)0xffff0fc0)
+  typedef int (__kuser_cmpxchg_t)(int oldval, int newval, volatile int *ptr);
+  #define __kuser_cmpxchg (*(__kuser_cmpxchg_t *)0xffff0fc0)
 
-int atomic_add(volatile int *ptr, int val)
-{
+  int atomic_add(volatile int *ptr, int val)
+  {
 	int old, new;
 
 	do {
@@ -159,7 +160,7 @@ int atomic_add(volatile int *ptr, int val)
 	} while(__kuser_cmpxchg(old, new, ptr));
 
 	return new;
-}
+  }
 
 Notes:
 
@@ -172,7 +173,7 @@ kuser_memory_barrier
 
 Location:	0xffff0fa0
 
-Reference prototype:
+Reference prototype::
 
   void __kuser_memory_barrier(void);
 
@@ -193,10 +194,10 @@ Definition:
   Apply any needed memory barrier to preserve consistency with data modified
   manually and __kuser_cmpxchg usage.
 
-Usage example:
+Usage example::
 
-typedef void (__kuser_dmb_t)(void);
-#define __kuser_dmb (*(__kuser_dmb_t *)0xffff0fa0)
+  typedef void (__kuser_dmb_t)(void);
+  #define __kuser_dmb (*(__kuser_dmb_t *)0xffff0fa0)
 
 Notes:
 
@@ -207,7 +208,7 @@ kuser_cmpxchg64
 
 Location:	0xffff0f60
 
-Reference prototype:
+Reference prototype::
 
   int __kuser_cmpxchg64(const int64_t *oldval,
                         const int64_t *newval,
@@ -231,22 +232,22 @@ Clobbered registers:
 
 Definition:
 
-  Atomically store the 64-bit value pointed by *newval in *ptr only if *ptr
-  is equal to the 64-bit value pointed by *oldval.  Return zero if *ptr was
+  Atomically store the 64-bit value pointed by `*newval` in `*ptr` only if `*ptr`
+  is equal to the 64-bit value pointed by `*oldval`.  Return zero if `*ptr` was
   changed or non-zero if no exchange happened.
 
-  The C flag is also set if *ptr was changed to allow for assembly
+  The C flag is also set if `*ptr` was changed to allow for assembly
   optimization in the calling code.
 
-Usage example:
+Usage example::
 
-typedef int (__kuser_cmpxchg64_t)(const int64_t *oldval,
-                                  const int64_t *newval,
-                                  volatile int64_t *ptr);
-#define __kuser_cmpxchg64 (*(__kuser_cmpxchg64_t *)0xffff0f60)
+  typedef int (__kuser_cmpxchg64_t)(const int64_t *oldval,
+                                    const int64_t *newval,
+                                    volatile int64_t *ptr);
+  #define __kuser_cmpxchg64 (*(__kuser_cmpxchg64_t *)0xffff0f60)
 
-int64_t atomic_add64(volatile int64_t *ptr, int64_t val)
-{
+  int64_t atomic_add64(volatile int64_t *ptr, int64_t val)
+  {
 	int64_t old, new;
 
 	do {
@@ -255,7 +256,7 @@ int64_t atomic_add64(volatile int64_t *ptr, int64_t val)
 	} while(__kuser_cmpxchg64(&old, &new, ptr));
 
 	return new;
-}
+  }
 
 Notes:
 
diff --git a/Documentation/arm/keystone/Overview.txt b/Documentation/arm/keystone/Overview.txt
index 400c0c270d2e..cd90298c493c 100644
--- a/Documentation/arm/keystone/Overview.txt
+++ b/Documentation/arm/keystone/Overview.txt
@@ -1,5 +1,6 @@
-		TI Keystone Linux Overview
-		--------------------------
+==========================
+TI Keystone Linux Overview
+==========================
 
 Introduction
 ------------
@@ -9,47 +10,65 @@ for users to run Linux on Keystone based EVMs from Texas Instruments.
 
 Following SoCs  & EVMs are currently supported:-
 
------------- K2HK SoC and EVM --------------------------------------------------
+K2HK SoC and EVM
+=================
 
 a.k.a Keystone 2 Hawking/Kepler SoC
 TCI6636K2H & TCI6636K2K: See documentation at
+
 	http://www.ti.com/product/tci6638k2k
 	http://www.ti.com/product/tci6638k2h
 
 EVM:
-http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
+  http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
 
------------- K2E SoC and EVM ---------------------------------------------------
+K2E SoC and EVM
+===============
 
 a.k.a Keystone 2 Edison SoC
-K2E  -  66AK2E05: See documentation at
+
+K2E  -  66AK2E05:
+
+See documentation at
+
 	http://www.ti.com/product/66AK2E05/technicaldocuments
 
 EVM:
-https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
+   https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
 
------------- K2L SoC and EVM ---------------------------------------------------
+K2L SoC and EVM
+===============
 
 a.k.a Keystone 2 Lamarr SoC
-K2L  -  TCI6630K2L: See documentation at
+
+K2L  -  TCI6630K2L:
+
+See documentation at
 	http://www.ti.com/product/TCI6630K2L/technicaldocuments
+
 EVM:
-https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
+  https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
 
 Configuration
 -------------
 
 All of the K2 SoCs/EVMs share a common defconfig, keystone_defconfig and same
 image is used to boot on individual EVMs. The platform configuration is
-specified through DTS. Following are the DTS used:-
-	K2HK EVM : k2hk-evm.dts
-	K2E EVM  : k2e-evm.dts
-	K2L EVM  : k2l-evm.dts
+specified through DTS. Following are the DTS used:
+
+	K2HK EVM:
+		k2hk-evm.dts
+	K2E EVM:
+		k2e-evm.dts
+	K2L EVM:
+		k2l-evm.dts
 
 The device tree documentation for the keystone machines are located at
+
         Documentation/devicetree/bindings/arm/keystone/keystone.txt
 
 Document Author
 ---------------
 Murali Karicheri <m-karicheri2@ti.com>
+
 Copyright 2015 Texas Instruments
diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
index fcdb9fd5f53a..7f7638d80b42 100644
--- a/Documentation/arm/keystone/knav-qmss.txt
+++ b/Documentation/arm/keystone/knav-qmss.txt
@@ -1,4 +1,6 @@
-* Texas Instruments Keystone Navigator Queue Management SubSystem driver
+======================================================================
+Texas Instruments Keystone Navigator Queue Management SubSystem driver
+======================================================================
 
 Driver source code path
   drivers/soc/ti/knav_qmss.c
@@ -34,11 +36,13 @@ driver that interface with the accumulator PDSP. This configures
 accumulator channels defined in DTS (example in DT documentation) to monitor
 1 or 32 queues per channel. More description on the firmware is available in
 CPPI/QMSS Low Level Driver document (docs/CPPI_QMSS_LLD_SDS.pdf) at
+
 	git://git.ti.com/keystone-rtos/qmss-lld.git
 
 k2_qmss_pdsp_acc48_k2_le_1_0_0_9.bin firmware supports upto 48 accumulator
 channels. This firmware is available under ti-keystone folder of
 firmware.git at
+
    git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
 
 To use copy the firmware image to lib/firmware folder of the initramfs or
diff --git a/Documentation/arm/mem_alignment b/Documentation/arm/mem_alignment
index 6335fcacbba9..7bef27367c9a 100644
--- a/Documentation/arm/mem_alignment
+++ b/Documentation/arm/mem_alignment
@@ -1,3 +1,7 @@
+================
+Memory alignment
+================
+
 Too many problems poped up because of unnoticed misaligned memory access in
 kernel code lately.  Therefore the alignment fixup is now unconditionally
 configured in for SA11x0 based targets.  According to Alan Cox, this is a
@@ -26,9 +30,9 @@ space, and might cause programs to fail unexpectedly.
 To change the alignment trap behavior, simply echo a number into
 /proc/cpu/alignment.  The number is made up from various bits:
 
+===		========================================================
 bit		behavior when set
----		-----------------
-
+===		========================================================
 0		A user process performing an unaligned memory access
 		will cause the kernel to print a message indicating
 		process name, pid, pc, instruction, address, and the
@@ -41,12 +45,13 @@ bit		behavior when set
 
 2		The kernel will send a SIGBUS signal to the user process
 		performing the unaligned access.
+===		========================================================
 
 Note that not all combinations are supported - only values 0 through 5.
 (6 and 7 don't make sense).
 
 For example, the following will turn on the warnings, but without
-fixing up or sending SIGBUS signals:
+fixing up or sending SIGBUS signals::
 
 	echo 1 > /proc/cpu/alignment
 
diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 546a39048eb0..0521b4ce5c96 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -1,6 +1,9 @@
-		Kernel Memory Layout on ARM Linux
+=================================
+Kernel Memory Layout on ARM Linux
+=================================
 
 		Russell King <rmk@arm.linux.org.uk>
+
 		     November 17, 2005 (2.6.15)
 
 This document describes the virtual memory layout which the Linux
@@ -15,8 +18,9 @@ As the ARM architecture matures, it becomes necessary to reserve
 certain regions of VM space for use for new facilities; therefore
 this document may reserve more VM space over time.
 
+=============== =============== ===============================================
 Start		End		Use
---------------------------------------------------------------------------
+=============== =============== ===============================================
 ffff8000	ffffffff	copy_user_page / clear_user_page use.
 				For SA11xx and Xscale, this is used to
 				setup a minicache mapping.
@@ -77,6 +81,7 @@ MODULES_VADDR	MODULES_END-1	Kernel module space
 				place their vector page here.  NULL pointer
 				dereferences by both the kernel and user
 				space are also caught via this mapping.
+=============== =============== ===============================================
 
 Please note that mappings which collide with the above areas may result
 in a non-bootable kernel, or may cause the kernel to (eventually) panic
diff --git a/Documentation/arm/nwfpe/NOTES b/Documentation/arm/nwfpe/NOTES
index 40577b5a49d3..102e55af8439 100644
--- a/Documentation/arm/nwfpe/NOTES
+++ b/Documentation/arm/nwfpe/NOTES
@@ -1,3 +1,6 @@
+Notes
+=====
+
 There seems to be a problem with exp(double) and our emulator.  I haven't
 been able to track it down yet.  This does not occur with the emulator
 supplied by Russell King.
diff --git a/Documentation/arm/nwfpe/README b/Documentation/arm/nwfpe/README
index 771871de0c8b..35cd90dacbff 100644
--- a/Documentation/arm/nwfpe/README
+++ b/Documentation/arm/nwfpe/README
@@ -1,4 +1,7 @@
-This directory contains the version 0.92 test release of the NetWinder 
+Introduction
+============
+
+This directory contains the version 0.92 test release of the NetWinder
 Floating Point Emulator.
 
 The majority of the code was written by me, Scott Bambrough It is
@@ -31,7 +34,7 @@ SoftFloat to the ARM was done by Phil Blundell, based on an earlier
 port of SoftFloat version 1 by Neil Carson for NetBSD/arm32.
 
 The file README.FPE contains a description of what has been implemented
-so far in the emulator.  The file TODO contains a information on what 
+so far in the emulator.  The file TODO contains a information on what
 remains to be done, and other ideas for the emulator.
 
 Bug reports, comments, suggestions should be directed to me at
@@ -48,10 +51,11 @@ Legal Notices
 
 The NetWinder Floating Point Emulator is free software.  Everything Rebel.com
 has written is provided under the GNU GPL.  See the file COPYING for copying
-conditions.  Excluded from the above is the SoftFloat code.  John Hauser's 
+conditions.  Excluded from the above is the SoftFloat code.  John Hauser's
 legal notice for SoftFloat is included below.
 
 -------------------------------------------------------------------------------
+
 SoftFloat Legal Notice
 
 SoftFloat was written by John R. Hauser.  This work was made possible in
diff --git a/Documentation/arm/nwfpe/README.FPE b/Documentation/arm/nwfpe/README.FPE
index 26f5d7bb9a41..cbb320960fc4 100644
--- a/Documentation/arm/nwfpe/README.FPE
+++ b/Documentation/arm/nwfpe/README.FPE
@@ -1,12 +1,18 @@
+=============
+Current State
+=============
+
 The following describes the current state of the NetWinder's floating point
 emulator.
 
 In the following nomenclature is used to describe the floating point
 instructions.  It follows the conventions in the ARM manual.
 
-<S|D|E> = <single|double|extended>, no default
-{P|M|Z} = {round to +infinity,round to -infinity,round to zero},
-          default = round to nearest
+::
+
+  <S|D|E> = <single|double|extended>, no default
+  {P|M|Z} = {round to +infinity,round to -infinity,round to zero},
+            default = round to nearest
 
 Note: items enclosed in {} are optional.
 
@@ -32,10 +38,10 @@ Form 2 syntax:
 <LFM|SFM>{cond}<FD,EA> Fd, <count>, [Rn]{!}
 
 These instructions are fully implemented.  They store/load three words
-for each floating point register into the memory location given in the 
+for each floating point register into the memory location given in the
 instruction.  The format in memory is unlikely to be compatible with
 other implementations, in particular the actual hardware.  Specific
-mention of this is made in the ARM manuals.  
+mention of this is made in the ARM manuals.
 
 Floating Point Coprocessor Register Transfer Instructions (CPRT)
 ----------------------------------------------------------------
@@ -123,7 +129,7 @@ RPW{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - reverse power
 POL{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - polar angle (arctan2)
 
 LOG{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base 10
-LGN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base e 
+LGN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base e
 EXP{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - exponent
 SIN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - sine
 COS{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - cosine
@@ -134,7 +140,7 @@ ATN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arctangent
 
 These are not implemented.  They are not currently issued by the compiler,
 and are handled by routines in libc.  These are not implemented by the FPA11
-hardware, but are handled by the floating point support code.  They should 
+hardware, but are handled by the floating point support code.  They should
 be implemented in future versions.
 
 Signalling:
@@ -147,10 +153,10 @@ current_set[0] correctly.
 The kernel provided with this distribution (vmlinux-nwfpe-0.93) contains
 a fix for this problem and also incorporates the current version of the
 emulator directly.  It is possible to run with no floating point module
-loaded with this kernel.  It is provided as a demonstration of the 
+loaded with this kernel.  It is provided as a demonstration of the
 technology and for those who want to do floating point work that depends
 on signals.  It is not strictly necessary to use the module.
 
-A module (either the one provided by Russell King, or the one in this 
+A module (either the one provided by Russell King, or the one in this
 distribution) can be loaded to replace the functionality of the emulator
 built into the kernel.
diff --git a/Documentation/arm/nwfpe/TODO b/Documentation/arm/nwfpe/TODO
index 8027061b60eb..393f11b14540 100644
--- a/Documentation/arm/nwfpe/TODO
+++ b/Documentation/arm/nwfpe/TODO
@@ -1,39 +1,42 @@
 TODO LIST
----------
+=========
 
-POW{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - power
-RPW{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - reverse power
-POL{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - polar angle (arctan2)
+::
 
-LOG{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base 10
-LGN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base e 
-EXP{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - exponent
-SIN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - sine
-COS{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - cosine
-TAN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - tangent
-ASN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arcsine
-ACS{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arccosine
-ATN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arctangent
+  POW{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - power
+  RPW{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - reverse power
+  POL{cond}<S|D|E>{P,M,Z} Fd, Fn, <Fm,#value> - polar angle (arctan2)
+
+  LOG{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base 10
+  LGN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - logarithm to base e
+  EXP{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - exponent
+  SIN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - sine
+  COS{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - cosine
+  TAN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - tangent
+  ASN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arcsine
+  ACS{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arccosine
+  ATN{cond}<S|D|E>{P,M,Z} Fd, <Fm,#value> - arctangent
 
 These are not implemented.  They are not currently issued by the compiler,
 and are handled by routines in libc.  These are not implemented by the FPA11
-hardware, but are handled by the floating point support code.  They should 
+hardware, but are handled by the floating point support code.  They should
 be implemented in future versions.
 
 There are a couple of ways to approach the implementation of these.  One
-method would be to use accurate table methods for these routines.  I have 
+method would be to use accurate table methods for these routines.  I have
 a couple of papers by S. Gal from IBM's research labs in Haifa, Israel that
 seem to promise extreme accuracy (in the order of 99.8%) and reasonable speed.
 These methods are used in GLIBC for some of the transcendental functions.
 
 Another approach, which I know little about is CORDIC.  This stands for
-Coordinate Rotation Digital Computer, and is a method of computing 
+Coordinate Rotation Digital Computer, and is a method of computing
 transcendental functions using mostly shifts and adds and a few
 multiplications and divisions.  The ARM excels at shifts and adds,
-so such a method could be promising, but requires more research to 
+so such a method could be promising, but requires more research to
 determine if it is feasible.
 
 Rounding Methods
+----------------
 
 The IEEE standard defines 4 rounding modes.  Round to nearest is the
 default, but rounding to + or - infinity or round to zero are also allowed.
@@ -42,8 +45,8 @@ in a control register.  Not so with the ARM FPA11 architecture.  To change
 the rounding mode one must specify it with each instruction.
 
 This has made porting some benchmarks difficult.  It is possible to
-introduce such a capability into the emulator.  The FPCR contains 
-bits describing the rounding mode.  The emulator could be altered to 
+introduce such a capability into the emulator.  The FPCR contains
+bits describing the rounding mode.  The emulator could be altered to
 examine a flag, which if set forced it to ignore the rounding mode in
 the instruction, and use the mode specified in the bits in the FPCR.
 
@@ -52,7 +55,8 @@ in the FPCR.  This requires a kernel call in ArmLinux, as WFC/RFC are
 supervisor only instructions.  If anyone has any ideas or comments I
 would like to hear them.
 
-[NOTE: pulled out from some docs on ARM floating point, specifically
+NOTE:
+ pulled out from some docs on ARM floating point, specifically
  for the Acorn FPE, but not limited to it:
 
  The floating point control register (FPCR) may only be present in some
@@ -64,4 +68,5 @@ would like to hear them.
 
  Hence, the answer is yes, you could do this, but then you will run a high
  risk of becoming isolated if and when hardware FP emulation comes out
-		-- Russell].
+
+		-- Russell.
diff --git a/Documentation/arm/pxa/mfp.txt b/Documentation/arm/pxa/mfp.txt
index 0b7cab978c02..ac34e5d7ee44 100644
--- a/Documentation/arm/pxa/mfp.txt
+++ b/Documentation/arm/pxa/mfp.txt
@@ -1,4 +1,6 @@
-                 MFP Configuration for PXA2xx/PXA3xx Processors
+==============================================
+MFP Configuration for PXA2xx/PXA3xx Processors
+==============================================
 
 			Eric Miao <eric.miao@marvell.com>
 
@@ -6,15 +8,15 @@ MFP stands for Multi-Function Pin, which is the pin-mux logic on PXA3xx and
 later PXA series processors.  This document describes the existing MFP API,
 and how board/platform driver authors could make use of it.
 
- Basic Concept
-===============
+Basic Concept
+=============
 
 Unlike the GPIO alternate function settings on PXA25x and PXA27x, a new MFP
 mechanism is introduced from PXA3xx to completely move the pin-mux functions
 out of the GPIO controller. In addition to pin-mux configurations, the MFP
 also controls the low power state, driving strength, pull-up/down and event
 detection of each pin.  Below is a diagram of internal connections between
-the MFP logic and the remaining SoC peripherals:
+the MFP logic and the remaining SoC peripherals::
 
  +--------+
  |        |--(GPIO19)--+
@@ -69,8 +71,8 @@ NOTE: with such a clear separation of MFP and GPIO, by GPIO<xx> we normally
 mean it is a GPIO signal, and by MFP<xxx> or pin xxx, we mean a physical
 pad (or ball).
 
- MFP API Usage
-===============
+MFP API Usage
+=============
 
 For board code writers, here are some guidelines:
 
@@ -94,9 +96,9 @@ For board code writers, here are some guidelines:
    PXA310 supporting some additional ones), thus the difference is actually
    covered in a single mfp-pxa300.h.
 
-2. prepare an array for the initial pin configurations, e.g.:
+2. prepare an array for the initial pin configurations, e.g.::
 
-   static unsigned long mainstone_pin_config[] __initdata = {
+     static unsigned long mainstone_pin_config[] __initdata = {
 	/* Chip Select */
 	GPIO15_nCS_1,
 
@@ -116,7 +118,7 @@ For board code writers, here are some guidelines:
 
 	/* GPIO */
 	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
-   };
+     };
 
    a) once the pin configurations are passed to pxa{2xx,3xx}_mfp_config(),
    and written to the actual registers, they are useless and may discard,
@@ -143,17 +145,17 @@ For board code writers, here are some guidelines:
    d) although PXA3xx MFP supports edge detection on each pin, the
    internal logic will only wakeup the system when those specific bits
    in ADxER registers are set, which can be well mapped to the
-   corresponding peripheral, thus set_irq_wake() can be called with 
+   corresponding peripheral, thus set_irq_wake() can be called with
    the peripheral IRQ to enable the wakeup.
 
 
- MFP on PXA3xx
-===============
+MFP on PXA3xx
+=============
 
 Every external I/O pad on PXA3xx (excluding those for special purpose) has
 one MFP logic associated, and is controlled by one MFP register (MFPR).
 
-The MFPR has the following bit definitions (for PXA300/PXA310/PXA320):
+The MFPR has the following bit definitions (for PXA300/PXA310/PXA320)::
 
  31                        16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
   +-------------------------+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
@@ -183,8 +185,8 @@ The MFPR has the following bit definitions (for PXA300/PXA310/PXA320):
 			0b006 - slow 10mA
 			0b007 - fast 10mA
 
- MFP Design for PXA2xx/PXA3xx
-==============================
+MFP Design for PXA2xx/PXA3xx
+============================
 
 Due to the difference of pin-mux handling between PXA2xx and PXA3xx, a unified
 MFP API is introduced to cover both series of processors.
@@ -194,11 +196,11 @@ configurations, these definitions are processor and platform independent, and
 the actual API invoked to convert these definitions into register settings and
 make them effective there-after.
 
-  Files Involved
-  --------------
+Files Involved
+--------------
 
   - arch/arm/mach-pxa/include/mach/mfp.h
-  
+
   for
     1. Unified pin definitions - enum constants for all configurable pins
     2. processor-neutral bit definitions for a possible MFP configuration
@@ -226,42 +228,42 @@ make them effective there-after.
   for implementation of the pin configuration to take effect for the actual
   processor.
 
-  Pin Configuration
-  -----------------
+Pin Configuration
+-----------------
 
   The following comments are copied from mfp.h (see the actual source code
-  for most updated info)
-  
-  /*
-   * a possible MFP configuration is represented by a 32-bit integer
-   *
-   * bit  0.. 9 - MFP Pin Number (1024 Pins Maximum)
-   * bit 10..12 - Alternate Function Selection
-   * bit 13..15 - Drive Strength
-   * bit 16..18 - Low Power Mode State
-   * bit 19..20 - Low Power Mode Edge Detection
-   * bit 21..22 - Run Mode Pull State
-   *
-   * to facilitate the definition, the following macros are provided
-   *
-   * MFP_CFG_DEFAULT - default MFP configuration value, with
-   * 		  alternate function = 0,
-   * 		  drive strength = fast 3mA (MFP_DS03X)
-   * 		  low power mode = default
-   * 		  edge detection = none
-   *
-   * MFP_CFG	- default MFPR value with alternate function
-   * MFP_CFG_DRV	- default MFPR value with alternate function and
-   * 		  pin drive strength
-   * MFP_CFG_LPM	- default MFPR value with alternate function and
-   * 		  low power mode
-   * MFP_CFG_X	- default MFPR value with alternate function,
-   * 		  pin drive strength and low power mode
-   */
+  for most updated info)::
 
-   Examples of pin configurations are:
+    /*
+     * a possible MFP configuration is represented by a 32-bit integer
+     *
+     * bit  0.. 9 - MFP Pin Number (1024 Pins Maximum)
+     * bit 10..12 - Alternate Function Selection
+     * bit 13..15 - Drive Strength
+     * bit 16..18 - Low Power Mode State
+     * bit 19..20 - Low Power Mode Edge Detection
+     * bit 21..22 - Run Mode Pull State
+     *
+     * to facilitate the definition, the following macros are provided
+     *
+     * MFP_CFG_DEFAULT - default MFP configuration value, with
+     * 		  alternate function = 0,
+     * 		  drive strength = fast 3mA (MFP_DS03X)
+     * 		  low power mode = default
+     * 		  edge detection = none
+     *
+     * MFP_CFG	- default MFPR value with alternate function
+     * MFP_CFG_DRV	- default MFPR value with alternate function and
+     * 		  pin drive strength
+     * MFP_CFG_LPM	- default MFPR value with alternate function and
+     * 		  low power mode
+     * MFP_CFG_X	- default MFPR value with alternate function,
+     * 		  pin drive strength and low power mode
+     */
 
-   #define GPIO94_SSP3_RXD		MFP_CFG_X(GPIO94, AF1, DS08X, FLOAT)
+   Examples of pin configurations are::
+
+     #define GPIO94_SSP3_RXD		MFP_CFG_X(GPIO94, AF1, DS08X, FLOAT)
 
    which reads GPIO94 can be configured as SSP3_RXD, with alternate function
    selection of 1, driving strength of 0b101, and a float state in low power
@@ -272,8 +274,8 @@ make them effective there-after.
    do so, simply because this default setting is usually carefully encoded,
    and is supposed to work in most cases.
 
-  Register Settings
-  -----------------
+Register Settings
+-----------------
 
    Register settings on PXA3xx for a pin configuration is actually very
    straight-forward, most bits can be converted directly into MFPR value
diff --git a/Documentation/arm/sti/overview.txt b/Documentation/arm/sti/overview.txt
index 1a4e93d6027f..70743617a74f 100644
--- a/Documentation/arm/sti/overview.txt
+++ b/Documentation/arm/sti/overview.txt
@@ -1,5 +1,6 @@
-			STi ARM Linux Overview
-			==========================
+======================
+STi ARM Linux Overview
+======================
 
 Introduction
 ------------
@@ -10,15 +11,17 @@ Introduction
   B2000 and B2020 Reference boards.
 
 
-  configuration
-  -------------
+configuration
+-------------
 
   A generic configuration is provided for both STiH415/416, and can be used as the
-  default by
+  default by::
+
 	make stih41x_defconfig
 
-  Layout
-  ------
+Layout
+------
+
   All the files for multiple machine families (STiH415, STiH416, and STiG125)
   are located in the platform code contained in arch/arm/mach-sti
 
@@ -27,7 +30,7 @@ Introduction
   Device Trees.
 
 
-  Document Author
-  ---------------
+Document Author
+---------------
 
   Srinivas Kandagatla <srinivas.kandagatla@st.com>, (c) 2013 ST Microelectronics
diff --git a/Documentation/arm/sti/stih407-overview.txt b/Documentation/arm/sti/stih407-overview.txt
index 3343f32f58bc..027e75bc7b7c 100644
--- a/Documentation/arm/sti/stih407-overview.txt
+++ b/Documentation/arm/sti/stih407-overview.txt
@@ -1,5 +1,6 @@
-			STiH407 Overview
-			================
+================
+STiH407 Overview
+================
 
 Introduction
 ------------
@@ -12,7 +13,7 @@ Introduction
     - ARM Cortex-A9 1.5 GHz dual core CPU (28nm)
     - SATA2, USB 3.0, PCIe, Gbit Ethernet
 
-  Document Author
-  ---------------
+Document Author
+---------------
 
   Maxime Coquelin <maxime.coquelin@st.com>, (c) 2014 ST Microelectronics
diff --git a/Documentation/arm/sti/stih415-overview.txt b/Documentation/arm/sti/stih415-overview.txt
index 1383e33f265d..b67452d610c4 100644
--- a/Documentation/arm/sti/stih415-overview.txt
+++ b/Documentation/arm/sti/stih415-overview.txt
@@ -1,5 +1,6 @@
-			STiH415 Overview
-			================
+================
+STiH415 Overview
+================
 
 Introduction
 ------------
@@ -7,6 +8,7 @@ Introduction
     The STiH415 is the next generation of HD, AVC set-top box processors
     for satellite, cable, terrestrial and IP-STB markets.
 
-    Features
+    Features:
+
     - ARM Cortex-A9 1.0 GHz, dual-core CPU
     - SATA2x2,USB 2.0x3, PCIe, Gbit Ethernet MACx2
diff --git a/Documentation/arm/sti/stih416-overview.txt b/Documentation/arm/sti/stih416-overview.txt
index 558444c201c6..93f17d74d8db 100644
--- a/Documentation/arm/sti/stih416-overview.txt
+++ b/Documentation/arm/sti/stih416-overview.txt
@@ -1,5 +1,6 @@
-			STiH416 Overview
-			================
+================
+STiH416 Overview
+================
 
 Introduction
 ------------
diff --git a/Documentation/arm/sti/stih418-overview.txt b/Documentation/arm/sti/stih418-overview.txt
index 1cd8fc80646d..b563c1f4fe5a 100644
--- a/Documentation/arm/sti/stih418-overview.txt
+++ b/Documentation/arm/sti/stih418-overview.txt
@@ -1,5 +1,6 @@
-			STiH418 Overview
-			================
+================
+STiH418 Overview
+================
 
 Introduction
 ------------
@@ -14,7 +15,7 @@ Introduction
     - HEVC L5.1 Main 10
     - VP9
 
-  Document Author
-  ---------------
+Document Author
+---------------
 
   Maxime Coquelin <maxime.coquelin@st.com>, (c) 2015 ST Microelectronics
diff --git a/Documentation/arm/stm32/stm32f429-overview.rst b/Documentation/arm/stm32/stm32f429-overview.rst
index 18feda97f483..a7ebe8ea6697 100644
--- a/Documentation/arm/stm32/stm32f429-overview.rst
+++ b/Documentation/arm/stm32/stm32f429-overview.rst
@@ -1,3 +1,4 @@
+==================
 STM32F429 Overview
 ==================
 
@@ -21,6 +22,4 @@ Datasheet and reference manual are publicly available on ST website (STM32F429_)
 
 .. _STM32F429: http://www.st.com/web/en/catalog/mmc/FM141/SC1169/SS1577/LN1806?ecmp=stm32f429-439_pron_pr-ces2014_nov2013
 
-:Authors:
-
-Maxime Coquelin <mcoquelin.stm32@gmail.com>
+:Authors: Maxime Coquelin <mcoquelin.stm32@gmail.com>
diff --git a/Documentation/arm/stm32/stm32f746-overview.rst b/Documentation/arm/stm32/stm32f746-overview.rst
index b5f4b6ce7656..78befddc7740 100644
--- a/Documentation/arm/stm32/stm32f746-overview.rst
+++ b/Documentation/arm/stm32/stm32f746-overview.rst
@@ -1,3 +1,4 @@
+==================
 STM32F746 Overview
 ==================
 
@@ -28,6 +29,4 @@ Datasheet and reference manual are publicly available on ST website (STM32F746_)
 
 .. _STM32F746: http://www.st.com/content/st_com/en/products/microcontrollers/stm32-32-bit-arm-cortex-mcus/stm32f7-series/stm32f7x6/stm32f746ng.html
 
-:Authors:
-
-Alexandre Torgue <alexandre.torgue@st.com>
+:Authors: Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/Documentation/arm/stm32/stm32f769-overview.rst b/Documentation/arm/stm32/stm32f769-overview.rst
index 228656ced2fe..e482980ddf21 100644
--- a/Documentation/arm/stm32/stm32f769-overview.rst
+++ b/Documentation/arm/stm32/stm32f769-overview.rst
@@ -1,3 +1,4 @@
+==================
 STM32F769 Overview
 ==================
 
@@ -30,6 +31,4 @@ Datasheet and reference manual are publicly available on ST website (STM32F769_)
 
 .. _STM32F769: http://www.st.com/content/st_com/en/products/microcontrollers/stm32-32-bit-arm-cortex-mcus/stm32-high-performance-mcus/stm32f7-series/stm32f7x9/stm32f769ni.html
 
-:Authors:
-
-Alexandre Torgue <alexandre.torgue@st.com>
+:Authors: Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/Documentation/arm/stm32/stm32h743-overview.rst b/Documentation/arm/stm32/stm32h743-overview.rst
index 3458dc00095d..4e15f1a42730 100644
--- a/Documentation/arm/stm32/stm32h743-overview.rst
+++ b/Documentation/arm/stm32/stm32h743-overview.rst
@@ -1,3 +1,4 @@
+==================
 STM32H743 Overview
 ==================
 
@@ -29,6 +30,4 @@ Datasheet and reference manual are publicly available on ST website (STM32H743_)
 
 .. _STM32H743: http://www.st.com/en/microcontrollers/stm32h7x3.html?querycriteria=productId=LN2033
 
-:Authors:
-
-Alexandre Torgue <alexandre.torgue@st.com>
+:Authors: Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
index 62e176d47ca7..f62fdc8e7d8d 100644
--- a/Documentation/arm/stm32/stm32mp157-overview.rst
+++ b/Documentation/arm/stm32/stm32mp157-overview.rst
@@ -1,3 +1,4 @@
+===================
 STM32MP157 Overview
 ===================
 
diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index f8efc21998bf..b037428aee98 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -1,3 +1,4 @@
+==================
 ARM Allwinner SoCs
 ==================
 
@@ -10,93 +11,140 @@ SunXi family
   Linux kernel mach directory: arch/arm/mach-sunxi
 
   Flavors:
+
     * ARM926 based SoCs
       - Allwinner F20 (sun3i)
-        + Not Supported
+
+        * Not Supported
 
     * ARM Cortex-A8 based SoCs
       - Allwinner A10 (sun4i)
-        + Datasheet
+
+        * Datasheet
+
 	  http://dl.linux-sunxi.org/A10/A10%20Datasheet%20-%20v1.21%20%282012-04-06%29.pdf
-	+ User Manual
+	* User Manual
+
 	  http://dl.linux-sunxi.org/A10/A10%20User%20Manual%20-%20v1.20%20%282012-04-09%2c%20DECRYPTED%29.pdf
 
       - Allwinner A10s (sun5i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A10s/A10s%20Datasheet%20-%20v1.20%20%282012-03-27%29.pdf
 
       - Allwinner A13 / R8 (sun5i)
-        + Datasheet
+
+        * Datasheet
+
 	  http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
-        + User Manual
+        * User Manual
+
           http://dl.linux-sunxi.org/A13/A13%20User%20Manual%20-%20v1.2%20%282013-01-08%29.pdf
 
       - Next Thing Co GR8 (sun5i)
 
     * Single ARM Cortex-A7 based SoCs
       - Allwinner V3s (sun8i)
-        + Datasheet
+
+        * Datasheet
+
           http://linux-sunxi.org/File:Allwinner_V3s_Datasheet_V1.0.pdf
 
     * Dual ARM Cortex-A7 based SoCs
       - Allwinner A20 (sun7i)
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf
 
       - Allwinner A23 (sun8i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A23/A23%20Datasheet%20V1.0%2020130830.pdf
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A23/A23%20User%20Manual%20V1.0%2020130830.pdf
 
     * Quad ARM Cortex-A7 based SoCs
       - Allwinner A31 (sun6i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A31/A3x_release_document/A31/IC/A31%20datasheet%20V1.3%2020131106.pdf
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A31/A3x_release_document/A31/IC/A31%20user%20manual%20V1.1%2020130630.pdf
 
       - Allwinner A31s (sun6i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A31/A3x_release_document/A31s/IC/A31s%20datasheet%20V1.3%2020131106.pdf
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A31/A3x_release_document/A31s/IC/A31s%20User%20Manual%20%20V1.0%2020130322.pdf
 
       - Allwinner A33 (sun8i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A33/A33%20Datasheet%20release%201.1.pdf
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A33/A33%20user%20manual%20release%201.1.pdf
 
       - Allwinner H2+ (sun8i)
-        + No document available now, but is known to be working properly with
+
+        * No document available now, but is known to be working properly with
           H3 drivers and memory map.
 
       - Allwinner H3 (sun8i)
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
 
       - Allwinner R40 (sun8i)
-        + Datasheet
+
+        * Datasheet
+
           https://github.com/tinalinux/docs/raw/r40-v1.y/R40_Datasheet_V1.0.pdf
-        + User Manual
+
+        * User Manual
+
           https://github.com/tinalinux/docs/raw/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
 
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
-        + Datasheet
+
+        * Datasheet
+
 	  http://dl.linux-sunxi.org/A80/A80_Datasheet_Revision_1.0_0404.pdf
 
     * Octa ARM Cortex-A7 based SoCs
       - Allwinner A83T
-        + Datasheet
+
+        * Datasheet
+
           https://github.com/allwinner-zh/documents/raw/master/A83T/A83T_Datasheet_v1.3_20150510.pdf
-        + User Manual
+
+        * User Manual
+
           https://github.com/allwinner-zh/documents/raw/master/A83T/A83T_User_Manual_v1.5.1_20150513.pdf
 
     * Quad ARM Cortex-A53 based SoCs
       - Allwinner A64
-        + Datasheet
+
+        * Datasheet
+
           http://dl.linux-sunxi.org/A64/A64_Datasheet_V1.1.pdf
-        + User Manual
+
+        * User Manual
+
           http://dl.linux-sunxi.org/A64/Allwinner%20A64%20User%20Manual%20v1.0.pdf
diff --git a/Documentation/arm/sunxi/clocks.txt b/Documentation/arm/sunxi/clocks.txt
index e09a88aa3136..23bd03f3e21f 100644
--- a/Documentation/arm/sunxi/clocks.txt
+++ b/Documentation/arm/sunxi/clocks.txt
@@ -1,3 +1,4 @@
+=======================================================
 Frequently asked questions about the sunxi clock system
 =======================================================
 
@@ -12,7 +13,7 @@ A: The 24MHz oscillator allows gating to save power. Indeed, if gated
    steps, one can gate it and keep the system running. Consider this
    simplified suspend example:
 
-   While the system is operational, you would see something like
+   While the system is operational, you would see something like::
 
       24MHz         32kHz
        |
@@ -23,7 +24,7 @@ A: The 24MHz oscillator allows gating to save power. Indeed, if gated
            [CPU]
 
    When you are about to suspend, you switch the CPU Mux to the 32kHz
-   oscillator:
+   oscillator::
 
       24Mhz         32kHz
        |              |
@@ -33,7 +34,7 @@ A: The 24MHz oscillator allows gating to save power. Indeed, if gated
              |
            [CPU]
 
-    Finally you can gate the main oscillator
+    Finally you can gate the main oscillator::
 
                     32kHz
                       |
diff --git a/Documentation/arm/swp_emulation b/Documentation/arm/swp_emulation
index af903d22fd93..6a608a9c3715 100644
--- a/Documentation/arm/swp_emulation
+++ b/Documentation/arm/swp_emulation
@@ -11,17 +11,17 @@ sequence. If a memory access fault (an abort) occurs, a segmentation fault is
 signalled to the triggering process.
 
 /proc/cpu/swp_emulation holds some statistics/information, including the PID of
-the last process to trigger the emulation to be invocated. For example:
----
-Emulated SWP:		12
-Emulated SWPB:		0
-Aborted SWP{B}:		1
-Last process:		314
----
+the last process to trigger the emulation to be invocated. For example::
 
-NOTE: when accessing uncached shared regions, LDREX/STREX rely on an external
-transaction monitoring block called a global monitor to maintain update
-atomicity. If your system does not implement a global monitor, this option can
-cause programs that perform SWP operations to uncached memory to deadlock, as
-the STREX operation will always fail.
+  Emulated SWP:		12
+  Emulated SWPB:		0
+  Aborted SWP{B}:		1
+  Last process:		314
 
+
+NOTE:
+  when accessing uncached shared regions, LDREX/STREX rely on an external
+  transaction monitoring block called a global monitor to maintain update
+  atomicity. If your system does not implement a global monitor, this option can
+  cause programs that perform SWP operations to uncached memory to deadlock, as
+  the STREX operation will always fail.
diff --git a/Documentation/arm/tcm.txt b/Documentation/arm/tcm.txt
index 7c15871c1885..effd9c7bc968 100644
--- a/Documentation/arm/tcm.txt
+++ b/Documentation/arm/tcm.txt
@@ -1,5 +1,7 @@
+==================================================
 ARM TCM (Tightly-Coupled Memory) handling in Linux
-----
+==================================================
+
 Written by Linus Walleij <linus.walleij@stericsson.com>
 
 Some ARM SoC:s have a so-called TCM (Tightly-Coupled Memory).
@@ -85,46 +87,50 @@ to have functions called locally inside the TCM without
 wasting space, there is also the __tcmlocalfunc prefix that
 will make the call relative.
 
-Variables to go into dtcm can be tagged like this:
-int __tcmdata foo;
+Variables to go into dtcm can be tagged like this::
 
-Constants can be tagged like this:
-int __tcmconst foo;
+  int __tcmdata foo;
+
+Constants can be tagged like this::
+
+  int __tcmconst foo;
+
+To put assembler into TCM just use::
+
+  .section ".tcm.text" or .section ".tcm.data"
 
-To put assembler into TCM just use
-.section ".tcm.text" or .section ".tcm.data"
 respectively.
 
-Example code:
+Example code::
 
-#include <asm/tcm.h>
+  #include <asm/tcm.h>
 
-/* Uninitialized data */
-static u32 __tcmdata tcmvar;
-/* Initialized data */
-static u32 __tcmdata tcmassigned = 0x2BADBABEU;
-/* Constant */
-static const u32 __tcmconst tcmconst = 0xCAFEBABEU;
+  /* Uninitialized data */
+  static u32 __tcmdata tcmvar;
+  /* Initialized data */
+  static u32 __tcmdata tcmassigned = 0x2BADBABEU;
+  /* Constant */
+  static const u32 __tcmconst tcmconst = 0xCAFEBABEU;
 
-static void __tcmlocalfunc tcm_to_tcm(void)
-{
+  static void __tcmlocalfunc tcm_to_tcm(void)
+  {
 	int i;
 	for (i = 0; i < 100; i++)
 		tcmvar ++;
-}
+  }
 
-static void __tcmfunc hello_tcm(void)
-{
+  static void __tcmfunc hello_tcm(void)
+  {
 	/* Some abstract code that runs in ITCM */
 	int i;
 	for (i = 0; i < 100; i++) {
 		tcmvar ++;
 	}
 	tcm_to_tcm();
-}
+  }
 
-static void __init test_tcm(void)
-{
+  static void __init test_tcm(void)
+  {
 	u32 *tcmem;
 	int i;
 
@@ -152,4 +158,4 @@ static void __init test_tcm(void)
 			printk("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
 		tcm_free(tcmem, 20);
 	}
-}
+  }
diff --git a/Documentation/arm/uefi.txt b/Documentation/arm/uefi.txt
index 6543a0adea8a..f868330df6be 100644
--- a/Documentation/arm/uefi.txt
+++ b/Documentation/arm/uefi.txt
@@ -1,3 +1,7 @@
+================================================
+The Unified Extensible Firmware Interface (UEFI)
+================================================
+
 UEFI, the Unified Extensible Firmware Interface, is a specification
 governing the behaviours of compatible firmware interfaces. It is
 maintained by the UEFI Forum - http://www.uefi.org/.
@@ -11,11 +15,13 @@ UEFI support in Linux
 =====================
 Booting on a platform with firmware compliant with the UEFI specification
 makes it possible for the kernel to support additional features:
+
 - UEFI Runtime Services
 - Retrieving various configuration information through the standardised
   interface of UEFI configuration tables. (ACPI, SMBIOS, ...)
 
 For actually enabling [U]EFI support, enable:
+
 - CONFIG_EFI=y
 - CONFIG_EFI_VARS=y or m
 
@@ -42,19 +48,20 @@ Instead, the kernel reads the UEFI memory map.
 
 The stub populates the FDT /chosen node with (and the kernel scans for) the
 following parameters:
-________________________________________________________________________________
-Name                      | Size   | Description
-================================================================================
-linux,uefi-system-table   | 64-bit | Physical address of the UEFI System Table.
---------------------------------------------------------------------------------
-linux,uefi-mmap-start     | 64-bit | Physical address of the UEFI memory map,
-                          |        | populated by the UEFI GetMemoryMap() call.
---------------------------------------------------------------------------------
-linux,uefi-mmap-size      | 32-bit | Size in bytes of the UEFI memory map
-                          |        | pointed to in previous entry.
---------------------------------------------------------------------------------
-linux,uefi-mmap-desc-size | 32-bit | Size in bytes of each entry in the UEFI
-                          |        | memory map.
---------------------------------------------------------------------------------
-linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
---------------------------------------------------------------------------------
+
+==========================  ======   ===========================================
+Name                        Size     Description
+==========================  ======   ===========================================
+linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
+
+linux,uefi-mmap-start       64-bit   Physical address of the UEFI memory map,
+                                     populated by the UEFI GetMemoryMap() call.
+
+linux,uefi-mmap-size        32-bit   Size in bytes of the UEFI memory map
+                                     pointed to in previous entry.
+
+linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in the UEFI
+                                     memory map.
+
+linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
+==========================  ======   ===========================================
diff --git a/Documentation/arm/vlocks.txt b/Documentation/arm/vlocks.txt
index 45731672c564..a40a1742110b 100644
--- a/Documentation/arm/vlocks.txt
+++ b/Documentation/arm/vlocks.txt
@@ -1,3 +1,4 @@
+======================================
 vlocks for Bare-Metal Mutual Exclusion
 ======================================
 
@@ -26,7 +27,7 @@ started yet.
 Algorithm
 ---------
 
-The easiest way to explain the vlocks algorithm is with some pseudo-code:
+The easiest way to explain the vlocks algorithm is with some pseudo-code::
 
 
 	int currently_voting[NR_CPUS] = { 0, };
@@ -93,7 +94,7 @@ Features and limitations
    number of CPUs.
 
    vlocks can be cascaded in a voting hierarchy to permit better scaling
-   if necessary, as in the following hypothetical example for 4096 CPUs:
+   if necessary, as in the following hypothetical example for 4096 CPUs::
 
 	/* first level: local election */
 	my_town = towns[(this_cpu >> 4) & 0xf];
@@ -127,12 +128,12 @@ the basic algorithm:
    reduces the number of round-trips required to external memory.
 
    In the ARM implementation, this means that we can use a single load
-   and comparison:
+   and comparison::
 
 	LDR	Rt, [Rn]
 	CMP	Rt, #0
 
-   ...in place of code equivalent to:
+   ...in place of code equivalent to::
 
 	LDRB	Rt, [Rn]
 	CMP	Rt, #0
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..e0a669552193 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,3 +1,4 @@
+
 .. The Linux Kernel documentation master file, created by
    sphinx-quickstart on Fri Feb 12 13:51:46 2016.
    You can adapt this file completely to your liking, but it should at least
-- 
2.20.1

