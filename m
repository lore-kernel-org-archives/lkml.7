Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8490FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4954F222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066396;
	bh=D5IRy4XAkIH9bJC8ATB9LlP4bTezolHHmz5Uw0fMFZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KB3ZGWRzSL33v3GMqad6+wYiEcfuzrVquvXYO8TBL7eTnPcGiAVomgCmR5ftBc5fz
	 5ZwV4jn5G1JKX5m3lk6N5ckFL6ej1R/f3OIeBXpRBE3FtejIqXUyhlx/cFjElXkGG3
	 A9iZQYxspgFY4guCjvFu0bLaMSNeyITHQMzToScI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfJCBdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfJCBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50D4222C5;
        Thu,  3 Oct 2019 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066388;
        bh=D5IRy4XAkIH9bJC8ATB9LlP4bTezolHHmz5Uw0fMFZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvwI8SfNB1nnNkNj2TH95nxbhVRuFhmJGd/SVP0yIzvKGyaBB6CWuLZCrv0/ANtgJ
         lgwvXRLFwWJ3moheW24StWBr8lXdOJEktiFn6xsWnHJ6j030n8UVyS2N75PG2eGBOd
         1/wYAHInK5m04Edx3G5TDBKhPBYF8zj3z3kXt6zw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/8] workqueue: Convert for_each_wq to use built-in list check
Date:   Wed,  2 Oct 2019 18:33:00 -0700
Message-Id: <20191003013305.12854-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Because list_for_each_entry_rcu() can now check for holding a
lock as well as for being in an RCU read-side critical section,
this commit replaces the workqueue_sysfs_unregister() function's
use of assert_rcu_or_wq_mutex() and list_for_each_entry_rcu() with
list_for_each_entry_rcu() augmented with a lockdep_is_held() optional
argument.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/workqueue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bc2e09a..e501c79 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -364,11 +364,6 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex(wq)					\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
-			 !lockdep_is_held(&wq->mutex),			\
-			 "RCU or wq->mutex should be held")
-
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
 			 !lockdep_is_held(&wq->mutex) &&		\
@@ -425,9 +420,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
  * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
-	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
-		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
-		else
+	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
+				 lockdep_is_held(&(wq->mutex)))
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-- 
2.9.5

