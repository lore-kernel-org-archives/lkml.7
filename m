Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2A8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF92207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfFMPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:06:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732425AbfFMOK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:10:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0DDEB0324DE52C9396E;
        Thu, 13 Jun 2019 22:10:42 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Jun 2019 22:10:34 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <vvs@virtuozzo.com>, <adobriyan@sw.ru>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <mingo@kernel.org>,
        <viresh.kumar@linaro.org>, <luto@kernel.org>,
        <arjan@linux.intel.com>, <Nadia.Derbey@bull.net>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <stern@rowland.harvard.edu>, <paulmck@linux.vnet.ibm.com>,
        <masami.hiramatsu.pt@hitachi.com>, <alex.huangjianhui@huawei.com>,
        <dylix.dailei@huawei.com>
Subject: [PATCH] kernel/notifier.c: remove notifier_chain_register
Date:   Thu, 13 Jun 2019 22:07:44 +0800
Message-ID: <1560434864-98664-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registering the same notifier to a hook repeatedly can cause the hook
list to form a ring or lose other members of the list.

case1: An infinite loop in notifier_chain_register can cause soft lockup
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier2);

case2: An infinite loop in notifier_chain_register can cause soft lockup
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
	atomic_notifier_call_chain(&test_notifier_list, 0, NULL);

case3: lose other hook "test_notifier2"
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier2);
	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);

case4: Unregister returns 0, but the hook is still in the linked list,
	and it is not really registered. If you call notifier_call_chain
	after ko is unloaded, it will trigger oops.

If the system is configured with softlockup_panic and the same
hook is repeatedly registered on the panic_notifier_list, it
will cause a loop panic.

The only difference between notifier_chain_cond_register and
notifier_chain_register is that a check is added in order to
avoid registering the same notifier multiple times to the same hook.
So consider removing notifier_chain_register and replacing it
with notifier_chain_cond_register.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 kernel/notifier.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index d9f5081..56efd54 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -19,20 +19,6 @@
  *	are layered on top of these, with appropriate locking added.
  */
 
-static int notifier_chain_register(struct notifier_block **nl,
-		struct notifier_block *n)
-{
-	while ((*nl) != NULL) {
-		WARN_ONCE(((*nl) == n), "double register detected");
-		if (n->priority > (*nl)->priority)
-			break;
-		nl = &((*nl)->next);
-	}
-	n->next = *nl;
-	rcu_assign_pointer(*nl, n);
-	return 0;
-}
-
 static int notifier_chain_cond_register(struct notifier_block **nl,
 		struct notifier_block *n)
 {
@@ -127,7 +113,7 @@ int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 	int ret;
 
 	spin_lock_irqsave(&nh->lock, flags);
-	ret = notifier_chain_register(&nh->head, n);
+	ret = notifier_chain_cond_register(&nh->head, n);
 	spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
@@ -223,10 +209,10 @@ int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 	 * such times we must not call down_write().
 	 */
 	if (unlikely(system_state == SYSTEM_BOOTING))
-		return notifier_chain_register(&nh->head, n);
+		return notifier_chain_cond_register(&nh->head, n);
 
 	down_write(&nh->rwsem);
-	ret = notifier_chain_register(&nh->head, n);
+	ret = notifier_chain_cond_register(&nh->head, n);
 	up_write(&nh->rwsem);
 	return ret;
 }
@@ -349,7 +335,7 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *n)
 {
-	return notifier_chain_register(&nh->head, n);
+	return notifier_chain_cond_register(&nh->head, n);
 }
 EXPORT_SYMBOL_GPL(raw_notifier_chain_register);
 
@@ -431,10 +417,10 @@ int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 	 * such times we must not call mutex_lock().
 	 */
 	if (unlikely(system_state == SYSTEM_BOOTING))
-		return notifier_chain_register(&nh->head, n);
+		return notifier_chain_cond_register(&nh->head, n);
 
 	mutex_lock(&nh->mutex);
-	ret = notifier_chain_register(&nh->head, n);
+	ret = notifier_chain_cond_register(&nh->head, n);
 	mutex_unlock(&nh->mutex);
 	return ret;
 }
-- 
1.8.5.6

