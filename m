Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04121871
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iYPmt/JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbfEXJ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:56:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390323AbfEXJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:56:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9rXCJ141596;
        Fri, 24 May 2019 09:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=4091RvQX40jExczBn2ASU3OkIZNPKuI845hI/ShV1zw=;
 b=iYPmt/JFIN0IezySNfMHJh4PC9H2x5st+ZVZsEDmoS/ooHoNqBuxwhPP4tW9FyRNo1YF
 hXGpqzDPILE2Wzpo1MjP4wjlj0dIhEQpfzBzs6mU2J4bd0bAmX3JpWyCC7uKfu/7vcip
 230MOE349EwpEs8VPyCGRMRqXT/gp9liLsqbk9+UrURsdaELlS4zNn4cy6LLEaM51bMr
 XLOcaNXkOE108GsotlzpaP32tGivA4pM2XO3+AKqveajtVSenbdQD8DcEgZkrGvUHjBR
 qZLl4/kbDugTq5aeMc/8SEOcY2Pt1Bl097JyqYjT0UuW/zGH57YXiaqHAS1GwLw7p+K0 VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2smsk5r25s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O9tcdr135014;
        Fri, 24 May 2019 09:56:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2smsgtsmvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 09:56:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4O9u2dF032506;
        Fri, 24 May 2019 09:56:04 GMT
Received: from tomti.i.net-space.pl (/10.175.163.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 09:56:02 +0000
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com
Subject: [PATCH RFC 1/2] x86/boot: Introduce the setup_header2
Date:   Fri, 24 May 2019 11:55:03 +0200
Message-Id: <20190524095504.12894-2-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190524095504.12894-1-daniel.kiper@oracle.com>
References: <20190524095504.12894-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to limited space left in the setup header it was decided to
introduce the setup_header2. Its role is to communicate Linux kernel
supported features to the boot loader. Starting from now this is the
primary way to communicate things to the boot loader.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
---
I know that setup_header2 is not the best name. There were some
alternatives proposed like setup_header_extra, setup_header_addendum,
setup_header_more, ext_setup_header, extended_setup_header, extended_header
and extended_setup. Sadly, I am not happy with any of them. So,
leaving setup_header2 as is but still looking for better name.
Probably shorter == better...
---
 Documentation/x86/boot.txt               | 49 ++++++++++++++++++++++++++++++++
 arch/x86/boot/Makefile                   |  2 +-
 arch/x86/boot/compressed/Makefile        |  4 +--
 arch/x86/boot/compressed/setup_header2.S | 12 ++++++++
 arch/x86/boot/header.S                   |  3 +-
 arch/x86/boot/tools/build.c              |  8 ++++++
 arch/x86/include/uapi/asm/bootparam.h    |  1 +
 7 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/setup_header2.S

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index f4c2a97bfdbd..ff10c6116662 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -61,6 +61,22 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
 		to struct boot_params for loading bzImage and ramdisk
 		above 4G in 64bit.
 
+Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
+		(x86/boot: Add ACPI RSDP address to setup_header)
+		DO NOT USE!!! ASSUME SAME AS 2.13.
+
+Protocol 2.15:	(Kernel 5.2) Added the setup_header2.
+
+Note: The protocol version number should be changed only if the setup header
+      is changed. There is no need to update the version number if boot_params
+      or setup_header2 are changed. Additionally, it is recommended to use
+      xloadflags (in this case the protocol version number should not be
+      updated either) or setup_header2 to communicate supported Linux kernel
+      features to the boot loader. Due to very limited space available in
+      the original setup header every update to it should be considered
+      with great care. Starting from the protocol 2.15 the primary way to
+      communicate things to the boot loader is the setup_header2.
+
 **** MEMORY LAYOUT
 
 The traditional memory map for the kernel loader, used for Image or
@@ -197,6 +213,7 @@ Offset	Proto	Name		Meaning
 0258/8	2.10+	pref_address	Preferred loading address
 0260/4	2.10+	init_size	Linear memory required during initialization
 0264/4	2.11+	handover_offset	Offset of handover entry point
+0268/4	2.15+	setup_header2_offset Offset of the setup_header2
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
@@ -744,6 +761,38 @@ Offset/size:	0x264/4
 
   See EFI HANDOVER PROTOCOL below for more details.
 
+Field name:	setup_header2_offset
+Type:		read
+Offset/size:	0x268/4
+Protocol:	2.15+
+
+  This field is the offset from the beginning of the kernel image to the
+  setup_header2. It is embedded in the Linux image in the uncompressed
+  protected mode region.
+
+
+**** THE SETUP_HEADER2
+
+Due to limited space left in the setup header it was decided to introduce
+the setup_header2. Its role is to communicate Linux kernel supported features
+to the boot loader. All fields of the setup_header2 are read only from the
+boot loader point of view. The setup_header2 is supported starting from the
+boot protocol version 2.15.
+
+
+**** DETAILS OF THE SETUP_HEADER2 FIELDS
+
+Field name:	header
+Offset/size:	0x0000/4
+
+  Contains the magic number "hDR2" (0x68445232).
+
+Field name:	size
+Offset/size:	0x0004/4
+
+  This field contains the size of the setup_header2 including setup_header2.header.
+  It should be used by the boot loader to detect supported fields in the setup_header2.
+
 
 **** THE IMAGE CHECKSUM
 
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5c246c..c11b57da90f6 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -87,7 +87,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|setup_header2\|input_data\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..c12ccc2bd923 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -72,8 +72,8 @@ $(obj)/../voffset.h: vmlinux FORCE
 
 $(obj)/misc.o: $(obj)/../voffset.h
 
-vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/head_$(BITS).o $(obj)/misc.o \
-	$(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
+vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/setup_header2.o $(obj)/head_$(BITS).o \
+	$(obj)/misc.o $(obj)/string.o $(obj)/cmdline.o $(obj)/error.o \
 	$(obj)/piggy.o $(obj)/cpuflags.o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
diff --git a/arch/x86/boot/compressed/setup_header2.S b/arch/x86/boot/compressed/setup_header2.S
new file mode 100644
index 000000000000..0b3963296825
--- /dev/null
+++ b/arch/x86/boot/compressed/setup_header2.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+	.section ".rodata.setup_header2", "a"
+
+	.global setup_header2
+
+setup_header2:
+        /* Header. */
+	.ascii	"hDR2"
+        /* Size. */
+	.long	setup_header2_end - setup_header2
+setup_header2_end:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..72387b1e359c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020d		# header version number (>= 0x0105)
+		.word	0x020f		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
@@ -557,6 +557,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
+setup_header2_offset:	.long 0			# Filled in by build.c
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a93d44e58f9c..7fc9425a0fc9 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -56,6 +56,7 @@ u8 buf[SETUP_SECT_MAX*512];
 unsigned long efi32_stub_entry;
 unsigned long efi64_stub_entry;
 unsigned long efi_pe_entry;
+unsigned long setup_header2;
 unsigned long startup_64;
 
 /*----------------------------------------------------------------------*/
@@ -289,6 +290,10 @@ static inline int reserve_pecoff_reloc_section(int c)
 }
 #endif /* CONFIG_EFI_STUB */
 
+static void setup_header2_offset_update(void)
+{
+	put_unaligned_le32(setup_header2, &buf[0x268]);
+}
 
 /*
  * Parse zoffset.h and find the entry points. We could just #include zoffset.h
@@ -321,6 +326,7 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_stub_entry);
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
+		PARSE_ZOFS(p, setup_header2);
 		PARSE_ZOFS(p, startup_64);
 
 		p = strchr(p, '\n');
@@ -410,6 +416,8 @@ int main(int argc, char ** argv)
 
 	efi_stub_entry_update();
 
+	setup_header2_offset_update();
+
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
 		die("Writing setup failed");
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137e9a..77b48c7a23b4 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -86,6 +86,7 @@ struct setup_header {
 	__u64	pref_address;
 	__u32	init_size;
 	__u32	handover_offset;
+	__u32	setup_header2_offset;
 } __attribute__((packed));
 
 struct sys_desc_table {
-- 
2.11.0

