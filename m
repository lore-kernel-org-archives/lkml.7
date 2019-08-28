Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C51C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8862339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9JORaju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfH1W4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46689 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfH1W4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id g185so853927pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xAknKHqXr0xCfYuKxMybFQP6qX0ULDYjjg9JhyAUNI4=;
        b=r9JORajusLEPhUbZ/aCElfnTPC6SOGPOzUW205APcHa8WSO2eLR3RwkNsx1f28w8Do
         qfJMIBpd44p6DGLZSywA7wRF1cXcN5pWJ6s19xSuN29K6qUWJy5P4t32xR3q6Y6y/kbv
         yRt5riE7/WDyBtMCOrT6V0BF1izIKQ4rwqXsWGy6s9ySO3eSjo0pWXE8sJ5CO/zuK+Ct
         wyRaMwlxf9w7J1LChppWxqZgozB55v+OKfeKU6i0lucLfyp0zcuQSWjLu/CNKd3yg7jI
         ahGPGIS4SDQRtrBJGHUvfnGf1gSmJUH23PohDPiuUm9vp4JpKgqaMm9fNMyw5n6q0aFi
         t1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xAknKHqXr0xCfYuKxMybFQP6qX0ULDYjjg9JhyAUNI4=;
        b=DmwkWP8vao9iMy9EulqoKMFC4Gu//UW2NeBviwWQ98nSGhllhMLR7GCweSUeqnZDCg
         pAh9mghPzi4FUcTqh+uBedpejGGXjDwyGjGEVO/KFzrz0zaiE7J/5iNYem7wPCvZtL5G
         /YWLU9BuTH02Ha7fj/24kbRY1WOKB2iqDt8nnTI+ic5F7iTrMlYbGZm1seyidDLbBaJl
         PhmdUwcQfzMfmFabyNrLwKWpt8Q3/P2KdOPRZo19T6zTLwb0VVDBESdCfk4GirjoP6PW
         V9d1cBwxFdPyWhxntX0o/+TFo4uL96vfIxWUZpk/ok/VdVmBrb+XeN4D6KkR5+omaCa5
         sTyA==
X-Gm-Message-State: APjAAAUtNDmpIiz4MPl8qXaHvQgH/0kjx0MuaicuF8RUlL1UuCwk5+u5
        FBYu9syPBkupm7KVfrQMrdUrhOgO6JpGShBUt9U=
X-Google-Smtp-Source: APXvYqzeFFio/F7sx4tTtPoYwhiGamSbwgczDStme+gz+MurQbvPl8MfcUNHBNaInloHe4UFeWwOoIQ/dVV80bA16zk=
X-Received: by 2002:a63:f04:: with SMTP id e4mr5384375pgl.38.1567032988724;
 Wed, 28 Aug 2019 15:56:28 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:33 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-13-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 12/14] include/linux: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Acked-by: Will Deacon <will@kernel.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/cache.h       | 6 +++---
 include/linux/cpu.h         | 2 +-
 include/linux/export.h      | 2 +-
 include/linux/init_task.h   | 4 ++--
 include/linux/interrupt.h   | 5 ++---
 include/linux/sched/debug.h | 2 +-
 include/linux/srcutree.h    | 2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..3f4df9eef1e1 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -28,7 +28,7 @@
  * but may get written to during init, so can't live in .rodata (via "const").
  */
 #ifndef __ro_after_init
-#define __ro_after_init __attribute__((__section__(".data..ro_after_init")))
+#define __ro_after_init __section(.data..ro_after_init)
 #endif
 
 #ifndef ____cacheline_aligned
@@ -45,8 +45,8 @@
 
 #ifndef __cacheline_aligned
 #define __cacheline_aligned					\
-  __attribute__((__aligned__(SMP_CACHE_BYTES),			\
-		 __section__(".data..cacheline_aligned")))
+	__aligned(SMP_CACHE_BYTES)				\
+	__section(.data..cacheline_aligned)
 #endif /* __cacheline_aligned */
 
 #ifndef __cacheline_aligned_in_smp
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fcb1386bb0d4..186bbd79d6ce 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -166,7 +166,7 @@ void cpu_startup_entry(enum cpuhp_state state);
 void cpu_idle_poll_ctrl(bool enable);
 
 /* Attach to any functions which should be considered cpuidle. */
-#define __cpuidle	__attribute__((__section__(".cpuidle.text")))
+#define __cpuidle	__section(.cpuidle.text)
 
 bool cpu_in_idle(unsigned long pc);
 
diff --git a/include/linux/export.h b/include/linux/export.h
index fd8711ed9ac4..808c1a0c2ef9 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -104,7 +104,7 @@ struct kernel_symbol {
  * discarded in the final link stage.
  */
 #define __ksym_marker(sym)	\
-	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
+	static int __ksym_marker_##sym[0] __section(.discard.ksym) __used
 
 #define __EXPORT_SYMBOL(sym, sec)				\
 	__ksym_marker(sym);					\
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 6049baa5b8bc..50139505da34 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -51,12 +51,12 @@ extern struct cred init_cred;
 
 /* Attach to the init_task data structure for proper alignment */
 #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
-#define __init_task_data __attribute__((__section__(".data..init_task")))
+#define __init_task_data __section(.data..init_task)
 #else
 #define __init_task_data /**/
 #endif
 
 /* Attach to the thread_info data structure for proper alignment */
-#define __init_thread_info __attribute__((__section__(".data..init_thread_info")))
+#define __init_thread_info __section(.data..init_thread_info)
 
 #endif
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a99b2a..29debfe4dd0f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -741,8 +741,7 @@ extern int arch_early_irq_init(void);
 /*
  * We want to know which function is an entrypoint of a hardirq or a softirq.
  */
-#define __irq_entry		 __attribute__((__section__(".irqentry.text")))
-#define __softirq_entry  \
-	__attribute__((__section__(".softirqentry.text")))
+#define __irq_entry	__section(.irqentry.text)
+#define __softirq_entry	__section(.softirqentry.text)
 
 #endif
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index 95fb9e025247..e17b66221fdd 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -42,7 +42,7 @@ extern void proc_sched_set_task(struct task_struct *p);
 #endif
 
 /* Attach to any functions which should be ignored in wchan output. */
-#define __sched		__attribute__((__section__(".sched.text")))
+#define __sched		__section(.sched.text)
 
 /* Linker adds these: start and end of __sched functions */
 extern char __sched_text_start[], __sched_text_end[];
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..9de652f4e1bd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -124,7 +124,7 @@ struct srcu_struct {
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
 	struct srcu_struct * const __srcu_struct_##name			\
-		__section("___srcu_struct_ptrs") = &name
+		__section(___srcu_struct_ptrs) = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
-- 
2.23.0.187.g17f5b7556c-goog

