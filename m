Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB103C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0D920685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257667;
	bh=5vlIzUe1terjkQX+7PJwOvk8Li/L2QgptU7GQAaA6GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzyA7w4TkgRCFoQdLdNOcMMGuCjMDAn4PBDPXrCVdY73tEz1Y830ROylCoGKc0aoJ
	 HNWFzCwRnfVCDcSnlkGA8DjKlZYPlpW0fXbqXXwxYQhx9m6hXFXRd8lTopS/WfIEdg
	 YhWJL8/rsu2dJKXBdQfC1XskidX0OztEErXwaKIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbfCVM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403758AbfCVM1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:27:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2C62054F;
        Fri, 22 Mar 2019 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257643;
        bh=5vlIzUe1terjkQX+7PJwOvk8Li/L2QgptU7GQAaA6GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2Vu95+aRu1XbS+7n22+u3Bo7uTbAA33Gqje63fyy/DOlmf4toSzq5UpTJiBlH8IU
         /Fn34V3/GwkFFoLlmzb+TUacBpy11W9TX5BujuXdszfVcsqwoSJpjvqs2SExXJCl0v
         FC6bNB6OE5nXuww0goF+dqA8UN9cLLuSq96a2sFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "He, Bo" <bo.he@intel.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "xiao, jin" <jin.xiao@intel.com>, Jie A <jie.a.bai@intel.com>
Subject: [PATCH 4.9 113/118] rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
Date:   Fri, 22 Mar 2019 12:16:25 +0100
Message-Id: <20190322111224.272969383@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 kernel/rcu/tree.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1718,15 +1718,23 @@ static int rcu_future_gp_cleanup(struct
 }
 
 /*
- * Awaken the grace-period kthread for the specified flavor of RCU.
- * Don't do a self-awaken, and don't bother awakening when there is
- * nothing for the grace-period kthread to do (as in several CPUs
- * raced to awaken, and we lost), and finally don't try to awaken
- * a kthread that has not yet been created.
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
 static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 {
-	if (current == rsp->gp_kthread ||
+	if ((current == rsp->gp_kthread &&
+	     !in_interrupt() && !in_serving_softirq()) ||
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;


