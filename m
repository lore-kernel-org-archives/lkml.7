Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0EBC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556267750;
	bh=rDJKs8zI9XQQqqoxoLSjl3Ycy6tM2XmzPrhr4sq/aLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6FFEBdxTyfjPToV6moW/MmTYPPTY1j/dxxZ6dc6aD9kArTyowsNtQEAtX+P2MTGs
	 ePFs3MXIW4I8Ohr4V6SikPXkGekW+/O9I92PdidxdL+qws4WSVf9TGHZ6oWU4mD/CL
	 bmkC+yXhoHQyeL0QWSmXzNI02Ahw2bsYqGtRsbYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfDZIft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:35:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDZIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:35:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so2711298wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=auh2n5ez8f3k8JtxERTzIFczyJO/2QRKYQZuO2eMI80=;
        b=DBmHizx3C8v5SJgwIiJorLVtGcbi+kk7TVMw9v//OzwQnudYqHFH6yGePov3jews/n
         dhZE7R7yZBMdt57zD9kI86qYnCq7CFaxDaQvukOv2qoot+6GGZ4GWDIrke7L4Sy7jb2L
         3SCY9wXZBmd6JJzTAqfybsnGqx3f03b2BEWuQxfWO+tPQpNjgkDzqryy7SfGsUS7EbeH
         zo1pAT5xsatgFVOOP4OnIRvhjkBqL+l2ZD25zEX8uGbmiBbGMtHrI/0r3CTcRx7K8bLc
         Mz1m1XhTcXQb3BupnPdQ3uk3bDBWXZfJI61nn4FZQMOsM8NFvk2NSeywbiMtcw7X3QFU
         6CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=auh2n5ez8f3k8JtxERTzIFczyJO/2QRKYQZuO2eMI80=;
        b=GCQLST1ZL1JwH8kvu3Gxn4YCTdWG5dhzDCDzgq25VAI3LIzTLXK/zfzo3WAfN7TDj2
         ttCoYHBQsEJaJJNOUd8y55mhyCnwl7/a1Wg7ynbQ7ui6WL/wsXMOE9vKmTaRG9vhUAm+
         AZEpNQ3kFdkmQUeSAHybKVZFuwZgZ5D9DJC8pgvqczxRB9T68+2lQi4GsnXV9yha7EjW
         BdqIfCSMlTrbWfQtJyR/EYFKgLhVO0+9CMydy7lByUvbd0UCruffdrTY8TR5pt1CBDrq
         XbGF5N784fSo4+8pMe8+77OF/fTt95PupzGUeRX4CcfvWiH+NlrEK5XKOR5t0O0+0Sle
         hTcg==
X-Gm-Message-State: APjAAAWgGgtVLVK+LfnPJdw2st5wlzi1eXvEbQxK24FfayQoEQcSFyQu
        I7SyI4xcvTl3zoyJ4Yr3j7A=
X-Google-Smtp-Source: APXvYqzJTQGtxLVvkGztocjN5ZNjkDSLJVlj8LZyxQCn5qmrlV7g11sA0X9r/K+7hBn4JbFaFvrDvA==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr6628017wmd.30.1556267747054;
        Fri, 26 Apr 2019 01:35:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z4sm2773615wrq.75.2019.04.26.01.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 01:35:46 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:35:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190426083543.GB126896@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
 <20190417182932.GB5140@gmail.com>
 <20190424163424.GG4038@hirez.programming.kicks-ass.net>
 <20190425173333.GA4081@gmail.com>
 <20190425174425.GA121124@gmail.com>
 <CAKfTPtBQs9yBPQbzZykvEca-pjjuSmB2wTAHJbFxuW-ew-ew7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBQs9yBPQbzZykvEca-pjjuSmB2wTAHJbFxuW-ew-ew7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> On Thu, 25 Apr 2019 at 19:44, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > >
> > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > On Wed, Apr 17, 2019 at 08:29:32PM +0200, Ingo Molnar wrote:
> > > > > Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load
> > > > > tracking approach.
> > > >
> > > > I seem to remember competing proposals, and have forgotten everything
> > > > about them; the cover letter also didn't have references to them or
> > > > mention them in any way.
> > > >
> > > > As to the averaging and period, I personally prefer a PELT signal with
> > > > the windows lined up, if that really is too short a window, then a PELT
> > > > like signal with a natural multiple of the PELT period would make sense,
> > > > such that the windows still line up nicely.
> > > >
> > > > Mixing different averaging methods and non-aligned windows just makes me
> > > > uncomfortable.
> > >
> > > Yeah, so the problem with PELT is that while it nicely approximates
> > > variable-period decay calculations with plain additions, shifts and table
> > > lookups (i.e. accelerates pow()), AFAICS the most important decay
> > > parameter is fixed: the speed of decay, the dampening factor, which is
> > > fixed at 32:
> > >
> > >   Documentation/scheduler/sched-pelt.c
> > >
> > >   #define HALFLIFE 32
> > >
> > > Right?
> > >
> > > Thara's numbers suggest that there's high sensitivity to the speed of
> > > decay. By using PELT we'd be using whatever averaging speed there is
> > > within PELT.
> > >
> > > Now we could make that parametric of course, but that would both
> > > complicate the PELT lookup code (one more dimension) and would negatively
> > > affect code generation in a number of places.
> >
> > I missed the other solution, which is what you suggested: by
> > increasing/reducing the PELT window size we can effectively shift decay
> > speed and use just a single lookup table.
> >
> > I.e. instead of the fixed period size of 1024 in accumulate_sum(), use
> > decay_load() directly but use a different (longer) window size from 1024
> > usecs to calculate 'periods', and make it a multiple of 1024.
> 
> Can't we also scale the now parameter of ___update_load_sum() ?
> If we right shift it before calling ___update_load_sum, it should be
> the same as using a half period of 62, 128, 256ms ...
> The main drawback would be a lost of precision but we are in the range
> of 2, 4, 8us compared to the 1ms window
> 
> This is quite similar to how we scale the utilization with frequency and uarch

Yeah, that would work too.

Thanks,

	Ingo
