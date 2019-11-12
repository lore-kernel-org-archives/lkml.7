Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1EEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BCA21A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgWSAD49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKLVKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:10:24 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:32859 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:10:23 -0500
Received: by mail-wm1-f73.google.com with SMTP id g13so1974078wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AImRA0iAmIPP5MlLCN7f+WlpNxu0QRdC715vd3kJqjY=;
        b=XgWSAD49k7MvI9rLdhpU6FxsBbVvIzU5VnOhKBwid61NAtko9yvScv1glv/0nRpZhg
         wiLYLkuXDwe0zpN40vO63gmDMKP1w349JLJ4fpY4hMhGQGkY2kPYk6kK1+ZEKhBhPHym
         5b3ZPyrtfa9hPzAWZ/njpPt3dT8gAZHzLXraLHc4/l883C5sfEUzFoffDgGmFq8dJtDq
         Euj70P/yOhngVwcjj9YdlPTCI2NOuOT8xYGwaC19EtfexXdKIsU8Y2IqH64WnA0mvGy0
         dH5WCzm8S3m5Cp2asLRQmfYW2oYH04GyeQMZXm9mqCHA5nSuuZ9xi+t/jfMxNNxY7tGt
         1mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AImRA0iAmIPP5MlLCN7f+WlpNxu0QRdC715vd3kJqjY=;
        b=WFkijXiwOjYnjWtoR82YD9FgpTtwuCLnltbP8ZbFhXIzBGagyWj1ozeFoZu4NRwBgL
         d566EVFdSDEBAtRTOGZ2yvv5xrn2+E7tnrgHx8IRoEn8HECTLMp+ec8jFEaS4po/K0/C
         8ibUQBsgqX2zm/SS8mZLYw5lg+s9nWkhFEK6N/xw2QR11ZzWnPu4+I62erRDOwqqa1vu
         s/1tqdjxooJt1DmEPF7S+7TYhkaxyjuU+xQccfTtLSYIceTIQ4ua+SdjYK2q+HImaTiG
         kVZOd7LP11e6w877gFQybT/DPu3FbHoZtShjwM1RY3IZAf4TwxxJhoi/XYCmqiF2xKxA
         DHow==
X-Gm-Message-State: APjAAAXabhzqhx2ln6ElwaxB7Uqgmqj3aty9elnrY7Phm+k+aug+cMRG
        lfHcrPOs08w6xHWWVZ4OUMnQEspNdQ==
X-Google-Smtp-Source: APXvYqy/CG0pAtaTibsW6y5eXSinXHlEVGjdFu4q/lQc6QDUp9LN5yCFcvTGrHSNLMxRwLcGkHTZZJYypQ==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr28542605wrr.50.1573593020286;
 Tue, 12 Nov 2019 13:10:20 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:10:02 +0100
In-Reply-To: <20191112211002.128278-1-jannh@google.com>
Message-Id: <20191112211002.128278-3-jannh@google.com>
Mime-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 3/3] x86/kasan: Print original address on #GP
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org
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
    traps: dereferencing non-canonical address 0xe017577ddf75b7dd
    general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI

into this:

    traps: dereferencing non-canonical address 0xe017577ddf75b7dd
    kasan: maybe dereferencing invalid pointer in range
            [0x00badbeefbadbee8-0x00badbeefbadbeef]
    general protection fault: 0000 [#3] PREEMPT SMP KASAN PTI
    [...]

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/kasan.h |  6 +++++
 arch/x86/kernel/traps.c      |  2 ++
 arch/x86/mm/kasan_init_64.c  | 52 +++++++++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da38bed..eaf624a758ed 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -25,6 +25,12 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_KASAN_INLINE
+void kasan_general_protection_hook(unsigned long addr);
+#else
+static inline void kasan_general_protection_hook(unsigned long addr) { }
+#endif
+
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
 void __init kasan_init(void);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 479cfc6e9507..e271a5a1ddd4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -58,6 +58,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/kasan.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -544,6 +545,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
 		return;
 
 	pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
+	kasan_general_protection_hook(addr_ref);
 #endif
 }
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 296da58f3013..9ef099309489 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -246,20 +246,44 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
 }
 
 #ifdef CONFIG_KASAN_INLINE
-static int kasan_die_handler(struct notifier_block *self,
-			     unsigned long val,
-			     void *data)
+/*
+ * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
+ * canonical half of the address space) cause out-of-bounds shadow memory reads
+ * before the actual access. For addresses in the low canonical half of the
+ * address space, as well as most non-canonical addresses, that out-of-bounds
+ * shadow memory access lands in the non-canonical part of the address space,
+ * causing #GP to be thrown.
+ * Help the user figure out what the original bogus pointer was.
+ */
+void kasan_general_protection_hook(unsigned long addr)
 {
-	if (val == DIE_GPF) {
-		pr_emerg("CONFIG_KASAN_INLINE enabled\n");
-		pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
-	}
-	return NOTIFY_OK;
-}
+	unsigned long orig_addr;
+	const char *addr_type;
+
+	if (addr < KASAN_SHADOW_OFFSET)
+		return;
 
-static struct notifier_block kasan_die_notifier = {
-	.notifier_call = kasan_die_handler,
-};
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
+		addr_type = "dereferencing kernel NULL pointer";
+	else if (orig_addr < TASK_SIZE_MAX)
+		addr_type = "probably dereferencing invalid pointer";
+	else
+		addr_type = "maybe dereferencing invalid pointer";
+	pr_alert("%s in range [0x%016lx-0x%016lx]\n", addr_type,
+		 orig_addr, orig_addr + (1 << KASAN_SHADOW_SCALE_SHIFT) - 1);
+}
 #endif
 
 void __init kasan_early_init(void)
@@ -298,10 +322,6 @@ void __init kasan_init(void)
 	int i;
 	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
 
-#ifdef CONFIG_KASAN_INLINE
-	register_die_notifier(&kasan_die_notifier);
-#endif
-
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
-- 
2.24.0.432.g9d3f5f5b63-goog

