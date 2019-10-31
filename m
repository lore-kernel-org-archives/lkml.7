Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B33CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38521D80
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfJaL6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:58:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55292 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfJaLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92c-0002wq-MM; Thu, 31 Oct 2019 12:55:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 69BF41C04E3;
        Thu, 31 Oct 2019 12:54:59 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:59 -0000
From:   "tip-bot2 for kbuild test robot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Several rcu_segcblist functions can be static
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289915.29376.99377795403979638.tip-bot2@tip-bot2>
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

Commit-ID:     1d24dd4e01fb6b928cf679e3e415ddff7016fa96
Gitweb:        https://git.kernel.org/tip/1d24dd4e01fb6b928cf679e3e415ddff7016fa96
Author:        kbuild test robot <lkp@intel.com>
AuthorDate:    Thu, 08 Aug 2019 10:32:58 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:33:22 -07:00

rcu: Several rcu_segcblist functions can be static

None of rcu_segcblist_set_len(), rcu_segcblist_add_len(), or
rcu_segcblist_xchg_len() are used outside of kernel/rcu/rcu_segcblist.c.
This commit therefore makes them static.

Fixes: eda669a6a2c5 ("rcu/nocb: Atomic ->len field in rcu_segcblist structure")
Signed-off-by: kbuild test robot <lkp@intel.com>
[ paulmck: "Fixes:" updated per Stephen Rothwell feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 495c58c..cbc87b8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -88,7 +88,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 }
 
 /* Set the length of an rcu_segcblist structure. */
-void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_set(&rsclp->len, v);
@@ -104,7 +104,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
@@ -134,7 +134,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
  * with the actual number of callbacks on the structure.  This exchange is
  * fully ordered with respect to the callers accesses both before and after.
  */
-long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
+static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	return atomic_long_xchg(&rsclp->len, v);
