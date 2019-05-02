Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E72206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UFHGOIH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEBOQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:16:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43927 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:16:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id j20so2244596edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6jUhArYSkidgJUMQ6b0WS+/knU0557UDozCsjweJWs=;
        b=UFHGOIH302CnF6JpJHIaEB1nf04/eQzLwfnVDas8dsLvkpH29rOZVhgNglnFzzidu+
         M+Q97vTxbRGNzagU9B9kO8u/k0UXJmpNv9q5YEker0ICoHosdbgAOU9MzI71il1E6+BL
         mkIqvJeR+HAAxcxDhaXSmlYAMDuR0qNgj5CFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6jUhArYSkidgJUMQ6b0WS+/knU0557UDozCsjweJWs=;
        b=TGPqXmiKRYWQ6++nuE91lk8Uk5ooeXsPDmYqmtL8WiKjdvcvWjr5rmU4yNO0t4T4qj
         b851uLAha2kdDpmQ7MK1pvvZsfTvO/Q7EDMR8YA8B/aH/URizadu4IJJWBgzRQ7/UxLp
         LZGuasA95d0j1my5GUiRdimFIhfEEq5vuyGZasQ8njaXf21qvqAmpB+ak2dqFjkWQnh3
         OigXj+5eZ8n3qXHnzhDFIPAt2ImnpS8N+MRmY+QWGkPjhOdMuhIY3MMTr573bFUZpejS
         nfTZTBs5sna3c4gC6Sjryjusmpvbp+PjvipTUcoBepHiw1S7sxxCYtkTHD6fRGachH+k
         8Q/g==
X-Gm-Message-State: APjAAAUc/04rL+yFxNEeyLUfU84R5M1WynoMETOl+zGx7aWC4gB/OdrT
        e1WFs/ZZ5Q6yhz/Yfqj0HWA7bo+whZc=
X-Google-Smtp-Source: APXvYqwzjvqcm5mLeQ58eJqQE74D+fxLzITraKbx389wNBvLg+qlVeqNsgPzBKf/xRqh3fnu5xr+Sw==
X-Received: by 2002:a17:906:65d4:: with SMTP id z20mr1979407ejn.38.1556806610779;
        Thu, 02 May 2019 07:16:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r24sm5339705ejo.84.2019.05.02.07.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:16:49 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: console: hack up console_trylock more
Date:   Thu,  2 May 2019 16:16:43 +0200
Message-Id: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
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

Fix this by creating a __down_trylock which only trylocks the
semaphore.lock. This isn't correct in full generality, but good enough
for console_lock:

- there's only ever one console_lock holder, we won't fail spuriously
  because someone is doing a down() or up() while there's still room
  (unlike other semaphores with count > 1).

- console_unlock() has one massive retry loop, which will catch anyone
  who races the trylock against the up(). This makes sure that no
  printk lines will get lost. Making the trylock more racy therefore
  has no further impact.

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
 include/linux/semaphore.h  |  1 +
 kernel/locking/semaphore.c | 33 +++++++++++++++++++++++++++++++++
 kernel/printk/printk.c     |  2 +-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 11c86fbfeb98..82f6db6121c3 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -40,6 +40,7 @@ extern void down(struct semaphore *sem);
 extern int __must_check down_interruptible(struct semaphore *sem);
 extern int __must_check down_killable(struct semaphore *sem);
 extern int __must_check down_trylock(struct semaphore *sem);
+extern int __must_check __down_trylock(struct semaphore *sem);
 extern int __must_check down_timeout(struct semaphore *sem, long jiffies);
 extern void up(struct semaphore *sem);
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 561acdd39960..345123336019 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -143,6 +143,39 @@ int down_trylock(struct semaphore *sem)
 }
 EXPORT_SYMBOL(down_trylock);
 
+/**
+ * __down_trylock - try to acquire the semaphore, without any locking
+ * @sem: the semaphore to be acquired
+ *
+ * Try to acquire the semaphore atomically.  Returns 0 if the semaphore has
+ * been acquired successfully or 1 if it it cannot be acquired.
+ *
+ * NOTE: This return value is inverted from both spin_trylock and
+ * mutex_trylock!  Be careful about this when converting code.
+ *
+ * Unlike mutex_trylock, this function can be used from interrupt context,
+ * and the semaphore can be released by any task or interrupt.
+ *
+ * WARNING: Unlike down_trylock this function doesn't guarantee that that the
+ * semaphore will be acquired if it could, it's best effort only. Use for
+ * down_trylock_console_sem only.
+ */
+int __down_trylock(struct semaphore *sem)
+{
+	unsigned long flags;
+	int count;
+
+	if (!raw_spin_trylock_irqsave(&sem->lock, flags))
+		return 1;
+	count = sem->count - 1;
+	if (likely(count >= 0))
+		sem->count = count;
+	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	return (count < 0);
+}
+EXPORT_SYMBOL(__down_trylock);
+
 /**
  * down_timeout - acquire the semaphore within a specified time
  * @sem: the semaphore to be acquired
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..5293803eec1f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -217,7 +217,7 @@ static int __down_trylock_console_sem(unsigned long ip)
 	 * deadlock in printk()->down_trylock_console_sem() otherwise.
 	 */
 	printk_safe_enter_irqsave(flags);
-	lock_failed = down_trylock(&console_sem);
+	lock_failed = __down_trylock(&console_sem);
 	printk_safe_exit_irqrestore(flags);
 
 	if (lock_failed)
-- 
2.20.1

