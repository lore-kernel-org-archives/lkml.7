Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65ECC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753BC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eb7HQSum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfIYJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:32:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfIYJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+1xpzzC7e+If0Dblidua6mpK2AngQpcowyagtZlcJrI=; b=Eb7HQSum/uvhU9ytIsU78GhNY
        ayCNsL1Z0BY4hYn23Q0O50hMcoR7v6nQkhMsyeVaghoxqy+UM/1tYr/tXwJyjY0FfG9XL7vgeuedE
        NiajSjto9JiKjIvMBrNWgtonTmUDtRTyoFbi3vmVdPQfIlf46XyuuBJK+LrtZUM4kDVuX9YW2PObj
        /2iLMyzRRKPY0cic3bI+f59p1iwxP1VHax4tpdk7fhHEOleGtp6oGzUdADDEtr1YH7NP7czZujtw7
        elUwCB2bOaj2YGfS+T0Wno1Kan6wxAqATz6sXCPdmYP1dEr58G05lJiYmWcwbIJ9swhMVMTX3Vo5Y
        IRWxeaqNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD3eO-0000RR-Ae; Wed, 25 Sep 2019 09:31:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B3C9302A71;
        Wed, 25 Sep 2019 11:31:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20736203E50D5; Wed, 25 Sep 2019 11:31:53 +0200 (CEST)
Date:   Wed, 25 Sep 2019 11:31:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Message-ID: <20190925093153.GC4553@hirez.programming.kicks-ass.net>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568392064-3052-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:27:44PM -0400, Qian Cai wrote:
> The commit b7d5dc21072c ("random: add a spinlock_t to struct
> batched_entropy") insists on acquiring "batched_entropy_u32.lock" in
> get_random_u32() which introduced the lock chain,
> 
> "&rq->lock --> batched_entropy_u32.lock"
> 
> even after crng init. As the result, it could result in deadlock below.
> Fix it by using get_random_bytes() in shuffle_freelist() which does not
> need to take on the batched_entropy locks.
> 
> WARNING: possible circular locking dependency detected
> 5.3.0-rc7-mm1+ #3 Tainted: G             L
> ------------------------------------------------------
> make/7937 is trying to acquire lock:
> ffff900012f225f8 (random_write_wait.lock){....}, at:
> __wake_up_common_lock+0xa8/0x11c
> 
> but task is already holding lock:
> ffff0096b9429c00 (batched_entropy_u32.lock){-.-.}, at:
> get_random_u32+0x6c/0x1dc
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (batched_entropy_u32.lock){-.-.}:
>        lock_acquire+0x31c/0x360
>        _raw_spin_lock_irqsave+0x7c/0x9c
>        get_random_u32+0x6c/0x1dc
>        new_slab+0x234/0x6c0
>        ___slab_alloc+0x3c8/0x650
>        kmem_cache_alloc+0x4b0/0x590
>        __debug_object_init+0x778/0x8b4
>        debug_object_init+0x40/0x50
>        debug_init+0x30/0x29c
>        hrtimer_init+0x30/0x50
>        init_dl_task_timer+0x24/0x44
>        __sched_fork+0xc0/0x168
>        init_idle+0x78/0x26c
>        fork_idle+0x12c/0x178
>        idle_threads_init+0x108/0x178
>        smp_init+0x20/0x1bc
>        kernel_init_freeable+0x198/0x26c
>        kernel_init+0x18/0x334
>        ret_from_fork+0x10/0x18
> 
> -> #2 (&rq->lock){-.-.}:

This relation is silly..

I suspect the below 'works'...

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 63900ca029e0..ec1d72f18b34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6027,10 +6027,11 @@ void init_idle(struct task_struct *idle, int cpu)
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
