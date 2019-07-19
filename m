Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E1C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1600C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTW8MZ4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfGSJ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:58:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41924 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:58:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so33941765eds.8;
        Fri, 19 Jul 2019 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gpYE+zJ6EXcLs21MOYZokgRLOUE5PGmGdhYUwcBgjU=;
        b=rTW8MZ4xBHDd/sC6TSsfB+StXORNzg7HRiHx1YbH0m4LtNTF6MrW/HUhQbrtZ6DkIK
         fkKCaXYur2JwBI1zyBUvUFcjMLrUqZWzcNGu//qOpVaRciPFjjG+AmeU84nNeuokIoRV
         310WML2iuWQenrkUXWsMF4KfGBfJDyfROXTZld/U3aBo9clcWlPRuFjmmawow6r82L31
         jfQCGR9rRt/G/hyx49P9BKHxJNANxhN/dfz/B3IuPlWTHElL3o1Yc8eBBYHRdFuoODDR
         8iICTsBnuzLTXtrtaDn+F6oQydOp8Jy5+Z0eCRl7LAOLNrTVRF01VTWvS57YP1491P42
         eDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gpYE+zJ6EXcLs21MOYZokgRLOUE5PGmGdhYUwcBgjU=;
        b=cH24Ng4p7xxDlV3HyzpBXrvnLTe1yY+yMjcCPWfguU/tB/bmNtCumtDAWehP3grth9
         1V7uS8w/NsVCBH5Dq0BzdqJ6t/SVEmeyuKMzlgE3apGZl4TQ7a74NwlJgIpXKAHYlYaJ
         OVTazzkH5T9dai9uNre563O8L/eoTRKYZsaxu5PvdrCrZUueIstXE5KPT3F5Hn4jIXRo
         TKBb+7VWQKITtjbdqAZ2VfyE98t8bpYPru5i8iSzOYp1a/fzDxyCUH4jdSwKZTUPKTQI
         lICMa0e39QvDwsfLSFCMzUZZgtm10i74Rejt9hjIwONmp1ZMJXzdu6Uxkui0sDtqSqDJ
         h4tw==
X-Gm-Message-State: APjAAAUunGrDiXrZucz/S6psh5mK0Cz9stnZjLHzZNFF6ZXlW5DWZ9ox
        WK1OtDhHCmQ5x83btQrFXGmxSv5Shyq87+OOQ9o=
X-Google-Smtp-Source: APXvYqz8Fuu5vbQkb81iceuLPYVPUjam3GRqu4pmMWX89pXd5blNX5FXfiQKk4TyQyIIdE5HJRqfrTu6skrxqvM8GNQ=
X-Received: by 2002:a17:906:9447:: with SMTP id z7mr40297534ejx.165.1563530289559;
 Fri, 19 Jul 2019 02:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190712063240.GD7702@X58A-UD3R> <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com> <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R> <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com>
In-Reply-To: <20190719074329.GY14271@linux.ibm.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Fri, 19 Jul 2019 18:57:58 +0900
Message-ID: <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > [snip]
> > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > grace period.
> > >
> > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > stopper from being scheduled on Y.
> > >
> > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > scheduler locks such as pi_lock or rq->lock or something.
> > >
> > > I think what you mentioned can happen easily.
> > >
> > > Basically we would need information about preemption/irq disabled
> > > sections on Y and scheduler's current activity on every cpu at that time.
> >
> > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > don't have NMI solutions and only IPI or interrupt based backtrace
> > works which should at least catch and the preempt disable and softirq
> > disable cases.
>
> True, though people with systems having hundreds of CPUs might not
> thank you for forcing an NMI backtrace on each of them.  Is it possible
> to NMI only the ones that are holding up the CPU stopper?

What a good idea! I think it's possible!

But we need to think about the case NMI doesn't work when the
holding-up was caused by IRQ disabled.

Though it's just around the corner of weekend, I will keep thinking
on it during weekend!

Thanks,
Byungchul

>                                                         Thanx, Paul
>
> > But yeah I don't see why just the stacks of those CPUs that are
> > blocking the CPU X would not suffice for the trivial cases where a
> > piece of misbehaving code disable interrupts / preemption and
> > prevented the stopper thread from executing.
> >
> > May be once the test case is ready (no rush!) , then it will be more
> > clear what can help.
> >
> > J.
> >



-- 
Thanks,
Byungchul
