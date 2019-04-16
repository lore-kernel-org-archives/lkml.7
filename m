Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8220821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfDPLaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:30:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34911 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDPLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:30:20 -0400
Received: by mail-io1-f67.google.com with SMTP id p16so17339344iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kncRXSaDmHAz0vEzoPgmtt9ZkL84kbgi+tbCTlVlZg=;
        b=ApQRI9fWUYRLLPs58NNTurTxHnFiW36N/Cu4OnwjpbGDyeg12RDrUw3v0fllz/7bnC
         PnXfPYJqe3NbsoErjUakamZIaNFKp49aeffYaWY0cUrdoxB5ojEnTZuR/yX8jHpPWpkp
         NLduZ4EPngI6MIG173MfhEzylFRkyZeb9gI6mQ2uhnt63Y8UovaBT4jpxA6p7rg/tpw7
         w8GUzhOWrSHPxbquzvZOA6mrutrhc9sgcsTKaoL78rAyM2rQea59fJAOBQ+mQTnsft4b
         kr9TtosQ9p/5M3KjX4UuwBILDPuy3ipsWxu2Dsxx4tP90YbTJ7Tr0WvkYB9uP+LYcyxN
         g4+Q==
X-Gm-Message-State: APjAAAVKkQZOmgkFp0cNCckIC85OVOjquYxWMCEfzieaecgBPL6jmLJt
        p5Jsi61Lei1Q+QJWkaPj8pS2Q9upkKhsGaqb7gIKTQ==
X-Google-Smtp-Source: APXvYqxd3Uwa1yI6uLSuvIcq9kBKgnvusjWCX2A01vpAJJPor/2NbCMGhCaBPPW6B20RtItNF7YZ42poPqL+Ylo9MKE=
X-Received: by 2002:a6b:7218:: with SMTP id n24mr13899663ioc.112.1555414219274;
 Tue, 16 Apr 2019 04:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190408165942.23640-1-kasong@redhat.com> <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
In-Reply-To: <20190415165859.ul7i2w3lai3umgik@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 16 Apr 2019 19:30:07 +0800
Message-ID: <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Apr 15, 2019 at 05:36:22PM +0200, Peter Zijlstra wrote:
> >
> > I'll mostly defer to Josh on unwinding, but a few comments below.
> >
> > On Tue, Apr 09, 2019 at 12:59:42AM +0800, Kairui Song wrote:
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index e2b1447192a8..6075a4f94376 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -2355,6 +2355,12 @@ void arch_perf_update_userpage(struct perf_event *event,
> > >     cyc2ns_read_end();
> > >  }
> > >
> > > +static inline int
> > > +valid_perf_registers(struct pt_regs *regs)
> > > +{
> > > +   return (regs->ip && regs->bp && regs->sp);
> > > +}
> >
> > I'm unconvinced by this, with both guess and orc having !bp is perfectly
> > valid.
> >
> > >  void
> > >  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> > >  {
> > > @@ -2366,11 +2372,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> > >             return;
> > >     }
> > >
> > > -   if (perf_callchain_store(entry, regs->ip))
> > > +   if (valid_perf_registers(regs)) {
> > > +           if (perf_callchain_store(entry, regs->ip))
> > > +                   return;
> > > +           unwind_start(&state, current, regs, NULL);
> > > +   } else if (regs->sp) {
> > > +           unwind_start(&state, current, NULL, (unsigned long *)regs->sp);
> > > +   } else {
> > >             return;
> > > +   }
> >
> > AFAICT if we, by pure accident, end up with !bp for ORC, then we
> > initialize the unwind wrong.
> >
> > Note that @regs is mostly trivially correct, except for that tracepoint
> > case. So I don't think we should magic here.
>
> Ah, I didn't quite understand this code before, and I still don't
> really, but I guess the issue is that @regs can be either real or fake.
>
> In the real @regs case, we just want to always unwind starting from
> regs->sp.
>
> But in the fake @regs case, we should instead unwind from the current
> frame, skipping all frames until we hit the fake regs->sp.  Because
> starting from fake/incomplete regs is most likely going to cause
> problems with ORC (or DWARF for other arches).
>
> The idea of a fake regs is fragile and confusing.  Is it possible to
> just pass in the "skip" stack pointer directly instead?  That should
> work for both FP and non-FP.  And I _think_ there's no need to ever
> capture regs->bp anyway -- the stack pointer should be sufficient.

Hi, that will break some other usage, if perf_callchain_kernel is
called but it won't unwind to the callsite (could be produced by
attach an ebpf call to kprobe), things will also go wrong. It should
start with given registers when the register is valid.
And it's true with omit frame pointer BP value could be anything, so 0
is also valid, I think I need to find a better way to tell if we could
start with the registers value or direct start unwinding and skip
until got the stack.

>
> In other words, either regs should be "real", and skip_sp is NULL; or
> regs should be NULL and skip_sp should have a value.
>
> --
> Josh
--
Best Regards,
Kairui Song
