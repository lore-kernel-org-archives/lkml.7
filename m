Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829F72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ES+v6LcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfH2RO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:14:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH2RO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:14:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so1911603pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPDM53/6fx4rnRkVTsQ5BY1RiGRNlZ4KUune0Ro7yNA=;
        b=ES+v6LcCwtNJsRIRE18/qNv6QT20nJphH77qku4h5nuifb2Wj1/18f5TeoE4dY3IPA
         rhhxr+Wqb3oUpX46hfOnzYY3HDNWdMUd+HJV5GYySJ/TEv4Yg5h3x3lj4DcKeSKvoCWS
         TN7fwkfTE6IjogQx7daWws5OBakVs4pcljWHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPDM53/6fx4rnRkVTsQ5BY1RiGRNlZ4KUune0Ro7yNA=;
        b=bqgtyYlO2rkPWukWCRf6NbGu9nZ6u4yLE+wQA1wMLXY74riHGozHuQqs2fVrdDUD18
         6+q9kOGznjaYk6TTxUEjoifiJugveDKdsURzlgkuTZ29bnxeWRqfMFmMpIDV5gIRIWzZ
         4fS85SOXXrLvl6lI5OZsZtF7QqfDe5uOt2Q911pjSSnu4MmNUJR3b8VBjE/Viier+uFJ
         c3dZzPNOx4C6TD0P478eA0fOxhKXpMAIQscz/W1aA4wLoxijPYHp5NceSfTIj37U+7RD
         8XmikXFwu4IbILdeFZ77IY3+E0cU4F7cdGkBrq76at9zE0D4aZsSq0M5//n1ybhadqk3
         k71w==
X-Gm-Message-State: APjAAAXNx21cyMiyJhxawsZySqTQbf7f+RelraLG70n9GnsyiJzOGW7U
        dIhWxy3xA/NHtsVqtd0cTkA3Jg==
X-Google-Smtp-Source: APXvYqzLu5wk3DxAGdv97u2fDeuvOrok07/5HmEdMMy5kzt5jkkZmQC2p7EkfjQqRXSQajATsBsnrg==
X-Received: by 2002:a17:90a:e286:: with SMTP id d6mr11225418pjz.61.1567098896195;
        Thu, 29 Aug 2019 10:14:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x17sm3516199pff.62.2019.08.29.10.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:14:55 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:14:54 -0400
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
Message-ID: <20190829171454.GA115245@google.com>
References: <20190828211904.GX26530@linux.ibm.com>
 <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829151325.GF63638@google.com>
 <20190829161301.GQ4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829161301.GQ4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:13:01AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 29, 2019 at 11:13:25AM -0400, Joel Fernandes wrote:
> > On Thu, Aug 29, 2019 at 10:43:55AM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 28, 2019 at 08:43:36PM -0700, Paul E. McKenney wrote:
> > > [snip]
> > > > > > > > This change is not fixing a bug, so there is no need for an emergency fix,
> > > > > > > > and thus no point in additional churn.  I understand that it is a bit
> > > > > > > > annoying to code and test something and have your friendly maintainer say
> > > > > > > > "sorry, wrong rocks", and the reason that I understand this is that I do
> > > > > > > > that to myself rather often.
> > > > > > > 
> > > > > > > The motivation for me for this change is to avoid future bugs such as with
> > > > > > > the following patch where "== 2" did not take the force write of
> > > > > > > DYNTICK_IRQ_NONIDLE into account:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=13c4b07593977d9288e5d0c21c89d9ba27e2ea1f
> > > > > > 
> > > > > > Yes, the current code does need some simplification.
> > > > > > 
> > > > > > > I still don't see it as pointless churn, it is also a maintenance cost in its
> > > > > > > current form and the simplification is worth it IMHO both from a readability,
> > > > > > > and maintenance stand point.
> > > > > > > 
> > > > > > > I still don't see what's technically wrong with the patch. I could perhaps
> > > > > > > add the above "== 2" point in the patch?
> > > > > > 
> > > > > > I don't know of a crash or splat your patch would cause, if that is
> > > > > > your question.  But that is also true of the current code, so the point
> > > > > > is simplification, not bug fixing.  And from what I can see, there is an
> > > > > > opportunity to simplify quite a bit further.  And with something like
> > > > > > RCU, further simplification is worth -serious- consideration.
> > > > > > 
> > > > > > > We could also discuss f2f at LPC to see if we can agree about it?
> > > > > > 
> > > > > > That might make a lot of sense.
> > > > > 
> > > > > Sure. I am up for a further redesign / simplification. I will think more
> > > > > about your suggestions and can also further discuss at LPC.
> > > > 
> > > > One question that might (or might not) help:  Given the compound counter,
> > > > where the low-order hex digit indicates whether the corresponding CPU
> > > > is running in a non-idle kernel task and the rest of the hex digits
> > > > indicate the NMI-style nesting counter shifted up by four bits, what
> > > > could rcu_is_cpu_rrupt_from_idle() be reduced to?
> > > > 
> > > > > And this patch is on LKML archives and is not going anywhere so there's no
> > > > > rush I guess ;-)
> > > > 
> > > > True enough!  ;-)
> > > 
> > > Paul, do we also nuke rcu_eqs_special_set()?  Currently I don't see anyone
> > > using it. And also remove the bottom most bit of dynticks?
> > > 
> > > Also what happens if a TLB flush broadcast is needed? Do we IPI nohz or idle
> > > CPUs are the moment?
> > > 
> > > All of this was introduced in:
> > > b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
> > 
> > 
> > Paul, also what what happens in the following scenario:
> > 
> > CPU0                                                 CPU1
> > 
> > A syscall causes rcu_eqs_exit()
> > rcu_read_lock();
> >                                                      ---> FQS loop waiting on
> > 						           dyntick_snap
> > usermode-upcall  entry -->causes rcu_eqs_enter();
> > 
> > usermode-upcall  exit  -->causes rcu_eqs_exit();
> > 
> >                                                      ---> FQS loop sees
> > 						          dyntick snap
> > 							  increment and
> > 							  declares CPU0 is
> > 							  in a QS state
> > 							  before the
> > 							  rcu_read_unlock!
> > 
> > rcu_read_unlock();
> > ---
> > 
> > Does the context tracking not call rcu_user_enter() in this case, or did I
> > really miss something?
> 
> Holding rcu_read_lock() across usermode execution (in this case,
> the usermode upcall) is a bad idea.  Why is CPU 0 doing that?

Oh, ok. I was just hypothesizing that since usermode upcalls from
something as heavy as interrupts, it could also mean we had the same from
some path that held an rcu_read_lock() as well. It was just a theoretical
concern, if it is not an issue, no problem.

The other question I had was, in which cases would dyntick_nesting in current
RCU code be > 1 (after removing the lower bit and any crowbarring) ? In the
scenarios I worked out on paper, I can only see this as 1 or 0. But the
wording of it is 'dynticks_nesting'. May be I am missing a nesting scenario?
We can exit RCU-idleness into process context only once (either exiting idle
mode or user mode). Both cases would imply a value of 1.

thanks!

 - Joel

