Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5D218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373978;
	bh=S+aB5NrAZr1AdmRoHZDtkR8g9Hb59n48vOCmiAWIsJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oRc3hY9Igpz2K4MLhvA12iwdhbLIRU/vHG+oKbcAMzTfSzks3x3xeSicq10C4thpR
	 IdFBYUASU8ic/Xi6BaZmL7XUgV25hZeNAvP5+lBj5B1xiFg7un9TBKUb9a5pTlc9J+
	 CnMLc/DvznsxbqxYSgJsP24f0hF+Nd4s5N5IT3m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfB1RM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfB1RMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:12:54 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7837218CD;
        Thu, 28 Feb 2019 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373974;
        bh=S+aB5NrAZr1AdmRoHZDtkR8g9Hb59n48vOCmiAWIsJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7tFmyFIkxsMe2nIj8DqvW6V+h3Z4votuOpiepCOzbMZpvKXnIJFfvMFW8u+VQKvs
         EdAc1L4yi8U2GoTFKqQ5cqPgO1ZTnRf9vA2TCJY+ddA1isJB/f1q1HrsWaqyA7QUn2
         7AJzHMzYeFBYIsnB1l0+DOv3SJzjJfVerAeRIW00=
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
Subject: [PATCH 01/37] locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Date:   Thu, 28 Feb 2019 18:12:06 +0100
Message-Id: <20190228171242.32144-2-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

valid_state() and print_usage*() functions are not used beyond locking
correctness checks. So move them inside the appropriate
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING section.

Sadly the "unused function" warning wouldn't fire because valid_state()
is inline.

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
 kernel/locking/lockdep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 608f74ed8bb9..a989a3e9ead7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2409,6 +2409,12 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit);
+
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+
 static void
 print_usage_bug_scenario(struct held_lock *lock)
 {
@@ -2478,10 +2484,6 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
-
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 /*
  * print irq inversion bug:
-- 
2.21.0

