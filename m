Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950312087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8rWEmIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfDPQQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:16:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39977 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:16:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so10645330pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKe2ycREilj9tfPYoXzW7gTBCUBKFGtqznaVigWaJlE=;
        b=k8rWEmIuHTsiRuEjSErSov1sgVwSlfO+TBL6QvMWwlP3fBa2gEkmvG448MOcwN5EST
         TUZv1JzITqWhpjCFCakeYKGGrfbo7TA0sIQSOlj3WvyfDu23QITXimwYxCsV6AAsm6ge
         DB8pp2Q7yocDR5x8sFl5c3BuClKeFr8u8s1N6y57lCAn6lp6zd8oePmDfC1Vz6GXPPtn
         eOPbxOWQ/cGUY6HO4q7P6iEe4zD1Zt2zLOPSd63QEDqkZFn1bConVqhFC2t4CeWpy3vJ
         QNO2mkcyLgs+MC7+TloIyWfUTnU5ZabB3g1XI3j8rICSxEur91aL7rVY7L/TvK6z/eHA
         LRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKe2ycREilj9tfPYoXzW7gTBCUBKFGtqznaVigWaJlE=;
        b=srxxtKfNolFdYBnev/waV2znt3uOLJzij3f266zbjKksO/5lZwgYgWl6656El+jOMC
         fQIbp2xtdpa/JK/WWYiUGd1c94SaeetIKC2EcbJsUirDF7ZXugjYpSPcxI8L9df1aaIq
         r+LrlCcr062OS1HQicCzG7/j59cGMug+8fVunbVINhXzGosAhi61b0ySflQ9s+4n+lzV
         W3JMPQI1pgqiqZ5OXeJonc/LUUqgnT9kL98KyXEdheSLO6cxznu1EwgRw6c5ek2AYOIf
         cF82DSZRbvNZtOtpEjIjuKXghHQPsgStPE1uQbMcNd7ayG/ChWYau9cIZB/UaSeLyp7Z
         a9kA==
X-Gm-Message-State: APjAAAWVCq/cfQeg6UA26v/S7/PQ5MwHCSuCjoy84fmV3sxXCm3XAy6I
        zTPMiaO3biz5641S39G/ubI=
X-Google-Smtp-Source: APXvYqxU0C1ZDa+VKiXqjglgvttNG03GkEuzBcD7HJDjZ0O+X6CjZgbPyOiVFscxaZdTm/2TN2mknw==
X-Received: by 2002:aa7:820c:: with SMTP id k12mr82777918pfi.177.1555431377103;
        Tue, 16 Apr 2019 09:16:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:601e])
        by smtp.gmail.com with ESMTPSA id z14sm79273847pfn.161.2019.04.16.09.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:16:16 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:16:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        guro@fb.com, yhs@fb.com, brendan.d.gregg@gmail.com
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190416161612.zgavfk4teqmumk5n@ast-mbp.dhcp.thefacebook.com>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
 <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 07:30:07PM +0800, Kairui Song wrote:
> On Tue, Apr 16, 2019 at 12:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Apr 15, 2019 at 05:36:22PM +0200, Peter Zijlstra wrote:
> > >
> > > I'll mostly defer to Josh on unwinding, but a few comments below.
> > >
> > > On Tue, Apr 09, 2019 at 12:59:42AM +0800, Kairui Song wrote:
> > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > index e2b1447192a8..6075a4f94376 100644
> > > > --- a/arch/x86/events/core.c
> > > > +++ b/arch/x86/events/core.c
> > > > @@ -2355,6 +2355,12 @@ void arch_perf_update_userpage(struct perf_event *event,
> > > >     cyc2ns_read_end();
> > > >  }
> > > >
> > > > +static inline int
> > > > +valid_perf_registers(struct pt_regs *regs)
> > > > +{
> > > > +   return (regs->ip && regs->bp && regs->sp);
> > > > +}
> > >
> > > I'm unconvinced by this, with both guess and orc having !bp is perfectly
> > > valid.
> > >
> > > >  void
> > > >  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> > > >  {
> > > > @@ -2366,11 +2372,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> > > >             return;
> > > >     }
> > > >
> > > > -   if (perf_callchain_store(entry, regs->ip))
> > > > +   if (valid_perf_registers(regs)) {
> > > > +           if (perf_callchain_store(entry, regs->ip))
> > > > +                   return;
> > > > +           unwind_start(&state, current, regs, NULL);
> > > > +   } else if (regs->sp) {
> > > > +           unwind_start(&state, current, NULL, (unsigned long *)regs->sp);
> > > > +   } else {
> > > >             return;
> > > > +   }
> > >
> > > AFAICT if we, by pure accident, end up with !bp for ORC, then we
> > > initialize the unwind wrong.
> > >
> > > Note that @regs is mostly trivially correct, except for that tracepoint
> > > case. So I don't think we should magic here.
> >
> > Ah, I didn't quite understand this code before, and I still don't
> > really, but I guess the issue is that @regs can be either real or fake.
> >
> > In the real @regs case, we just want to always unwind starting from
> > regs->sp.
> >
> > But in the fake @regs case, we should instead unwind from the current
> > frame, skipping all frames until we hit the fake regs->sp.  Because
> > starting from fake/incomplete regs is most likely going to cause
> > problems with ORC (or DWARF for other arches).
> >
> > The idea of a fake regs is fragile and confusing.  Is it possible to
> > just pass in the "skip" stack pointer directly instead?  That should
> > work for both FP and non-FP.  And I _think_ there's no need to ever
> > capture regs->bp anyway -- the stack pointer should be sufficient.
> 
> Hi, that will break some other usage, if perf_callchain_kernel is
> called but it won't unwind to the callsite (could be produced by
> attach an ebpf call to kprobe), things will also go wrong. It should
> start with given registers when the register is valid.
> And it's true with omit frame pointer BP value could be anything, so 0
> is also valid, I think I need to find a better way to tell if we could
> start with the registers value or direct start unwinding and skip
> until got the stack.

Hey, what is the status of the fix?
We're hitting it from bpf as well.
kernel stack traces are not working in tracepoints.

