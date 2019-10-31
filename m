Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4738CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CB821734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfJaL6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:58:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55293 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfJaLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92d-0002uN-Iz; Thu, 31 Oct 2019 12:55:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E62AD1C04D7;
        Thu, 31 Oct 2019 12:54:57 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:57 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Update descriptions for rcu_nocb_wake tracepoint
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289767.29376.2910308882156136502.tip-bot2@tip-bot2>
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

Commit-ID:     d01f86206864e429839f6a4aeb90064f0c043ed9
Gitweb:        https://git.kernel.org/tip/d01f86206864e429839f6a4aeb90064f0c043ed9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 21 Aug 2019 10:29:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:34:52 -07:00

rcu: Update descriptions for rcu_nocb_wake tracepoint

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index afa8985..4609f2e 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -258,20 +258,27 @@ TRACE_EVENT_RCU(rcu_exp_funnel_lock,
  * the number of the offloaded CPU are extracted.  The third and final
  * argument is a string as follows:
  *
- *	"WakeEmpty": Wake rcuo kthread, first CB to empty list.
- *	"WakeEmptyIsDeferred": Wake rcuo kthread later, first CB to empty list.
- *	"WakeOvf": Wake rcuo kthread, CB list is huge.
- *	"WakeOvfIsDeferred": Wake rcuo kthread later, CB list is huge.
- *	"WakeNot": Don't wake rcuo kthread.
- *	"WakeNotPoll": Don't wake rcuo kthread because it is polling.
- *	"DeferredWake": Carried out the "IsDeferred" wakeup.
- *	"Poll": Start of new polling cycle for rcu_nocb_poll.
- *	"Sleep": Sleep waiting for GP for !rcu_nocb_poll.
- *	"CBSleep": Sleep waiting for CBs for !rcu_nocb_poll.
- *	"WokeEmpty": rcuo kthread woke to find empty list.
- *	"WokeNonEmpty": rcuo kthread woke to find non-empty list.
- *	"WaitQueue": Enqueue partially done, timed wait for it to complete.
- *	"WokeQueue": Partial enqueue now complete.
+ * "AlreadyAwake": The to-be-awakened rcuo kthread is already awake.
+ * "Bypass": rcuo GP kthread sees non-empty ->nocb_bypass.
+ * "CBSleep": rcuo CB kthread sleeping waiting for CBs.
+ * "Check": rcuo GP kthread checking specified CPU for work.
+ * "DeferredWake": Timer expired or polled check, time to wake.
+ * "DoWake": The to-be-awakened rcuo kthread needs to be awakened.
+ * "EndSleep": Done waiting for GP for !rcu_nocb_poll.
+ * "FirstBQ": New CB to empty ->nocb_bypass (->cblist maybe non-empty).
+ * "FirstBQnoWake": FirstBQ plus rcuo kthread need not be awakened.
+ * "FirstBQwake": FirstBQ plus rcuo kthread must be awakened.
+ * "FirstQ": New CB to empty ->cblist (->nocb_bypass maybe non-empty).
+ * "NeedWaitGP": rcuo GP kthread must wait on a grace period.
+ * "Poll": Start of new polling cycle for rcu_nocb_poll.
+ * "Sleep": Sleep waiting for GP for !rcu_nocb_poll.
+ * "Timer": Deferred-wake timer expired.
+ * "WakeEmptyIsDeferred": Wake rcuo kthread later, first CB to empty list.
+ * "WakeEmpty": Wake rcuo kthread, first CB to empty list.
+ * "WakeNot": Don't wake rcuo kthread.
+ * "WakeNotPoll": Don't wake rcuo kthread because it is polling.
+ * "WakeOvfIsDeferred": Wake rcuo kthread later, CB list is huge.
+ * "WokeEmpty": rcuo CB kthread woke to find empty list.
  */
 TRACE_EVENT_RCU(rcu_nocb_wake,
 
