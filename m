Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F8A22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHXGF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39022 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfHXGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so7050424pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gm/XdTYkIOoGkuaPCMNGz5/LttF1ivxSvkXXovWunI0=;
        b=O71ltPSDYJos+ApmyeXzPFSjwWDXEwNrdjoQ7LXqC6RC7DHq2+MhCU19JjqogkO3HK
         NtgmZD2pe9SKYgFr6hEYQp29gFJQA5AorPMg9CyKpzdMisp4OQoP3qb0xDWd4Askn+DC
         D/ch6Qw5U3JLz4tW10LgVTahQJ/mJr2w8ML3QUNIlDs0y6UxMXHFEwZUvnPdeBqdGVfS
         JjBHSJOF84HsAyaCjMIjNa2y+Hw6XZ8AlIt3MnrB+rMCgWlM4mxkDjd5tDr1cnSIMDZZ
         CMSZbEP+iy/0QS+nW+e5zk1EQa92UEv7HtcJBkFzCST0BdOryA9XTsoCaHnBWQ2D0tOE
         ejAQ==
X-Gm-Message-State: APjAAAXvMwdf7T6u9ILJWHjdXbzDEIpUWwefhb8jfjWHY6mSCzuTFabb
        kD3bXk4T4h2WJ9G3XYxW/Gs=
X-Google-Smtp-Source: APXvYqwmfor3l/pjL1JO7B0xRehhEkmmsL56ceOI3qUBevHOc/J6b9Pkqdbh/AZX7l3kmFz1Xu+HUg==
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr9033125pjr.78.1566626721980;
        Fri, 23 Aug 2019 23:05:21 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:21 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 7/7] x86/current: Aggressive caching of current
Date:   Fri, 23 Aug 2019 15:44:24 -0700
Message-Id: <20190823224424.15296-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current_task is supposed to be constant in each thread and therefore
does not need to be reread. There is already an attempt to cache it
using inline assembly, using this_cpu_read_stable(), which hides the
dependency on the read memory address.

However, this caching is not working very well. For example,
sync_mm_rss() still reads current_task twice for no reason.

Allow more aggressive caching by aliasing current_task to
into a constant const_current_task and reading from the constant copy.
Doing so requires the compiler to support x86 segment qualifiers.
Hide const_current_task in a different compilation unit to avoid the
compiler from assuming that the value is constant during compilation.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/current.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/Makefile   |  1 +
 arch/x86/kernel/cpu/common.c   |  7 +------
 arch/x86/kernel/cpu/current.c  | 16 ++++++++++++++++
 include/linux/compiler.h       |  2 +-
 5 files changed, 49 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/current.c

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 3e204e6140b5..7f093e81a647 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -10,11 +10,41 @@ struct task_struct;
 
 DECLARE_PER_CPU(struct task_struct *, current_task);
 
+#if USE_X86_SEG_SUPPORT
+
+/*
+ * Hold a constant alias for current_task, which would allow to avoid caching of
+ * current task.
+ *
+ * We must mark const_current_task with the segment qualifiers, as otherwise gcc
+ * would do redundant reads of const_current_task.
+ */
+DECLARE_PER_CPU(struct task_struct * const __percpu_seg_override, const_current_task);
+
+static __always_inline struct task_struct *get_current(void)
+{
+
+	/*
+	 * GCC is missing functionality of removing segment qualifiers, which
+	 * messes with per-cpu infrastructure that holds local copies. Use
+	 * __raw_cpu_read to avoid holding any copy.
+	 */
+	return __raw_cpu_read(, const_current_task);
+}
+
+#else /* USE_X86_SEG_SUPPORT */
+
+/*
+ * Without segment qualifier support, the per-cpu infrastrucutre is not
+ * suitable for reading constants, so use this_cpu_read_stable() in this case.
+ */
 static __always_inline struct task_struct *get_current(void)
 {
 	return this_cpu_read_stable(current_task);
 }
 
+#endif /* USE_X86_SEG_SUPPORT */
+
 #define current get_current()
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7a1e5a9331c..d816f03a37d7 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -19,6 +19,7 @@ CFLAGS_common.o		:= $(nostackp)
 
 obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
+obj-y			+= current.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5cc2d51cc25e..5f7c9ee57802 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1619,13 +1619,8 @@ DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
 EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
 /*
- * The following percpu variables are hot.  Align current_task to
- * cacheline size such that they fall in the same cacheline.
+ * The following percpu variables are hot.
  */
-DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
-	&init_task;
-EXPORT_PER_CPU_SYMBOL(current_task);
-
 DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 
diff --git a/arch/x86/kernel/cpu/current.c b/arch/x86/kernel/cpu/current.c
new file mode 100644
index 000000000000..3238c6e34984
--- /dev/null
+++ b/arch/x86/kernel/cpu/current.c
@@ -0,0 +1,16 @@
+#include <linux/sched/task.h>
+#include <asm/current.h>
+
+/*
+ * Align current_task to cacheline size such that they fall in the same
+ * cacheline.
+ */
+DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
+	&init_task;
+EXPORT_PER_CPU_SYMBOL(current_task);
+
+#if USE_X86_SEG_SUPPORT
+DECLARE_PER_CPU(struct task_struct * const __percpu_seg_override, const_current_task)
+	__attribute__((alias("current_task")));
+EXPORT_PER_CPU_SYMBOL(const_current_task);
+#endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f0fd5636fddb..1b6ee9ab6373 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -299,7 +299,7 @@ unsigned long read_word_at_a_time(const void *addr)
  */
 #define __ADDRESSABLE(sym) \
 	static void * __section(".discard.addressable") __used \
-		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
+		__PASTE(__addressable_##sym, __LINE__) = (void *)(uintptr_t)&sym;
 
 /**
  * offset_to_ptr - convert a relative memory offset to an absolute pointer
-- 
2.17.1

