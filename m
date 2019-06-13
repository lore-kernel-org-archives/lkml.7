Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B1DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4DA20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TSe3Bx29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfFMPJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbfFMN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IyfYZz+eZfA7AvNZfJSE5vVjCdlB8b8pieR3SaMGq7s=; b=TSe3Bx29OWthf89T6qNJ4JrVDE
        q9YwKzGiTKHPP0fp6eiGtiW3oYTtroa6af8p16d0tE7QQj+ZfJinw8KAj9t/5CBPk7wYYG7+GW0KI
        Dae3fdfRWFdPPdLKDaJEJxhm2EKb/rfm/z09zNciNkhuRNjTK0cKD4LDr7PMhClSLnaD+KuJ2xNnh
        rqfijIscuiG4TUB4w6ixZSL4ptf/FgtBmJOZtzFzT41HxXaRnvfAwMmYuzu+0QWjbl1HT4/9FZgcQ
        L1KoUamA+vmGZXpCshK3iPIboCgfkq2lnX5jgwY0D1V8oZk9d8aXh2+jQ0WFevByr7fG4K50PS4Rm
        wtTTfQKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbQDy-0005lM-JH; Thu, 13 Jun 2019 13:57:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1984220435AA8; Thu, 13 Jun 2019 15:57:05 +0200 (CEST)
Message-Id: <20190613135653.516610094@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Jun 2019 15:54:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 4/5] x86/percpu, sched/fair: Avoid local_clock()
References: <20190613135445.318096781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav reported that code-gen changed because of the this_cpu_*()
constraints, avoid this for select_idle_cpu() because that runs with
preemption (and IRQs) disabled anyway.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6160,6 +6160,7 @@ static int select_idle_cpu(struct task_s
 	u64 time, cost;
 	s64 delta;
 	int cpu, nr = INT_MAX;
+	int this = smp_processor_id();
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6183,7 +6184,7 @@ static int select_idle_cpu(struct task_s
 			nr = 4;
 	}
 
-	time = local_clock();
+	time = cpu_clock(this);
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
@@ -6194,7 +6195,7 @@ static int select_idle_cpu(struct task_s
 			break;
 	}
 
-	time = local_clock() - time;
+	time = cpu_clock(this) - time;
 	cost = this_sd->avg_scan_cost;
 	delta = (s64)(time - cost) / 8;
 	this_sd->avg_scan_cost += delta;


