Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6B02190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3NL5OAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCVTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:05:09 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33757 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:05:09 -0400
Received: by mail-vs1-f68.google.com with SMTP id z6so2004772vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuGeYXYMxPj1xf5ZZS06FwRXke7aLba1dEUVGe11Odc=;
        b=C3NL5OAZV4Kwj1I3rcIL7w++E99EMJ2BemYTOZfSlJWRilxLJgnYyKpc/WJXnywa+R
         +o4y/z+fxNHoBFH+ee9GNF1FemPEgr/KP8FeSvhZNxvHR7pZzLlmUYtJplDMc426p6jT
         n1ZOjCQu+ChmL6ELTd6sMVfgepveVeCuSNGmrKUwN1RQmbfgqnB47p6HJEdKiP52HgKu
         cjJQIfClJRJUj1jskv2mnYdtqkiaLGuN7cTb2xU8aGPaKeLcFNNqiFYEOk5h3BcXZBBB
         J+555EhC4G5b6f18EGJruwHlLLo1KzEDVVvby4YYd+WngKFi3huzy3LzFWqK2uCmPpH1
         PyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuGeYXYMxPj1xf5ZZS06FwRXke7aLba1dEUVGe11Odc=;
        b=Qg9HOZ+L3lgGkdyE8ABYaBAdqJegxdgiQD8D4aAbx+z8bVB1fx3mcLl2O0HZv+QfUV
         lfQwPcSYP/vyG2JxPJ/X3KEl6MJp9/IN6znayH6+IevkpACrh0GXxM1z3eYzsQurZiuC
         GKkx0fMiQJlR/7Py7VS7iRBbAcOCJTY7GyJjpskBtAzqV8O5ZQgGszkwGHQFTmbS7KjF
         tFYbUwk/z/iCWYVrRWEO6kvF4nlYh9YbUiBw5njV6GD/nQCBPDPjjymH1wHdfzMDE8At
         iLyWn0HL5ZEBYwpCl1ga5n1UxrDjKL+9ULPsAWBuwqgK/D3jnQMvJT/PI5D0aNI6ciBJ
         K3Dw==
X-Gm-Message-State: APjAAAX6bKLWI456PmbmRQa8B/va7h53JE3/GdkWHygT2lu86pdaX7ic
        ewgUokMW1hYuyy2/Ka+kSsh9zCBYSqUVqK5PD7b4cw==
X-Google-Smtp-Source: APXvYqwl17oviXYzHPfD3ms8L617n6oBYtTHLNW8HwYgUEG0yZDstZ+RnYtXw/42BFwon8JCORPBqoEoC0mHQvuKWko=
X-Received: by 2002:a67:e9cc:: with SMTP id q12mr7026549vso.208.1553281507110;
 Fri, 22 Mar 2019 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net> <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net> <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <CABPqkBSZbAbU5h=t2f=oMre080ezSq78LaNQO5xEdRV1nczuew@mail.gmail.com> <alpine.DEB.2.21.1903211844010.1784@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903211844010.1784@nanos.tec.linutronix.de>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 22 Mar 2019 12:04:55 -0700
Message-ID: <CABPqkBQ=hGNY8nd5WTONaMepH1ma=dBN=AdWOyOF_xe1K5JGHA@mail.gmail.com>
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

On Thu, Mar 21, 2019 at 10:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 21 Mar 2019, Stephane Eranian wrote:
> > On Thu, Mar 21, 2019 at 9:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > > > Subject: perf/x86/intel: Initialize TFA MSR
> > > >
> > > > Stephane reported that we don't initialize the TFA MSR, which could lead
> > > > to trouble if the RESET value is not 0 or on kexec.
> > >
> > > That sentence doesn't parse.
> > >
> > >   Stephane reported that the TFA MSR is not initialized by the kernel, but
> > >   the TFA bit could set by firmware or as a leftover from a kexec, which
> > >   makes the state inconsistent.
> > >
> > Correct. This is what I meant.
> > The issue is what does the kernel guarantee when it boots?
> >
> > I see:
> > static bool allow_tsx_force_abort = true;
> >
> > Therefore you must ensure the MSR is set to reflect that state on boot.
> > So you have to force it to that value to be in sync which is what your
> > new patch is doing.
>
> The initial state should be that the MSR TFA bit is 0. The software state
> is a different beast.
>
> allow_tsx_force_abort
>
>   false                 Do not set MSR TFA bit (Make TSX work with PMC3) and
>                         exclude PMC3 from being used.
>
>   true                  Set the MSR TFA bit when PMC3 is used by perf, clear it
>                         when PMC3 is not longer in use.
>
I would expect this description to be included in the source code where the
allow_tsx_force_abort variable is defined and somewhere in the kernel
Documentation
because it is not trivial to understand what the control actually does
and the guarantees
you have when you toggle it.

> Now, if the firmware or the kexec has the TFA bit set in the MSR and PMC3
> is not in use then TSX always aborts pointlessly. It's not a fatal isseu,
> but it's inconsistent.
>
> So independent of the state of allow_tsx_force_abort the kernel has to
> clear the MSR TSA bit when the CPUs are brought up.
>
> The state of allow_tsx_force_abort is solely relevant after CPUs coming up
> to decide whether PMC3 can be used by perf or not.
>
> Thanks,
>
>         tglx
>
