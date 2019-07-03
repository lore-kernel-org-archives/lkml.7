Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6B021882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f1YGUU71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCUhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:37:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46543 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfGCUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:37:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so1772176pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKG93kH1nJplHRswkGCnie9FbNFinKJfzxQcF1wGkIU=;
        b=f1YGUU715TPdNfaaYb9aRs6ljIT4zeam0z4kbBiIb9aXjxvpxAx8EELjNSg8R1heAr
         S+E0B5pC+fdaN75v4uxBbkJB/VRhUjLq92JEn0TZm+tHlSK7ezQO0A/Dqw7nW7dk22qQ
         lzinn0cQMxguQ4jj3mIEKXaxq4P1QZ5EJwasg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKG93kH1nJplHRswkGCnie9FbNFinKJfzxQcF1wGkIU=;
        b=amZKsm7/tLtVWDMYmyOJ2Ew56xfHJPz6sW2BxZE3Ogecj9s4LGhubiZhLo/HARz+d6
         Xec+RXWeaMDq8h8zGeDpKl2wGhQPgFPm7pkop8zbpF+V0e6eXUpbwBThBS+S+rqVCk/C
         Gzmmn88Mbq6b41SNBjjxORafndB7qrS3z/Yy+SV4A04JImg9Q4HbLlvlpXVua911kzL7
         TJ6uqOvXvCkKjGyVnpABlxRdP9Xh6/lRwSH+5JX5T9O5Q88TS3lF8T9cC2kMXl+wxDBu
         glBVoNJxm3pyaENjuv3MFlTE5T1w0VMda4fowTEeXtmqtASC5IskvHbXjGUOhqETYZVt
         oOgQ==
X-Gm-Message-State: APjAAAU0+kXTycHl7uDchJeoUedRFR8rCwVQ3HT22HCkquXCXSCFVnJo
        bmVNosKEuBrTr3nQdEzJBwE=
X-Google-Smtp-Source: APXvYqykdW0m0mEltO0vYTEY7Wjb8Is+XIU0h5sjDFuTvkVSy9g/Omww1/HJ6d5KLCpopvpa4aRt4w==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr14532242pjs.109.1562186266123;
        Wed, 03 Jul 2019 13:37:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id cq4sm2774291pjb.23.2019.07.03.13.37.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 13:37:45 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:37:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] rcuperf: Make rcuperf test more robust for !expedited mode
Message-ID: <20190703203744.GA146386@google.com>
References: <20190703043945.128825-1-joel@joelfernandes.org>
 <20190703172344.GR26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703172344.GR26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:23:44AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 03, 2019 at 12:39:45AM -0400, Joel Fernandes (Google) wrote:
> > It is possible that rcuperf run concurrently with init starting up.
> > During this time, the system is running all grace periods as expedited.
> > However, rcuperf can also be run in a normal mode. The rcuperf test
> > depends on a holdoff before starting the test to ensure grace periods
> > start later. This works fine with the default holdoff time however it is
> > not robust in situations where init takes greater than the holdoff time
> > the finish running. Or, as in my case:
> > 
> > I modified the rcuperf test locally to also run a thread that did
> > preempt disable/enable in a loop. This had the effect of slowing down
> > init. The end result was "batches:" counter was 0. This was because only
> > expedited GPs seem to happen, not normal ones which led to the
> > rcu_state.gp_seq counter remaining constant across grace periods which
> > unexpectedly happen to be expedited.
> > 
> > This led me to debug that even though the test could be for normal GP
> > performance, because init has still not run enough, the
> > rcu_unexpedited_gp() call would not have run yet. In other words, the
> > test would concurrently with init booting in expedited GP mode.
> > 
> > To fix this properly, let us just check for whether rcu_unexpedited_gp()
> > was called yet before starting the writer test. With this, the holdoff
> > parameter could also be dropped or reduced to speed up the test.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > Please consider this patch as an RFC only! This is the first time I am
> > running the RCU performance tests, thanks!
> 
> Another approach is to create (say) a late_initcall() function that
> sets a global variable.  Then have the wait loop wait for that global
> variable to be set.  Or use an explicit wait/wakeup scheme, if you wish.
> 
> This has the virtue of keeping this (admittedly small) bit of complexit
> out of the core kernel.

Agreed, I thought of the late_initcall approach as well. I will respin the
patch to do that.

> > Question:
> > I actually did not know that expedited gp does not increment
> > rcu_state.gp_seq. Does expedited GPs not go through the same RCU-tree
> > machinery as non-expedited? If yes, why doesn't rcu_state.gp_seq
> > increment when we are expedited? If no, why not?
> 
> They are indeed (mostly) independent mechanisms.
> 
> This is in contrast to SRCU, where an expedited grace period does what
> you expect, causing all grace periods to do less waiting until the
> most recent expedited grace period has completed.
> 
> Why the difference?
> 
> o	Current SRCU uses have relatively few updates, so the decreases
> 	in batching effectiveness for normal grace periods are less
> 	troublesome than they would be for RCU.  Shortening RCU grace
> 	periods would significantly increase per-update overhead, for
> 	example, and less so for SRCU.
> 
> o	RCU uses a much more distributed design, which means that
> 	expediting an already-started RCU grace period would be more
> 	challenging than it is for SRCU.  The race conditions between
> 	an "expedite now!" event and the various changes in state for
> 	a normal RCU grace period would be challenging.
> 
> o	In addition, RCU's more distributed design results in
> 	higher latencies.  Expedited RCU grace periods simply bypass
> 	this and get much better latencies.
> 
> So, yes, normal and expedited RCU grace periods could be converged, but
> it does not seem like a good idea given current requirements.

Thanks a lot for the explanation of these subtleties, I really appreciate
that and it will serve as a great future reference for everyone (and for my notes!)

Thanks again!

- Joel
