Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B720896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU/1jRU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDAKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:24:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:24:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so11253812wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hZZJ8ds+4AAeARbwpP8OE7+gRCeDpclgBqkjuPlxyk=;
        b=KU/1jRU04dJG844nExFpk9oKVKuskKwc5hSkoOsuVlhwtrNPwLiVtG0fabwT4c5WKo
         Y6tU+1Tonc886FPzpSsvohRdycs3mBirkK/9sOtzr5MW9YqxUlp2uW+hWzz58q8VmeZn
         aztStfKHowkII0n5UupRMqIH1uLP0BUWbVWjdrnLjLq2WCFRyvrb5GSuDOdmxrQro3jl
         s3/peSLOQF+v3+pR5LzaEZA3D77zqE7QoFwFoCh1dmSjd/TsiOCi7qRbGm+8ysHOVeUh
         Dl4PoGZW9+xKwpRHbLCWCnR7b7TlkUIrupXt3vZwE7BXWwn59RH52tiSN6iyfJJzfCdV
         1Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hZZJ8ds+4AAeARbwpP8OE7+gRCeDpclgBqkjuPlxyk=;
        b=XsYgDQ4/s3+LTZXf8DGbH5IR+RUmimVjBKRBuT2Q6OvojceWHiGycD7d5hCSKkNh8r
         WgD9QsVFIGkjZp8WCKeqaRgdr7q4rxYUHIAGyj1BRbXuPrR5ALwcTjvaotfpzwIEKWUY
         ZXXK4UqrNQuPT/fnQC8YCIak2SyEf8VO4w0VcaSJOjYcz/2FeRMGO1APAzC2b8fhwAfC
         eEOZWbeGp2N3uDD3O65ssEu+F8JjgY3iLqOIq51TZLpZTG65I9hKYreK3hJToqKTmHOn
         Z8+tTC9nhKwvv/ZVbGY2QxFgNpWMg7bmD0E4fs1k8cRm0QDwJJkf5qFqtxlQVUhQJWls
         qZ9w==
X-Gm-Message-State: APjAAAWEKUSs48iegKsOmtFk77BUAxSwmA57NDy2X8+IFzOqccofDWTL
        Vxxs/ZS5z/qFt9B16Sw7D/JpChgl
X-Google-Smtp-Source: APXvYqx09KgPaFDPnHPff+U162w/ib4bndjf9/pH258qDZ9NLXwtIrOHeUzRo5fIg9NU8wOBhg6/oA==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr40549337wrm.300.1554114286352;
        Mon, 01 Apr 2019 03:24:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:718:1e03:a01::1ca])
        by smtp.gmail.com with ESMTPSA id h10sm16123322wrs.27.2019.04.01.03.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 03:24:45 -0700 (PDT)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot: This program cannot be run in DOS mode.$
Date:   Mon,  1 Apr 2019 12:24:34 +0200
Message-Id: <20190401102434.9805-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every EFI binary is in PE format. And we know that PE format needs to have
MZ MS-DOS header as there is written offset to PE header.

Therefore generated bzImage binary with CONFIG_EFI_STUB option is MS-DOS
executable binary.

We already know the "requirement" that Windows PE executable started in
MS-DOS must print legendary and famous message to computer screen:
"This program cannot be run in DOS mode."

But trying to run that bzImage of Linux kernel with MZ header just cause
freezing whole MS-DOS instead of writing "the correct message" to user.
This is not the compliant behavior of PE executables!

This patch fixes this problem. When Linux kernel compiled with
CONFIG_EFI_STUB is started in MS-DOS then it prints message:

  This program cannot be run in DOS mode.
  To load Linux kernel from DOS mode use LOADLIN.EXE.

So it also helps MS-DOS users how to "correctly" start this bzImage binary
by mentioning LOADLIN.EXE. Note that MS-DOS strings are not null-terminated
but rather dollar-terminated.

To have error message unified bugger_off_msg for BIOS boot block code was
changed to:

  This program cannot be run in BIOS mode.

So if you copy generated bzImage directly to boot sector and try to boot it
by BIOS you get this new updated message.

Due to fixed offset of setup header (0x1f1), PE header was moved after
entrytext section. bstext and bsdata sections where is full MZ header and
MS-DOS code is now bigger.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 arch/x86/boot/header.S | 55 +++++++++++++++++++++++++++++++++++++++++++-------
 arch/x86/boot/setup.ld |  1 +
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..58fcab7d00c8 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -45,6 +45,46 @@ bootsect_start:
 	# "MZ", MS-DOS header
 	.byte 0x4d
 	.byte 0x5a
+
+	# Explicitly enter this as bytes, or the assembler
+	# tries to generate a 3-byte jump here, which causes
+	# everything else to push off to the wrong offset.
+	.byte	0xeb    # short (2-byte) jump
+	.byte	bios_start-1f
+1:
+
+	.org	0x04
+	.short	3       # e_cp - Pages in file
+	.short	0       # e_crlc - Relocations
+	.short	4       # e_cparhdr - Size of header in paragraphs
+	.short	0       # e_minalloc - Minimum extra paragraphs needed
+	.short	0xffff  # e_maxalloc - Maximum extra paragraphs needed
+	.short	0       # e_ss - Initial (relative) SS value
+	.short	0       # e_sp - Initial SP value
+	.short	0       # e_csum - Checksum
+	.short	0       # e_ip - Initial IP value
+	.short	-4      # e_cs - Initial (relative) CS value
+	.short	0x40    # e_lfarlc - File address of relocation table
+
+	.org	0x3c
+	.long	pe_header  # Offset to the PE header
+
+	#
+	# MS-DOS start code
+	#
+	push	%cs
+	pop	%ds
+
+	# Write msdos_msg string
+	mov	$msdos_msg, %dx
+	mov	$0x09, %ah
+	int	$0x21
+
+	# Terminate program
+	mov	$0x4c01, %ax
+	int	$0x21
+
+bios_start:
 #endif
 
 	# Normalize the start address
@@ -80,22 +120,23 @@ bs_die:
 	# invoke the BIOS reset code...
 	ljmp	$0xf000,$0xfff0
 
+	.section ".bsdata", "a"
 #ifdef CONFIG_EFI_STUB
-	.org	0x3c
-	#
-	# Offset to the PE header.
-	#
-	.long	pe_header
+msdos_msg:
+	.ascii	"This program cannot be run in DOS mode.\r\n"
+	.ascii	"To load Linux kernel from DOS mode use LOADLIN.EXE.\r\r\n"
+	.ascii	"$"
 #endif /* CONFIG_EFI_STUB */
 
-	.section ".bsdata", "a"
 bugger_off_msg:
-	.ascii	"Use a boot loader.\r\n"
+	.ascii	"This program cannot be run in BIOS mode.\r\n"
+	.ascii	"To load Linux kernel from BIOS mode use a boot loader.\r\n"
 	.ascii	"\n"
 	.ascii	"Remove disk and press any key to reboot...\r\n"
 	.byte	0
 
 #ifdef CONFIG_EFI_STUB
+	.section ".pedata", "a"
 pe_header:
 	.ascii	"PE"
 	.word 	0
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 0149e41d42c2..c0ec2fe09d2d 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -16,6 +16,7 @@ SECTIONS
 	. = 495;
 	.header		: { *(.header) }
 	.entrytext	: { *(.entrytext) }
+	.pedata		: { *(.pedata) }
 	.inittext	: { *(.inittext) }
 	.initdata	: { *(.initdata) }
 	__end_init = .;
-- 
2.11.0

