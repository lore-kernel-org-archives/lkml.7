Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED0C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471F921019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OYS8zzov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGRQOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:14:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41207 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:14:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id 62so14742604lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaojJi+dg+txqNSRlh/qKTQmkDls7tEGMsUj1+NKXOE=;
        b=OYS8zzovkDSGmIJ5CvE9WtxD7QYP4M0Wj43MxRDLoPkEtknF9Ezu3QRWS2geVPNYdH
         p5jfH44AUZqRV1RbpJ6MCL/ss9ND2Yf1dP9WUJNXXaCrRUTrpvq34svc5owsm8UzuR1H
         RgtKXG3jd5avfNUDAFFYfCoJxWimD8RNkSGTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaojJi+dg+txqNSRlh/qKTQmkDls7tEGMsUj1+NKXOE=;
        b=nNq8+UGb++/kUnK3nae9EN0Qia5fNhg/2Sj4Ma53lExgHzUJ6cu6BkiXZb1GedPtC2
         IYTkYa8uoFUPnMW50dX90px3fOlRjqt6rDqZKWCWMrfN5D+UbGf6nZAyb5gjM4hkStx4
         j7hJzo7e7hz+BsWs97O91cWzyAuYDZgP+q951Drvlu/RYuLW/cGc9Vfg4KeN+WgyQAP3
         P88Kk/KAE1tgbfHxJG2KVH0KCjWgCN1iwQ6MZEdKYgFXbxXwzGetApiK1m8rboSvefpg
         Zt3nYPLRGtUB3zzUHg2+qKpJY4Gyfyf/AHUNv7hikM7008Wy84EC+yLYMu9/Z5AQ2tzy
         8C6Q==
X-Gm-Message-State: APjAAAWBZnEVwYr9v245X8+SZ46sAuW7qa8kLX2pak1SU7QY/7mHyrDx
        todhnJxpO3NAaGyG5rn9AHakxaKWG80/9Y1rbW8=
X-Google-Smtp-Source: APXvYqyhnUflYyfqDDAii3Dm8cVfsNANSxmQ1PKt1+23cthFmJd4RCj10tEqWheZW4oA2Iytx1fG7Cf+iASqjwWTGJQ=
X-Received: by 2002:a19:6602:: with SMTP id a2mr20784338lfc.25.1563466473470;
 Thu, 18 Jul 2019 09:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190711130849.GA212044@google.com> <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com> <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com> <20190713174111.GG26519@linux.ibm.com>
In-Reply-To: <20190713174111.GG26519@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Jul 2019 12:14:22 -0400
Message-ID: <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming the list a bit to keep my noise level low,

On Sat, Jul 13, 2019 at 1:41 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
[snip]
> > It still feels like you guys are hyperfocusing on this one particular
> > > knob.  I instead need you to look at the interrelating knobs as a group.
> >
> > Thanks for the hints, we'll do that.
> >
> > > On the debugging side, suppose someone gives you an RCU bug report.
> > > What information will you need?  How can you best get that information
> > > without excessive numbers of over-and-back interactions with the guy
> > > reporting the bug?  As part of this last question, what information is
> > > normally supplied with the bug?  Alternatively, what information are
> > > bug reporters normally expected to provide when asked?
> >
> > I suppose I could dig out some of our Android bug reports of the past where
> > there were RCU issues but if there's any fires you are currently fighting do
> > send it our way as debugging homework ;-)
>
>   Suppose that you were getting RCU CPU stall
> warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> Of course, this really means that some other CPU/task is holding up
> multi_cpu_stop() without also blocking the current grace period.
>

So I took a shot at this trying to learn how CPU stoppers work in
relation to this problem.

I am assuming here say CPU X has entered MULTI_STOP_DISABLE_IRQ state
in multi_cpu_stop() but another CPU Y has not yet entered this state.
So CPU X is stalling RCU but it is really because of CPU Y. Now in the
problem statement, you mentioned CPU Y is not holding up the grace
period, which means Y doesn't have any of IRQ, BH or preemption
disabled ; but is still somehow stalling RCU indirectly by troubling
X.

This can only happen if :
- CPU Y has a thread executing on it that is higher priority than CPU
X's stopper thread which prevents it from getting scheduled. - but the
CPU stopper thread (migration/..) is highest priority RT so this would
be some kind of an odd scheduler bug.
- There is a bug in the CPU stopper machinery itself preventing it
from scheduling the stopper on Y. Even though Y is not holding up the
grace period.

Did I get that right? Would be exciting to run the rcutorture test
once Paul has it available to reproduce this problem.

thanks,

 - Joel
