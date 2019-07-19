Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E2C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A633A2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iOcnUsUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfGSUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:34:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35505 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfGSUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:34:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so31986966ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWoLcIWo45da57QgaYno7VI6Op8uVj/Cqdt+Sn9VmY0=;
        b=iOcnUsUOUmUDjUPd2RB7piycSYuRa0AXleJVgdN2h7YSBPG3416E5nC6hOnjd+wwLj
         Ggo0iU/RRwL6CXCbxKfsxQoSLuMiCW1vGnCQyhaTUt4tV3nx9uTJr2CpIGB8xyPZCfMy
         VLJL5zyEFPoIpF/pFAmQzdew8l7ALpgpyKrt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWoLcIWo45da57QgaYno7VI6Op8uVj/Cqdt+Sn9VmY0=;
        b=he1XBejCt3OyjLExSi7Uwebrc68GxnIx6h2AxwFrJoEeaE8tMupKSByEIe/2oPce8n
         P16vE5bOb0jaIqE1l6aKx58M3Bw70Qn8h9bQl1z6plSQsfE0KbU/EjlolAMoBuXGlGWJ
         QvssXSO7Mnoz6XeQcyWQeXjNZcvlfn1h4hmbiTRyPH/Msl4XixhSlsDva8p7GVzcXwOH
         cy11MxZ8RBicxda+nhXMoZihNMZzYMOnB1jDd3/lhaNy4sxyv2res8V9X8zCtuV7lPo7
         qs4kfbOL1WX5S0PRTn5uHjtoAfJUUu4fLlHjNnMbiYqXtTAcluiQktS+7OImtof4mQbY
         C5Iw==
X-Gm-Message-State: APjAAAWRRU31LH3saabB2BcOaQFv/Pb7ZqxNkravatV+pVigSvmmPGUx
        cF3xw0m9BB7e0IqbMx1Kyo9CUSE2hr4zQC3/7Hg=
X-Google-Smtp-Source: APXvYqxJIT/ulpm6D6M1/aGWkcJqVmFa6Pfr0jgRty160DDMnx2/Xlv3f7J7ThMzu8xCHC17SRMRSvZJyZSJy8P3R5o=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr28981129lja.112.1563568448218;
 Fri, 19 Jul 2019 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com> <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com> <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R> <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com> <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
 <20190719195728.GF14271@linux.ibm.com>
In-Reply-To: <20190719195728.GF14271@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 Jul 2019 16:33:56 -0400
Message-ID: <CAEXW_YQADrPRtJW7yJZyROH1_d2yOA7_1HVgm50wxpOC80+=Wg@mail.gmail.com>
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

On Fri, Jul 19, 2019 at 3:57 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Fri, Jul 19, 2019 at 06:57:58PM +0900, Byungchul Park wrote:
> > On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > > > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > > > [snip]
> > > > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > > > grace period.
> > > > >
> > > > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > > > stopper from being scheduled on Y.
> > > > >
> > > > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > > > scheduler locks such as pi_lock or rq->lock or something.
> > > > >
> > > > > I think what you mentioned can happen easily.
> > > > >
> > > > > Basically we would need information about preemption/irq disabled
> > > > > sections on Y and scheduler's current activity on every cpu at that time.
> > > >
> > > > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > > > don't have NMI solutions and only IPI or interrupt based backtrace
> > > > works which should at least catch and the preempt disable and softirq
> > > > disable cases.
> > >
> > > True, though people with systems having hundreds of CPUs might not
> > > thank you for forcing an NMI backtrace on each of them.  Is it possible
> > > to NMI only the ones that are holding up the CPU stopper?
> >
> > What a good idea! I think it's possible!
> >
> > But we need to think about the case NMI doesn't work when the
> > holding-up was caused by IRQ disabled.
> >
> > Though it's just around the corner of weekend, I will keep thinking
> > on it during weekend!
>
> Very good!

Me too will think more about it ;-) Agreed with point about 100s of
CPUs usecase,

Thanks, have a great weekend,

 - Joel
