Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE562075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383572;
	bh=rAHE36BRoa+5KM1dy+puDrqqAlQv2Gfi8CEZaR5xKmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMVzfsaXxIhNOIosfsjm/ZJJ0VPOgByRUCDQp/G6KXdLpSIfAwudZpcG5GY00VTFc
	 zlrllluBjnZMeq/7n+LL1yu2EIOzj915bke6K08df5/zJcj3rF1SwiazcKwKZBpwtB
	 5I4iiKv+KTeKVXGPxT6XnLSanqJtZLsgVfjBXF9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfDPC7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d4QZ1jDYX18EPmzNYqxLuCHymOA31MxLS4Wg5celgh8=; b=uDwFZMZDUE7we9C6z05GObkrlV
        mbX45hbLXz7aA/du1lYuc/oE7DuPrZDxmPh3ipyuXzhlCxwLDHaioOqLMi/tE74k9fEOfqpAxhIP1
        Nv1w6AAmBKJpELeubhDsHqo24St6B9N746q87bLqzKTRoWEsO/eqtwGPMyyl67Prqee+Lt0VWwldW
        0isKKAHEz8bpvlxAuwnwFuBWTOevnYKdoLgTioedkWiskITomlF99o/IIJRVFV8MECw98wm57AMDb
        Tvad6kogwjXjNpjQ3YIIwKrP3EfoHnZsB89s6MgVatq6t1pR+4MjuQ1q49973BDpjeBNVoVhwF700
        5I0ibXzA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGq-0007at-6A; Tue, 16 Apr 2019 02:56:30 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001os-VC; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 38/57] docs: x86: convert text files to ReST
Date:   Mon, 15 Apr 2019 23:56:03 -0300
Message-Id: <72da4bbdb988e14679a3d2a23859f4e4dc10c657.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the x86/x86_64 text files to ReST and prepare them to
be part of a new architecture book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/amd-memory-encryption.txt |  10 +-
 Documentation/x86/boot.txt                  | 578 +++++++++---------
 Documentation/x86/earlyprintk.txt           |  69 ++-
 Documentation/x86/entry_64.txt              |  11 +-
 Documentation/x86/exception-tables.txt      | 245 ++++----
 Documentation/x86/i386/IO-APIC.txt          |  23 +-
 Documentation/x86/intel_mpx.txt             |  55 +-
 Documentation/x86/microcode.txt             |  51 +-
 Documentation/x86/mtrr.txt                  | 442 +++++++-------
 Documentation/x86/orc-unwinder.txt          |   1 +
 Documentation/x86/pat.txt                   | 217 +++----
 Documentation/x86/protection-keys.txt       |  33 +-
 Documentation/x86/pti.txt                   |   8 +-
 Documentation/x86/resctrl_ui.txt            | 621 +++++++++++---------
 Documentation/x86/tlb.txt                   |  12 +-
 Documentation/x86/topology.txt              |  26 +-
 Documentation/x86/usb-legacy-support.txt    |  33 +-
 Documentation/x86/x86_64/5level-paging.txt  |  14 +-
 Documentation/x86/x86_64/boot-options.txt   |  98 ++-
 Documentation/x86/x86_64/mm.txt             | 212 ++++---
 Documentation/x86/x86_64/uefi.txt           |  21 +-
 Documentation/x86/zero-page.txt             |  67 ++-
 22 files changed, 1575 insertions(+), 1272 deletions(-)

diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.txt
index afc41f544dab..bcefc00847f4 100644
--- a/Documentation/x86/amd-memory-encryption.txt
+++ b/Documentation/x86/amd-memory-encryption.txt
@@ -1,3 +1,7 @@
+=====================
+AMD memory encryption
+=====================
+
 Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
 features found on AMD processors.
 
@@ -34,7 +38,7 @@ is operating in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware
 forces the memory encryption bit to 1.
 
 Support for SME and SEV can be determined through the CPUID instruction. The
-CPUID function 0x8000001f reports information related to SME:
+CPUID function 0x8000001f reports information related to SME::
 
 	0x8000001f[eax]:
 		Bit[0] indicates support for SME
@@ -48,14 +52,14 @@ CPUID function 0x8000001f reports information related to SME:
 			   addresses)
 
 If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
-determine if SME is enabled and/or to enable memory encryption:
+determine if SME is enabled and/or to enable memory encryption::
 
 	0xc0010010:
 		Bit[23]   0 = memory encryption features are disabled
 			  1 = memory encryption features are enabled
 
 If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
-SEV is active:
+SEV is active::
 
 	0xc0010131:
 		Bit[0]	  0 = memory encryption is not active
diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index 223e484a1304..206f659e077a 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -1,5 +1,6 @@
-		     THE LINUX/x86 BOOT PROTOCOL
-		     ---------------------------
+===========================
+THE LINUX/x86 BOOT PROTOCOL
+===========================
 
 On the x86 platform, the Linux kernel uses a rather complicated boot
 convention.  This has evolved partially due to historical aspects, as
@@ -10,6 +11,7 @@ real-mode DOS as a mainstream operating system.
 
 Currently, the following versions of the Linux/x86 boot protocol exist.
 
+=============== ===============================================================
 Old kernels:	zImage/Image support only.  Some very early kernels
 		may not even support a command line.
 
@@ -48,7 +50,7 @@ Protocol 2.08:	(Kernel 2.6.26) Added crc32 checksum and ELF format
 		fields to aid in locating the payload.
 
 Protocol 2.09:	(Kernel 2.6.26) Added a field of 64-bit physical
-		pointer to single linked list of struct	setup_data.
+		pointer to single linked list of struct setup_data.
 
 Protocol 2.10:	(Kernel 2.6.31) Added a protocol for relaxed alignment
 		beyond the kernel_alignment added, new init_size and
@@ -64,33 +66,35 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
 Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
 		xloadflags to support booting a 64-bit kernel from 32-bit
 		EFI
+=============== ===============================================================
 
-**** MEMORY LAYOUT
+MEMORY LAYOUT
+=============
 
 The traditional memory map for the kernel loader, used for Image or
-zImage kernels, typically looks like:
+zImage kernels, typically looks like::
 
-	|			 |
-0A0000	+------------------------+
-	|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
-09A000	+------------------------+
-	|  Command line		 |
-	|  Stack/heap		 |	For use by the kernel real-mode code.
-098000	+------------------------+	
-	|  Kernel setup		 |	The kernel real-mode code.
-090200	+------------------------+
-	|  Kernel boot sector	 |	The kernel legacy boot sector.
-090000	+------------------------+
-	|  Protected-mode kernel |	The bulk of the kernel image.
-010000	+------------------------+
-	|  Boot loader		 |	<- Boot sector entry point 0000:7C00
-001000	+------------------------+
-	|  Reserved for MBR/BIOS |
-000800	+------------------------+
-	|  Typically used by MBR |
-000600	+------------------------+ 
-	|  BIOS use only	 |
-000000	+------------------------+
+	 |                        |
+  0A0000 +------------------------+
+	 |  Reserved for BIOS     |      Do not use.  Reserved for BIOS EBDA.
+  09A000 +------------------------+
+	 |  Command line          |
+	 |  Stack/heap            |      For use by the kernel real-mode code.
+  098000 +------------------------+
+	 |  Kernel setup          |      The kernel real-mode code.
+  090200 +------------------------+
+	 |  Kernel boot sector    |      The kernel legacy boot sector.
+  090000 +------------------------+
+	 |  Protected-mode kernel |      The bulk of the kernel image.
+  010000 +------------------------+
+	 |  Boot loader           |      <- Boot sector entry point 0000:7C00
+  001000 +------------------------+
+	 |  Reserved for MBR/BIOS |
+  000800 +------------------------+
+	 |  Typically used by MBR |
+  000600 +------------------------+
+	 |  BIOS use only         |
+  000000 +------------------------+
 
 
 When using bzImage, the protected-mode kernel was relocated to
@@ -116,36 +120,37 @@ zImage or old bzImage kernels, which need data written into the
 above the 0x9A000 point; too many BIOSes will break above that point.
 
 For a modern bzImage kernel with boot protocol version >= 2.02, a
-memory layout like the following is suggested:
+memory layout like the following is suggested::
 
-	~                        ~
-        |  Protected-mode kernel |
-100000  +------------------------+
-	|  I/O memory hole	 |
-0A0000	+------------------------+
-	|  Reserved for BIOS	 |	Leave as much as possible unused
-	~                        ~
-	|  Command line		 |	(Can also be below the X+10000 mark)
-X+10000	+------------------------+
-	|  Stack/heap		 |	For use by the kernel real-mode code.
-X+08000	+------------------------+	
-	|  Kernel setup		 |	The kernel real-mode code.
-	|  Kernel boot sector	 |	The kernel legacy boot sector.
-X       +------------------------+
-	|  Boot loader		 |	<- Boot sector entry point 0000:7C00
-001000	+------------------------+
-	|  Reserved for MBR/BIOS |
-000800	+------------------------+
-	|  Typically used by MBR |
-000600	+------------------------+ 
-	|  BIOS use only	 |
-000000	+------------------------+
+	  ~                        ~
+	  |  Protected-mode kernel |
+  100000  +------------------------+
+	  |  I/O memory hole       |
+  0A0000  +------------------------+
+	  |  Reserved for BIOS     |      Leave as much as possible unused
+	  ~                        ~
+	  |  Command line          |      (Can also be below the X+10000 mark)
+  X+10000 +------------------------+
+	  |  Stack/heap            |      For use by the kernel real-mode code.
+  X+08000 +------------------------+
+	  |  Kernel setup          |      The kernel real-mode code.
+	  |  Kernel boot sector    |      The kernel legacy boot sector.
+  X       +------------------------+
+	  |  Boot loader           |      <- Boot sector entry point 0000:7C00
+  001000  +------------------------+
+	  |  Reserved for MBR/BIOS |
+  000800  +------------------------+
+	  |  Typically used by MBR |
+  000600  +------------------------+
+	  |  BIOS use only         |
+  000000  +------------------------+
 
-... where the address X is as low as the design of the boot loader
-permits.
+  ... where the address X is as low as the design of the boot loader
+  permits.
 
 
-**** THE REAL-MODE KERNEL HEADER
+THE REAL-MODE KERNEL HEADER
+===========================
 
 In the following text, and anywhere in the kernel boot sequence, "a
 sector" refers to 512 bytes.  It is independent of the actual sector
@@ -159,48 +164,54 @@ sectors (1K) and then examine the bootup sector size.
 
 The header looks like:
 
-Offset	Proto	Name		Meaning
+======  ======== ===================== ========================================
+Offset  Proto    Name                  Meaning
 /Size
 
-01F1/1	ALL(1	setup_sects	The size of the setup in sectors
-01F2/2	ALL	root_flags	If set, the root is mounted readonly
-01F4/4	2.04+(2	syssize		The size of the 32-bit code in 16-byte paras
-01F8/2	ALL	ram_size	DO NOT USE - for bootsect.S use only
-01FA/2	ALL	vid_mode	Video mode control
-01FC/2	ALL	root_dev	Default root device number
-01FE/2	ALL	boot_flag	0xAA55 magic number
-0200/2	2.00+	jump		Jump instruction
-0202/4	2.00+	header		Magic signature "HdrS"
-0206/2	2.00+	version		Boot protocol version supported
-0208/4	2.00+	realmode_swtch	Boot loader hook (see below)
-020C/2	2.00+	start_sys_seg	The load-low segment (0x1000) (obsolete)
-020E/2	2.00+	kernel_version	Pointer to kernel version string
-0210/1	2.00+	type_of_loader	Boot loader identifier
-0211/1	2.00+	loadflags	Boot protocol option flags
-0212/2	2.00+	setup_move_size	Move to high memory size (used with hooks)
-0214/4	2.00+	code32_start	Boot loader hook (see below)
-0218/4	2.00+	ramdisk_image	initrd load address (set by boot loader)
-021C/4	2.00+	ramdisk_size	initrd size (set by boot loader)
-0220/4	2.00+	bootsect_kludge	DO NOT USE - for bootsect.S use only
-0224/2	2.01+	heap_end_ptr	Free memory after setup end
-0226/1	2.02+(3 ext_loader_ver	Extended boot loader version
-0227/1	2.02+(3	ext_loader_type	Extended boot loader ID
-0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
-022C/4	2.03+	initrd_addr_max	Highest legal initrd address
-0230/4	2.05+	kernel_alignment Physical addr alignment required for kernel
-0234/1	2.05+	relocatable_kernel Whether kernel is relocatable or not
-0235/1	2.10+	min_alignment	Minimum alignment, as a power of two
-0236/2	2.12+	xloadflags	Boot protocol option flags
-0238/4	2.06+	cmdline_size	Maximum size of the kernel command line
-023C/4	2.07+	hardware_subarch Hardware subarchitecture
-0240/8	2.07+	hardware_subarch_data Subarchitecture-specific data
-0248/4	2.08+	payload_offset	Offset of kernel payload
-024C/4	2.08+	payload_length	Length of kernel payload
-0250/8	2.09+	setup_data	64-bit physical pointer to linked list
-				of struct setup_data
-0258/8	2.10+	pref_address	Preferred loading address
-0260/4	2.10+	init_size	Linear memory required during initialization
-0264/4	2.11+	handover_offset	Offset of handover entry point
+01F1/1  ALL(1)   setup_sects           The size of the setup in sectors
+01F2/2  ALL      root_flags            If set, the root is mounted readonly
+01F4/4  2.04+(2) syssize               The size of the 32-bit code in 16-byte
+				       paras
+01F8/2  ALL      ram_size              DO NOT USE - for bootsect.S use only
+01FA/2  ALL      vid_mode              Video mode control
+01FC/2  ALL      root_dev              Default root device number
+01FE/2  ALL      boot_flag             0xAA55 magic number
+0200/2  2.00+    jump                  Jump instruction
+0202/4  2.00+    header                Magic signature "HdrS"
+0206/2  2.00+    version               Boot protocol version supported
+0208/4  2.00+    realmode_swtch        Boot loader hook (see below)
+020C/2  2.00+    start_sys_seg         The load-low segment (0x1000) (obsolete)
+020E/2  2.00+    kernel_version        Pointer to kernel version string
+0210/1  2.00+    type_of_loader        Boot loader identifier
+0211/1  2.00+    loadflags             Boot protocol option flags
+0212/2  2.00+    setup_move_size       Move to high memory size
+				       (used with hooks)
+0214/4  2.00+    code32_start          Boot loader hook (see below)
+0218/4  2.00+    ramdisk_image         initrd load address (set by boot loader)
+021C/4  2.00+    ramdisk_size          initrd size (set by boot loader)
+0220/4  2.00+    bootsect_kludge       DO NOT USE - for bootsect.S use only
+0224/2  2.01+    heap_end_ptr          Free memory after setup end
+0226/1  2.02+(3) ext_loader_ver        Extended boot loader version
+0227/1  2.02+(3) ext_loader_type       Extended boot loader ID
+0228/4  2.02+    cmd_line_ptr          32-bit pointer to the kernel command line
+022C/4  2.03+    initrd_addr_max       Highest legal initrd address
+0230/4  2.05+    kernel_alignment      Physical addr alignment required for
+				       kernel
+0234/1  2.05+    relocatable_kernel    Whether kernel is relocatable or not
+0235/1  2.10+    min_alignment         Minimum alignment, as a power of two
+0236/2  2.12+    xloadflags            Boot protocol option flags
+0238/4  2.06+    cmdline_size          Maximum size of the kernel command line
+023C/4  2.07+    hardware_subarch      Hardware subarchitecture
+0240/8  2.07+    hardware_subarch_data Subarchitecture-specific data
+0248/4  2.08+    payload_offset        Offset of kernel payload
+024C/4  2.08+    payload_length        Length of kernel payload
+0250/8  2.09+    setup_data            64-bit physical pointer to linked list
+				       of struct setup_data
+0258/8  2.10+    pref_address          Preferred loading address
+0260/4  2.10+    init_size             Linear memory required during
+				       initialization
+0264/4  2.11+    handover_offset       Offset of handover entry point
+======  ======== ===================== ========================================
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
@@ -213,7 +224,7 @@ Offset	Proto	Name		Meaning
 
 If the "HdrS" (0x53726448) magic number is not found at offset 0x202,
 the boot protocol version is "old".  Loading an old kernel, the
-following parameters should be assumed:
+following parameters should be assumed::
 
 	Image type = zImage
 	initrd not supported
@@ -225,7 +236,8 @@ setting fields in the header, you must make sure only to set fields
 supported by the protocol version in use.
 
 
-**** DETAILS OF HEADER FIELDS
+DETAILS OF HEADER FIELDS
+========================
 
 For each field, some are information from the kernel to the bootloader
 ("read"), some are expected to be filled out by the bootloader
@@ -239,106 +251,106 @@ boot loaders can ignore those fields.
 
 The byte order of all fields is littleendian (this is x86, after all.)
 
-Field name:	setup_sects
-Type:		read
-Offset/size:	0x1f1/1
-Protocol:	ALL
+:Field name:     setup_sects
+:Type:           read
+:Offset/size:    0x1f1/1
+:Protocol:       ALL
 
   The size of the setup code in 512-byte sectors.  If this field is
   0, the real value is 4.  The real-mode code consists of the boot
   sector (always one 512-byte sector) plus the setup code.
 
-Field name:	 root_flags
-Type:		 modify (optional)
-Offset/size:	 0x1f2/2
-Protocol:	 ALL
+:Field name:      root_flags
+:Type:            modify (optional)
+:Offset/size:     0x1f2/2
+:Protocol:        ALL
 
   If this field is nonzero, the root defaults to readonly.  The use of
   this field is deprecated; use the "ro" or "rw" options on the
   command line instead.
 
-Field name:	syssize
-Type:		read
-Offset/size:	0x1f4/4 (protocol 2.04+) 0x1f4/2 (protocol ALL)
-Protocol:	2.04+
+:Field name:     syssize
+:Type:           read
+:Offset/size:    0x1f4/4 (protocol 2.04+) 0x1f4/2 (protocol ALL)
+:Protocol:       2.04+
 
   The size of the protected-mode code in units of 16-byte paragraphs.
   For protocol versions older than 2.04 this field is only two bytes
   wide, and therefore cannot be trusted for the size of a kernel if
   the LOAD_HIGH flag is set.
 
-Field name:	ram_size
-Type:		kernel internal
-Offset/size:	0x1f8/2
-Protocol:	ALL
+:Field name:     ram_size
+:Type:           kernel internal
+:Offset/size:    0x1f8/2
+:Protocol:       ALL
 
   This field is obsolete.
 
-Field name:	vid_mode
-Type:		modify (obligatory)
-Offset/size:	0x1fa/2
+:Field name:     vid_mode
+:Type:           modify (obligatory)
+:Offset/size:    0x1fa/2
 
   Please see the section on SPECIAL COMMAND LINE OPTIONS.
 
-Field name:	root_dev
-Type:		modify (optional)
-Offset/size:	0x1fc/2
-Protocol:	ALL
+:Field name:     root_dev
+:Type:           modify (optional)
+:Offset/size:    0x1fc/2
+:Protocol:       ALL
 
   The default root device device number.  The use of this field is
   deprecated, use the "root=" option on the command line instead.
 
-Field name:	boot_flag
-Type:		read
-Offset/size:	0x1fe/2
-Protocol:	ALL
+:Field name:     boot_flag
+:Type:           read
+:Offset/size:    0x1fe/2
+:Protocol:       ALL
 
   Contains 0xAA55.  This is the closest thing old Linux kernels have
   to a magic number.
 
-Field name:	jump
-Type:		read
-Offset/size:	0x200/2
-Protocol:	2.00+
+:Field name:     jump
+:Type:           read
+:Offset/size:    0x200/2
+:Protocol:       2.00+
 
   Contains an x86 jump instruction, 0xEB followed by a signed offset
   relative to byte 0x202.  This can be used to determine the size of
   the header.
 
-Field name:	header
-Type:		read
-Offset/size:	0x202/4
-Protocol:	2.00+
+:Field name:     header
+:Type:           read
+:Offset/size:    0x202/4
+:Protocol:       2.00+
 
   Contains the magic number "HdrS" (0x53726448).
 
-Field name:	version
-Type:		read
-Offset/size:	0x206/2
-Protocol:	2.00+
+:Field name:     version
+:Type:           read
+:Offset/size:    0x206/2
+:Protocol:       2.00+
 
   Contains the boot protocol version, in (major << 8)+minor format,
   e.g. 0x0204 for version 2.04, and 0x0a11 for a hypothetical version
   10.17.
 
-Field name:	realmode_swtch
-Type:		modify (optional)
-Offset/size:	0x208/4
-Protocol:	2.00+
+:Field name:     realmode_swtch
+:Type:           modify (optional)
+:Offset/size:    0x208/4
+:Protocol:       2.00+
 
   Boot loader hook (see ADVANCED BOOT LOADER HOOKS below.)
 
-Field name:	start_sys_seg
-Type:		read
-Offset/size:	0x20c/2
-Protocol:	2.00+
+:Field name:     start_sys_seg
+:Type:           read
+:Offset/size:    0x20c/2
+:Protocol:       2.00+
 
   The load low segment (0x1000).  Obsolete.
 
-Field name:	kernel_version
-Type:		read
-Offset/size:	0x20e/2
-Protocol:	2.00+
+:Field name:     kernel_version
+:Type:           read
+:Offset/size:    0x20e/2
+:Protocol:       2.00+
 
   If set to a nonzero value, contains a pointer to a NUL-terminated
   human-readable kernel version number string, less 0x200.  This can
@@ -348,17 +360,17 @@ Protocol:	2.00+
   For example, if this value is set to 0x1c00, the kernel version
   number string can be found at offset 0x1e00 in the kernel file.
   This is a valid value if and only if the "setup_sects" field
-  contains the value 15 or higher, as:
+  contains the value 15 or higher, as::
 
 	0x1c00  < 15*0x200 (= 0x1e00) but
 	0x1c00 >= 14*0x200 (= 0x1c00)
 
 	0x1c00 >> 9 = 14, so the minimum value for setup_secs is 15.
 
-Field name:	type_of_loader
-Type:		write (obligatory)
-Offset/size:	0x210/1
-Protocol:	2.00+
+:Field name:     type_of_loader
+:Type:           write (obligatory)
+:Offset/size:    0x210/1
+:Protocol:       2.00+
 
   If your boot loader has an assigned id (see table below), enter
   0xTV here, where T is an identifier for the boot loader and V is
@@ -369,13 +381,13 @@ Protocol:	2.00+
   Similarly, the ext_loader_ver field can be used to provide more than
   four bits for the bootloader version.
 
-  For example, for T = 0x15, V = 0x234, write:
+  For example, for T = 0x15, V = 0x234, write::
 
-  type_of_loader  <- 0xE4
-  ext_loader_type <- 0x05
-  ext_loader_ver  <- 0x23
+    type_of_loader  <- 0xE4
+    ext_loader_type <- 0x05
+    ext_loader_ver  <- 0x23
 
-  Assigned boot loader ids (hexadecimal):
+  Assigned boot loader ids (hexadecimal)::
 
 	0  LILO			(0x00 reserved for pre-2.00 bootloader)
 	1  Loadlin
@@ -399,10 +411,10 @@ Protocol:	2.00+
   Please contact <hpa@zytor.com> if you need a bootloader ID
   value assigned.
 
-Field name:	loadflags
-Type:		modify (obligatory)
-Offset/size:	0x211/1
-Protocol:	2.00+
+:Field name:     loadflags
+:Type:           modify (obligatory)
+:Offset/size:    0x211/1
+:Protocol:       2.00+
 
   This field is a bitmask.
 
@@ -419,14 +431,17 @@ Protocol:	2.00+
   Bit 5 (write): QUIET_FLAG
 	- If 0, print early messages.
 	- If 1, suppress early messages.
+
 		This requests to the kernel (decompressor and early
 		kernel) to not write early messages that require
 		accessing the display hardware directly.
 
   Bit 6 (write): KEEP_SEGMENTS
 	Protocol: 2.07+
+
 	- If 0, reload the segment registers in the 32bit entry point.
 	- If 1, do not reload the segment registers in the 32bit entry point.
+
 		Assume that %cs %ds %ss %es are all set to flat segments with
 		a base of 0 (or the equivalent for their environment).
 
@@ -435,10 +450,10 @@ Protocol:	2.00+
 	heap_end_ptr is valid.  If this field is clear, some setup code
 	functionality will be disabled.
 
-Field name:	setup_move_size
-Type:		modify (obligatory)
-Offset/size:	0x212/2
-Protocol:	2.00-2.01
+:Field name:     setup_move_size
+:Type:           modify (obligatory)
+:Offset/size:    0x212/2
+:Protocol:       2.00-2.01
 
   When using protocol 2.00 or 2.01, if the real mode kernel is not
   loaded at 0x90000, it gets moved there later in the loading
@@ -447,14 +462,14 @@ Protocol:	2.00-2.01
   itself.
 
   The unit is bytes starting with the beginning of the boot sector.
-  
+
   This field is can be ignored when the protocol is 2.02 or higher, or
   if the real-mode code is loaded at 0x90000.
 
-Field name:	code32_start
-Type:		modify (optional, reloc)
-Offset/size:	0x214/4
-Protocol:	2.00+
+:Field name:     code32_start
+:Type:           modify (optional, reloc)
+:Offset/size:    0x214/4
+:Protocol:       2.00+
 
   The address to jump to in protected mode.  This defaults to the load
   address of the kernel, and can be used by the boot loader to
@@ -468,41 +483,41 @@ Protocol:	2.00+
      relocatable kernel at a nonstandard address it will have to modify
      this field to point to the load address.
 
-Field name:	ramdisk_image
-Type:		write (obligatory)
-Offset/size:	0x218/4
-Protocol:	2.00+
+:Field name:     ramdisk_image
+:Type:           write (obligatory)
+:Offset/size:    0x218/4
+:Protocol:       2.00+
 
   The 32-bit linear address of the initial ramdisk or ramfs.  Leave at
   zero if there is no initial ramdisk/ramfs.
 
-Field name:	ramdisk_size
-Type:		write (obligatory)
-Offset/size:	0x21c/4
-Protocol:	2.00+
+:Field name:     ramdisk_size
+:Type:           write (obligatory)
+:Offset/size:    0x21c/4
+:Protocol:       2.00+
 
   Size of the initial ramdisk or ramfs.  Leave at zero if there is no
   initial ramdisk/ramfs.
 
-Field name:	bootsect_kludge
-Type:		kernel internal
-Offset/size:	0x220/4
-Protocol:	2.00+
+:Field name:     bootsect_kludge
+:Type:           kernel internal
+:Offset/size:    0x220/4
+:Protocol:       2.00+
 
   This field is obsolete.
 
-Field name:	heap_end_ptr
-Type:		write (obligatory)
-Offset/size:	0x224/2
-Protocol:	2.01+
+:Field name:     heap_end_ptr
+:Type:           write (obligatory)
+:Offset/size:    0x224/2
+:Protocol:       2.01+
 
   Set this field to the offset (from the beginning of the real-mode
   code) of the end of the setup stack/heap, minus 0x0200.
 
-Field name:	ext_loader_ver
-Type:		write (optional)
-Offset/size:	0x226/1
-Protocol:	2.02+
+:Field name:     ext_loader_ver
+:Type:           write (optional)
+:Offset/size:    0x226/1
+:Protocol:       2.02+
 
   This field is used as an extension of the version number in the
   type_of_loader field.  The total version number is considered to be
@@ -514,10 +529,10 @@ Protocol:	2.02+
   Kernels prior to 2.6.31 did not recognize this field, but it is safe
   to write for protocol version 2.02 or higher.
 
-Field name:	ext_loader_type
-Type:		write (obligatory if (type_of_loader & 0xf0) == 0xe0)
-Offset/size:	0x227/1
-Protocol:	2.02+
+:Field name:     ext_loader_type
+:Type:           write (obligatory if (type_of_loader & 0xf0) == 0xe0)
+:Offset/size:    0x227/1
+:Protocol:       2.02+
 
   This field is used as an extension of the type number in
   type_of_loader field.  If the type in type_of_loader is 0xE, then
@@ -528,10 +543,10 @@ Protocol:	2.02+
   Kernels prior to 2.6.31 did not recognize this field, but it is safe
   to write for protocol version 2.02 or higher.
 
-Field name:	cmd_line_ptr
-Type:		write (obligatory)
-Offset/size:	0x228/4
-Protocol:	2.02+
+:Field name:     cmd_line_ptr
+:Type:           write (obligatory)
+:Offset/size:    0x228/4
+:Protocol:       2.02+
 
   Set this field to the linear address of the kernel command line.
   The kernel command line can be located anywhere between the end of
@@ -544,10 +559,10 @@ Protocol:	2.02+
   zero, the kernel will assume that your boot loader does not support
   the 2.02+ protocol.
 
-Field name:	initrd_addr_max
-Type:		read
-Offset/size:	0x22c/4
-Protocol:	2.03+
+:Field name:     initrd_addr_max
+:Type:           read
+:Offset/size:    0x22c/4
+:Protocol:       2.03+
 
   The maximum address that may be occupied by the initial
   ramdisk/ramfs contents.  For boot protocols 2.02 or earlier, this
@@ -556,10 +571,10 @@ Protocol:	2.03+
   your ramdisk is exactly 131072 bytes long and this field is
   0x37FFFFFF, you can start your ramdisk at 0x37FE0000.)
 
-Field name:	kernel_alignment
-Type:		read/modify (reloc)
-Offset/size:	0x230/4
-Protocol:	2.05+ (read), 2.10+ (modify)
+:Field name:     kernel_alignment
+:Type:           read/modify (reloc)
+:Offset/size:    0x230/4
+:Protocol:       2.05+ (read), 2.10+ (modify)
 
   Alignment unit required by the kernel (if relocatable_kernel is
   true.)  A relocatable kernel that is loaded at an alignment
@@ -571,20 +586,20 @@ Protocol:	2.05+ (read), 2.10+ (modify)
   loader to modify this field to permit a lesser alignment.  See the
   min_alignment and pref_address field below.
 
-Field name:	relocatable_kernel
-Type:		read (reloc)
-Offset/size:	0x234/1
-Protocol:	2.05+
+:Field name:     relocatable_kernel
+:Type:           read (reloc)
+:Offset/size:    0x234/1
+:Protocol:       2.05+
 
   If this field is nonzero, the protected-mode part of the kernel can
   be loaded at any address that satisfies the kernel_alignment field.
   After loading, the boot loader must set the code32_start field to
   point to the loaded code, or to a boot loader hook.
 
-Field name:	min_alignment
-Type:		read (reloc)
-Offset/size:	0x235/1
-Protocol:	2.10+
+:Field name:     min_alignment
+:Type:           read (reloc)
+:Offset/size:    0x235/1
+:Protocol:       2.10+
 
   This field, if nonzero, indicates as a power of two the minimum
   alignment required, as opposed to preferred, by the kernel to boot.
@@ -597,10 +612,10 @@ Protocol:	2.10+
   misaligned kernel.  Therefore, a loader should typically try each
   power-of-two alignment from kernel_alignment down to this alignment.
 
-Field name:     xloadflags
-Type:           read
-Offset/size:    0x236/2
-Protocol:       2.12+
+:Field name:     xloadflags
+:Type:           read
+:Offset/size:    0x236/2
+:Protocol:       2.12+
 
   This field is a bitmask.
 
@@ -608,33 +623,33 @@ Protocol:       2.12+
 	- If 1, this kernel has the legacy 64-bit entry point at 0x200.
 
   Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
-        - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
+	- If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
 
   Bit 2 (read):	XLF_EFI_HANDOVER_32
 	- If 1, the kernel supports the 32-bit EFI handoff entry point
-          given at handover_offset.
+	  given at handover_offset.
 
   Bit 3 (read): XLF_EFI_HANDOVER_64
 	- If 1, the kernel supports the 64-bit EFI handoff entry point
-          given at handover_offset + 0x200.
+	  given at handover_offset + 0x200.
 
   Bit 4 (read): XLF_EFI_KEXEC
 	- If 1, the kernel supports kexec EFI boot with EFI runtime support.
 
-Field name:	cmdline_size
-Type:		read
-Offset/size:	0x238/4
-Protocol:	2.06+
+:Field name:     cmdline_size
+:Type:           read
+:Offset/size:    0x238/4
+:Protocol:       2.06+
 
   The maximum size of the command line without the terminating
   zero. This means that the command line can contain at most
   cmdline_size characters. With protocol version 2.05 and earlier, the
   maximum size was 255.
 
-Field name:	hardware_subarch
-Type:		write (optional, defaults to x86/PC)
-Offset/size:	0x23c/4
-Protocol:	2.07+
+:Field name:     hardware_subarch
+:Type:           write (optional, defaults to x86/PC)
+:Offset/size:    0x23c/4
+:Protocol:       2.07+
 
   In a paravirtualized environment the hardware low level architectural
   pieces such as interrupt handling, page table handling, and
@@ -643,25 +658,27 @@ Protocol:	2.07+
   This field allows the bootloader to inform the kernel we are in one
   one of those environments.
 
+  ==========	==============================
   0x00000000	The default x86/PC environment
   0x00000001	lguest
   0x00000002	Xen
   0x00000003	Moorestown MID
   0x00000004	CE4100 TV Platform
+  ==========	==============================
 
-Field name:	hardware_subarch_data
-Type:		write (subarch-dependent)
-Offset/size:	0x240/8
-Protocol:	2.07+
+:Field name:     hardware_subarch_data
+:Type:           write (subarch-dependent)
+:Offset/size:    0x240/8
+:Protocol:       2.07+
 
   A pointer to data that is specific to hardware subarch
   This field is currently unused for the default x86/PC environment,
   do not modify.
 
-Field name:	payload_offset
-Type:		read
-Offset/size:	0x248/4
-Protocol:	2.08+
+:Field name:     payload_offset
+:Type:           read
+:Offset/size:    0x248/4
+:Protocol:       2.08+
 
   If non-zero then this field contains the offset from the beginning
   of the protected-mode code to the payload.
@@ -674,29 +691,29 @@ Protocol:	2.08+
   02 21).  The uncompressed payload is currently always ELF (magic
   number 7F 45 4C 46).
 
-Field name:	payload_length
-Type:		read
-Offset/size:	0x24c/4
-Protocol:	2.08+
+:Field name:     payload_length
+:Type:           read
+:Offset/size:    0x24c/4
+:Protocol:       2.08+
 
   The length of the payload.
 
-Field name:	setup_data
-Type:		write (special)
-Offset/size:	0x250/8
-Protocol:	2.09+
+:Field name:     setup_data
+:Type:           write (special)
+:Offset/size:    0x250/8
+:Protocol:       2.09+
 
   The 64-bit physical pointer to NULL terminated single linked list of
   struct setup_data. This is used to define a more extensible boot
   parameters passing mechanism. The definition of struct setup_data is
-  as follow:
+  as follow::
 
-  struct setup_data {
+    struct setup_data {
 	  u64 next;
 	  u32 type;
 	  u32 len;
 	  u8  data[0];
-  };
+    };
 
   Where, the next is a 64-bit physical pointer to the next node of
   linked list, the next field of the last node is 0; the type is used
@@ -708,10 +725,10 @@ Protocol:	2.09+
   sure to consider the case where the linked list already contains
   entries.
 
-Field name:	pref_address
-Type:		read (reloc)
-Offset/size:	0x258/8
-Protocol:	2.10+
+:Field name:     pref_address
+:Type:           read (reloc)
+:Offset/size:    0x258/8
+:Protocol:       2.10+
 
   This field, if nonzero, represents a preferred load address for the
   kernel.  A relocating bootloader should attempt to load at this
@@ -720,9 +737,9 @@ Protocol:	2.10+
   A non-relocatable kernel will unconditionally move itself and to run
   at this address.
 
-Field name:	init_size
-Type:		read
-Offset/size:	0x260/4
+:Field name:     init_size
+:Type:           read
+:Offset/size:    0x260/4
 
   This field indicates the amount of linear contiguous memory starting
   at the kernel runtime start address that the kernel needs before it
@@ -738,9 +755,9 @@ Offset/size:	0x260/4
   else
 	runtime_start = pref_address
 
-Field name:	handover_offset
-Type:		read
-Offset/size:	0x264/4
+:Field name:     handover_offset
+:Type:           read
+:Offset/size:    0x264/4
 
   This field is the offset from the beginning of the kernel image to
   the EFI handover protocol entry point. Boot loaders using the EFI
@@ -749,7 +766,8 @@ Offset/size:	0x264/4
   See EFI HANDOVER PROTOCOL below for more details.
 
 
-**** THE IMAGE CHECKSUM
+THE IMAGE CHECKSUM
+==================
 
 From boot protocol version 2.08 onwards the CRC-32 is calculated over
 the entire file using the characteristic polynomial 0x04C11DB7 and an
@@ -758,7 +776,8 @@ file; therefore the CRC of the file up to the limit specified in the
 syssize field of the header is always 0.
 
 
-**** THE KERNEL COMMAND LINE
+THE KERNEL COMMAND LINE
+=======================
 
 The kernel command line has become an important way for the boot
 loader to communicate with the kernel.  Some of its options are also
@@ -784,13 +803,14 @@ command line is entered using the following protocol:
 	At offset 0x0022 (word), "cmd_line_offset", enter the offset
 	of the kernel command line (relative to the start of the
 	real-mode kernel).
-	
+
 	The kernel command line *must* be within the memory region
 	covered by setup_move_size, so you may need to adjust this
 	field.
 
 
-**** MEMORY LAYOUT OF THE REAL-MODE CODE
+MEMORY LAYOUT OF THE REAL-MODE CODE
+===================================
 
 The real-mode code requires a stack/heap to be set up, as well as
 memory allocated for the kernel command line.  This needs to be done
@@ -806,7 +826,7 @@ segment has to be used:
 	- When loading a zImage kernel ((loadflags & 0x01) == 0).
 	- When loading a 2.01 or earlier boot protocol kernel.
 
-	  -> For the 2.00 and 2.01 boot protocols, the real-mode code
+	  -  For the 2.00 and 2.01 boot protocols, the real-mode code
 	     can be loaded at another address, but it is internally
 	     relocated to 0x90000.  For the "old" protocol, the
 	     real-mode code must be loaded at 0x90000.
@@ -822,24 +842,29 @@ The kernel command line should not be located below the real-mode
 code, nor should it be located in high memory.
 
 
-**** SAMPLE BOOT CONFIGURATION
+SAMPLE BOOT CONFIGURATION
+=========================
 
 As a sample configuration, assume the following layout of the real
 mode segment:
 
     When loading below 0x90000, use the entire segment:
 
+	=============	===================
 	0x0000-0x7fff	Real mode kernel
 	0x8000-0xdfff	Stack and heap
 	0xe000-0xffff	Kernel command line
+	=============	===================
 
     When loading at 0x90000 OR the protocol version is 2.01 or earlier:
 
+	=============	===================
 	0x0000-0x7fff	Real mode kernel
 	0x8000-0x97ff	Stack and heap
 	0x9800-0x9fff	Kernel command line
+	=============	===================
 
-Such a boot loader should enter the following fields in the header:
+Such a boot loader should enter the following fields in the header::
 
 	unsigned long base_ptr;	/* base address for real-mode segment */
 
@@ -887,7 +912,7 @@ Such a boot loader should enter the following fields in the header:
 		if ( base_ptr != 0x90000 ) {
 			/* Copy the real-mode kernel */
 			memcpy(0x90000, base_ptr, (setup_sects+1)*512);
-			base_ptr = 0x90000;		 /* Relocated */
+			base_ptr = 0x90000;		/* Relocated */
 		}
 
 		strcpy(0x90000+cmd_line_offset, cmdline);
@@ -898,7 +923,8 @@ Such a boot loader should enter the following fields in the header:
 	}
 
 
-**** LOADING THE REST OF THE KERNEL
+LOADING THE REST OF THE KERNEL
+==============================
 
 The 32-bit (non-real-mode) kernel starts at offset (setup_sects+1)*512
 in the kernel file (again, if setup_sects == 0 the real value is 4.)
@@ -917,7 +943,8 @@ much a requirement for these kernels to load the real-mode part at
 0x90000.  bzImage kernels allow much more flexibility.
 
 
-**** SPECIAL COMMAND LINE OPTIONS
+SPECIAL COMMAND LINE OPTIONS
+============================
 
 If the command line provided by the boot loader is entered by the
 user, the user may expect the following command line options to work.
@@ -966,7 +993,8 @@ or configuration-specified command line.  Otherwise, "init=/bin/sh"
 gets confused by the "auto" option.
 
 
-**** RUNNING THE KERNEL
+RUNNING THE KERNEL
+==================
 
 The kernel is started by jumping to the kernel entry point, which is
 located at *segment* offset 0x20 from the start of the real mode
@@ -980,7 +1008,7 @@ interrupts should be disabled.  Furthermore, to guard against bugs in
 the kernel, it is recommended that the boot loader sets fs = gs = ds =
 es = ss.
 
-In our example from above, we would do:
+In our example from above, we would do::
 
 	/* Note: in the case of the "old" kernel protocol, base_ptr must
 	   be == 0x90000 at this point; see the previous sample code */
@@ -1003,7 +1031,8 @@ switched off, especially if the loaded kernel has the floppy driver as
 a demand-loaded module!
 
 
-**** ADVANCED BOOT LOADER HOOKS
+ADVANCED BOOT LOADER HOOKS
+==========================
 
 If the boot loader runs in a particularly hostile environment (such as
 LOADLIN, which runs under DOS) it may be impossible to follow the
@@ -1032,7 +1061,8 @@ IMPORTANT: All the hooks are required to preserve %esp, %ebp, %esi and
 	(relocated, if appropriate.)
 
 
-**** 32-bit BOOT PROTOCOL
+32-bit BOOT PROTOCOL
+====================
 
 For machine with some new BIOS other than legacy BIOS, such as EFI,
 LinuxBIOS, etc, and kexec, the 16-bit real mode setup code in kernel
@@ -1069,7 +1099,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %esi must hold the base
 address of the struct boot_params; %ebp, %edi and %ebx must be zero.
 
-**** 64-bit BOOT PROTOCOL
+64-bit BOOT PROTOCOL
+====================
 
 For machine with 64bit cpus and 64bit kernel, we could use 64bit bootloader
 and we need a 64-bit boot protocol.
@@ -1107,7 +1138,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
 address of the struct boot_params.
 
-**** EFI HANDOVER PROTOCOL
+EFI HANDOVER PROTOCOL
+=====================
 
 This protocol allows boot loaders to defer initialisation to the EFI
 boot stub. The boot loader is required to load the kernel/initrd(s)
@@ -1115,7 +1147,7 @@ from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
 
-The function prototype for the handover entry point looks like this,
+The function prototype for the handover entry point looks like this::
 
     efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
 
diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.txt
index 46933e06c972..22d809aae387 100644
--- a/Documentation/x86/earlyprintk.txt
+++ b/Documentation/x86/earlyprintk.txt
@@ -1,3 +1,6 @@
+==============================================
+Mini-HOWTO for using the earlyprintk parameter
+==============================================
 
 Mini-HOWTO for using the earlyprintk=dbgp boot option with a
 USB2 Debug port key and a debug cable, on x86 systems.
@@ -5,47 +8,48 @@ USB2 Debug port key and a debug cable, on x86 systems.
 You need two computers, the 'USB debug key' special gadget and
 and two USB cables, connected like this:
 
-  [host/target] <-------> [USB debug key] <-------> [client/console]
+  [host/target] <------> [USB debug key] <------> [client/console]
 
 1. There are a number of specific hardware requirements:
 
- a.) Host/target system needs to have USB debug port capability.
+ a.  Host/target system needs to have USB debug port capability.
 
- You can check this capability by looking at a 'Debug port' bit in
- the lspci -vvv output:
+     You can check this capability by looking at a 'Debug port' bit in
+     the lspci -vvv output::
 
- # lspci -vvv
- ...
- 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
-         Subsystem: Lenovo ThinkPad T61
-         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
-         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-         Latency: 0
-         Interrupt: pin D routed to IRQ 19
-         Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
-         Capabilities: [50] Power Management version 2
-                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
-         Capabilities: [58] Debug port: BAR=1 offset=00a0
-                            ^^^^^^^^^^^ <==================== [ HERE ]
-	 Kernel driver in use: ehci_hcd
-         Kernel modules: ehci-hcd
- ...
+      # lspci -vvv
+      ...
+      00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
+              Subsystem: Lenovo ThinkPad T61
+              Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
+              Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+              Latency: 0
+              Interrupt: pin D routed to IRQ 19
+              Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
+              Capabilities: [50] Power Management version 2
+                      Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+                      Status: D0 PME-Enable- DSel=0 DScale=0 PME+
+              Capabilities: [58] Debug port: BAR=1 offset=00a0
+                                 ^^^^^^^^^^^ <==================== [ HERE ]
+	      Kernel driver in use: ehci_hcd
+              Kernel modules: ehci-hcd
+      ...
 
-( If your system does not list a debug port capability then you probably
-  won't be able to use the USB debug key. )
+     NOTE:
+       If your system does not list a debug port capability then you probably
+       won't be able to use the USB debug key.
 
- b.) You also need a NetChip USB debug cable/key:
+ b.  You also need a NetChip USB debug cable/key:
 
         http://www.plxtech.com/products/NET2000/NET20DC/default.asp
 
      This is a small blue plastic connector with two USB connections;
      it draws power from its USB connections.
 
- c.) You need a second client/console system with a high speed USB 2.0
+ c.  You need a second client/console system with a high speed USB 2.0
      port.
 
- d.) The NetChip device must be plugged directly into the physical
+ d.  The NetChip device must be plugged directly into the physical
      debug port on the "host/target" system.  You cannot use a USB hub in
      between the physical debug port and the "host/target" system.
 
@@ -65,7 +69,7 @@ and two USB cables, connected like this:
      to the hardware vendor, because there is no reason not to wire
      this port into one of the physically accessible ports.
 
- e.) It is also important to note, that many versions of the NetChip
+ e.  It is also important to note, that many versions of the NetChip
      device require the "client/console" system to be plugged into the
      right hand side of the device (with the product logo facing up and
      readable left to right).  The reason being is that the 5 volt
@@ -74,7 +78,7 @@ and two USB cables, connected like this:
 
 2. Software requirements:
 
- a.) On the host/target system:
+ a.  On the host/target system:
 
     You need to enable the following kernel config option:
 
@@ -82,12 +86,13 @@ and two USB cables, connected like this:
 
     And you need to add the boot command line: "earlyprintk=dbgp".
 
-    (If you are using Grub, append it to the 'kernel' line in
+    Note:
+     If you are using Grub, append it to the 'kernel' line in
      /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
      append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
      using Grub2 on an EFI firmware system, append it to the 'linux'
      or 'linuxefi' line in /boot/grub2/grub.cfg or
-     /boot/efi/EFI/<distro>/grub.cfg.)
+     /boot/efi/EFI/<distro>/grub.cfg.
 
     On systems with more than one EHCI debug controller you must
     specify the correct EHCI debug controller number.  The ordering
@@ -101,7 +106,7 @@ and two USB cables, connected like this:
     this channel open beyond early bootup. This can be useful for
     debugging crashes under Xorg, etc.
 
- b.) On the client/console system:
+ b.  On the client/console system:
 
     You should enable the following kernel config option:
 
@@ -115,7 +120,7 @@ and two USB cables, connected like this:
     it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
     see the raw output.
 
- c.) On Nvidia Southbridge based systems: the kernel will try to probe
+ c.  On Nvidia Southbridge based systems: the kernel will try to probe
      and find out which port has a debug device connected.
 
 3. Testing that it works fine:
diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.txt
index c1df8eba9dfd..5fde68a19f57 100644
--- a/Documentation/x86/entry_64.txt
+++ b/Documentation/x86/entry_64.txt
@@ -1,3 +1,8 @@
+=====================
+Entries at entry_64.S
+=====================
+
+
 This file documents some of the kernel entries in
 arch/x86/entry/entry_64.S.  A lot of this explanation is adapted from
 an email from Ingo Molnar:
@@ -59,7 +64,7 @@ Now, there's a secondary complication: there's a cheap way to test
 which mode the CPU is in and an expensive way.
 
 The cheap way is to pick this info off the entry frame on the kernel
-stack, from the CS of the ptregs area of the kernel stack:
+stack, from the CS of the ptregs area of the kernel stack::
 
 	xorl %ebx,%ebx
 	testl $3,CS+8(%rsp)
@@ -67,7 +72,7 @@ stack, from the CS of the ptregs area of the kernel stack:
 	SWAPGS
 
 The expensive (paranoid) way is to read back the MSR_GS_BASE value
-(which is what SWAPGS modifies):
+(which is what SWAPGS modifies)::
 
 	movl $1,%ebx
 	movl $MSR_GS_BASE,%ecx
@@ -76,7 +81,7 @@ The expensive (paranoid) way is to read back the MSR_GS_BASE value
 	js 1f   /* negative -> in kernel */
 	SWAPGS
 	xorl %ebx,%ebx
-1:	ret
+  1:	ret
 
 If we are at an interrupt or user-trap/gate-alike boundary then we can
 use the faster check: the stack will be a reliable indicator of
diff --git a/Documentation/x86/exception-tables.txt b/Documentation/x86/exception-tables.txt
index e396bcd8d830..6929c84c65b6 100644
--- a/Documentation/x86/exception-tables.txt
+++ b/Documentation/x86/exception-tables.txt
@@ -1,4 +1,7 @@
-     Kernel level exception handling in Linux
+========================================
+Kernel level exception handling in Linux
+========================================
+
   Commentary by Joerg Pommnitz <joerg@raleigh.ibm.com>
 
 When a process runs in kernel mode, it often has to access user
@@ -22,12 +25,13 @@ To overcome this situation, Linus decided to let the virtual memory
 hardware present in every Linux-capable CPU handle this test.
 
 How does this work?
+===================
 
 Whenever the kernel tries to access an address that is currently not
 accessible, the CPU generates a page fault exception and calls the
-page fault handler
+page fault handler::
 
-void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+  void do_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 in arch/x86/mm/fault.c. The parameters on the stack are set up by
 the low level assembly glue in arch/x86/kernel/entry_32.S. The parameter
@@ -49,6 +53,7 @@ return address (again regs->eip) and returns. The execution will
 continue at the address in fixup.
 
 Where does fixup point to?
+==========================
 
 Since we jump to the contents of fixup, fixup obviously points
 to executable code. This code is hidden inside the user access macros.
@@ -58,72 +63,73 @@ the code generated by the preprocessor and the compiler. I selected
 the get_user call in drivers/char/sysrq.c for a detailed examination.
 
 The original code in sysrq.c line 587:
+
         get_user(c, buf);
 
-The preprocessor output (edited to become somewhat readable):
+The preprocessor output (edited to become somewhat readable)::
 
-(
-  {
-    long __gu_err = - 14 , __gu_val = 0;
-    const __typeof__(*( (  buf ) )) *__gu_addr = ((buf));
-    if (((((0 + current_set[0])->tss.segment) == 0x18 )  ||
-       (((sizeof(*(buf))) <= 0xC0000000UL) &&
-       ((unsigned long)(__gu_addr ) <= 0xC0000000UL - (sizeof(*(buf)))))))
-      do {
-        __gu_err  = 0;
-        switch ((sizeof(*(buf)))) {
-          case 1:
-            __asm__ __volatile__(
-              "1:      mov" "b" " %2,%" "b" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "b" " %" "b" "1,%" "b" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"
-              "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=q" (__gu_val): "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  )) ;
-              break;
-          case 2:
-            __asm__ __volatile__(
-              "1:      mov" "w" " %2,%" "w" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "w" " %" "w" "1,%" "w" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"
-              "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  ));
-              break;
-          case 4:
-            __asm__ __volatile__(
-              "1:      mov" "l" " %2,%" "" "1\n"
-              "2:\n"
-              ".section .fixup,\"ax\"\n"
-              "3:      movl %3,%0\n"
-              "        xor" "l" " %" "" "1,%" "" "1\n"
-              "        jmp 2b\n"
-              ".section __ex_table,\"a\"\n"
-              "        .align 4\n"        "        .long 1b,3b\n"
-              ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
-                            (   __gu_addr   )) ), "i"(- 14 ), "0"(__gu_err));
-              break;
-          default:
-            (__gu_val) = __get_user_bad();
-        }
-      } while (0) ;
-    ((c)) = (__typeof__(*((buf))))__gu_val;
-    __gu_err;
-  }
-);
+  (
+    {
+      long __gu_err = - 14 , __gu_val = 0;
+      const __typeof__(*( (  buf ) )) *__gu_addr = ((buf));
+      if (((((0 + current_set[0])->tss.segment) == 0x18 )  ||
+         (((sizeof(*(buf))) <= 0xC0000000UL) &&
+         ((unsigned long)(__gu_addr ) <= 0xC0000000UL - (sizeof(*(buf)))))))
+        do {
+          __gu_err  = 0;
+          switch ((sizeof(*(buf)))) {
+            case 1:
+              __asm__ __volatile__(
+                "1:      mov" "b" " %2,%" "b" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "b" " %" "b" "1,%" "b" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"
+                "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=q" (__gu_val): "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  )) ;
+                break;
+            case 2:
+              __asm__ __volatile__(
+                "1:      mov" "w" " %2,%" "w" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "w" " %" "w" "1,%" "w" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"
+                "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(  __gu_err  ));
+                break;
+            case 4:
+              __asm__ __volatile__(
+                "1:      mov" "l" " %2,%" "" "1\n"
+                "2:\n"
+                ".section .fixup,\"ax\"\n"
+                "3:      movl %3,%0\n"
+                "        xor" "l" " %" "" "1,%" "" "1\n"
+                "        jmp 2b\n"
+                ".section __ex_table,\"a\"\n"
+                "        .align 4\n"        "        .long 1b,3b\n"
+                ".text"        : "=r"(__gu_err), "=r" (__gu_val) : "m"((*(struct __large_struct *)
+                              (   __gu_addr   )) ), "i"(- 14 ), "0"(__gu_err));
+                break;
+            default:
+              (__gu_val) = __get_user_bad();
+          }
+        } while (0) ;
+      ((c)) = (__typeof__(*((buf))))__gu_val;
+      __gu_err;
+    }
+  );
 
 WOW! Black GCC/assembly magic. This is impossible to follow, so let's
-see what code gcc generates:
+see what code gcc generates::
 
  >         xorl %edx,%edx
  >         movl current_set,%eax
@@ -154,7 +160,7 @@ understand. Can we? The actual user access is quite obvious. Thanks
 to the unified address space we can just access the address in user
 memory. But what does the .section stuff do?????
 
-To understand this we have to look at the final kernel:
+To understand this we have to look at the final kernel::
 
  > objdump --section-headers vmlinux
  >
@@ -181,7 +187,7 @@ To understand this we have to look at the final kernel:
 
 There are obviously 2 non standard ELF sections in the generated object
 file. But first we want to find out what happened to our code in the
-final kernel executable:
+final kernel executable::
 
  > objdump --disassemble --section=.text vmlinux
  >
@@ -199,7 +205,7 @@ final kernel executable:
 The whole user memory access is reduced to 10 x86 machine instructions.
 The instructions bracketed in the .section directives are no longer
 in the normal execution path. They are located in a different section
-of the executable file:
+of the executable file::
 
  > objdump --disassemble --section=.fixup vmlinux
  >
@@ -207,14 +213,15 @@ of the executable file:
  > c0199ffa <.fixup+10ba> xorb   %dl,%dl
  > c0199ffc <.fixup+10bc> jmp    c017e7a7 <do_con_write+e3>
 
-And finally:
+And finally::
+
  > objdump --full-contents --section=__ex_table vmlinux
  >
  >  c01aa7c4 93c017c0 e09f19c0 97c017c0 99c017c0  ................
  >  c01aa7d4 f6c217c0 e99f19c0 a5e717c0 f59f19c0  ................
  >  c01aa7e4 080a18c0 01a019c0 0a0a18c0 04a019c0  ................
 
-or in human readable byte order:
+or in human readable byte order::
 
  >  c01aa7c4 c017c093 c0199fe0 c017c097 c017c099  ................
  >  c01aa7d4 c017c2f6 c0199fe9 c017e7a5 c0199ff5  ................
@@ -222,58 +229,84 @@ or in human readable byte order:
                                this is the interesting part!
  >  c01aa7e4 c0180a08 c019a001 c0180a0a c019a004  ................
 
-What happened? The assembly directives
+What happened? The assembly directives:
 
-.section .fixup,"ax"
-.section __ex_table,"a"
+  .section .fixup,"ax"
+  .section __ex_table,"a"
 
 told the assembler to move the following code to the specified
-sections in the ELF object file. So the instructions
-3:      movl $-14,%eax
-        xorb %dl,%dl
-        jmp 2b
-ended up in the .fixup section of the object file and the addresses
+sections in the ELF object file. So the instructions::
+
+  3:      movl $-14,%eax
+          xorb %dl,%dl
+          jmp 2b
+
+ended up in the .fixup section of the object file and the addresses::
+
         .long 1b,3b
+
 ended up in the __ex_table section of the object file. 1b and 3b
 are local labels. The local label 1b (1b stands for next label 1
 backward) is the address of the instruction that might fault, i.e.
 in our case the address of the label 1 is c017e7a5:
-the original assembly code: > 1:      movb (%ebx),%dl
-and linked in vmlinux     : > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
+
+the original assembly code::
+
+	> 1:      movb (%ebx),%dl
+
+and linked in vmlinux::
+
+	> c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
 
 The local label 3 (backwards again) is the address of the code to handle
 the fault, in our case the actual value is c0199ff5:
-the original assembly code: > 3:      movl $-14,%eax
-and linked in vmlinux     : > c0199ff5 <.fixup+10b5> movl   $0xfffffff2,%eax
 
-The assembly code
+the original assembly code::
+
+	> 3:      movl $-14,%eax
+
+and linked in vmlinux::
+
+	> c0199ff5 <.fixup+10b5> movl   $0xfffffff2,%eax
+
+The assembly code::
+
  > .section __ex_table,"a"
  >         .align 4
  >         .long 1b,3b
 
-becomes the value pair
+becomes the value pair::
+
  >  c01aa7d4 c017c2f6 c0199fe9 c017e7a5 c0199ff5  ................
                                ^this is ^this is
                                1b       3b
+
 c017e7a5,c0199ff5 in the exception table of the kernel.
 
 So, what actually happens if a fault from kernel mode with no suitable
 vma occurs?
 
-1.) access to invalid address:
- > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
-2.) MMU generates exception
-3.) CPU calls do_page_fault
-4.) do page fault calls search_exception_table (regs->eip == c017e7a5);
-5.) search_exception_table looks up the address c017e7a5 in the
+1.  access to invalid address::
+
+	> c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
+
+2.  MMU generates exception
+3.  CPU calls do_page_fault
+4.  do page fault calls search_exception_table (regs->eip == c017e7a5);
+5.  search_exception_table looks up the address c017e7a5 in the
     exception table (i.e. the contents of the ELF section __ex_table)
     and returns the address of the associated fault handle code c0199ff5.
-6.) do_page_fault modifies its own return address to point to the fault
+6.  do_page_fault modifies its own return address to point to the fault
     handle code and returns.
-7.) execution continues in the fault handling code.
-8.) 8a) EAX becomes -EFAULT (== -14)
-    8b) DL  becomes zero (the value we "read" from user space)
-    8c) execution continues at local label 2 (address of the
+7.  execution continues in the fault handling code.
+8.  :
+
+    - 8a.
+	EAX becomes -EFAULT (== -14)
+    - 8b.
+	DL  becomes zero (the value we "read" from user space)
+    - 8c.
+	execution continues at local label 2 (address of the
         instruction immediately after the faulting user access).
 
 The steps 8a to 8c in a certain way emulate the faulting instruction.
@@ -286,23 +319,26 @@ return value, however the inline assembly code in get_user tries to
 return -EFAULT. GCC selected EAX to return this value.
 
 NOTE:
-Due to the way that the exception table is built and needs to be ordered,
-only use exceptions for code in the .text section.  Any other section
-will cause the exception table to not be sorted correctly, and the
-exceptions will fail.
+  Due to the way that the exception table is built and needs to be ordered,
+  only use exceptions for code in the .text section.  Any other section
+  will cause the exception table to not be sorted correctly, and the
+  exceptions will fail.
 
 Things changed when 64-bit support was added to x86 Linux. Rather than
 double the size of the exception table by expanding the two entries
 from 32-bits to 64 bits, a clever trick was used to store addresses
 as relative offsets from the table itself. The assembly code changed
-from:
+from::
+
 	.long 1b,3b
-to:
+
+to::
+
         .long (from) - .
         .long (to) - .
 
 and the C-code that uses these values converts back to absolute addresses
-like this:
+like this::
 
 	ex_insn_addr(const struct exception_table_entry *x)
 	{
@@ -313,15 +349,16 @@ In v4.6 the exception table entry was expanded with a new field "handler".
 This is also 32-bits wide and contains a third relative function
 pointer which points to one of:
 
-1) int ex_handler_default(const struct exception_table_entry *fixup)
+1) int ex_handler_default(`const struct exception_table_entry *fixup`)
    This is legacy case that just jumps to the fixup code
-2) int ex_handler_fault(const struct exception_table_entry *fixup)
+2) int ex_handler_fault(`const struct exception_table_entry *fixup`)
    This case provides the fault number of the trap that occurred at
    entry->insn. It is used to distinguish page faults from machine
    check.
-3) int ex_handler_ext(const struct exception_table_entry *fixup)
+3) int ex_handler_ext(`const struct exception_table_entry *fixup`)
    This case is used for uaccess_err ... we need to set a flag
    in the task structure. Before the handler functions existed this
    case was handled by adding a large offset to the fixup to tag
    it as special.
+
 More functions can easily be added.
diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.txt
index 15f5baf7e1b6..4a9d2e4dfe5d 100644
--- a/Documentation/x86/i386/IO-APIC.txt
+++ b/Documentation/x86/i386/IO-APIC.txt
@@ -1,3 +1,7 @@
+=======
+IO-APIC
+=======
+
 Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
 which is an enhanced interrupt controller. It enables us to route
 hardware interrupts to multiple CPUs, or to CPU groups. Without an
@@ -13,9 +17,8 @@ usually worked around by the kernel. If your MP-compliant SMP board does
 not boot Linux, then consult the linux-smp mailing list archives first.
 
 If your box boots fine with enabled IO-APIC IRQs, then your
-/proc/interrupts will look like this one:
+/proc/interrupts will look like this one::
 
-   ---------------------------->
   hell:~> cat /proc/interrupts
              CPU0
     0:    1360293    IO-APIC-edge  timer
@@ -28,7 +31,6 @@ If your box boots fine with enabled IO-APIC IRQs, then your
   NMI:          0
   ERR:          0
   hell:~>
-  <----------------------------
 
 Some interrupts are still listed as 'XT PIC', but this is not a problem;
 none of those IRQ sources is performance-critical.
@@ -37,14 +39,14 @@ none of those IRQ sources is performance-critical.
 In the unlikely case that your board does not create a working mp-table,
 you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
 is non-trivial though and cannot be automated. One sample /etc/lilo.conf
-entry:
+entry::
 
 	append="pirq=15,11,10"
 
 The actual numbers depend on your system, on your PCI cards and on their
 PCI slot position. Usually PCI slots are 'daisy chained' before they are
 connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
-lines):
+lines)::
 
                ,-.        ,-.        ,-.        ,-.        ,-.
      PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
@@ -56,7 +58,7 @@ lines):
      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
                `-'        `-'        `-'        `-'        `-'
 
-Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
+Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
 
                                ,-.
                          INTD--| |
@@ -78,19 +80,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
 do not use interrupts normally, thus they are not daisy chained either.
 
 so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
-Slot2, then you'll have to specify this pirq= line:
+Slot2, then you'll have to specify this pirq= line::
 
 	append="pirq=11,9"
 
 the following script tries to figure out such a default pirq= line from
-your PCI configuration:
+your PCI configuration::
 
 	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
 
 note that this script won't work if you have skipped a few slots or if your
 board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
 connected in some strange way). E.g. if in the above case you have your SCSI
-card (IRQ11) in Slot3, and have Slot1 empty:
+card (IRQ11) in Slot3, and have Slot1 empty::
 
 	append="pirq=0,9,11"
 
@@ -105,7 +107,7 @@ won't function properly (e.g. if it's inserted as a module).
 If you have 2 PCI buses, then you can use up to 8 pirq values, although such
 boards tend to have a good configuration.
 
-Be prepared that it might happen that you need some strange pirq line:
+Be prepared that it might happen that you need some strange pirq line::
 
 	append="pirq=0,0,0,0,0,0,9,11"
 
@@ -116,4 +118,3 @@ linux-kernel@vger.kernel.org if you have any problems that are not covered
 by this document.
 
 -- mingo
-
diff --git a/Documentation/x86/intel_mpx.txt b/Documentation/x86/intel_mpx.txt
index 85d0549ad846..33d150d7a920 100644
--- a/Documentation/x86/intel_mpx.txt
+++ b/Documentation/x86/intel_mpx.txt
@@ -1,3 +1,7 @@
+============
+Intel(R) MPX
+============
+
 1. Intel(R) MPX Overview
 ========================
 
@@ -92,6 +96,7 @@ Handling #BR faults caused by MPX
 
 When MPX is enabled, there are 2 new situations that can generate
 #BR faults.
+
   * new bounds tables (BT) need to be allocated to save bounds.
   * bounds violation caused by MPX instructions.
 
@@ -124,9 +129,11 @@ the kernel. It can theoretically be done completely from userspace. Here
 are a few ways this could be done. We don't think any of them are practical
 in the real-world, but here they are.
 
-Q: Can virtual space simply be reserved for the bounds tables so that we
+Q:
+   Can virtual space simply be reserved for the bounds tables so that we
    never have to allocate them?
-A: MPX-enabled application will possibly create a lot of bounds tables in
+A:
+   MPX-enabled application will possibly create a lot of bounds tables in
    process address space to save bounds information. These tables can take
    up huge swaths of memory (as much as 80% of the memory on the system)
    even if we clean them up aggressively. In the worst-case scenario, the
@@ -140,19 +147,23 @@ A: MPX-enabled application will possibly create a lot of bounds tables in
    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
    infeasible to prepopulate bounds directories.
 
-Q: Can we preallocate bounds table space at the same time memory is
+Q:
+   Can we preallocate bounds table space at the same time memory is
    allocated which might contain pointers that might eventually need
    bounds tables?
-A: This would work if we could hook the site of each and every memory
+A:
+   This would work if we could hook the site of each and every memory
    allocation syscall. This can be done for small, constrained applications.
    But, it isn't practical at a larger scale since a given app has no
    way of controlling how all the parts of the app might allocate memory
    (think libraries). The kernel is really the only place to intercept
    these calls.
 
-Q: Could a bounds fault be handed to userspace and the tables allocated
+Q:
+   Could a bounds fault be handed to userspace and the tables allocated
    there in a signal handler instead of in the kernel?
-A: mmap() is not on the list of safe async handler functions and even
+A:
+   mmap() is not on the list of safe async handler functions and even
    if mmap() would work it still requires locking or nasty tricks to
    keep track of the allocation state there.
 
@@ -167,20 +178,20 @@ If a #BR is generated due to a bounds violation caused by MPX.
 We need to decode MPX instructions to get violation address and
 set this address into extended struct siginfo.
 
-The _sigfault field of struct siginfo is extended as follow:
+The _sigfault field of struct siginfo is extended as follow::
 
-87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-88		struct {
-89			void __user *_addr; /* faulting insn/memory ref. */
-90 #ifdef __ARCH_SI_TRAPNO
-91			int _trapno;	/* TRAP # which caused the signal */
-92 #endif
-93			short _addr_lsb; /* LSB of the reported address */
-94			struct {
-95				void __user *_lower;
-96				void __user *_upper;
-97			} _addr_bnd;
-98		} _sigfault;
+  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+  88		struct {
+  89			void __user *_addr; /* faulting insn/memory ref. */
+  90 #ifdef __ARCH_SI_TRAPNO
+  91			int _trapno;	/* TRAP # which caused the signal */
+  92 #endif
+  93			short _addr_lsb; /* LSB of the reported address */
+  94			struct {
+  95				void __user *_lower;
+  96				void __user *_upper;
+  97			} _addr_bnd;
+  98		} _sigfault;
 
 The '_addr' field refers to violation address, and new '_addr_and'
 field refers to the upper/lower bounds when a #BR is caused.
@@ -208,10 +219,10 @@ Adding new prctl commands
 -------------------------
 
 Two new prctl commands are added to enable and disable MPX bounds tables
-management in kernel.
+management in kernel::
 
-155	#define PR_MPX_ENABLE_MANAGEMENT	43
-156	#define PR_MPX_DISABLE_MANAGEMENT	44
+  155	#define PR_MPX_ENABLE_MANAGEMENT	43
+  156	#define PR_MPX_DISABLE_MANAGEMENT	44
 
 Runtime library in userspace is responsible for allocation of bounds
 directory. So kernel have to use XSAVE instruction to get the base
diff --git a/Documentation/x86/microcode.txt b/Documentation/x86/microcode.txt
index 79fdb4a8148a..e510c34d4979 100644
--- a/Documentation/x86/microcode.txt
+++ b/Documentation/x86/microcode.txt
@@ -1,7 +1,10 @@
-	The Linux Microcode Loader
+==========================
+The Linux Microcode Loader
+==========================
 
-Authors: Fenghua Yu <fenghua.yu@intel.com>
-	 Borislav Petkov <bp@suse.de>
+Authors:
+	 - Fenghua Yu <fenghua.yu@intel.com>
+	 - Borislav Petkov <bp@suse.de>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -26,8 +29,11 @@ loader parses the combined initrd image during boot.
 
 The microcode files in cpio name space are:
 
-on Intel: kernel/x86/microcode/GenuineIntel.bin
-on AMD  : kernel/x86/microcode/AuthenticAMD.bin
+on Intel:
+	kernel/x86/microcode/GenuineIntel.bin
+
+on AMD:
+	kernel/x86/microcode/AuthenticAMD.bin
 
 During BSP (BootStrapping Processor) boot (pre-SMP), the kernel
 scans the microcode file in the initrd. If microcode matching the
@@ -43,7 +49,8 @@ normally done automatically by the distribution, when recreating the
 initrd, so you don't really have to do it yourself. It is documented
 here for future reference only).
 
----
+::
+
   #!/bin/bash
 
   if [ -z "$1" ]; then
@@ -76,7 +83,7 @@ here for future reference only).
   cat ucode.cpio $INITRD.orig > $INITRD
 
   rm -rf $TMPDIR
----
+
 
 The system needs to have the microcode packages installed into
 /lib/firmware or you need to fixup the paths above if yours are
@@ -94,9 +101,9 @@ The /dev/cpu/microcode method is deprecated because it needs a special
 userspace tool for that.
 
 The easier method is simply installing the microcode packages your distro
-supplies and running:
+supplies and running::
 
-# echo 1 > /sys/devices/system/cpu/microcode/reload
+	# echo 1 > /sys/devices/system/cpu/microcode/reload
 
 as root.
 
@@ -111,22 +118,22 @@ The loader supports also loading of a builtin microcode supplied through
 the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
 currently supported.
 
-Here's an example:
+Here's an example::
 
-CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 
-This basically means, you have the following tree structure locally:
+This basically means, you have the following tree structure locally::
 
-/lib/firmware/
-|-- amd-ucode
-...
-|   |-- microcode_amd_fam15h.bin
-...
-|-- intel-ucode
-...
-|   |-- 06-3a-09
-...
+  /lib/firmware/
+  |-- amd-ucode
+  ...
+  |   |-- microcode_amd_fam15h.bin
+  ...
+  |-- intel-ucode
+  ...
+  |   |-- 06-3a-09
+  ...
 
 so that the build system can find those files and integrate them into
 the final kernel image. The early loader finds them and applies them.
diff --git a/Documentation/x86/mtrr.txt b/Documentation/x86/mtrr.txt
index dc3e703913ac..6187e2a3d0e5 100644
--- a/Documentation/x86/mtrr.txt
+++ b/Documentation/x86/mtrr.txt
@@ -1,10 +1,14 @@
+=========================================
 MTRR (Memory Type Range Register) control
+=========================================
 
-Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
-Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
+- Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
+- Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
+
+------------------------------------------------------------------
 
-===============================================================================
 Phasing out MTRR use
+====================
 
 MTRR use is replaced on modern x86 hardware with PAT. Direct MTRR use by
 drivers on Linux is now completely phased out, device drivers should use
@@ -25,7 +29,7 @@ requests mtrr_type_lookup() should always return MTRR_TYPE_INVALID.
 
 For details refer to Documentation/x86/pat.txt.
 
-===============================================================================
+------------------------------------------------------------------
 
   On Intel P6 family processors (Pentium Pro, Pentium II and later)
   the Memory Type Range Registers (MTRRs) may be used to control
@@ -61,138 +65,155 @@ interface. The ASCII interface is meant for administration. The
 ioctl() interface is meant for C programs (i.e. the X server). The
 interfaces are described below, with sample commands and C code.
 
-===============================================================================
-Reading MTRRs from the shell:
+------------------------------------------------------------------
 
-% cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
-reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
-===============================================================================
-Creating MTRRs from the C-shell:
-# echo "base=0xf8000000 size=0x400000 type=write-combining" >! /proc/mtrr
-or if you use bash:
-# echo "base=0xf8000000 size=0x400000 type=write-combining" >| /proc/mtrr
+Reading MTRRs from the shell::
 
-And the result thereof:
-% cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
-reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
-reg02: base=0xf8000000 (3968MB), size=   4MB: write-combining, count=1
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
+  reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
+
+------------------------------------------------------------------
+
+Creating MTRRs from the C-shell::
+
+  # echo "base=0xf8000000 size=0x400000 type=write-combining" >! /proc/mtrr
+  or if you use bash:
+  # echo "base=0xf8000000 size=0x400000 type=write-combining" >| /proc/mtrr
+
+And the result thereof::
+
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
+  reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
+  reg02: base=0xf8000000 (3968MB), size=   4MB: write-combining, count=1
 
 This is for video RAM at base address 0xf8000000 and size 4 megabytes. To
 find out your base address, you need to look at the output of your X
 server, which tells you where the linear framebuffer address is. A
-typical line that you may get is:
+typical line that you may get is::
 
-(--) S3: PCI: 968 rev 0, Linear FB @ 0xf8000000
+  (--) S3: PCI: 968 rev 0, Linear FB @ 0xf8000000
 
 Note that you should only use the value from the X server, as it may
 move the framebuffer base address, so the only value you can trust is
 that reported by the X server.
 
 To find out the size of your framebuffer (what, you don't actually
-know?), the following line will tell you:
+know?), the following line will tell you::
 
-(--) S3: videoram:  4096k
+  (--) S3: videoram:  4096k
 
 That's 4 megabytes, which is 0x400000 bytes (in hexadecimal).
 A patch is being written for XFree86 which will make this automatic:
 in other words the X server will manipulate /proc/mtrr using the
 ioctl() interface, so users won't have to do anything. If you use a
 commercial X server, lobby your vendor to add support for MTRRs.
-===============================================================================
-Creating overlapping MTRRs:
 
-%echo "base=0xfb000000 size=0x1000000 type=write-combining" >/proc/mtrr
-%echo "base=0xfb000000 size=0x1000 type=uncachable" >/proc/mtrr
+------------------------------------------------------------------
 
-And the results: cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size=  64MB: write-back, count=1
-reg01: base=0xfb000000 (4016MB), size=  16MB: write-combining, count=1
-reg02: base=0xfb000000 (4016MB), size=   4kB: uncachable, count=1
+Creating overlapping MTRRs::
+
+  % echo "base=0xfb000000 size=0x1000000 type=write-combining" >/proc/mtrr
+  % echo "base=0xfb000000 size=0x1000 type=uncachable" >/proc/mtrr
+
+And the results::
+
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size=  64MB: write-back, count=1
+  reg01: base=0xfb000000 (4016MB), size=  16MB: write-combining, count=1
+  reg02: base=0xfb000000 (4016MB), size=   4kB: uncachable, count=1
 
 Some cards (especially Voodoo Graphics boards) need this 4 kB area
 excluded from the beginning of the region because it is used for
 registers.
 
-NOTE: You can only create type=uncachable region, if the first
-region that you created is type=write-combining.
-===============================================================================
-Removing MTRRs from the C-shell:
-% echo "disable=2" >! /proc/mtrr
-or using bash:
-% echo "disable=2" >| /proc/mtrr
-===============================================================================
-Reading MTRRs from a C program using ioctl()'s:
-
-/*  mtrr-show.c
-
-    Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This program will use an ioctl() on /proc/mtrr to show the current MTRR
-    settings. This is an alternative to reading /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main ()
-{
-    int fd;
-    struct mtrr_gentry gentry;
-
-    if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
-    {
+NOTE:
+  You can only create type=uncachable region, if the first
+  region that you created is type=write-combining.
+
+------------------------------------------------------------------
+
+Removing MTRRs from the C-shell::
+
+  % echo "disable=2" >! /proc/mtrr
+
+or using bash::
+
+  % echo "disable=2" >| /proc/mtrr
+
+------------------------------------------------------------------
+
+Reading MTRRs from a C program using ioctl()'s::
+
+  /*  mtrr-show.c
+
+      Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
+
+      Copyright (C) 1997-1998  Richard Gooch
+
+      This program is free software; you can redistribute it and/or modify
+      it under the terms of the GNU General Public License as published by
+      the Free Software Foundation; either version 2 of the License, or
+      (at your option) any later version.
+
+      This program is distributed in the hope that it will be useful,
+      but WITHOUT ANY WARRANTY; without even the implied warranty of
+      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      GNU General Public License for more details.
+
+      You should have received a copy of the GNU General Public License
+      along with this program; if not, write to the Free Software
+      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+      Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+      The postal address is:
+        Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+  */
+
+  /*
+      This program will use an ioctl() on /proc/mtrr to show the current MTRR
+      settings. This is an alternative to reading /proc/mtrr.
+
+
+      Written by      Richard Gooch   17-DEC-1997
+
+      Last updated by Richard Gooch   2-MAY-1998
+
+
+  */
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <string.h>
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <fcntl.h>
+  #include <sys/ioctl.h>
+  #include <errno.h>
+  #include <asm/mtrr.h>
+
+  #define TRUE 1
+  #define FALSE 0
+  #define ERRSTRING strerror (errno)
+
+  static char *mtrr_strings[MTRR_NUM_TYPES] =
+  {
+      "uncachable",               /* 0 */
+      "write-combining",          /* 1 */
+      "?",                        /* 2 */
+      "?",                        /* 3 */
+      "write-through",            /* 4 */
+      "write-protect",            /* 5 */
+      "write-back",               /* 6 */
+  };
+
+  int main ()
+  {
+      int fd;
+      struct mtrr_gentry gentry;
+
+      if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
+      {
 	if (errno == ENOENT)
 	{
 	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
@@ -201,10 +222,10 @@ int main ()
 	}
 	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
 	exit (2);
-    }
-    for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
+      }
+      for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
 	 ++gentry.regnum)
-    {
+      {
 	if (gentry.size < 1)
 	{
 	    fprintf (stderr, "Register: %u disabled\n", gentry.regnum);
@@ -213,99 +234,101 @@ int main ()
 	fprintf (stderr, "Register: %u base: 0x%lx size: 0x%lx type: %s\n",
 		 gentry.regnum, gentry.base, gentry.size,
 		 mtrr_strings[gentry.type]);
-    }
-    if (errno == EINVAL) exit (0);
-    fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
-    exit (3);
-}   /*  End Function main  */
-===============================================================================
-Creating MTRRs from a C programme using ioctl()'s:
-
-/*  mtrr-add.c
-
-    Source file for mtrr-add (example programme to add an MTRRs using ioctl())
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This programme will use an ioctl() on /proc/mtrr to add an entry. The first
-    available mtrr is used. This is an alternative to writing /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main (int argc, char **argv)
-{
-    int fd;
-    struct mtrr_sentry sentry;
-
-    if (argc != 4)
-    {
+      }
+      if (errno == EINVAL) exit (0);
+      fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
+      exit (3);
+  }   /*  End Function main  */
+
+------------------------------------------------------------------
+
+Creating MTRRs from a C programme using ioctl()'s::
+
+  /*  mtrr-add.c
+
+      Source file for mtrr-add (example programme to add an MTRRs using ioctl())
+
+      Copyright (C) 1997-1998  Richard Gooch
+
+      This program is free software; you can redistribute it and/or modify
+      it under the terms of the GNU General Public License as published by
+      the Free Software Foundation; either version 2 of the License, or
+      (at your option) any later version.
+
+      This program is distributed in the hope that it will be useful,
+      but WITHOUT ANY WARRANTY; without even the implied warranty of
+      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      GNU General Public License for more details.
+
+      You should have received a copy of the GNU General Public License
+      along with this program; if not, write to the Free Software
+      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+      Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+      The postal address is:
+        Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+  */
+
+  /*
+      This programme will use an ioctl() on /proc/mtrr to add an entry. The first
+      available mtrr is used. This is an alternative to writing /proc/mtrr.
+
+
+      Written by      Richard Gooch   17-DEC-1997
+
+      Last updated by Richard Gooch   2-MAY-1998
+
+
+  */
+  #include <stdio.h>
+  #include <string.h>
+  #include <stdlib.h>
+  #include <unistd.h>
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <fcntl.h>
+  #include <sys/ioctl.h>
+  #include <errno.h>
+  #include <asm/mtrr.h>
+
+  #define TRUE 1
+  #define FALSE 0
+  #define ERRSTRING strerror (errno)
+
+  static char *mtrr_strings[MTRR_NUM_TYPES] =
+  {
+      "uncachable",               /* 0 */
+      "write-combining",          /* 1 */
+      "?",                        /* 2 */
+      "?",                        /* 3 */
+      "write-through",            /* 4 */
+      "write-protect",            /* 5 */
+      "write-back",               /* 6 */
+  };
+
+  int main (int argc, char **argv)
+  {
+      int fd;
+      struct mtrr_sentry sentry;
+
+      if (argc != 4)
+      {
 	fprintf (stderr, "Usage:\tmtrr-add base size type\n");
 	exit (1);
-    }
-    sentry.base = strtoul (argv[1], NULL, 0);
-    sentry.size = strtoul (argv[2], NULL, 0);
-    for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
-    {
+      }
+      sentry.base = strtoul (argv[1], NULL, 0);
+      sentry.size = strtoul (argv[2], NULL, 0);
+      for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
+      {
 	if (strcmp (argv[3], mtrr_strings[sentry.type]) == 0) break;
-    }
-    if (sentry.type >= MTRR_NUM_TYPES)
-    {
+      }
+      if (sentry.type >= MTRR_NUM_TYPES)
+      {
 	fprintf (stderr, "Illegal type: \"%s\"\n", argv[3]);
 	exit (2);
-    }
-    if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
-    {
+      }
+      if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
+      {
 	if (errno == ENOENT)
 	{
 	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
@@ -314,16 +337,15 @@ int main (int argc, char **argv)
 	}
 	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
 	exit (4);
-    }
-    if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
-    {
+      }
+      if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
+      {
 	fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
 	exit (5);
-    }
-    fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
-    sleep (5);
-    close (fd);
-    fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
+      }
+      fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
+      sleep (5);
+      close (fd);
+      fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
 	   stderr);
-}   /*  End Function main  */
-===============================================================================
+  }   /*  End Function main  */
diff --git a/Documentation/x86/orc-unwinder.txt b/Documentation/x86/orc-unwinder.txt
index cd4b29be29af..3a8d6d324cfa 100644
--- a/Documentation/x86/orc-unwinder.txt
+++ b/Documentation/x86/orc-unwinder.txt
@@ -1,3 +1,4 @@
+============
 ORC unwinder
 ============
 
diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
index 481d8d8536ac..8c8ea7292780 100644
--- a/Documentation/x86/pat.txt
+++ b/Documentation/x86/pat.txt
@@ -1,5 +1,6 @@
-
+==========================
 PAT (Page Attribute Table)
+==========================
 
 x86 Page Attribute Table (PAT) allows for setting the memory attribute at the
 page level granularity. PAT is complementary to the MTRR settings which allows
@@ -11,8 +12,15 @@ not having memory type aliasing for the same physical memory with multiple
 virtual addresses.
 
 PAT allows for different types of memory attributes. The most commonly used
-ones that will be supported at this time are Write-back, Uncached,
-Write-combined, Write-through and Uncached Minus.
+ones that will be supported at this time are:
+
+===  ==============
+WB   Write-back
+UC   Uncached
+WC   Write-combined
+WT   Write-through
+UC-  Uncached Minus
+===  ==============
 
 
 PAT APIs
@@ -23,81 +31,80 @@ attributes at the page level. In order to avoid aliasing, these interfaces
 should be used thoughtfully. Below is a table of interfaces available,
 their intended usage and their memory attribute relationships. Internally,
 these APIs use a reserve_memtype()/free_memtype() interface on the physical
-address range to avoid any aliasing.
+address range to avoid any aliasing
 
 
--------------------------------------------------------------------
-API                    |    RAM   |  ACPI,...  |  Reserved/Holes  |
------------------------|----------|------------|------------------|
-                       |          |            |                  |
-ioremap                |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_cache          |    --    |    WB      |       WB         |
-                       |          |            |                  |
-ioremap_uc             |    --    |    UC      |       UC         |
-                       |          |            |                  |
-ioremap_nocache        |    --    |    UC-     |       UC-        |
-                       |          |            |                  |
-ioremap_wc             |    --    |    --      |       WC         |
-                       |          |            |                  |
-ioremap_wt             |    --    |    --      |       WT         |
-                       |          |            |                  |
-set_memory_uc          |    UC-   |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wc          |    WC    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-set_memory_wt          |    WT    |    --      |       --         |
- set_memory_wb         |          |            |                  |
-                       |          |            |                  |
-pci sysfs resource     |    --    |    --      |       UC-        |
-                       |          |            |                  |
-pci sysfs resource_wc  |    --    |    --      |       WC         |
- is IORESOURCE_PREFETCH|          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       UC-        |
- !PCIIOC_WRITE_COMBINE |          |            |                  |
-                       |          |            |                  |
-pci proc               |    --    |    --      |       WC         |
- PCIIOC_WRITE_COMBINE  |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- read-write            |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    UC-     |       UC-        |
- mmap SYNC flag        |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |  WB/WC/UC- |    WB/WC/UC-     |
- mmap !SYNC flag       |          |(from exist-|  (from exist-    |
- and                   |          |  ing alias)|    ing alias)    |
- any alias to this area|          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    WB      |       WB         |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says WB          |          |            |                  |
-                       |          |            |                  |
-/dev/mem               |    --    |    --      |       UC-        |
- mmap !SYNC flag       |          |            |                  |
- no alias to this area |          |            |                  |
- and                   |          |            |                  |
- MTRR says !WB         |          |            |                  |
-                       |          |            |                  |
--------------------------------------------------------------------
++------------------------+----------+--------------+------------------+
+| API                    |    RAM   |  ACPI,...    |  Reserved/Holes  |
++------------------------+----------+--------------+------------------+
+| ioremap                |    --    |    UC-       |       UC-        |
++------------------------+----------+--------------+------------------+
+| ioremap_cache          |    --    |    WB        |       WB         |
++------------------------+----------+--------------+------------------+
+| ioremap_uc             |    --    |    UC        |       UC         |
++------------------------+----------+--------------+------------------+
+| ioremap_nocache        |    --    |    UC-       |       UC-        |
++------------------------+----------+--------------+------------------+
+| ioremap_wc             |    --    |    --        |       WC         |
++------------------------+----------+--------------+------------------+
+| ioremap_wt             |    --    |    --        |       WT         |
++------------------------+----------+--------------+------------------+
+| set_memory_uc          |    UC-   |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| set_memory_wc          |    WC    |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| set_memory_wt          |    WT    |    --        |       --         |
+| set_memory_wb          |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci sysfs resource     |    --    |    --        |       UC-        |
++------------------------+----------+--------------+------------------+
+| pci sysfs resource_wc  |    --    |    --        |       WC         |
+| is IORESOURCE_PREFETCH |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci proc               |    --    |    --        |       UC-        |
+| !PCIIOC_WRITE_COMBINE  |          |              |                  |
++------------------------+----------+--------------+------------------+
+| pci proc               |    --    |    --        |       WC         |
+| PCIIOC_WRITE_COMBINE   |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |   WB/WC/UC-  |    WB/WC/UC-     |
+| read-write             |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    UC-       |       UC-        |
+| mmap SYNC flag         |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |   WB/WC/UC-  |  WB/WC/UC-       |
+| mmap !SYNC flag        |          |              |                  |
+| and                    |          |(from existing|  (from existing  |
+| any alias to this area |          |alias)        |  alias)          |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    WB        |       WB         |
+| mmap !SYNC flag        |          |              |                  |
+| no alias to this area  |          |              |                  |
+| and                    |          |              |                  |
+| MTRR says WB           |          |              |                  |
++------------------------+----------+--------------+------------------+
+| /dev/mem               |    --    |    --        |       UC-        |
+| mmap !SYNC flag        |          |              |                  |
+| no alias to this area  |          |              |                  |
+| and                    |          |              |                  |
+| MTRR says !WB          |          |              |                  |
++------------------------+----------+--------------+------------------+
 
 Advanced APIs for drivers
 -------------------------
-A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
-vmf_insert_pfn
+**Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
+vmf_insert_pfn**
 
 Drivers wanting to export some pages to userspace do it by using mmap
 interface and a combination of
+
 1) pgprot_noncached()
 2) io_remap_pfn_range() or remap_pfn_range() or vmf_insert_pfn()
 
-With PAT support, a new API pgprot_writecombine is being added. So, drivers can
+With PAT support, a new API pgprot_writecombine() is being added. So, drivers can
 continue to use the above sequence, with either pgprot_noncached() or
 pgprot_writecombine() in step 1, followed by step 2.
 
@@ -124,23 +131,22 @@ set_memory_wc() to white-list effective write-combined areas.  Such use is
 nevertheless discouraged as the effective memory type is considered
 implementation defined, yet this strategy can be used as last resort on devices
 with size-constrained regions where otherwise MTRR write-combining would
-otherwise not be effective.
+otherwise not be effective::
 
-----------------------------------------------------------------------
-MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
-----------------------------------------------------------------------
-                                                  Non-PAT |  PAT
-     PAT
-     |PCD
-     ||PWT
-     |||
-WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
-WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
-WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
-WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
-----------------------------------------------------------------------
+  ====  =======  ===  =========================  =====================
+  MTRR  Non-PAT  PAT  Linux ioremap value        Effective memory type
+  ====  =======  ===  =========================  =====================
+        PAT                                        Non-PAT |  PAT
+        |PCD                                               |
+        ||PWT                                              |
+        |||                                                |
+  WC    000      WB   _PAGE_CACHE_MODE_WB             WC   |   WC
+  WC    001      WC   _PAGE_CACHE_MODE_WC             WC*  |   WC
+  WC    010      UC-  _PAGE_CACHE_MODE_UC_MINUS       WC*  |   UC
+  WC    011      UC   _PAGE_CACHE_MODE_UC             UC   |   UC
+  ====  =======  ===  =========================  =====================
 
-(*) denotes implementation defined and is discouraged
+  (*) denotes implementation defined and is discouraged
 
 Notes:
 
@@ -168,26 +174,26 @@ Drivers should use set_memory_[uc|wc|wt] to set access type for RAM ranges.
 PAT debugging
 -------------
 
-With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by
+With CONFIG_DEBUG_FS enabled, PAT memtype list can be examined by::
 
-# mount -t debugfs debugfs /sys/kernel/debug
-# cat /sys/kernel/debug/x86/pat_memtype_list
-PAT memtype list:
-uncached-minus @ 0x7fadf000-0x7fae0000
-uncached-minus @ 0x7fb19000-0x7fb1a000
-uncached-minus @ 0x7fb1a000-0x7fb1b000
-uncached-minus @ 0x7fb1b000-0x7fb1c000
-uncached-minus @ 0x7fb1c000-0x7fb1d000
-uncached-minus @ 0x7fb1d000-0x7fb1e000
-uncached-minus @ 0x7fb1e000-0x7fb25000
-uncached-minus @ 0x7fb25000-0x7fb26000
-uncached-minus @ 0x7fb26000-0x7fb27000
-uncached-minus @ 0x7fb27000-0x7fb28000
-uncached-minus @ 0x7fb28000-0x7fb2e000
-uncached-minus @ 0x7fb2e000-0x7fb2f000
-uncached-minus @ 0x7fb2f000-0x7fb30000
-uncached-minus @ 0x7fb31000-0x7fb32000
-uncached-minus @ 0x80000000-0x90000000
+  # mount -t debugfs debugfs /sys/kernel/debug
+  # cat /sys/kernel/debug/x86/pat_memtype_list
+  PAT memtype list:
+  uncached-minus @ 0x7fadf000-0x7fae0000
+  uncached-minus @ 0x7fb19000-0x7fb1a000
+  uncached-minus @ 0x7fb1a000-0x7fb1b000
+  uncached-minus @ 0x7fb1b000-0x7fb1c000
+  uncached-minus @ 0x7fb1c000-0x7fb1d000
+  uncached-minus @ 0x7fb1d000-0x7fb1e000
+  uncached-minus @ 0x7fb1e000-0x7fb25000
+  uncached-minus @ 0x7fb25000-0x7fb26000
+  uncached-minus @ 0x7fb26000-0x7fb27000
+  uncached-minus @ 0x7fb27000-0x7fb28000
+  uncached-minus @ 0x7fb28000-0x7fb2e000
+  uncached-minus @ 0x7fb2e000-0x7fb2f000
+  uncached-minus @ 0x7fb2f000-0x7fb30000
+  uncached-minus @ 0x7fb31000-0x7fb32000
+  uncached-minus @ 0x80000000-0x90000000
 
 This list shows physical address ranges and various PAT settings used to
 access those physical address ranges.
@@ -204,8 +210,9 @@ configurations. The PAT MSR must be updated by Linux in order to support WC
 and WT attributes. Otherwise, the PAT MSR has the value programmed in it
 by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
 
+ ==== ===== ==========================  =========  =======
  MTRR PAT   Call Sequence               PAT State  PAT MSR
- =========================================================
+ ==== ===== ==========================  =========  =======
  E    E     MTRR -> PAT init            Enabled    OS
  E    D     MTRR -> PAT init            Disabled    -
  D    E     MTRR -> PAT disable         Disabled   BIOS
@@ -215,9 +222,11 @@ by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
  E    !P/E  MTRR -> PAT init            Disabled   BIOS
  D    !P/E  MTRR -> PAT disable         Disabled   BIOS
  !M   !P/E  MTRR stub -> PAT disable    Disabled   BIOS
+ ==== ===== ==========================  =========  =======
 
  Legend
- ------------------------------------------------
+
+ ========= =======================================
  E         Feature enabled in CPU
  D	   Feature disabled/unsupported in CPU
  np	   "nopat" boot option specified
@@ -227,4 +236,4 @@ by the firmware. Note, Xen enables WC attribute in the PAT MSR for guests.
  Disabled  PAT state set to disabled
  OS        PAT initializes PAT MSR with OS setting
  BIOS      PAT keeps PAT MSR with BIOS setting
-
+ ========= =======================================
diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.txt
index ecb0d2dadfb7..93becb2385b3 100644
--- a/Documentation/x86/protection-keys.txt
+++ b/Documentation/x86/protection-keys.txt
@@ -1,3 +1,7 @@
+==========================================
+Memory Protection Keys for Userspace (PKU)
+==========================================
+
 Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
 which is found on Intel's Skylake "Scalable Processor" Server CPUs.
 It will be avalable in future non-server parts.
@@ -23,9 +27,10 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-=========================== Syscalls ===========================
+Syscalls
+========
 
-There are 3 system calls which directly interact with pkeys:
+There are 3 system calls which directly interact with pkeys::
 
 	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
 	int pkey_free(int pkey);
@@ -36,7 +41,7 @@ Before a pkey can be used, it must first be allocated with
 pkey_alloc().  An application calls the WRPKRU instruction
 directly in order to change access permissions to memory covered
 with a key.  In this example WRPKRU is wrapped by a C function
-called pkey_set().
+called pkey_set()::
 
 	int real_prot = PROT_READ|PROT_WRITE;
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
@@ -45,43 +50,45 @@ called pkey_set().
 	... application runs here
 
 Now, if the application needs to update the data at 'ptr', it can
-gain access, do the update, then remove its write access:
+gain access, do the update, then remove its write access::
 
 	pkey_set(pkey, 0); // clear PKEY_DISABLE_WRITE
 	*ptr = foo; // assign something
 	pkey_set(pkey, PKEY_DISABLE_WRITE); // set PKEY_DISABLE_WRITE again
 
 Now when it frees the memory, it will also free the pkey since it
-is no longer in use:
+is no longer in use::
 
 	munmap(ptr, PAGE_SIZE);
 	pkey_free(pkey);
 
-(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
- An example implementation can be found in
- tools/testing/selftests/x86/protection_keys.c)
+Note:
+  pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
+  An example implementation can be found in
+  tools/testing/selftests/x86/protection_keys.c
 
-=========================== Behavior ===========================
+Behavior
+========
 
 The kernel attempts to make protection keys consistent with the
-behavior of a plain mprotect().  For instance if you do this:
+behavior of a plain mprotect().  For instance if you do this::
 
 	mprotect(ptr, size, PROT_NONE);
 	something(ptr);
 
-you can expect the same effects with protection keys when doing this:
+you can expect the same effects with protection keys when doing this::
 
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
 	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
 	something(ptr);
 
 That should be true whether something() is a direct access to 'ptr'
-like:
+like::
 
 	*ptr = foo;
 
 or when the kernel does the access on the application's behalf like
-with a read():
+with a read()::
 
 	read(fd, ptr, 1);
 
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.txt
index 5cd58439ad2d..8ba2a4b8c146 100644
--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.txt
@@ -1,3 +1,7 @@
+====================
+Page Table Isolation
+====================
+
 Overview
 ========
 
@@ -60,6 +64,7 @@ Protection against side-channel attacks is important.  But,
 this protection comes at a cost:
 
 1. Increased Memory Use
+
   a. Each process now needs an order-1 PGD instead of order-0.
      (Consumes an additional 4k per process).
   b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
@@ -68,6 +73,7 @@ this protection comes at a cost:
      is decompressed, but no space in the kernel image itself.
 
 2. Runtime Cost
+
   a. CR3 manipulation to switch between the page table copies
      must be done at interrupt, syscall, and exception entry
      and exit (it can be skipped when the kernel is interrupted,
@@ -124,7 +130,7 @@ Possible Future Work
    boot-time switching.
 
 Testing
-========
+=======
 
 To test stability of PTI, the following test procedure is recommended,
 ideally doing all of these in parallel:
diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.txt
index c1f95b59e14d..5e7a7a8da518 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -1,33 +1,45 @@
+===========================================
 User Interface for Resource Control feature
+===========================================
 
 Intel refers to this feature as Intel Resource Director Technology(Intel(R) RDT).
 AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 
 Copyright (C) 2016 Intel Corporation
 
-Fenghua Yu <fenghua.yu@intel.com>
-Tony Luck <tony.luck@intel.com>
-Vikas Shivappa <vikas.shivappa@intel.com>
+- Fenghua Yu <fenghua.yu@intel.com>
+- Tony Luck <tony.luck@intel.com>
+- Vikas Shivappa <vikas.shivappa@intel.com>
 
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
-RDT (Resource Director Technology) Allocation - "rdt_a"
-CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
-CDP (Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
-CQM (Cache QoS Monitoring) - "cqm_llc", "cqm_occup_llc"
-MBM (Memory Bandwidth Monitoring) - "cqm_mbm_total", "cqm_mbm_local"
-MBA (Memory Bandwidth Allocation) - "mba"
 
-To use the feature mount the file system:
+RDT
+	(Resource Director Technology) Allocation - "rdt_a"
+CAT
+	(Cache Allocation Technology) - "cat_l3", "cat_l2"
+CDP
+	(Code and Data Prioritization ) - "cdp_l3", "cdp_l2"
+CQM
+	(Cache QoS Monitoring) - "cqm_llc", "cqm_occup_llc"
+MBM
+	(Memory Bandwidth Monitoring) - "cqm_mbm_total", "cqm_mbm_local"
+MBA
+	(Memory Bandwidth Allocation) - "mba"
+
+To use the feature mount the file system::
 
  # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
 
 mount options are:
 
-"cdp": Enable code/data prioritization in L3 cache allocations.
-"cdpl2": Enable code/data prioritization in L2 cache allocations.
-"mba_MBps": Enable the MBA Software Controller(mba_sc) to specify MBA
- bandwidth in MBps
+"cdp":
+	Enable code/data prioritization in L3 cache allocations.
+"cdpl2":
+	Enable code/data prioritization in L2 cache allocations.
+"mba_MBps":
+	Enable the MBA Software Controller(mba_sc) to specify MBA
+	bandwidth in MBps
 
 L2 and L3 CDP are controlled seperately.
 
@@ -56,71 +68,88 @@ allocation:
 Cache resource(L3/L2)  subdirectory contains the following files
 related to allocation:
 
-"num_closids":  	The number of CLOSIDs which are valid for this
+"num_closids":
+			The number of CLOSIDs which are valid for this
 			resource. The kernel uses the smallest number of
 			CLOSIDs of all enabled resources as limit.
 
-"cbm_mask":     	The bitmask which is valid for this resource.
+"cbm_mask":
+			The bitmask which is valid for this resource.
 			This mask is equivalent to 100%.
 
-"min_cbm_bits": 	The minimum number of consecutive bits which
+"min_cbm_bits":
+			The minimum number of consecutive bits which
 			must be set when writing a mask.
 
-"shareable_bits":	Bitmask of shareable resource with other executing
+"shareable_bits":
+			Bitmask of shareable resource with other executing
 			entities (e.g. I/O). User can use this when
 			setting up exclusive cache partitions. Note that
 			some platforms support devices that have their
 			own settings for cache use which can over-ride
 			these bits.
-"bit_usage":		Annotated capacity bitmasks showing how all
+"bit_usage":
+			Annotated capacity bitmasks showing how all
 			instances of the resource are used. The legend is:
-			"0" - Corresponding region is unused. When the system's
+
+			"0"
+			    - Corresponding region is unused. When the system's
 			      resources have been allocated and a "0" is found
 			      in "bit_usage" it is a sign that resources are
 			      wasted.
-			"H" - Corresponding region is used by hardware only
+			"H"
+			    - Corresponding region is used by hardware only
 			      but available for software use. If a resource
 			      has bits set in "shareable_bits" but not all
 			      of these bits appear in the resource groups'
 			      schematas then the bits appearing in
 			      "shareable_bits" but no resource group will
 			      be marked as "H".
-			"X" - Corresponding region is available for sharing and
+			"X"
+			    - Corresponding region is available for sharing and
 			      used by hardware and software. These are the
 			      bits that appear in "shareable_bits" as
 			      well as a resource group's allocation.
-			"S" - Corresponding region is used by software
+			"S"
+			    - Corresponding region is used by software
 			      and available for sharing.
-			"E" - Corresponding region is used exclusively by
+			"E"
+			    - Corresponding region is used exclusively by
 			      one resource group. No sharing allowed.
-			"P" - Corresponding region is pseudo-locked. No
+			"P"
+			    - Corresponding region is pseudo-locked. No
 			      sharing allowed.
 
 Memory bandwitdh(MB) subdirectory contains the following files
 with respect to allocation:
 
-"min_bandwidth":	The minimum memory bandwidth percentage which
+"min_bandwidth":
+			The minimum memory bandwidth percentage which
 			user can request.
 
-"bandwidth_gran":	The granularity in which the memory bandwidth
+"bandwidth_gran":
+			The granularity in which the memory bandwidth
 			percentage is allocated. The allocated
 			b/w percentage is rounded off to the next
 			control step available on the hardware. The
 			available bandwidth control steps are:
 			min_bandwidth + N * bandwidth_gran.
 
-"delay_linear": 	Indicates if the delay scale is linear or
+"delay_linear":
+			Indicates if the delay scale is linear or
 			non-linear. This field is purely informational
 			only.
 
 If RDT monitoring is available there will be an "L3_MON" directory
 with the following files:
 
-"num_rmids":		The number of RMIDs available. This is the
+"num_rmids":
+			The number of RMIDs available. This is the
 			upper bound for how many "CTRL_MON" + "MON"
 			groups can be created.
 
-"mon_features":	Lists the monitoring events if
+"mon_features":
+			Lists the monitoring events if
 			monitoring is enabled for the resource.
 
 "max_threshold_occupancy":
@@ -133,7 +162,7 @@ named "last_cmd_status". This is reset with every "command" issued
 via the file system (making new directories or writing to any of the
 control files). If the command was successful, it will read as "ok".
 If the command failed, it will provide more information that can be
-conveyed in the error returns from file operations. E.g.
+conveyed in the error returns from file operations. E.g.::
 
 	# echo L3:0=f7 > schemata
 	bash: echo: write error: Invalid argument
@@ -417,15 +446,15 @@ Reading/writing the schemata file
 ---------------------------------
 Reading the schemata file will show the state of all resources
 on all domains. When writing you only need to specify those values
-which you wish to change.  E.g.
+which you wish to change.  E.g.::
 
-# cat schemata
-L3DATA:0=fffff;1=fffff;2=fffff;3=fffff
-L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
-# echo "L3DATA:2=3c0;" > schemata
-# cat schemata
-L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
-L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
+  # cat schemata
+  L3DATA:0=fffff;1=fffff;2=fffff;3=fffff
+  L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
+  # echo "L3DATA:2=3c0;" > schemata
+  # cat schemata
+  L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
+  L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
 Cache Pseudo-Locking
 --------------------
@@ -442,6 +471,7 @@ a region of memory with reduced average read latency.
 The creation of a cache pseudo-locked region is triggered by a request
 from the user to do so that is accompanied by a schemata of the region
 to be pseudo-locked. The cache pseudo-locked region is created as follows:
+
 - Create a CAT allocation CLOSNEW with a CBM matching the schemata
   from the user of the cache region that will contain the pseudo-locked
   memory. This region must not overlap with any current CAT allocation/CLOS
@@ -480,6 +510,7 @@ initial mmap() handling, there is no enforcement afterwards and the
 application self needs to ensure it remains affine to the correct cores.
 
 Pseudo-locking is accomplished in two stages:
+
 1) During the first stage the system administrator allocates a portion
    of cache that should be dedicated to pseudo-locking. At this time an
    equivalent portion of memory is allocated, loaded into allocated
@@ -506,7 +537,7 @@ by user space in order to obtain access to the pseudo-locked memory region.
 An example of cache pseudo-locked region creation and usage can be found below.
 
 Cache Pseudo-Locking Debugging Interface
----------------------------------------
+----------------------------------------
 The pseudo-locking debugging interface is enabled by default (if
 CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
 
@@ -514,6 +545,7 @@ There is no explicit way for the kernel to test if a provided memory
 location is present in the cache. The pseudo-locking debugging interface uses
 the tracing infrastructure to provide two ways to measure cache residency of
 the pseudo-locked region:
+
 1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
    from these measurements are best visualized using a hist trigger (see
    example below). In this test the pseudo-locked region is traversed at
@@ -529,13 +561,14 @@ it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
 write-only file, pseudo_lock_measure, is present in this directory. The
 measurement of the pseudo-locked region depends on the number written to this
 debugfs file:
-1 -  writing "1" to the pseudo_lock_measure file will trigger the latency
+
+1.   writing "1" to the pseudo_lock_measure file will trigger the latency
      measurement captured in the pseudo_lock_mem_latency tracepoint. See
      example below.
-2 -  writing "2" to the pseudo_lock_measure file will trigger the L2 cache
+2.   writing "2" to the pseudo_lock_measure file will trigger the L2 cache
      residency (cache hits and misses) measurement captured in the
      pseudo_lock_l2 tracepoint. See example below.
-3 -  writing "3" to the pseudo_lock_measure file will trigger the L3 cache
+3.   writing "3" to the pseudo_lock_measure file will trigger the L3 cache
      residency (cache hits and misses) measurement captured in the
      pseudo_lock_l3 tracepoint.
 
@@ -546,55 +579,56 @@ Example of latency debugging interface:
 In this example a pseudo-locked region named "newlock" was created. Here is
 how we can measure the latency in cycles of reading from this region and
 visualize this data with a histogram that is available if CONFIG_HIST_TRIGGERS
-is set:
-# :> /sys/kernel/debug/tracing/trace
-# echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
-# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
-# echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
-# cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
+is set::
 
-# event histogram
-#
-# trigger info: hist:keys=latency:vals=hitcount:sort=hitcount:size=2048 [active]
-#
+  # :> /sys/kernel/debug/tracing/trace
+  # echo 'hist:keys=latency' > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/trigger
+  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/enable
+  # cat /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_mem_latency/hist
 
-{ latency:        456 } hitcount:          1
-{ latency:         50 } hitcount:         83
-{ latency:         36 } hitcount:         96
-{ latency:         44 } hitcount:        174
-{ latency:         48 } hitcount:        195
-{ latency:         46 } hitcount:        262
-{ latency:         42 } hitcount:        693
-{ latency:         40 } hitcount:       3204
-{ latency:         38 } hitcount:       3484
+  # event histogram
+  #
+  # trigger info: hist:keys=latency:vals=hitcount:sort=hitcount:size=2048 [active]
+  #
 
-Totals:
-    Hits: 8192
-    Entries: 9
-   Dropped: 0
+  { latency:        456 } hitcount:          1
+  { latency:         50 } hitcount:         83
+  { latency:         36 } hitcount:         96
+  { latency:         44 } hitcount:        174
+  { latency:         48 } hitcount:        195
+  { latency:         46 } hitcount:        262
+  { latency:         42 } hitcount:        693
+  { latency:         40 } hitcount:       3204
+  { latency:         38 } hitcount:       3484
+
+  Totals:
+      Hits: 8192
+      Entries: 9
+     Dropped: 0
 
 Example of cache hits/misses debugging:
 In this example a pseudo-locked region named "newlock" was created on the L2
 cache of a platform. Here is how we can obtain details of the cache hits
-and misses using the platform's precision counters.
+and misses using the platform's precision counters::
 
-# :> /sys/kernel/debug/tracing/trace
-# echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
-# echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-# echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
-# cat /sys/kernel/debug/tracing/trace
+  # :> /sys/kernel/debug/tracing/trace
+  # echo 1 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+  # echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/debug/tracing/events/resctrl/pseudo_lock_l2/enable
+  # cat /sys/kernel/debug/tracing/trace
 
-# tracer: nop
-#
-#                              _-----=> irqs-off
-#                             / _----=> need-resched
-#                            | / _---=> hardirq/softirq
-#                            || / _--=> preempt-depth
-#                            ||| /     delay
-#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
-#              | |       |   ||||       |         |
- pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=4097 miss=0
+  # tracer: nop
+  #
+  #                              _-----=> irqs-off
+  #                             / _----=> need-resched
+  #                            | / _---=> hardirq/softirq
+  #                            || / _--=> preempt-depth
+  #                            ||| /     delay
+  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+  #              | |       |   ||||       |         |
+   pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=4097 miss=0
 
 
 Examples for RDT allocation usage:
@@ -603,13 +637,13 @@ Example 1
 ---------
 On a two socket machine (one L3 cache per socket) with just four bits
 for cache bit masks, minimum b/w of 10% with a memory bandwidth
-granularity of 10%
+granularity of 10%::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
-# echo "L3:0=3;1=c\nMB:0=50;1=50" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3\nMB:0=50;1=50" > /sys/fs/resctrl/p1/schemata
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3;1=c\nMB:0=50;1=50" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3\nMB:0=50;1=50" > /sys/fs/resctrl/p1/schemata
 
 The default resource group is unmodified, so we have access to all parts
 of all caches (its schemata file reads "L3:0=f;1=f").
@@ -627,10 +661,10 @@ b/w that the group may be able to use and the system admin can configure
 the b/w accordingly.
 
 If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
-rather than the percentage values.
+rather than the percentage values::
 
-# echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
+  # echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
 
 In the above example the tasks in "p1" and "p0" on socket 0 would use a max b/w
 of 1024MB where as on socket 1 they would use 500MB.
@@ -642,51 +676,51 @@ Again two sockets, but this time with a more realistic 20-bit mask.
 Two real time tasks pid=1234 running on processor 0 and pid=5678 running on
 processor 1 on socket 0 on a 2-socket and dual core machine. To avoid noisy
 neighbors, each of the two real-time tasks exclusively occupies one quarter
-of L3 cache on socket 0.
+of L3 cache on socket 0::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
 
 First we reset the schemata for the default group so that the "upper"
 50% of the L3 cache on socket 0 and 50% of memory b/w cannot be used by
-ordinary tasks:
+ordinary tasks::
 
-# echo "L3:0=3ff;1=fffff\nMB:0=50;1=100" > schemata
+  # echo "L3:0=3ff;1=fffff\nMB:0=50;1=100" > schemata
 
 Next we make a resource group for our first real time task and give
-it access to the "top" 25% of the cache on socket 0.
+it access to the "top" 25% of the cache on socket 0::
 
-# mkdir p0
-# echo "L3:0=f8000;1=fffff" > p0/schemata
+  # mkdir p0
+  # echo "L3:0=f8000;1=fffff" > p0/schemata
 
 Finally we move our first real time task into this resource group. We
 also use taskset(1) to ensure the task always runs on a dedicated CPU
 on socket 0. Most uses of resource groups will also constrain which
-processors tasks run on.
+processors tasks run on::
 
-# echo 1234 > p0/tasks
-# taskset -cp 1 1234
+  # echo 1234 > p0/tasks
+  # taskset -cp 1 1234
 
 Ditto for the second real time task (with the remaining 25% of cache):
 
-# mkdir p1
-# echo "L3:0=7c00;1=fffff" > p1/schemata
-# echo 5678 > p1/tasks
-# taskset -cp 2 5678
+  # mkdir p1
+  # echo "L3:0=7c00;1=fffff" > p1/schemata
+  # echo 5678 > p1/tasks
+  # taskset -cp 2 5678
 
 For the same 2 socket system with memory b/w resource and CAT L3 the
 schemata would look like(Assume min_bandwidth 10 and bandwidth_gran is
 10):
 
 For our first real time task this would request 20% memory b/w on socket
-0.
+0::
 
-# echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
+  # echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
 
 For our second real time task this would request an other 20% memory b/w
-on socket 0.
+on socket 0::
 
-# echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
+  # echo -e "L3:0=f8000;1=fffff\nMB:0=20;1=100" > p0/schemata
 
 Example 3
 ---------
@@ -695,30 +729,30 @@ A single socket system which has real-time tasks running on core 4-7 and
 non real-time workload assigned to core 0-3. The real-time tasks share text
 and data, so a per task association is not required and due to interaction
 with the kernel it's desired that the kernel on these cores shares L3 with
-the tasks.
+the tasks::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
 
 First we reset the schemata for the default group so that the "upper"
 50% of the L3 cache on socket 0, and 50% of memory bandwidth on socket 0
-cannot be used by ordinary tasks:
+cannot be used by ordinary tasks::
 
-# echo "L3:0=3ff\nMB:0=50" > schemata
+  # echo "L3:0=3ff\nMB:0=50" > schemata
 
 Next we make a resource group for our real time cores and give it access
 to the "top" 50% of the cache on socket 0 and 50% of memory bandwidth on
-socket 0.
+socket 0::
 
-# mkdir p0
-# echo "L3:0=ffc00\nMB:0=50" > p0/schemata
+  # mkdir p0
+  # echo "L3:0=ffc00\nMB:0=50" > p0/schemata
 
 Finally we move core 4-7 over to the new group and make sure that the
 kernel and the tasks running there get 50% of the cache. They should
 also get 50% of memory bandwidth assuming that the cores 4-7 are SMT
-siblings and only the real time threads are scheduled on the cores 4-7.
+siblings and only the real time threads are scheduled on the cores 4-7::
 
-# echo F0 > p0/cpus
+  # echo F0 > p0/cpus
 
 Example 4
 ---------
@@ -731,116 +765,124 @@ to overlap with that allocation.
 In this example a new exclusive resource group will be created on a L2 CAT
 system with two L2 cache instances that can be configured with an 8-bit
 capacity bitmask. The new exclusive resource group will be configured to use
-25% of each cache instance.
+25% of each cache instance::
 
-# mount -t resctrl resctrl /sys/fs/resctrl/
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
 
 First, we observe that the default group is configured to allocate to all L2
-cache:
+cache::
 
-# cat schemata
-L2:0=ff;1=ff
+  # cat schemata
+  L2:0=ff;1=ff
 
 We could attempt to create the new resource group at this point, but it will
-fail because of the overlap with the schemata of the default group:
-# mkdir p0
-# echo 'L2:0=0x3;1=0x3' > p0/schemata
-# cat p0/mode
-shareable
-# echo exclusive > p0/mode
--sh: echo: write error: Invalid argument
-# cat info/last_cmd_status
-schemata overlaps
+fail because of the overlap with the schemata of the default group::
+
+  # mkdir p0
+  # echo 'L2:0=0x3;1=0x3' > p0/schemata
+  # cat p0/mode
+  shareable
+  # echo exclusive > p0/mode
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  schemata overlaps
 
 To ensure that there is no overlap with another resource group the default
 resource group's schemata has to change, making it possible for the new
-resource group to become exclusive.
-# echo 'L2:0=0xfc;1=0xfc' > schemata
-# echo exclusive > p0/mode
-# grep . p0/*
-p0/cpus:0
-p0/mode:exclusive
-p0/schemata:L2:0=03;1=03
-p0/size:L2:0=262144;1=262144
+resource group to become exclusive::
+
+  # echo 'L2:0=0xfc;1=0xfc' > schemata
+  # echo exclusive > p0/mode
+  # grep . p0/*
+  p0/cpus:0
+  p0/mode:exclusive
+  p0/schemata:L2:0=03;1=03
+  p0/size:L2:0=262144;1=262144
 
 A new resource group will on creation not overlap with an exclusive resource
-group:
-# mkdir p1
-# grep . p1/*
-p1/cpus:0
-p1/mode:shareable
-p1/schemata:L2:0=fc;1=fc
-p1/size:L2:0=786432;1=786432
+group::
 
-The bit_usage will reflect how the cache is used:
-# cat info/L2/bit_usage
-0=SSSSSSEE;1=SSSSSSEE
+  # mkdir p1
+  # grep . p1/*
+  p1/cpus:0
+  p1/mode:shareable
+  p1/schemata:L2:0=fc;1=fc
+  p1/size:L2:0=786432;1=786432
 
-A resource group cannot be forced to overlap with an exclusive resource group:
-# echo 'L2:0=0x1;1=0x1' > p1/schemata
--sh: echo: write error: Invalid argument
-# cat info/last_cmd_status
-overlaps with exclusive group
+The bit_usage will reflect how the cache is used::
+
+  # cat info/L2/bit_usage
+  0=SSSSSSEE;1=SSSSSSEE
+
+A resource group cannot be forced to overlap with an exclusive resource group::
+
+  # echo 'L2:0=0x1;1=0x1' > p1/schemata
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  overlaps with exclusive group
 
 Example of Cache Pseudo-Locking
 -------------------------------
 Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
 region is exposed at /dev/pseudo_lock/newlock that can be provided to
-application for argument to mmap().
+application for argument to mmap()::
 
-# mount -t resctrl resctrl /sys/fs/resctrl/
-# cd /sys/fs/resctrl
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
 
 Ensure that there are bits available that can be pseudo-locked, since only
 unused bits can be pseudo-locked the bits to be pseudo-locked needs to be
-removed from the default resource group's schemata:
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSSSS
-# echo 'L2:1=0xfc' > schemata
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSS00
+removed from the default resource group's schemata::
+
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSSSS
+  # echo 'L2:1=0xfc' > schemata
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSS00
 
 Create a new resource group that will be associated with the pseudo-locked
 region, indicate that it will be used for a pseudo-locked region, and
-configure the requested pseudo-locked region capacity bitmask:
+configure the requested pseudo-locked region capacity bitmask::
 
-# mkdir newlock
-# echo pseudo-locksetup > newlock/mode
-# echo 'L2:1=0x3' > newlock/schemata
+  # mkdir newlock
+  # echo pseudo-locksetup > newlock/mode
+  # echo 'L2:1=0x3' > newlock/schemata
 
 On success the resource group's mode will change to pseudo-locked, the
 bit_usage will reflect the pseudo-locked region, and the character device
-exposing the pseudo-locked region will exist:
+exposing the pseudo-locked region will exist::
 
-# cat newlock/mode
-pseudo-locked
-# cat info/L2/bit_usage
-0=SSSSSSSS;1=SSSSSSPP
-# ls -l /dev/pseudo_lock/newlock
-crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
+  # cat newlock/mode
+  pseudo-locked
+  # cat info/L2/bit_usage
+  0=SSSSSSSS;1=SSSSSSPP
+  # ls -l /dev/pseudo_lock/newlock
+  crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
 
-/*
- * Example code to access one page of pseudo-locked cache region
- * from user space.
- */
-#define _GNU_SOURCE
-#include <fcntl.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/mman.h>
+::
 
-/*
- * It is required that the application runs with affinity to only
- * cores associated with the pseudo-locked region. Here the cpu
- * is hardcoded for convenience of example.
- */
-static int cpuid = 2;
+  /*
+   * Example code to access one page of pseudo-locked cache region
+   * from user space.
+   */
+  #define _GNU_SOURCE
+  #include <fcntl.h>
+  #include <sched.h>
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <unistd.h>
+  #include <sys/mman.h>
 
-int main(int argc, char *argv[])
-{
+  /*
+   * It is required that the application runs with affinity to only
+   * cores associated with the pseudo-locked region. Here the cpu
+   * is hardcoded for convenience of example.
+   */
+  static int cpuid = 2;
+
+  int main(int argc, char *argv[])
+  {
 	cpu_set_t cpuset;
 	long page_size;
 	void *mapping;
@@ -882,7 +924,7 @@ int main(int argc, char *argv[])
 
 	close(dev_fd);
 	exit(EXIT_SUCCESS);
-}
+  }
 
 Locking between applications
 ----------------------------
@@ -921,32 +963,32 @@ Read lock:
  B) If success read the directory structure.
  C) funlock
 
-Example with bash:
+Example with bash::
 
-# Atomically read directory structure
-$ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
+  # Atomically read directory structure
+  $ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
 
-# Read directory contents and create new subdirectory
+  # Read directory contents and create new subdirectory
 
-$ cat create-dir.sh
-find /sys/fs/resctrl/ > output.txt
-mask = function-of(output.txt)
-mkdir /sys/fs/resctrl/newres/
-echo mask > /sys/fs/resctrl/newres/schemata
+  $ cat create-dir.sh
+  find /sys/fs/resctrl/ > output.txt
+  mask = function-of(output.txt)
+  mkdir /sys/fs/resctrl/newres/
+  echo mask > /sys/fs/resctrl/newres/schemata
 
-$ flock /sys/fs/resctrl/ ./create-dir.sh
+  $ flock /sys/fs/resctrl/ ./create-dir.sh
 
-Example with C:
+Example with C::
 
-/*
- * Example code do take advisory locks
- * before accessing resctrl filesystem
- */
-#include <sys/file.h>
-#include <stdlib.h>
+  /*
+   * Example code do take advisory locks
+   * before accessing resctrl filesystem
+   */
+  #include <sys/file.h>
+  #include <stdlib.h>
 
-void resctrl_take_shared_lock(int fd)
-{
+  void resctrl_take_shared_lock(int fd)
+  {
 	int ret;
 
 	/* take shared lock on resctrl filesystem */
@@ -955,10 +997,10 @@ void resctrl_take_shared_lock(int fd)
 		perror("flock");
 		exit(-1);
 	}
-}
+  }
 
-void resctrl_take_exclusive_lock(int fd)
-{
+  void resctrl_take_exclusive_lock(int fd)
+  {
 	int ret;
 
 	/* release lock on resctrl filesystem */
@@ -967,10 +1009,10 @@ void resctrl_take_exclusive_lock(int fd)
 		perror("flock");
 		exit(-1);
 	}
-}
+  }
 
-void resctrl_release_lock(int fd)
-{
+  void resctrl_release_lock(int fd)
+  {
 	int ret;
 
 	/* take shared lock on resctrl filesystem */
@@ -979,10 +1021,10 @@ void resctrl_release_lock(int fd)
 		perror("flock");
 		exit(-1);
 	}
-}
+  }
 
-void main(void)
-{
+  void main(void)
+  {
 	int fd, ret;
 
 	fd = open("/sys/fs/resctrl", O_DIRECTORY);
@@ -997,7 +1039,7 @@ void main(void)
 	resctrl_take_exclusive_lock(fd);
 	/* code to read and write directory contents */
 	resctrl_release_lock(fd);
-}
+  }
 
 Examples for RDT Monitoring along with allocation usage:
 
@@ -1009,17 +1051,17 @@ group or CTRL_MON group.
 
 
 Example 1 (Monitor CTRL_MON group and subset of tasks in CTRL_MON group)
----------
+------------------------------------------------------------------------
 On a two socket machine (one L3 cache per socket) with just four bits
-for cache bit masks
+for cache bit masks::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
-# echo "L3:0=3;1=c" > /sys/fs/resctrl/p0/schemata
-# echo "L3:0=3;1=3" > /sys/fs/resctrl/p1/schemata
-# echo 5678 > p1/tasks
-# echo 5679 > p1/tasks
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3;1=c" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3;1=3" > /sys/fs/resctrl/p1/schemata
+  # echo 5678 > p1/tasks
+  # echo 5679 > p1/tasks
 
 The default resource group is unmodified, so we have access to all parts
 of all caches (its schemata file reads "L3:0=f;1=f").
@@ -1028,48 +1070,48 @@ Tasks that are under the control of group "p0" may only allocate from the
 "lower" 50% on cache ID 0, and the "upper" 50% of cache ID 1.
 Tasks in group "p1" use the "lower" 50% of cache on both sockets.
 
-Create monitor groups and assign a subset of tasks to each monitor group.
+Create monitor groups and assign a subset of tasks to each monitor group::
 
-# cd /sys/fs/resctrl/p1/mon_groups
-# mkdir m11 m12
-# echo 5678 > m11/tasks
-# echo 5679 > m12/tasks
+  # cd /sys/fs/resctrl/p1/mon_groups
+  # mkdir m11 m12
+  # echo 5678 > m11/tasks
+  # echo 5679 > m12/tasks
 
-fetch data (data shown in bytes)
+fetch data (data shown in bytes)::
 
-# cat m11/mon_data/mon_L3_00/llc_occupancy
-16234000
-# cat m11/mon_data/mon_L3_01/llc_occupancy
-14789000
-# cat m12/mon_data/mon_L3_00/llc_occupancy
-16789000
+  # cat m11/mon_data/mon_L3_00/llc_occupancy
+  16234000
+  # cat m11/mon_data/mon_L3_01/llc_occupancy
+  14789000
+  # cat m12/mon_data/mon_L3_00/llc_occupancy
+  16789000
 
-The parent ctrl_mon group shows the aggregated data.
+The parent ctrl_mon group shows the aggregated data::
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-31234000
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31234000
 
 Example 2 (Monitor a task from its creation)
----------
-On a two socket machine (one L3 cache per socket)
+--------------------------------------------
+On a two socket machine (one L3 cache per socket)::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p0 p1
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
 
 An RMID is allocated to the group once its created and hence the <cmd>
-below is monitored from its creation.
+below is monitored from its creation::
 
-# echo $$ > /sys/fs/resctrl/p1/tasks
-# <cmd>
+  # echo $$ > /sys/fs/resctrl/p1/tasks
+  # <cmd>
 
-Fetch the data
+Fetch the data::
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-31789000
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31789000
 
 Example 3 (Monitor without CAT support or before creating CAT groups)
----------
+---------------------------------------------------------------------
 
 Assume a system like HSW has only CQM and no CAT support. In this case
 the resctrl will still mount but cannot create CTRL_MON directories.
@@ -1077,28 +1119,28 @@ But user can create different MON groups within the root group thereby
 able to monitor all tasks including kernel threads.
 
 This can also be used to profile jobs cache size footprint before being
-able to allocate them to different allocation groups.
+able to allocate them to different allocation groups::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir mon_groups/m01
-# mkdir mon_groups/m02
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir mon_groups/m01
+  # mkdir mon_groups/m02
 
-# echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
-# echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
+  # echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
+  # echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
 
 Monitor the groups separately and also get per domain data. From the
 below its apparent that the tasks are mostly doing work on
-domain(socket) 0.
+domain(socket) 0::
 
-# cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
-31234000
-# cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
-34555
-# cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
-31234000
-# cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
-32789
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
+  34555
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
+  32789
 
 
 Example 4 (Monitor real time tasks)
@@ -1106,16 +1148,17 @@ Example 4 (Monitor real time tasks)
 
 A single socket system which has real time tasks running on cores 4-7
 and non real time tasks on other cpus. We want to monitor the cache
-occupancy of the real time threads on these cores.
+occupancy of the real time threads on these cores::
 
-# mount -t resctrl resctrl /sys/fs/resctrl
-# cd /sys/fs/resctrl
-# mkdir p1
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p1
 
-Move the cpus 4-7 over to p1
-# echo f0 > p1/cpus
+Move the cpus 4-7 over to p1::
 
-View the llc occupancy snapshot
+  # echo f0 > p1/cpus
 
-# cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
-11234000
+View the llc occupancy snapshot::
+
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
+  11234000
diff --git a/Documentation/x86/tlb.txt b/Documentation/x86/tlb.txt
index 6a0607b99ed8..073a0f6827c8 100644
--- a/Documentation/x86/tlb.txt
+++ b/Documentation/x86/tlb.txt
@@ -1,5 +1,10 @@
+==================================
+Translation Lookaside Buffer (TLB)
+==================================
+
 When the kernel unmaps or modified the attributes of a range of
 memory, it has two choices:
+
  1. Flush the entire TLB with a two-instruction sequence.  This is
     a quick operation, but it causes collateral damage: TLB entries
     from areas other than the one we are trying to flush will be
@@ -10,6 +15,7 @@ memory, it has two choices:
     damage to other TLB entries.
 
 Which method to do depends on a few things:
+
  1. The size of the flush being performed.  A flush of the entire
     address space is obviously better performed by flushing the
     entire TLB than doing 2^48/PAGE_SIZE individual flushes.
@@ -31,7 +37,7 @@ sizes of the flush will vary greatly depending on the workload as
 well.  There is essentially no "right" point to choose.
 
 You may be doing too many individual invalidations if you see the
-invlpg instruction (or instructions _near_ it) show up high in
+invlpg instruction (or instructions *near* it) show up high in
 profiles.  If you believe that individual invalidations being
 called too often, you can lower the tunable:
 
@@ -54,9 +60,9 @@ Essentially, you are balancing the cycles you spend doing invlpg
 with the cycles that you spend refilling the TLB later.
 
 You can measure how expensive TLB refills are by using
-performance counters and 'perf stat', like this:
+performance counters and 'perf stat', like this::
 
-perf stat -e
+  perf stat -e
 	cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
 	cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
 	cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 2953e3ec9a02..4ad29eb0fc6d 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -1,3 +1,4 @@
+============
 x86 Topology
 ============
 
@@ -66,12 +67,13 @@ The topology of a system is described in the units of:
   - cpu_llc_id:
 
     A per-CPU variable containing:
+
     - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
-    Cache
+      Cache
 
     - On AMD, the Node ID or Core Complex ID containing the Last Level
-    Cache. In general, it is a number identifying an LLC uniquely on the
-    system.
+      Cache. In general, it is a number identifying an LLC uniquely on the
+      system.
 
 * Cores:
 
@@ -138,32 +140,32 @@ That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
 the same whether threads are enabled or not. That's merely an implementation
 detail and has no practical impact.
 
-1) Single Package, Single Core
+1) Single Package, Single Core::
 
    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 
 2) Single Package, Dual Core
 
-   a) One thread per core
+   a) One thread per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
 
-   b) Two threads per core
+   b) Two threads per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 1
 		    -> [core 1] -> [thread 0] -> Linux CPU 2
 				-> [thread 1] -> Linux CPU 3
 
-      Alternative enumeration:
+      Alternative enumeration::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 2
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
 				-> [thread 1] -> Linux CPU 3
 
-      AMD nomenclature for CMT systems:
+      AMD nomenclature for CMT systems::
 
 	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
 				     -> [Compute Unit Core 1] -> Linux CPU 1
@@ -172,7 +174,7 @@ detail and has no practical impact.
 
 4) Dual Package, Dual Core
 
-   a) One thread per core
+   a) One thread per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
@@ -180,7 +182,7 @@ detail and has no practical impact.
 	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
 		    -> [core 1] -> [thread 0] -> Linux CPU 3
 
-   b) Two threads per core
+   b) Two threads per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 1
@@ -192,7 +194,7 @@ detail and has no practical impact.
 		    -> [core 1] -> [thread 0] -> Linux CPU 6
 				-> [thread 1] -> Linux CPU 7
 
-      Alternative enumeration:
+      Alternative enumeration::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 4
@@ -204,7 +206,7 @@ detail and has no practical impact.
 		    -> [core 1] -> [thread 0] -> Linux CPU 3
 				-> [thread 1] -> Linux CPU 7
 
-      AMD nomenclature for CMT systems:
+      AMD nomenclature for CMT systems::
 
 	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
 				     -> [Compute Unit Core 1] -> Linux CPU 1
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.txt
index 1894cdfc69d9..ea18db8c7441 100644
--- a/Documentation/x86/usb-legacy-support.txt
+++ b/Documentation/x86/usb-legacy-support.txt
@@ -1,5 +1,6 @@
+==================
 USB Legacy support
-~~~~~~~~~~~~~~~~~~
+==================
 
 Vojtech Pavlik <vojtech@suse.cz>, January 2004
 
@@ -25,20 +26,22 @@ It has several drawbacks, though:
    BIOS manufacturers only test with Windows, and Windows doesn't do 64-bit
    yet.
 
-Solutions:
+Solutions
 
-Problem 1) can be solved by loading the USB drivers prior to loading the
-PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
-the kernel unconditionally, this means the USB drivers need to be
-compiled-in, too.
+Problem 1)
+  Can be solved by loading the USB drivers prior to loading the
+  PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
+  the kernel unconditionally, this means the USB drivers need to be
+  compiled-in, too.
 
-Problem 2) can currently only be solved by either disabling HIGHMEM64G
-in the kernel config or USB Legacy support in the BIOS. A BIOS update
-could help, but so far no such update exists.
-
-Problem 3) is usually fixed by a BIOS update. Check the board
-manufacturers web site. If an update is not available, disable USB
-Legacy support in the BIOS. If this alone doesn't help, try also adding
-idle=poll on the kernel command line. The BIOS may be entering the SMM
-on the HLT instruction as well.
+Problem 2)
+  Can currently only be solved by either disabling HIGHMEM64G
+  in the kernel config or USB Legacy support in the BIOS. A BIOS update
+  could help, but so far no such update exists.
 
+Problem 3)
+  Is usually fixed by a BIOS update. Check the board
+  manufacturers web site. If an update is not available, disable USB
+  Legacy support in the BIOS. If this alone doesn't help, try also adding
+  idle=poll on the kernel command line. The BIOS may be entering the SMM
+  on the HLT instruction as well.
diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.txt
index 2432a5ef86d9..fb7a12a83ad7 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.txt
@@ -1,4 +1,9 @@
-== Overview ==
+==============
+5-level Paging
+==============
+
+Overview
+========
 
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
@@ -16,7 +21,8 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
+Enabling 5-level paging
+=======================
 
 CONFIG_X86_5LEVEL=y enables the feature.
 
@@ -24,7 +30,8 @@ Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
+User-space and large virtual address space
+==========================================
 
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index abc53886655e..20ab030fdb2a 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -1,9 +1,12 @@
+===========================
 AMD64 specific boot options
+===========================
 
 There are many others (usually documented in driver documentation), but
 only the AMD64 specific ones are listed here.
 
 Machine check
+=============
 
    Please see Documentation/x86/x86_64/machinecheck for sysfs runtime tunables.
 
@@ -69,27 +72,31 @@ Machine check
    Everything else is in sysfs now.
 
 APICs
+=====
 
-   apic		 Use IO-APIC. Default
+   ============== =============================================================
+   apic		  Use IO-APIC. Default
 
-   noapic	 Don't use the IO-APIC.
+   noapic	  Don't use the IO-APIC.
 
-   disableapic	 Don't use the local APIC
+   disableapic	  Don't use the local APIC
 
-   nolapic	 Don't use the local APIC (alias for i386 compatibility)
+   nolapic	  Don't use the local APIC (alias for i386 compatibility)
 
-   pirq=...	 See Documentation/x86/i386/IO-APIC.txt
+   pirq=...	  See Documentation/x86/i386/IO-APIC.txt
 
-   noapictimer	 Don't set up the APIC timer
+   noapictimer	  Don't set up the APIC timer
 
    no_timer_check Don't check the IO-APIC timer. This can work around
-		 problems with incorrect timer initialization on some boards.
+		  problems with incorrect timer initialization on some boards.
    apicpmtimer
-		 Do APIC timer calibration using the pmtimer. Implies
-		 apicmaintimer. Useful when your PIT timer is totally
-		 broken.
+		  Do APIC timer calibration using the pmtimer. Implies
+		  apicmaintimer. Useful when your PIT timer is totally
+		  broken.
+   ============== =============================================================
 
 Timing
+======
 
   notsc
   Deprecated, use tsc=unstable instead.
@@ -98,19 +105,25 @@ Timing
   Don't use the HPET timer.
 
 Idle loop
+=========
 
   idle=poll
+
   Don't do power saving in the idle loop using HLT, but poll for rescheduling
   event. This will make the CPUs eat a lot more power, but may be useful
   to get slightly better performance in multiprocessor benchmarks. It also
   makes some profiling using performance counters more accurate.
+
   Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
   CPUs) this option has no performance advantage over the normal idle loop.
   It may also interact badly with hyperthreading.
 
 Rebooting
+=========
 
    reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
+
+   ====== =====================================================================
    bios	  Use the CPU reboot vector for warm reset
    warm   Don't set the cold reboot flag
    cold   Set the cold reboot flag
@@ -122,6 +135,7 @@ Rebooting
    efi    Use efi reset_system runtime service. If EFI is not configured or the
           EFI reset does not work, the reboot path attempts the reset using
           the keyboard controller.
+   ====== =====================================================================
 
    Using warm reset will be much faster especially on big memory
    systems because the BIOS will not go through the memory check.
@@ -134,17 +148,23 @@ Rebooting
    in some cases.
 
 Non Executable Mappings
+=======================
 
   noexec=on|off
 
+  ===     ===============
   on      Enable(default)
   off     Disable
+  ===     ===============
 
 NUMA
+====
 
-  numa=off	Only set up a single NUMA node spanning all memory.
+  numa=off
+		Only set up a single NUMA node spanning all memory.
 
-  numa=noacpi   Don't parse the SRAT table for NUMA setup
+  numa=noacpi
+		Don't parse the SRAT table for NUMA setup
 
   numa=fake=<size>[MG]
 		If given as a memory unit, fills all system RAM with nodes of
@@ -159,35 +179,45 @@ NUMA
 		physical node into N emulated nodes.
 
 ACPI
+====
 
-  acpi=off	Don't enable ACPI
-  acpi=ht	Use ACPI boot table parsing, but don't enable ACPI
-		interpreter
-  acpi=force	Force ACPI on (currently not needed)
+  ============================== ==============================================
+  acpi=off			 Don't enable ACPI
+  acpi=ht			 Use ACPI boot table parsing, but don't enable
+				 ACPI interpreter
+  acpi=force			 Force ACPI on (currently not needed)
 
-  acpi=strict   Disable out of spec ACPI workarounds.
+  acpi=strict			 Disable out of spec ACPI workarounds.
 
-  acpi_sci={edge,level,high,low}  Set up ACPI SCI interrupt.
+  acpi_sci={edge,level,high,low} Set up ACPI SCI interrupt.
 
-  acpi=noirq	Don't route interrupts
+  acpi=noirq			 Don't route interrupts
+
+  acpi=nocmcff			 Disable firmware first mode for corrected
+				 errors. This disables parsing the HEST CMC
+				 error source to check if firmware has set
+				 the FF flag. This may result in duplicate
+				 corrected error reports.
+  ============================== ==============================================
 
-  acpi=nocmcff	Disable firmware first mode for corrected errors. This
-		disables parsing the HEST CMC error source to check if
-		firmware has set the FF flag. This may result in
-		duplicate corrected error reports.
 
 PCI
+===
 
+  ===================== ====================================================
   pci=off		Don't use PCI
   pci=conf1		Use conf1 access.
   pci=conf2		Use conf2 access.
   pci=rom		Assign ROMs.
   pci=assign-busses	Assign busses
   pci=irqmask=MASK	Set PCI interrupt mask to MASK
-  pci=lastbus=NUMBER	Scan up to NUMBER busses, no matter what the mptable says.
+  pci=lastbus=NUMBER	Scan up to NUMBER busses, no matter what the mptable
+			says.
   pci=noacpi		Don't use ACPI to set up PCI interrupt routing.
+  ===================== ====================================================
 
 IOMMU (input/output memory management unit)
+===========================================
 
  Multiple x86-64 PCI-DMA mapping implementations exist, for example:
 
@@ -209,11 +239,12 @@ IOMMU (input/output memory management unit)
       mapping with memory protection, etc.
       Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
 
- iommu=[<size>][,noagp][,off][,force][,noforce]
-	[,memaper[=<order>]][,merge][,fullflush][,nomerge]
-	[,noaperture][,calgary]
+ iommu=[<size>][,noagp][,off][,force][,noforce][,memaper[=<order>]][,merge]
+ [,fullflush][,nomerge][,noaperture][,calgary]
 
   General iommu options:
+
+    ================== =======================================================
     off                Don't initialize and use any kind of IOMMU.
     noforce            Don't force hardware IOMMU usage when it is not needed.
                        (default).
@@ -222,8 +253,11 @@ IOMMU (input/output memory management unit)
     soft               Use software bounce buffering (SWIOTLB) (default for
                        Intel machines). This can be used to prevent the usage
                        of an available hardware IOMMU.
+    ================== =======================================================
 
   iommu options only relevant to the AMD GART hardware IOMMU:
+
+    ================== ========================================================
     <size>             Set the size of the remapping area in bytes.
     allowed            Overwrite iommu off workarounds for specific chipsets.
     fullflush          Flush IOMMU on each allocation (default).
@@ -237,21 +271,31 @@ IOMMU (input/output memory management unit)
     noagp              Don't initialize the AGP driver and use full aperture.
     panic              Always panic when IOMMU overflows.
     calgary            Use the Calgary IOMMU if it is available
+    ================== ========================================================
 
   iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
   implementation:
+
     swiotlb=<pages>[,force]
+
+    ================== ===================================================
     <pages>            Prereserve that many 128K pages for the software IO
                        bounce buffering.
     force              Force all IO through the software TLB.
+    ================== ===================================================
 
   Settings for the IBM Calgary hardware IOMMU currently found in IBM
   pSeries and xSeries machines:
 
     calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
+
     calgary=[translate_empty_slots]
+
     calgary=[disable=<PCI bus number>]
+
+    =====              =================================
     panic              Always panic when IOMMU overflows
+    =====              =================================
 
     64k,...,8M - Set the size of each PCI slot's translation table
     when using the Calgary IOMMU. This is the size of the translation
diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 804f9426ed17..be9958ece8d9 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -18,51 +18,68 @@ Notes:
    notation than "16 EB", which few will recognize at first sight as 16 exabytes.
    It also shows it nicely how incredibly large 64-bit address space is.
 
-========================================================================================================================
-    Start addr    |   Offset   |     End addr     |  Size   | VM area description
-========================================================================================================================
-                  |            |                  |         |
- 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
-__________________|____________|__________________|_________|___________________________________________________________
-                  |            |                  |         |
- 0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                  |            |                  |         |     virtual memory addresses up to the -128 TB
-                  |            |                  |         |     starting offset of kernel mappings.
-__________________|____________|__________________|_________|___________________________________________________________
-                                                            |
-                                                            | Kernel-space virtual memory, shared between all processes:
-____________________________________________________________|___________________________________________________________
-                  |            |                  |         |
- ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
- ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI
- ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
- ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole
- ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
- ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
- ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
- ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
- ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
-__________________|____________|__________________|_________|____________________________________________________________
-                                                            |
-                                                            | Identical layout to the 56-bit one from here on:
-____________________________________________________________|____________________________________________________________
-                  |            |                  |         |
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
- ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
- ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
- ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
- ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
- ffffffff80000000 |-2048    MB |                  |         |
- ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
- ffffffffff000000 |  -16    MB |                  |         |
-    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
- ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
- ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
-__________________|____________|__________________|_________|___________________________________________________________
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   Start addr    |   Offset   |     End addr     |  Size   | VM area description                                       |
++=================+============+==================+=========+===========================================================+
+|                 |            |                  |         |                                                           |
+|0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm               |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                 |            |                  |         |                                                           |
+|0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical       |
+|                 |            |                  |         | virtual memory addresses up to the -128 TB                |
+|                 |            |                  |         | starting offset of kernel mappings.                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                      **Kernel-space virtual memory, shared between all processes:**                                   |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor              |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                         **Identical layout to the 56-bit one from here on:**                                          |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole                                           |
+|                 |            |                  |         | vaddr_end for KASLR                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping                                    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |-2048    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space                                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff000000 |  -16    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
 
 
 ====================================================
@@ -76,51 +93,66 @@ Notes:
    offset and many of the regions expand to support the much larger physical
    memory supported.
 
-========================================================================================================================
-    Start addr    |   Offset   |     End addr     |  Size   | VM area description
-========================================================================================================================
-                  |            |                  |         |
- 0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
-__________________|____________|__________________|_________|___________________________________________________________
-                  |            |                  |         |
- 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
-                  |            |                  |         |     virtual memory addresses up to the -64 PB
-                  |            |                  |         |     starting offset of kernel mappings.
-__________________|____________|__________________|_________|___________________________________________________________
-                                                            |
-                                                            | Kernel-space virtual memory, shared between all processes:
-____________________________________________________________|___________________________________________________________
-                  |            |                  |         |
- ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
- ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI
- ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
- ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole
- ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
- ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
- ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
- ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
- ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
-__________________|____________|__________________|_________|____________________________________________________________
-                                                            |
-                                                            | Identical layout to the 47-bit one from here on:
-____________________________________________________________|____________________________________________________________
-                  |            |                  |         |
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
- ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
- ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
- ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
- ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
- ffffffff80000000 |-2048    MB |                  |         |
- ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
- ffffffffff000000 |  -16    MB |                  |         |
-    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
- ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
- ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
-__________________|____________|__________________|_________|___________________________________________________________
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   Start addr    |   Offset   |     End addr     |  Size   | VM area description                                       |
++=================+============+==================+=========+===========================================================+
+|0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm               |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical |
+|                 |            |                  |         | virtual memory addresses up to the -64 PB                 |
+|                 |            |                  |         | starting offset of kernel mappings.                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                       **Kernel-space virtual memory, shared between all processes:**                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor              |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                           **Identical layout to the 47-bit one from here on:**                                        |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole                                           |
+|                 |            |                  |         | vaddr_end for KASLR                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping                                    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |-2048    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space                                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff000000 |  -16    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
 
 Architecture defines a 64-bit virtual address. Implementations can support
 less. Currently supported are 48- and 57-bit virtual addresses. Bits 63
diff --git a/Documentation/x86/x86_64/uefi.txt b/Documentation/x86/x86_64/uefi.txt
index a5e2b4fdb170..7b564b0aa02e 100644
--- a/Documentation/x86/x86_64/uefi.txt
+++ b/Documentation/x86/x86_64/uefi.txt
@@ -1,5 +1,6 @@
+=====================================
 General note on [U]EFI x86_64 support
--------------------------------------
+=====================================
 
 The nomenclature EFI and UEFI are used interchangeably in this document.
 
@@ -14,29 +15,41 @@ with EFI firmware and specifications are listed below.
 
 3. x86_64 platform with EFI/UEFI firmware.
 
-Mechanics:
+Mechanics
 ---------
-- Build the kernel with the following configuration.
+- Build the kernel with the following configuration::
 	CONFIG_FB_EFI=y
 	CONFIG_FRAMEBUFFER_CONSOLE=y
+
   If EFI runtime services are expected, the following configuration should
-  be selected.
+  be selected::
+
 	CONFIG_EFI=y
 	CONFIG_EFI_VARS=y or m		# optional
+
 - Create a VFAT partition on the disk
 - Copy the following to the VFAT partition:
+
 	elilo bootloader with x86_64 support, elilo configuration file,
 	kernel image built in first step and corresponding
 	initrd. Instructions on building elilo	and its dependencies
 	can be found in the elilo sourceforge project.
+
 - Boot to EFI shell and invoke elilo choosing the kernel image built
   in first step.
 - If some or all EFI runtime services don't work, you can try following
   kernel command line parameters to turn off some or all EFI runtime
   services.
+
+        =============== ===================================
 	noefi		turn off all EFI runtime services
 	reboot_type=k	turn off EFI reboot runtime service
+        =============== ===================================
+
 - If the EFI memory map has additional entries not in the E820 map,
   you can include those entries in the kernels memory map of available
   physical RAM by using the following kernel command line parameter.
+
+        =============== ================================================
 	add_efi_memmap	include EFI memory map of available physical RAM
+        =============== ================================================
diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
index 68aed077f7b6..fc4554e038d2 100644
--- a/Documentation/x86/zero-page.txt
+++ b/Documentation/x86/zero-page.txt
@@ -1,3 +1,7 @@
+=========
+Zero Page
+=========
+
 The additional fields in struct boot_params as a part of 32-bit boot
 protocol of kernel. These should be filled by bootloader or 16-bit
 real-mode setup code of the kernel. References/settings to it mainly
@@ -5,36 +9,39 @@ are in:
 
   arch/x86/include/uapi/asm/bootparam.h
 
-
+=======	=====	=======================	=======================================
 Offset	Proto	Name		Meaning
 /Size
-
-000/040	ALL	screen_info	Text mode or frame buffer information
-				(struct screen_info)
-040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
-058/008	ALL	tboot_addr      Physical address of tboot shared page
-060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
-				(struct ist_info)
-080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
-090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
-0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
-				OBSOLETE!!
-0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
-0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
-0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
-0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
-140/080	ALL	edid_info	Video mode setup (struct edid_info)
-1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
-1E4/004	ALL	scratch		Scratch field for the kernel setup code
-1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
-1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
+=======	=====	=======================	=======================================
+000/040	ALL	screen_info		Text mode or frame buffer information
+					(struct screen_info)
+040/014	ALL	apm_bios_info		APM BIOS information
+					(struct apm_bios_info)
+058/008	ALL	tboot_addr		Physical address of tboot shared page
+060/010	ALL	ist_info		Intel SpeedStep (IST) BIOS support
+					information
+					(struct ist_info)
+080/010	ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
+090/010	ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
+0A0/010	ALL	sys_desc_table		System description table
+					(struct sys_desc_table), OBSOLETE!!
+0B0/010	ALL	olpc_ofw_header		OLPC's OpenFirmware CIF and friends
+0C0/004	ALL	ext_ramdisk_image	ramdisk_image high 32bits
+0C4/004	ALL	ext_ramdisk_size	ramdisk_size high 32bits
+0C8/004	ALL	ext_cmd_line_ptr	cmd_line_ptr high 32bits
+140/080	ALL	edid_info		Video mode setup (struct edid_info)
+1C0/020	ALL	efi_info		EFI 32 information (struct efi_info)
+1E0/004	ALL	alt_mem_k		Alternative mem check, in KB
+1E4/004	ALL	scratch			Scratch field for the kernel setup code
+1E8/001	ALL	e820_entries		Number of entries in e820_table (below)
+1E9/001	ALL	eddbuf_entries		Number of entries in eddbuf (below)
 1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
-				(below)
-1EB/001	ALL     kbd_status      Numlock is enabled
-1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
-1EF/001	ALL	sentinel	Used to detect broken bootloaders
-290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
-2D0/A00	ALL	e820_table	E820 memory map table
-				(array of struct e820_entry)
-D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
+				        (below)
+1EB/001	ALL     kbd_status		Numlock is enabled
+1EC/001	ALL     secure_boot		Secure boot is enabled in the firmware
+1EF/001	ALL	sentinel		Used to detect broken bootloaders
+290/040	ALL	edd_mbr_sig_buffer	EDD MBR signatures
+2D0/A00	ALL	e820_table		E820 memory map table
+					(array of struct e820_entry)
+D00/1EC	ALL	eddbuf			EDD data (array of struct edd_info)
+=======	=====	=======================	=======================================
-- 
2.20.1

