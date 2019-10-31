Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB9CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBB62173E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJaL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:58:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJaLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92a-0002vh-MF; Thu, 31 Oct 2019 12:55:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AFB2F1C03AD;
        Thu, 31 Oct 2019 12:54:58 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:58 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Ensure that ->rcu_urgent_qs is set before resched IPI
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289837.29376.5576201849355844371.tip-bot2@tip-bot2>
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

Commit-ID:     05ef9e9eb3dade21413680f41eb0170778e8ae2b
Gitweb:        https://git.kernel.org/tip/05ef9e9eb3dade21413680f41eb0170778e8ae2b
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 15 Aug 2019 22:59:14 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:34:35 -07:00

rcu: Ensure that ->rcu_urgent_qs is set before resched IPI

The RCU-specific resched_cpu() function sends a resched IPI to the
specified CPU, which can be used to force the tick on for a given
nohz_full CPU.  This is needed when this nohz_full CPU is looping in the
kernel while blocking the current grace period.  However, for the tick
to actually be forced on in all cases, that CPU's rcu_data structure's
->rcu_urgent_qs flag must be set beforehand.  This commit therefore
causes rcu_implicit_dynticks_qs() to set this flag prior to invoking
resched_cpu() on a holdout nohz_full CPU.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8110514..0d83b19 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1073,6 +1073,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
