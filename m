Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D33C5AE59
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69353216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oOd4/Pgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfIKA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:27:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:59942 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfIKA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:27:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 084E2BD649;
        Tue, 10 Sep 2019 20:27:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id k_nCUCl2YpvD; Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2CB62BD63F;
        Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2CB62BD63F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568161672;
        bh=LiYLJtRnRl7RiTEkK3GzZtE13amSGTCOnGb6HWoWMjo=;
        h=From:To:Date:Message-Id;
        b=oOd4/PgiFZxL0bMq4uhtO8LUKjn1hBNZvS6/G3OIbC/G05KGCVNSjcxwO3sMcO3FE
         s9kK+CNmklrIy6uRhp2yRal32NwiF09QTNLWLQemqYTfBLsf/9tOFBYZKor9xkZyoM
         UG6LgwOZngjEtD+Zb14G7cMiYtRiRiModndHPdFHjeSrJlHlxLmFGLgLtVykysm03y
         ZYGxlJoeF5Wwpow5jguZshmgkoPEzlAMwbZE99DLfrF7zK9cu3FQ0DpB9d/vUG9ykh
         LM1VilhIyxRN5MjWoEzO4VPZCNuWS6YK6zLJDuCyT98rAchBy3YKdAd0rpe2l5UETc
         Z0fgNMw97ZbJw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id O09eYkdgPmCd; Tue, 10 Sep 2019 20:27:52 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id EAC41BD632;
        Tue, 10 Sep 2019 20:27:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-api@vger.kernel.org
Subject: [RFC PATCH 2/4] rseq: Fix: Unregister rseq for CLONE_TLS
Date:   Tue, 10 Sep 2019 20:27:42 -0400
Message-Id: <20190911002744.8690-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
References: <20190911002744.8690-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported by Google that rseq is not behaving properly
with respect to clone when CLONE_VM is used without CLONE_THREAD.
It keeps the prior thread's rseq TLS registered when the TLS of the
thread has moved, so the kernel deals with the wrong TLS.

The approach of clearing the per task-struct rseq registration
on clone with CLONE_THREAD flag is incomplete. It does not cover
the use-case of clone with CLONE_VM set, but without CLONE_THREAD.

Looking more closely at each of the clone flags:

- CLONE_THREAD,
- CLONE_VM,
- CLONE_SETTLS.

It appears that the flag we really want to track is CLONE_SETTLS, which
moves the location of the TLS for the child, which makes the rseq
registration point to the wrong TLS.

Suggested-by: "H . Peter Anvin" <hpa@zytor.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..deb4154dbf11 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1919,11 +1919,11 @@ static inline void rseq_migrate(struct task_struct *t)
 
 /*
  * If parent process has a registered restartable sequences area, the
- * child inherits. Only applies when forking a process, not a thread.
+ * child inherits. Unregister rseq for a clone with CLONE_TLS set.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
-	if (clone_flags & CLONE_THREAD) {
+	if (clone_flags & CLONE_TLS) {
 		t->rseq = NULL;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
-- 
2.17.1

