Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64537C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E712186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lA4EjBRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCOTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:55:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44104 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfCOTzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:55:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id b8so6097779vsq.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rt2exJeHKsxBOhIl4TlnP9BjaHDauY09fiofqEAP2wk=;
        b=lA4EjBRhxSdQ5qRJIZseRaXKxvmdtX/b270WBihvXBgTQlo+aen7XoQKL+9P7xnG3W
         3+gz/QXIyq0njoEpj5yEve0SZdJ2CVWdf1evwC3K3zjdk7AVPjs/JAyUttD8ISYIuAzt
         ybYlSuwr4RO9b459vHF9ij3BPU2IdUljVnq/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rt2exJeHKsxBOhIl4TlnP9BjaHDauY09fiofqEAP2wk=;
        b=OLQ0M5p7yhXSlAcO9zjNzHgpmI73Z+9CuiWbY5TEXFd8deQ/u1QKGR32U/nLevOMXR
         aELh4WxTOqT9v9EFiz62DN0VngqeBXA8/HxoWH7+Cg7yxNS5DcdCtt8HbPYcWHm9xOti
         mbtaEoQ4fuBnpnpAene5tTvNjHi3iwvOrxxvRoB+SLT7CBwxyyEDxQlFF7RnsTAKcZbB
         c3IY7E5WuwmfgoSsN09v0LKtJ6lj4nKVIlLrIpOlLnlcUg8wjCJrmI7S8qKyMV/jdFwh
         lIdkB5FE1ROQZwAHtnfSw9SnoAQYEcy1mhYjf30POrAvj9OQCwDPodD4msKK1O14O6QT
         2JUg==
X-Gm-Message-State: APjAAAUsdRsIMu68TL36+zehn7yx31ZmdmvIjEatptOPjILwcqCTKwWV
        7FHNiogO08hDvjcpmUxyXpivIRUN76Q=
X-Google-Smtp-Source: APXvYqzhyfOamlc9/8nqejCNZiqQN6DnPJEL0YmXPFxC6PmYD59lkzeU0sagaBuIa/JXot/DvsHqWg==
X-Received: by 2002:a67:df07:: with SMTP id s7mr2945688vsk.157.1552679744017;
        Fri, 15 Mar 2019 12:55:44 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id j4sm2570124vke.0.2019.03.15.12.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 12:55:42 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id e126so5888773vse.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:55:42 -0700 (PDT)
X-Received: by 2002:a67:d48e:: with SMTP id g14mr3162883vsj.111.1552679742263;
 Fri, 15 Mar 2019 12:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190315174528.16531-1-dianders@chromium.org> <20190315144130.1aa36931@gandalf.local.home>
In-Reply-To: <20190315144130.1aa36931@gandalf.local.home>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 12:55:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
Message-ID: <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: kdb: Allow ftdump to skip all but the last
 few lines
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 11:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Mar 2019 10:45:28 -0700
> Douglas Anderson <dianders@chromium.org> wrote:
>
>
> > Changes in v3:
> > - Optimize counting as per Steven Rostedt.
> > - Down to 1 patch since patch #1 from v2 landed.
> >
> >  kernel/trace/trace_kdb.c | 38 +++++++++++++++++++++++++++++---------
> >  1 file changed, 29 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > index 810d78a8d14c..cc6ca6c0d6de 100644
> > --- a/kernel/trace/trace_kdb.c
> > +++ b/kernel/trace/trace_kdb.c
> > @@ -17,7 +17,7 @@
> >  #include "trace.h"
> >  #include "trace_output.h"
> >
> > -static void ftrace_dump_buf(int skip_lines, long cpu_file)
> > +static int ftrace_dump_buf(int skip_lines, long cpu_file, bool quiet)
>
> Not quite what I wanted you to do.
>
>
> >  {
> >       /* use static because iter can be a bit big for the stack */
> >       static struct trace_iterator iter;
> > @@ -39,8 +39,6 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >       /* don't look at user memory in panic mode */
> >       tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
> >
> > -     kdb_printf("Dumping ftrace buffer:\n");
> > -
> >       /* reset all but tr, trace, and overruns */
> >       memset(&iter.seq, 0,
> >                  sizeof(struct trace_iterator) -
> > @@ -55,6 +53,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >                                                cpu, GFP_ATOMIC);
> >                       ring_buffer_read_start(iter.buffer_iter[cpu]);
> >                       tracing_iter_reset(&iter, cpu);
> > +
> > +                     cnt +=
> > +                     ring_buffer_entries_cpu(iter.trace_buffer->buffer, cpu);
>
> BTW, 80 char limit is a guideline not a rule. Don't break a line to
> make it look worse. But that doesn't matter because this isn't the
> change I meant.

Yeah, I didn't like the look of it either but decided to match the
style of the function, which uses nearly the same solution for word
wrapping a few lines above.  :-)  I'm happy to just break 80
characters though...


> >               }
> >       } else {
> >               iter.cpu_file = cpu_file;
> > @@ -63,13 +64,21 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >                                                cpu_file, GFP_ATOMIC);
> >               ring_buffer_read_start(iter.buffer_iter[cpu_file]);
> >               tracing_iter_reset(&iter, cpu_file);
> > +
> > +             cnt += ring_buffer_entries_cpu(iter.trace_buffer->buffer,
> > +                                            cpu_file);
> >       }
> >
> > -     while (trace_find_next_entry_inc(&iter)) {
> > -             if (!cnt)
> > -                     kdb_printf("---------------------------------\n");
> > -             cnt++;
> > +     if (quiet)
> > +             goto out;
> > +
> > +     kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
> > +                skip_lines);
> > +
> > +     if (cnt)
> > +             kdb_printf("---------------------------------\n");
> >
> > +     while (trace_find_next_entry_inc(&iter)) {
> >               if (!skip_lines) {
> >                       print_trace_line(&iter);
> >                       trace_printk_seq(&iter.seq);
> > @@ -99,6 +108,8 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >                       iter.buffer_iter[cpu] = NULL;
> >               }
> >       }
> > +
> > +     return cnt;
> >  }
> >
> >  /*
> > @@ -109,6 +120,7 @@ static int kdb_ftdump(int argc, const char **argv)
> >       int skip_lines = 0;
> >       long cpu_file;
> >       char *cp;
> > +     int cnt;
> >
> >       if (argc > 2)
> >               return KDB_ARGCOUNT;
> > @@ -129,7 +141,14 @@ static int kdb_ftdump(int argc, const char **argv)
> >       }
> >
> >       kdb_trap_printk++;
> > -     ftrace_dump_buf(skip_lines, cpu_file);
> > +
> > +     /* A negative skip_lines means skip all but the last lines */
> > +     if (skip_lines < 0) {
> > +             cnt = ftrace_dump_buf(0, cpu_file, true);
>
> Actually, you can add a function in trace.c that exposes
> get_total_entries:
>
> unsigned long trace_total_entries(struct trace_array *tr)
> {
>         unsigned long total, entries;
>
>         if (!tr)
>                 tr = &global_trace;
>
>         get_total_entries(tr->trace_buffer, &total, &entries);
>
>         return entries;
> }
>
> and then do:
>                 cnt = trace_total_entries(NULL);

OK.  I guess I'll need to figure out how to add an argument to limit
it to just one CPU too since the kdb command allows you to specify a
single CPU or all CPUs.  I think the best way would mean adding an
argument to get_total_entries().  ...or I can just change the kdb
command to not allow specifying a CPU?  Which do you prefer?  I
personally haven't ever used the feature to just print the ftrace
buffer for a certain CPU so I'd be OK removing it.


> Don't modify ftrace_dump_buf()

I still kinda prefer modifying ftrace_dump_buf() just because it's
pretty important that the "count" we come up with match pretty exactly
the count that ftrace_dump_buf() will come up with.  My worry probably
comes from my lack of experience with the internals of ftrace but, for
instance, I see things like "tr->trace_flags &=
~TRACE_ITER_SYM_USEROBJ" in ftrace_dump_buf() and I worry that it will
affect the count.  ...but if you tell me that I need not worry about
things like that then I won't.  :-)


Thanks for your help!

-Doug
