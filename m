Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B780C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85421473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfDCImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:42:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfDCImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:42:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338fNAY1775363
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:41:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338fMik1775358;
        Wed, 3 Apr 2019 01:41:22 -0700
Date:   Wed, 3 Apr 2019 01:41:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Joel Fernandes (Google)" <tipbot@zytor.com>
Message-ID: <tip-2e7d58babd2a6073d1afb38519e246dd4a423da5@git.kernel.org>
Cc:     peterz@infradead.org, paulmck@linux.ibm.com,
        torvalds@linux-foundation.org, hpa@zytor.com, efault@gmx.de,
        mingo@kernel.org, morten.rasmussen@arm.com, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, jiangshanlai@gmail.com,
        luc.vanoostenryck@gmail.com, tglx@linutronix.de,
        rostedt@goodmis.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          hpa@zytor.com, efault@gmx.de, paulmck@linux.ibm.com,
          morten.rasmussen@arm.com, josh@joshtriplett.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          luc.vanoostenryck@gmail.com, tglx@linutronix.de,
          jiangshanlai@gmail.com, rostedt@goodmis.org,
          mathieu.desnoyers@efficios.com, joel@joelfernandes.org
In-Reply-To: <20190321003426.160260-5-joel@joelfernandes.org>
References: <20190321003426.160260-5-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Annotate perf_domain pointer with
 __rcu
Git-Commit-ID: 2e7d58babd2a6073d1afb38519e246dd4a423da5
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

Commit-ID:  2e7d58babd2a6073d1afb38519e246dd4a423da5
Gitweb:     https://git.kernel.org/tip/2e7d58babd2a6073d1afb38519e246dd4a423da5
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Wed, 20 Mar 2019 20:34:26 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:51:04 +0200

sched/core: Annotate perf_domain pointer with __rcu

This fixes the following sparse errors in sched/fair.c:

  fair.c:6506:14: error: incompatible types in comparison expression
  fair.c:8642:21: error: incompatible types in comparison expression

Using __rcu will also help sparse catch any future bugs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[ From an RCU perspective. ]
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
Link: https://lkml.kernel.org/r/20190321003426.160260-5-joel@joelfernandes.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b452d68ab2e..b52ed1ada0be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -780,7 +780,7 @@ struct root_domain {
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
 	 */
-	struct perf_domain	*pd;
+	struct perf_domain __rcu *pd;
 };
 
 extern struct root_domain def_root_domain;
