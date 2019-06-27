Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89119C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622D7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yL54hFeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF0Qri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:47:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38758 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0Qrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:47:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so3078727ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fP8Sg3qOi5RkXjx6ZyzKJn5DQ7slXEGVgd1aV4dwPMs=;
        b=yL54hFeMZHqyW7Ixx4fI2UB2nyITEp3UG11a33d3ga9G/npgfHBKurYmAhoo6abFOB
         dQioC/MtzJkNc4w1xvunxd2M+lI82+lvxwwgjWYYFxUHYfP/tDAIveYLx3GHA9bbXvd8
         kE6gNmilJFrsXlgsA5QcvEvEG3hQIQw2a/bKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP8Sg3qOi5RkXjx6ZyzKJn5DQ7slXEGVgd1aV4dwPMs=;
        b=p4JBu8QbKWzls3LfGprlt3tyvLBNO+8rYqV7y0F/jNJY5fiGO2fNv2MdUg0HXdrofu
         mRSYnnTcJgwk2JpojIAhK/e05f2xVpyCsJ8xOaNp5dpE/fFStOf348hzoX7ViwdApUy6
         /AQybrY80YXS1GPBCTloKZ9YIpE2tWFRyKQEPaSRAK6+c7Huxb307DYPvMXrcOuLQtlC
         7hcLGuXsqj5vCgG6InupL2ZnjM1HGtBYuzXURaK8/PV5Vz7Yq14XtEXjQ/fpInea1S2M
         +NLxcVtrL6nxZI3ey8kuN7gKDwXjBTvdK/T+sk7BE69hz3P3NaX5LdePjyjST4AAlxgh
         Aq+g==
X-Gm-Message-State: APjAAAVhA8KrdHe3SwbZUKYs1LaEKHMs55iYoxa+SZbXeBFdmu5Ah/HW
        oldq6j0AUDIq5AoSXeF0GG8MK7mMLKxz1v/OxpT1cg==
X-Google-Smtp-Source: APXvYqxw8W5U4CLprBkvfkk69su6Tl2j2dyf8Tx/LjZ+7eUUdWaQJYhaT3WTvGpyHsojfx1wvZ7M/rR1AtbR8RmWWrU=
X-Received: by 2002:a2e:1510:: with SMTP id s16mr3152570ljd.19.1561654055489;
 Thu, 27 Jun 2019 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
In-Reply-To: <20190627155506.GU26519@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 12:47:24 -0400
Message-ID: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:55 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Thu, Jun 27, 2019 at 11:30:31AM -0400, Joel Fernandes wrote:
> > On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> > > On Thu, 27 Jun 2019 10:24:36 -0400
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > > > What am I missing here?
> > > >
> > > > This issue I think is
> > > >
> > > > (in normal process context)
> > > > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > > >                      // but this was done in normal process context,
> > > >                      // not from IRQ handler
> > > > rcu_read_lock();
> > > >           <---------- IPI comes in and sets exp_hint
> > >
> > > How would an IPI come in here with interrupts disabled?
> > >
> > > -- Steve
> >
> > This is true, could it be rcu_read_unlock_special() got called for some
> > *other* reason other than the IPI then?
> >
> > Per Sebastian's stack trace of the recursive lock scenario, it is happening
> > during cpu_acct_charge() which is called with the rq_lock held.
> >
> > The only other reasons I know off to call rcu_read_unlock_special() are if
> > 1. the tick indicated that the CPU has to report a QS
> > 2. an IPI in the middle of the reader section for expedited GPs
> > 3. preemption in the middle of a preemptible RCU reader section
>
> 4. Some previous reader section was IPIed or preempted, but either
>    interrupts, softirqs, or preemption was disabled across the
>    rcu_read_unlock() of that previous reader section.

Hi Paul, I did not fully understand 4. The previous RCU reader section
could not have been IPI'ed or been preempted if interrupts were
disabled across. Also, if softirq/preempt is disabled across the
previous reader section, the previous reader could not be preempted in
these case.

That leaves us with the only scenario where the previous reader was
IPI'ed while softirq/preempt was disabled across it. Is that what you
meant? But in this scenario, the previous reader should have set
exp_hint to false in the previous reader's rcu_read_unlock_special()
invocation itself. So I would think t->rcu_read_unlock_special should
be 0 during the new reader's invocation thus I did not understand how
rcu_read_unlock_special can be called because of a previous reader.

I'll borrow some of that confused color paint if you don't mind ;-)
And we should document this somewhere for future sanity preservation
:-D

thanks,
 - Joel



>
> I -think- that this is what Sebastian is seeing.
>
>                                                         Thanx, Paul
>
> > 1. and 2. are not possible because interrupts are disabled, that's why the
> > wakeup_softirq even happened.
> > 3. is not possible because we are holding rq_lock in the RCU reader section.
> >
> > So I am at a bit of a loss how this can happen :-(
> >
> > Spurious call to rcu_read_unlock_special() may be when it should not have
> > been called?
> >
> > thanks,
> >
> > - Joel
