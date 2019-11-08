Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9349FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D51621924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573229369;
	bh=XH1045tMYe+K9HbmMd0qPKXHpNyh8RryBxSXENHeHbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5s3eCxGozBGjBlhA9WXFRwsPAjwCJwElYGYDF8sQW4TSPHBMxkv3+O4SKJ3/WtHU
	 IxM7q12Gz9BesyfvrCgXf1ZJrnEiMq0Llm2yq/EEsihBccYt2OcOUP7+nckQjZXlP+
	 WAOpOQAjY5MgDgntaNCAJRBhvL3+VbW9YGFaikgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfKHQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbfKHQJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:26 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756F622475;
        Fri,  8 Nov 2019 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573229365;
        bh=XH1045tMYe+K9HbmMd0qPKXHpNyh8RryBxSXENHeHbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fbwe+kKYtZbPru7xnexqYZU3rCZu07jeOMY28auKVHZ35xDF0dLCufWoiOKtABWGu
         yhRlgTCpnYarBViylj1pKHMiS4OC+SGLCQ0ZKpPozHa81DC3e+ScKX13mvGYGA7pSM
         3zt1Sns8Cyvp+DSbclW2Z9T86RkPZzL87gRLvDQc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] irq_work: Fix irq_work_claim() ordering
Date:   Fri,  8 Nov 2019 17:08:56 +0100
Message-Id: <20191108160858.31665-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108160858.31665-1-frederic@kernel.org>
References: <20191108160858.31665-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq_work_claim() finds IRQ_WORK_PENDING flag already set, we just
return and don't raise a new IPI. We expect the destination to see
and handle our latest updades thanks to the pairing atomic_xchg()
in irq_work_run_list().

But cmpxchg() doesn't guarantee a full memory barrier upon failure. So
it's possible that the destination misses our latest updates.

So use atomic_fetch_or() instead that is unconditionally fully ordered
and also performs exactly what we want here and simplify the code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index df0dbf4d859b..255454a48346 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -29,24 +29,16 @@ static DEFINE_PER_CPU(struct llist_head, lazy_list);
  */
 static bool irq_work_claim(struct irq_work *work)
 {
-	int flags, oflags, nflags;
+	int oflags;
 
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
 	/*
-	 * Start with our best wish as a premise but only trust any
-	 * flag value after cmpxchg() result.
+	 * If the work is already pending, no need to raise the IPI.
+	 * The pairing atomic_xchg() in irq_work_run() makes sure
+	 * everything we did before is visible.
 	 */
-	flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
-	for (;;) {
-		nflags = flags | IRQ_WORK_CLAIMED;
-		oflags = atomic_cmpxchg(&work->flags, flags, nflags);
-		if (oflags == flags)
-			break;
-		if (oflags & IRQ_WORK_PENDING)
-			return false;
-		flags = oflags;
-		cpu_relax();
-	}
-
+	if (oflags & IRQ_WORK_PENDING)
+		return false;
 	return true;
 }
 
-- 
2.23.0

