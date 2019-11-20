Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E618C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4A2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1azWtR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfKTRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:02:34 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35815 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbfKTRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:02:32 -0500
Received: by mail-vs1-f73.google.com with SMTP id w22so113178vse.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gxBL3CBm1h/tbDLIWI6DpF6/W5QiOnWrINNtvzXl3CY=;
        b=r1azWtR8COJZA/ahy8SN4T3KGLZ4gEKjIC1zz3dHUhDegy8SQwDqwrRmzQJ7VdYdLU
         gX2LiIeaALOtjf3p4Gu2eoOuynsKKm6R4iEMJTF6dgqK3IVXDNqEMU9EuoSEB0dJKClr
         ICWZ9LOTSMrPz5eCaQkyE5b9IP+fKgcWZxeiYiRIQN2+TI1j++xeYhbA81ZrYcmi8iir
         PNh2nB2ezqdW+uyxPm+H8jgCXh9jlDugxFTRd/cdV2uP7XwbES+RXOEqE1XECUdKRrn0
         Z3sysjV8AdyFLKHUWuF2htWfmgBTRg5BS9SjZH7pUPKNgZd5HXhih+BxfvqmU98fuwZh
         qLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gxBL3CBm1h/tbDLIWI6DpF6/W5QiOnWrINNtvzXl3CY=;
        b=VlMGSsQMiae2GYk7oHVSMQhfttluNaehtIlD9Ed2aSO7MzIvltSq+Iwr2uTSGRkSj9
         iXtXzXQXjqsgSPTekXrdYVIhUUUyKiQgm/nMKxq7rfkiWvFX3kEIL+GcM27u+apcr7d3
         hJuF+9L+/qkk7adC+fGbGFyW7JaBUcf5bx9mu467hf/J43AwTI0120brHlQT7C0cIz4t
         v9DL4GdzT5aPYucmyQW/a0vn6BleksTG2Zb1R15yNCbZ8th2t1VoPzokmtFLIdXzBrgE
         MK3OTE/aEHJeiKfqpQAnXlvjVDAElXyvkB4hyHZN0FDN4PD08mFEyp89EwQnis8pCKIX
         PR8Q==
X-Gm-Message-State: APjAAAVVr6baIUZiI3+/Ydp86MIhT63S/n16yq3stZOxROG6lyFle4HH
        dLQPwQNyUdUkIu9HSbKYYvqbH9ISxg==
X-Google-Smtp-Source: APXvYqwl4tyqT07ywtZZwAp4OuKRyazEmeceWDnsVuo1uFk5GHo3TY3yTtNZ0shwwbNQBBQ0Sr2G9BbJvA==
X-Received: by 2002:a1f:944a:: with SMTP id w71mr2219271vkd.60.1574269349528;
 Wed, 20 Nov 2019 09:02:29 -0800 (PST)
Date:   Wed, 20 Nov 2019 18:02:08 +0100
In-Reply-To: <20191120170208.211997-1-jannh@google.com>
Message-Id: <20191120170208.211997-4-jannh@google.com>
Mime-Version: 1.0
References: <20191120170208.211997-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 4/4] x86/kasan: Print original address on #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
to understand by computing the address of the original access and
printing that. More details are in the comments in the patch.

This turns an error like this:

    kasan: CONFIG_KASAN_INLINE enabled
    kasan: GPF could be caused by NULL-ptr deref or user memory access
    general protection fault probably for non-canonical address
        0xe017577ddf75b7dd: 0000 [#1] PREEMPT SMP KASAN PTI

into this:

    general protection fault probably for non-canonical address
        0xe017577ddf75b7dd: 0000 [#1] PREEMPT SMP KASAN PTI
    KASAN: maybe wild-memory-access in range
        [0x00badbeefbadbee8-0x00badbeefbadbeef]

The hook is placed in architecture-independent code, but is currently
only wired up to the X86 exception handler because I'm not sufficiently
familiar with the address space layout and exception handling mechanisms
on other architectures.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2:
     - move to mm/kasan/report.c (Dmitry)
     - change hook name to be more generic
     - use TASK_SIZE instead of TASK_SIZE_MAX for compiling on non-x86
     - don't open-code KASAN_SHADOW_MASK (Dmitry)
     - add "KASAN: " prefix, but not "BUG: " (Andrey, Dmitry)
     - use same naming scheme as get_wild_bug_type (Andrey)
     - this version was "Reviewed-by: Dmitry Vyukov <dvyukov@google.com>"
    v3:
     - adjusted example output in commit message based on
       changes in preceding patch
     - ensure that KASAN output happens after bust_spinlocks(1)
     - moved hook in arch/x86/kernel/traps.c such that output
       appears after the first line of KASAN-independent error report
    v4:
     - adjust patch to changes in x86/traps patch

 arch/x86/kernel/traps.c     | 11 ++++++++++
 arch/x86/mm/kasan_init_64.c | 21 -------------------
 include/linux/kasan.h       |  6 ++++++
 mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b90635f29b9f..342cee50bf7b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,6 +37,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/kasan.h>
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>
@@ -574,7 +575,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	if (!user_mode(regs)) {
 		bool addr_resolved = false;
 		unsigned long gp_addr;
+		unsigned long flags;
 		bool non_canonical;
+		int sig;
 
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
@@ -606,6 +609,14 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			    GPFSTR " probably for %saddress 0x%lx",
 			    non_canonical ? "non-canonical " : "", gp_addr);
 
+		flags = oops_begin();
+		sig = SIGSEGV;
+		__die_header(desc, regs, error_code);
+		if (addr_resolved && non_canonical)
+			kasan_non_canonical_hook(gp_addr);
+		if (__die_body(desc, regs, error_code))
+			sig = 0;
+		oops_end(flags, regs, sig);
 		die(desc, regs, error_code);
 		return;
 	}
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 296da58f3013..69c437fb21cc 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -245,23 +245,6 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
 	} while (pgd++, addr = next, addr != end);
 }
 
-#ifdef CONFIG_KASAN_INLINE
-static int kasan_die_handler(struct notifier_block *self,
-			     unsigned long val,
-			     void *data)
-{
-	if (val == DIE_GPF) {
-		pr_emerg("CONFIG_KASAN_INLINE enabled\n");
-		pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block kasan_die_notifier = {
-	.notifier_call = kasan_die_handler,
-};
-#endif
-
 void __init kasan_early_init(void)
 {
 	int i;
@@ -298,10 +281,6 @@ void __init kasan_init(void)
 	int i;
 	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
 
-#ifdef CONFIG_KASAN_INLINE
-	register_die_notifier(&kasan_die_notifier);
-#endif
-
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index cc8a03cc9674..7305024b44e3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -194,4 +194,10 @@ static inline void *kasan_reset_tag(const void *addr)
 
 #endif /* CONFIG_KASAN_SW_TAGS */
 
+#ifdef CONFIG_KASAN_INLINE
+void kasan_non_canonical_hook(unsigned long addr);
+#else /* CONFIG_KASAN_INLINE */
+static inline void kasan_non_canonical_hook(unsigned long addr) { }
+#endif /* CONFIG_KASAN_INLINE */
+
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 621782100eaa..5ef9f24f566b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -512,3 +512,43 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 
 	end_report(&flags);
 }
+
+#ifdef CONFIG_KASAN_INLINE
+/*
+ * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
+ * canonical half of the address space) cause out-of-bounds shadow memory reads
+ * before the actual access. For addresses in the low canonical half of the
+ * address space, as well as most non-canonical addresses, that out-of-bounds
+ * shadow memory access lands in the non-canonical part of the address space.
+ * Help the user figure out what the original bogus pointer was.
+ */
+void kasan_non_canonical_hook(unsigned long addr)
+{
+	unsigned long orig_addr;
+	const char *bug_type;
+
+	if (addr < KASAN_SHADOW_OFFSET)
+		return;
+
+	orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
+	/*
+	 * For faults near the shadow address for NULL, we can be fairly certain
+	 * that this is a KASAN shadow memory access.
+	 * For faults that correspond to shadow for low canonical addresses, we
+	 * can still be pretty sure - that shadow region is a fairly narrow
+	 * chunk of the non-canonical address space.
+	 * But faults that look like shadow for non-canonical addresses are a
+	 * really large chunk of the address space. In that case, we still
+	 * print the decoded address, but make it clear that this is not
+	 * necessarily what's actually going on.
+	 */
+	if (orig_addr < PAGE_SIZE)
+		bug_type = "null-ptr-deref";
+	else if (orig_addr < TASK_SIZE)
+		bug_type = "probably user-memory-access";
+	else
+		bug_type = "maybe wild-memory-access";
+	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
+		 orig_addr, orig_addr + KASAN_SHADOW_MASK);
+}
+#endif
-- 
2.24.0.432.g9d3f5f5b63-goog

