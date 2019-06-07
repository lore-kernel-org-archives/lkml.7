Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D24C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2F5208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSGfcj1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfFGRqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:46:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35060 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:46:45 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so2068032ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGmBbbRWFo234O0ByoHzH5djRqtJUP/+gKNDjfi0ktg=;
        b=XSGfcj1IOPYQbpqtlN+cMfxYHMJGXzTsP7R2SENjFD5r+ZZSMN2L7x2ee0FXcNEldO
         Rt88V2mbBhXKwecz/KlFLfUKszcmNPPAL09D2sYuxcNhgCdSjn7jZAucRGy9vlFAwNjq
         oxWyov48Y4hATJrDHadH0u9gUvH5/XFySKG56cOI5Z11wp+mCKyVO02j1BPrREdYthAL
         iy6oBZs/H1ppEFG6pM1vY0ZronAHPbDe95sorgybDhwmG+et7L1OysCqtwlp4Ng21MgG
         VrNT+mM7esgI3iK4tyURZwYeE/MQV7y5XHK7PyBDa+U++Ye/+7YW96FY/ypVO37vSbV5
         vo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGmBbbRWFo234O0ByoHzH5djRqtJUP/+gKNDjfi0ktg=;
        b=ViUStW9hK5IhJeHHhI+6GOsc0Mq5gcIMo02X4KyV7WkMshwvFM3C7f1qMvmZRhLFvF
         it4jIqtueuyIS93F1etvpbGvW2afyuOt00tnR7ZVhv3urEFvocxhGx5IKorELXQhmJZE
         U3jKmjmSCmChjuzG/Gh9kEAx2NFnxgza5T52Mg2ChoGP3cIAy5cmuuSJ9WlF+JSUqi+0
         ObqPanuemLL1pe0ntTgnjptSIDakW64JYVxOyZBTDA3tJDXwtOQVvA/uVM51Yc8bcdHm
         2c/zyOVxqo6QqXvN2elhYMxRU44fXbf+jpxJzwfFCnDTePOHS+I85ZUmPElKHzMlt1AV
         g8aQ==
X-Gm-Message-State: APjAAAUdOlBUROdZYimF21CN8+kwMaNtN7h7tAaySSnZhimoNEkCLHzz
        M4wzrpWDvJ7VkdaMYXWHxsqt8nvrBkT7TRaV10CsAw==
X-Google-Smtp-Source: APXvYqzcojG7IhnLk8f2hB3YsMsOg6cYvCD99jIIpOf/uzmSkn3NO8EuVgnxxOq/xMVendXgc7HudOQRbCab/mMtcP4=
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr19471049ios.57.1559929603835;
 Fri, 07 Jun 2019 10:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-3-mathieu.poirier@linaro.org> <c1507e8b-9ec8-a5c4-a398-20dcc47acaa8@arm.com>
In-Reply-To: <c1507e8b-9ec8-a5c4-a398-20dcc47acaa8@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 7 Jun 2019 11:46:32 -0600
Message-ID: <CANLsYkx6o9xgxTh4s-o7tVxKKLu_SQc5CLtoHzHK=8WtNK4dbQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] perf tools: Configure timestsamp generation in
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

On Fri, 7 Jun 2019 at 03:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 24/05/2019 18:34, Mathieu Poirier wrote:
> > When operating in CPU-wide mode tracers need to generate timestamps in
> > order to correlate the code being traced on one CPU with what is executed
> > on other CPUs.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 3912f0bf04ed..be1e4f20affa 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
> >       return err;
> >   }
> >
> > +static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> > +                             struct perf_evsel *evsel, int cpu)
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
> > +     /* Get a handle on TRCIRD0 */
> > +     snprintf(path, PATH_MAX, "cpu%d/%s",
> > +              cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
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
> > +      * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
> > +      * is supported:
> > +      *  0b00000 Global timestamping is not implemented
> > +      *  0b00110 Implementation supports a maximum timestamp of 48bits.
> > +      *  0b01000 Implementation supports a maximum timestamp of 64bits.
> > +      */
> > +     val &= GENMASK(28, 24);
> > +     if (!val) {
> > +             err = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     /* All good, let the kernel know */
> > +     evsel->attr.config |= (1 << ETM_OPT_TS);
> > +     err = 0;
> > +
> > +out:
> > +     return err;
> > +}
> > +
> >   static int cs_etm_set_option(struct auxtrace_record *itr,
> >                            struct perf_evsel *evsel, u32 option)
> >   {
> > @@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
> >                       if (err)
> >                               goto out;
> >                       break;
> > +             case ETM_OPT_TS:
> > +                     err = cs_etm_set_timestamp(itr, evsel, i);
> > +                     if (err)
> > +                             goto out;
> > +                     break;
> >               default:
> >                       goto out;
> >               }
> > @@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> >               err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
> >               if (err)
> >                       goto out;
> > +
> > +             err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
> > +             if (err)
> > +                     goto out;
>
> nit: Could we not do this in one shot, say :
>
>         cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS | ETM_OPT_CTXTID) ?
>
> rather than iterating over the per-CPU events twice ? The cs_etm_set_option()
> could simply replace the switch() to :
>
>         if (option & ETM_OPT_1)
>                 do_something_for_1()
>         if (option & ETM_OPT_2)
>                 do_something_for_2();
>         if (option & ~(ETM_OPT_1 | ETM_OPT_2 |...))
>                 /* do unsupported option */
>

Yes, that is a good optimization.

Arnaldo, do you prefer a new set or another patch on top of this one?

Thanks,
Mathieu

>
> Cheers
> Suzuki
