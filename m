Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494BAC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF021874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KiQBSMSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfH3BUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:20:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38402 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfH3BUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:20:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so3398886pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAQRTw/5GtO2IVjhxbnhbmA6jHoOszIxdzX2lqnMQMg=;
        b=KiQBSMShDGj9y6Xiii40u6wmUwaPzvCmLBrsQiiSeEfxEgpqCJWUuqzMHmO/Q73wx5
         r5riO7kqXyCHlrCGrBMtmwN2qlKAcIX9GLH7grhaEilxxO8KtWz0gbBbCVXi2z6BsmQX
         aYI3FaS4XY/k3gNyDLvPelJslB3mROrAPEU+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAQRTw/5GtO2IVjhxbnhbmA6jHoOszIxdzX2lqnMQMg=;
        b=AImyA6pHQAJMIf58215H39Yk/xwXVjG6cJxq71ZZnjURV9eLNrDa7PmsEfidUmQEo7
         pKQBzTbYDqw9sf5gu5kxdnBGRnZ6nMScG52a7GN8OK/lugqGNtW2mBoDh6Kjbzoa4Y6k
         gbsifQBC+KiXmAAulUL0pqtsYVmyTtXoeXot8baWt9jU9TAyc3vRYT7HVpsfki8iG+VO
         BRWPqdWwY1K2ceNlMOuVJKFJBdXQnoov0iajIBFR3DPcnQ6gBl5mmMJWDu4T1Cgh51PO
         SHBlplmmy5RG5yzoM5rLfks/WXYVBR3CgYjxOsrVbdfc4/ih9dYc8YDhafacENEwsHT2
         sO6g==
X-Gm-Message-State: APjAAAWQssY09xNDQ7h+wvI6c1WihaSHI8s8VxwDDPxqKFiazi93Cs05
        3QbaWrp3bHr6GKWL2irt0XhQgw==
X-Google-Smtp-Source: APXvYqykfjS84Wch2NctDuoxhRCl1Y8YxQnTMAp2BwXlvT5nVnlAr/uCcXGqkIIx/qsACUKgYHMMvg==
X-Received: by 2002:a62:2d3:: with SMTP id 202mr1245085pfc.141.1567128038716;
        Thu, 29 Aug 2019 18:20:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d11sm5473663pfh.59.2019.08.29.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 18:20:37 -0700 (PDT)
Date:   Thu, 29 Aug 2019 21:20:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190830012036.GA184995@google.com>
References: <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829151325.GF63638@google.com>
 <20190829161301.GQ4125@linux.ibm.com>
 <20190829171454.GA115245@google.com>
 <20190830004756.GW4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830004756.GW4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 05:47:56PM -0700, Paul E. McKenney wrote:
[snip]
> > > > Paul, also what what happens in the following scenario:
> > > > 
> > > > CPU0                                                 CPU1
> > > > 
> > > > A syscall causes rcu_eqs_exit()
> > > > rcu_read_lock();
> > > >                                                      ---> FQS loop waiting on
> > > > 						           dyntick_snap
> > > > usermode-upcall  entry -->causes rcu_eqs_enter();
> > > > 
> > > > usermode-upcall  exit  -->causes rcu_eqs_exit();
> > > > 
> > > >                                                      ---> FQS loop sees
> > > > 						          dyntick snap
> > > > 							  increment and
> > > > 							  declares CPU0 is
> > > > 							  in a QS state
> > > > 							  before the
> > > > 							  rcu_read_unlock!
> > > > 
> > > > rcu_read_unlock();
> > > > ---
> > > > 
> > > > Does the context tracking not call rcu_user_enter() in this case, or did I
> > > > really miss something?
> > > 
> > > Holding rcu_read_lock() across usermode execution (in this case,
> > > the usermode upcall) is a bad idea.  Why is CPU 0 doing that?
> > 
> > Oh, ok. I was just hypothesizing that since usermode upcalls from
> > something as heavy as interrupts, it could also mean we had the same from
> > some path that held an rcu_read_lock() as well. It was just a theoretical
> > concern, if it is not an issue, no problem.
> 
> Are there the usual lockdep checks in the upcall code?  Holding a spinlock
> across them would seem to be at least as bad as holding an rcu_read_lock()
> across them.

Great point, I'll take a look.

> > The other question I had was, in which cases would dyntick_nesting in current
> > RCU code be > 1 (after removing the lower bit and any crowbarring) ? In the
> > scenarios I worked out on paper, I can only see this as 1 or 0. But the
> > wording of it is 'dynticks_nesting'. May be I am missing a nesting scenario?
> > We can exit RCU-idleness into process context only once (either exiting idle
> > mode or user mode). Both cases would imply a value of 1.
> 
> Interrrupt -> NMI -> certain types of tracing.  I believe that can get
> it to 5.  There might be even more elaborate sequences of events.

I am only talking about dynticks_nesting, not dynticks_nmi_nesting. In
current mainline, I see this only 0 or 1. I am running the below patch
overnight on all RCU configurations to see if it is ever any other value.

And, please feel free to ignore my emails as you mentioned you are supposed
to be out next 2 days! Thanks for the replies though!

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..8c8ddb6457d5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -571,6 +571,9 @@ static void rcu_eqs_enter(bool user)
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
+
+	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
+
 	if (rdp->dynticks_nesting != 1) {
 		rdp->dynticks_nesting--;
 		return;
@@ -736,6 +739,9 @@ static void rcu_eqs_exit(bool user)
 	lockdep_assert_irqs_disabled();
 	rdp = this_cpu_ptr(&rcu_data);
 	oldval = rdp->dynticks_nesting;
+
+	WARN_ON_ONCE(rdp->dynticks_nesting != 0);
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		rdp->dynticks_nesting++;
-- 
2.23.0.187.g17f5b7556c-goog

