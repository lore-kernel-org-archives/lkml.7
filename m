Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46DA20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDCImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:42:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfDCIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338efZ91775283
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:40:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338eecc1775280;
        Wed, 3 Apr 2019 01:40:40 -0700
Date:   Wed, 3 Apr 2019 01:40:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Joel Fernandes (Google)" <tipbot@zytor.com>
Message-ID: <tip-ea3ce866b568e087737df666c2c035496f54fdcb@git.kernel.org>
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        efault@gmx.de, torvalds@linux-foundation.org,
        mathieu.desnoyers@efficios.com, morten.rasmussen@arm.com,
        luc.vanoostenryck@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jiangshanlai@gmail.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          paulmck@linux.ibm.com, josh@joshtriplett.org, efault@gmx.de,
          joel@joelfernandes.org, morten.rasmussen@arm.com,
          torvalds@linux-foundation.org, mathieu.desnoyers@efficios.com,
          peterz@infradead.org, jiangshanlai@gmail.com, hpa@zytor.com,
          tglx@linutronix.de, luc.vanoostenryck@gmail.com, mingo@kernel.org
In-Reply-To: <20190321003426.160260-4-joel@joelfernandes.org>
References: <20190321003426.160260-4-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] rcuwait: Annotate task_struct with __rcu
Git-Commit-ID: ea3ce866b568e087737df666c2c035496f54fdcb
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

Commit-ID:  ea3ce866b568e087737df666c2c035496f54fdcb
Gitweb:     https://git.kernel.org/tip/ea3ce866b568e087737df666c2c035496f54fdcb
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Wed, 20 Mar 2019 20:34:25 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:51:04 +0200

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
