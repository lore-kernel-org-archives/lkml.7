Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F36C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865721883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RDXuV2LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfIDMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:43:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FuUfOnc7snwlh4WYCMF8L7N0qd2YJQNzssdGMWgQAkk=; b=RDXuV2LUdERckmSsDYDvow5Dd
        N8Uv5uiig4bPwnzy9Xut1HvzAT18lxUCZiJhbxqpSFwt0Eer0HpWXjAhQg1n128Rid20IW9BTiLHN
        tJT73I+sUPdUM/jJ2H23xyY/2U0y8yCxAooEQzEPNPdLbhYSxMdfSfkBs1hUd8XD07D8/rOCQZm5D
        cDMNSxD4bmISi15CNEOqjrz7KKdnoXBJeBMk9Jnhf/FoJeDHl6FiYyGf31n37PLDrn9rzQfI5/hL0
        k688ilGYtaSYN0n9Xt48Bb7+grYrfC/NgHRZV19vzsCFvwsspwsPfSvlGYH6c+qdadPV57euhWC/v
        s/thPeolQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UdM-0005Je-5R; Wed, 04 Sep 2019 12:43:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D7A2306027;
        Wed,  4 Sep 2019 14:42:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4E7D29D9EB6E; Wed,  4 Sep 2019 14:43:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:43:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904124333.GQ2332@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
 <20190904112819.GD2349@hirez.programming.kicks-ass.net>
 <20190904120336.GC24568@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904120336.GC24568@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:03:37PM +0200, Oleg Nesterov wrote:
> On 09/04, Peter Zijlstra wrote:
> >
> > +		struct task_struct *g, *t;
> > +
> > +		read_lock(&tasklist_lock);
> > +		do_each_thread(g, t) {
> 
> for_each_process_thread() looks better

Argh, I always get confused. Why do we have multiple version of this
again?

> > +			if (t->mm == mm) {
> > +				atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED,
> > +					  &t->membarrier_state);
> > +			}
> 
> then you also need to change dup_task_struct(), it should clear
> ->membarrier_state unless CLONE_VM.

Or, as you suggest below.

> And probably unuse_mm() should clear current->membarrier_state too.

How about we hard exclude PF_KTHREAD and ignore {,un}use_mm() entirely?

> Hmm. And it can race with copy_process() anyway, tasklist_lock can't
> really help. So copy_process() needs to do
> 
> 	write_lock_irq(&tasklist_lock);
> 	...
> 
> 	if (clone_flags & CLONE_VM)
> 		p->membarrier_state = current->membarrier_state;
> 	else
> 		p->membarrier_state = 0;

Right you are.
