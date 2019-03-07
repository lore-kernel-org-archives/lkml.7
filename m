Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F1FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146442063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551957925;
	bh=K4r8voO+Aeclu0B1PpQv0Vo7r103BlDj8eE4Ut26VYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bgA/Tsf6lnuEjCK+oNhxSuxPeSzXijrhDqFn1RWn7xEUmVwvRNtfQ32+/X5IdoRbN
	 i5aaYaS3W4DFNNEK6SgS2zKwmdWEzk9tCFpiaxXhyAiTF0eHFMRttMDJSouYSpdWIC
	 XJ7lvBS8yHECkpT8zZ+irUphahrKZFwTMU4Acvjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCGLZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:25:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46534 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:25:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id c18so13735462otl.13;
        Thu, 07 Mar 2019 03:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9Wc7Nae3rPVTJ10Vhar3uNPY79jIxXWbPF9dQCr0oQ=;
        b=BBqIVbt2qPXxosOeXAlfU4AX7hkg18kYo0DdNWwDU+40T9lmiixQXMemL/fqlnSBuJ
         AzuaEhEiyPWTmaDioHUamR2NGpcOu6qzlTsR5NHOLoWoFnGWilIzrMiyX4Z69NZ0IFhO
         ncih57WJrETZF39OvSukxoNK5KG6vOWH/1VqrTWWqX655TYFgWWmg3K5IIivdfOVb534
         H/nuZHTOUYAyVA2WejzEo8HzUeEzeGqEWslC0VPLYcPx1YHP1K4QTFtjNLo2+wMlvMOP
         ekrZLrxAGNQF7aOu0TVg/t5wCV6BwK5s6Czz/eFeh/sYT5dGxbpfoeHGjdfXOSBpLIVC
         eYzw==
X-Gm-Message-State: APjAAAVP/dXZgy6Ns33DAoEearzPSSALB4u7/64Sy5BUmLKxEMYQ2m1N
        GUNYtpnBKoHPNFS3N+lNrQrBaUPKGTBrBtm1zks=
X-Google-Smtp-Source: APXvYqx0PMmP2CwyXp6I99t9uk2hAITTpvLIMN+NwtJErp5nDHFeEjf4qXKoTJLuVvhFgubDd5bOFqLrtuJPt/b+x4I=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr7143664otl.244.1551957921603;
 Thu, 07 Mar 2019 03:25:21 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net> <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
 <20190305173746.p32xolcpueudlzwn@queper01-lin> <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
 <20190307110256.padefvq4e52ly3nm@queper01-lin>
In-Reply-To: <20190307110256.padefvq4e52ly3nm@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Mar 2019 12:25:10 +0100
Message-ID: <CAJZ5v0hDBPBciBKEKpS_HBTHLiiZ0gKKkzGYPJ6fafNNMn48ew@mail.gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 12:03 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Rafael,
>
> On Wednesday 06 Mar 2019 at 11:05:47 (+0100), Rafael J. Wysocki wrote:
> > Please recall that the iowait boosting algo was different to start
> > with, though: it jumped to the max right away and then backed off.
> > That turned out to be overly aggressive in general and led to some
> > undesired "jittery" behavior, which is why it was changed.
> >
> > Thus it looks like the platforms on which it still jumps to the max
> > right away may actually benefit from changing it to more steps. :-)
>
> On the energy side of things at least ... ;-)
>
> > In turn, the platforms where it takes more than 3 steps for the boost
> > to get to the max would get a slight performance improvement from this
> > changes and I'm not sure why that could be bad.
>
> For energy possibly ? IIUC this thread:
>
>     https://patchwork.kernel.org/patch/9735885/
>
> the original intent of the ramp thing for the iowait boost was to reduce
> power consumption.
>
> > Moreover, it didn't depend on the min originally, just on the max and
> > just because I wanted the number of backoff steps needed to go back
> > down to zero to be independent of the platform IIRC.  The dependency
> > on the min is sort of artificial here and leads to arbitrary
> > differences in behavior between different platforms which isn't
> > particularly fortunate.
>
> It's a question of perspective I would say. Right now you can say the
> behaviour is somewhat coherent across platforms: getting an IOWAIT boost
> means you'll run twice as fast regardless of your board. With the '128
> approach', you may or may not run faster, depending on your set of OPPs.
>
> Also on recent big little SoCs, the capacity ratio can be pretty high.
> You can get little CPUs with 300 of capacity or so. The arbitrary 128
> thing is basically gonna go near max freq in one step, although the CPUs
> actually 20 available OPPs or so. And I guess that's a shame.

OK, you seem to be arguing that on some platforms there is a little
difference between 128 and 1024 in terms of power, while there may be
a lot of difference between, say, 64 and 128.

I can buy that, but then it also makes sense to boost quickly enough,
so maybe it could start at the min and jump from there to 256 right
away in the first step?

> For these reasons, I feel like it's not completely idiotic to have a
> platform-dependent starting point, although arguably min_freq might not
> always be the best choice.
>
> > With all of that in mind, I would go right away to making the boost
> > independent of min and max (the final number of steps to reach the max
> > is TBD in practice, but 3 looks like a good enough compromise to me).
>
> Perhaps the energy model could help find a good starting point, and a
> good number of steps ?
>
> FWIW there should be a slot at OSPM to discuss how sugov could be made
> smarter using the EM :-).

Well, if you can make a case for that. :-)
