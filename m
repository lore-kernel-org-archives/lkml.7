Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1909C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E7E206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g+Rj6lZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEFHqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:46:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46015 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEFHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:46:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so14220879edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04n4bi/0il+bPmWqsIQ2e+x6fvuMJP2MziNsJbLuWN4=;
        b=g+Rj6lZOq58m6EpuhkaGKAgELBYFqZayO0UVs6XuXjcKuZ9wZW696L0FAvqpvsC3Sz
         5LdY6QKVhDTtVGSkx4p7OhAoLS9tQxxHKqNASJ6XRM523im0HjxD4QMpKJJbxL6qls2A
         COWjAYliGJcM4AvajlOKV2UoIpFu9r95F/qBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04n4bi/0il+bPmWqsIQ2e+x6fvuMJP2MziNsJbLuWN4=;
        b=IhZzFIyoOrub0Jcd9EjvTwrCDRWxtDC/eila+1wB+W9Gx2qoVMPfQ4jXoXquHGFNnk
         5eMMIPTUWQj6daYk8OIcgViJ7Mv1Q6/9NOiQNUEBMMnMM45FF81zvaiaD9h+DpyluKO3
         ZLP33mrrAS95Ydc6tyrnnxAXvdmPTKi7Jx+fbgXH9iVeKWS0/O/rAjBPv7KSSujlZsLd
         mFHKcCp07AFJSJPJ2mmm0isQlUbXme6VOOYNdycFkI4UeT9bBWNKRNV8/FjDxpuepfyD
         +yfdQkwXCc/BUZJ2Bgk5oBFMYmdHHjz5moqFy42L2gBy8GZN36WlscR+XMxevfE7q1Wt
         G3dA==
X-Gm-Message-State: APjAAAXP4kXu3EYsPwxdS2DoR37UeME/9RVyJsvJsgNd6bt+OVXqpzNe
        p7xopgQ0NtqB+NHy/sL2gjruGw==
X-Google-Smtp-Source: APXvYqzon9mPPFB9xFLuZ56pH3fApyh6Ek73kjZdssOe6Nvobk9Y3fKvc1cQgXfVibqPEzhGE6bNeA==
X-Received: by 2002:a50:8bbb:: with SMTP id m56mr24893171edm.230.1557128759478;
        Mon, 06 May 2019 00:45:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z11sm1451872ejo.45.2019.05.06.00.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 00:45:58 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: console: hack up console_lock more v2
Date:   Mon,  6 May 2019 09:45:53 +0200
Message-Id: <20190506074553.21464-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

console_trylock, called from within printk, can be called from pretty
much anywhere. Including try_to_wake_up. Note that this isn't common,
usually the box is in pretty bad shape at that point already. But it
really doesn't help when then lockdep jumps in and spams the logs,
potentially obscuring the real backtrace we're really interested in.
One case I've seen (slightly simplified backtrace):

 Call Trace:
  <IRQ>
  console_trylock+0xe/0x60
  vprintk_emit+0xf1/0x320
  printk+0x4d/0x69
  __warn_printk+0x46/0x90
  native_smp_send_reschedule+0x2f/0x40
  check_preempt_curr+0x81/0xa0
  ttwu_do_wakeup+0x14/0x220
  try_to_wake_up+0x218/0x5f0
  pollwake+0x6f/0x90
  credit_entropy_bits+0x204/0x310
  add_interrupt_randomness+0x18f/0x210
  handle_irq+0x67/0x160
  do_IRQ+0x5e/0x130
  common_interrupt+0xf/0xf
  </IRQ>

This alone isn't a problem, but the spinlock in the semaphore is also
still held while waking up waiters (up() -> __up() -> try_to_wake_up()
callchain), which then closes the runqueue vs. semaphore.lock loop,
and upsets lockdep, which issues a circular locking splat to dmesg.
Worse it upsets developers, since we don't want to spam dmesg with
clutter when the machine is dying already.

Fix this by creating a prinkt_safe_up() which calls wake_up_process
outside of the spinlock. This isn't correct in full generality, but
good enough for console_lock:

- console_lock doesn't use interruptible or killable or timeout down()
  calls, hence an up() is the only thing that can wake up a process.
  Hence the process can't get woken and killed and reaped while we try
  to wake it up too.

- semaphore.c always updates the waiter list while under the spinlock,
  so there's no other races. Specifically another process that races
  with a quick console_lock/unlock while we've dropped the spinlock
  already won't see our own waiter.

Also cc'ing John Ogness since perhaps his printk rework fixes this all
properly.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
v2: My first attempt at patching down_trylock didn't work (thanks to
Petr for pointing out), now try to have a special up() that breaks the
cycle.
-Daniel
---
 include/linux/semaphore.h  |  1 +
 kernel/locking/semaphore.c | 31 +++++++++++++++++++++++++++++++
 kernel/printk/printk.c     |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 11c86fbfeb98..7e839c72809d 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -41,6 +41,7 @@ extern int __must_check down_interruptible(struct semaphore *sem);
 extern int __must_check down_killable(struct semaphore *sem);
 extern int __must_check down_trylock(struct semaphore *sem);
 extern int __must_check down_timeout(struct semaphore *sem, long jiffies);
+extern void printk_safe_up(struct semaphore *sem);
 extern void up(struct semaphore *sem);
 
 #endif /* __LINUX_SEMAPHORE_H */
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 561acdd39960..84675993dc59 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -197,6 +197,37 @@ struct semaphore_waiter {
 	bool up;
 };
 
+/**
+ * printk_safe_up - release the semaphore in console_unlock
+ * @sem: the semaphore to release
+ *
+ * Release the semaphore.  Unlike mutexes, up() may be called from any
+ * context and even by tasks which have never called down().
+ *
+ * NOTE: This is a special version of up() for console_unlock only. It is only
+ * safe if there are no killable, interruptible or timing out down() calls.
+ */
+void printk_safe_up(struct semaphore *sem)
+{
+	unsigned long flags;
+	struct semaphore_waiter *waiter = NULL;
+
+	raw_spin_lock_irqsave(&sem->lock, flags);
+	if (likely(list_empty(&sem->wait_list))) {
+		sem->count++;
+	} else {
+		waiter = list_first_entry(&sem->wait_list,
+					  struct semaphore_waiter, list);
+		list_del(&waiter->list);
+		waiter->up = true;
+	}
+	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	if (waiter)
+		wake_up_process(waiter->task);
+}
+EXPORT_SYMBOL(printk_safe_up);
+
 /*
  * Because this function is inlined, the 'state' parameter will be
  * constant, and thus optimised away by the compiler.  Likewise the
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..62303929afda 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -234,7 +234,7 @@ static void __up_console_sem(unsigned long ip)
 	mutex_release(&console_lock_dep_map, 1, ip);
 
 	printk_safe_enter_irqsave(flags);
-	up(&console_sem);
+	printk_safe_up(&console_sem);
 	printk_safe_exit_irqrestore(flags);
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
-- 
2.20.1

