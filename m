Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83942C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329372087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRSkWPKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfD0GnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35748 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0GnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so2760176pfh.2;
        Fri, 26 Apr 2019 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uQh+p4niM1XazCyX0W8SClLNopGSLFeOTKZKD97XRE=;
        b=jRSkWPKFy+aX307nFA9nwPtBSyUtI3Rx2wzXkDoawmNR9EBxnEgbgOuHqpJlUzURZT
         sV7k69m+oa16kaqF4hrYU8VlNGgLedRPtIQMrWtFfI1lYATZNKlBhFfYsdwu71vQpo8l
         4hsC4E1OYjLOCvcQc0ZNw7818nwUnGdICNM7KZF/Pj8oVL04L5HnrLC4hGuv9gcmfZac
         QEF3y8KkPlAdKQa7pk8VGNHlHNoii/EZVaGEr6IiXqB8Q9AYGmnR5/+s61lipbxEVDy4
         WVZil8tiOMGEBeIN6IOofRQtzUr/x76R5xEihGyGfY+KVuW7UGM6aZN17saLTTNxIC81
         Y9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uQh+p4niM1XazCyX0W8SClLNopGSLFeOTKZKD97XRE=;
        b=eQRV5guHUU2XfBvJ7o5ErGNaf4RMF6S2teOdi7D5Ob1F8dg6VrxlMlWVZL6thVr5vc
         S2MkNjdLLi/mj1rw7+XRo2QMpi5dsjwnxU3HKgw6L9b7Aucf3ny7G8pUzc8cy3z0SwpN
         6IUJEYPMC47/KK7VlODDH1zN0wTBGgyP3vaSP1siwSS5uQw8UMs8RVWirE9OsL4YTKcT
         mQwk5QkCNMIIi7otJv2wYNKaTh9GbPQE0t4thZRyP+SD+6lQftkeYvpZjc9x38csR1Xa
         Wla7wAGIZYS+PxOqe8gpt6plGDECW0uAnLCNrewhZV9vxR2K07W8GhG1EKDb6SO6nM6k
         NZ4A==
X-Gm-Message-State: APjAAAVR853iMmTG0Xk/iTIM3kSlkaCTjcrNx2tX89k5vX0vLwnyURMf
        HD5JGc5ZvIVE9oXf2lNvp4E=
X-Google-Smtp-Source: APXvYqxfDuRpBbYxO71iQgRCpp9YwcxdysZGYp8xW7ZBvNhCbiRnBK6qmFG1IHuGhuou8D2zduF20Q==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr12194274pfm.102.1556347384381;
        Fri, 26 Apr 2019 23:43:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:03 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 01/24] Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
Date:   Fri, 26 Apr 2019 16:22:40 -0700
Message-Id: <20190426232303.28381-2-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

text_mutex is currently expected to be held before text_poke() is
called, but kgdb does not take the mutex, and instead *supposedly*
ensures the lock is not taken and will not be acquired by any other core
while text_poke() is running.

The reason for the "supposedly" comment is that it is not entirely clear
that this would be the case if gdb_do_roundup is zero.

Create two wrapper functions, text_poke() and text_poke_kgdb(), which do
or do not run the lockdep assertion respectively.

While we are at it, change the return code of text_poke() to something
meaningful. One day, callers might actually respect it and the existing
BUG_ON() when patching fails could be removed. For kgdb, the return
value can actually be used.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 52 ++++++++++++++++++++--------
 arch/x86/kernel/kgdb.c               | 11 +++---
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..f8fc8e86cf01 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -35,6 +35,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
  * inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9a79c7808f9c..0a814d73547a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -679,18 +679,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	return addr;
 }
 
-/**
- * text_poke - Update instructions on a live kernel
- * @addr: address to modify
- * @opcode: source of the copy
- * @len: length to copy
- *
- * Only atomic text poke/set should be allowed when not doing early patching.
- * It means the size must be writable atomically and the address must be aligned
- * in a way that permits an atomic write. It also makes sure we fit on a single
- * page.
- */
-void *text_poke(void *addr, const void *opcode, size_t len)
+static void *__text_poke(void *addr, const void *opcode, size_t len)
 {
 	unsigned long flags;
 	char *vaddr;
@@ -703,8 +692,6 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!after_bootmem);
 
-	lockdep_assert_held(&text_mutex);
-
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
@@ -733,6 +720,43 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	return addr;
 }
 
+/**
+ * text_poke - Update instructions on a live kernel
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy
+ *
+ * Only atomic text poke/set should be allowed when not doing early patching.
+ * It means the size must be writable atomically and the address must be aligned
+ * in a way that permits an atomic write. It also makes sure we fit on a single
+ * page.
+ */
+void *text_poke(void *addr, const void *opcode, size_t len)
+{
+	lockdep_assert_held(&text_mutex);
+
+	return __text_poke(addr, opcode, len);
+}
+
+/**
+ * text_poke_kgdb - Update instructions on a live kernel by kgdb
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy
+ *
+ * Only atomic text poke/set should be allowed when not doing early patching.
+ * It means the size must be writable atomically and the address must be aligned
+ * in a way that permits an atomic write. It also makes sure we fit on a single
+ * page.
+ *
+ * Context: should only be used by kgdb, which ensures no other core is running,
+ *	    despite the fact it does not hold the text_mutex.
+ */
+void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
+{
+	return __text_poke(addr, opcode, len);
+}
+
 static void do_sync_core(void *info)
 {
 	sync_core();
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 4ff6b4cdb941..2b203ee5b879 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -759,13 +759,13 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 	if (!err)
 		return err;
 	/*
-	 * It is safe to call text_poke() because normal kernel execution
+	 * It is safe to call text_poke_kgdb() because normal kernel execution
 	 * is stopped on all cores, so long as the text_mutex is not locked.
 	 */
 	if (mutex_is_locked(&text_mutex))
 		return -EBUSY;
-	text_poke((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
-		  BREAK_INSTR_SIZE);
+	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
+		       BREAK_INSTR_SIZE);
 	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
 	if (err)
 		return err;
@@ -784,12 +784,13 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	if (bpt->type != BP_POKE_BREAKPOINT)
 		goto knl_write;
 	/*
-	 * It is safe to call text_poke() because normal kernel execution
+	 * It is safe to call text_poke_kgdb() because normal kernel execution
 	 * is stopped on all cores, so long as the text_mutex is not locked.
 	 */
 	if (mutex_is_locked(&text_mutex))
 		goto knl_write;
-	text_poke((void *)bpt->bpt_addr, bpt->saved_instr, BREAK_INSTR_SIZE);
+	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
+		       BREAK_INSTR_SIZE);
 	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
 	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
 		goto knl_write;
-- 
2.17.1

