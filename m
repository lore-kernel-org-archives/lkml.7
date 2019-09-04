Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0916B20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYLe8XhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfIDLji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:39:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=im2ZbBXjQCTwom2LyLeOxyP+DVNr02N1le8p8SD/sg0=; b=OYLe8XhTAU8uWotdgZdUYzlI5
        ho5okgGokJAnNrc7TUWV1V2XRxUHXTk7dnsornu2Oaub+SOsqOFdSmBpgDeKUfH6tuRiwR1lY6pfp
        BPJBF9JffkaXNRBBEvVM2V+TgLALPEeeqzietuOJN3t+fOYjz775svGa44NGceeIBzAnaLM0cDuTp
        6QnZuoMzvy0lBb3dhL86FVDw426ZJFQXGAuhp4j6LCu2XlSfkTeYLS6ItqRooea89xiMMczOcCL/p
        Pen6e1UQe12Qjbbjj33AwU34Fke2/hqh6657WH9LMjlUc0rLx7Tu/cb4Yztyl6VLl/VODW7hC2iR3
        O8N/2btag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5TdC-0004Uj-AI; Wed, 04 Sep 2019 11:39:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F23F030116F;
        Wed,  4 Sep 2019 13:38:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8771F29D9E73C; Wed,  4 Sep 2019 13:39:20 +0200 (CEST)
Date:   Wed, 4 Sep 2019 13:39:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904113920.GG2349@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190904105348.GA24568@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904105348.GA24568@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:53:49PM +0200, Oleg Nesterov wrote:
> On 09/03, Mathieu Desnoyers wrote:
> >
> > @@ -1130,6 +1130,10 @@ struct task_struct {
> >  	unsigned long			numa_pages_migrated;
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > +#ifdef CONFIG_MEMBARRIER
> > +	atomic_t membarrier_state;
> > +#endif
> 
> ...
> 
> > +static inline void membarrier_prepare_task_switch(struct task_struct *t)
> > +{
> > +	if (!t->mm)
> > +		return;
> > +	atomic_set(&t->membarrier_state,
> > +		   atomic_read(&t->mm->membarrier_state));
> > +}
> 
> Why not
> 
> 	rq->membarrier_state = next->mm ? t->mm->membarrier_state : 0;
> 
> and
> 
> 	if (cpu_rq(cpu)->membarrier_state & MEMBARRIER_STATE_GLOBAL_EXPEDITED) {
> 		...
> 	}
> 
> in membarrier_global_expedited() ? (I removed atomic_ to simplify)
> 
> IOW, why this new member has to live in task_struct, not in rq?

It could be like the above; but then we're still reading
mm->membarrier_state in the scheduler path.

The patch I just send avoids event that, at the cost of doing a
do_each_thread/while_each_thread iteration in the uncommon case where we
register a process after it grows threads.
