Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3E02171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfCLRfl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:35:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42805 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfCLRfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:35:36 -0400
Received: from wld62.hos.anvin.org (c-73-231-201-241.hsd1.ca.comcast.net [73.231.201.241])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2CHZ3WV307183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Mar 2019 10:35:13 -0700
Date:   Tue, 12 Mar 2019 10:34:54 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190311150423.15979-2-ross.philipson@oracle.com>
References: <20190311150423.15979-1-ross.philipson@oracle.com> <20190311150423.15979-2-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/1] x86: Secure Launch boot protocol
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
CC:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        corbet@lwn.net, konrad.wilk@oracle.com, kanth.ghatraju@oracle.com,
        daniel.kiper@oracle.com, boris.ostrovsky@oracle.com,
        dpsmith@apertussolutions.com, ross.philipson@oracle.com
From:   hpa@zytor.com
Message-ID: <018B6986-0C7F-4C76-88ED-1548BC77E5AA@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2019 8:04:23 AM PDT, Ross Philipson <ross.philipson@oracle.com> wrote:
>The open source project called Trenchboot aims to make Linux directly
>bootable
>into a secure late launch environment via Intel TXT or AMD SKINIT.
>Though the
>project name is Trenchboot, this new feature is referred to as Secure
>Launch.
>In this scheme, the entire Linux image becomes the Measured Launch
>Environment
>(MLE). This term comes from the Intel TXT specification and means the
>image
>whose measurement is rooted in the TXT hardware. AMD's SKINIT does
>something
>similar with the same end result. For TXT, see the "Intel Trusted
>Execution
>Technology" specification. For SKINIT, see the "AMD64 Architecture
>Programmer’s Manual Volume 2: System Programming", section 15.27.
>
>The boot protocol extension introduces a new Linux boot parameter in
>the
>setup_header to convey the offset of the MLE header within the
>compressed kernel
>image (NOTE the MLE header is in the uncompressed protected mode entry
>portion).
>This header is used to initiate the entire secure late launch process.
>The
>header offset is written using the same method that is used to setup
>the
>handover_offset of the EFI handover protocol.
>
>Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
>---
> Documentation/x86/boot.txt            | 15 +++++++++++++++
> arch/x86/Kconfig                      |  7 +++++++
> arch/x86/boot/Makefile                |  2 +-
> arch/x86/boot/header.S                |  3 ++-
> arch/x86/boot/tools/build.c           | 16 ++++++++++++++++
> arch/x86/include/uapi/asm/bootparam.h |  1 +
> 6 files changed, 42 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
>index f4c2a97bfdbd..958acd71815f 100644
>--- a/Documentation/x86/boot.txt
>+++ b/Documentation/x86/boot.txt
>@@ -61,6 +61,9 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags
>field and extension fields
> 		to struct boot_params for loading bzImage and ramdisk
> 		above 4G in 64bit.
> 
>+Protocol 2.14:	(Kernel 5.1) Added a field for offset of measured
>launch
>+		environment (MLE) header.
>+
> **** MEMORY LAYOUT
> 
> The traditional memory map for the kernel loader, used for Image or
>@@ -197,6 +200,7 @@ Offset	Proto	Name		Meaning
> 0258/8	2.10+	pref_address	Preferred loading address
> 0260/4	2.10+	init_size	Linear memory required during initialization
> 0264/4	2.11+	handover_offset	Offset of handover entry point
>+0268/4	2.14+	mle_header_offset Offset of measured launch environement
>header
> 
>(1) For backwards compatibility, if the setup_sects field contains 0,
>the
>     real value is 4.
>@@ -744,6 +748,17 @@ Offset/size:	0x264/4
> 
>   See EFI HANDOVER PROTOCOL below for more details.
> 
>+Field name:	mle_header_offset
>+Type:		read
>+Offset/size:	0x268/4
>+
>+  This field is the offset from the beginning of the kernel image to
>+  the measured launch environment header structure. Boot loaders
>launching
>+  a kernel using Intel TXT or AMD SKINT secure late launch features
>use
>+  this header to set up the launch environment. It is called
>mle_header
>+  and is embedded in the Linux image in the uncompressed protected
>mode
>+  entry region.
>+
> 
> **** THE IMAGE CHECKSUM
> 
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 68261430fe6e..508f1cc6795f 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1965,6 +1965,13 @@ config EFI_MIXED
> 
> 	   If unsure, say N.
> 
>+config SECURE_LAUNCH_STUB
>+       bool "Secure Launch stub support"
>+       depends on X86_64
>+       ---help---
>+         This kernel feature allows a bzImage to be loaded directly
>+         through Intel TXT or AMD SKINIT measured launch.
>+
> config SECCOMP
> 	def_bool y
> 	prompt "Enable seccomp to safely compute untrusted bytecode"
>diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>index 9b5adae9cc40..03c989bb36ab 100644
>--- a/arch/x86/boot/Makefile
>+++ b/arch/x86/boot/Makefile
>@@ -87,7 +87,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
> 
> SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
> 
>-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
>\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define
>ZO_\2 0x\1/p'
>+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
>\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|mle_header\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define
>ZO_\2 0x\1/p'
> 
> quiet_cmd_zoffset = ZOFFSET $@
>       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
>diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>index 850b8762e889..9f8f8c1db11a 100644
>--- a/arch/x86/boot/header.S
>+++ b/arch/x86/boot/header.S
>@@ -300,7 +300,7 @@ _start:
> 	# Part 2 of the header, from the old setup.S
> 
> 		.ascii	"HdrS"		# header signature
>-		.word	0x020d		# header version number (>= 0x0105)
>+		.word	0x020e		# header version number (>= 0x0105)
> 					# or else old loadlin-1.5 will fail)
> 		.globl realmode_swtch
> realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
>@@ -557,6 +557,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred
>load addr
> 
> init_size:		.long INIT_SIZE		# kernel initialization size
> handover_offset:	.long 0			# Filled in by build.c
>+mle_header_offset:	.long 0			# Filled in by build.c
> 
># End of setup header
>#####################################################
> 
>diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
>index a93d44e58f9c..0dd6f1ffc66d 100644
>--- a/arch/x86/boot/tools/build.c
>+++ b/arch/x86/boot/tools/build.c
>@@ -56,6 +56,7 @@ u8 buf[SETUP_SECT_MAX*512];
> unsigned long efi32_stub_entry;
> unsigned long efi64_stub_entry;
> unsigned long efi_pe_entry;
>+unsigned long mle_header;
> unsigned long startup_64;
> 
>/*----------------------------------------------------------------------*/
>@@ -289,6 +290,18 @@ static inline int reserve_pecoff_reloc_section(int
>c)
> }
> #endif /* CONFIG_EFI_STUB */
> 
>+#ifdef CONFIG_SECURE_LAUNCH_STUB
>+
>+static void slaunch_stub_entry_update(void)
>+{
>+	put_unaligned_le32(mle_header, &buf[0x268]);
>+}
>+
>+#else
>+
>+static void slaunch_stub_entry_update(void) {}
>+
>+#endif /* CONFIG_SECURE_LAUNCH_STUB */
> 
> /*
>* Parse zoffset.h and find the entry points. We could just #include
>zoffset.h
>@@ -321,6 +334,7 @@ static void parse_zoffset(char *fname)
> 		PARSE_ZOFS(p, efi32_stub_entry);
> 		PARSE_ZOFS(p, efi64_stub_entry);
> 		PARSE_ZOFS(p, efi_pe_entry);
>+		PARSE_ZOFS(p, mle_header);
> 		PARSE_ZOFS(p, startup_64);
> 
> 		p = strchr(p, '\n');
>@@ -410,6 +424,8 @@ int main(int argc, char ** argv)
> 
> 	efi_stub_entry_update();
> 
>+	slaunch_stub_entry_update();
>+
> 	crc = partial_crc32(buf, i, crc);
> 	if (fwrite(buf, 1, i, dest) != i)
> 		die("Writing setup failed");
>diff --git a/arch/x86/include/uapi/asm/bootparam.h
>b/arch/x86/include/uapi/asm/bootparam.h
>index 60733f137e9a..92cd63c99c9e 100644
>--- a/arch/x86/include/uapi/asm/bootparam.h
>+++ b/arch/x86/include/uapi/asm/bootparam.h
>@@ -86,6 +86,7 @@ struct setup_header {
> 	__u64	pref_address;
> 	__u32	init_size;
> 	__u32	handover_offset;
>+	__u32	mle_header_offset;
> } __attribute__((packed));
> 
> struct sys_desc_table {

Double NAK – I'm in a meeting right now but with clarify shortly.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
