Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FDC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D1421D79
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ts/CR1lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbfISRij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:33778 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404007AbfISRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 30CD63318CA;
        Thu, 19 Sep 2019 13:38:34 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id c9qwR2L27jPs; Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CB3FC3318C3;
        Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CB3FC3318C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914713;
        bh=Y+foybCeNbY5nGOuie70SNczfUyOhWGU3VGcIe+vLvk=;
        h=From:To:Date:Message-Id;
        b=ts/CR1lkpviQ4sXmC8h0iLzZsvtJEsIGHWZllOqGUTjgs1CTA4aLhmEwWc1POC+tw
         Kbd+JWVB9DDO8QbY2Li+S5Ang0g3oGdvL+zMaxi6I49j2BtcxsmcyL5CRRfZthyFLn
         wh9qIgPJ27A5KquBPuvyHjWJHE6v5JewCY5YKWz9AGUaB2pYvLXn0hkc0DYZI/QgHH
         Hcaa5zpbhaTFJlqPjBMuW8CTAGEtQZJiNJ2DO33hnPI53BG76MBzQ2Cwxmg72Xzgna
         BC9tEkNVDGT15kj7qLnTRovTmwH2swTPcYfZAfAXc3KA+mJrJiHvhQUztFFiJlxUnU
         Pme5diEaARyPA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YUIHJmI0aXzJ; Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id BEFD933188E;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.4 6/7] sched/membarrier: Skip IPIs when mm->mm_users == 1
Date:   Thu, 19 Sep 2019 13:37:04 -0400
Message-Id: <20190919173705.2181-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is only a single mm_user for the mm, the private expedited
membarrier command can skip the IPIs, because only a single thread
is using the mm.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/membarrier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index fce06a2e1d89..8afbdf92be0a 100644
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
@@ -193,7 +194,7 @@ static int membarrier_private_expedited(int flags)
 		if (cpu == raw_smp_processor_id())
 			continue;
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm == current->mm) {
+		if (p && p->mm == mm) {
 			if (!fallback)
 				__cpumask_set_cpu(cpu, tmpmask);
 			else
-- 
2.17.1

