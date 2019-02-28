Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E10C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A9320857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374083;
	bh=9Q0E84amZ9sdm9Q1KDNlgRDxzEPd3N/fDr882Iag6VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rxg0Yu4I9XqidOSKh6GP61QkiJVYai6az5Ow+CHJ7SwERCIIXm3PE50q9tdlwfU4q
	 Yj6ZGrGmn/ChWcP4Htc/ZAd4PyqGb70bhCdVW82agZ2khT/KWBIJ9XUHjU1w4S7kJb
	 f1DP33sCVDtQaMvqshYCUL2oMN5Pk4+d3/mcKmvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbfB1ROl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfB1ROh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:37 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22138218CD;
        Thu, 28 Feb 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374077;
        bh=9Q0E84amZ9sdm9Q1KDNlgRDxzEPd3N/fDr882Iag6VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n58478zbPSntqTulCpubGaD+Ts1GQnPgROA8/JGjHA1cn9XEkL/v58ITmpgUqjHQy
         Sjh82/aU/PRp1Itg8iJ4wVzjjwkVLtTK/etszTI+L0+ZQQHUy4kqHhT5kFQkHw8aFx
         +yoQW4sF9tAzCcVFkkor8ZP6wdekKbvwvXUdU040=
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
Subject: [PATCH 30/37] softirq: Prepare for mixing all/per-vector masking
Date:   Thu, 28 Feb 2019 18:12:35 +0100
Message-Id: <20190228171242.32144-31-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to mix and nest full and per vector softirq masking,
we need to be able to track the nesting state using a "full masking"
counter and a mask of "individual disabled vectors".

Start with introducing the full masking counter. For now it's a simple
mirror of softirq_count() because there is no per vector masking API
yet.

When this full masking counter is non 0, all softirq vectors are
explicitly disabled.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
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
 kernel/softirq.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 40aa915c5e4a..2cddaaff3bfa 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -59,6 +59,12 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+struct softirq_nesting {
+	unsigned int disabled_all;
+};
+
+static DEFINE_PER_CPU(struct softirq_nesting, softirq_nesting);
+
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
@@ -120,11 +126,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * call the trace_preempt_off later.
 	 */
 	__preempt_count_add(cnt);
-	/*
-	 * Were softirqs turned off above:
-	 */
-	if (softirq_count() == (cnt & SOFTIRQ_MASK))
+
+	if (__this_cpu_inc_return(softirq_nesting.disabled_all) == 1) {
+		softirq_enabled_clear_mask(SOFTIRQ_ALL_MASK);
 		trace_softirqs_off(ip);
+	}
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	raw_local_irq_restore(flags);
@@ -139,6 +145,15 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
+static void local_bh_enable_common(unsigned long ip, unsigned int cnt)
+{
+	if (__this_cpu_dec_return(softirq_nesting.disabled_all))
+		return;
+
+	softirq_enabled_set(SOFTIRQ_ALL_MASK);
+	trace_softirqs_on(ip);
+}
+
 static void __local_bh_enable_no_softirq(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
@@ -146,8 +161,7 @@ static void __local_bh_enable_no_softirq(unsigned int cnt)
 	if (preempt_count() == cnt)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
-	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_on(_RET_IP_);
+	local_bh_enable_common(_RET_IP_, cnt);
 
 	__preempt_count_sub(cnt);
 }
@@ -170,11 +184,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
 #endif
-	/*
-	 * Are softirqs going to be turned on now:
-	 */
-	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
-		trace_softirqs_on(ip);
+	local_bh_enable_common(ip, cnt);
+
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
-- 
2.21.0

