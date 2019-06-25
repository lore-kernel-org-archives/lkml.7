Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A586EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B95A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogYHOXQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfFYMrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:47:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38597 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFYMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:47:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so12560345lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFhUYimPUbqJq9B2d185T+4I4jO8FePpZz3MVN0qKNU=;
        b=ogYHOXQWQHxY+WUNvJ6NBMM3oawP05M+8W110Ab+W6dfV3vnMshSdSFDTnAmaSV8OK
         NWE/TBAas1XEaB4qUAYbzGDI+sENo2Vxzth6tkuOXZiqQrGf2XchCDKn7rMzbNofBmiD
         RcLZ33XrszlkuQsrGMxfOwXm6J1fQl1KTwz84aGM1SE5JSmXFXRejnn2GC4eXCQJys0D
         DefDnrMWtoEk2iXIQ6Emap2w6yghEq98xPpHunnR9kM8ZUijnYodoBXuItzGzXYIKLA+
         jXg/i3AtpUshBkk3dTBYyvuvr2BPgRRH5rfTaGXgmQ+e5WnKOb+0OB/Uq5rkd8r8MHvO
         sfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFhUYimPUbqJq9B2d185T+4I4jO8FePpZz3MVN0qKNU=;
        b=haTcEHJ9mIYfT10N2B5FFBDMFphJeSif3eXZ7Yh6T/Wlw0Fqcq4Eu9jf52OUA2Vr5s
         ZBFfCAaD7BvcoNREw/mKq4BA1gFQRE48LFl6dBTy0xYiXKNNgMIHvoLsSpwsfAQtoYU3
         Q/45ZdKqzM6NP7yex7wt1zecBBtGSHbBwq/gmHM1E+czalSey77oDWAlyAirC8jQeKbc
         DoxPtBpSLaRvp7u3AP7h+FybVgZZWPdrudm2M/16FhZ97Ehu4eQjdcMHEuBNhyDiE5zA
         OKXfN5GVz0Zd5jM0rNV65loA9ZNY6LOI/GR8eys1SkfgTXuVxVm1Rl4DukuLGnDwxjbQ
         csqg==
X-Gm-Message-State: APjAAAUob1DtGokqfM6+T8y5hHTpirHjfYRA9B7XpDA/tRGX2jZOp7+G
        cLbfzhdXpscR1GXkA/TOQHic9Ya09LBAYq1fu9g=
X-Google-Smtp-Source: APXvYqzzi59+QvPIsXn/jt+BeR1itzkIlVF3TXcm4+b60gbWyKye4ZAQFj4kE9voAwJnXESq5wq/CkF/MXimCFtfIaI=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr80180lfn.165.1561466860881;
 Tue, 25 Jun 2019 05:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com> <20190625071846.GN3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190625071846.GN3436@hirez.programming.kicks-ass.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Jun 2019 14:47:29 +0200
Message-ID: <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 9:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Can it build a kernel without patches yet? That is, why should I care
> what LLVM does?

Having more than a single compiler is always a good idea. You benefit
from more warnings, more tooling, a second implementation for
reference/comparison, etc.

As for what is the current state, I think they are close, specially
for aarch64, but I let Nick, Nathan et. al. answer that! :-) (Cc'd).
They had a talk in FOSDEM 2019 about it, too.

Also CC'ing Luc since he changed sparse to stop ignoring the attribute
so that __has_attribute() would work, but I am not sure if there has
been further work on supporting it properly.

> > Also note that C2x may get [[fallthrough]]. See N2267 and N2335. At
> > that point, surely tools/IDEs/analyzers will support it :-) The
> > question is whether we want to wait that long to replace the comments.
>
> #define __fallthrough [[fallthrough]]
>
> right?

Yes and no. The exact spelling we use does not matter much. My point
with that paragraph was that since C2x will (maybe) add fallthrough,
as C++17 did, every compiler/analyzer/IDE/etc. that is still missing
support for it will have to eventually add it even if they ignore GNU
attributes. At that point, I would guess most will likely add all
spellings too.

Cheers,
Miguel
