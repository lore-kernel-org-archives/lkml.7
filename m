Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33951C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D39208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io4ZHtOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfFGRks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:40:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33715 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:40:48 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so2064239iop.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlxCx0LcVRqEwUVpBa/0X4MAmO56cf6FlxJFEgvmnmc=;
        b=io4ZHtOx+pe44IJE28hPvzsRLOIt0VwvSmyD7ESSJ9h8O27pk1n+Hu2xfBOvwNgSP0
         A0qXMDL1mnGbV4WnCyav2N0tLJLbq4v/mT6AQDbTltZ0G9/gl+GSIW8rX8K7AQLt9XQl
         8vdSg87x62g2hXZTZjVmuhpcIqFjX6Lj1NY+K7gL075+JM7GVBcOPtyAAr7uM/Ydj2/S
         BGA1YLbBlm+NOEuKupWaszdkWXxBmVFuUc3dbpGyqDCQCdgE2i2Iz3eDG10bb9P1+Rvi
         twKS0O2ciONkTTOzsCLm6R4b4lAhv1H8P3Qt3IqVArTp7DyyNe36QpP3FOa7rkKzMW/R
         LHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlxCx0LcVRqEwUVpBa/0X4MAmO56cf6FlxJFEgvmnmc=;
        b=nB3xisvIKuMbE6U2OeX5ghbT1flidO17ptWTcazpk1Rh+sR0Bzf5c7g32ldalOZtl5
         NQfQbc20VnUxhRBlP4AsxnwMj10Br1ZJSckmr+Qnk++y+v7nMPPedS7Yv6hF7bfrUksP
         OFIgJeAS6TCEjr5hpu4zB1pnr/AnXCtNR7m/tXL1ID9REr6BV461zUfgbiWwLCW4ROXz
         WWkmJ3ad8vvqgMqNpnNTw0ESmTIT4zUu1ZnxaHeUdPnOMAadHnMiM4q5OZiwvfDBADlH
         ti76DY7mHkP+iqBcXDSZGRkzrxB11B+sqWF7/dNH9NdtF9nL9hMTW+h8p1AHCJmuWCKy
         OJXA==
X-Gm-Message-State: APjAAAXa/+PZCkUq082aq4nzgmrR1Zq0tbYeLzw60yvBf73hBCpXAR0K
        THDSj+WlM7pPQRvh2bqVfVFHZssqvurcJ5rLgyZ3fg==
X-Google-Smtp-Source: APXvYqyS/7a9/Dz1ggiv03hBOU54xjqxDo1Iciw3ODbbVW7tjvpMqHtRefyhNI4gWQstaMZPH3Y3mM+VTfb1fXN7wps=
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr14036127ioq.50.1559929247404;
 Fri, 07 Jun 2019 10:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-2-mathieu.poirier@linaro.org> <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
In-Reply-To: <68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 7 Jun 2019 11:40:36 -0600
Message-ID: <CANLsYkwrsvSXOpaxL7mFxiJF5A53Xk+3XDK14r_Z=wBLzDZy9A@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] perf tools: Configure contextID tracing in
 CPU-wide mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Suzuki,

On Fri, 7 Jun 2019 at 03:21, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 24/05/2019 18:34, Mathieu Poirier wrote:
> > When operating in CPU-wide mode being notified of contextID changes is
> > required so that the decoding mechanic is aware of the process context
> > switch.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> I am sorry but, I don't remember reviewing this patch in the previous
> postings. But here we go.

We definitely misunderstood each other - apologies for that.

>
> > ---
> >   tools/perf/arch/arm/util/cs-etm.c | 126 +++++++++++++++++++++++++-----
> >   tools/perf/util/cs-etm.h          |  12 +++
> >   2 files changed, 119 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 911426721170..3912f0bf04ed 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -35,8 +35,100 @@ struct cs_etm_recording {
> >       size_t                  snapshot_size;
> >   };
> >
>
>
> >   static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> >
> > +static int cs_etm_set_context_id(struct auxtrace_record *itr,
> > +                              struct perf_evsel *evsel, int cpu)
> > +{
> > +     struct cs_etm_recording *ptr;
> > +     struct perf_pmu *cs_etm_pmu;
> > +     char path[PATH_MAX];
> > +     int err = -EINVAL;
> > +     u32 val;
> > +
> > +     ptr = container_of(itr, struct cs_etm_recording, itr);
> > +     cs_etm_pmu = ptr->cs_etm_pmu;
> > +
> > +     if (!cs_etm_is_etmv4(itr, cpu))
> > +             goto out;
> > +
> > +     /* Get a handle on TRCIRD2 */
> > +     snprintf(path, PATH_MAX, "cpu%d/%s",
> > +              cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
> > +     err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> > +
> > +     /* There was a problem reading the file, bailing out */
> > +     if (err != 1) {
> > +             pr_err("%s: can't read file %s\n",
> > +                    CORESIGHT_ETM_PMU_NAME, path);
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
> > +      * is supported:
> > +      *  0b00000 Context ID tracing is not supported.
> > +      *  0b00100 Maximum of 32-bit Context ID size.
> > +      *  All other values are reserved.
> > +      */
> > +     val = BMVAL(val, 5, 9);
> > +     if (!val || val != 0x4) {
> > +             err = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     /* All good, let the kernel know */
> > +     evsel->attr.config |= (1 << ETM_OPT_CTXTID);
> > +     err = 0;
> > +
> > +out:
> > +
> > +     return err;
> > +}
> > +
> > +static int cs_etm_set_option(struct auxtrace_record *itr,
> > +                          struct perf_evsel *evsel, u32 option)
> > +{
> > +     int i, err = -EINVAL;
> > +     struct cpu_map *event_cpus = evsel->evlist->cpus;
> > +     struct cpu_map *online_cpus = cpu_map__new(NULL);
> > +
> > +     /* Set option of each CPU we have */
> > +     for (i = 0; i < cpu__max_cpu(); i++) {
> > +             if (!cpu_map__has(event_cpus, i) ||
> > +                 !cpu_map__has(online_cpus, i))
> > +                     continue;
> > +
> > +             switch (option) {
> > +             case ETM_OPT_CTXTID:
> > +                     err = cs_etm_set_context_id(itr, evsel, i);
> > +                     if (err)
> > +                             goto out;
> > +                     break;
> > +             default:
> > +                     goto out;
> > +             }
> > +     }
>
> I am not too familiar with the perf tool code. But, isn't there a way
> to force the config bit, right from the beginning when the events are
> created, when we know that we are doing a CPU wide tracing, along with
> the other config bits ?
>
>

This code is ran just after the event list is created.  In order to
avoid this step and have the config bits set right from the beginning
one would have to explicitly specify the options within the '/' '/' of
the cs_etm event on the command line, which would be cumbersome and
error prone.  Instead this code guarantees that all options needed for
a CPU-wide session are set properly.

>
> > +     err = 0;
> > +out:
> > +     cpu_map__put(online_cpus);
> > +     return err;
> > +}
> > +
> >   static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
> >                                        struct record_opts *opts,
> >                                        const char *str)
> > @@ -105,8 +197,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> >                               container_of(itr, struct cs_etm_recording, itr);
> >       struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> >       struct perf_evsel *evsel, *cs_etm_evsel = NULL;
> > -     const struct cpu_map *cpus = evlist->cpus;
> > +     struct cpu_map *cpus = evlist->cpus;
> >       bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
> > +     int err = 0;
> >
> >       ptr->evlist = evlist;
> >       ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
> > @@ -241,19 +334,24 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> >
> >       /*
> >        * In the case of per-cpu mmaps, we need the CPU on the
> > -      * AUX event.
> > +      * AUX event.  We also need the contextID in order to be notified
> > +      * when a context switch happened.
> >        */
> > -     if (!cpu_map__empty(cpus))
> > +     if (!cpu_map__empty(cpus)) {
> >               perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
> >
> > +             err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
> > +             if (err)
> > +                     goto out;
> > +     }
> > +
> >       /* Add dummy event to keep tracking */
> >       if (opts->full_auxtrace) {
> >               struct perf_evsel *tracking_evsel;
> > -             int err;
> >
> >               err = parse_events(evlist, "dummy:u", NULL);
> >               if (err)
> > -                     return err;
> > +                     goto out;
> >
> >               tracking_evsel = perf_evlist__last(evlist);
> >               perf_evlist__set_tracking_event(evlist, tracking_evsel);
> > @@ -266,7 +364,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> >                       perf_evsel__set_sample_bit(tracking_evsel, TIME);
> >       }
> >
> > -     return 0;
> > +out:
> > +     return err;
> >   }
>
>
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 0e97c196147a..826c9eedaf5c 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -103,6 +103,18 @@ struct intlist *traceid_list;
> >   #define KiB(x) ((x) * 1024)
> >   #define MiB(x) ((x) * 1024 * 1024)
> >
> > +/*
> > + * Create a contiguous bitmask starting at bit position @l and ending at
> > + * position @h. For example
> > + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > + *
> > + * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
> > + */
> > +#define GENMASK(h, l) \
> > +     (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > +
>
> minor nit: Could this be placed in a more generic header file for the other
> parts of the perf tool to consume ?

Back when I wrote this code my thinking was to keep it private since
nobody else in the perf tools had a need for it.  But I now that
Arnaldo added the header back in August [1] there is no need for a
private version.

Arnaldo, do you want a patch on top of the current patchset or a new set?

[1]. ba4aa02b417f0 (Arnaldo Carvalho de Melo 2018-09-25 10:55:59 -0300
17)  * GENMASK_ULL(39, 21)

>
> > +#define BMVAL(val, lsb, msb) ((val & GENMASK(msb, lsb)) >> lsb)
> > +
>
>
> Cheers
> Suzuki
