Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0583C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718EC218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374067;
	bh=55jyxrZrBwXb/jgF4n4BurbQDJb2KFxnjdY9X9yhwAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDsYQvqA1PZP5LwEKToYdlPBasPy22obZNaOnKDTE020LDNEUyR28jFAYqg99UlFI
	 EAAxTvGkA/2M4HSwemXD3TzmwAMCU2jwX4N1U4zVUnllPFQQ9BPbY4+EoOgWxZg5m1
	 7KpHxaUBJdubu62xY+rVqmANrdRSF5xecZLAwiZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfB1RO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbfB1ROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:22 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC8E20857;
        Thu, 28 Feb 2019 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374062;
        bh=55jyxrZrBwXb/jgF4n4BurbQDJb2KFxnjdY9X9yhwAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6m/QvZv8AunKawLU1WbRVbyEa5YTm6Y7DiwdUyzXENhirdKPfik3aM3oaWiBLQmH
         04pgjKd2H4bZpXuK29YVa4FhHxdxXGbM2A2fYXvXWpu/XWYMSCjSQOytZVq77Y2E8E
         3bktCojpUZBJ5kAXRn2DIP0CClH/8eT6K5qgQeq0=
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
Subject: [PATCH 26/37] softirq: Init softirq enabled field for default irq_stat definition
Date:   Thu, 28 Feb 2019 18:12:31 +0100
Message-Id: <20190228171242.32144-27-frederic@kernel.org>
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
 kernel/softirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d305b4c8d1a7..e957615102dc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -49,7 +49,9 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat) = {
+	.__softirq_data = SOFTIRQ_DATA_INIT,
+};
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
 
-- 
2.21.0

