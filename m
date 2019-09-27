Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A8D2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfI0ILX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfI0ILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKt-0005aj-9A; Fri, 27 Sep 2019 10:10:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D80E71C0440;
        Fri, 27 Sep 2019 10:10:42 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:42 -0000
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/membarrier: Skip IPIs when mm->mm_users == 1
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190919173705.2181-7-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-7-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <156957184275.9866.9051290983348883537.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c6d68c1c4a4d6611fc0f8145d764226571d737ca
Gitweb:        https://git.kernel.org/tip/c6d68c1c4a4d6611fc0f8145d764226571d737ca
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 19 Sep 2019 13:37:04 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:31 +02:00

sched/membarrier: Skip IPIs when mm->mm_users == 1

If there is only a single mm_user for the mm, the private expedited
membarrier command can skip the IPIs, because only a single thread
is using the mm.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190919173705.2181-7-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/membarrier.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 070cf43..fced54a 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -145,20 +145,21 @@ static int membarrier_private_expedited(int flags)
 	int cpu;
 	bool fallback = false;
 	cpumask_var_t tmpmask;
+	struct mm_struct *mm = current->mm;
 
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
-		if (!(atomic_read(&current->mm->membarrier_state) &
+		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
 	} else {
-		if (!(atomic_read(&current->mm->membarrier_state) &
+		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
 			return -EPERM;
 	}
 
-	if (num_online_cpus() == 1)
+	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1)
 		return 0;
 
 	/*
@@ -194,7 +195,7 @@ static int membarrier_private_expedited(int flags)
 			continue;
 		rcu_read_lock();
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p && p->mm == current->mm) {
+		if (p && p->mm == mm) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
 			else
