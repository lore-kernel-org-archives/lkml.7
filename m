Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64919C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368E1218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374063;
	bh=hNKftEXXHvtqaBHTShYRikXWXOm5SUg5WfrIdoRwzh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tsmL0E4WXbFvIl+/w1T6XXYfLtR5xHDJAx56cHABWFBlqsahBlXD9nyelbmloWk3w
	 54EXorXv5fe9EFS9OcBxH6y6+wj5/uOB69IU0aEDsHHkYNZNnIbKbr5ZbIANq+kfbV
	 gURemG9qvqxdjqAH4ZHi/O9R/aXp09k6M2cTyats=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfB1ROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387913AbfB1ROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:19 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE2F218AE;
        Thu, 28 Feb 2019 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374058;
        bh=hNKftEXXHvtqaBHTShYRikXWXOm5SUg5WfrIdoRwzh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHYy1dYDkUI8L4HJBKH/aLKwkMEPN1Q2ito1Bagx1RS3QMyWWejq+P2E3nrqNiruh
         xQ9KBxvqLpxkjGlMKxic3XYQyMtn1fMIOpgYMfRi37PrA6vra3c8N/SmwJjSD7u9/a
         lk2MU7sXg651rRPtY3qInip8UPPfC8uqUyWpyEdo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 25/37] powerpc: Init softirq enabled field
Date:   Thu, 28 Feb 2019 18:12:30 +0100
Message-Id: <20190228171242.32144-26-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

All softirqs must be set enabled on boot.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
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
 arch/powerpc/kernel/irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 916ddc4aac44..f5e35bbc2804 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -54,6 +54,7 @@
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/bottom_half.h>
 
 #include <linux/uaccess.h>
 #include <asm/io.h>
@@ -78,7 +79,9 @@
 #include <asm/trace.h>
 #include <asm/cpu_has_feature.h>
 
-DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat) = {
+	.__softirq_data = SOFTIRQ_DATA_INIT,
+};
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 int __irq_offset_value;
-- 
2.21.0

