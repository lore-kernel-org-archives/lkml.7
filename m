Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9601E21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfJOK3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:29:00 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52155 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbfJOK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:28:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tf7U3jR_1571135333;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tf7U3jR_1571135333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 18:28:53 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 5/7] rcu: move gp_state_names[] and gp_state_getname() to tree_stall.h
Date:   Tue, 15 Oct 2019 10:28:47 +0000
Message-Id: <20191015102850.2079-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015102850.2079-1-laijs@linux.alibaba.com>
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
Reply-To: <20191015102402.1978-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only tree_stall.h needs to get name from GP state.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree.c       | 10 ----------
 kernel/rcu/tree.h       | 12 ------------
 kernel/rcu/tree_stall.h | 22 ++++++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7830d5a06e69..7db5ea06a9ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -529,16 +529,6 @@ static struct rcu_node *rcu_get_root(void)
 	return &rcu_state.node[0];
 }
 
-/*
- * Convert a ->gp_state value to a character string.
- */
-static const char *gp_state_getname(short gs)
-{
-	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
-		return "???";
-	return gp_state_names[gs];
-}
-
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 823f475c5e35..75ae55b6270a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -367,18 +367,6 @@ struct rcu_state {
 #define RCU_GP_CLEANUP   7	/* Grace-period cleanup started. */
 #define RCU_GP_CLEANED   8	/* Grace-period cleanup complete. */
 
-static const char * const gp_state_names[] = {
-	"RCU_GP_IDLE",
-	"RCU_GP_WAIT_GPS",
-	"RCU_GP_DONE_GPS",
-	"RCU_GP_ONOFF",
-	"RCU_GP_INIT",
-	"RCU_GP_WAIT_FQS",
-	"RCU_GP_DOING_FQS",
-	"RCU_GP_CLEANUP",
-	"RCU_GP_CLEANED",
-};
-
 /*
  * In order to export the rcu_state name to the tracing tools, it
  * needs to be added in the __tracepoint_string section.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 806f2ddc8f74..0b75426ebb3e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -277,6 +277,28 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 
 #endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
 
+static const char * const gp_state_names[] = {
+	[RCU_GP_IDLE] = "RCU_GP_IDLE",
+	[RCU_GP_WAIT_GPS] = "RCU_GP_WAIT_GPS",
+	[RCU_GP_DONE_GPS] = "RCU_GP_DONE_GPS",
+	[RCU_GP_ONOFF] = "RCU_GP_ONOFF",
+	[RCU_GP_INIT] = "RCU_GP_INIT",
+	[RCU_GP_WAIT_FQS] = "RCU_GP_WAIT_FQS",
+	[RCU_GP_DOING_FQS] = "RCU_GP_DOING_FQS",
+	[RCU_GP_CLEANUP] = "RCU_GP_CLEANUP",
+	[RCU_GP_CLEANED] = "RCU_GP_CLEANED",
+};
+
+/*
+ * Convert a ->gp_state value to a character string.
+ */
+static const char *gp_state_getname(short gs)
+{
+	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
+		return "???";
+	return gp_state_names[gs];
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
-- 
2.20.1

