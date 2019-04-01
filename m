Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA2020856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139301;
	bh=E7REIvV71T9zyMeMShHiXIs5pMMcR03H0oJNvkpI2ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F6KPG9+5ad4ZWfdZLDJvlG8Ql+RztR7vxksFvUfXF2pavZFCiFfBgMsB00M9GQ88v
	 O3LqY2+Ktkcyfd7A9HE4q48xbshFSaOBho5nMSN/GGB6Vh86eMLOr08ywkDh2eoN+e
	 8DjPJRRUcWFLFkyYsyfH3ORgkZfpq5elJ80pm9aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfDARVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbfDARVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639B5206C0;
        Mon,  1 Apr 2019 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139296;
        bh=E7REIvV71T9zyMeMShHiXIs5pMMcR03H0oJNvkpI2ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdv2jyf6o32cuEM77qfra1vbVRNq3coU65DaGOJunMPKqfzQYc3oe7RuGyYHh1usU
         bwvFA35BPnbA/hrHIZ0ZQFhU1d0RMqZeYR5UkILAKvbhPEafkd26iYP0PsKHxazSOH
         x2LCUKnO/LEuRzOfy4Ld8sC3CPZ3h6EZoZwgN9O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 033/107] powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
Date:   Mon,  1 Apr 2019 19:01:48 +0200
Message-Id: <20190401170048.707230518@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 179ab1cbf883575c3a585bcfc0f2160f1d22a149 upstream.

Add a config symbol to encode which platforms support the
barrier_nospec speculation barrier. Currently this is just Book3S 64
but we will add Book3E in a future patch.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Kconfig               |    7 ++++++-
 arch/powerpc/include/asm/barrier.h |    6 +++---
 arch/powerpc/include/asm/setup.h   |    2 +-
 arch/powerpc/kernel/Makefile       |    3 ++-
 arch/powerpc/kernel/module.c       |    4 +++-
 arch/powerpc/kernel/vmlinux.lds.S  |    4 +++-
 arch/powerpc/lib/feature-fixups.c  |    6 ++++--
 7 files changed, 22 insertions(+), 10 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,7 +164,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
@@ -236,6 +236,11 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 
+config PPC_BARRIER_NOSPEC
+    bool
+    default y
+    depends on PPC_BOOK3S_64
+
 config GENERIC_CSUM
 	def_bool n
 
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,7 +76,7 @@ do {									\
 	___p1;								\
 })
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
@@ -86,10 +86,10 @@ do {									\
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
+#else /* !CONFIG_PPC_BARRIER_NOSPEC */
 #define barrier_nospec_asm
 #define barrier_nospec()
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 #include <asm-generic/barrier.h>
 
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -56,7 +56,7 @@ void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 #else
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -45,9 +45,10 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BARRIER_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,13 +72,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+#endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
 	if (sect != NULL)
 		do_barrier_nospec_fixups_range(barrier_nospec_enabled,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
 	if (sect != NULL)
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,14 +153,16 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+#endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 	. = ALIGN(8);
 	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
 		__start___barrier_nospec_fixup = .;
 		*(__barrier_nospec_fixup)
 		__stop___barrier_nospec_fixup = .;
 	}
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 	EXCEPTION_TABLE(0)
 
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -304,6 +304,9 @@ void do_barrier_nospec_fixups_range(bool
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -313,8 +316,7 @@ void do_barrier_nospec_fixups(bool enabl
 
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {


