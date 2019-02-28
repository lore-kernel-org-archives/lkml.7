Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A016A218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374020;
	bh=t+maIdQ6fHd8yF0I6oJpTh3qypSjh7KVPJ08lKgrqCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I//G4/KJx8szU3XFyUXxM9XldzlvLSIvHpXpd3awindWZRhKEqrfvjnt8lXkGR8Yx
	 Bc8B+2qFEeKhC8in2drg+KdLPRK1nv3x5Q5v6dgxNn8a1GdmHMmc45K6dGGpQ+istI
	 gIA6ZM/yGyZnRPgKHeMWA77duc5m9q9wYVuLmlNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfB1RNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbfB1RNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:34 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2B6218D0;
        Thu, 28 Feb 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374013;
        bh=t+maIdQ6fHd8yF0I6oJpTh3qypSjh7KVPJ08lKgrqCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBYDrh+abUyKg9zy+R4a6DniYyH/gNavzcqEntpRp3xy06KydZV7qFWFXdOZUmL/q
         xlMsK55bWmvVtJ8Bub5NnwaI+z6/1+PS6k7Jx722p2JkZP4lVEUtRRks/gJHjhhyP7
         gNcLSAXyAvtwqsoF9p/O2pZPgMx6KKxF3dlIbwZA=
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
Subject: [PATCH 12/37] locking/lockdep: Report all usages on mark_lock() verbosity mode
Date:   Thu, 28 Feb 2019 18:12:17 +0100
Message-Id: <20190228171242.32144-13-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mark_lock() may now be passed more than one usage at once, make
sure to expand the lock usage structure in order to report all of them
while in verbose mode logging.

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
 kernel/locking/lockdep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a369e7de3ade..a99fd5fade54 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3217,7 +3217,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_usage->bit]);
+		int bit;
+
+		for_each_bit_nr(new_mask, bit)
+			printk("\nmarked lock as {%s}:\n", usage_str[bit]);
+
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
-- 
2.21.0

