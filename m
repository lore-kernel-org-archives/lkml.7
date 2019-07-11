Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB56C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4240320863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QuWLHoVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfGKTmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:42:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44896 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:42:30 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so15111813iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MI4SXHOymT8P6kYfmh+Hx3e+cJoJ4h+bDPlaBCRc/oM=;
        b=QuWLHoVCrWD3y/0qNjoNEA2upf7ky0hnfkeX9Ac1qgCCN+ZBPgeH0bKgbDTSwhv2PT
         X9z1+3zGVntknKfTqUFWf+Hd07MCYNvFJyfe+mgX2fyoWF3u5vBWxh4BlTQTtlBrmq5l
         UyY3ARWGphmEiEtwg3h7lwgMyQ3FvqfEv08Ud332qxWgBnW0K/QgbaO+SZ3f5nFlBHKb
         g9Vu0T9xbCkvCp4QdXCPXvS8vQTkuK8Gb8G2xsAHvfdsQ+nMJPjVIUpTXp6CR3BY8D4R
         ckGGxC3dPmQeTqxH8JPNMK10XY3WcjuZqX3NVpvHBUMwaNOhttMxNPLSZMZerqXV5Jz9
         sHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MI4SXHOymT8P6kYfmh+Hx3e+cJoJ4h+bDPlaBCRc/oM=;
        b=hYnJRJ//X8Lx/7XHYgftyQoHJ+2G9wx7AYu050h98v6ctPGXlGAvSWZeOFbmmCUAPs
         eHapkwbFUqNpgcOAsQL3oV2xcoyDCJuyUx3uTDEkzeE6oD4lvp08P6chEqWH932wVasE
         GtJ1svhgPCUlIekf7lacvwuGk0skoL8fhkW/sPML7DubO8vkGmEBoTQRyOqEm+6jwS1M
         OJHYxE1sOagdP4sxR3mq5fcTcL8u/evM1YujlJM8AYV+phc4bE+2Aupd1T3Hz1gBsgvd
         fLTjVMrsGSU4E/Ycj+p+ULBRckRQT/Hhb2q2pG4l/PmjfCJZ+YHFqZkNxyugMS32fdBH
         YESw==
X-Gm-Message-State: APjAAAVi6buhz34R0V8Wg0KxruKUYOR5YMBmjSHGcknfAIZLFrePgD66
        pJW9VBDoBK1M4gJAv4/XYaut5w==
X-Google-Smtp-Source: APXvYqyDvsY/AXHMOZ73B35scDK+tFyHuzlcUCFoHbVxI1bgQiG6SaWl4AkrszQZdiJyTz/K88ATmA==
X-Received: by 2002:a5d:9ec4:: with SMTP id a4mr6007973ioe.125.1562874147497;
        Thu, 11 Jul 2019 12:42:27 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id m20sm6806256ioh.4.2019.07.11.12.42.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 12:42:26 -0700 (PDT)
Date:   Thu, 11 Jul 2019 12:42:25 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>
cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "trini@konsulko.com" <trini@konsulko.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "merker@debian.org" <merker@debian.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4] RISC-V: Add an Image header that boot loader can
 parse.
In-Reply-To: <c0bdc25bc3aee9eee8bf9ebe561900b88df0540b.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907111237520.8586@viisi.sifive.com>
References: <20190606230800.19932-1-atish.patra@wdc.com>  <alpine.DEB.2.21.9999.1906281207290.3867@viisi.sifive.com> <c0bdc25bc3aee9eee8bf9ebe561900b88df0540b.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019, Atish Patra wrote:

> On Fri, 2019-06-28 at 12:09 -0700, Paul Walmsley wrote:
> > On Thu, 6 Jun 2019, Atish Patra wrote:
> > 
> > > Currently, the last stage boot loaders such as U-Boot can accept
> > > only
> > > uImage which is an unnecessary additional step in automating boot
> > > process.
> > > 
> > > Add an image header that boot loader understands and boot Linux
> > > from
> > > flat Image directly.
> > 
> > ...
> > 
> > 
> > > +#if __riscv_xlen == 64
> > > +	/* Image load offset(2MB) from start of RAM */
> > > +	.dword 0x200000
> > > +#else
> > > +	/* Image load offset(4MB) from start of RAM */
> > > +	.dword 0x400000
> > > +#endif
> > 
> > Is there a rationale behind these load offset values?
> > 
> 
> 2MB/4MB alignment requirement is mandatory for current RISC-V kernel.
> Anup had a patch that tried to remove that but not accepted yet.
> 
> https://patchwork.kernel.org/patch/10868465/

Thanks for doing this work; this should really help.  Patch queued with a 
few minor tweaks to the documentation file and to the comments.  (Updated 
patch below)

Not sure if this will make it for v5.3-rc1.  If not, we'll try to get it 
in as soon as possible afterwards.

Something else to think about: we'll probably want some flag bits soon to 
identify whether the kernel binary is a 32-bit, 64-bit, or 128-bit binary.  
If two bits are used, and 64-bit is defined as 00, then it should be 
backwards compatible.  I would hope that this could be something that we'd 
be able to coordinate with the ARM64 folks also; otherwise we may need to 
start using that res3 field.


- Paul

From: Atish Patra <atish.patra@wdc.com>
Date: Thu, 6 Jun 2019 16:08:00 -0700
Subject: [PATCH] RISC-V: Add an Image header that boot loader can parse.

Currently, the last stage boot loaders such as U-Boot can accept only
uImage which is an unnecessary additional step in automating boot
process.

Add an image header that boot loader understands and boot Linux from
flat Image directly.

This header is based on ARM64 boot image header and provides an
opportunity to combine both ARM64 & RISC-V image headers in future.

Also make sure that PE/COFF header can co-exist in the same image so
that EFI stub can be supported for RISC-V in future. EFI specification
needs PE/COFF image header in the beginning of the kernel image in order
to load it as an EFI application. In order to support EFI stub, code0
should be replaced with "MZ" magic string and res4(at offset 0x3c)
should point to the rest of the PE/COFF header (which will be added
during EFI support).

Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Karsten Merker <merker@debian.org>
Tested-by: Karsten Merker <merker@debian.org> (QEMU+OpenSBI+U-Boot)
Tested-by: Kevin Hilman <khilman@baylibre.com> (OpenSBI + U-Boot + Linux)
[paul.walmsley@sifive.com: fixed whitespace in boot-image-header.txt;
 converted structure comment to kernel-doc format and added some detail]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 Documentation/riscv/boot-image-header.txt | 50 +++++++++++++++++
 arch/riscv/include/asm/image.h            | 65 +++++++++++++++++++++++
 arch/riscv/kernel/head.S                  | 32 +++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 Documentation/riscv/boot-image-header.txt
 create mode 100644 arch/riscv/include/asm/image.h

diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
new file mode 100644
index 000000000000..1b73fea23b39
--- /dev/null
+++ b/Documentation/riscv/boot-image-header.txt
@@ -0,0 +1,50 @@
+				Boot image header in RISC-V Linux
+			=============================================
+
+Author: Atish Patra <atish.patra@wdc.com>
+Date  : 20 May 2019
+
+This document only describes the boot image header details for RISC-V Linux.
+The complete booting guide will be available at Documentation/riscv/booting.txt.
+
+The following 64-byte header is present in decompressed Linux kernel image.
+
+	u32 code0;		  /* Executable code */
+	u32 code1; 		  /* Executable code */
+	u64 text_offset;	  /* Image load offset, little endian */
+	u64 image_size;		  /* Effective Image size, little endian */
+	u64 flags;		  /* kernel flags, little endian */
+	u32 version;		  /* Version of this header */
+	u32 res1  = 0;		  /* Reserved */
+	u64 res2  = 0;    	  /* Reserved */
+	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
+	u32 res3;		  /* Reserved for additional RISC-V specific header */
+	u32 res4;		  /* Reserved for PE COFF offset */
+
+This header format is compliant with PE/COFF header and largely inspired from
+ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
+header in future.
+
+Notes:
+- This header can also be reused to support EFI stub for RISC-V in future. EFI
+  specification needs PE/COFF image header in the beginning of the kernel image
+  in order to load it as an EFI application. In order to support EFI stub,
+  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
+  point to the rest of the PE/COFF header.
+
+- version field indicate header version number.
+	Bits 0:15  - Minor version
+	Bits 16:31 - Major version
+
+  This preserves compatibility across newer and older version of the header.
+  The current version is defined as 0.1.
+
+- res3 is reserved for offset to any other additional fields. This makes the
+  header extendible in future. One example would be to accommodate ISA
+  extension for RISC-V in future. For current version, it is set to be zero.
+
+- In current header, the flag field has only one field.
+	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
+
+- Image size is mandatory for boot loader to load kernel image. Booting will
+  fail otherwise.
diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
new file mode 100644
index 000000000000..ef28e106f247
--- /dev/null
+++ b/arch/riscv/include/asm/image.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define RISCV_IMAGE_MAGIC	"RISCV"
+
+#define RISCV_IMAGE_FLAG_BE_SHIFT	0
+#define RISCV_IMAGE_FLAG_BE_MASK	0x1
+
+#define RISCV_IMAGE_FLAG_LE		0
+#define RISCV_IMAGE_FLAG_BE		1
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#error conversion of header fields to LE not yet implemented
+#else
+#define __HEAD_FLAG_BE		RISCV_IMAGE_FLAG_LE
+#endif
+
+#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
+				RISCV_IMAGE_FLAG_##field##_SHIFT)
+
+#define __HEAD_FLAGS		(__HEAD_FLAG(BE))
+
+#define RISCV_HEADER_VERSION_MAJOR 0
+#define RISCV_HEADER_VERSION_MINOR 1
+
+#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
+			      RISCV_HEADER_VERSION_MINOR)
+
+#ifndef __ASSEMBLY__
+/**
+ * struct riscv_image_header - riscv kernel image header
+ * @code0:		Executable code
+ * @code1:		Executable code
+ * @text_offset:	Image load offset (little endian)
+ * @image_size:		Effective Image size (little endian)
+ * @flags:		kernel flags (little endian)
+ * @version:		version
+ * @res1:		reserved
+ * @res2:		reserved
+ * @magic:		Magic number
+ * @res3:		reserved (will be used for additional RISC-V specific
+ *			header)
+ * @res4:		reserved (will be used for PE COFF offset)
+ *
+ * The intention is for this header format to be shared between multiple
+ * architectures to avoid a proliferation of image header formats.
+ */
+
+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	u64 text_offset;
+	u64 image_size;
+	u64 flags;
+	u32 version;
+	u32 res1;
+	u64 res2;
+	u64 magic;
+	u32 res3;
+	u32 res4;
+};
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index e368106f2228..0f1ba17e476f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -11,9 +11,41 @@
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/csr.h>
+#include <asm/image.h>
 
 __INIT
 ENTRY(_start)
+	/*
+	 * Image header expected by Linux boot-loaders. The image header data
+	 * structure is described in asm/image.h.
+	 * Do not modify it without modifying the structure and all bootloaders
+	 * that expects this header format!!
+	 */
+	/* jump to start kernel */
+	j _start_kernel
+	/* reserved */
+	.word 0
+	.balign 8
+#if __riscv_xlen == 64
+	/* Image load offset(2MB) from start of RAM */
+	.dword 0x200000
+#else
+	/* Image load offset(4MB) from start of RAM */
+	.dword 0x400000
+#endif
+	/* Effective size of kernel image */
+	.dword _end - _start
+	.dword __HEAD_FLAGS
+	.word RISCV_HEADER_VERSION
+	.word 0
+	.dword 0
+	.asciz RISCV_IMAGE_MAGIC
+	.word 0
+	.balign 4
+	.word 0
+
+.global _start_kernel
+_start_kernel:
 	/* Mask all interrupts */
 	csrw CSR_SIE, zero
 	csrw CSR_SIP, zero
-- 
2.20.1

