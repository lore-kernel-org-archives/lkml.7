Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D869DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CAD2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952016;
	bh=hgkAaJEz97Y8JjBEQncErJDImLBC+X2C78Qsvhtd/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8I0NXKfHnEotbWHiW4gHhmJ2XflAuR5bubnxtjLE3G4/2IAw25OKlmg2OeoXZEVJ
	 zzhxVtDWUv139+69gtDLul5hdZj6ZkZq5qYLpUPjFbtxW9mRttD27o/68CauRqFeRc
	 JUbi/fuakXuiTstIHOGS6YBFdy9sZ/ckOkaFttMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLJE04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfLJE0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:37 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE8220828;
        Tue, 10 Dec 2019 04:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951997;
        bh=hgkAaJEz97Y8JjBEQncErJDImLBC+X2C78Qsvhtd/YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOE5agW5ZPfi2AzZOi48XO4WpXvQlyNEl5o8a3sAoew5xw3hnetXDbN4tTt92cztW
         eP+bq8ZS3u6MP0s4XSTra2SViRQSKjQHMwnG4utB9TgC/wXNupBC2JD9c2Fg6wPpgs
         Tmajg354JHouua8XI/4TAS+ULZpe7eb+kEk7btEA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/11] rcu: Clear ->rcu_read_unlock_special only once
Date:   Mon,  9 Dec 2019 20:26:26 -0800
Message-Id: <20191210042629.3808-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In rcu_preempt_deferred_qs_irqrestore(), ->rcu_read_unlock_special is
cleared one piece at a time.  Given that the "if" statements in this
function use the copy in "special", this commit removes the clearing
of the individual pieces in favor of clearing ->rcu_read_unlock_special
in one go just after it has been determined to be non-zero.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7487c79..c3a3271 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -444,16 +444,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
-	t->rcu_read_unlock_special.b.exp_hint = false;
-	t->rcu_read_unlock_special.b.deferred_qs = false;
-	if (special.b.need_qs) {
+	t->rcu_read_unlock_special.s = 0;
+	if (special.b.need_qs)
 		rcu_qs();
-		t->rcu_read_unlock_special.b.need_qs = false;
-		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
-			local_irq_restore(flags);
-			return;
-		}
-	}
 
 	/*
 	 * Respond to a request by an expedited grace period for a
@@ -461,17 +454,11 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (rdp->exp_deferred_qs) {
+	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
-		if (!t->rcu_read_unlock_special.s) {
-			local_irq_restore(flags);
-			return;
-		}
-	}
 
 	/* Clean up if blocked during RCU read-side critical section. */
 	if (special.b.blocked) {
-		t->rcu_read_unlock_special.b.blocked = false;
 
 		/*
 		 * Remove this task from the list it blocked on.  The task
-- 
2.9.5

