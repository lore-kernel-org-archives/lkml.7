Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3272084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIQCHSxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfDZHIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:08:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37949 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:08:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so1677667lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXrFXB2NzklWq6nejt9rEAAWErabyL0mpEfbi7YUPJQ=;
        b=NIQCHSxvxTKsbDwGB2MVJmn1q9VNAV4YaA8r48nrEyBAAasITPzSo8m22+dn7wdCXO
         B/59n9LwS1KafALy7RrzGrIAqySMfP8KhU+8cIpWHKcAhxeifWuKwceW8WUEbKgHVPyc
         5uOwA2hWaiY9ACnQPeZszpSEqBnvpUUmFO1+mUoaRJ/dzMqaViEWJh8nB77TVj7qEh+6
         nS/4Mpqr0cMX7eSRI09mBAktSjTLv2/MtuiY054dxIY3p2K9YhKeRarYMwge4x5Fcwkg
         okHNTNEWmWBp4ZeMeCRFboimDVOvf2mkdWrbJvAf1DBSRrCw7UAtyBMCJocRXdgCfFmU
         SJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXrFXB2NzklWq6nejt9rEAAWErabyL0mpEfbi7YUPJQ=;
        b=dgiUu+fFipmLTG0hMx4bMw5PI7ZV2d5N66OHulSpOJx8nQUuIzCSVDoRj2Vxw+UE2Z
         5iczYDdKfto6g+XSqsM+m3B8CNolfcDN/mZtFUDySg4EjuBW6cH7FBfJRjLM+74YIGiM
         ti+FoJTZSh8KEHcYHNwIe0HUoxth2u6xZMiX5u8WHZDyAF9WbYvSgkJCmb8o6kcRNw4G
         Ib/FL/v3Dsxvj+iiSDXJF7GR2Q3kEVlAXmzAq6yUnxJQLAyXLa0sxzsEMI3Ix/obIH5h
         /H+UlaUh9ChmoWgID7b49ATbF3UrbQkJ8msW1s7rsIn0ynDOmxc2vlw32x57IM8r0P1w
         EdoA==
X-Gm-Message-State: APjAAAVnzt9MIWCtcJwC2Kucfk60dHJxfc9iQYS3miLJRsGswJobbwT7
        eNsMtksyhWHotTK7jAiKzxAfSmTouGy7YTFDPAQNEw==
X-Google-Smtp-Source: APXvYqwe5FJm2TQxHXCjVjdQIf21U2luKIGZF0m2/ANiaANjy/pt/qX3bbnZGIn2YTcQdo3+VRE64uVzD6cDTqznmvo=
X-Received: by 2002:ac2:4301:: with SMTP id l1mr7431299lfh.54.1556262521194;
 Fri, 26 Apr 2019 00:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com> <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com> <20190424163424.GG4038@hirez.programming.kicks-ass.net>
 <20190425173333.GA4081@gmail.com> <20190425174425.GA121124@gmail.com>
In-Reply-To: <20190425174425.GA121124@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Apr 2019 09:08:29 +0200
Message-ID: <CAKfTPtBQs9yBPQbzZykvEca-pjjuSmB2wTAHJbFxuW-ew-ew7A@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 19:44, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > On Wed, Apr 17, 2019 at 08:29:32PM +0200, Ingo Molnar wrote:
> > > > Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load
> > > > tracking approach.
> > >
> > > I seem to remember competing proposals, and have forgotten everything
> > > about them; the cover letter also didn't have references to them or
> > > mention them in any way.
> > >
> > > As to the averaging and period, I personally prefer a PELT signal with
> > > the windows lined up, if that really is too short a window, then a PELT
> > > like signal with a natural multiple of the PELT period would make sense,
> > > such that the windows still line up nicely.
> > >
> > > Mixing different averaging methods and non-aligned windows just makes me
> > > uncomfortable.
> >
> > Yeah, so the problem with PELT is that while it nicely approximates
> > variable-period decay calculations with plain additions, shifts and table
> > lookups (i.e. accelerates pow()), AFAICS the most important decay
> > parameter is fixed: the speed of decay, the dampening factor, which is
> > fixed at 32:
> >
> >   Documentation/scheduler/sched-pelt.c
> >
> >   #define HALFLIFE 32
> >
> > Right?
> >
> > Thara's numbers suggest that there's high sensitivity to the speed of
> > decay. By using PELT we'd be using whatever averaging speed there is
> > within PELT.
> >
> > Now we could make that parametric of course, but that would both
> > complicate the PELT lookup code (one more dimension) and would negatively
> > affect code generation in a number of places.
>
> I missed the other solution, which is what you suggested: by
> increasing/reducing the PELT window size we can effectively shift decay
> speed and use just a single lookup table.
>
> I.e. instead of the fixed period size of 1024 in accumulate_sum(), use
> decay_load() directly but use a different (longer) window size from 1024
> usecs to calculate 'periods', and make it a multiple of 1024.

Can't we also scale the now parameter of ___update_load_sum() ?
If we right shift it before calling ___update_load_sum, it should be
the same as using a half period of 62, 128, 256ms ...
The main drawback would be a lost of precision but we are in the range
of 2, 4, 8us compared to the 1ms window

This is quite similar to how we scale the utilization with frequency and uarch

>
> This might just work out right: with a half-life of 32 the fastest decay
> speed should be around ~20 msecs (?) - and Thara's numbers so far suggest
> that the sweet spot averaging is significantly longer, at a couple of
> hundred millisecs.
>
> Thanks,
>
>         Ingo
