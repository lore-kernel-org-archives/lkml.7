Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80157C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D4E207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO6uPoib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfLIOcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:32:04 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48690 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLIOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:32:03 -0500
Received: by mail-yw1-f73.google.com with SMTP id b70so11907237ywa.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yBHbIQvNCgun/fLqJAC7LW6t/3v3EtuoAoy5ROyL9Io=;
        b=SO6uPoibPUNY/jUyQHsPYembtuJJIdaB04wQgG2R3N71denmrgbn5SLda85XqxI53K
         M62NG0BYtH+Bwm+8Cuu6gARMbR/EFcsDXHAEojv9aGioar2XH/Ua44ksLRKW0Euid8c4
         t67RzNMwZeSuqICoin8e1yt7DJl35aTXlY+3MD4Y0Mzbwtk2ifRg0b4odkHbWA9fqsMo
         kZKgykJtRauiZMCgvVBW6IS8iDZ+X6c0iqyKuxiM1/k5obFEMT2J+RFUBS+MjXqIL/aW
         SmoPVuz3MHQQ7yYDGxUPLWm1uFb5eeqbfwcynkmYnQeGVjoN3VuzHzMkFy5A3jpWqCWl
         ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yBHbIQvNCgun/fLqJAC7LW6t/3v3EtuoAoy5ROyL9Io=;
        b=WckJ6r+UZAzSpidSsLkC0iSzbDMrdvZ0uloxnySSnTFXooGHF+4FbibR3aaiAULq2M
         9wCiS4arQBoqRV/KsjmPi/jX5HaFz5D1qJhITLQesCnikx0X4ScG1cHuGsar19dR1RY4
         XPc1J5v+h3g7cdMRw3ATL8Q4klZtoK9mTFoLW03qJlocKRGQFRCXn12160ncg3pJ0nAP
         VQlVi7Jgb9wPVp4I0TjLLENO1k1AQKZKV1mXNthyMqg5DwGvwSyRISm154Gwa2nReiH4
         F0chM6aQk5jJB/AOtPIpc998m3TlcRlkfD/0kOAg2U/ZOh0eb4vUg96gy4ZKes69LrAm
         i5aA==
X-Gm-Message-State: APjAAAWOViEA1RG/hfwdS66kzJZ4uWmyRS0ALuUywaT0Row4cw1RTRuI
        6Vizb32Zhm5WmH2D1uN0y8xYoVErTQ==
X-Google-Smtp-Source: APXvYqy3hDK6VlviOuXekXqT7uB+N93aOE2rwKbXxMgm0LQjLDvSXHTOEpCP/gHfhUvmkoNDxgmM2Xrb4g==
X-Received: by 2002:a81:7015:: with SMTP id l21mr21359313ywc.425.1575901922114;
 Mon, 09 Dec 2019 06:32:02 -0800 (PST)
Date:   Mon,  9 Dec 2019 15:31:20 +0100
In-Reply-To: <20191209143120.60100-1-jannh@google.com>
Message-Id: <20191209143120.60100-4-jannh@google.com>
Mime-Version: 1.0
References: <20191209143120.60100-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 4/4] x86/kasan: Print original address on #GP
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
    general protection fault, probably for non-canonical address
        0xe017577ddf75b7dd: 0000 [#1] PREEMPT SMP KASAN PTI

into this:

    general protection fault, probably for non-canonical address
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
    v5:
     - adjust patch to changes in x86/traps patch
     - fix bug introduced in v3: remove die() call after oops_end()
    v6:
     - adjust sample output in commit message

 arch/x86/kernel/traps.c     | 12 ++++++++++-
 arch/x86/mm/kasan_init_64.c | 21 -------------------
 include/linux/kasan.h       |  6 ++++++
 mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c8b4ae6aed5b..7813592b4fb3 100644
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
@@ -589,6 +590,8 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	if (!user_mode(regs)) {
 		enum kernel_gp_hint hint = GP_NO_HINT;
 		unsigned long gp_addr;
+		unsigned long flags;
+		int sig;
 
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
@@ -621,7 +624,14 @@ do_general_protection(struct pt_regs *regs, long error_code)
 				 "maybe for address",
 				 gp_addr);
 
-		die(desc, regs, error_code);
+		flags = oops_begin();
+		sig = SIGSEGV;
+		__die_header(desc, regs, error_code);
+		if (hint == GP_NON_CANONICAL)
+			kasan_non_canonical_hook(gp_addr);
+		if (__die_body(desc, regs, error_code))
+			sig = 0;
+		oops_end(flags, regs, sig);
 		return;
 	}
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index cf5bc37c90ac..763e71abc0fe 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -288,23 +288,6 @@ static void __init kasan_shallow_populate_pgds(void *start, void *end)
 	} while (pgd++, addr = next, addr != (unsigned long)end);
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
@@ -341,10 +324,6 @@ void __init kasan_init(void)
 	int i;
 	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
 
-#ifdef CONFIG_KASAN_INLINE
-	register_die_notifier(&kasan_die_notifier);
-#endif
-
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4f404c565db1..e0238af0388f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -225,4 +225,10 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long free_region_end) {}
 #endif
 
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
2.24.0.393.g34dc348eaf-goog

