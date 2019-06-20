Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CF82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lqOo7E9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfFTKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:00:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfFTKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:00:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5K9wxGF906696
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 02:58:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5K9wxGF906696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024740;
        bh=4/7OlXkZ0rfaBo1SqBGSOaT9CO52lJhHdM5uB+Bhns4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lqOo7E9j8hlVtoc4JaXTQGELMxycs2I2n5puRgCHuTF8erRlOKqQrsckw18V2CV5l
         925Xy1et5EkRr3P9ssVy7MIieIlWHsBkXnrUPJG+93Kh3wlxUdqL/jFotz9mZHtqJB
         XX7mvZI7hLBhrA9diw4ENsK9jYqDH9TTipCWWNCX/4PbEz9y7M0vtekIik5VsEeq4j
         6LVUj/Cj/3/TWjvKpLnHE8oTZpKpNxz3CQo100rRd745SYgiVlOna7AbDWTOkaw3XQ
         2LxNZvhLJ6Wu2g9m8FF7M/5IChj1/+ZACWrk8PDKgZfoFYh6BWxMGO12KLzfXw5b8k
         L/wjPyOTlKs0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5K9wxoo906691;
        Thu, 20 Jun 2019 02:58:59 -0700
Date:   Thu, 20 Jun 2019 02:58:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Lendacky <tipbot@zytor.com>
Message-ID: <tip-e1bfa87399e372446454ecbaeba2800f0a385733@git.kernel.org>
Cc:     luto@kernel.org, lijiang@redhat.com, dave.hansen@intel.com,
        thomas.lendacky@amd.com, keescook@chromium.org, x86@kernel.org,
        peterz@infradead.org, mingo@redhat.com, brijesh.singh@amd.com,
        samitolvanen@google.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de, hpa@zytor.com,
        ndesaulniers@google.com, bp@suse.de, rafael@espindo.la,
        Thomas.Lendacky@amd.com, bhe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jroedel@suse.de, bp@suse.de,
          ndesaulniers@google.com, hpa@zytor.com, bhe@redhat.com,
          rafael@espindo.la, Thomas.Lendacky@amd.com, x86@kernel.org,
          keescook@chromium.org, peterz@infradead.org,
          dave.hansen@intel.com, lijiang@redhat.com, luto@kernel.org,
          thomas.lendacky@amd.com, samitolvanen@google.com,
          tglx@linutronix.de, mingo@kernel.org, mingo@redhat.com,
          brijesh.singh@amd.com
In-Reply-To: <3c483262eb4077b1654b2052bd14a8d011bffde3.1560969363.git.thomas.lendacky@amd.com>
References: <3c483262eb4077b1654b2052bd14a8d011bffde3.1560969363.git.thomas.lendacky@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/mm: Create a workarea in the kernel for SME
 early encryption
Git-Commit-ID: e1bfa87399e372446454ecbaeba2800f0a385733
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e1bfa87399e372446454ecbaeba2800f0a385733
Gitweb:     https://git.kernel.org/tip/e1bfa87399e372446454ecbaeba2800f0a385733
Author:     Thomas Lendacky <Thomas.Lendacky@amd.com>
AuthorDate: Wed, 19 Jun 2019 18:40:59 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 09:44:26 +0200

x86/mm: Create a workarea in the kernel for SME early encryption

In order for the kernel to be encrypted "in place" during boot, a workarea
outside of the kernel must be used. This SME workarea used during early
encryption of the kernel is situated on a 2MB boundary after the end of
the kernel text, data, etc. sections (_end).

This works well during initial boot of a compressed kernel because of
the relocation used for decompression of the kernel. But when performing
a kexec boot, there's a chance that the SME workarea may not be mapped
by the kexec pagetables or that some of the other data used by kexec
could exist in this range.

Create a section for SME in vmlinux.lds.S. Position it after "_end", which
is after "__end_of_kernel_reserve", so that the memory will be reclaimed
during boot and since this area is all zeroes, it compresses well. This
new section will be part of the kernel image, so kexec will account for it
in pagetable mappings and placement of data after the kernel.

Here's an example of a kernel size without and with the SME section:

	without:
		vmlinux:	36,501,616
		bzImage:	 6,497,344

		100000000-47f37ffff : System RAM
		  1e4000000-1e47677d4 : Kernel code	(0x7677d4)
		  1e47677d5-1e4e2e0bf : Kernel data	(0x6c68ea)
		  1e5074000-1e5372fff : Kernel bss	(0x2fefff)

	with:
		vmlinux:	44,419,408
		bzImage:	 6,503,136

		880000000-c7ff7ffff : System RAM
		  8cf000000-8cf7677d4 : Kernel code	(0x7677d4)
		  8cf7677d5-8cfe2e0bf : Kernel data	(0x6c68ea)
		  8d0074000-8d0372fff : Kernel bss	(0x2fefff)

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Lianbo Jiang <lijiang@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael Ávila de Espíndola" <rafael@espindo.la>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/3c483262eb4077b1654b2052bd14a8d011bffde3.1560969363.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/vmlinux.lds.S      | 25 +++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_identity.c | 22 ++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ca2252ca6ad7..147cd020516a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -387,6 +387,31 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Early scratch/workarea section: Lives outside of the kernel proper
+	 * (_text - _end).
+	 *
+	 * Resides after _end because even though the .brk section is after
+	 * __end_of_kernel_reserve, the .brk section is later reserved as a
+	 * part of the kernel. Since it is located after __end_of_kernel_reserve
+	 * it will be discarded and become part of the available memory. As
+	 * such, it can only be used by very early boot code and must not be
+	 * needed afterwards.
+	 *
+	 * Currently used by SME for performing in-place encryption of the
+	 * kernel during boot. Resides on a 2MB boundary to simplify the
+	 * pagetable setup used for SME in-place encryption.
+	 */
+	. = ALIGN(HPAGE_SIZE);
+	.init.scratch : AT(ADDR(.init.scratch) - LOAD_OFFSET) {
+		__init_scratch_begin = .;
+		*(.init.scratch)
+		. = ALIGN(HPAGE_SIZE);
+		__init_scratch_end = .;
+	}
+#endif
+
 	STABS_DEBUG
 	DWARF_DEBUG
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 4aa9b1480866..6a8dd483f7d9 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -73,6 +73,19 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+/*
+ * This work area lives in the .init.scratch section, which lives outside of
+ * the kernel proper. It is sized to hold the intermediate copy buffer and
+ * more than enough pagetable pages.
+ *
+ * By using this section, the kernel can be encrypted in place and it
+ * avoids any possibility of boot parameters or initramfs images being
+ * placed such that the in-place encryption logic overwrites them.  This
+ * section is 2MB aligned to allow for simple pagetable setup using only
+ * PMD entries (see vmlinux.lds.S).
+ */
+static char sme_workarea[2 * PMD_PAGE_SIZE] __section(.init.scratch);
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -314,8 +327,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/* Set the encryption workarea to be immediately after the kernel */
-	workarea_start = kernel_end;
+	/*
+	 * We're running identity mapped, so we must obtain the address to the
+	 * SME encryption workarea using rip-relative addressing.
+	 */
+	asm ("lea sme_workarea(%%rip), %0"
+	     : "=r" (workarea_start)
+	     : "p" (sme_workarea));
 
 	/*
 	 * Calculate required number of workarea bytes needed:
