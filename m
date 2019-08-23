Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E96C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDC322CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQF17QvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395071AbfHWM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:56:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43079 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfHWM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:56:46 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so19760426ioe.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XID+uEqMpo1msXzHrPG2vXSXUSZE5du4xRV16C8TdVE=;
        b=iQF17QvRNQaaa/SIlshzYQUZu/ekcylkeuAJeL6K9WbpMM0NllsteRFxJevNe0+vQM
         xiRVHpq1kNDbKoXS8G+VBhpqrKp5J3tWcXCh7mEAU63XCNhmmgP3rRJCfYqPH3MfWpRA
         i3kR29HYF4+GmI4vnVvvHDisZ3wyvwk34QgKZIerZ1y5D/8elj6mAxWeob51zj2Vu7eq
         WMG+JTt0XB21g+Ra+FeXzEkQLFdcPnFRd9hkI8yurwRog7ZVPu40P9xoV9thk7XiBrJC
         LnN4UN+IoFjyVohCLbJtxZwJOvjPBirv78eVraj91gXl74uiqGTf1B3b1YW/aBGnLrH3
         Dqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XID+uEqMpo1msXzHrPG2vXSXUSZE5du4xRV16C8TdVE=;
        b=egn/QlrXSKK4MnsTeCX/PtyLBw1vCIiffMWBSAT3XWS+ZzJYglnwsc1I9sqAswSAod
         ZmUHnJQpbej896ywhYLebBFftiIR6eOtker/vxSiLyNZVapJkB8+N3dkAXbtk1Mmfp87
         AwbGH4aJJeIZQCmpbjGXd6/sSnCfNbyGm13EU8Y1s8aXlg9fsUuQkJ/ohhHeOWd1th3A
         FZ0xwFnI2ce1fZFZiOH4Dhw9My2aeqFWzduWtz/POmlmC4FIueVZaRt1LBbYjyxApWUN
         Nld/ZC/FN+1E6Sm7SpBCPQP1cl6q8SS0VEzxTiI6X6lphUQy6gRFTtuIye5feJv8DkaP
         xSew==
X-Gm-Message-State: APjAAAVfqDgGNxSFeuGGofQV00FVKXjKWglxABW4n6JTuhwZnrmVxE95
        /X9zQt86TMeaD3MIHMlf0eQskYPuoZlyZ/UnWfRHOr7V
X-Google-Smtp-Source: APXvYqwima7WTSlzAySQFeHBINGCr77JSflI0BPv/RYgV6+cgWpOR6GK8sOj0uki2rcOaPN0EFFNxtz7TnCEMxjG6Qw=
X-Received: by 2002:a5e:8e09:: with SMTP id a9mr6632065ion.238.1566565005719;
 Fri, 23 Aug 2019 05:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
 <20190624075520.GC3436@hirez.programming.kicks-ass.net> <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
 <CAKTKpr6m7YzqJ7U2icNHq7ZwoG0pw8ws_EHcLR+-T6ZeEfe15Q@mail.gmail.com> <20190823115946.GM2349@hirez.programming.kicks-ass.net>
In-Reply-To: <20190823115946.GM2349@hirez.programming.kicks-ass.net>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 23 Aug 2019 18:26:34 +0530
Message-ID: <CAKTKpr5N6thBR+SJ8rdRTCEjv+7GVsw3R9EY+cKTGexz-yr4sg@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Aug 23, 2019 at 5:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

Sorry for the top-posting.
>
> On Fri, Aug 23, 2019 at 04:13:46PM +0530, Ganapatrao Kulkarni wrote:
>
> > We are seeing regression with our uncore perf driver(Marvell's
> > ThunderX2, ARM64 server platform) on 5.3-Rc1.
> > After bisecting, it turned out to be this patch causing the issue.
>
> Funnily enough; the email you replied to didn't contain a patch.

Hmm sorry, not sure why the patch is clipped-off, I see it in my inbox.
>
> > Test case:
> > Load module and run perf for more than 4 events( we have 4 counters,
> > event multiplexing takes place for more than 4 events), then unload
> > module.
> > With this sequence of testing, the system hangs(soft lockup) after 2
> > or 3 iterations. Same test runs for hours on 5.2.
> >
> > while [ 1 ]
> > do
> >         rmmod thunderx2_pmu
> >         modprobe thunderx2_pmu
> >         perf stat -a -e \
> >         uncore_dmc_0/cnt_cycles/,\
> >         uncore_dmc_0/data_transfers/,\
> >         uncore_dmc_0/read_txns/,\
> >         uncore_dmc_0/config=0xE/,\
> >         uncore_dmc_0/write_txns/ sleep 1
> >         sleep 2
> > done
>
> Can you reproduce without the module load+unload? I don't think people
> routinely unload modules.

The issue wont happen, if module is not unloaded/reloaded.
IMHO, this could be potential bug!

>
>

Thanks,
Ganapat
