Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86918208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yKqjPVkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfF1VkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:40:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41790 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfF1VkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:40:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so3611633pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jCvsK07ThrOtm2mRIw4Un4YwGsJ6vhB4AB5ORa0vWlA=;
        b=yKqjPVkrhteNdaJFFV0U8q0RPi2SdXcKjQBfSnERCv5I82XNoHDvuVoU4+4lrpuzVW
         xBiNdLXdFnjYXsnraBWekglpLudT+Y0+2SbJBJJEpq/JpTHKQqHDFAPmKhLjMtI38DrQ
         Dd7WliyG25HBEeMzndnad9A5ee3SjSi9uKtUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jCvsK07ThrOtm2mRIw4Un4YwGsJ6vhB4AB5ORa0vWlA=;
        b=BZULJnSGITEWg3mIt0GUod/yG/I3uqR5qpNguanJhbnwsVfguyujdI6huOkHyngrCq
         cY2gOP0rco6nVDEnZiuJesHP1R30NdAjcRGZDjJxFsgrp+3duzDE8fZvG7boY0S5RjVm
         mKRm4fi4DRrXkiHQsO6+eZKNDgZQZMzy29unUVWOCjTzbwdFgBXB0ucIbES0MjTAWypj
         FSMlzL/CrYWS0Po3Gaps0lj0nmsQ84SMA6zbUodRfT1PFrWnoxEiYwv12QB6R4G1aaQS
         OKXxF2ZkIGRBwUoLfXC5BGdwcoMWkrGLuEy5ssfhGvIZ00DBk34HRVJmWkrFG4B4JGB2
         ouBw==
X-Gm-Message-State: APjAAAXAmbeM0lMXDazeU3Wl+MJkvzfWiH0ezmvd7NOufTn2tmvcJliP
        go+hWUTACsEL50wFhXPmN5OyiQ==
X-Google-Smtp-Source: APXvYqxBx5u0xr36Tcf97zl0hZo7eVtkw7YHeeMp2wx3eeAqCz8qRWMLu7NjD/ppqvtv9qtx6AEhCg==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr15505765pjr.64.1561758021129;
        Fri, 28 Jun 2019 14:40:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e11sm5472318pfm.35.2019.06.28.14.40.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 14:40:20 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:40:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628214018.GB249127@google.com>
References: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
 <20190628192407.GA89956@google.com>
 <20190628200423.GB26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628200423.GB26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Jun 28, 2019 at 01:04:23PM -0700, Paul E. McKenney wrote:
[snip]
> > > > Commit
> > > > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> > > >    rcu_read_unlock_special()") does not trigger the bug within 94
> > > >    attempts.
> > > > 
> > > > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> > > >   processing") needed 12 attempts to trigger the bug.
> > > 
> > > That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> > > conditions in rcu_read_unlock_special()") will at least greatly decrease
> > > the probability of this bug occurring.
> > 
> > I was just typing a reply that I can't reproduce it with:
> >   rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()
> > 
> > I am trying to revert enough of this patch to see what would break things,
> > however I think a better exercise might be to understand more what the patch
> > does why it fixes things in the first place ;-) It is probably the
> > deferred_qs thing.
> 
> The deferred_qs flag is part of it!  Looking forward to hearing what
> you come up with as being the critical piece of this commit.

The new deferred_qs flag indeed saves the machine from the dead-lock.

If we don't want the deferred_qs, then the below patch also fixes the issue.
However, I am more sure than not that it does not handle all cases (such as
what if we previously had an expedited grace period IPI in a previous reader
section and had to to defer processing. Then it seems a similar deadlock
would present. But anyway, the below patch does fix it for me! It is based on
your -rcu tree commit 23634ebc1d946f19eb112d4455c1d84948875e31 (rcu: Check
for wakeup-safe conditions in rcu_read_unlock_special()).

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] Fix RCU recursive deadlock

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h    |  2 +-
 kernel/rcu/tree_plugin.h | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 942a44c1b8eb..347e6dfcc91b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -565,7 +565,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			deferred_qs;
+		u8			pad;
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 75110ea75d01..5b9b12c1ba5c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -455,7 +455,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
-	t->rcu_read_unlock_special.b.deferred_qs = false;
 	if (special.b.need_qs) {
 		rcu_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
@@ -608,13 +607,24 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
 		t->rcu_read_unlock_special.b.exp_hint = false;
 		// Need to defer quiescent state until everything is enabled.
+
+		/* If unlock_special was called in the current reader section
+		 * just because we were blocked in a previous reader section,
+		 * then raising softirqs can deadlock. This is because the
+		 * scheduler executes RCU sections with preemption disabled,
+		 * however it may have previously blocked in a previous
+		 * non-scheduler reader section and .blocked got set.  It is
+		 * never safe to call unlock_special from the scheduler path
+		 * due to recursive wake ups (unless we are in_irq(), so
+		 * prevent this by checking if we were previously blocked.
+		 */
 		if (irqs_were_disabled && use_softirq &&
-		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
+		    (!t->rcu_read_unlock_special.b.blocked || in_irq())) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else if (irqs_were_disabled && !use_softirq &&
-			   !t->rcu_read_unlock_special.b.deferred_qs) {
+			   !t->rcu_read_unlock_special.b.blocked) {
 			// Safe to awaken and we get no help from enabling
 			// irqs, unlike bh/preempt.
 			invoke_rcu_core();
@@ -623,7 +633,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}
-		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

