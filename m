Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA23CC5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC2620659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfGHGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:01:03 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:37352 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfGHGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:01:03 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 8 Jul 2019 15:01:01 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 8 Jul 2019 15:01:01 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Make jiffies_till_sched_qs writable
Date:   Mon,  8 Jul 2019 15:00:09 +0900
Message-Id: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiffies_till_sched_qs is useless if it's readonly as it is used to set
jiffies_to_sched_qs with its value regardless of first/next fqs jiffies.
And it should be applied immediately on change through sysfs.

The function for setting jiffies_to_sched_qs,
adjust_jiffies_till_sched_qs() will be called only if
the value from sysfs != ULONG_MAX. And the value won't be adjusted
unlike first/next fqs jiffies.

While at it, changed the positions of two module_param()s downward.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a2f8ba2..a28e2fe 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -422,9 +422,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
  * quiescent-state help from rcu_note_context_switch().
  */
 static ulong jiffies_till_sched_qs = ULONG_MAX;
-module_param(jiffies_till_sched_qs, ulong, 0444);
 static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
-module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
 
 /*
  * Make sure that we give the grace-period kthread time to detect any
@@ -450,6 +448,18 @@ static void adjust_jiffies_till_sched_qs(void)
 	WRITE_ONCE(jiffies_to_sched_qs, j);
 }
 
+static int param_set_sched_qs_jiffies(const char *val, const struct kernel_param *kp)
+{
+	ulong j;
+	int ret = kstrtoul(val, 0, &j);
+
+	if (!ret && j != ULONG_MAX) {
+		WRITE_ONCE(*(ulong *)kp->arg, j);
+		adjust_jiffies_till_sched_qs();
+	}
+	return ret;
+}
+
 static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
 {
 	ulong j;
@@ -474,6 +484,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
+static struct kernel_param_ops sched_qs_jiffies_ops = {
+	.set = param_set_sched_qs_jiffies,
+	.get = param_get_ulong,
+};
+
 static struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
@@ -484,8 +499,11 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	.get = param_get_ulong,
 };
 
+module_param_cb(jiffies_till_sched_qs, &sched_qs_jiffies_ops, &jiffies_till_sched_qs, 0644);
 module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
 module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
+
+module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
 module_param(rcu_kick_kthreads, bool, 0644);
 
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
-- 
1.9.1

