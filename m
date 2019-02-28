Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CB020857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374141;
	bh=XwNDYzDNSvAIiSgclmH8vxgZ1FR1k1FhVt6zEFixBP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuDiNWlNVbCvgPuLNHWRj7kzDrOei8Qs3FI++vjfTcFExGFcPQqCOxplrBZcIw96B
	 OhZc5yYs6ScRwVHazUqO5VvQrkJ8tdYsB/K+KhC/sYV0lwgSd9GQHe1RRuEwWZ5yd7
	 CNx8/aXtSIlhoRjc7ZsBy9wvT9iOmFStgjwMDsO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfB1ROO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732613AbfB1ROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:09 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33F1218AE;
        Thu, 28 Feb 2019 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374047;
        bh=XwNDYzDNSvAIiSgclmH8vxgZ1FR1k1FhVt6zEFixBP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9V/MfCzRicq0kFJjm7aVLKxz66bakHXwX84/HFfHqE+XQZFflZ4keNAafgYTEZwl
         ez72z3F857hIOy/U9mmLqM8p4xl8zr06jfKktH+RFP9+UGS8w+WkD5b7P/AHPrlsOq
         0LJULh+5L10hPIm//dEamEY7ux069Ym+QC9lksvo=
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
Subject: [PATCH 22/37] softirq: Move vectors bits to bottom_half.h
Date:   Thu, 28 Feb 2019 18:12:27 +0100
Message-Id: <20190228171242.32144-23-frederic@kernel.org>
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

Using the bottom-half masking APIs defined in linux/bottom-half.h won't
be possible without passing the relevant softirq vectors that are
currently defined in linux/interrupt.h

Yet we can't include linux/interrupt.h from linux/bottom-half.h due to
circular dependencies.

Now the vector bits belong to bottom halves anyway, so moving them there
is more natural and avoid nasty header dances.

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
 include/linux/bottom_half.h | 24 ++++++++++++++++++++++++
 include/linux/interrupt.h   | 21 ---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a104f815efcf..39aaf9189226 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,30 @@
 
 #include <linux/preempt.h>
 
+
+/*
+ * PLEASE, avoid to allocate new softirqs, if you need not _really_ high
+ * frequency threaded job scheduling. For almost all the purposes
+ * tasklets are more than enough. F.e. all serial device BHs et
+ * al. should be converted to tasklets, not to softirqs.
+ */
+enum
+{
+#define SOFTIRQ_VECTOR(__SVEC) \
+	__SVEC##_SOFTIRQ,
+#include <linux/softirq_vector.h>
+#undef SOFTIRQ_VECTOR
+	NR_SOFTIRQS
+};
+
+#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
+
+#define SOFTIRQ_ENABLED_SHIFT 16
+#define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
+
+
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0c3590e4fcac..1f4bd62ae218 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -457,27 +457,6 @@ extern bool force_irqthreads;
 #define hard_irq_disable()	do { } while(0)
 #endif
 
-/* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
-   frequency threaded job scheduling. For almost all the purposes
-   tasklets are more than enough. F.e. all serial device BHs et
-   al. should be converted to tasklets, not to softirqs.
- */
-enum
-{
-#define SOFTIRQ_VECTOR(__SVEC) \
-	__SVEC##_SOFTIRQ,
-#include <linux/softirq_vector.h>
-#undef SOFTIRQ_VECTOR
-	NR_SOFTIRQS
-};
-
-#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
-#define SOFTIRQ_ALL_MASK (BIT(NR_SOFTIRQS) - 1)
-
-#define SOFTIRQ_ENABLED_SHIFT 16
-#define SOFTIRQ_PENDING_MASK (BIT(SOFTIRQ_ENABLED_SHIFT) - 1)
-
-
 #ifndef local_softirq_data
 
 #ifndef local_softirq_data_ref
-- 
2.21.0

