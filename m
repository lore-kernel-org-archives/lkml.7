Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F886C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2FB212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWBbcelB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfFGSek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:34:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42989 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfFGSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:34:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so1862708qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FTavkhD/U3nEQ58jCZ6nyHW3BIZ3uQK2evEJdGyByI=;
        b=KWBbcelBqHz4SM9BWGrNUF1zTt4tuCpclsHaK2tEPnBd+RpgdiQ1ReEmqXyBTysXx4
         l19AejEXYeA53wt7erHU5CB2ajtGASH5ifr+TKWxr2SjCha6l+QBJeKGc6GwIxyGyIfD
         Anv55k0LyNI6wzPlFhLOhBkIaWPrJMhN75iwJ9FjyhJHfUK5wlGwWxuNP3BBza7tEKZ0
         TPiuQ3PivzNIbJMw9oB5Zze+pBxpWepHz2y0o4aiKXaQm4snFz3tWw/Cf5rnqkmTCg7Q
         4Lty7OABE6cS1YkdriLRGmxwbmWdGGm64o3aIDXBvdl72RAvkE/svhuMzImcMqD0sDMh
         sm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FTavkhD/U3nEQ58jCZ6nyHW3BIZ3uQK2evEJdGyByI=;
        b=kyHIrP0XRKOZuhJqcBc974Zs2Q7xKoknehatLEKbDOyqMdjXZ4pkkOf0Ne/WOeWPS5
         zSUNcFPKx1p26Dq75qOQ8XeKzIucGW02gFdSXIHYJh9oMqxPhIGc4PwTfEtcZFA0ORaC
         YH+2/WcnRVF0Zmzl+fiQ0v0UK8iGrt06EowfW0e/FoPbiJVXPGJoMP0BSgDdTSuY4ope
         PdpTd8cjYhJRLu8WbxknVvM5pnWtzpIHuuDe+YpIMsI/ITzKLzocg5W3I9+rm3/sr6N5
         vJpgI/S3Sj3t8puqfcNX9KWNWhjCgvqT6kkHhEsjWH5yKumIIy44f7ZyCpcicfgpDl15
         j7xw==
X-Gm-Message-State: APjAAAWAQPis2hzzkldzgSYjWy/7Xi3eFWrxZvJBYoF7LlNGdoDxrJvd
        TNpKyX0416hHuhW63+clmPA=
X-Google-Smtp-Source: APXvYqwj7+HWOc6CKPx++QAze7WF0RnuU6iSwKqcAY9hBYE7Jmw2rfjntzDrkobCVISN58r8zHIYdQ==
X-Received: by 2002:a37:a093:: with SMTP id j141mr25893984qke.244.1559932478969;
        Fri, 07 Jun 2019 11:34:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-97-17.3g.claro.net.br. [187.26.97.17])
        by smtp.gmail.com with ESMTPSA id 32sm1456816qta.91.2019.06.07.11.34.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 11:34:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4DD441149; Fri,  7 Jun 2019 15:34:34 -0300 (-03)
Date:   Fri, 7 Jun 2019 15:34:34 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v2 02/17] perf tools: Configure timestsamp generation in
 CPU-wide mode
Message-ID: <20190607183434.GO21245@kernel.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-3-mathieu.poirier@linaro.org>
 <c1507e8b-9ec8-a5c4-a398-20dcc47acaa8@arm.com>
 <CANLsYkx6o9xgxTh4s-o7tVxKKLu_SQc5CLtoHzHK=8WtNK4dbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkx6o9xgxTh4s-o7tVxKKLu_SQc5CLtoHzHK=8WtNK4dbQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 07, 2019 at 11:46:32AM -0600, Mathieu Poirier escreveu:
> On Fri, 7 Jun 2019 at 03:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> >
> >
> > On 24/05/2019 18:34, Mathieu Poirier wrote:
> > > When operating in CPU-wide mode tracers need to generate timestamps in
> > > order to correlate the code being traced on one CPU with what is executed
> > > on other CPUs.
> > >
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >   tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
> > >   1 file changed, 57 insertions(+)
> > >
> > > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > > index 3912f0bf04ed..be1e4f20affa 100644
> > > --- a/tools/perf/arch/arm/util/cs-etm.c
> > > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > > @@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
> > >       return err;
> > >   }
> > >
> > > +static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> > > +                             struct perf_evsel *evsel, int cpu)
> > > +{
> > > +     struct cs_etm_recording *ptr;
> > > +     struct perf_pmu *cs_etm_pmu;
> > > +     char path[PATH_MAX];
> > > +     int err = -EINVAL;
> > > +     u32 val;
> > > +
> > > +     ptr = container_of(itr, struct cs_etm_recording, itr);
> > > +     cs_etm_pmu = ptr->cs_etm_pmu;
> > > +
> > > +     if (!cs_etm_is_etmv4(itr, cpu))
> > > +             goto out;
> > > +
> > > +     /* Get a handle on TRCIRD0 */
> > > +     snprintf(path, PATH_MAX, "cpu%d/%s",
> > > +              cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> > > +     err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> > > +
> > > +     /* There was a problem reading the file, bailing out */
> > > +     if (err != 1) {
> > > +             pr_err("%s: can't read file %s\n",
> > > +                    CORESIGHT_ETM_PMU_NAME, path);
> > > +             goto out;
> > > +     }
> > > +
> > > +     /*
> > > +      * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
> > > +      * is supported:
> > > +      *  0b00000 Global timestamping is not implemented
> > > +      *  0b00110 Implementation supports a maximum timestamp of 48bits.
> > > +      *  0b01000 Implementation supports a maximum timestamp of 64bits.
> > > +      */
> > > +     val &= GENMASK(28, 24);
> > > +     if (!val) {
> > > +             err = -EINVAL;
> > > +             goto out;
> > > +     }
> > > +
> > > +     /* All good, let the kernel know */
> > > +     evsel->attr.config |= (1 << ETM_OPT_TS);
> > > +     err = 0;
> > > +
> > > +out:
> > > +     return err;
> > > +}
> > > +
> > >   static int cs_etm_set_option(struct auxtrace_record *itr,
> > >                            struct perf_evsel *evsel, u32 option)
> > >   {
> > > @@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
> > >                       if (err)
> > >                               goto out;
> > >                       break;
> > > +             case ETM_OPT_TS:
> > > +                     err = cs_etm_set_timestamp(itr, evsel, i);
> > > +                     if (err)
> > > +                             goto out;
> > > +                     break;
> > >               default:
> > >                       goto out;
> > >               }
> > > @@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> > >               err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
> > >               if (err)
> > >                       goto out;
> > > +
> > > +             err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
> > > +             if (err)
> > > +                     goto out;
> >
> > nit: Could we not do this in one shot, say :
> >
> >         cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS | ETM_OPT_CTXTID) ?
> >
> > rather than iterating over the per-CPU events twice ? The cs_etm_set_option()
> > could simply replace the switch() to :
> >
> >         if (option & ETM_OPT_1)
> >                 do_something_for_1()
> >         if (option & ETM_OPT_2)
> >                 do_something_for_2();
> >         if (option & ~(ETM_OPT_1 | ETM_OPT_2 |...))
> >                 /* do unsupported option */
> >
> 
> Yes, that is a good optimization.
> 
> Arnaldo, do you prefer a new set or another patch on top of this one?

On top of it, as this isn't a fix just an optimization, so no need to go
back and fix history to avoid bisection, etc.

Put it in your next set, no need to hurry.

- Arnaldo
 
> Thanks,
> Mathieu
> 
> >
> > Cheers
> > Suzuki

-- 

- Arnaldo
