Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B3C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1E6216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfFZOww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:52:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48952 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfFZOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:52:49 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg9Hy-0004Rs-1K; Wed, 26 Jun 2019 16:52:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] workqueue: Make alloc/apply/free_workqueue_attrs() static
Date:   Wed, 26 Jun 2019 16:52:37 +0200
Message-Id: <20190626145238.19708-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626145238.19708-1-bigeasy@linutronix.de>
References: <[PATCH 0/2] Workqueeu code cleanup>
 <20190626145238.19708-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

None of those functions have any users outside of workqueue.c. Confine
them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/workqueue.h | 4 ----
 kernel/workqueue.c        | 7 +++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d59525fca4d37..b7c585b5ec1cb 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -435,10 +435,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
-struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask);
-void free_workqueue_attrs(struct workqueue_attrs *attrs);
-int apply_workqueue_attrs(struct workqueue_struct *wq,
-			  const struct workqueue_attrs *attrs);
 int workqueue_set_unbound_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 95aea04ff722f..b8fa7afe6e7d8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3329,7 +3329,7 @@ EXPORT_SYMBOL_GPL(execute_in_process_context);
  *
  * Undo alloc_workqueue_attrs().
  */
-void free_workqueue_attrs(struct workqueue_attrs *attrs)
+static void free_workqueue_attrs(struct workqueue_attrs *attrs)
 {
 	if (attrs) {
 		free_cpumask_var(attrs->cpumask);
@@ -3346,7 +3346,7 @@ void free_workqueue_attrs(struct workqueue_attrs *attrs)
  *
  * Return: The allocated new workqueue_attr on success. %NULL on failure.
  */
-struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask)
+static struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask)
 {
 	struct workqueue_attrs *attrs;
 
@@ -4033,7 +4033,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
  *
  * Return: 0 on success and -errno on failure.
  */
-int apply_workqueue_attrs(struct workqueue_struct *wq,
+static int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs)
 {
 	int ret;
@@ -4044,7 +4044,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(apply_workqueue_attrs);
 
 /**
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
-- 
2.20.1

