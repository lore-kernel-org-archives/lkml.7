Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F682C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA25120700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmbcU21L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfJAJSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:18:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59324 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbfJAJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qJgQIp1PbWd7MDwKGdEgTjEvRijTu/H2sV4eU4dxT3E=; b=CmbcU21Ln2WAiNG4BNCs8y5uf
        lnrh/jm7R8+P+5vep3wk6Xg6GNVfwmJn2afgLlo7l1BZJ7G68HAFXvQdvyXWI0MRMu140eKGxYKrL
        i+WvbHkw1H4NMQr9HleZ6DEAPN+zJWwgIQqqpSSGFAsNOhDhtX2hcWWc6XtzTDvh9WBrqPdWkppPb
        bsuMgn0a1kSzm/0lu3C4+3kBNQXwjoJHdo4NIHxoAagF4AMVQt9LjfP0YiSP0Pl5dkZSamF1HB4Xh
        AJeGyU6MrHsWgadJ4OA3dEQWaPVDrrt8KPeKg5WM/uDQynOgOVVaisKTuVg0Ur2HTe8OgG4/mvWRP
        ErUx5iYHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFEIq-0002nx-U7; Tue, 01 Oct 2019 09:18:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7300F30600C;
        Tue,  1 Oct 2019 11:17:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2C28265261AC; Tue,  1 Oct 2019 11:18:37 +0200 (CEST)
Date:   Tue, 1 Oct 2019 11:18:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: [PATCH] sched: Avoid spurious lock dependencies
Message-ID: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190925093153.GC4553@hirez.programming.kicks-ass.net>
 <1569424727.5576.221.camel@lca.pw>
 <20190925164527.GG4553@hirez.programming.kicks-ass.net>
 <1569500974.5576.234.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569500974.5576.234.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 08:29:34AM -0400, Qian Cai wrote:

> Oh, you were talking about took #3 while holding #2. Anyway, your patch is
> working fine so far. Care to post/merge it officially or do you want me to post
> it?

Does the below adequately describe the situation?

---
Subject: sched: Avoid spurious lock dependencies

While seemingly harmless, __sched_fork() does hrtimer_init(), which,
when DEBUG_OBJETS, can end up doing allocations.

This then results in the following lock order:

  rq->lock
    zone->lock.rlock
      batched_entropy_u64.lock

Which in turn causes deadlocks when we do wakeups while holding that
batched_entropy lock -- as the random code does.

Solve this by moving __sched_fork() out from under rq->lock. This is
safe because nothing there relies on rq->lock, as also evident from the
other __sched_fork() callsite.

Fixes: b7d5dc21072c ("random: add a spinlock_t to struct batched_entropy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..1832fc0fbec5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6039,10 +6039,11 @@ void init_idle(struct task_struct *idle, int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
+	__sched_fork(0, idle);
+
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_lock(&rq->lock);
 
-	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;


