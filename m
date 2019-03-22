Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FBD218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257657;
	bh=t6MmLYm0Wmc9yDVdp7FsI+xLa1mtbMs8BHn7lvW6kzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ayFSaTDd0tAJmO09xY68701oqhP/6/DTJjX8oAEtxszEMB1WLTk4Sx3UKFU7VWBNQ
	 xGuZgaj1F/nTh17FI8+WntfBlqK4PN45p8u4jLqbCw7EFLCpym5GPKLUAmhbNzzyrO
	 /zSHT6be8Zi6vRNZTgO46hsB3dKdFg7JdznGhmlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfCVM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391116AbfCVM1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:27:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C78A218A1;
        Fri, 22 Mar 2019 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257651;
        bh=t6MmLYm0Wmc9yDVdp7FsI+xLa1mtbMs8BHn7lvW6kzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhDVvZYDYy5wiENK7LoPEuKRuK6M9j8sn1M1SF2coNXt0EIo+8Sy5HZk6DKCRu6C7
         JNyBzoLL8j2t7PFawN/vUQKknI6F6GJ4/r9Flg64oT/KIsiBVYVstepTjczVxqupsI
         OLc3bqIbXdchWgKhWRnDQqjZ49Q8Yrx25CWKbcnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "He, Bo" <bo.he@intel.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "xiao, jin" <jin.xiao@intel.com>, Jie A <jie.a.bai@intel.com>
Subject: [PATCH 5.0 211/238] rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
Date:   Fri, 22 Mar 2019 12:17:10 +0100
Message-Id: <20190322111310.710253266@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang, Jun <jun.zhang@intel.com>

commit 1d1f898df6586c5ea9aeaf349f13089c6fa37903 upstream.

The rcu_gp_kthread_wake() function is invoked when it might be necessary
to wake the RCU grace-period kthread.  Because self-wakeups are normally
a useless waste of CPU cycles, if rcu_gp_kthread_wake() is invoked from
this kthread, it naturally refuses to do the wakeup.

Unfortunately, natural though it might be, this heuristic fails when
rcu_gp_kthread_wake() is invoked from an interrupt or softirq handler
that interrupted the grace-period kthread just after the final check of
the wait-event condition but just before the schedule() call.  In this
case, a wakeup is required, even though the call to rcu_gp_kthread_wake()
is within the RCU grace-period kthread's context.  Failing to provide
this wakeup can result in grace periods failing to start, which in turn
results in out-of-memory conditions.

This race window is quite narrow, but it actually did happen during real
testing.  It would of course need to be fixed even if it was strictly
theoretical in nature.

This patch does not Cc stable because it does not apply cleanly to
earlier kernel versions.

Fixes: 48a7639ce80c ("rcu: Make callers awaken grace-period kthread")
Reported-by: "He, Bo" <bo.he@intel.com>
Co-developed-by: "Zhang, Jun" <jun.zhang@intel.com>
Co-developed-by: "He, Bo" <bo.he@intel.com>
Co-developed-by: "xiao, jin" <jin.xiao@intel.com>
Co-developed-by: Bai, Jie A <jie.a.bai@intel.com>
Signed-off: "Zhang, Jun" <jun.zhang@intel.com>
Signed-off: "He, Bo" <bo.he@intel.com>
Signed-off: "xiao, jin" <jin.xiao@intel.com>
Signed-off: Bai, Jie A <jie.a.bai@intel.com>
Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>
[ paulmck: Switch from !in_softirq() to "!in_interrupt() &&
  !in_serving_softirq() to avoid redundant wakeups and to also handle the
  interrupt-handler scenario as well as the softirq-handler scenario that
  actually occurred in testing. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Link: https://lkml.kernel.org/r/CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1557,14 +1557,23 @@ static bool rcu_future_gp_cleanup(struct
 }
 
 /*
- * Awaken the grace-period kthread.  Don't do a self-awaken, and don't
- * bother awakening when there is nothing for the grace-period kthread
- * to do (as in several CPUs raced to awaken, and we lost), and finally
- * don't try to awaken a kthread that has not yet been created.
+ * Awaken the grace-period kthread.  Don't do a self-awaken (unless in
+ * an interrupt or softirq handler), and don't bother awakening when there
+ * is nothing for the grace-period kthread to do (as in several CPUs raced
+ * to awaken, and we lost), and finally don't try to awaken a kthread that
+ * has not yet been created.  If all those checks are passed, track some
+ * debug information and awaken.
+ *
+ * So why do the self-wakeup when in an interrupt or softirq handler
+ * in the grace-period kthread's context?  Because the kthread might have
+ * been interrupted just as it was going to sleep, and just after the final
+ * pre-sleep check of the awaken condition.  In this case, a wakeup really
+ * is required, and is therefore supplied.
  */
 static void rcu_gp_kthread_wake(void)
 {
-	if (current == rcu_state.gp_kthread ||
+	if ((current == rcu_state.gp_kthread &&
+	     !in_interrupt() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) ||
 	    !rcu_state.gp_kthread)
 		return;


