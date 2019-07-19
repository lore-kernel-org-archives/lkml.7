Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCECC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6FB2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wJ4Do64T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGSAsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:48:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42648 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:48:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so14740715plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7jHRVGYnOvUursfYWZeDAUUnbVipDkEH1tJJIaRboaw=;
        b=wJ4Do64TgslH5ajaP39l3lzWeOkT7er76jZGcUJG2PYrgj1XIa8WPr5AJWdIo6ztbf
         6SgS4u/Mzqxd5dp6vzMR0WsJQS8P2WmPY/FjBG/JNFP0Rn8+sIYpTm4QHn1+gah9+xck
         sdm0QTt3Tc4LqhY6vZJzce98FmnJotTEeFC6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7jHRVGYnOvUursfYWZeDAUUnbVipDkEH1tJJIaRboaw=;
        b=WdPCm2FXsdjbXKYeEA6WVPTU6XPzA5f9K2gOlxUhpPtRlVWINWCV2c7R767t0NDMWd
         SDnyLhMekTpVz6FD01ulp2r3dm5q45jO6hwPhVq8w8JtjdQ6VTO5JAuUzegvJrY+mPpn
         MqBZwEpHww+z0y106HZirjUkJWwJtzf+tS7x0pJadjf9cSFmmHio5IKFfh0ZobfgYBL8
         Y5rhj+j8B0h6g8bLj4OV8/poe140SV/tEzqlvanvtz0AvNRMMh7gbztymaexknv7wMIA
         s8qR/luho3JlLpes/kpUtAbDR3ILS0R4k+X0ezV/h7FpSd+jE6BOuNE9AK0KKk83rb7N
         BeFA==
X-Gm-Message-State: APjAAAViZ/0LtgHQ7mhesgQOIqk1NJBeYFxOX7MQbzRahOc8FFfSel7Y
        hpUP86Nt36UH67f0Y58+Ol0=
X-Google-Smtp-Source: APXvYqx734KcWZYzkKf3/SIjDUX0yRPIkJuI1pcTeivj+Em++JUJ/9kBxm9LhHvmYSzZWN8PSnJwwQ==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr49965858pll.298.1563497328827;
        Thu, 18 Jul 2019 17:48:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m16sm29639113pfd.127.2019.07.18.17.48.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:48:48 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:48:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190719004846.GA61615@google.com>
References: <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190718213419.GV14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718213419.GV14271@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:34:19PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 18, 2019 at 12:14:22PM -0400, Joel Fernandes wrote:
> > Trimming the list a bit to keep my noise level low,
> > 
> > On Sat, Jul 13, 2019 at 1:41 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > [snip]
> > > > It still feels like you guys are hyperfocusing on this one particular
> > > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > > >
> > > > Thanks for the hints, we'll do that.
> > > >
> > > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > > What information will you need?  How can you best get that information
> > > > > without excessive numbers of over-and-back interactions with the guy
> > > > > reporting the bug?  As part of this last question, what information is
> > > > > normally supplied with the bug?  Alternatively, what information are
> > > > > bug reporters normally expected to provide when asked?
> > > >
> > > > I suppose I could dig out some of our Android bug reports of the past where
> > > > there were RCU issues but if there's any fires you are currently fighting do
> > > > send it our way as debugging homework ;-)
> > >
> > >   Suppose that you were getting RCU CPU stall
> > > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > > Of course, this really means that some other CPU/task is holding up
> > > multi_cpu_stop() without also blocking the current grace period.
> > >
> > 
> > So I took a shot at this trying to learn how CPU stoppers work in
> > relation to this problem.
> > 
> > I am assuming here say CPU X has entered MULTI_STOP_DISABLE_IRQ state
> > in multi_cpu_stop() but another CPU Y has not yet entered this state.
> > So CPU X is stalling RCU but it is really because of CPU Y. Now in the
> > problem statement, you mentioned CPU Y is not holding up the grace
> > period, which means Y doesn't have any of IRQ, BH or preemption
> > disabled ; but is still somehow stalling RCU indirectly by troubling
> > X.
> > 
> > This can only happen if :
> > - CPU Y has a thread executing on it that is higher priority than CPU
> > X's stopper thread which prevents it from getting scheduled. - but the
> > CPU stopper thread (migration/..) is highest priority RT so this would
> > be some kind of an odd scheduler bug.
> > - There is a bug in the CPU stopper machinery itself preventing it
> > from scheduling the stopper on Y. Even though Y is not holding up the
> > grace period.
> 
> - CPU Y might have already passed through its quiescent state for
>   the current grace period, then disabled IRQs indefinitely.
>   Now, CPU Y would block a later grace period, but CPU X is
>   preventing the current grace period from ending, so no such
>   later grace period can start.

Ah totally possible, yes!

thanks,

 - Joel

