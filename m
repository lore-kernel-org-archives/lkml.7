Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00392173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F8K4J6ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCSOpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:45:55 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38866 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:45:55 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so6547805uap.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkIUslYOQ11EGhiFvtaB0L6PyS4FFkyPHlpF2YOJkzc=;
        b=F8K4J6phY+chGmbKPTOvZo45yIvc71j0JqzCWTXYAquKjXaCwIiJOs+Mhb0l7WNoTJ
         KymHYHdP3/4IADDK2jp8zBg8ELrDoYoQYdxK3PFDFn06PAo0SlRi1oJnL8EsWHV0VMiU
         aVD5Qf1EQqhpUWe1ytrLJfxWuKRjJxfgTj2Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkIUslYOQ11EGhiFvtaB0L6PyS4FFkyPHlpF2YOJkzc=;
        b=n0KiSx5cA4Cf98Vo0P7OYzSvOtrIw4R9bhVlycJEJKb31ZsGGX/orsxr4W1yjJo+Ly
         hAkrzwiDsQIrUH72+Xvk0SHeCxJngGWBODAqKSRBa8ZSUo+y0x+zLbocYBdlwR9X/ya5
         Ty8uiNrjNGU66U/c5lXyw4B84ZRh4X6S8PG89K0ozj97gzbRdVtmuIxWXeb7jey7GjSc
         /L6nBf+BIQtkJ5JZvR+8KBWB3KKj6ONaTvPcPGDbqxFAUuUhaynLiapaisI8C7iBlQkj
         u6FU6e9hUI8x4TlLjilJl4twqq65xm/o2lLZgOP3G5NKBNRGdA0FOIX+HL1Giw6pqc3d
         x72A==
X-Gm-Message-State: APjAAAVIhxF6XjntcJTzDlBRt5RR6jZ9lSGjiCV0RytmWJB0u4zy7VJX
        DRPzBNx6wDxrYIQYhB4+KIiuiGZuJjU=
X-Google-Smtp-Source: APXvYqz4/NIsks7z5Zjp1LvamvsVn/jx6QpLHtTv31f5fg6veOgrmZicvEUXXXNI30JJutqFgjUrpQ==
X-Received: by 2002:ab0:28d6:: with SMTP id g22mr1396460uaq.75.1553006753434;
        Tue, 19 Mar 2019 07:45:53 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id c124sm2494450vsd.3.2019.03.19.07.45.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:45:51 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id c13so4488452uao.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:45:50 -0700 (PDT)
X-Received: by 2002:ab0:3445:: with SMTP id a5mr1419745uaq.130.1553006750663;
 Tue, 19 Mar 2019 07:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190318204741.116550-1-dianders@chromium.org>
 <20190318204741.116550-2-dianders@chromium.org> <20190319112537.5yi7gelkk4ixswmu@holly.lan>
In-Reply-To: <20190319112537.5yi7gelkk4ixswmu@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Mar 2019 07:45:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJNED79Oc3ge3_JXZdJcADm_B9N-asymGrwZvKew2Wzw@mail.gmail.com>
Message-ID: <CAD=FV=UJNED79Oc3ge3_JXZdJcADm_B9N-asymGrwZvKew2Wzw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] tracing: Add trace_total_entries() / trace_total_entries_cpu()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 19, 2019 at 4:25 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Mar 18, 2019 at 01:47:40PM -0700, Douglas Anderson wrote:
> > These two new exported functions will be used in a future patch by
> > kdb_ftdump() to quickly skip all but the last few trace entries.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v5: None
> > Changes in v4:
> > - trace_total_entries() / trace_total_entries_cpu() new for v4
> >
> > Changes in v3: None
> >
> >  kernel/trace/trace.c | 65 ++++++++++++++++++++++++++++++++++----------
> >  kernel/trace/trace.h |  3 ++
> >  2 files changed, 53 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index ccd759eaad79..7afc90f82e53 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -3490,34 +3490,69 @@ static void s_stop(struct seq_file *m, void *p)
> >       trace_event_read_unlock();
> >  }
> >
> > +static void
> > +get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
> > +                   unsigned long *entries, int cpu)
> > +{
> > +     unsigned long count;
> > +
> > +     count = ring_buffer_entries_cpu(buf->buffer, cpu);
> > +     /*
> > +      * If this buffer has skipped entries, then we hold all
> > +      * entries for the trace and we need to ignore the
> > +      * ones before the time stamp.
> > +      */
> > +     if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
> > +             count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
> > +             /* total is the same as the entries */
> > +             *total = count;
> > +     } else
> > +             *total = count +
> > +                     ring_buffer_overrun_cpu(buf->buffer, cpu);
> > +     *entries = count;
> > +}
> > +
> >  static void
> >  get_total_entries(struct trace_buffer *buf,
> >                 unsigned long *total, unsigned long *entries)
> >  {
> > -     unsigned long count;
> > +     unsigned long t, e;
> >       int cpu;
> >
> >       *total = 0;
> >       *entries = 0;
> >
> >       for_each_tracing_cpu(cpu) {
> > -             count = ring_buffer_entries_cpu(buf->buffer, cpu);
> > -             /*
> > -              * If this buffer has skipped entries, then we hold all
> > -              * entries for the trace and we need to ignore the
> > -              * ones before the time stamp.
> > -              */
> > -             if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
> > -                     count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
> > -                     /* total is the same as the entries */
> > -                     *total += count;
> > -             } else
> > -                     *total += count +
> > -                             ring_buffer_overrun_cpu(buf->buffer, cpu);
> > -             *entries += count;
> > +             get_total_entries_cpu(buf, &t, &e, cpu);
> > +             *total += t;
> > +             *entries += e;
> >       }
> >  }
> >
> > +unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
> > +{
> > +     unsigned long total, entries;
> > +
> > +     if (!tr)
> > +             tr = &global_trace;
>
> This function is only ever called with tr set to NULL which means tr is
> an argument looking for a user.
>
> I wouldn't mind except if this was following copying prior art to keep
> the API feel the same but I can't find any other trace function where
> the trace_array can be substituted for NULL. AFAICT all the existing
> sites where global_trace is used will use it unconditionally.

Happy to change this if you guys want.  At the moment the
trace_total_entries() comes straight from Steven's suggestion at:

https://lkml.kernel.org/r/20190315144130.1aa36931@gandalf.local.home

Ugh, but while looking at this it looks like I totally forgot one
piece of feedback from Steven: to move the disabling of the tracing
out so it's not re-enabled after counting but before dumping.  Not
sure how I missed that.  :(

I'll wait to spin until I hear from Steven if he wants me to remove
the "struct trace_array *tr" argument, then I'll post out a v6 with
the fix I forgot...


-Doug
