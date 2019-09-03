Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE50C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E4D22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lAcoMRpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfICQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:00:52 -0400
Received: from mail.efficios.com ([167.114.142.138]:48798 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:00:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 654A42AD057;
        Tue,  3 Sep 2019 12:00:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7hkK1hRKA1wf; Tue,  3 Sep 2019 12:00:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D92F62AD048;
        Tue,  3 Sep 2019 12:00:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D92F62AD048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567526444;
        bh=Zqhr/+MbOuomokLdwjrVX2IWsufug4RaFYpEXDeAvVU=;
        h=From:To:Date:Message-Id;
        b=lAcoMRpFssL1+ZedFAhjlG+0Dnuw1I+PUEexxmpXS4NWGWnK7iBMJ9E0TZg4KrULa
         Ef6ZZTtO4R2Oq5dPNhVrfyCJ0GX94Sv/9GY6xd4p0DuWYRcq1cSJ/K4g87OPuyMje+
         fUQ3lYoG8myPqK0zZFP7SZT8MrCQRQalcQhFgPK+TuIQ02gz9vo5tzYSKd+tiGFDtl
         03tnxT4ieaqfej+nGFdi8xlsVc0k3tdKvKFOSTQNmP1vbMyOp6x+LtUVmnbftWulfS
         enMYlycYelXnC++/o+E/StSGSkhq7XM2Mb2r7y5ZSn6WPgpEHlxLbDkcvvUwjNLLyl
         /wXGtEkHnVOrQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id oanwNV4MFyzd; Tue,  3 Sep 2019 12:00:44 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 943BB2AD02B;
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
Subject: [RFC PATCH 2/3] Fix: sched/membarrier: READ_ONCE p->mm in membarrier_global_expedited
Date:   Tue,  3 Sep 2019 12:00:35 -0400
Message-Id: <20190903160036.2400-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the lack of READ_ONCE() on p->mm, this code can in fact turn into
a NULL deref when we hit do_exit() around exit_mm(). The first p->mm
read is before and sees !NULL, the second is after and does observe
NULL, which triggers a null pointer dereference.

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
 kernel/sched/membarrier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aa8d75804108..02feb7c8da4f 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -72,12 +72,16 @@ static int membarrier_global_expedited(void)
 
 		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
+		if (p) {
+			struct mm_struct *mm = READ_ONCE(p->mm);
+
+			if (mm && (atomic_read(&mm->membarrier_state) &
 				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
-			if (!fallback)
-				__cpumask_set_cpu(cpu, tmpmask);
-			else
-				smp_call_function_single(cpu, ipi_mb, NULL, 1);
+				if (!fallback)
+					__cpumask_set_cpu(cpu, tmpmask);
+				else
+					smp_call_function_single(cpu, ipi_mb, NULL, 1);
+			}
 		}
 		rcu_read_unlock();
 	}
-- 
2.17.1

