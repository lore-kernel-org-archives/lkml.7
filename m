Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE4C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ADC204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x/SzQTNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGMPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 11:43:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39138 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfGMPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:43:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so5837190pgi.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38aEeWzt3ijYt2DwkFWv2RP5UO7sSKFkj7x22Iz0ST8=;
        b=x/SzQTNQ4sByXI7Io+rDMT15SeWxge0saa6QHsu4zEVm/KMxgPeKe7Gc44duVSyYxW
         08LY05sma2GOurKLHzQ5q175aAd3uEhs2N4epWdcXEipUWGzyaV++4QUM2PemEyZwh8p
         fNpiLdMImxFOJTiyzUIshMIhAxA1gpajVgd90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38aEeWzt3ijYt2DwkFWv2RP5UO7sSKFkj7x22Iz0ST8=;
        b=MpotMHNx0HFjEEDRIiuU2EKsKLYM56bDeX/bUw+VQTNOURbrM6slY/7Zwuu6fJFRbo
         K6jfghGPAjurc/DXEkSY66iz2Lf+aH0+9mmEwBM+I/d+bQRHKJo6O2+9oEp9qARV4jUB
         hGjrjCFzU6jpCy5QFjJvy1eGx13FyBTUL978KTkNTU3YuYzEHwgeSlgzKmUnCbNByaRM
         EmO7vtH3Bkf8NrMHan140LBdtI9iRzIMq5DkrM6FumdsblBm9tUOndSBTKfcWOPYOAa+
         xHsXhTBwL6X4mrYarCQU+Qd98B7nn0kqTIpij5YSKnaeD9b8S+0aTXdERhPQQWOiMsAW
         Lnwg==
X-Gm-Message-State: APjAAAVnJ+S74aJ1Tnb3JVImRO2xSCzH07QGfzTW9zVaTvmgRa2KsVYi
        CflaPvXEJPlNzgu44FB0juA=
X-Google-Smtp-Source: APXvYqxuZTAseRLLzuBMBdAPveg+MgsvnGJWOBo447qS8AoV1GRx7g0vMde7cEXEPsr4yNi2krzO8w==
X-Received: by 2002:a65:5888:: with SMTP id d8mr17113350pgu.124.1563032579443;
        Sat, 13 Jul 2019 08:42:59 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z19sm10488216pgv.35.2019.07.13.08.42.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 08:42:58 -0700 (PDT)
Date:   Sat, 13 Jul 2019 11:42:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190713154257.GE133650@google.com>
References: <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713151330.GE26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 08:13:30AM -0700, Paul E. McKenney wrote:
> On Sat, Jul 13, 2019 at 10:20:02AM -0400, Joel Fernandes wrote:
> > On Sat, Jul 13, 2019 at 4:47 AM Byungchul Park
> > <max.byungchul.park@gmail.com> wrote:
> > >
> > > On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > > > anywhere.
> > > > > >
> > > > > > Any idea why it was added but not used?
> > > > > >
> > > > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > > > >
> > > > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > > > look like.
> > > > >
> > > > > Hi,
> > > > >
> > > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > > >       rcu: Remove debugfs tracing
> > > > >
> > > > > removed all debugfs tracing, gp_max also included.
> > > > >
> > > > > And you sounds great. And even looks not that hard to add it like,
> > > > >
> > > > > :)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index ad9dc86..86095ff 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > > >       rcu_state.gp_end = jiffies;
> > > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > > -     if (gp_duration > rcu_state.gp_max)
> > > > > +     if (gp_duration > rcu_state.gp_max) {
> > > > >               rcu_state.gp_max = gp_duration;
> > > > > +             trace_rcu_grace_period(something something);
> > > > > +     }
> > > >
> > > > Yes, that makes sense. But I think it is much better off as a readable value
> > > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > > >  - Tracing will only catch it if tracing is on
> > > >  - Tracing data can be lost if too many events, then no one has a clue what
> > > >    the max gp time is.
> > > >  - The data is already available in rcu_state::gp_max so copying it into the
> > > >    trace buffer seems a bit pointless IMHO
> > > >  - It is a lot easier on ones eyes to process a single counter than process
> > > >    heaps of traces.
> > > >
> > > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > > hurt and could do more good than not. The scheduler already does this for
> > > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > > but not much (or never) about new statistics.
> > > >
> > > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > > the stall timeouts and also any other RCU knobs. What do you think?
> > >
> > > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > > looks like undoing what Paul did at ae91aa0ad.
> > >
> > > I think you're rational enough. I just wondered how Paul think of it.
> > 
> > I believe at least initially, a set of statistics can be made
> > available only when rcutorture or rcuperf module is loaded. That way
> > they are purely only for debugging and nothing needs to be exposed to
> > normal kernels distributed thus reducing testability concerns.
> > 
> > rcu_state::gp_max would be trivial to expose through this, but for
> > other statistics that are more complicated - perhaps
> > tracepoint_probe_register can be used to add hooks on to the
> > tracepoints and generate statistics from them. Again the registration
> > of the probe and the probe handler itself would all be in
> > rcutorture/rcuperf test code and not a part of the kernel proper.
> > Thoughts?
> 
> It still feels like you guys are hyperfocusing on this one particular
> knob.  I instead need you to look at the interrelating knobs as a group.

Thanks for the hints, we'll do that.

> On the debugging side, suppose someone gives you an RCU bug report.
> What information will you need?  How can you best get that information
> without excessive numbers of over-and-back interactions with the guy
> reporting the bug?  As part of this last question, what information is
> normally supplied with the bug?  Alternatively, what information are
> bug reporters normally expected to provide when asked?

I suppose I could dig out some of our Android bug reports of the past where
there were RCU issues but if there's any fires you are currently fighting do
send it our way as debugging homework ;-)

thanks,

 - Joel


