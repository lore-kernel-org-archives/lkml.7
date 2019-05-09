Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48FF20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U4lWH3eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEIMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:09:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33440 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:09:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so1829977edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izuW0WNa96R8N+iy6p0UdDercxEPAtv8yqEdooTmbYE=;
        b=U4lWH3eJOpAsvj58mxXHPpMtRfisBHitmT6mFOFWr/3ksRQiQm+Hsu36wTr/igC5yN
         /PPIy8CnryRK9hwpLLPYKnL9h3uqh1UirlV2HvbBTlfqczkYNmuoyT3bpF41c803ZgcC
         AFXC9pr+uuGtOw8ytjHHmeuB0cmQl5OgEzkXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izuW0WNa96R8N+iy6p0UdDercxEPAtv8yqEdooTmbYE=;
        b=j7qX+040L3ASaENyBguvPbtCOChzy69Gu6YsbkqSpKZOD3oTrz3VkAz1uoMdAsY4ya
         aIBVeVoQAHPYKLpAudV3MliFIR1mFDnusVxqeNSbGFJE2LehJbknX0jl6i3hR3qFJD/D
         C3uCYMGZL+H7Y757samFJYgPfmMjYsoC9V6xRm0htg8wyy47y2uvdmgDF90ZGh5RKPKp
         vgU3tTACfdcRxwNU3vNVY7mzqbQwR6ZnRcAxIA01qagOkWOoWkHRu9qrD7JWoUsbmDER
         YtRswSsiUg+V6QTWGv+UwAfy6j9nqKScIQg0/+Y67iTectm5YDdSrmm8cezPZDLMkaOE
         3IOQ==
X-Gm-Message-State: APjAAAW54OaFyaAfe7Q0UCZ6voOzFpn9Oe6N4nlU1sBzx/Q9HslN9oa3
        c1T613Bdd6UnxKzdqkUjrFOCtg==
X-Google-Smtp-Source: APXvYqwcwgvTfdphrsa3kEoaNQEIBDMhqSu5+txfEoivDIHjwl+D0rUvKi5h5/fyf2hFHFwq+rK2qA==
X-Received: by 2002:a17:906:7b58:: with SMTP id n24mr2925648ejo.224.1557403750029;
        Thu, 09 May 2019 05:09:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d90sm531586edd.69.2019.05.09.05.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 05:09:09 -0700 (PDT)
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
Subject: [PATCH] RFC: console: hack up console_lock more v3
Date:   Thu,  9 May 2019 14:09:03 +0200
Message-Id: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
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

Note that we only have to break the recursion for the semaphore.lock
spinlock of the console_lock. Recursion within various scheduler
related locks is already prevented by the printk_safe_enter/exit pair
in __up_console_sem().

Also cc'ing John Ogness since perhaps his printk rework fixes this all
properly.

v2: Ditch attempt to fix console_trylock.

v3: Add a comment explaining why the taks we're waking won't
disappear (Chris), and improve commit message to address review
questions.

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
index 561acdd39960..55a896f18d91 100644
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
+	if (waiter) /* protected by being sole wake source */
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

