Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C507AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32162133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfFXQIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:08:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45261 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFXQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:08:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so15018899qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84ZTyhb76oZ1syJLjLhevgZVNieTR7PJQPSO7UnJims=;
        b=d0T9g4aH+pn/mqf3UYkB7PRwNLAjbcwp6pxB0ZfBN1+O09HXtjqa+T93onp2CvAttt
         BQWR0p/kDb1c4/eVXl7sGVenNaLIrlMHBd5mG8eWW3SsdLaGukL4pmWfL++l24LSzBNu
         fMcdJOJg+tnbbHn7+UQ/Uh8a4Pa0RSCLR8lrkVz8hAxILT7t+QmBpdmdpRqgVF/jiFBn
         J7LSFGsAHK+axAmjXxoMxXVbesvcIrSK2CnRT72WFbKZRFc3BWoRpHSK9U4RlG8eVfy8
         Ze8Ar6tqvuOh8eJPdPlmxVK2iD7TwMaO5nxDYKAHRCcHp1wKYk1SZlYg5uluxcN3aabS
         dasw==
X-Gm-Message-State: APjAAAXl67yWoBZKuvjXa/wopXPsXE5u7k/vhIMfJ+uezCnKzZvD4cMc
        HBmg3MVO7gARENPgPf/vLbyfin0j8XpZEnOV9V0=
X-Google-Smtp-Source: APXvYqwz/pDsdQ5LT9mgLdXladpDYFsNqhlI4efb4k8umqdGz/yQ5E9t3rTMqrj+Aa0k4Ky0rZsfC2C0T5f0g61Sm7s=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr125290681qtf.204.1561392479818;
 Mon, 24 Jun 2019 09:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190617124718.1232976-1-arnd@arndb.de> <20190624121755.x5746xrskrbbhaft@willie-the-truck>
In-Reply-To: <20190624121755.x5746xrskrbbhaft@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Jun 2019 18:07:40 +0200
Message-ID: <CAK8P3a2X_5p9QOKG-jcozR4P8iPNJAY2ObXgfqt=bBD+hZdnSg@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Move mark_lock() inside
 CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:18 PM Will Deacon <will@kernel.org> wrote:
> On Mon, Jun 17, 2019 at 02:47:05PM +0200, Arnd Bergmann wrote:

> >
> > +unsigned long nr_stack_trace_entries;
> > +
> > +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
>
> Is this necessary, given that CONFIG_PROVE_LOCKING selects TRACE_IRQFLAGS?
> I find that having both of the symbols makes this really hard to read.

Probably not. I have removed the CONFIG_TRACE_IRQFLAGS check from
all instances in this file now, and will give it some more testing.

It took me a few iterations to get to a version of this patch that had no
build failures, so I'm a bit careful. I had copied the #if check from what
protected some of the callers. If the change below works, I'll fold it
into my patch and send it again.

       Arnd

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -448,7 +448,7 @@ static void print_lockdep_off(const char *bug_msg)

 unsigned long nr_stack_trace_entries;

-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the graph_lock.
@@ -491,7 +491,7 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif

-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Locking printouts:
  */
@@ -2969,7 +2969,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }

-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
                     enum lock_usage_bit new_bit);

@@ -3608,7 +3608,7 @@ static int mark_lock(struct task_struct *curr,
struct held_lock *this,
        return ret;
 }

-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#else /* CONFIG_PROVE_LOCKING */

 static inline int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
@@ -3627,7 +3627,7 @@ static inline int separate_irq_context(struct
task_struct *curr,
        return 0;
 }

-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#endif /* CONFIG_PROVE_LOCKING */

 /*
  * Initialize a lock instance's lock-class mapping info:
@@ -4321,8 +4321,7 @@ static void __lock_unpin_lock(struct lockdep_map
*lock, struct pin_cookie cookie
  */
 static void check_flags(unsigned long flags)
 {
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
-    defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
        if (!debug_locks)
                return;
