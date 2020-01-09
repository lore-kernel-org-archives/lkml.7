Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09935C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D692073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAIUJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:09:07 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45952 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgAIUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:09:06 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so3515661qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6r8xg2PuYSK+TINnEVJUzqCO5IEgqeTFuVgwXoFM/k=;
        b=XtF2I71kuPOPLhJAkUPO9u2uQoE1UasT9NtdxP+ICAgHLOZWLaoxcV0CK1kt48brTE
         TpGVocfYgxAouqjNzxwd9Bz03vnbqzoUKH0VOFFF0m5pxdwZX8PWLf8klBOAYqauboMK
         6eo/j8UIFWPSKRhr/opOlh03JZywOYuwTMdvgba2GmS1yo8vYuVTAs1P919XMX4hizy/
         5oTxj32reu8X6lljTJrXSgQ3sP85/4BvSXzKWJVGK5Dvv4I0mcc/2sKmNF9xtUiJVCau
         PPdqHxBDmw4Zz6p05C+y1un/QHYmVMqM3X2NByB2w4wGV8D76gbM0b8Op+dIme9DSP3x
         +xPQ==
X-Gm-Message-State: APjAAAXvBSfMc+eSkWjP3E1Aioa7nYgxBfOFc72teoliNG7rebseMDaq
        cOpcq2ZVCeEvndUH0yexTuU=
X-Google-Smtp-Source: APXvYqw5/XcgRrbzxq9lHogyXcUNlWAVgy+7sKUK8bzh5cJvi1OyjmqgYj7o70FBmYV9ZhBHYmx7ig==
X-Received: by 2002:ad4:44ee:: with SMTP id p14mr10199737qvt.114.1578600545982;
        Thu, 09 Jan 2020 12:09:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p126sm3552314qke.108.2020.01.09.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 12:09:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "H . J . Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] x86/boot/compressed: Detect data relocations at link time
Date:   Thu,  9 Jan 2020 15:09:04 -0500
Message-Id: <20200109200904.514349-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

98f78525371b ("x86/boot: Refuse to build with data relocations") checks
the .o files linked into compressed/vmlinux to see if any have a
*.rel.local section, which typically is created from a data relocation.

However, this check has some limitations:
- it doesn't check libstub, as that gets linked in as a .a file
- if the address of an external variable with default visibility is
  referenced, rather than static or hidden, the section doesn't have
  .local attached (i.e. it would be just .rel[a].data.rel for
  example)
- if the data is constant (eg const char * const table[] = { .. }) the
  section is .data.rel.ro[.local]

So it is dependent on how exactly the linker decides to name the
sections in various cases.

This patch modifies the linker script to capture all dynamic
relocations, except for those in .head.text and .text (which come from
head_{32,64}.o and are harmless), in .rel[a].bad and assert that those
sections are empty. This is still dependent on linker naming convention
of naming the final relocation sections as .rel[a]<section> but that
should be more stable than the intermediate ones created for object
files.

The last remaining data relocation, in head_64.o's gdt structure, is
also removed.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

---
This patch is based on
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
as of "efi/libstub/x86: use const attribute for efi_is_64bit()"
---
 arch/x86/boot/compressed/head_64.S     |  7 ++++---
 arch/x86/boot/compressed/vmlinux.lds.S | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8139b3..1838b59c6d6a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -121,8 +121,9 @@ SYM_FUNC_START(startup_32)
  */
 
 	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	addl	%ebp, gdt+2(%ebp)
-	lgdt	gdt(%ebp)
+	leal	gdt(%ebp), %eax
+	movl	%eax, 2(%eax)
+	lgdt	(%eax)
 
 	/* Enable PAE mode */
 	movl	%cr4, %eax
@@ -619,7 +620,7 @@ SYM_DATA_END(gdt64)
 	.balign	8
 SYM_DATA_START_LOCAL(gdt)
 	.word	gdt_end - gdt
-	.long	gdt
+	.long	0
 	.word	0
 	.quad	0x00cf9a000000ffff	/* __KERNEL32_CS */
 	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..1ba85b109ac0 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,4 +73,20 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	/* Discard text relocations */
+	/DISCARD/ : {
+		*(.rel.head.text .rel.text)
+		*(.rela.head.text .rela.text)
+	}
+
+	/* There should be no other relocations */
+	.rel.bad : {
+		*(.rel.*)
+	}
+	.rela.bad : {
+		*(.rela.*)
+	}
 }
+
+ASSERT (SIZEOF(.rel.bad) == 0 && SIZEOF(.rela.bad) == 0, "Compressed kernel has data relocations!");
-- 
2.24.1

