Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D529CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A9C21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c081sn6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfCURYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:24:06 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42769 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCURYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:24:06 -0400
Received: by mail-ua1-f67.google.com with SMTP id s26so2173683uao.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edN8mbSonelSs10wXRgLVOdRWztUgDj+E0oQokPbibM=;
        b=c081sn6gsAvnO7YePYKSBIDLybYfsf6sNMLCEDrNV/O/RBpOzyRikJQQ8TvexemEEm
         sSqN+2lgibHPPPstwFmxmOHoYAb3hqxRKuYGXcxYRfWrZdZSd06aUmLVQiO49RWoKn1C
         92/e9/BywS51WdYc6Esd6TtU6FjgqhIaw2nt945V3I31x9p4Fxf8Nr9ft/XoOLcZNcKC
         4hY3fyyuUY9nNSMn32au9BfjK2JmWWd7hDnd7GVgWwAbjrlr9c3Ep5IE3LJzHLauL5LP
         y/ILLYW5mTLT21TAnZQ76dSEMj1JS8k9LF8JMaWlQjdZjukrC6dz6jzE8jwYTpVk3ZeN
         MSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edN8mbSonelSs10wXRgLVOdRWztUgDj+E0oQokPbibM=;
        b=PqvFVGqMatLaewds0ZxIaeWmHPNzSMq7tcICre1K/m9KJSTbK2mO7l6tpqx5zZZv1S
         ySrdqJDznOkHAcCfKVlBsJwaCC45Vy0UiZd5C2zW6x23ii7qATnRdbGAYdAvHmpo86Nk
         N6nrmFN5ud3aIIyv3ddyh18YS14YPDuPYsqbBAZLDicP4siGWZaYxpRnWNYboWHTtj/H
         MeymWYUfXJIgO2bKL6ZgcoKABkPcX/eycvBXEFy73J5p89kKyuncLFBAv6Xg+R3KhbuW
         8OUOWOgu5EgTLXbLLffQnvwcjUzJSE+JZWW7jtZcZQ2r58PaMSEaIHKrQjLZHRTgOMd3
         jMEQ==
X-Gm-Message-State: APjAAAWQPiGjj49FsRR7YCtjNbZxdRWfjHwyTFYEHxWm2Dff/VqDuXTY
        D1dc+/gzXv8buAEEeDbo0Sx5r0w+wfg+kgNHbcKcuA==
X-Google-Smtp-Source: APXvYqwlsXtf2usG8DJIdz89HmrkSMZxfDxQtm5EHq+TYkZEH0SsgK+DVo9qJirTp2/yOBJFo/bzk57VTaEHWeKPnS8=
X-Received: by 2002:ab0:6193:: with SMTP id h19mr2473143uan.47.1553189043420;
 Thu, 21 Mar 2019 10:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net> <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net> <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 21 Mar 2019 10:23:50 -0700
Message-ID: <CABPqkBSZbAbU5h=t2f=oMre080ezSq78LaNQO5xEdRV1nczuew@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 9:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > Subject: perf/x86/intel: Initialize TFA MSR
> >
> > Stephane reported that we don't initialize the TFA MSR, which could lead
> > to trouble if the RESET value is not 0 or on kexec.
>
> That sentence doesn't parse.
>
>   Stephane reported that the TFA MSR is not initialized by the kernel, but
>   the TFA bit could set by firmware or as a leftover from a kexec, which
>   makes the state inconsistent.
>
Correct. This is what I meant.
The issue is what does the kernel guarantee when it boots?

I see:
static bool allow_tsx_force_abort = true;

Therefore you must ensure the MSR is set to reflect that state on boot.
So you have to force it to that value to be in sync which is what your
new patch is doing.

> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/events/intel/core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 8baa441d8000..2d3caf2d1384 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
> >
> >       cpuc->lbr_sel = NULL;
> >
> > +     if (x86_pmu.flags & PMU_FL_TFA) {
> > +             WARN_ON_ONCE(cpuc->tfa_shadow);
>
> Hmm. I wouldn't warn here as this is a legit state for kexec/kdump and I
> don't think we can figure out whether this comes directly from the
> firmware.
>
> Thanks,
>
>         tglx
