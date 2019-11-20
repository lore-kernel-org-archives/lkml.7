Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB86C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283AF22429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdTANbiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfKTKgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:36:54 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47550 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfKTKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:36:52 -0500
Received: by mail-qk1-f201.google.com with SMTP id v9so5973207qkj.14
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XXv7Sasr5KrifXcHDhUghU+ar6AdS1iTu/G2m38gf3g=;
        b=JdTANbiV9oHdk4Aw6r13hpEkchB0RtHXb9CVTIzcDjK0IO3+B0p7GmoNtrW86lCmce
         tpYqeKh/zBK2xN0yF+Jo2GGU3QiCl5aWAx/jShebQgJ908Phtvuwwog/XgrOx7MZShSy
         DGxz1j95s7QV6phFBu4k4zWaw/FwP9wvelY1+GxBWOQWyHBAxL95U2xIy8v17ivQAzQK
         UfQRT9S9mD1D1tNkhlXm0rpgmJQ70D8KDQH62soo6Rf85c62MqpgmM3/99j1bRZrk7ac
         vonjjqbIBrKhpHQ3TYUQywwiAtbRHw606m+wL6R9LGcVd3Xx4R74RML5H/UZ0GSYQo0/
         UR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XXv7Sasr5KrifXcHDhUghU+ar6AdS1iTu/G2m38gf3g=;
        b=Xyd4iGBfirQAG0LyD1xxva3lcZ3dQ/Yzt542VCLgszQ1nhEnZ9bpzvgXKvKhx5VY23
         oPzdxqNTnqigk8Xg15L/5hbsF2OvLkgJ3dMHm8AgckNuNpkrJf1LARRMpsdPrZJOeEDh
         VlEXITfqpkb8Zkf0SeELOLs0JFcsUmvRR0TkeweJYcqF5kfxgHrG4qQGhdXwDCzzsqWS
         ZBtwHCM7H+dAvmjA6H6ym3WqBaSnyS7qXIsHIchMY2T77Qd522nh4I7dFrMhxcp4GLB0
         +EtIrzCd8mT+iQZiK5ArbNwKxFjDRgktUR7iA+ATLyNMMvXnfPtur1lFTSFUbWXpmsB/
         DUJw==
X-Gm-Message-State: APjAAAXnxY4uC/ni32eqoA9E1LVm0J4I/1RtJIaSVNQumRY3w10H6nnG
        tVVP/NNCKVfcIHZ9fxEDPAMkdYjzLg==
X-Google-Smtp-Source: APXvYqzmhxYyDc9cMeI6H9TwrkaoayfuvHIamhrvtIFGL1DLbEmKU9F0bp4T+yRQKFREP71PcElxnN4yYQ==
X-Received: by 2002:ae9:dd47:: with SMTP id r68mr1686874qkf.7.1574246209435;
 Wed, 20 Nov 2019 02:36:49 -0800 (PST)
Date:   Wed, 20 Nov 2019 11:36:13 +0100
In-Reply-To: <20191120103613.63563-1-jannh@google.com>
Message-Id: <20191120103613.63563-4-jannh@google.com>
Mime-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 4/4] x86/kasan: Print original address on #GP
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
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

 arch/x86/kernel/traps.c     | 11 ++++++++++
 arch/x86/mm/kasan_init_64.c | 21 -------------------
 include/linux/kasan.h       |  6 ++++++
 mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 19afedcd6f4e..b5baf1114d44 100644
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
@@ -568,6 +569,8 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	tsk = current;
 	if (!user_mode(regs)) {
 		unsigned long non_canonical_addr = 0;
+		unsigned long flags;
+		int sig;
 
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
@@ -598,6 +601,14 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			    GPFSTR " probably for non-canonical address 0x%lx",
 			    non_canonical_addr);
 
+		flags = oops_begin();
+		sig = SIGSEGV;
+		__die_header(desc, regs, error_code);
+		if (non_canonical_addr)
+			kasan_non_canonical_hook(non_canonical_addr);
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

