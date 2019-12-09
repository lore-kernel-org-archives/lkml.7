Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1178C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B572077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icsNm3j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLIXDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:03:22 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:38057 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfLIXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:03:21 -0500
Received: by mail-pj1-f74.google.com with SMTP id k93so8742298pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=W3soJVkX3chqUA4yexryiNdNdsd2zeyH2ACPivdWQA8=;
        b=icsNm3j6tS4DrwHUSrvkGKpTESpzPvJ21F8+b7+8VyQZIlooOA9DopmsKukKCtDh1L
         gWhNEmCuuXB6cvoF9kyyZUYQgJP/RZ+FmfXvXZjTcEA7q+syn79PWukJn4wTqyx/4hwl
         PFMKjibfUgLhCrmgl/XsSXgaUu0Rhf8IbwhY5oVzyCQNhNO2heAURtl24uC1v7bZt1Jm
         PvSYyPwmWrDKnI26TrIa5FrsQuEQqglS3nFbpvF86TPaBXztcohHNqfcZhnhJCK47wSR
         4DQ/fsCbncLuP1EoQRHhH0srUeMDn/iVxTNqXJEyszZWOrH2/RO1lzUW3AQUJIhLPMbj
         h3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=W3soJVkX3chqUA4yexryiNdNdsd2zeyH2ACPivdWQA8=;
        b=OXPTEeGZa6GD8zkQyWLdr1bXEFrRjqjC4waE7q3x0I7E89srORuv75bD3pPaWQGrC6
         JqqMmIjtI5OB2VzJBwd7f/lQtLIg/rSLbxnaeHcA5hJZ2/0l5uLRcsYPBO55pWfyVWZL
         oJzC5xL7guVglz039nFX5OeQLM2c0L4tNZUs5AyspchBP6C7VZ4ZCsYKzUdDyMblF1wG
         WYC36ZC4Zik/rh1nOgnVl2Lx97Wq+qDF3pefewOzn9ZdQ2lDSwHcaUNw4pDmPe64n7jN
         CApEf3KuZ4sqk7SLYwBqoa1gDdgr1Y0NUUDnn2YR+ByPKJIKZKYt1gtdbtpgBpob8lAV
         s7Yg==
X-Gm-Message-State: APjAAAWGpf79Z6e5wL7ZJudke0jYX4q4w7h+auOSgXXpVAtY3iD3aJCq
        bYZd8tOSs5ss+DSX6yWZI8v85ZfHxnYHl5pxpRsJVA==
X-Google-Smtp-Source: APXvYqzVTDS325/noPt/l65faddq5BSPhWvBoetxhq7lm3/LJ7lJuFMdzueIB5+pqewiDHaxVSYyVIiUeNpKdBk6i8PefQ==
X-Received: by 2002:a63:5718:: with SMTP id l24mr20858274pgb.136.1575932599919;
 Mon, 09 Dec 2019 15:03:19 -0800 (PST)
Date:   Mon,  9 Dec 2019 15:02:48 -0800
Message-Id: <20191209230248.227508-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_STATIC_LINK appears to have been broken since before v4.20. It
doesn't play nice with CONFIG_UML_NET_VECTOR=y:

/usr/bin/ld: arch/um/drivers/vector_user.o: in function
`user_init_socket_fds': vector_user.c:(.text+0x430): warning: Using
'getaddrinfo' in statically linked applications requires at runtime the
shared libraries from the glibc version used for linking

And it seems to break the ptrace check:

Checking that ptrace can change system call numbers...check_ptrace :
child exited with exitcode 6, while expecting 0; status 0x67f
[1]    126822 abort      ./linux mem=256M

(Apparently, a patch was recently discussed that fixes this - around
v5.5-rc1[1] - but the fact that this was broken for over a year
remains.)

According to Anton, PCAP throws even more warnings, and the resulting
binary isn't really even static anyway, so there is really no point in
keeping this config around[2].

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Link[1]: https://www.spinics.net/lists/stable/msg346933.html
Link[2]: https://lkml.org/lkml/2019/12/6/46
---
 arch/um/Kconfig              |  23 +----
 arch/um/Makefile             |   3 +-
 arch/um/kernel/dyn.lds.S     | 170 ----------------------------------
 arch/um/kernel/uml.lds.S     | 115 -----------------------
 arch/um/kernel/vmlinux.lds.S | 175 ++++++++++++++++++++++++++++++++++-
 5 files changed, 172 insertions(+), 314 deletions(-)
 delete mode 100644 arch/um/kernel/dyn.lds.S
 delete mode 100644 arch/um/kernel/uml.lds.S

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 2a6d04fcb3e91..00927fb7ce67a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -19,6 +19,7 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+	select MODULE_REL_CRCS if MODVERSIONS
 
 config MMU
 	bool
@@ -61,28 +62,6 @@ config NR_CPUS
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
-config STATIC_LINK
-	bool "Force a static link"
-	default n
-	help
-	  This option gives you the ability to force a static link of UML.
-	  Normally, UML is linked as a shared binary.  This is inconvenient for
-	  use in a chroot jail.  So, if you intend to run UML inside a chroot,
-	  you probably want to say Y here.
-	  Additionally, this option enables using higher memory spaces (up to
-	  2.75G) for UML.
-
-config LD_SCRIPT_STATIC
-	bool
-	default y
-	depends on STATIC_LINK
-
-config LD_SCRIPT_DYN
-	bool
-	default y
-	depends on !LD_SCRIPT_STATIC
-	select MODULE_REL_CRCS if MODVERSIONS
-
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index d2daa206872da..ec8af28daf051 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -117,8 +117,7 @@ archheaders:
 archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
-LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-y += -Wl,-rpath,/lib $(call cc-option, -no-pie)
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
deleted file mode 100644
index c69d69ee96beb..0000000000000
--- a/arch/um/kernel/dyn.lds.S
+++ /dev/null
@@ -1,170 +0,0 @@
-#include <asm/vmlinux.lds.h>
-#include <asm/page.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  PROVIDE (__executable_start = START);
-  . = START + SIZEOF_HEADERS;
-  .interp         : { *(.interp) }
-  __binary_start = .;
-  . = ALIGN(4096);		/* Init code and data */
-  _text = .;
-  INIT_TEXT_SECTION(PAGE_SIZE)
-
-  . = ALIGN(PAGE_SIZE);
-
-  /* Read-only sections, merged into text segment: */
-  .hash           : { *(.hash) }
-  .gnu.hash       : { *(.gnu.hash) }
-  .dynsym         : { *(.dynsym) }
-  .dynstr         : { *(.dynstr) }
-  .gnu.version    : { *(.gnu.version) }
-  .gnu.version_d  : { *(.gnu.version_d) }
-  .gnu.version_r  : { *(.gnu.version_r) }
-  .rel.init       : { *(.rel.init) }
-  .rela.init      : { *(.rela.init) }
-  .rel.text       : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
-  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
-  .rel.fini       : { *(.rel.fini) }
-  .rela.fini      : { *(.rela.fini) }
-  .rel.rodata     : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
-  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
-  .rel.data       : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
-  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
-  .rel.tdata	  : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
-  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
-  .rel.tbss	  : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
-  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
-  .rel.ctors      : { *(.rel.ctors) }
-  .rela.ctors     : { *(.rela.ctors) }
-  .rel.dtors      : { *(.rel.dtors) }
-  .rela.dtors     : { *(.rela.dtors) }
-  .rel.got        : { *(.rel.got) }
-  .rela.got       : { *(.rela.got) }
-  .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
-  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
-  .rel.plt : {
-	*(.rel.plt)
-	PROVIDE_HIDDEN(__rel_iplt_start = .);
-	*(.rel.iplt)
-	PROVIDE_HIDDEN(__rel_iplt_end = .);
-  }
-  .rela.plt : {
-	*(.rela.plt)
-	PROVIDE_HIDDEN(__rela_iplt_start = .);
-	*(.rela.iplt)
-	PROVIDE_HIDDEN(__rela_iplt_end = .);
-  }
-  .init           : {
-    KEEP (*(.init))
-  } =0x90909090
-  .plt            : { *(.plt) }
-  .text           : {
-    _stext = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    CPUIDLE_TEXT
-    LOCK_TEXT
-    IRQENTRY_TEXT
-    SOFTIRQENTRY_TEXT
-    *(.fixup)
-    *(.stub .text.* .gnu.linkonce.t.*)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-
-    . = ALIGN(PAGE_SIZE);
-  } =0x90909090
-  . = ALIGN(PAGE_SIZE);
-  .syscall_stub : {
-	__syscall_stub_start = .;
-	*(.__syscall_stub*)
-	__syscall_stub_end = .;
-  }
-  .fini           : {
-    KEEP (*(.fini))
-  } =0x90909090
-
-  .kstrtab : { *(.kstrtab) }
-
-  #include <asm/common.lds.S>
-
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
-  /* Ensure the __preinit_array_start label is properly aligned.  We
-     could instead move the label definition inside the section, but
-     the linker would then create the section even if it turns out to
-     be empty, which isn't pretty.  */
-  . = ALIGN(32 / 8);
-  .preinit_array     : { *(.preinit_array) }
-  .fini_array     : { *(.fini_array) }
-  .data           : {
-    INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
-    DATA_DATA
-    *(.data.* .gnu.linkonce.d.*)
-    SORT(CONSTRUCTORS)
-  }
-  .data1          : { *(.data1) }
-  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
-  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-  .eh_frame       : { KEEP (*(.eh_frame)) }
-  .gcc_except_table   : { *(.gcc_except_table) }
-  .dynamic        : { *(.dynamic) }
-  .ctors          : {
-    /* gcc uses crtbegin.o to find the start of
-       the constructors, so we make sure it is
-       first.  Because this is a wildcard, it
-       doesn't matter if the user does not
-       actually link against crtbegin.o; the
-       linker won't look for a file to match a
-       wildcard.  The wildcard also means that it
-       doesn't matter which directory crtbegin.o
-       is in.  */
-    KEEP (*crtbegin.o(.ctors))
-    /* We don't want to include the .ctor section from
-       from the crtend.o file until after the sorted ctors.
-       The .ctor section from the crtend file contains the
-       end of ctors marker and it must be last */
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
-    KEEP (*(SORT(.ctors.*)))
-    KEEP (*(.ctors))
-  }
-  .dtors          : {
-    KEEP (*crtbegin.o(.dtors))
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
-    KEEP (*(SORT(.dtors.*)))
-    KEEP (*(.dtors))
-  }
-  .jcr            : { KEEP (*(.jcr)) }
-  .got            : { *(.got.plt) *(.got) }
-  _edata = .;
-  PROVIDE (edata = .);
-  .bss            : {
-   __bss_start = .;
-   *(.dynbss)
-   *(.bss .bss.* .gnu.linkonce.b.*)
-   *(COMMON)
-   /* Align here to ensure that the .bss section occupies space up to
-      _end.  Align after .bss to ensure correct alignment even if the
-      .bss section disappears because there are no input sections.  */
-   . = ALIGN(32 / 8);
-  . = ALIGN(32 / 8);
-  }
-   __bss_stop = .;
-  _end = .;
-  PROVIDE (end = .);
-
-  STABS_DEBUG
-
-  DWARF_DEBUG
-
-  DISCARDS
-}
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
deleted file mode 100644
index 9f21443be2c9e..0000000000000
--- a/arch/um/kernel/uml.lds.S
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/vmlinux.lds.h>
-#include <asm/page.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  /* This must contain the right address - not quite the default ELF one.*/
-  PROVIDE (__executable_start = START);
-  /* Static binaries stick stuff here, like the sigreturn trampoline,
-   * invisibly to objdump.  So, just make __binary_start equal to the very
-   * beginning of the executable, and if there are unmapped pages after this,
-   * they are forever unusable.
-   */
-  __binary_start = START;
-
-  . = START + SIZEOF_HEADERS;
-
-  _text = .;
-  INIT_TEXT_SECTION(0)
-  . = ALIGN(PAGE_SIZE);
-
-  .text      :
-  {
-    _stext = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    CPUIDLE_TEXT
-    LOCK_TEXT
-    IRQENTRY_TEXT
-    SOFTIRQENTRY_TEXT
-    *(.fixup)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-    *(.gnu.linkonce.t*)
-  }
-
-  . = ALIGN(PAGE_SIZE);
-  .syscall_stub : {
-	__syscall_stub_start = .;
-	*(.__syscall_stub*)
-	__syscall_stub_end = .;
-  }
-
-  /*
-   * These are needed even in a static link, even if they wind up being empty.
-   * Newer glibc needs these __rel{,a}_iplt_{start,end} symbols.
-   */
-  .rel.plt : {
-	*(.rel.plt)
-	PROVIDE_HIDDEN(__rel_iplt_start = .);
-	*(.rel.iplt)
-	PROVIDE_HIDDEN(__rel_iplt_end = .);
-  }
-  .rela.plt : {
-	*(.rela.plt)
-	PROVIDE_HIDDEN(__rela_iplt_start = .);
-	*(.rela.iplt)
-	PROVIDE_HIDDEN(__rela_iplt_end = .);
-  }
-
-  #include <asm/common.lds.S>
-
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
-  .data    :
-  {
-    INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
-    DATA_DATA
-    *(.gnu.linkonce.d*)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  .ctors         :
-  {
-    *(.ctors)
-  }
-  .dtors         :
-  {
-    *(.dtors)
-  }
-
-  .got           : { *(.got.plt) *(.got) }
-  .dynamic       : { *(.dynamic) }
-  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
-  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  . = ALIGN(PAGE_SIZE);
-  __bss_start = .;
-  PROVIDE(_bss_start = .);
-  SBSS(0)
-  BSS(0)
-   __bss_stop = .;
-  _end = .;
-  PROVIDE (end = .);
-
-  STABS_DEBUG
-
-  DWARF_DEBUG
-
-  DISCARDS
-}
diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 16e49bfa2b426..f4b6114e54d62 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,8 +1,173 @@
 
 KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
 
-#ifdef CONFIG_LD_SCRIPT_STATIC
-#include "uml.lds.S"
-#else
-#include "dyn.lds.S"
-#endif
+#include <asm/vmlinux.lds.h>
+#include <asm/page.h>
+
+OUTPUT_FORMAT(ELF_FORMAT)
+OUTPUT_ARCH(ELF_ARCH)
+ENTRY(_start)
+jiffies = jiffies_64;
+
+SECTIONS
+{
+  PROVIDE (__executable_start = START);
+  . = START + SIZEOF_HEADERS;
+  .interp         : { *(.interp) }
+  __binary_start = .;
+  . = ALIGN(4096);		/* Init code and data */
+  _text = .;
+  INIT_TEXT_SECTION(PAGE_SIZE)
+
+  . = ALIGN(PAGE_SIZE);
+
+  /* Read-only sections, merged into text segment: */
+  .hash           : { *(.hash) }
+  .gnu.hash       : { *(.gnu.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+  .rel.init       : { *(.rel.init) }
+  .rela.init      : { *(.rela.init) }
+  .rel.text       : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
+  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
+  .rel.fini       : { *(.rel.fini) }
+  .rela.fini      : { *(.rela.fini) }
+  .rel.rodata     : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
+  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
+  .rel.data       : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
+  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
+  .rel.tdata	  : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
+  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
+  .rel.tbss	  : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
+  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
+  .rel.ctors      : { *(.rel.ctors) }
+  .rela.ctors     : { *(.rela.ctors) }
+  .rel.dtors      : { *(.rel.dtors) }
+  .rela.dtors     : { *(.rela.dtors) }
+  .rel.got        : { *(.rel.got) }
+  .rela.got       : { *(.rela.got) }
+  .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
+  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
+  .rel.plt : {
+	*(.rel.plt)
+	PROVIDE_HIDDEN(__rel_iplt_start = .);
+	*(.rel.iplt)
+	PROVIDE_HIDDEN(__rel_iplt_end = .);
+  }
+  .rela.plt : {
+	*(.rela.plt)
+	PROVIDE_HIDDEN(__rela_iplt_start = .);
+	*(.rela.iplt)
+	PROVIDE_HIDDEN(__rela_iplt_end = .);
+  }
+  .init           : {
+    KEEP (*(.init))
+  } =0x90909090
+  .plt            : { *(.plt) }
+  .text           : {
+    _stext = .;
+    TEXT_TEXT
+    SCHED_TEXT
+    CPUIDLE_TEXT
+    LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
+    *(.fixup)
+    *(.stub .text.* .gnu.linkonce.t.*)
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+
+    . = ALIGN(PAGE_SIZE);
+  } =0x90909090
+  . = ALIGN(PAGE_SIZE);
+  .syscall_stub : {
+	__syscall_stub_start = .;
+	*(.__syscall_stub*)
+	__syscall_stub_end = .;
+  }
+  .fini           : {
+    KEEP (*(.fini))
+  } =0x90909090
+
+  .kstrtab : { *(.kstrtab) }
+
+  #include <asm/common.lds.S>
+
+  __init_begin = .;
+  init.data : { INIT_DATA }
+  __init_end = .;
+
+  /* Ensure the __preinit_array_start label is properly aligned.  We
+     could instead move the label definition inside the section, but
+     the linker would then create the section even if it turns out to
+     be empty, which isn't pretty.  */
+  . = ALIGN(32 / 8);
+  .preinit_array     : { *(.preinit_array) }
+  .fini_array     : { *(.fini_array) }
+  .data           : {
+    INIT_TASK_DATA(KERNEL_STACK_SIZE)
+    . = ALIGN(KERNEL_STACK_SIZE);
+    *(.data..init_irqstack)
+    DATA_DATA
+    *(.data.* .gnu.linkonce.d.*)
+    SORT(CONSTRUCTORS)
+  }
+  .data1          : { *(.data1) }
+  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
+  .gcc_except_table   : { *(.gcc_except_table) }
+  .dynamic        : { *(.dynamic) }
+  .ctors          : {
+    /* gcc uses crtbegin.o to find the start of
+       the constructors, so we make sure it is
+       first.  Because this is a wildcard, it
+       doesn't matter if the user does not
+       actually link against crtbegin.o; the
+       linker won't look for a file to match a
+       wildcard.  The wildcard also means that it
+       doesn't matter which directory crtbegin.o
+       is in.  */
+    KEEP (*crtbegin.o(.ctors))
+    /* We don't want to include the .ctor section from
+       from the crtend.o file until after the sorted ctors.
+       The .ctor section from the crtend file contains the
+       end of ctors marker and it must be last */
+    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
+    KEEP (*(SORT(.ctors.*)))
+    KEEP (*(.ctors))
+  }
+  .dtors          : {
+    KEEP (*crtbegin.o(.dtors))
+    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
+    KEEP (*(SORT(.dtors.*)))
+    KEEP (*(.dtors))
+  }
+  .jcr            : { KEEP (*(.jcr)) }
+  .got            : { *(.got.plt) *(.got) }
+  _edata = .;
+  PROVIDE (edata = .);
+  .bss            : {
+   __bss_start = .;
+   *(.dynbss)
+   *(.bss .bss.* .gnu.linkonce.b.*)
+   *(COMMON)
+   /* Align here to ensure that the .bss section occupies space up to
+      _end.  Align after .bss to ensure correct alignment even if the
+      .bss section disappears because there are no input sections.  */
+   . = ALIGN(32 / 8);
+  . = ALIGN(32 / 8);
+  }
+   __bss_stop = .;
+  _end = .;
+  PROVIDE (end = .);
+
+  STABS_DEBUG
+
+  DWARF_DEBUG
+
+  DISCARDS
+}
-- 
2.24.0.393.g34dc348eaf-goog

