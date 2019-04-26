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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A70C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D64A208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKJ4fAeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfD0GpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:45:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42169 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfD0GnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so2567500pln.9;
        Fri, 26 Apr 2019 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gMfxobg7i1AP5PQ14JM+oGjrmklNXXx9IUFM/PW54zo=;
        b=XKJ4fAeBY8aGdbJDn84dW83HzgSvQACPuhXWJHvF1CWt6rAKSo0+tUCXqeDEYn8KGx
         u3zXII+RSuYhdLmlbo5/0feDTgEEs6/tOmzti0w5Pevv/8Nua7dmelg2Hg1YTOM0HPNp
         IuB1XxBtPV5C1LDrt4HWOamCYTjBpu9Uc9bqXu6wh2x58Sr/Usj1f74P/vpY9jMFSCFS
         THBbi+fo5P15SNYnnZLc+khNDUp7StdyPifYfNcqKpXcU/HGBdU106YbtBqZ2gBNSvKt
         YTZSQ/QqPm8CwczIhg2BokKOhThemqJ36d1wwJl1ZB93G6rLPD545DygLOMnvs67gNXF
         w1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gMfxobg7i1AP5PQ14JM+oGjrmklNXXx9IUFM/PW54zo=;
        b=VTV3oNABLcWnQT6EyxfYkWKw+VCqL9kozgc+uQPe2ewZsoHcE3S9yVBZlAFpYhBNbz
         7rq68VSTmRYxNsszQ8s5Vlwp4hOZemvnHQQKISpez0TbprktH90D+seVfxYVw8ndRTyG
         I9ydMVYCE9ctxzcUKroA6SK8Z1A0tYz4Z8Id5F4BYC7FJ3AjxcpMCnLReoZQrs4WcHs3
         d/F8E/YoLGT7XA1bcnuhoO8yok3zUru8WptkOegmVycUcvqNj0VnrECe/wzgCTe11fb7
         PJlS56Zt+9qDwawTwXnNIv0ixb1JamSFn4pIObJ7P6ZiREEoxQWVcwU3Xb6toI3mJm6R
         f2tQ==
X-Gm-Message-State: APjAAAUiKMYfOfhAJ0UhztxLwnMMNTfMUy2MaLFgUBNvh5cNYJslMRna
        5PHCBTbcphtklUIEDQrUf50=
X-Google-Smtp-Source: APXvYqwk9lLXQyc9bNgKLLm6YtZMcI1PVJ4KR2rM1C+cN3nT9zotDQcbIXGbwEvAmUupbSpfYScE8w==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr50206141pla.111.1556347390037;
        Fri, 26 Apr 2019 23:43:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:09 -0700 (PDT)
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v6 05/24] uprobes: Initialize uprobes earlier
Date:   Fri, 26 Apr 2019 16:22:44 -0700
Message-Id: <20190426232303.28381-6-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

In order to have a separate address space for text poking, we need to
duplicate init_mm early during start_kernel(). This, however, introduces
a problem since uprobes functions are called from dup_mmap(), but
uprobes is still not initialized in this early stage.

Since uprobes initialization is necassary for fork, and since all the
dependant initialization has been done when fork is initialized (percpu
and vmalloc), move uprobes initialization to fork_init(). It does not
seem uprobes introduces any security problem for the poking_mm.

Crash and burn if uprobes initialization fails, similarly to other early
initializations. Change the init_probes() name to probes_init() to match
other early initialization functions name convention.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/uprobes.h | 5 +++++
 kernel/events/uprobes.c | 8 +++-----
 kernel/fork.c           | 1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 103a48a48872..12bf0b68ed92 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,6 +115,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
@@ -154,6 +155,10 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 struct uprobes_state {
 };
 
+static inline void uprobes_init(void)
+{
+}
+
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
 static inline int
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c5cde87329c7..e6a0d6be87e3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2294,16 +2294,14 @@ static struct notifier_block uprobe_exception_nb = {
 	.priority		= INT_MAX-1,	/* notified after kprobes, kgdb */
 };
 
-static int __init init_uprobes(void)
+void __init uprobes_init(void)
 {
 	int i;
 
 	for (i = 0; i < UPROBES_HASH_SZ; i++)
 		mutex_init(&uprobes_mmap_mutex[i]);
 
-	if (percpu_init_rwsem(&dup_mmap_sem))
-		return -ENOMEM;
+	BUG_ON(percpu_init_rwsem(&dup_mmap_sem));
 
-	return register_die_notifier(&uprobe_exception_nb);
+	BUG_ON(register_die_notifier(&uprobe_exception_nb));
 }
-__initcall(init_uprobes);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b..44fba5e5e916 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -815,6 +815,7 @@ void __init fork_init(void)
 #endif
 
 	lockdep_init_task(&init_task);
+	uprobes_init();
 }
 
 int __weak arch_dup_task_struct(struct task_struct *dst,
-- 
2.17.1

