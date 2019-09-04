Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716AAC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4822622CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SuGvE/+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbfIDQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:10:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732989AbfIDQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/EDR4GvlJhkdLPR8kYkQGJ2qlMGAC0osrPMnnOYDBIg=; b=SuGvE/+zYB3jQ+kfZDnQwC7Wo
        JeUwO3O/k3flaa2K4c95ijKzir0G0VZIUtveVY32G++8pFy+Gf/t0gvdOS7SsDPOQ8qLMHHc3bXss
        +KHCuVIYwAEZmqReLHCigSc6/lMSH7GMXiLRXv/Of8zZZPt0Bk+QQhgIOy6NwWYvwTg2NoMPUbiMC
        eK2/qz1LF3xsEpd3ui+WV4Ir2RPUP2TlY9SH5qW4l6s4jxNCtX2TNu9DbxsTlqUMKIH4mVshHHrZM
        8IoGIjtooW76ukE2EZ2DXE0LtPyHGxSpN/NSjjaG5/T1RWCuP9kCP4hnO1hMOhLqntQp7bCbqHZT3
        1k6uuxhpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Xr2-0006yh-CU; Wed, 04 Sep 2019 16:09:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C79AA3060CF;
        Wed,  4 Sep 2019 18:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6037D20EFA5D9; Wed,  4 Sep 2019 18:09:53 +0200 (CEST)
Date:   Wed, 4 Sep 2019 18:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck <paulmck@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904160953.GU2332@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
 <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:19:00AM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 3, 2019, at 4:36 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> > I wonder if the easiest model might be to just use a percpu variable
> > instead for the membarrier stuff? It's not like it has to be in
> > 'struct task_struct' at all, I think. We only care about the current
> > runqueues, and those are percpu anyway.
> 
> One issue here is that membarrier iterates over all runqueues without
> grabbing any runqueue lock. If we copy that state from mm to rq on
> sched switch prepare, we would need to ensure we have the proper
> memory barriers between:
> 
> prior user-space memory accesses  /  setting the runqueue membarrier state
> 
> and
> 
> setting the runqueue membarrier state / following user-space memory accesses
> 
> Copying the membarrier state into the task struct leverages the fact that
> we have documented and guaranteed those barriers around the rq->curr update
> in the scheduler.

Should be the same as the barriers we already rely on for rq->curr, no?
That is, if we put this before switch_mm() then we have
smp_mb__after_spinlock() and switch_mm() itself.

Also, if we place mm->membarrier_state in the same cacheline as mm->pgd
(which switch_mm() is bound to load) then we should be fine, I think.
