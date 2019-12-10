Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B62C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8648F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950899;
	bh=1EDFsKq10v2RAcv+ouUFckwgU2L7K+cLnN0yoZBQRvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GwDohKe1CofLb439yLyE7MKk1CyiATyoGMeTdbrMOx2ezgB+osivlPT7j3L6MZbH6
	 /3Ii/LlIG7AzpQSNb9gUHrQjARbtQGM2aaPeUnE/jvBA6gJgZ4lKAvzhIvzLcywpsd
	 Tpb9A4Prd7sZVYdZjP2PtDaRIlrbVxqUVWa5/c2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLJEIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:08:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfLJEHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DD2214D8;
        Tue, 10 Dec 2019 04:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950867;
        bh=1EDFsKq10v2RAcv+ouUFckwgU2L7K+cLnN0yoZBQRvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quOhZVYH43vcx6t9ug2xhRcRopYbRvxgdl1776/UXJlpL/vWZnzlVk3JtOv5u28VY
         VfVmv3kRYwguiXtdzKaIpUlgo6HCbTXteDTeNlICu2sFayOv/lneapm9djqQpvhA/n
         ZvEqrK3Tz1dUSb60DgNFMHMlvjSy4WatZtCer6uQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/12] rcu: Move gp_state_names[] and gp_state_getname() to tree_stall.h
Date:   Mon,  9 Dec 2019 20:07:35 -0800
Message-Id: <20191210040741.2943-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Only tree_stall.h needs to get name from GP state, so this commit
moves the gp_state_names[] array and the gp_state_getname()
from kernel/rcu/tree.h and kernel/rcu/tree.c, respectively, to
kernel/rcu/tree_stall.h.  While moving gp_state_names[], this commit
uses the GCC syntax to ensure that the right string is associated with
the right CPP macro.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 10 ----------
 kernel/rcu/tree.h       | 12 ------------
 kernel/rcu/tree_stall.h | 22 ++++++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ba154a3..bbb60ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -529,16 +529,6 @@ static struct rcu_node *rcu_get_root(void)
 }
 
 /*
- * Convert a ->gp_state value to a character string.
- */
-static const char *gp_state_getname(short gs)
-{
-	if (gs < 0 || gs >= ARRAY_SIZE(gp_state_names))
-		return "???";
-	return gp_state_names[gs];
-}
-
-/*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 54ff989..9d5986a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -368,18 +368,6 @@ struct rcu_state {
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
index c0b8c45..f18adaf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -279,6 +279,28 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 
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
2.9.5

