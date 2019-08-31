Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB382C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7463922D37
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STgNSSqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfHaRtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 13:49:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfHaRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 13:49:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so10006287wrx.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdsMvOsDGpwgDD/vj4j7q/Nsn3f/GT/pd3p/c4qtgQk=;
        b=STgNSSqWuaTPtQxfZUjAn6t/RpiHW3oNrjcOdPRjdyfpHakkqPNd5xjtzw++yrg7Io
         xpICZNenr+GGhBmzUd4Q4hqDVtGMkEHAv5bCVIf41T5fw7e8udMSDVEBfFDAJdoKhuT9
         Ai7mEXBuu/S91wUTCbBJLw/rhm3XaKWFnKbmi3Uu0A0rHeYizQIWsA4W8qJ9HS5QhzTp
         zwXl82HIOZnnS1OWT2Q0ItKAQLsjcqoRwXIkFA5EnxI961fZ0h7RBi1RPq8NQaIiLktj
         O3x6tt9IfQHaShCrONBgVDeJoM/dz8SucKYbdmmh7GuOyBbSlOk54tbIP/bKwN5gYLWE
         wW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdsMvOsDGpwgDD/vj4j7q/Nsn3f/GT/pd3p/c4qtgQk=;
        b=YIo2c5vF35Q7MRpJamwHV/SbI30zJDpSGqviJszlh8QdbCFYmB/wgd1y4sIuoXR9+D
         fbqoKcaAQ+AiJWOw7LZF+amepDD3pGV5k4zhbhYhA/grFUnna0gTBFKSQ8qYNvTh4y0l
         nus6auRfsfy20lYNOXrgHG/ggZNCpa52LMoMv51QcTuY9X1iNQXeJC8iG8reixqn9YZO
         R7YH0T+dvPIp1DBPc/4SFy3O+vlXOpjLytwjVEVuHoFvr5ksF0FsJXUY1J5IJkZg6aCV
         5YsU9YkqYT+Flk+6OwAxrGmZwCPSb/JHAa1BDz2KQtcc8RW9ULzfFei1MwF42+50xtpJ
         Z9Ng==
X-Gm-Message-State: APjAAAUhjg6el50Y4WiARelTjqqoT5R5HZ5sM9JnLf+G+cxHMtW2EzHb
        yVFSui42eROhpjOl8vPdt8OQuyAMmSeAwJItyU9u8w==
X-Google-Smtp-Source: APXvYqyRhsVkyzGzSbN+QuHx3fD6W0lV9etQ/NGMSOU8sMC2hoVOy0wqveGIp/4xZrctLTm3XjEPz64psHiT+OBMN5g=
X-Received: by 2002:adf:ec48:: with SMTP id w8mr1105602wrn.198.1567273747268;
 Sat, 31 Aug 2019 10:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190827163204.29903-1-will@kernel.org> <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck> <201908281353.0EFD0776@keescook>
In-Reply-To: <201908281353.0EFD0776@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 31 Aug 2019 20:48:56 +0300
Message-ID: <CAKv+Gu_Q=o_6xDW_7YTd3J6psqs-o+qBxW4r9MXCBwjmsGpTbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_* operations
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 00:03, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Aug 28, 2019 at 03:14:40PM +0100, Will Deacon wrote:
> > On Wed, Aug 28, 2019 at 09:30:52AM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> > > > Will Deacon (6):
> > > >   lib/refcount: Define constants for saturation and max refcount values
> > > >   lib/refcount: Ensure integer operands are treated as signed
> > > >   lib/refcount: Remove unused refcount_*_checked() variants
> > > >   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
> > > >   lib/refcount: Improve performance of generic REFCOUNT_FULL code
> > > >   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
>
> BTW, can you repeat the timing details into the "Improve performance of
> generic REFCOUNT_FULL code" patch?
>
> > > So I'm not a fan; I itch at the whole racy nature of this thing and I
> > > find the code less than obvious. Yet, I have to agree it is exceedingly
> > > unlikely the race will ever actually happen, I just don't want to be the
> > > one having to debug it.
> >
> > FWIW, I think much the same about the version under arch/x86 ;)
> >
> > > I've not looked at the implementation much; does it do all the same
> > > checks the FULL one does? The x86-asm one misses a few iirc, so if this
> > > is similarly fast but has all the checks, it is in fact better.
> >
> > Yes, it passes all of the REFCOUNT_* tests in lkdtm [1] so I agree that
> > it's an improvement over the asm version.
> >
> > > Can't we make this a default !FULL implementation?
> >
> > My concern with doing that is I think it would make the FULL implementation
> > entirely pointless. I can't see anybody using it, and it would only exist
> > as an academic exercise in handling the theoretical races. That's a change
> > from the current situation where it genuinely handles cases which the
> > x86-specific code does not and, judging by the Kconfig text, that's the
> > only reason for its existence.
>
> Looking at timing details, the new implementation is close enough to the
> x86 asm version that I would be fine to drop the x86-specific case
> entirely as long as we could drop "FULL" entirely too -- we'd have _one_
> refcount_t implementation: it would be both complete and fast.
>

+1

> However, I do think a defconfig image size comparison should be done as
> part of that too. I think this implementation will be larger than the
> x86 asm one (but not by any amount that I think is a problem).
>

It's been ~2 years since I looked at this code in detail, but IIRC, it
looked like the inc-from-zero check was missing from the x86
implementation because it requires a load/compare/increment/store
sequence instead of a single increment instruction taking a memory
operand. Was there more rationale at the time for omitting this
particular case, and if so, was it based on a benchmark? Can we run it
against this implementation as well?

> I'd also note that the saturation speed is likely faster in this
> implementation (i.e. the number of instructions between noticing the
> wrap and setting the saturation value), as it is on the other side of
> a branch instead of across a trap, trap handler lookup, and call. So
> the race window should even be smaller (though I continue to think it
> remains hard enough to hit as to make it a non-issue in all cases: if
> you can schedule INT_MAX / 2 increments before a handful of instructions
> resets it to INT_MAX / 2, I suspect there are much larger problems. :)
>
> --
> Kees Cook
