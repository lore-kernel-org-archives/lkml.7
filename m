Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021AECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857C7206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfJKRJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:09:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40872 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:09:09 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIyOv-0002WN-J8; Fri, 11 Oct 2019 18:08:25 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIyOv-0007sJ-5L; Fri, 11 Oct 2019 18:08:25 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: add declarations of undeclared items
Date:   Fri, 11 Oct 2019 18:08:24 +0100
Message-Id: <20191011170824.30228-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_state, rcu_rnp_online_cpus and rcu_dynticks_curr_cpu_in_eqs
do not have declarations in a header. Add these to remove the
following sparse warnings:

kernel/rcu/tree.c:87:18: warning: symbol 'rcu_state' was not declared. Should it be static?
kernel/rcu/tree.c:191:15: warning: symbol 'rcu_rnp_online_cpus' was not declared. Should it be static?
kernel/rcu/tree.c:297:6: warning: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/rcu/tree.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c612f306fe89..1f88351b9014 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -352,6 +352,8 @@ struct rcu_state {
 						/*  GP pre-initialization. */
 };
 
+extern struct rcu_state rcu_state;
+
 /* Values for rcu_state structure's gp_flags field. */
 #define RCU_GP_FLAG_INIT 0x1	/* Need grace-period initialization. */
 #define RCU_GP_FLAG_FQS  0x2	/* Need grace-period quiescent-state forcing. */
@@ -472,3 +474,7 @@ static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
 static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 				     const unsigned long gpssdelay);
+
+extern unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp);
+extern bool rcu_dynticks_curr_cpu_in_eqs(void);
+
-- 
2.23.0

