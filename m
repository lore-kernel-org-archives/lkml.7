Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0EAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9B0217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fpCVJsMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfEUOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:47:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33362 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfEUOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:47:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so29871244edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORiID9Ap1Ob1uAeKkaBEOgmrOkRFTz441mfPcwfeVdo=;
        b=fpCVJsMGbVo4GpzstOvt8j2+d91/EMWbNCdaBUHhz7PfDrfsbmYFj936b3DTgwnHL3
         2uoQ8oWlpW6PBeEvByLI+hamcbjZf/Bd92NU6WxXZvOa1xc2hvdotOLIYpZEj3rogl8X
         NhpXPJa4dNEj21vwsB5tLPXadJz1t4Y0lktR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORiID9Ap1Ob1uAeKkaBEOgmrOkRFTz441mfPcwfeVdo=;
        b=F3E0sGbOrg9JGe+rIUt8bQpjqRnegM3/Zeh67d89N8Mj1U0IGe5WM6yN6PsutKcLeS
         8bFlT3o9ItUMI86gCNHOUPlxvG+BgM+GUwBr8gNuSx8bhUScU9aG0MYsA6XFjO9rsGJR
         AacxQ5V0fQeAK1DV5x6LCJmtdjjttDR4KtnQFvuO7XpaVWhTpECexJvTN7iAo8FNwbHS
         rQ8KlrR0CdWXv8qtDe/VDqa9wJswD4McIzlwQsqNdZykcnJH665RrxRF1EV9EYV3psx4
         rFC0aaO2aD6xdgZRPGlP5HwGJWXaAIoT0pTlM1mDGGHYUAZdpqujD9ibEOgR72zIoywG
         3k4Q==
X-Gm-Message-State: APjAAAVnjOCDM/Ld3l3rzaKUSvFF5qv5fFxGJQZEoFXc9QE6dtUPU41O
        JrvfblSlXXU69kr8eMEUx7/m3w==
X-Google-Smtp-Source: APXvYqxERFtQFlyIJ7giopEydDDWTX5kk1Gf0ci+hNclUSwmbRui3nZHrUHxGCfgmxEnBmWtycq59A==
X-Received: by 2002:a50:896a:: with SMTP id f39mr82284940edf.293.1558450070057;
        Tue, 21 May 2019 07:47:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p27sm3510990ejf.65.2019.05.21.07.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:47:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] kernel.h: Add non_block_start/end()
Date:   Tue, 21 May 2019 16:47:43 +0200
Message-Id: <20190521144743.6895-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520213945.17046-2-daniel.vetter@ffwll.ch>
References: <20190520213945.17046-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some special cases we must not block, but there's not a
spinlock, preempt-off, irqs-off or similar critical section already
that arms the might_sleep() debug checks. Add a non_block_start/end()
pair to annotate these.

This will be used in the oom paths of mmu-notifiers, where blocking is
not allowed to make sure there's forward progress. Quoting Michal:

"The notifier is called from quite a restricted context - oom_reaper -
which shouldn't depend on any locks or sleepable conditionals. The code
should be swift as well but we mostly do care about it to make a forward
progress. Checking for sleepable context is the best thing we could come
up with that would describe these demands at least partially."

Peter also asked whether we want to catch spinlocks on top, but Michal
said those are less of a problem because spinlocks can't have an
indirect dependency upon the page allocator and hence close the loop
with the oom reaper.

Suggested by Michal Hocko.

v2:
- Improve commit message (Michal)
- Also check in schedule, not just might_sleep (Peter)

v3: It works better when I actually squash in the fixup I had lying
around :-/

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wei Wang <wvw@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/kernel.h | 10 +++++++++-
 include/linux/sched.h  |  4 ++++
 kernel/sched/core.c    | 19 ++++++++++++++-----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 74b1ee9027f5..b5f2c2ff0eab 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -214,7 +214,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
  * might_sleep - annotation for functions that can sleep
  *
  * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...).
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
  *
  * This is a useful debugging help to be able to catch problems early and not
  * be bitten later when the calling function happens to sleep when it is not
@@ -230,6 +232,10 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define cant_sleep() \
 	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
+# define non_block_start() \
+	do { current->non_block_count++; } while (0)
+# define non_block_end() \
+	do { WARN_ON(current->non_block_count-- == 0); } while (0)
 #else
   static inline void ___might_sleep(const char *file, int line,
 				   int preempt_offset) { }
@@ -238,6 +244,8 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
 # define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
 #endif
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..7f5b293e72df 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -908,6 +908,10 @@ struct task_struct {
 	struct mutex_waiter		*blocked_on;
 #endif
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	int				non_block_count;
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int			irq_events;
 	unsigned long			hardirq_enable_ip;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..ed7755a28465 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3264,13 +3264,22 @@ static noinline void __schedule_bug(struct task_struct *prev)
 /*
  * Various schedule()-time debugging checks and statistics:
  */
-static inline void schedule_debug(struct task_struct *prev)
+static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
 	if (task_stack_end_corrupted(prev))
 		panic("corrupted stack end detected inside scheduler\n");
 #endif
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	if (!preempt && prev->state && prev->non_block_count) {
+		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
+			prev->comm, prev->pid, prev->non_block_count);
+		dump_stack();
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+#endif
+
 	if (unlikely(in_atomic_preempt_off())) {
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
@@ -3377,7 +3386,7 @@ static void __sched notrace __schedule(bool preempt)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK))
 		hrtick_clear(rq);
@@ -6102,7 +6111,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 	rcu_sleep_check();
 
 	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
-	     !is_idle_task(current)) ||
+	     !is_idle_task(current) && !current->non_block_count) ||
 	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
 		return;
@@ -6118,8 +6127,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
 		"BUG: sleeping function called from invalid context at %s:%d\n",
 			file, line);
 	printk(KERN_ERR
-		"in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
-			in_atomic(), irqs_disabled(),
+		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
+			in_atomic(), irqs_disabled(), current->non_block_count,
 			current->pid, current->comm);
 
 	if (task_stack_end_corrupted(current))
-- 
2.20.1

