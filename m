Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22BC04AAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 01:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A1220872
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 01:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWlFD/3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfESBli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 21:41:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39034 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfESBli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 21:41:38 -0400
Received: by mail-io1-f67.google.com with SMTP id m7so8401692ioa.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 18:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+HeqwAEcCZlxTlN2fPsPmRvYlA8UMTWELs3MdTDPTY=;
        b=FWlFD/3ebRRLCywonkK1V5QyHaUWgp5+enX7C4DTPmQq/+0ZOddkFJv8wtfJozlPD7
         PdWr96cjJh0exNAtBjPS0bTYeRJdxVsLiP6m0kUEtobZSygqFw+ItjXcgXEWo9QyI+6t
         fXrGhg7LQlDs64VGOfh96k1ZXK70QND8msR6K/rY3ni8qJ4ZAqzMHoc1m4+f1w2rVzJo
         V/WFiCxX0Eq5ngh0DQy9e9ooY2MWmHuNUHodaJLn6u1xddzAwwNexabtGE5739t+YVLo
         uRqQ5B3xsFm2lPEVnBZauIF6ma/iXrYcLusEvSKiT+O8Ubeaew1MBk3z5zL3XKmv96mr
         79QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+HeqwAEcCZlxTlN2fPsPmRvYlA8UMTWELs3MdTDPTY=;
        b=K6tcRV9Z+MlNNnVgixqTUB+hXNr2sS6kcN490VtGICVHtHI+jxmq+cSfd4nprlaGBq
         VdqMMtdru/ieIMBZmJc94HDxNSLS51nSf1s0lFxQ7FEVTfeL4TN75n866hjpA9hdlj3I
         a8PzoXNjDSQD7YFuGCzKioA169N955N4oToK7oNcACOHEzk+MfaV4y+66QGOpjdVZJVV
         wJivveyhCCVN5k2/F2CbMGKkg+Ft1KlpYaPwEWO3zjh8tCJh6FrkCeEGOx61lh27wxYp
         KDENgEev8usScrsiMyesOcdSxkQRJc8fGLZn+gxfP9Qjw3/BQuZ84UP0gDiLB02sxnRI
         MpeQ==
X-Gm-Message-State: APjAAAW0aR/0JKl/ByxfvOq8k5MCn7mu2A2s659G84LUVwQOwqj2Qi+o
        Fwbr88XQApH31oFFo9tkE+JwLkT6x3bLqSCbf8wGpg==
X-Google-Smtp-Source: APXvYqxw7z6yLYUkJ+gWXvTxERjZmblTFTr1I6hJ8+3UBc0x/URaQgoudoPl7MXtnLGMFZI9j+EBMcoWuzrKeCzjVyI=
X-Received: by 2002:a5d:96c4:: with SMTP id r4mr10137168iol.193.1558230096974;
 Sat, 18 May 2019 18:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190509214556.123493-1-eranian@google.com> <tip-6b89d4c1ae8596a8c9240f169ef108704de373f2@git.kernel.org>
 <20190518211630.GC51669@gmail.com>
In-Reply-To: <20190518211630.GC51669@gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Sat, 18 May 2019 18:41:25 -0700
Message-ID: <CABPqkBSS5b583+sxGjLj=N-OSOMFRiTtbZLNF0=+cCqvvEigqw@mail.gmail.com>
Subject: Re: [tip:perf/urgent] perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT*
 masking
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 2:16 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * tip-bot for Stephane Eranian <tipbot@zytor.com> wrote:
>
> > Commit-ID:  6b89d4c1ae8596a8c9240f169ef108704de373f2
> > Gitweb:     https://git.kernel.org/tip/6b89d4c1ae8596a8c9240f169ef108704de373f2
> > Author:     Stephane Eranian <eranian@google.com>
> > AuthorDate: Thu, 9 May 2019 14:45:56 -0700
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Fri, 10 May 2019 08:04:17 +0200
> >
> > perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking
> >
> > On Intel Westmere, a cmdline as follows:
> >
> >   $ perf record -e cpu/event=0xc4,umask=0x2,name=br_inst_retired.near_call/p ....
> >
> > was failing. Yet the event+ umask support PEBS.
> >
> > It turns out this is due to a bug in the the PEBS event constraint table for
> > westmere. All forms of BR_INST_RETIRED.* support PEBS. Therefore the constraint
> > mask should ignore the umask. The name of the macro INTEL_FLAGS_EVENT_CONSTRAINT()
> > hint that this is the case but it was not. That macros was checking both the
> > event code and event umask. Therefore, it was only matching on 0x00c4.
> > There are code+umask macros, they all have *UEVENT*.
> >
> > This bug fixes the issue by checking only the event code in the mask.
> > Both single and range version are modified.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Vince Weaver <vincent.weaver@maine.edu>
> > Cc: kan.liang@intel.com
> > Link: http://lkml.kernel.org/r/20190509214556.123493-1-eranian@google.com
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  arch/x86/events/perf_event.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > index 07fc84bb85c1..a6ac2f4f76fc 100644
> > --- a/arch/x86/events/perf_event.h
> > +++ b/arch/x86/events/perf_event.h
> > @@ -394,10 +394,10 @@ struct cpu_hw_events {
> >
> >  /* Event constraint, but match on all event flags too. */
> >  #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
> > -     EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
> > +     EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
> >
> >  #define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)                  \
> > -     EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
> > +     EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
>
> This commit broke one of my testboxes - and unfortunately I noticed this
> too late and the commit is now upstream.
>
> The breakage is that 'perf top' stops working altogether, it errors out
> in the event creation:
>
>  $ perf top --stdio
>  Error:
>  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
>
> I bisected it back to this commit:
>
>  6b89d4c1ae8596a8c9240f169ef108704de373f2 is the first bad commit
>  commit 6b89d4c1ae8596a8c9240f169ef108704de373f2
>  Author: Stephane Eranian <eranian@google.com>
>  Date:   Thu May 9 14:45:56 2019 -0700
>
>     perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking
>
> The system is IvyBridge model 62, running a defconfig-ish kernel, and
> with perf_event_paranoid set to -1:
>
>  [    3.756600] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
>
>  processor      : 39
>  vendor_id      : GenuineIntel
>  cpu family     : 6
>  model          : 62
>  model name     : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz
>  stepping       : 4
>  microcode      : 0x428
>
> If I revert the commit 'perf top' starts working again.
>
I have some ivybridge systems, let me debug this. This is likely
related to cycles:ppp stuff given what perf top does.
I think my patch is right, but there may be assumptions or bugs
elsewhere exposed by the fix.

>
> Thanks,
>
>         Ingo
