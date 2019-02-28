Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE57218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374034;
	bh=izsgkwMaFBPC1U7kABLWjGZrETM1VE9Z1DwdN+FSV7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zXqN6Z3RZtI9oQaiW9oLIQs81BROuvJghNeEGymYps3SyNiKC8XBQ+A7lICyIV2NK
	 cDbO6ukHPhZzlPYITE982QMqhiqTFCN2BWalOj7+d4wEsZloyrXtOJMfxBhh7ggoUY
	 4/RkYtDZ4M4uFYCtqoCeg3seP4B9JJATb2FvO/2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfB1RNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbfB1RNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:47 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E60218D0;
        Thu, 28 Feb 2019 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374027;
        bh=izsgkwMaFBPC1U7kABLWjGZrETM1VE9Z1DwdN+FSV7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4D0dLT7YuTTxCB4Nfdl9hkalANlQX8/d1zls5m5UmvrX1GhRVN5Ie04wa9fq3Ejv
         Vom5gjFYQNaLvvmsSkbp+PUw9OYqMQ16e5BoGmjymebTWuG8Q4Kbc6QYtwV9XLY1Y1
         Qni0WbVw+IU0Nm2LKDeeA07LZuChBQ6xposhXWQE=
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
Subject: [PATCH 16/37] x86: Revert "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"
Date:   Thu, 28 Feb 2019 18:12:21 +0100
Message-Id: <20190228171242.32144-17-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9aee5f8a7e30330d0a8f4c626dc924ca5590aba5.

We are going to need the 16 high bits above in order to implement
a softirq enable mask. x86 is the only architecture that doesn't use
unsigned int to implement softirq_pending.

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
 arch/x86/include/asm/hardirq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb26c7f..a8e8e126b421 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	u16	     __softirq_pending;
+	unsigned int __softirq_pending;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
-- 
2.21.0

