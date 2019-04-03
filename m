Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F2D20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDCKsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:48:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfDCKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:48:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AlYOf1815150
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:47:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AlXtX1815147;
        Wed, 3 Apr 2019 03:47:33 -0700
Date:   Wed, 3 Apr 2019 03:47:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Joel Fernandes (Google)" <tipbot@zytor.com>
Message-ID: <tip-03f4b48edae7d936c5bf23488c1ce3fbe7fc2733@git.kernel.org>
Cc:     rostedt@goodmis.org, morten.rasmussen@arm.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, efault@gmx.de,
        joel@joelfernandes.org, jiangshanlai@gmail.com,
        luc.vanoostenryck@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mathieu.desnoyers@efficios.com
Reply-To: linux-kernel@vger.kernel.org, josh@joshtriplett.org,
          efault@gmx.de, paulmck@linux.ibm.com, joel@joelfernandes.org,
          luc.vanoostenryck@gmail.com, jiangshanlai@gmail.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
          morten.rasmussen@arm.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190321003426.160260-4-joel@joelfernandes.org>
References: <20190321003426.160260-4-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] rcuwait: Annotate task_struct with __rcu
Git-Commit-ID: 03f4b48edae7d936c5bf23488c1ce3fbe7fc2733
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

Commit-ID:  03f4b48edae7d936c5bf23488c1ce3fbe7fc2733
Gitweb:     https://git.kernel.org/tip/03f4b48edae7d936c5bf23488c1ce3fbe7fc2733
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Wed, 20 Mar 2019 20:34:25 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 12:34:31 +0200

rcuwait: Annotate task_struct with __rcu

This suppresses sparse error generated due to the recently added
rcu_assign_pointer sparse check.

  percpu-rwsem.c:162:9: sparse: error: incompatible types in comparison expression
  exit.c:316:16: sparse: error: incompatible types in comparison expression

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
Link: https://lkml.kernel.org/r/20190321003426.160260-4-joel@joelfernandes.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..563290fc194f 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -18,7 +18,7 @@
  * awoken.
  */
 struct rcuwait {
-	struct task_struct *task;
+	struct task_struct __rcu *task;
 };
 
 #define __RCUWAIT_INITIALIZER(name)		\
