Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC8320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gGMfxi+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfD2SdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:33:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:33:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIVEta1026987
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:31:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIVEta1026987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562676;
        bh=djka8r8Z7z+gPG3hzLCJZGz5GUvcSM5b42fHLRRYAWw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gGMfxi+SJiaIpRR7/RHSf7kOTXp3cOUmzFn6kDRbjbyMmQrI+i/ci4BXrKLkZUMXv
         nNkysst9crERgqvI69KiZnICyGKKb4YkoDDFeunb2ySHlNUNvexmjoVHVlEzgyyDWn
         c0lLUN4ZDYoHjKqVzhfv9QSRXTIgb8XDzPqxpxjNUr7GMJ6E5vD1d/Hiy/b3DyPC+8
         pXFDyMm2a6GRsjPPfkN+hy5rkOvd9A8sl24FkZiay7gqBDHSdPAcy3ajGrmu41YqGk
         mZr4l5pPQEYp73f/fSGAbaa99TYv0Mw+FrOd5RD9aGBU3RP4NEP1zhZJj1GTs+hyJY
         khReLU79wu0iQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIVBAK1026981;
        Mon, 29 Apr 2019 11:31:11 -0700
Date:   Mon, 29 Apr 2019 11:31:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3d9a8072915366b5932beeed97f158f8d4955768@git.kernel.org>
Cc:     snitzer@redhat.com, rientjes@google.com, robin.murphy@arm.com,
        cl@linux.com, airlied@linux.ie, rppt@linux.vnet.ibm.com,
        maarten.lankhorst@linux.intel.com, jthumshirn@suse.de,
        catalin.marinas@arm.com, daniel@ffwll.ch, dsterba@suse.com,
        jani.nikula@linux.intel.com, rostedt@goodmis.org, agk@redhat.com,
        tom.zanussi@linux.intel.com, mingo@kernel.org,
        akinobu.mita@gmail.com, penberg@kernel.org,
        m.szyprowski@samsung.com, rodrigo.vivi@intel.com, clm@fb.com,
        aryabinin@virtuozzo.com, tglx@linutronix.de,
        akpm@linux-foundation.org, mbenes@suse.cz, glider@google.com,
        dvyukov@google.com, luto@kernel.org,
        joonas.lahtinen@linux.intel.com, adobriyan@gmail.com,
        hpa@zytor.com, josef@toxicpanda.com, hch@lst.de,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com
Reply-To: catalin.marinas@arm.com, dsterba@suse.com, daniel@ffwll.ch,
          jani.nikula@linux.intel.com, rostedt@goodmis.org, agk@redhat.com,
          snitzer@redhat.com, rientjes@google.com, robin.murphy@arm.com,
          cl@linux.com, rppt@linux.vnet.ibm.com, airlied@linux.ie,
          maarten.lankhorst@linux.intel.com, jthumshirn@suse.de,
          aryabinin@virtuozzo.com, tglx@linutronix.de,
          akpm@linux-foundation.org, mbenes@suse.cz, dvyukov@google.com,
          glider@google.com, luto@kernel.org,
          joonas.lahtinen@linux.intel.com, hpa@zytor.com,
          adobriyan@gmail.com, josef@toxicpanda.com, hch@lst.de,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          mingo@kernel.org, tom.zanussi@linux.intel.com,
          akinobu.mita@gmail.com, penberg@kernel.org,
          m.szyprowski@samsung.com, rodrigo.vivi@intel.com, clm@fb.com
In-Reply-To: <20190425094801.230654524@linutronix.de>
References: <20190425094801.230654524@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Cleanup stack trace code
Git-Commit-ID: 3d9a8072915366b5932beeed97f158f8d4955768
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3d9a8072915366b5932beeed97f158f8d4955768
Gitweb:     https://git.kernel.org/tip/3d9a8072915366b5932beeed97f158f8d4955768
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:46 +0200

tracing: Cleanup stack trace code

- Remove the extra array member of stack_dump_trace[] along with the
  ARRAY_SIZE - 1 initialization for struct stack_trace :: max_entries.

  Both are historical leftovers of no value. The stack tracer never exceeds
  the array and there is no extra storage requirement either.

- Make variables which are only used in trace_stack.c static.

- Simplify the enable/disable logic.

- Rename stack_trace_print() as it's using the stack_trace_ namespace. Free
  the name up for stack trace related functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094801.230654524@linutronix.de

---
 include/linux/ftrace.h     | 18 ++++--------------
 kernel/trace/trace_stack.c | 42 +++++++++++++-----------------------------
 2 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 730876187344..20899919ead8 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -241,21 +241,11 @@ static inline void ftrace_free_mem(struct module *mod, void *start, void *end) {
 
 #ifdef CONFIG_STACK_TRACER
 
-#define STACK_TRACE_ENTRIES 500
-
-struct stack_trace;
-
-extern unsigned stack_trace_index[];
-extern struct stack_trace stack_trace_max;
-extern unsigned long stack_trace_max_size;
-extern arch_spinlock_t stack_trace_max_lock;
-
 extern int stack_tracer_enabled;
-void stack_trace_print(void);
-int
-stack_trace_sysctl(struct ctl_table *table, int write,
-		   void __user *buffer, size_t *lenp,
-		   loff_t *ppos);
+
+int stack_trace_sysctl(struct ctl_table *table, int write,
+		       void __user *buffer, size_t *lenp,
+		       loff_t *ppos);
 
 /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
 DECLARE_PER_CPU(int, disable_stack_tracer);
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c6e54ff25cae..4efda5f75a0f 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -18,30 +18,26 @@
 
 #include "trace.h"
 
-static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES + 1];
-unsigned stack_trace_index[STACK_TRACE_ENTRIES];
+#define STACK_TRACE_ENTRIES 500
+
+static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
+static unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
-/*
- * Reserve one entry for the passed in ip. This will allow
- * us to remove most or all of the stack size overhead
- * added by the stack tracer itself.
- */
 struct stack_trace stack_trace_max = {
-	.max_entries		= STACK_TRACE_ENTRIES - 1,
+	.max_entries		= STACK_TRACE_ENTRIES,
 	.entries		= &stack_dump_trace[0],
 };
 
-unsigned long stack_trace_max_size;
-arch_spinlock_t stack_trace_max_lock =
+static unsigned long stack_trace_max_size;
+static arch_spinlock_t stack_trace_max_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 DEFINE_PER_CPU(int, disable_stack_tracer);
 static DEFINE_MUTEX(stack_sysctl_mutex);
 
 int stack_tracer_enabled;
-static int last_stack_tracer_enabled;
 
-void stack_trace_print(void)
+static void print_max_stack(void)
 {
 	long i;
 	int size;
@@ -61,16 +57,7 @@ void stack_trace_print(void)
 	}
 }
 
-/*
- * When arch-specific code overrides this function, the following
- * data should be filled up, assuming stack_trace_max_lock is held to
- * prevent concurrent updates.
- *     stack_trace_index[]
- *     stack_trace_max
- *     stack_trace_max_size
- */
-void __weak
-check_stack(unsigned long ip, unsigned long *stack)
+static void check_stack(unsigned long ip, unsigned long *stack)
 {
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
 	static int tracer_frame;
@@ -179,7 +166,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	stack_trace_max.nr_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
-		stack_trace_print();
+		print_max_stack();
 		BUG();
 	}
 
@@ -412,23 +399,21 @@ stack_trace_sysctl(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp,
 		   loff_t *ppos)
 {
+	int was_enabled;
 	int ret;
 
 	mutex_lock(&stack_sysctl_mutex);
+	was_enabled = !!stack_tracer_enabled;
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
-	if (ret || !write ||
-	    (last_stack_tracer_enabled == !!stack_tracer_enabled))
+	if (ret || !write || (was_enabled == !!stack_tracer_enabled))
 		goto out;
 
-	last_stack_tracer_enabled = !!stack_tracer_enabled;
-
 	if (stack_tracer_enabled)
 		register_ftrace_function(&trace_ops);
 	else
 		unregister_ftrace_function(&trace_ops);
-
  out:
 	mutex_unlock(&stack_sysctl_mutex);
 	return ret;
@@ -444,7 +429,6 @@ static __init int enable_stacktrace(char *str)
 		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
 
 	stack_tracer_enabled = 1;
-	last_stack_tracer_enabled = 1;
 	return 1;
 }
 __setup("stacktrace", enable_stacktrace);
