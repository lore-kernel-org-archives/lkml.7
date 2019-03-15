Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B429C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF1218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gh7ioiER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCOUy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:54:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37885 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfCOUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:54:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id w13so176765vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaDgNqwrMtkd1jZdYBYWdnJcXl5sG/sCtLVTTyqj4TY=;
        b=Gh7ioiERruWDR6RwylEqZnL6aH1UZsmQ05tDgJI6vgflJcasruflnYtDk4lOZM6wXN
         +VQtT9vPFXvy+LzfS5pxqQ3zRKbbRCb40t2tHvcCw+hFTsNOLg0u62DZfXb6XA751rVY
         iv4TzgzmrXH5YUGJvSc4qcLb2X98B2yp4ucvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaDgNqwrMtkd1jZdYBYWdnJcXl5sG/sCtLVTTyqj4TY=;
        b=CK76SwT0aH6vZ94+7snIwpKQVb5LHNvYynexWGIdjfGojzZGLv8yX3CC3YMuweELtH
         gAViuGZXAKTrnEsd1cDEnJ0VkyLn+8Yf/ElI9nXazgMwa6Gjxk+GBecLx4kcnp+akU7N
         bN3NcxJ+9hdZo3fT8Fxpg1f1zTAK3sCNMgfkwygiI4FEsxyxXS+ov+M+as8tUCx4jOZW
         mm4dOzFa2Yu9p/gaYCLgn2gXHCD04bhmYdI1fOR/j8UuiyRT+A6Zz/gx8nR+k9OjGWnJ
         KGHu8eW3i+Jc3LJjbTSDqVLwhVBQTikkPsaJv5n8Z7kq+BSYXeFRb7ked9VU62XdRbI4
         5Q4A==
X-Gm-Message-State: APjAAAXqFqtHt4Y4ovWsFyZbTqoErPTiPrbGAzrDL2pq1wKqC2JX0343
        DsxqQmeyLYzymCJ5S5W0jTMVDTYmqhw=
X-Google-Smtp-Source: APXvYqw4lxOXwDWUwy0D4Zde7ESWVNGI/kI4avNFKKINPG09yUXvDIF21l7lQllPC92kyFO0O3JIDQ==
X-Received: by 2002:a67:ecc2:: with SMTP id i2mr3100489vsp.12.1552683264676;
        Fri, 15 Mar 2019 13:54:24 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id z9sm877852vkd.22.2019.03.15.13.54.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:54:23 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id z25so4890806vsk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:54:23 -0700 (PDT)
X-Received: by 2002:a67:b60c:: with SMTP id d12mr1947437vsm.149.1552683262678;
 Fri, 15 Mar 2019 13:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190315174528.16531-1-dianders@chromium.org> <20190315144130.1aa36931@gandalf.local.home>
 <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com> <20190315161203.25dc2a0c@gandalf.local.home>
In-Reply-To: <20190315161203.25dc2a0c@gandalf.local.home>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 13:54:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
Message-ID: <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 1:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Mar 2019 12:55:31 -0700
> Doug Anderson <dianders@chromium.org> wrote:
>
> > >
> > > Actually, you can add a function in trace.c that exposes
> > > get_total_entries:
> > >
> > > unsigned long trace_total_entries(struct trace_array *tr)
> > > {
> > >         unsigned long total, entries;
> > >
> > >         if (!tr)
> > >                 tr = &global_trace;
> > >
> > >         get_total_entries(tr->trace_buffer, &total, &entries);
> > >
> > >         return entries;
> > > }
> > >
> > > and then do:
> > >                 cnt = trace_total_entries(NULL);
> >
> > OK.  I guess I'll need to figure out how to add an argument to limit
> > it to just one CPU too since the kdb command allows you to specify a
> > single CPU or all CPUs.  I think the best way would mean adding an
> > argument to get_total_entries().  ...or I can just change the kdb
> > command to not allow specifying a CPU?  Which do you prefer?  I
> > personally haven't ever used the feature to just print the ftrace
> > buffer for a certain CPU so I'd be OK removing it.
>
> I would make a get_total_entries_cpu() that contains the guts of
> get_total_entries() which then calls get_total_entries_cpu()
>
> static void
> get_total_entries(struct trace_buffer *buf,
>                   unsigned long *total, unsigned long *entries)
> {
>         unsigned long t, e;
>         int cpu;
>
>         *total = 0;
>         *entries = 0;
>
>         for_each_tracing_cpu(cpu)
>                 get_total_entries_cpu(buf, &t, &e, cpu);
>                 *total += t;
>                 *entries += e;
>         }
> }
>
> >
> >
> > > Don't modify ftrace_dump_buf()
> >
> > I still kinda prefer modifying ftrace_dump_buf() just because it's
> > pretty important that the "count" we come up with match pretty exactly
> > the count that ftrace_dump_buf() will come up with.  My worry probably
> > comes from my lack of experience with the internals of ftrace but, for
> > instance, I see things like "tr->trace_flags &=
> > ~TRACE_ITER_SYM_USEROBJ" in ftrace_dump_buf() and I worry that it will
> > affect the count.  ...but if you tell me that I need not worry about
> > things like that then I won't.  :-)
>
> Hmm, actually your method still wont work, because you are only
> counting entries not lines. The stack dumps are considered a single
> line but will print multiple lines.

LOL.  Back to v1 then?  v1 of the patch [1] was definitely consistent
even if it was very slow.  Specifically whatever was being counted by
ftrace_dump_buf() (entries or lines or something in between) was
definitely used to figure out how many to skip.


> Not only that, perhaps you should break apart ftrace_dump_buf(),
> because calling it twice (or doing what I suggested), wont stop tracing
> in between, and the size of the buffer might change between the two
> calls.
>
> You need to move out:
>
>         for_each_tracing_cpu(cpu) {
>                 atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
>         }
>
>
> and
>
>         for_each_tracing_cpu(cpu) {
>                 atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
>         }
>
> to disable tracing while you do this.

Happy to do this in a v4.  I think it's very unlikely to matter
because we're in kdb and thus all the other CPUs are stopped and
interrupts are disabled.  ...so unless an NMI adds something to the
trace buffer in between the two calls the counts will be the same.
...but it certainly is cleaner.


> The get_total_entries() is the faster approach to get the count, but in
> either case, the count should end up the same.

If you're OK with going back to the super slow mechanism in v1 I can
do that and we can be guaranteed we're consistent.  Presumably it
can't be _that_ slow because we're going to use the same mechanism to
skip the lines later.

So, if you agree, I'll send out a v4 that looks like v1 except that it
disables / enables tracing directly in kdb_ftdump() so it stays
disabled for both calls.


[1] https://lkml.kernel.org/r/20190305233150.159633-1-dianders@chromium.org

-Doug
