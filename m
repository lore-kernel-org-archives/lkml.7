Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCE3CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF2C2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfJaLzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfJaLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92v-00036N-DE; Thu, 31 Oct 2019 12:55:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5EB951C04E4;
        Thu, 31 Oct 2019 12:55:08 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:08 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Separate warnings for each failure type
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290804.29376.9334441931843722578.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8b5ddf8b99dc42241d1d413c6685bce18275c40e
Gitweb:        https://git.kernel.org/tip/8b5ddf8b99dc42241d1d413c6685bce18275c40e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 14 Aug 2019 12:02:40 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:50:03 -07:00

rcutorture: Separate warnings for each failure type

Currently, each of six different types of failure triggers a
single WARN_ON_ONCE(), and it is then necessary to stare at the
rcu_torture_stats(), Reader Pipe, and Reader Batch lines looking for
inappropriately non-zero values.  This can be annoying and error-prone,
so this commit provides a separate WARN_ON_ONCE() for each of the
six error conditions and adds short comments to each to ease error
identification.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca..5ac4672 100644
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
