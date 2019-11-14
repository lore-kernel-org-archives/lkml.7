Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C34AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F530206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbPLF85m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNSeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:34:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34109 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKNSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:34:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id y186so5901375lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL+6TKbWs0kFvX42H+BmmW43OUv1OEqioKINoEDhBTI=;
        b=hbPLF85mLt+6GGeHsbb2Mr2LC65NwsQb8hbXV/C6UnJ5aElWFGfnKF5PpNJMRkDqGw
         //sdrpv2yZq9dQt3TK+AGNNtE1sMBFWNid/qxybW9VnvU5tPY0BJ1zdMeRW5ef91SJHo
         dwMZIULPgge2NQjGuC6V8MT3/UNFnE+Zk94LFetn9aZoJLVUxO7I7/zj+cX+Y24ZKZuM
         i0CZA/+X6FBbjSJdB/NFFQMWOSNr1wX7pHi4pMYvrc2W3Z5ElvAKwzjCwCpW9Ea3sOsH
         fK++r1TqTh07K/FL+4fGep+Qrm2GOTEu53dZLETX0batnw008yaiozf9e+x/ZqKeQs6K
         1KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL+6TKbWs0kFvX42H+BmmW43OUv1OEqioKINoEDhBTI=;
        b=FjGzGnzE8K+LrpBr7YudDGOzeTVFy4/aEOlNDJIL+AaBorDL4KmuNhfiO90kl2ubuh
         bK0iXE48WJAm7CLpRzZqwpxWFAiiiiO6K9OA2JYhYX81rvZ8/MAtKB1r8bec3KUgDrtu
         1a+e8PYxVf+FQdUqQvQsiLt7QnM6Ds1sgp2niUoXmg4SjbrC41NrbklGeIDgcoSswrRL
         8eoLva2vzpkEG7YDqw6RcvIcgGjmsXurtlCixMsidKeDfR0m+KpG9tXamZjNtFgsjQhL
         oBnEtXAeJiEZPWqnV5GdOov+pPK10+hEaz/Z1TUKtkZVJNzAEjTx0RUfswpA6tpBhFOR
         ryZA==
X-Gm-Message-State: APjAAAVILuInTtKNq9z6huCFPEqi2yofdpTGKgHEQHGz/IiMNXWRw/AY
        uNWoc2r0cgFyMv5I84ivmiCQKgi0+TQnuFd+VQM=
X-Google-Smtp-Source: APXvYqx09Tq8PjPyuTQbbJcG5pwkf5HDNesGry9vyQ/fZb6BLx+Ooh0/uEU517xPfKv4BRle+BDSm/H0m0EfNYfiolM=
X-Received: by 2002:a19:4bd6:: with SMTP id y205mr7916404lfa.167.1573756461389;
 Thu, 14 Nov 2019 10:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20191108212834.594904349@goodmis.org> <20191108213450.032003836@goodmis.org>
 <20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com>
 <20191109073310.6a7a16f2@gandalf.local.home> <20191114132942.2adc7aa2@gandalf.local.home>
In-Reply-To: <20191114132942.2adc7aa2@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Nov 2019 10:34:09 -0800
Message-ID: <CAADnVQJcwyDBm7no2_wauezjkEFvgJk10FppiqRBU8p_7n0tbw@mail.gmail.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 9 Nov 2019 07:33:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Fri, 8 Nov 2019 18:29:09 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > Is there a way to do a replacement of direct call?
> >
> > I'm curious to what the use case would be. The direct call added would
> > still need to be a trampoline, as the parameters need to be saved
> > before calling any other code, and then restored before going back to
> > the traced function. Couldn't you do a text poke on that trampoline to
> > change what gets called?
> >
> > > If I use unregister(old)+register(new) some events will be missed.
> >
> > > If I use register(new)+unregister(old) for short period of time both new and
> >
> > Actually, as we only allow a single direct call to be added at any time,
> > the register(new) would fail if there was already an old at the
> > location.
> >
> > > old will be triggering on all cpus which will likely confuse bpf tracing.
> > > Something like modify_ftrace_direct() should solve it. It's still racy. In a
> > > sense that some cpus will be executing old while other cpus will be executing
> > > new, but per-cpu there will be no double accounting. How difficult would be
> > > to add such feature?
> >
> > All this said, it would actually be pretty trivial to implement this,
> > as when another ftrace_ops is attached to the direct call location, it
> > falls back to the direct helper. To implement a modify_ftrace_direct(),
> > all that would be needed to do is to:
> >
> > 1) Attached a ftrace_ops stub to the same function that has the direct
> > caller, that will cause ftrace to got to the loop routine, and the
> > direct helper would then define what gets called by what what
> > registered in the direct_functions array.
> >
> > 2) Change what gets called in the direct_functions array, and at that
> > moment, the helper function would be using that. May require syncing
> > CPUs to get all CPUs seeing the same thing.
> >
> > 3) Remove the ftrace_ops stub, which would put back the direct caller
> > in the fentry location, but this time with the new function.
> >
>
> Alexei,
>
> Do you still need such a feature?
>
> Note, I just pushed my tree to my for-next tree, and also have a
> ftrace/direct branch that ends with this patch set that is the basis of
> the rest of the work of my code. Feel free to build against that
> branch if you need to have something built on the net tree.

I'm still trying to figure out what you meant
by your suggestion to implement a modify_ftrace_direct().
I was thinking something much simpler like
modify_ftrace_direct(ip, old_call, new_ca);
will just text poke that call addr from old to new if old matches
and will adjust ftrace inner bookkeeping.
I don't understand why you want to malloc/free ftrace_ops for that.
