Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E554EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA831222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067262;
	bh=XdyvM6DTwVT7YnqBoyXQ1xjXhS8PIGQJzupZHFgdfHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DNPPDU0xjQCDA6tnrKIytIIbR1DixXJlEvxyW257/e/RwOVMVyA5i6ohUckmhMSV5
	 684XoM5p+gxs9IHN+2zJrW+PMp7EtZvjJyVwTVtoZi4/P1E92I8r8jJSoroiPJMWPP
	 WyIjA+4P5y5vE6zO/yaftJJJUnKBTZKZ7mM+wxJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfJCBri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfJCBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B45222CB;
        Thu,  3 Oct 2019 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067252;
        bh=XdyvM6DTwVT7YnqBoyXQ1xjXhS8PIGQJzupZHFgdfHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MA/VO8FcQ6Y4bgWglxRxt3YCNS51D0evvOR3F4Ib5+AzOgDKmu7NO7VQj2Qs29ac5
         vEvn5IzZ7BcKi8TAMhuDqDEL89rVKCFC2o0q/Qk4cuVURDilYYvlqj3l8ueCA9ZJYo
         AfOvBTRmxnxIiWL9q9DesAEbxCHXjt8DPXOvWamw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 6/9] rcutorture: Separate warnings for each failure type
Date:   Wed,  2 Oct 2019 18:47:25 -0700
Message-Id: <20191003014728.13496-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Currently, each of six different types of failure triggers a
single WARN_ON_ONCE(), and it is then necessary to stare at the
rcu_torture_stats(), Reader Pipe, and Reader Batch lines looking for
inappropriately non-zero values.  This can be annoying and error-prone,
so this commit provides a separate WARN_ON_ONCE() for each of the
six error conditions and adds short comments to each to ease error
identification.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7dcb2b8..a9e97c3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1442,15 +1442,18 @@ rcu_torture_stats_print(void)
 		n_rcu_torture_barrier_error);
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
-	if (atomic_read(&n_rcu_torture_mberror) != 0 ||
-	    n_rcu_torture_barrier_error != 0 ||
-	    n_rcu_torture_boost_ktrerror != 0 ||
-	    n_rcu_torture_boost_rterror != 0 ||
-	    n_rcu_torture_boost_failure != 0 ||
+	if (atomic_read(&n_rcu_torture_mberror) ||
+	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
+	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
 	    i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
+		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
+		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
+		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
+		WARN_ON_ONCE(n_rcu_torture_boost_failure); // RCU boost failed
+		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
 	pr_cont("Reader Pipe: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
-- 
2.9.5

