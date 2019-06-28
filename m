Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B59CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D563208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R1bIEps/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfF1TYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:24:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42925 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfF1TYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:24:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3466210pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k5MirY9PvjvoYy2JYPX/EykDAkKOFRQV3e8B1ez3nZY=;
        b=R1bIEps/kzzezmtJeA2smWl1IIsg/enV00IthiN0CW8o+juhmIZoBy0ETt0JXHc5rs
         g0L7kxMEn3MZH+jByHm/zYo5Xr5kgImfp+O6PGhSdHcKUT62g0MPFdNrka5u4JiStby/
         zSSDgYBQheykD8GSSPPuo1JQJxur+bG2q71XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k5MirY9PvjvoYy2JYPX/EykDAkKOFRQV3e8B1ez3nZY=;
        b=BIu4M88pk10zeQ+PWKjh5e9WFr+yWIHRMiafCPMUYHP6pjJWti/Gt8DJSI3LlYu555
         /mYoKHH30M+SmEzurqAfqX9BWlorRDoGb0YcXhrxTJNf+Wp5aEtuviPEOGMKm6nucpKE
         kELZlJZn+q01sGVR9UMFWfA5gzz9TKZluKEUOXnl/fY6EdQsNtlNpzOZnmtxUwpIQ2G1
         4aGM44tf+BZHa9j69IEVFfSSs94O4kWHW6kqFQSDuF2NSfI2Zc6IlIyYCfEdBBzy+ol1
         s6FnWGxoHLDk1SNfW78Aam8Ft44itgbjIYHK3IqCIGfZecyqv5sCndF3bccnK76/Itow
         uMMg==
X-Gm-Message-State: APjAAAXgwI9IiUZfsAyWg/8w72TYZ18WuDpPi6aC8QZ5C4ZUmkbm8EuE
        dJ2LIhu6Y4gXWc7nf4tNgi2scA==
X-Google-Smtp-Source: APXvYqwbcx+n1QhZAl2iZBUwcoQ/Pe6rfSKhIiYqrxobO8zyJAmPU/2VRyvZpr78itBF3XyCcpvqJA==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr10509941pgh.174.1561749849525;
        Fri, 28 Jun 2019 12:24:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c83sm3872829pfb.111.2019.06.28.12.24.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:24:08 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:24:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628192407.GA89956@google.com>
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628135433.GE3402@hirez.programming.kicks-ass.net>
 <20190628153050.GU26519@linux.ibm.com>
 <20190628184026.fds6scgi2pnjnc5p@linutronix.de>
 <20190628185219.GA26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628185219.GA26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:52:19AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 08:40:26PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-06-28 08:30:50 [-0700], Paul E. McKenney wrote:
> > > On Fri, Jun 28, 2019 at 03:54:33PM +0200, Peter Zijlstra wrote:
> > > > On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
> > > > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > > > of any way to determine whether rcu_read_unlock() is being called from
> > > > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > > > about that.
> > > > 
> > > > There (still) is no 'in-scheduler' state.
> > > 
> > > Well, my TREE03 + threadirqs rcutorture test ran for ten hours last
> > > night with no problems, so we just might be OK.
> > > 
> > > The apparent fix is below, though my approach would be to do backports
> > > for the full set of related changes.
> > > 
> > > Joel, Sebastian, how goes any testing from your end?  Any reason
> > > to believe that this does not represent a fix?  (Me, I am still
> > > concerned about doing raise_softirq() from within a threaded
> > > interrupt, but am not seeing failures.)

Are you concerned also about a regular process context executing in the
scheduler and using RCU, having this issue?
(not anything with threaded or not threaded IRQs, but just a path in the
scheduler that uses RCU).

I don't think Sebastian's lock up has to do with the fact that an interrupt
is threaded or not, except that ksoftirqd is awakened in the case where
threadirqs is passed.

> > For some reason it does not trigger as good as it did yesterday.
> 
> I swear that I wasn't watching!!!  ;-)
> 
> But I do know that feeling.

:-)

> > Commit
> > - 23634ebc1d946 ("rcu: Check for wakeup-safe conditions in
> >    rcu_read_unlock_special()") does not trigger the bug within 94
> >    attempts.
> > 
> > - 48d07c04b4cc1 ("rcu: Enable elimination of Tree-RCU softirq
> >   processing") needed 12 attempts to trigger the bug.
> 
> That matches my belief that 23634ebc1d946 ("rcu: Check for wakeup-safe
> conditions in rcu_read_unlock_special()") will at least greatly decrease
> the probability of this bug occurring.

I was just typing a reply that I can't reproduce it with:
  rcu: Check for wakeup-safe conditions in rcu_read_unlock_special()

I am trying to revert enough of this patch to see what would break things,
however I think a better exercise might be to understand more what the patch
does why it fixes things in the first place ;-) It is probably the
deferred_qs thing.

thanks!



