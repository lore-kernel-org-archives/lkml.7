Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A57218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HdFdQOvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCOV2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:28:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44235 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:28:54 -0400
Received: by mail-vs1-f65.google.com with SMTP id b8so6239494vsq.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXewwpor+TNa5aCZoKeGBIaPftJEhqX6TirFfZPNiH4=;
        b=HdFdQOvW13ownyKXwnH4pLz1GnXn/pChZDpK6gmJYjwoRhevcBvnCkQDi3b/J74Vbi
         EDWOMXVD6hR4XdM9awzi3h/xoDKKUVmI+Fo6WN08p19ItEJq14Sj+rD+BsunEJLondPN
         9TKyPI08O/aT08aCMwkDUfAQvSgzXSIOBKKdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXewwpor+TNa5aCZoKeGBIaPftJEhqX6TirFfZPNiH4=;
        b=g5BH1N/9j4QfGtfwQMNiVujOVjf+W4wdRCvw/MelCJ2iwSnCqaE1rHuCmkyPYwLWcg
         qus7Ra7BY2vUNr8mWJeaqb3zXIsa+19enMSSIKbSus5VxSGXN4hSkqdZuAzgCisZ7uFy
         LHTvMxOq+9eIJiBRrDLIuOr+275vbowjZUDDiOVr+LS1ULo3CXp1L+RtnC7Eyi9VK259
         cGo6Qx3X5KUqXn/gjPcwr9Wa7fqrREo5ENBq8g+ySDTt04aSV15gJm9rmTyM0taiBvzC
         k6xzTozY3SdUcCRwZyI/Kcjdm+0Sk21RF6Q5TxmNTCtTfYDWgw+4W4ME56YM1uv3mv8N
         SrZg==
X-Gm-Message-State: APjAAAXDDQA8/MM/XpvylP0pLZBwCbESvOoVLPIodmQHUHy140ygGrgF
        dtMdLag5luIRGiRWIvcXL01ZUxrtDPs=
X-Google-Smtp-Source: APXvYqwnTwMAYkqjbx9GguHNXg9IiXHnVH/TB1T6PMe2SggfTsCcZaU8MyqLwxV8TU0+nKMVlOVlJg==
X-Received: by 2002:a67:eb84:: with SMTP id e4mr3177674vso.7.1552685332689;
        Fri, 15 Mar 2019 14:28:52 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id h14sm970867vsd.3.2019.03.15.14.28.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 14:28:51 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id n14so6225864vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:28:51 -0700 (PDT)
X-Received: by 2002:a67:ed04:: with SMTP id l4mr3086761vsp.20.1552685331334;
 Fri, 15 Mar 2019 14:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190315174528.16531-1-dianders@chromium.org> <20190315144130.1aa36931@gandalf.local.home>
 <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
 <20190315161203.25dc2a0c@gandalf.local.home> <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
 <20190315170822.6316f3cb@gandalf.local.home>
In-Reply-To: <20190315170822.6316f3cb@gandalf.local.home>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 14:28:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHybx9ACyWePjxyqUiH7ixokPEoJYf43BvojT1U1ZB=g@mail.gmail.com>
Message-ID: <CAD=FV=UHybx9ACyWePjxyqUiH7ixokPEoJYf43BvojT1U1ZB=g@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 2:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > The get_total_entries() is the faster approach to get the count, but in
> > > either case, the count should end up the same.
> >
> > If you're OK with going back to the super slow mechanism in v1 I can
> > do that and we can be guaranteed we're consistent.  Presumably it
> > can't be _that_ slow because we're going to use the same mechanism to
> > skip the lines later.
> >
> > So, if you agree, I'll send out a v4 that looks like v1 except that it
> > disables / enables tracing directly in kdb_ftdump() so it stays
> > disabled for both calls.
> >
> >
> > [1] https://lkml.kernel.org/r/20190305233150.159633-1-dianders@chromium.org
> >
>
> But this part of the patch:
>
> > -static void ftrace_dump_buf(int skip_lines, long cpu_file)
> > +static int ftrace_dump_buf(int skip_lines, long cpu_file, bool quiet)
> >  {
> >       /* use static because iter can be a bit big for the stack */
> >       static struct trace_iterator iter;
> > @@ -39,7 +39,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >       /* don't look at user memory in panic mode */
> >       tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
> >
> > -     kdb_printf("Dumping ftrace buffer:\n");
> > +     if (!quiet)
> > +             kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
> > +                        skip_lines);
> >
> >       /* reset all but tr, trace, and overruns */
> >       memset(&iter.seq, 0,
> > @@ -66,25 +68,29 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
> >       }
> >
> >       while (trace_find_next_entry_inc(&iter)) {
> > -             if (!cnt)
> > -                     kdb_printf("---------------------------------\n");
> > -             cnt++;
> > -
> > -             if (!skip_lines) {
> > -                     print_trace_line(&iter);
> > -                     trace_printk_seq(&iter.seq);
> > -             } else {
> > -                     skip_lines--;
> > +             if (!quiet) {
> > +                     if (!cnt)
> > +                             kdb_printf("---------------------------------\n");
> > +
> > +                     if (!skip_lines) {
> > +                             print_trace_line(&iter);
> > +                             trace_printk_seq(&iter.seq);
> > +                     } else {
> > +                             skip_lines--;
>
> How do you know that trace_printk_seq() didn't produce more than one line?
>
> If the event is a stack dump, you need to read the seq, and count the
> number of '\n' that are added.
>
> The cnt in this code is no different than the get_total_entries() that
> I suggested.

I had a little bit of a hard time figuring out if print_trace_line()
plus trace_printk_seq() always printed one line or always printed one
entry.  I guess the point I was making was that in v1 of my patch it
wouldn't matter because the pseudo code looked like:

1. Count how many "things" would be printed, but don't printed them.

2. Use math to figure out how many "things" to skip given that we want
to print the last N "things".

3. Skip the "things" the math told us to and then print the last N "things".

...but it sounds like it _must_ print one entry because we're looping
over trace_find_next_entry_inc().  That means that the existing "skip
lines" that predates my patch should actually be "skip entries".  I'd
be happy adjusting the help text (and local variable name) so that
"skip_lines" is instead "skip_entries".  I think that would avoid
confusion everywhere.  It doesn't change behavior but just documents
the existing behavior.


With that I can use your optimized path assuming you can confirm that
"tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ" doesn't affect how many
entries will be iterated over by trace_find_next_entry_inc().

-Doug
