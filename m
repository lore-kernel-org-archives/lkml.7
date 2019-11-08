Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC6FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577D92178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573229371;
	bh=XONYQsEoNe8yVWiybJpTIylgaGizvlUWWexXaABvNxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3mKd+nvGPW6qT+BlZHMpE+fSywvJl6alYs/AGADTSZ3nVhVwZDap64iajxEurWdU
	 6AlwZTU3AVJF5pziU1BCcX/fRIhPzTVJJh1Nit6kmne2+wmjzOU/iUM1RRdM9YtZjB
	 6Z/8IOrsodjontS/4vxjyL7WEofZHZ+rEpAgU1kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfKHQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfKHQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:28 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407D721D82;
        Fri,  8 Nov 2019 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573229368;
        bh=XONYQsEoNe8yVWiybJpTIylgaGizvlUWWexXaABvNxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+0a+rZoGK8baZ8RtUPEP5dXwYAdacH2bRiwraNRRrUHJFMoybLuxEviHRV2Zj3On
         3/zIrpKqMcQiZYiPwj0VJ3LUvkVxE+Q25JIDk59LkQ7Y4POga029VnZXbAzHSw1hEP
         YYqIF3oaDNjcr2sztFERCk/Me38178YwL7g2lo9c=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4] irq_work: Slightly simplify IRQ_WORK_PENDING clearing
Date:   Fri,  8 Nov 2019 17:08:57 +0100
Message-Id: <20191108160858.31665-4-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108160858.31665-1-frederic@kernel.org>
References: <20191108160858.31665-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching the value of flags and perform an xchg() to clear
a bit, just use atomic_fetch_andnot() that is more suitable to do that
job in one operation while keeping the full ordering.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 255454a48346..49c53f80a13a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -34,7 +34,7 @@ static bool irq_work_claim(struct irq_work *work)
 	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
-	 * The pairing atomic_xchg() in irq_work_run() makes sure
+	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
 	 * everything we did before is visible.
 	 */
 	if (oflags & IRQ_WORK_PENDING)
@@ -135,7 +135,6 @@ static void irq_work_run_list(struct llist_head *list)
 {
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
-	int flags;
 
 	BUG_ON(!irqs_disabled());
 
@@ -144,6 +143,7 @@ static void irq_work_run_list(struct llist_head *list)
 
 	llnode = llist_del_all(list);
 	llist_for_each_entry_safe(work, tmp, llnode, llnode) {
+		int flags;
 		/*
 		 * Clear the PENDING bit, after this point the @work
 		 * can be re-used.
@@ -151,8 +151,7 @@ static void irq_work_run_list(struct llist_head *list)
 		 * to claim that work don't rely on us to handle their data
 		 * while we are in the middle of the func.
 		 */
-		flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
-		atomic_xchg(&work->flags, flags);
+		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
 
 		work->func(work);
 		/*
-- 
2.23.0

