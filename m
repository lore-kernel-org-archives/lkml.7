Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A82C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D6C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDCKrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:47:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:47:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AkEFj1815062
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:46:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AkD881815055;
        Wed, 3 Apr 2019 03:46:13 -0700
Date:   Wed, 3 Apr 2019 03:46:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Joel Fernandes (Google)" <tipbot@zytor.com>
Message-ID: <tip-b10abd0a8859493a93c6b8020f2be2587557749d@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        josh@joshtriplett.org, luc.vanoostenryck@gmail.com, efault@gmx.de,
        joel@joelfernandes.org, torvalds@linux-foundation.org,
        hpa@zytor.com, jiangshanlai@gmail.com, morten.rasmussen@arm.com,
        linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org
Reply-To: joel@joelfernandes.org, efault@gmx.de,
          luc.vanoostenryck@gmail.com, josh@joshtriplett.org,
          rostedt@goodmis.org, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, mathieu.desnoyers@efficios.com,
          paulmck@linux.ibm.com, linux-kernel@vger.kernel.org,
          morten.rasmussen@arm.com, hpa@zytor.com, jiangshanlai@gmail.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190321003426.160260-2-joel@joelfernandes.org>
References: <20190321003426.160260-2-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Annotate cpufreq_update_util_data
 pointer with __rcu
Git-Commit-ID: b10abd0a8859493a93c6b8020f2be2587557749d
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

Commit-ID:  b10abd0a8859493a93c6b8020f2be2587557749d
Gitweb:     https://git.kernel.org/tip/b10abd0a8859493a93c6b8020f2be2587557749d
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Wed, 20 Mar 2019 20:34:23 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 12:34:31 +0200

sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu

Recently I added an RCU annotation check to rcu_assign_pointer(). All
pointers assigned to RCU protected data are to be annotated with __rcu
inorder to be able to use rcu_assign_pointer() similar to checks in
other RCU APIs.

This resulted in a sparse error:

  kernel//sched/cpufreq.c:41:9: sparse: error: incompatible types in comparison expression (different address spaces)

Fix this by annotating cpufreq_update_util_data pointer with __rcu. This
will also help sparse catch any future RCU misuage bugs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ From an RCU perspective. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com
Cc: kernel-team@android.com
Link: https://lkml.kernel.org/r/20190321003426.160260-2-joel@joelfernandes.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 835671f0f917..b5dcd1d83c7f 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efa686eeff26..713715dd00cf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2185,7 +2185,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
