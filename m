Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB04C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9548121851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlZ5YXsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfGSN2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:28:37 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46749 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfGSN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:28:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so18713818pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iYL0YLGspAoacIEhwiD/4Rcr5rrGFUrtzpWbGW+PP1M=;
        b=qlZ5YXsQ3q6VcrDkxcJvSAccOBJQViXXTLP1/OSN+TYafaoVDqCkXR5iOqSJ7OW/Bb
         8a4zee129xEC8hjucIwplQkU7GE0DbdRixq/X74le1Cy+9vc0Ag9T7Rpq3I6Zae25GnF
         v9ChASD1iHsW+qVJUeO62zPqpEdxjxhJewf7uzaELdTjLzu8mM5MNAnKMwVG7Hvu3uAF
         7oT8cxxLYyEUej8sEaBakNQmX4xfS6+a/LVlYJVNcyhCb6VYbMF3ru9Yqvayn98pdxOS
         mb1994PMmNjdROUc/irvGXuVMsFogZzJoabzwlEdJ+V8biznyaI9/7FPSbXTous/OBKj
         sPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iYL0YLGspAoacIEhwiD/4Rcr5rrGFUrtzpWbGW+PP1M=;
        b=jFFsi3WBUM2A+iMD5mhnMQFIqp1+bkWdA3kwOu+jBfSn2ClVaJmEeoymUPGXhC3GKj
         DdxoV4iKxA8gghrSg2ZgiOs+hfRqtC8fOYmc/B8+R24wFtS15DhxzNt0k7f7d/MX8Wdh
         udnM8FGGs4VnFIP+WmJFqbsZGBD5S/Dcf3sGAiuO5kvbnPB6025DGrLuZW1Ui9Qdv98s
         mGRLqeW4lNBqDdO/xHZkYtpdOM0cE/pWMNdorAJVuosJOm+6bTurwzv/SbomBue83Wq6
         cUB5VRbOIs6DIqrrI+AnQ5RZHlPwPlkWH4VcryA0pmkKwULcBp7MyGdkNuXIuurhnktf
         RkuQ==
X-Gm-Message-State: APjAAAV+avW8mf1Pxb+atebzNJUxiv3oMjhcTnfGqjZ206B3bjfxvQIw
        tvNrGF9m7a4rh2AJX316MFWLtv+YxA==
X-Google-Smtp-Source: APXvYqyDhpHnMjwjWrUSWI2hz3TzPC4T9qC/homjDaT9MIAUL76KayytgH++tiunuzPUAPmiuBNvPHpx4w==
X-Received: by 2002:a63:ef4b:: with SMTP id c11mr51427206pgk.129.1563542915386;
 Fri, 19 Jul 2019 06:28:35 -0700 (PDT)
Date:   Fri, 19 Jul 2019 15:28:17 +0200
Message-Id: <20190719132818.40258-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling STACK_GUARD_PAGE helps catching kernel stack overflows immediately
rather than causing difficult-to-diagnose corruption. Note that, unlike
virtually-mapped kernel stacks, this will effectively waste an entire page of
memory; however, this feature may provide extra protection in cases that cannot
use virtually-mapped kernel stacks, at the cost of a page.

The motivation for this patch is that KASAN cannot use virtually-mapped kernel
stacks to detect stack overflows. An alternative would be implementing support
for vmapped stacks in KASAN, but would add significant extra complexity. While
the stack-end guard page approach here wastes a page, it is significantly
simpler than the alternative.  We assume that the extra cost of a page can be
justified in the cases where STACK_GUARD_PAGE would be enabled.

Note that in an earlier prototype of this patch, we used
'set_memory_{ro,rw}' functions, which flush the TLBs. This, however,
turned out to be unacceptably expensive, especially when run with
fuzzers such as Syzkaller, as the kernel would encounter frequent RCU
timeouts. The current approach of not flushing the TLB is therefore
best-effort, but works in the test cases considered -- any comments on
better alternatives or improvements are welcome.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kasan-dev@googlegroups.com
---
 arch/Kconfig                         | 15 +++++++++++++++
 arch/x86/include/asm/page_64_types.h |  8 +++++++-
 include/linux/sched/task_stack.h     | 11 +++++++++--
 kernel/fork.c                        | 22 +++++++++++++++++++++-
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e8d19c3cb91f..cca3258fff1f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -935,6 +935,21 @@ config LOCK_EVENT_COUNTS
 	  the chance of application behavior change because of timing
 	  differences. The counts are reported via debugfs.
 
+config STACK_GUARD_PAGE
+	default n
+	bool "Use stack-end page as guard page"
+	depends on !VMAP_STACK && ARCH_HAS_SET_DIRECT_MAP && THREAD_INFO_IN_TASK && !STACK_GROWSUP
+	help
+	  Enable this if you want to use the stack-end page as a guard page.
+	  This causes kernel stack overflows to be caught immediately rather
+	  than causing difficult-to-diagnose corruption. Note that, unlike
+	  virtually-mapped kernel stacks, this will effectively waste an entire
+	  page of memory; however, this feature may provide extra protection in
+	  cases that cannot use virtually-mapped kernel stacks, at the cost of
+	  a page. Note that, this option does not implicitly increase the
+	  default stack size. The main use-case is for KASAN to avoid reporting
+	  misleading bugs due to stack overflow.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 288b065955b7..b218b5713c02 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -12,8 +12,14 @@
 #define KASAN_STACK_ORDER 0
 #endif
 
+#ifdef CONFIG_STACK_GUARD_PAGE
+#define STACK_GUARD_SIZE PAGE_SIZE
+#else
+#define STACK_GUARD_SIZE 0
+#endif
+
 #define THREAD_SIZE_ORDER	(2 + KASAN_STACK_ORDER)
-#define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
+#define THREAD_SIZE  ((PAGE_SIZE << THREAD_SIZE_ORDER) - STACK_GUARD_SIZE)
 
 #define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 2413427e439c..7ee86ad0a282 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -11,6 +11,13 @@
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
+#ifndef STACK_GUARD_SIZE
+#ifdef CONFIG_STACK_GUARD_PAGE
+#error "Architecture not compatible with STACK_GUARD_PAGE"
+#endif
+#define STACK_GUARD_SIZE 0
+#endif
+
 /*
  * When accessing the stack of a non-current task that might exit, use
  * try_get_task_stack() instead.  task_stack_page will return a pointer
@@ -18,14 +25,14 @@
  */
 static inline void *task_stack_page(const struct task_struct *task)
 {
-	return task->stack;
+	return task->stack + STACK_GUARD_SIZE;
 }
 
 #define setup_thread_stack(new,old)	do { } while(0)
 
 static inline unsigned long *end_of_stack(const struct task_struct *task)
 {
-	return task->stack;
+	return task->stack + STACK_GUARD_SIZE;
 }
 
 #elif !defined(__HAVE_THREAD_FUNCTIONS)
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..22033b03f7da 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/set_memory.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -249,6 +250,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 					     THREAD_SIZE_ORDER);
 
 	if (likely(page)) {
+		if (IS_ENABLED(CONFIG_STACK_GUARD_PAGE)) {
+			/*
+			 * Best effort: do not flush TLB to avoid the overhead
+			 * of flushing all TLBs.
+			 */
+			set_direct_map_invalid_noflush(page);
+		}
+
 		tsk->stack = page_address(page);
 		return tsk->stack;
 	}
@@ -258,6 +267,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 static inline void free_thread_stack(struct task_struct *tsk)
 {
+	struct page* stack_page;
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 
@@ -285,7 +295,17 @@ static inline void free_thread_stack(struct task_struct *tsk)
 	}
 #endif
 
-	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	stack_page = virt_to_page(tsk->stack);
+
+	if (IS_ENABLED(CONFIG_STACK_GUARD_PAGE)) {
+		/*
+		 * Avoid flushing TLBs, and instead rely on spurious fault
+		 * detection of stale TLBs.
+		 */
+		set_direct_map_default_noflush(stack_page);
+	}
+
+	__free_pages(stack_page, THREAD_SIZE_ORDER);
 }
 # else
 static struct kmem_cache *thread_stack_cache;
-- 
2.22.0.657.g960e92d24f-goog

