Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EBDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C4820674
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKOSBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:01:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:01:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iVfuP-0004t2-7E; Fri, 15 Nov 2019 19:01:25 +0100
Date:   Fri, 15 Nov 2019 19:01:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] workqueue: Add RCU annotation for pwq list walk
Message-ID: <20191115180125.j4gvmltzi6z2szhw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An additional check has been recently added to ensure that a RCU related lock
is held while the RCU list is iterated.
The `pwqs' are sometimes iterated without a RCU lock but with the &wq->mutex
acquired leading to a warning.

Teach list_for_each_entry_rcu() that the RCU usage is okay if &wq->mutex
is acquired during the list traversal.

Fixes: 28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bc2e09a8ea61d..0a1d2f4289178 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -425,7 +425,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				lockdep_is_held(&wq->mutex))		\
 		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
 		else
 
-- 
2.24.0
