Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F913C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A82377B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U8IhZuLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfICQAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:00:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:48824 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfICQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:00:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B6FB22AD05F;
        Tue,  3 Sep 2019 12:00:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id SUQj-9eWayid; Tue,  3 Sep 2019 12:00:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0C1862AD054;
        Tue,  3 Sep 2019 12:00:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0C1862AD054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567526445;
        bh=IiU+X/8sLphDHDOB7B80Wd6xogjC55NsznwSwLWNAiM=;
        h=From:To:Date:Message-Id;
        b=U8IhZuLVw7lvYfo06g2RkxzJd/bDccJhLiE3MSdKY1MQZirffUAcGyVFpiU1oWipn
         3JTQfwICrbVT+qOUnBJTgel+r8LiCBgQ1EFSCfejlEf1WHMLgbaF2DpvwyQMpnxvZN
         jPeuq/uCJyKvZyzOgrj8qeFAyHK/nRN8kikNcPAsVUZDaQhmkMe9bmLq176bTZ7llZ
         3ri1JkBzC7A1kEBol8aH+cH4uxKjIIN55IH9mx+eVldHV3+X5RGSYmBYIfL0Il4ZLD
         45D3lAejkmD804qGlUdEA3LVzfbNvL/eJ9h8nzEwpG9ptmnIOIj597Tj3SHbz9KslJ
         SRFJoIuLsxlXA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id DOsY7CHLigQB; Tue,  3 Sep 2019 12:00:44 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id CAA582AD037;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/3] Fix: sched/membarrier: use probe_kernel_address to read mm->membarrier_state
Date:   Tue,  3 Sep 2019 12:00:36 -0400
Message-Id: <20190903160036.2400-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

membarrier_global_expedited reads each runqueue current task's
mm->membarrier_state to test a flag. A concurrent task exit can cause
the memory backing the struct mm to have been freed before that read.
Therefore, use probe_kernel_address to read that flag. If the read
fails, consider it as if the flag was unset: it means the scheduler code
provides the barriers required by membarrier, and sending an IPI to this
CPU is redundant.

There is ongoing discussion on removing the need to use
probe_kernel_address from this code by providing additional existence
guarantees for struct mm. This patch is submitted as a fix aiming to be
backported to prior stable kernel releases.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 kernel/sched/membarrier.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 02feb7c8da4f..0312604d8315 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -58,6 +58,8 @@ static int membarrier_global_expedited(void)
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
+		struct mm_struct *mm;
+		int membarrier_state;
 
 		/*
 		 * Skipping the current CPU is OK even through we can be
@@ -72,17 +74,34 @@ static int membarrier_global_expedited(void)
 
 		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p) {
-			struct mm_struct *mm = READ_ONCE(p->mm);
+		if (!p)
+			goto next;
+		mm = READ_ONCE(p->mm);
+		if (!mm)
+			goto next;
 
-			if (mm && (atomic_read(&mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
-				if (!fallback)
-					__cpumask_set_cpu(cpu, tmpmask);
-				else
-					smp_call_function_single(cpu, ipi_mb, NULL, 1);
-			}
+		/*
+		 * Using probe_kernel_address() of membarrier_state instead of
+		 * an atomic_read() to deal with the fact that mm may have been
+		 * concurrently freed. If probe_kernel_address fails, it means
+		 * the mm struct was freed, so there is no need to issue a
+		 * barrier on that particular CPU, because the scheduler code
+		 * is taking care of it.
+		 *
+		 * It does not matter whether probe_kernel_address decides to
+		 * read membarrier_state piece-wise, given that we only care
+		 * about testing a single bit.
+		 */
+		if (probe_kernel_address(&mm->membarrier_state.counter,
+					 membarrier_state))
+			membarrier_state = 0;
+		if (membarrier_state & MEMBARRIER_STATE_GLOBAL_EXPEDITED) {
+			if (!fallback)
+				__cpumask_set_cpu(cpu, tmpmask);
+			else
+				smp_call_function_single(cpu, ipi_mb, NULL, 1);
 		}
+	next:
 		rcu_read_unlock();
 	}
 	if (!fallback) {
-- 
2.17.1

