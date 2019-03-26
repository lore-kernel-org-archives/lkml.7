Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA7620857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553596602;
	bh=yn+zcbe5vHmzuxaaXc8U6ognhrxRs3M8GUNaTIFYqt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=umaO0aax6+4e/f9bNskRuMn1dwI0RD8fo4lLbcbR2UlJFZkaMfh7/ypPreOZjP188
	 CTzvA1p6NM5lDz8j94sJj3XTZs1JiaY/lS0gf+uimAk9WlmO5FAY/gqAr96cAWy6v0
	 VxGG+eCdzETke85QJD/lAgXxtDzBsyBkmjqhPJOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfCZKgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:36:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33801 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:36:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id k21so9590284otf.1;
        Tue, 26 Mar 2019 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8j1B6OwetF9lBqmH6rAe0V0MqvmwARcP8TsPhZtHqQ=;
        b=tUEQes7zzbIs06PwAD7QlfENw45jKFjbSRQPtKO4/jLaFNHNIYByoBP3kyiyZYN0OS
         F9tqPi8D7nCAnIK4w0z9VrykwLJZuYXImKmP2DajLpHK/R8NLYrRt7e/WTCkd/7645tm
         OoMzAaC1qkP1Lzzbc/i6IfUwGmRDLqImN2L2q2zr+30xGZjmBDbV/vj/+uIN/lSjThLE
         fEOx6uUQD4ibdhmdCAORLBwIHMl3SjLE1Mo6VHLS0756/vSS6d+iNen6i7o1i+W2sjgq
         cdk5m7ikTEB2FPsRGzfeldGT4C/KkjuPVBOYVO5SJAyOexcbY0H5OAm3gd1/dE83VkcY
         TRPQ==
X-Gm-Message-State: APjAAAVGwpwbs1PIIdNMJxKsnGoAG8YZYJ2NUl5WNiR6X2EzIU6fFuY2
        CzseIcOgfafLE6HlDvOO5mYN58p8s0Dz9TkK6rE=
X-Google-Smtp-Source: APXvYqz9gqwmf/hj92we5sSVxPPQgaG3L1fYFdHikS27eQ71XBNB6iRel5FOTU8JxEQ617UPxb/yevGOr8mDdFikid4=
X-Received: by 2002:a9d:738c:: with SMTP id j12mr20483042otk.119.1553596600485;
 Tue, 26 Mar 2019 03:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org> <2942111.nn8VVVUCAL@aspire.rjw.lan>
 <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
In-Reply-To: <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 11:36:29 +0100
Message-ID: <CAJZ5v0gHpX0=Urwj5z+FS=PKibM1VO0B5ZEQvwnvqXbUV_=fpg@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 3:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 25 Mar 2019 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> > > To be able to predict the sleep duration for a CPU that is entering idle,
> > > knowing when the next timer/tick is going to expire, is extremely useful.
> > > Both the teo and the menu cpuidle governors already makes use of this
> > > information, while selecting an idle state.
> > >

[cut]

> >
> > > +
> > >       if (cpuidle_state_is_coupled(drv, index))
> > >               return cpuidle_enter_state_coupled(dev, drv, index);
> > >       return cpuidle_enter_state(dev, drv, index);
> >
> > Also I would clear next_hrtimer here to avoid dragging stale values
> > around.
>
> Right, I can do that.
>
> However, at least in my case it would be an unnecessary update of the
> variable, as I am never in a path where the value can be "stale".

It easily can AFAICS.  After all, cpu_power_down_ok() need not run on
the same CPU that is setting next_hrtimer here.

> Even if one theoretically could use a stale value, it's seems likely to not
> be an issue, don't you think?

That would be because of the locking in the ->enter() callback I
suppose?  But is it actually universally guaranteed that setting
next_hrtimer will never be reordered with acquiring the lock?

Also, there is some overhead to be avoided if cpu_power_down_ok()
checked the next_hrtimer of the other CPUs against 0 explicitly, isn't
it?
