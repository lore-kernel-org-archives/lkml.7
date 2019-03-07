Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF97C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCGWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:24:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38651 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:24:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id s1so19118268qte.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVSDyuojxDr8yKM2hUZArTW3td5unUmPpSnGlPnhrLA=;
        b=Z3BirsmqKDZtstrgnAnuGYb6p9K+3MdnF1jSli5vondQicCQRapn0TLQovbM+IDZg/
         uIEpOiytmwwCEpypLqAfcCol3fSiTqGz+Ul39Za3mMH54lgRckbj79VJSoUQctOOr0CP
         QuT/oBB+lNDcEYkBoqSF8TSmStmCH8olFYnkqHt3fLLl/vC3YcdvzOOi4SjRt0hK29M6
         2di1WzUnQdqZbCkIBOq30xPkYn9NFfLaL+qnc09NQVlG/AIjSkglOho4w1Asq0kYD3Jd
         oOd52skhw8x3w+cgy5hYGa9Km4sNvYB4p/Le/B3Y56f3EzAgeKcxfA/C3a9adJKjxIYH
         xtIQ==
X-Gm-Message-State: APjAAAXezpYVUTgPMv1MbFuuZDu3jVW1j2fFOBWBIrzvu+UXbtpCt4+U
        w565MBpINWDFn/148XnTZpL6Ng5h7mxh72KISOA=
X-Google-Smtp-Source: APXvYqzNriK/KMlNRmmAEqfBV/zdy5PYR6cREKCd0ieKPnVJm1CixoY1ZAsRXjYkdhIwrW1TugnA9Tv4UOXAxKMmk68=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr12833709qve.115.1551997482641;
 Thu, 07 Mar 2019 14:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <CAKwvOdkr+a1F1VJ=Gc44WfrBnhnDNkvgQ=byz+N++xQ6VPdc2g@mail.gmail.com>
 <20190307182102.GA12466@archlinux-ryzen>
In-Reply-To: <20190307182102.GA12466@archlinux-ryzen>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 23:24:26 +0100
Message-ID: <CAK8P3a1sPvO=V07oSUQ2Sdf4S5voVLfWeK=1Fu10_BNAJYWF8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 7:21 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Mar 07, 2019 at 10:12:11AM -0800, Nick Desaulniers wrote:
> > On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On 32-bit ARM, I got a link failure in futex_init() when building
> > > with clang in some random configurations:
> > >
> > > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> >
> > Do we know what function from the fixup text section is calling
> > futex_detect_cmpxchg?  I'm curious if this is maybe another case of
> > -Wsection where some function may be in the wrong section?
> >
>
> Looks like this is the call stack:
>
> futex_init ->
>     futex_detect_cmpxchg ->
>         cmpxchg_futex_value_locked ->
>             futex_atomic_cmpxchg_inatomic
>
> This is the same issue I reported: https://github.com/ClangBuiltLinux/linux/issues/325
>
> Marking arm's futex_atomic_cmpxchg_inatomic as noinline also fixes this
> so maybe that's it?

I think part of the problem is the linker sometimes failing to generate
veneers for long calls. I've seen this in the past with relocations in
non-executable sections, but it's possible that the problem here is
having a relocation to a section that doesn't start with ".text".

I have not analyzed the linker behavior in more detail, but have
experimentally shown that the problem doesn't happen if the relocation
is from the .text.fixup segment to .text rather than .init.text. It's
also possible that this is simply a result of the relative distance of
the locations in memory as Russell said, so it could come back
if the kernel grows further.

        Arnd
