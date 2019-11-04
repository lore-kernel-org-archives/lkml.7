Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F6CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DC3214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1XZp68j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfKDRsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:48:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45228 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfKDRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:48:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so12878434lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CerRZqVW5KD7h9g62jmCWoCx6bdHOPRVAdr0IAwl3q4=;
        b=S1XZp68j+Ms0VaWxxXY2vQrcslic0wHP2t2PK+Wp3XqXu8dKiItgWxUNh9UYCWgJHW
         WmHMEpApUaFgvTAr5rh35Ofvs4kqzS55jCAhlPCmb+rrceUlL3Dzj54dDH41fdA2uQrf
         yGTHyWv5QlxJBnXQji5LhihyLNWQclUizI+8A9Zuu4XS15bFaYxMZC1FMYMCnwcZ3n7Q
         iPZVo/dahHCXQK1OEz6H1ERxppSBbGh6e1kxNz0hEKnWOE42P24kXk4nbk1JE97iWPkY
         v2bai5G9Y+MIrOzTOv7KVQYikbOUCJ3tOcism5JK/OekL8C6fnG2Q5Udo4ID9imcClin
         8JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CerRZqVW5KD7h9g62jmCWoCx6bdHOPRVAdr0IAwl3q4=;
        b=IlNzhnCGQDJNrzHdSWxCvnKwokJTNSko42OdHIO9vdI/dDaSLE00YiqBe/6KK7Kk13
         PSJdY4eL08WcE3ggOZpyLQ/xBFeeT6ve41EHEde9CaF4j0ITrXG+nG44L+08xhomqfaE
         8la0mtKMFcRpI9QCz4d+1saA2jwK00H3uXm9Skx07ZtYEKW3EgjX8lTGuUTKovqi8CUO
         nAsvlQ5eX0wnP0yVEW2I4g9CMDEIqzbvdKlx3JikKTmm2FzTd96PvyTdnU7Y2p5Xv1yd
         6wK6V6UN6wrTKeJPJPqwrYWcGT/YuIXmm0KeYQBgx28WeW7TABLAH6kyiZn9QDZLwaWf
         pVfA==
X-Gm-Message-State: APjAAAXDmaDsBcbhPByiEz23YP52A7cPaIf/fQkz86kdrT3WOs9PP3tS
        ss9VsImZmIt2T13l93Vy9f6n5lAyimMPK/UbneUi1w==
X-Google-Smtp-Source: APXvYqwRT7xzZik+9WmXSwJ+LXqDAPfWrYHgtQVcA4NrPPlvJ0uY0GQDNdpubQws9aQunlKscwmfGYN38gKmc5l5C14=
X-Received: by 2002:ac2:48af:: with SMTP id u15mr17204731lfg.151.1572889724743;
 Mon, 04 Nov 2019 09:48:44 -0800 (PST)
MIME-Version: 1.0
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
 <379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com> <5DBC9C57.3040504@linaro.org>
 <dc30ed89-6581-d99d-03bb-58ea40b74a3d@arm.com> <CAKfTPtBQ1_7ApBkAQrEBy7twohSiM3WcYa-JiHekbedR8C3EKg@mail.gmail.com>
 <d7c590b5-f415-ecad-0e81-def9f9bc1296@arm.com>
In-Reply-To: <d7c590b5-f415-ecad-0e81-def9f9bc1296@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Nov 2019 18:48:32 +0100
Message-ID: <CAKfTPtBAsiVemcmB6VeS9MVrO4z0qY9H6+3mh5DS-7WOOy-fdw@mail.gmail.com>
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 18:42, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 04/11/2019 18:34, Vincent Guittot wrote:
> > On Mon, 4 Nov 2019 at 18:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 01/11/2019 21:57, Thara Gopinath wrote:
> >>> On 11/01/2019 08:17 AM, Dietmar Eggemann wrote:
> >>>> On 22.10.19 22:34, Thara Gopinath wrote:
>
> [...]
>
> >>> You still need now.All the update_*_avg apis take now as a parameter.
> >>
> >> You do need it for the ___update_load_sum() call inside the
> >> foo_load_avg() functions. But that doesn't mean you have to pass it into
> >> foo_load_avg(). Look at update_irq_load_avg() for example. We don't pass
> >> rq->clock as now in there.
> >
> > update_irq_load_avg is the exception but having now as a parameter is
> > the default behavior that update_thermal_load_avg have to follow
>
> Why would this be? Just so the functions have the the same parameters?

That's the default behavior to keep all pelt function to behave
similarly and keep outside what is not strictly related to pelt so it
will ease any further modification
sched_thermal_decay_coeff is not a pelt parameter but a thermal one
irq_avg is an exception not the default behavior to follow

>
> In this case you could argue that update_irq_load_avg() has to pass in
> rq->clock as now.
>
> >> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> >> +extern int sched_thermal_decay_coeff;
> >> +
> >> +int update_thermal_load_avg(struct rq *rq, u64 capacity)
> >>  {
> >> +       u64 now = rq_clock_task(rq) >> sched_thermal_decay_coeff;
> >> +
> >>         if (___update_load_sum(now, &rq->avg_thermal,
> >>                                capacity,
> >>                                capacity,
