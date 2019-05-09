Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB642C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C6D2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Hjg39OzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfEIUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:06:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEIUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:06:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so3156408edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eMy81xQoynkvOjZ8yVubZa7SulddFEJzBcPEPrFGYQ=;
        b=Hjg39OzW1Svgec3a5DZNVclKDdeN2jAcbw2Ff17kMPtzSfVdFVjOOMpVM+8pvd/y1G
         GxzIE6WCwJDU7oO3C++iCeBly3eLKVezmFRH1W8G4HRxbWQVnSyyEVMFWFeojqEva+ls
         hsUSstHf3wZDSxBqOGTWOfE536dkZ5+uGGC4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eMy81xQoynkvOjZ8yVubZa7SulddFEJzBcPEPrFGYQ=;
        b=ZtcX+wDwvBmf0p63paOVVdRvEUdvHKI7i7277Z1uql1tTuFwV710+6timfPIebAPal
         YpMliHpeLCcpPOZnu7kkZPOHyXqaKdZK+rYzdztQZf/LGZHmzYhACrIxc8hfCjvQK9vC
         fwYkqGl+6NLrakS9EmxuDu0Acb04VO0XSDKSsevLGi0CyF2U2MZg/1L7EFEMe6o9S6VG
         Z03MO+AQvwH5ewU6hV3dsjCQATvutwfjQY12O/f/JWwXsV8WLC8iRDcIjr4sNQn7nh19
         neM8HEZFslDpuLQ/3LlKLNOHVQRmuKyBsoMXrAEq/1qEJ3vJ6d1ozjZB/49NVaRcIj2d
         4IBA==
X-Gm-Message-State: APjAAAXFbB2gTwYrYXU9uxMwx2FC0IvkrKdgEefKZHWUPo8dNLcEPs7m
        QXdZdYx8gSuC/+Q8M3wUwVsSsA==
X-Google-Smtp-Source: APXvYqxj4+2Mrt199n9RPZfirgO2cTGlKahmfW3rytPUch4MQ27eM7Nxv4JvVHynhY78CelcoZKfCw==
X-Received: by 2002:a50:a5ed:: with SMTP id b42mr6126084edc.178.1557432399557;
        Thu, 09 May 2019 13:06:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x30sm813241edd.74.2019.05.09.13.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:06:38 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/locking/semaphore: use wake_q in up()
Date:   Thu,  9 May 2019 22:06:33 +0200
Message-Id: <20190509200633.19678-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
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

Fix this specific locking recursion by moving the wake_up_process out
from under the semaphore.lock spinlock, using wake_q as recommended by
Peter Zijlstra.

As Petr Mladek points out this doesn't fix all the locking recursions
in this area. If we actually recursive in the above callchain:

      + try_to_wake_up()    # takes p->pi_lock
        + ttwu_remote()     # takes rq lock
          + ttwu_do_wakeup()
            + check_preempt_curr()
              + native_smp_send_reschedule()
                + __warn_printk()
                  + printk()
                    + vprintk_emit()
                      + console_trylock() # success
                      + console_unlock()
                        + up_console_sem()
                          + up() # wait list in not empty
                            + __up()
                              + wake_up_process()
                                + try_to_wake_up()

Then there's any number of scheduler related locks will deadlock.
Given that the kernel is dying already (the printk() in
native_smp_send_reschedule() happens because we run on an offlined
CPU) I think there's limited value in trying to fix this:

- We haven't seen the actual deadlock in our CI, only lockdep
  complaining about the possibility.

- The real issue is that the lockdep splat hides useful dmesg
  information we capture in e.g. pstore or on screen about the real
  cause of why the kernel is dying.

- The console_unlock in the above callchain should have managed to get
  all the dmesg up to that point out already. Dying later on is
  somewhat ok - I've only seen this lockdep splat in pstore when the
  machine died anyway.

Also cc'ing John Ogness since perhaps his printk rework fixes this all
properly.

v2: Ditch attempt to fix console_trylock.

v3: Add a comment explaining why the taks we're waking won't
disappear (Chris), and improve commit message to address review
questions.

v4: Use wake_q (Peter Z).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 kernel/locking/semaphore.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 561acdd39960..7a6f33715688 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,12 +33,12 @@
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
+#include <linux/sched/wake_q.h>
 
 static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
 
 /**
  * down - acquire the semaphore
@@ -169,6 +169,14 @@ int down_timeout(struct semaphore *sem, long timeout)
 }
 EXPORT_SYMBOL(down_timeout);
 
+/* Functions for the contended case */
+
+struct semaphore_waiter {
+	struct list_head list;
+	struct task_struct *task;
+	bool up;
+};
+
 /**
  * up - release the semaphore
  * @sem: the semaphore to release
@@ -179,24 +187,25 @@ EXPORT_SYMBOL(down_timeout);
 void up(struct semaphore *sem)
 {
 	unsigned long flags;
+	struct semaphore_waiter *waiter;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(list_empty(&sem->wait_list)))
+	if (likely(list_empty(&sem->wait_list))) {
 		sem->count++;
-	else
-		__up(sem);
+	} else {
+		waiter =  list_first_entry(&sem->wait_list,
+					   struct semaphore_waiter, list);
+		list_del(&waiter->list);
+		waiter->up = true;
+		wake_q_add(&wake_q, waiter->task);
+	}
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
-/* Functions for the contended case */
-
-struct semaphore_waiter {
-	struct list_head list;
-	struct task_struct *task;
-	bool up;
-};
-
 /*
  * Because this function is inlined, the 'state' parameter will be
  * constant, and thus optimised away by the compiler.  Likewise the
@@ -252,12 +261,3 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 {
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
-
-static noinline void __sched __up(struct semaphore *sem)
-{
-	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
-						struct semaphore_waiter, list);
-	list_del(&waiter->list);
-	waiter->up = true;
-	wake_up_process(waiter->task);
-}
-- 
2.20.1

