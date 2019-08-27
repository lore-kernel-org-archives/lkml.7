Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9bA6RYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfH0UlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:41:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41672 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbfH0UlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:41:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so224090pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c85yaSBCcgJs92ECoOpY1wTN4fvezGR1R2LzkXxYTJA=;
        b=X9bA6RYW3SmopxTVDf41RMh8cJZOXKHPd+G3Ugca/TkoK4ngGJYO+ZJp13UVO7qDxT
         203FNJAVQqt719AEzD96jSoIuXdjHvGJlWDIqyE+jltbjJhA8hCd4jnui2w7P1Xcj/3f
         S9hj/lL2roLibcJ26l3c+yUCJFJ8I0Unkk+n5pRVbCUr5T16FTzx8KnQYZhjvvJGTaig
         z9uDAtJKZJQBonhsXPO+5D0T9YwTshQeTzFRM04y348tbRlpdWL9OYvUkW7ttsH3ZWNm
         HSIronvBHUvTuEAJoF0ua6CAYFRuM9K1qzXufDDTSFuf6P4x0Yc8D5C6hix4fdjYsgE1
         +aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c85yaSBCcgJs92ECoOpY1wTN4fvezGR1R2LzkXxYTJA=;
        b=sNns4zhwCAv8l/9/bA/g5zlFNCL3Snvrzrc9tlHnhqsM5d9dZx7pdjBANLaq3MpUqp
         fGvUWDE9BSA5qz3YeXAq3sq1im+FF3GLQ3TcWtpaUuiE2s6PlLMINvmM+04hJt4szqIU
         Cr+rhujul9JWpdkYjfdh1jkwFVyFHV37iDK+QCJYILUUFsBx7xKURhD1IqbymORujCV2
         SZz+253F89BmsUsaQArpQyPPhv4gaC1IIh2RCwSAT38ZTbCGtWttUTjzOgBB9kx4doSD
         mBetULOTSn11Ks3DbgeaUSNkDdzh8hjn0nL+n20pH/iL+MEJ55kzNWWM+9NepB/h9S64
         fpDQ==
X-Gm-Message-State: APjAAAUmRT8VaczpF3Hd937t2LfzrNqdK8UbNkskrAcJpp0NWG5iclVF
        nyhA+uaDrcL+z35SHLOMcfP7J2wZboazXZ3f5sk=
X-Google-Smtp-Source: APXvYqw7PQLgNWPjDJWwMVHsbcxdyo3jDvyj6QI+64H142EjniePe3uhwBBmfiWehPkcVNLd6q4evavOhSJQoMPbnjg=
X-Received: by 2002:a65:6815:: with SMTP id l21mr312139pgt.146.1566938460536;
 Tue, 27 Aug 2019 13:41:00 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:05 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-13-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 12/14] include/linux: prefer __section from compiler_attributes.h
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
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
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

