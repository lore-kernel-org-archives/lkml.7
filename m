Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A378420857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374159;
	bh=sozJU/5OlzrK/deFVRBigGuvn3Yn9Yat/RlMQ7ceFSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+R0rROesfW8tUTryiuBKJKz3IfvLkjCXt1gP0gNKqRUoY/2/vAM1La1kEDs9vKxf
	 q+Vlq4gtcibnuZ+W3qnyE70VV2CLY6LeDmB4Z9KbPJHj2SIBSRa2sTC9QC3jadaw8L
	 BIQvXK5/PTfSxrfAJLLo49Ilr0EIc5GevM1tB8pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfB1RP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbfB1RNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:37 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99BE218D8;
        Thu, 28 Feb 2019 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374016;
        bh=sozJU/5OlzrK/deFVRBigGuvn3Yn9Yat/RlMQ7ceFSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWGFW4dlNAunUxQ24fb1LqJiGASnNRuKOgj7s610PqCc9HEvYUuQVZdtqa8bHmrs/
         PFnRp7AmihbREqdvCmtihC8Y3Fierx5SCgvz9sOclv3+EjmIKy0JgZhXxNrsZxLR+n
         lnpJLhM94q616k8ESpiQir6BDOZpniUmlMaqC0+A=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 13/37] softirq: Macrofy softirq vectors
Date:   Thu, 28 Feb 2019 18:12:18 +0100
Message-Id: <20190228171242.32144-14-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the softirq vectors through macros so that we can later include
them in the automated definition of lockdep usage states.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/interrupt.h      | 17 ++++-------------
 include/linux/softirq_vector.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/softirq_vector.h

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..e871f361f1f1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -474,21 +474,12 @@ extern bool force_irqthreads;
    tasklets are more than enough. F.e. all serial device BHs et
    al. should be converted to tasklets, not to softirqs.
  */
-
 enum
 {
-	HI_SOFTIRQ=0,
-	TIMER_SOFTIRQ,
-	NET_TX_SOFTIRQ,
-	NET_RX_SOFTIRQ,
-	BLOCK_SOFTIRQ,
-	IRQ_POLL_SOFTIRQ,
-	TASKLET_SOFTIRQ,
-	SCHED_SOFTIRQ,
-	HRTIMER_SOFTIRQ, /* Unused, but kept as tools rely on the
-			    numbering. Sigh! */
-	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
-
+#define SOFTIRQ_VECTOR(__SVEC) \
+	__SVEC##_SOFTIRQ,
+#include <linux/softirq_vector.h>
+#undef SOFTIRQ_VECTOR
 	NR_SOFTIRQS
 };
 
diff --git a/include/linux/softirq_vector.h b/include/linux/softirq_vector.h
new file mode 100644
index 000000000000..c0308cbc916f
--- /dev/null
+++ b/include/linux/softirq_vector.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+SOFTIRQ_VECTOR(HI)
+SOFTIRQ_VECTOR(TIMER)
+SOFTIRQ_VECTOR(NET_TX)
+SOFTIRQ_VECTOR(NET_RX)
+SOFTIRQ_VECTOR(BLOCK)
+SOFTIRQ_VECTOR(IRQ_POLL)
+SOFTIRQ_VECTOR(TASKLET)
+SOFTIRQ_VECTOR(SCHED)
+SOFTIRQ_VECTOR(HRTIMER)
+SOFTIRQ_VECTOR(RCU)    /* Preferable RCU should always be the last softirq */
-- 
2.21.0

