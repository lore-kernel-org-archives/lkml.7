Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FEB206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IRecT2OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEGRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:33:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36754 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfEGRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:33:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so19517475edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By/YTXwruc5w+T+z2pt0ueyq600FZNbXB/6wgpzCllU=;
        b=IRecT2OKkFRfFRAye0IddpuN/wdrWMSDOiynnDPnjXt+OWBDhneVqcyps+1EqtnwgT
         fN4V1Ew1Op754Jx9OKCQdNdJWJcGkSbHNu7qqLhW0O+x9DWI7fXcFc37xfCiEw+vjMKp
         NEv4eY8gAUDK+kSzUpb5MkeVLzQERFgu4sTxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By/YTXwruc5w+T+z2pt0ueyq600FZNbXB/6wgpzCllU=;
        b=dVoIWMNBJtWYgJoO84ePWFJqXGK6mxFNW7jBKwW74rrirXhkUS7z5g9CXOYen2OdYT
         dE7nVy2iJxWHdrcbhaxiEeei2K32OFWl5QqvaY/TcWq9JKdfGHzG0h8co+qit661S7V0
         OifrMJwqvzb+Oh/nghlZJXEKgIPTJRj3ILilTTHJn+uQ2G0arFM4uGY+WyLhRytWn2Rk
         czl2djUEDBO15u7yF0th70nwk2Y3hndhpsc+Yta/17kEugMJkwW4u3oxTtCe/Affs8WQ
         x6ogdCRrhJZmAqXg21ZG5aXRgFsQG7k2rs9IshMwHqZZ6ikZpMRKJN/Dl2ymIxXjGFb/
         61pQ==
X-Gm-Message-State: APjAAAXgDWxRkkN6eg7qY6J4Fdxu57Sl6ofj8IhTAtnVMyv43Jogaqyu
        7qWWmLidWkIxg9X3wLrNwSeMgQ==
X-Google-Smtp-Source: APXvYqzwUWoGQU/mZgFLbHKa3ECgR+9y72omkVBurUTg5qeDhqDe73SXSidSmcuuh8YTB3k3RhSzNw==
X-Received: by 2002:a17:906:138e:: with SMTP id f14mr9414382ejc.279.1557250415860;
        Tue, 07 May 2019 10:33:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p13sm2245429ejj.2.2019.05.07.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:33:35 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] RFC: x86/smp: use printk_deferred in native_smp_send_reschedule
Date:   Tue,  7 May 2019 19:33:29 +0200
Message-Id: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
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

This is fix attempt number 3, we've already tried to:

- make the console_trylock trylock also the spinlock. This works in
  the limited case of the console_lock use-case, but doesn't fix the
  same semaphore.lock acquisition in the up() path in console_unlock,
  which we can't avoid with a trylock.

- move the wake_up_process in up() out from under the semaphore.lock
  spinlock critical section. Again this works for the limited case of
  the console_lock, and does fully break the cycle for this lock.
  Unfortunately there's still plenty of scheduler related locks that
  wake_up_process needs, so the loop is still there, just with a few
  less locks involved.

Hence now third attempt, trying to fix this by using printk_deferred()
instead of the normal printk that WARN() uses.
native_smp_send_reschedule is only called from scheduler related code,
which has to use printk_deferred due to this locking recursion, so
this seems consistent.

It has the unfortunate downside that we're losing the backtrace though
(I didn't find a printk_deferred version of WARN, and I'm not sure
it's a bright idea to dump that much using printk_deferred.)

Keeping all the people from the console_lock/printk related attempts
on cc as fyi.

Note: We can only hit this in our CI, with a very low reproduction
rate. And right now the lockdep splat and a few other things crowd out
what actually happens in the little bit of dmesg we recover, so no
idea yet why exactly we're hitting that WARN().

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
Cc: Nicolai Stange <nstange@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 04adc8d60aed..f19782786669 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -125,7 +125,8 @@ static bool smp_no_nmi_ipi = false;
 static void native_smp_send_reschedule(int cpu)
 {
 	if (unlikely(cpu_is_offline(cpu))) {
-		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
+		printk_deferred(KERN_WARNING
+				"sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
 		return;
 	}
 	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
-- 
2.20.1

