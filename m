Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E2DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7896D207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfFMO7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732599AbfFMOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:50:42 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hbR3m-0002Ty-OH; Thu, 13 Jun 2019 16:50:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/6] sched/swait: Add swait_event_lock_irq()
Date:   Thu, 13 Jun 2019 16:50:25 +0200
Message-Id: <20190613145027.27753-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613145027.27753-1-bigeasy@linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The swait_event_lock_irq() is inspired by wait_event_lock_irq(). This is
required by the workqueue code once it switches to swait.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swait.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 73e06e9986d4b..12612823c2cb1 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -297,4 +297,18 @@ do {									\
 	__ret;								\
 })
 
+#define __swait_event_lock_irq(wq, condition, lock, cmd)		\
+	___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,		\
+		       raw_spin_unlock_irq(&lock);			\
+		       cmd;						\
+		       schedule();					\
+		       raw_spin_lock_irq(&lock))
+
+#define swait_event_lock_irq(wq_head, condition, lock)			\
+	do {								\
+		if (condition)						\
+			break;						\
+		__swait_event_lock_irq(wq_head, condition, lock, );	\
+	} while (0)
+
 #endif /* _LINUX_SWAIT_H */
-- 
2.20.1

