Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC166C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA44218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374006;
	bh=ZQoVqRW6Zu1lCFYe/ygXJGf7oHrzWzrc3FZ4EzIERQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yb6XxRQ6O0/m8Tge3wteCdaOhK0D+T0ZR7aSHqvEavlywZfrhCUACAunmmcA9NL30
	 Y/PlIAuzu1AGlC08YwA15zfUmTDpnkeVlYP5tsFBhApW2ldTCEMie9/UFh/V6Z22LA
	 ZlPa+DmBAJ50vIKrzNOOJeDtJjJP33BkbRVEdBoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfB1RNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387644AbfB1RNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:23 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BE4218EA;
        Thu, 28 Feb 2019 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374002;
        bh=ZQoVqRW6Zu1lCFYe/ygXJGf7oHrzWzrc3FZ4EzIERQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5YWbHIdkwFZAyj3WUR+eClBU24plXNkB+fchrtpCrFQlLT1ps7NfGaBYdDJQtFsq
         V6ROh0UjxWyjKmfczUtkMSb/G6zbIZPV/MRV1HrjMGaj5hHlAEtJ8SAlZAfWuMNoaJ
         Wum198nBhFJnPI8Ebh3BK2yGT7u65bAEJzFFEuMg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 09/37] locking/lockdep: Prepare state_verbose() to handle all softirqs
Date:   Thu, 28 Feb 2019 18:12:14 +0100
Message-Id: <20190228171242.32144-10-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loosely handle all the softirq vectors verbosity under the same
function.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d1bfe5eff708..0988de06a7ed 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2757,17 +2757,13 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 
 #define STRICT_READ_CHECKS	1
 
-static int (*state_verbose_f[])(struct lock_class *class) = {
-#define LOCKDEP_STATE(__STATE) \
-	__STATE##_verbose,
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
 static inline int state_verbose(enum lock_usage_bit bit,
 				struct lock_class *class)
 {
-	return state_verbose_f[bit >> 2](class);
+	if (bit < LOCK_USED_IN_SOFTIRQ)
+		return HARDIRQ_verbose(class);
+	else
+		return SOFTIRQ_verbose(class);
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-- 
2.21.0

