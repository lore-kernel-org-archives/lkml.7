Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D80C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559A2218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374058;
	bh=toSgyL4nbokHqwCJ0u+iAI+99QqXU7IePRtCQEwT/ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOIG6nvOwXNHY5bc36mepN9tpGWiL0yCW+8JzrTxLs+1bH9JW/ABOMBp0RWKVruDK
	 tV0SCynyznHG32k14Y/14TTHg5UWaRw+LC4b0t4nkVA8t5io4K22ZOo1xEjxB3gU6b
	 Ia2jDcteVxrfQmhEy2vzV3isbS60YRwGOYMmONqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfB1ROQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387913AbfB1ROP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:15 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C3F218D3;
        Thu, 28 Feb 2019 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374055;
        bh=toSgyL4nbokHqwCJ0u+iAI+99QqXU7IePRtCQEwT/ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wW3u+ARrUKkueJpvYMHQQJJ7GWhdUARQBF+xFKooBfYZE3HM+meEXt2kG6q3KiJrh
         72Asw6p1Yg2rkSWykE3Oy+5L/Njvc0bxxmiiLwcUrHmlhiTvp49SEWvKKNgSyiR+kI
         5XGvm0fEvL7L15trOPKSKiEvr83P6P9rOHpCz9CY=
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
Subject: [PATCH 24/37] parisc: Init softirq enabled field
Date:   Thu, 28 Feb 2019 18:12:29 +0100
Message-Id: <20190228171242.32144-25-frederic@kernel.org>
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
 arch/parisc/kernel/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0ca254085a66..b905a7e8e556 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -28,6 +28,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
 #include <linux/types.h>
+#include <linux/bottom_half.h>
 #include <asm/io.h>
 
 #include <asm/smp.h>
@@ -152,7 +153,10 @@ static struct irq_chip cpu_interrupt_type = {
 	.irq_retrigger	= NULL,
 };
 
-DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat) = {
+	.__softirq_data = SOFTIRQ_DATA_INIT,
+};
+
 #define irq_stats(x)		(&per_cpu(irq_stat, x))
 
 /*
-- 
2.21.0

