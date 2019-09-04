Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A28C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2688A20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EQe/Wsaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfIDOfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:35:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40938 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:35:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so3745955pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gZ2ksRnGO0yWH42zai0y/N6lDiHsqeG4OnHQbM7T4ws=;
        b=EQe/WsaqNt+rhmP/5byiVXgnBo2D6r0BNW4YXwDGkn7xOEwxS2d8z7pQbotAM9HBnK
         8HZLKSDeW0OB1h7RO+k4yb0Q9JoaQRcaRZbFrbedz2/4h2blx24JD3tSEFLv7DzoGp9s
         9Hi/BMZHBihhrysGwz8acYbkMfdc7n8QCLYUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZ2ksRnGO0yWH42zai0y/N6lDiHsqeG4OnHQbM7T4ws=;
        b=ACkAflFOPClMus/hc/F+xigy6n25OuaURCmfYZa5BP3hLbVJU+GZYbwpNPh99gVE4R
         fM6rgNlfp2AGKxY4e8U8Pte6QGZx6MPmyC0ETSlBL1TSMD7Ur2zSIc82if2etAwYFxE2
         I34kI0XhDrnsC6JOwLcGl69c87sAnFKUoAFiPn5tVuWc9eki4z8KY8OEh13Foek1LfgO
         e26DcV3rB0feNuc+XjoeO2o/Y7uivi7qJ/mPaRNHR9f4pPjp+L3XQwf2XNfJKMIoAALU
         1q9xNnGa4r5eGPPaZ2IzHC5F0BIbyDOfgwMkaCABOK6YP3Y2g3tCuK3BcDtfr5xraJaA
         sJdQ==
X-Gm-Message-State: APjAAAWT76elWx+hdbvyYNgbwpvUHaO4B5TnHNLXb2M/TCxjtEfnagSn
        p9ooVG303oWYkwa2BRHVuAxJks4w+Jg=
X-Google-Smtp-Source: APXvYqxHYUgaEwwJVrxVSEbsGz41tZSUactVOxw7RxreY90MKjveNIyh/ovjBi1yI21eRyYs+go8cQ==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7mr24698603pls.57.1567607736877;
        Wed, 04 Sep 2019 07:35:36 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n19sm11563306pfa.67.2019.09.04.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:35:36 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:35:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, kernel-team@android.com
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190904143535.GD240514@google.com>
References: <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
 <20190831144117.GA133727@google.com>
 <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
 <20190904061616.25ce79e1@oasis.local.home>
 <20190904113038.GE2349@hirez.programming.kicks-ass.net>
 <20190904132418.GA237277@google.com>
 <20190904141109.4v6o2cxklpdlmldb@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904141109.4v6o2cxklpdlmldb@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:11:10PM +0100, Will Deacon wrote:
> Hi Joel,
> 
> On Wed, Sep 04, 2019 at 09:24:18AM -0400, Joel Fernandes wrote:
> > On Wed, Sep 04, 2019 at 01:30:38PM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 04, 2019 at 06:16:16AM -0400, Steven Rostedt wrote:
> > > > On Mon, 2 Sep 2019 11:16:23 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > > 
> > > > > in sched_dl_period_handler(). And do:
> > > > > 
> > > > > +	preempt_disable();
> > > > > 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> > > > > 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> > > > > +	preempt_enable();
> > > > 
> > > > Hmm, I'm curious. Doesn't the preempt_disable/enable() also add
> > > > compiler barriers which would remove the need for the READ_ONCE()s here?
> > > 
> > > They do add compiler barriers; but they do not avoid the compiler
> > > tearing stuff up.
> > 
> > Neither does WRITE_ONCE() on some possibly buggy but currently circulating
> > compilers :(
> 
> Hmm. The example above is using READ_ONCE, which is a different kettle of
> frogs.

True. But, I equally worry about all *-tearing frog kettles ;-)

> > As Will said in:
> > https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/
> > 
> > void bar(u64 *x)
> > {
> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> > }
> > 
> > gives:
> > 
> > bar:
> > 	mov	w1, 61200
> > 	movk	w1, 0xabcd, lsl 16
> > 	str	w1, [x0]
> > 	str	w1, [x0, 4]
> > 	ret
> > 
> > Speaking of which, Will, is there a plan to have compiler folks address this
> > tearing issue and are bugs filed somewhere? I believe aarch64 gcc is buggy,
> > and clang is better but is still buggy?
> 
> Well, it depends on your point of view. Personally, I think tearing a
> volatile access (e.g. WRITE_ONCE) is buggy and it seems as though the GCC
> developers agree:
> 
> https://gcc.gnu.org/ml/gcc-patches/2019-08/msg01500.html
> 
> so it's likely this will be fixed for AArch64 GCC. I couldn't persuade
> clang to break the volatile case, so think we're good there too.

Glad to know that GCC folks are looking into the issue.

Sorry if this is getting a bit off-topic. Also does the aarch64 clang doing
the "memset folding" issue, also need to be looked into?
You had mentioned it in the same thread:
https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/
Or, does WRITE_ONCE() resolve such memset store-merging?

> For the non-volatile case, I don't actually consider it to be a bug,
> although I sympathise with the desire to avoid a retrospective tree-wide
> sweep adding random WRITE_ONCE invocations to stores that look like they
> might be concurrent. In other words, I think I'd suggest:
> 
>   * The use of WRITE_ONCE in new code (probably with a comment justifying it)
>   * The introduction of WRITE_ONCE to existing code where it can be shown to
>     be fixing a real bug (e.g. by demonstrating that a compiler actually
>     gets it wrong)
> 
> For the /vast/ majority of cases, the compiler will do the right thing
> even without WRITE_ONCE, simply because that's going to be the most
> performant choice as well.

Thanks for the thoughts. They seem to be reasonable to me.

thanks,

 - Joel

