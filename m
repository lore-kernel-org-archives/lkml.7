Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pda6oP3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfFGOpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:45:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38828 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfFGOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:45:03 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so3096123itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0461UCKFoYu7Rdu8kwzbsR/mRhSFbTO2AAbs+xAqEe8=;
        b=Pda6oP3d4skdQ2p0gZWXIABX6SCh0/CQLL5/TN+p7/4QZ48etg+wtnhwMMUx6SKsoV
         kdKMUgzUAJPFEsyxhG80zygITwLxXK02Xc3gifTmplLjlf6UAevPd79GDDjRt6rNq59y
         aIjQy+WKPTdGmgkPnNXT6y7856CHhjMvSkCExgN1cxQ2KFgzTYdwi6gelqGN82ujKcRR
         4xJjHdaIQvFJh1ywa3Mdse9m9AW0oqvKd5ac4ye1dtgL3/zSctxElomulabRHy1YCp7B
         hhOu8F5Wxu3q3S9hoXnEmn2HFR5JkddExLoOqUBGt0D4kiXaWS1AGL5YkmMeNBrOLBTG
         i6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0461UCKFoYu7Rdu8kwzbsR/mRhSFbTO2AAbs+xAqEe8=;
        b=blQVPQDm4CYUYxgdhMSR6tsDg20ceWj3PY4Ei6UnztQWu3uRsvwvpiWXtkZtgStFY+
         IRLfOpIWz5tf0RXCNm+KChr/9EG0MfL28OW5/r00hHk5IzzdPWNhuukmELxfM9ZUWPwp
         m9lU3zuK7S/Bix8G2ZP2VxpxH0S6fXc0Kb5jMJCROF96A4Dgy1bVsWtXw7LrNFavJkA7
         cjh6iCv2DrCFxC4tq/DizIrUzbit97Vur2nLNlXpemIxb3VR35CiNhgBQQAr0/h/q2YX
         2mksTf7E+3dFEzSSnBcWfVNoEy0pjL0akny1I2zoTz7Yk9t8mXHDZa6Ki4bAwdu+n7bV
         c1Bw==
X-Gm-Message-State: APjAAAUQF21lVWPtHi5iS7Ky6qgP0SGeZWmqs0pf158w9c1oRrqUXAtq
        ZzNns5SwjkDvg4WjVVBlTJWJ+QvbvGARcS4W/1G9Rw==
X-Google-Smtp-Source: APXvYqzrKoOE+6wc8YTZ6KchVxmLj9eHPCQREDvKnJwJlTQngGpbtDOqcZsj2EHYvg5QTfN/Pdz0fvzzd0ENCF4PUAk=
X-Received: by 2002:a24:c384:: with SMTP id s126mr4186373itg.1.1559918702032;
 Fri, 07 Jun 2019 07:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190605161633.12245-1-mathieu.poirier@linaro.org> <20190606201056.GJ21245@kernel.org>
In-Reply-To: <20190606201056.GJ21245@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 7 Jun 2019 08:44:51 -0600
Message-ID: <CANLsYky1XFBjO-F9Sf_Spkw+p_Cm5n+DDUaAbKMmHkc+GgeHMQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Properly set the value of 'old' and 'head' in
 snapshot mode
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 at 14:11, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 05, 2019 at 10:16:33AM -0600, Mathieu Poirier escreveu:
> > This patch adds the necessay intelligence to properly compute the value
> > of 'old' and 'head' when operating in snapshot mode.  That way we can get
> > the latest information in the AUX buffer and be compatible with the
> > generic AUX ring buffer mechanic.
>
> Leo, have you had the chance to test/review this one? Suzuki?

Leo did test this before and added his Tested-by on the Coresight
mailing list.  I did not carried it here because I changed the call to
reallocarray() to realloc() in order to avoid cross compilation
problems.  I think it is safe enough but other people's opinion may
differ so I played it safe.  Leo, please test this again if/when you
have the time.

>
> I also changed the subject to:
>
>   [PATCH] perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode
>
> So that when looking at a 'git log --oneline' one can have the proper
> context and know that its about cs-etm.

Very well.

Mathieu

>
> - Arnaldo
>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c | 127 +++++++++++++++++++++++++++++-
> >  1 file changed, 123 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 911426721170..0a278bbcaba6 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -31,6 +31,8 @@ struct cs_etm_recording {
> >       struct auxtrace_record  itr;
> >       struct perf_pmu         *cs_etm_pmu;
> >       struct perf_evlist      *evlist;
> > +     int                     wrapped_cnt;
> > +     bool                    *wrapped;
> >       bool                    snapshot_mode;
> >       size_t                  snapshot_size;
> >  };
> > @@ -536,16 +538,131 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
> >       return 0;
> >  }
> >
> > -static int cs_etm_find_snapshot(struct auxtrace_record *itr __maybe_unused,
> > +static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
> > +{
> > +     bool *wrapped;
> > +     int cnt = ptr->wrapped_cnt;
> > +
> > +     /* Make @ptr->wrapped as big as @idx */
> > +     while (cnt <= idx)
> > +             cnt++;
> > +
> > +     /*
> > +      * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
> > +      * cross compilation problems where the host's system supports
> > +      * reallocarray() but not the target.
> > +      */
> > +     wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
> > +     if (!wrapped)
> > +             return -ENOMEM;
> > +
> > +     wrapped[cnt - 1] = false;
> > +     ptr->wrapped_cnt = cnt;
> > +     ptr->wrapped = wrapped;
> > +
> > +     return 0;
> > +}
> > +
> > +static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
> > +                                   size_t buffer_size, u64 head)
> > +{
> > +     u64 i, watermark;
> > +     u64 *buf = (u64 *)buffer;
> > +     size_t buf_size = buffer_size;
> > +
> > +     /*
> > +      * We want to look the very last 512 byte (chosen arbitrarily) in
> > +      * the ring buffer.
> > +      */
> > +     watermark = buf_size - 512;
> > +
> > +     /*
> > +      * @head is continuously increasing - if its value is equal or greater
> > +      * than the size of the ring buffer, it has wrapped around.
> > +      */
> > +     if (head >= buffer_size)
> > +             return true;
> > +
> > +     /*
> > +      * The value of @head is somewhere within the size of the ring buffer.
> > +      * This can be that there hasn't been enough data to fill the ring
> > +      * buffer yet or the trace time was so long that @head has numerically
> > +      * wrapped around.  To find we need to check if we have data at the very
> > +      * end of the ring buffer.  We can reliably do this because mmap'ed
> > +      * pages are zeroed out and there is a fresh mapping with every new
> > +      * session.
> > +      */
> > +
> > +     /* @head is less than 512 byte from the end of the ring buffer */
> > +     if (head > watermark)
> > +             watermark = head;
> > +
> > +     /*
> > +      * Speed things up by using 64 bit transactions (see "u64 *buf" above)
> > +      */
> > +     watermark >>= 3;
> > +     buf_size >>= 3;
> > +
> > +     /*
> > +      * If we find trace data at the end of the ring buffer, @head has
> > +      * been there and has numerically wrapped around at least once.
> > +      */
> > +     for (i = watermark; i < buf_size; i++)
> > +             if (buf[i])
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +
> > +static int cs_etm_find_snapshot(struct auxtrace_record *itr,
> >                               int idx, struct auxtrace_mmap *mm,
> > -                             unsigned char *data __maybe_unused,
> > +                             unsigned char *data,
> >                               u64 *head, u64 *old)
> >  {
> > +     int err;
> > +     bool wrapped;
> > +     struct cs_etm_recording *ptr =
> > +                     container_of(itr, struct cs_etm_recording, itr);
> > +
> > +     /*
> > +      * Allocate memory to keep track of wrapping if this is the first
> > +      * time we deal with this *mm.
> > +      */
> > +     if (idx >= ptr->wrapped_cnt) {
> > +             err = cs_etm_alloc_wrapped_array(ptr, idx);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     /*
> > +      * Check to see if *head has wrapped around.  If it hasn't only the
> > +      * amount of data between *head and *old is snapshot'ed to avoid
> > +      * bloating the perf.data file with zeros.  But as soon as *head has
> > +      * wrapped around the entire size of the AUX ring buffer it taken.
> > +      */
> > +     wrapped = ptr->wrapped[idx];
> > +     if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
> > +             wrapped = true;
> > +             ptr->wrapped[idx] = true;
> > +     }
> > +
> >       pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
> >                 __func__, idx, (size_t)*old, (size_t)*head, mm->len);
> >
> > -     *old = *head;
> > -     *head += mm->len;
> > +     /* No wrap has occurred, we can just use *head and *old. */
> > +     if (!wrapped)
> > +             return 0;
> > +
> > +     /*
> > +      * *head has wrapped around - adjust *head and *old to pickup the
> > +      * entire content of the AUX buffer.
> > +      */
> > +     if (*head >= mm->len) {
> > +             *old = *head - mm->len;
> > +     } else {
> > +             *head += mm->len;
> > +             *old = *head - mm->len;
> > +     }
> >
> >       return 0;
> >  }
> > @@ -586,6 +703,8 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
> >  {
> >       struct cs_etm_recording *ptr =
> >                       container_of(itr, struct cs_etm_recording, itr);
> > +
> > +     zfree(&ptr->wrapped);
> >       free(ptr);
> >  }
> >
> > --
> > 2.17.1
>
> --
>
> - Arnaldo
