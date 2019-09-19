Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB1CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DA62196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TE2Qe9D+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbfISRig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:36 -0400
Received: from mail.efficios.com ([167.114.142.138]:33618 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390907AbfISRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:32 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 839CB33186C;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 6B2uJudFK36G; Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0AC63331867;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0AC63331867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914711;
        bh=7Srmn34tOeDbJzYM48SWBd4hahO+yo5hhHH3R10GHHo=;
        h=From:To:Date:Message-Id;
        b=TE2Qe9D+j5GHsODWCrAOw4HVjjeosSCcT7MQ2Wqr0AJ6r2D0LJwXRtrV4SUB7B2m+
         OZOQGEsPKm6QbpTEC1yjJ7taXPGNQa/ycR7JXEudAuuPoMe8gZcnIuoA402fo8Okqy
         tPppvpprDpX+AJ47zOeZbhmO82yrnfAm7tnnc2uWtw+12eJ2aXxo3Esd6BsuytRGgQ
         OSaKlGzUlTU/H+VVIr11U0N4XwrophZnyzSL5yMXEIXF968eiQkxYxLb5g7OypWGjU
         PQti+6M4M37osMsUd+UULa3ccIKPUR37waLTojO6aIvRL5YcMbPnCp5znQ1LUddQXs
         vd7sLmteJkl9A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dRpxlu-EFIKS; Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id BC018331853;
        Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
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
Subject: [RFC PATCH for 5.4 2/7] Cleanup: sched/membarrier: Remove redundant check
Date:   Thu, 19 Sep 2019 13:37:00 -0400
Message-Id: <20190919173705.2181-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
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

