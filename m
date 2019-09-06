Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88AC206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b8K0dwSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404398AbfIFDNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:13:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:40124 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391259AbfIFDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:13:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0A41532CD7E;
        Thu,  5 Sep 2019 23:13:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id aayVk7JPbFuJ; Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5A2DB32CD78;
        Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5A2DB32CD78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567739587;
        bh=7Srmn34tOeDbJzYM48SWBd4hahO+yo5hhHH3R10GHHo=;
        h=From:To:Date:Message-Id;
        b=b8K0dwSOPkr9c1xMqkrNDNl2ZxxygJer6Cq8atILpglXPX1lDdxBudcarGU1EzFWw
         fVvO3kbCJa70pN40/ykfJMaOostIjxuOqoafXPaaD7snB7rUuUoRK66kijboyd1RS9
         WUwSGnvsUIbVWVycioK64dKBoleiEgmZ3nwn9RjYo/33SLQ3Ye5T1Ltcy2RVbfSH5E
         BopLIJbY+0d9A01teWiR/KEfnTe403TVK9XcCszSVM+LG6nlqsUOptlCG/E088V1Qm
         SP3EMCfBkt5mwfbYU5XER7ZNvgusF0BbGhg/4bZWWkoaPdiDnWNa5SF4f9MThaxZEm
         srlsnhQpFNYdw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id x5jTZ3oxQ--h; Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 1C10532CD68;
        Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
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
Subject: [RFC PATCH 2/4] Cleanup: sched/membarrier: remove redundant check
Date:   Thu,  5 Sep 2019 23:12:58 -0400
Message-Id: <20190906031300.1647-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking that the number of threads is 1 is redundant with checking
mm_users == 1.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
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
 kernel/sched/membarrier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 5110d91b1b0e..7e0a0d6535f3 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -186,7 +186,7 @@ static int membarrier_register_global_expedited(void)
 	    MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &mm->membarrier_state);
-	if (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1) {
+	if (atomic_read(&mm->mm_users) == 1) {
 		/*
 		 * For single mm user, single threaded process, we can
 		 * simply issue a memory barrier after setting
@@ -232,7 +232,7 @@ static int membarrier_register_private_expedited(int flags)
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
 		atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE,
 			  &mm->membarrier_state);
-	if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
+	if (atomic_read(&mm->mm_users) != 1) {
 		/*
 		 * Ensure all future scheduler executions will observe the
 		 * new thread flag state for this process.
-- 
2.17.1

