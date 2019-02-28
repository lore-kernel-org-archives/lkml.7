Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E92C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FB6218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374056;
	bh=ryMzaKrvgs0ai/reGrKgJBh40oSjaRZlvJQR2jggfAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2+vkoQdeXb7YQnzrwVIllCM2WmCFHWmqnzCCvg6UNXfYVkfTlg1eU8zNUiXTgBTC
	 Fj0TJIvGejsarec4K5pHzIAj+ZN/iWaAO9++/G26+TxhvAwlD7msfPEkUDSZcCUAzK
	 9qpAtVOWA5j7fyC7zuAKfyYgpyCO34Yg6tKt2CA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfB1ROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732446AbfB1ROM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:12 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A8F20857;
        Thu, 28 Feb 2019 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374051;
        bh=ryMzaKrvgs0ai/reGrKgJBh40oSjaRZlvJQR2jggfAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7MEV6QMmqbWXURV4Qi5u1z/8zpE103YVx96eIsC22jhXahB3oc0AullbQl8CNdFC
         DpFG6q62IE+iKGhcdskqDDHE9GUNHT3DQcbZblZgtncJ1+KRdHp3WgLqNX2dP4K7By
         vnsAU4KXQUihAFiY1V1i7ngxngMkfA3eHdeSUPZE=
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
Subject: [PATCH 23/37] x86: Init softirq enabled field
Date:   Thu, 28 Feb 2019 18:12:28 +0100
Message-Id: <20190228171242.32144-24-frederic@kernel.org>
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

Reviewed-by: David S. Miller <davem@davemloft.net>
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
 arch/x86/kernel/irq.c       | 5 ++++-
 include/linux/bottom_half.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2ea7c2f..b859861733a4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/bottom_half.h>
 
 #include <asm/apic.h>
 #include <asm/io_apic.h>
@@ -22,7 +23,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
 
-DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat) = {
+	.__softirq_data = SOFTIRQ_DATA_INIT,
+};
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 DEFINE_PER_CPU(struct pt_regs *, irq_regs);
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 39aaf9189226..240419382978 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -26,6 +26,8 @@ enum
 #define SOFTIRQ_ENABLED_SHIFT 16
 #define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
 
+#define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
+
 
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.21.0

