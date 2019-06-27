Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D2C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Y6a0QfMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF0PhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:37:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46446 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfF0PhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:37:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so2802711ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAiAhNcqqN83HV89jHOtQmAjXiR+1D1hV8qVzm4kOU8=;
        b=Y6a0QfMeusE49Ow+gzUNmBUFqbgGMHCmtrJxOwnQ1MeKB4oeIz2c1FjE6XfWiDKqcc
         MuUDD5UDha0tq/z87lL2noiWB5GadljzQX29Uzd2+g2Wc8RJDsGA+bSD1uLLdueeGqXY
         AYELY011UNU6k3vC4YWhRcgU7bHMetl7JeuVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAiAhNcqqN83HV89jHOtQmAjXiR+1D1hV8qVzm4kOU8=;
        b=IJxcx3PedXtrjJJuPuMU0ZgcTeDW2xBtlmj6YKEPSTA5yGxLWyWqHzV9lzBoQVbk2n
         /jsCQw8HaSY6GSYpLIdIc5JM27UwziGkG/uXnXdZPLnr233qiQlygyh2u5Hlcup1FE62
         r/aGN9wj5IOwSrMMXy33y1gNJU+xFwyGKtF+YGROflPMGrKmnOXsX7MAwoCEeN+Fugtu
         n1YM5Tr3DwMbp5YkOfauggKNPH2A/RWktA48rvuTbpTpBahyJw+zBgMPpUZP2Sa0360f
         aIJjPN/u6HhN+vcZivTv45VuZVAIIhlJtWxqwDDm0rYRdwxu2V9pnpotEI5XInrjNYMJ
         6iKA==
X-Gm-Message-State: APjAAAU5aNXx/uqtLbxi+xeBREn+RTn6g5rdEdkctRxh7oGV+1Z1qAyW
        apRW9i/ZxAk1lYmJRchQBTN3pbagY5dSy0jm3lKtjw==
X-Google-Smtp-Source: APXvYqzNFkRWe/SoiGTQbadQfRPFwDyBo4PC+WzGPLG3NhGCymU6wRDcrcjauByJfvCIrZCSyHzLTrwl7bQCjE8lsY8=
X-Received: by 2002:a2e:7315:: with SMTP id o21mr2995067ljc.3.1561649841872;
 Thu, 27 Jun 2019 08:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
In-Reply-To: <20190627153031.GA249127@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 11:37:10 -0400
Message-ID: <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
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

On Thu, Jun 27, 2019 at 11:30 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> > On Thu, 27 Jun 2019 10:24:36 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > > What am I missing here?
> > >
> > > This issue I think is
> > >
> > > (in normal process context)
> > > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > >                        // but this was done in normal process context,
> > >                        // not from IRQ handler
> > > rcu_read_lock();
> > >           <---------- IPI comes in and sets exp_hint
> >
> > How would an IPI come in here with interrupts disabled?
> >
> > -- Steve
>
> This is true, could it be rcu_read_unlock_special() got called for some
> *other* reason other than the IPI then?
>
> Per Sebastian's stack trace of the recursive lock scenario, it is happening
> during cpu_acct_charge() which is called with the rq_lock held.
>
> The only other reasons I know off to call rcu_read_unlock_special() are if
> 1. the tick indicated that the CPU has to report a QS
> 2. an IPI in the middle of the reader section for expedited GPs
> 3. preemption in the middle of a preemptible RCU reader section
>
> 1. and 2. are not possible because interrupts are disabled, that's why the
> wakeup_softirq even happened.
> 3. is not possible because we are holding rq_lock in the RCU reader section.
>
> So I am at a bit of a loss how this can happen :-(

Sebastian it would be nice if possible to trace where the
t->rcu_read_unlock_special is set for this scenario of calling
rcu_read_unlock_special, to give a clear idea about whether it was
really because of an IPI. I guess we could also add additional RCU
debug fields to task_struct (just for debugging) to see where there
unlock_special is set.

Is there a test to reproduce this, or do I just boot an intel x86_64
machine with "threadirqs" and run into it?
