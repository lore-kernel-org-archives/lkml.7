Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0618C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58B208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s1ahvOzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfF1QqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:46:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfF1QqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:46:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so2833756pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LAeW0vM39GC0KmaPFoxhW1ECWQ2nzJIxGxsqVk3ozU8=;
        b=s1ahvOzzyovEDLX3qaJdoioW0tayuZCblu5PiB30XizYnRrPbobs+w6Kz10R8WYQa8
         MF5wdtx7mdFAQz73jeEs79G1OqkX6UPmZ5kwnbkCFoFKZwn8tgoaZJQn5uo2w108KOMQ
         sLrlY4NNgYXD/cW3remFZk6M8CdXyapZRGXiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LAeW0vM39GC0KmaPFoxhW1ECWQ2nzJIxGxsqVk3ozU8=;
        b=uJiwi+4Sf9zNFY/xCF4aL+FnED3Ytwutc7mVJWqbmdnAwA0e+jvsMNbn+scJRpZmo/
         xGlHP1iQq+4OXhpiTY5cVzfAMnD3H4PfwClwBrJ08rLgPhmBaTR+EEcrkT+Y8cG0gSV5
         Gxyhtd9Q9z3Fs0y6yq6HVp9RT+KLWA2uEr6fb9/odiMBswvke5Ah5JsZ5nzgfI946wcc
         Bse636klAEfEHlAVVqtb4YuPWUy/9kHPCXwQMOk6dj7cVtN5AXQ2tuBUs9eHUdmtgfvR
         0VfpKAq1H1dlmdoaJ5rVJ9FDastSdkHCmsJ+AHgkFpnliIEuS7ySR/adv9JQOEFQ2Mm3
         7GoQ==
X-Gm-Message-State: APjAAAVUo5ZDjVIy9P8rxFDXZuXo7YiCibo5r25loKWrgSwx/G9i62On
        pFn6kkIvPPdr0k/L1Rv7+tsCng==
X-Google-Smtp-Source: APXvYqw7KdGoTGxdx+l6Ql/QFa2Oy4oNmNSCqo+9DSf0VtsXpyaLtPevZfEYUq0F0F156OIse1TGvw==
X-Received: by 2002:a17:90a:3463:: with SMTP id o90mr14704574pjb.15.1561740361965;
        Fri, 28 Jun 2019 09:46:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w16sm3545366pfj.85.2019.06.28.09.46.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 09:46:01 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:45:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628164559.GC240964@google.com>
References: <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628164008.GB240964@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:40:08PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> [snip]
> > > > > And we should document this somewhere for future sanity preservation
> > > > > :-D
> > > > 
> > > > Or adjust the code and requirements to make it more sane, if feasible.
> > > > 
> > > > My current (probably wildly unreliable) guess that the conditions in
> > > > rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
> > > > implies a hardirq context, in other words that in_irq() would return
> > > > false from a threaded interrupt handler.  If in_irq() instead returns
> > > > true from within a threaded interrupt handler, then this code in
> > > > rcu_read_unlock_special() needs fixing:
> > > > 
> > > > 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > > > 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > > > 			// Using softirq, safe to awaken, and we get
> > > > 			// no help from enabling irqs, unlike bh/preempt.
> > > > 			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > 
> > > > The fix would be replacing the calls to in_irq() with something that
> > > > returns true only if called from within a hardirq context.
> > > > Thoughts?
> > > 
> > > I am not sure if this will fix all cases though?
> > > 
> > > I think the crux of the problem is doing a recursive wake up. The threaded
> > > IRQ probably just happens to be causing it here, it seems to me this problem
> > > can also occur on a non-threaded irq system (say current_reader() in your
> > > example executed in a scheduler path in process-context and not from an
> > > interrupt). Is that not possible?
> > 
> > In the non-threaded case, invoking raise_softirq*() from hardirq context
> > just sets a bit in a per-CPU variable.  Now, to Sebastian's point, we
> > are only sort of in hardirq context in this case due to being called
> > from irq_exit(), but the failure we are seeing might well be a ways
> > downstream of the actual root-cause bug.
> 
> Hi Paul,
> I was talking about calling of rcu_read_unlock_special from a normal process
> context from the scheduler.
> 
> In the below traces, it shows that only the PREEMPT_MASK offset is set at the
> time of the issue. Both HARD AND SOFT IRQ masks are not enabled, which means
> the lock up is from a normal process context.
> 
> I think I finally understood why the issue shows up only with threadirqs in
> my setup. If I build x86_64_defconfig, the CONFIG_IRQ_FORCED_THREADING=y
> option is set. And booting this with threadirqs, it always tries to
> wakeup_ksoftirqd in invoke_softirq.
> 
> I believe what happens is, at an in-opportune time when the .blocked field is
> set for the preempted task, an interrupt is received. This timing is quite in
> auspicious because t->rcu_read_unlock_special just happens to have its
> .blocked field set even though it is not in a reader-section.

I believe the .blocked field remains set even though we are not any more in a
reader section because of deferred processing of the blocked lists that you
mentioned yesterday.

