Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1855C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF4A20857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374132;
	bh=WzhgAWb/SVHc+B7+792CEOlZ8yVPd9OraEcnp6B2LQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keqwo12gPb81mL1jPPj92GoSvlOw+drfbG+DBjq/mS92rkDsevebp2E67BgUyp7Qs
	 ztjSfT1w8u8DB77e3lBf1CcjWN/j4tKV9HvzjE56Iw+tyk5W9/yIA1VjR/OE1lY9Yp
	 7PorpHhrOm2pf68v3XSEEyNSRhbtSHdSuMb0sQMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbfB1RPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733219AbfB1ROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:34 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945C7218D3;
        Thu, 28 Feb 2019 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374073;
        bh=WzhgAWb/SVHc+B7+792CEOlZ8yVPd9OraEcnp6B2LQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWXEuuLCz1t0f1Xy9wUIioCBAnEt4+UIuPPnAAKwBzxC/TWPxFKwtAgvkcr647oNH
         vDhGBKR1KitjD26sBxLMpKia6gSEF13dkypW0RKqQD0XpIuxOG2ED97EuAAbNYoVDQ
         RQa1u1Zw8kPHpicbFENDs5nRtMrzLzNaEyvOz/oA=
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
Subject: [PATCH 29/37] softirq: Uninline !CONFIG_TRACE_IRQFLAGS __local_bh_disable_ip()
Date:   Thu, 28 Feb 2019 18:12:34 +0100
Message-Id: <20190228171242.32144-30-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common code between both versions of __local_bh_disable_ip(), whether
CONFIG_TRACE_IRQFLAGS is on or off, is going to grow up in order to
support vector masking granularity.

Merge these versions together to prepare for that.

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
 include/linux/bottom_half.h | 10 ----------
 kernel/softirq.c            | 10 ++++++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 240419382978..ef9e4c752f56 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -28,17 +28,7 @@ enum
 
 #define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
 
-
-
-#ifdef CONFIG_TRACE_IRQFLAGS
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
-#else
-static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
-{
-	preempt_count_add(cnt);
-	barrier();
-}
-#endif
 
 static inline void local_bh_disable(void)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 60d1706ad47e..40aa915c5e4a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -104,14 +104,14 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
+#ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
 
-	WARN_ON_ONCE(in_irq());
-
 	raw_local_irq_save(flags);
+#endif
+	WARN_ON_ONCE(in_irq());
 	/*
 	 * The preempt tracer hooks into preempt_count_add and will break
 	 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
@@ -125,7 +125,10 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_off(ip);
+
+#ifdef CONFIG_TRACE_IRQFLAGS
 	raw_local_irq_restore(flags);
+#endif
 
 	if (preempt_count() == cnt) {
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -135,7 +138,6 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
-#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void __local_bh_enable_no_softirq(unsigned int cnt)
 {
-- 
2.21.0

