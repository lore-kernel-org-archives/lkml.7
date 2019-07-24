Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A15C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2AD2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSzmjEPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbfGXScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:32:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36630 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfGXSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:32:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so38392791wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=s4VfL6MUO9VgRafLAF5EHdvsk9Fh9zd6SRuOSd4BkgI=;
        b=MSzmjEPvgfRRF+iHLcf9ulyHpUxlF5v5/lx8kGQhYjNg7lLjvIvOC2gOycU9mXHrTb
         cZasiMHCfpRwzWh8ygo5XuNQ5JK5cmANI0uSjs9/ybRasKlZxJpXcf5vxOCd9nR7XNGR
         UhZxNrlodw1+Kky5lC3Al7jO5AmlEuS4f+XnMYjG/ECwRePNvd0pB25dJrVAVdNV7wKt
         pihJgG/zG9KDiyVJ7+KkowHTHUzac899UHLgLbHnypxcRk0AOheoTkFF3WTI9B2vTSR2
         X6nV5Pi2Hi/royFVWMbUHoMfaJi9cdfcto9/VhG5s/g8ffD+GUUHXwxaJ/COvOv65zdU
         +apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=s4VfL6MUO9VgRafLAF5EHdvsk9Fh9zd6SRuOSd4BkgI=;
        b=NZMYT3sSo3lHcK4OYCuFgSyqz+bz0KG18D4mMng+XxK/E+EEq9poXyvoOPYgVlHShO
         vY/C7GHF3G4kXJEn/DGrgIBVK4GaAcVuRpDYWUWWJ9rVqsdwIjiCN6kelf8fc5TrQnfE
         XgZWBw2/CSTbudofz7QJFdDYavD16ZEilvxLt8Tcz2FzzqIZPdn5wQWY1CDeeJ8KKz2b
         AejboAng3C0gdAhY1Otir4drOsbq1r9OzZYqccMkyza8bwstlmYh2L22BOA/8WDytQTJ
         PZpUDSO8ZX1vE1fe01/Hz0JCjYrT5gSt2flS5Iomv8AZfbyF7EOn8ekgs4D/hL8lmRyE
         p09Q==
X-Gm-Message-State: APjAAAWuhTRiFLizs1n9YBWEQZ0JK5Zx+xSfLKU+Lgl/lia+9sSxsR/4
        eyGGjhs/n9Tco+BBjTQ6ubICcShi2pLHp4D9LeI=
X-Google-Smtp-Source: APXvYqwO8Ga9X1u/mvkbtBqTdv0fQvbAoRAuq6J3HqtYRe8x/FRaMUJ7cREWJQJz9QKJBfkba2DYwMjMr2pL2eBEBaQ=
X-Received: by 2002:a7b:c215:: with SMTP id x21mr75723916wmi.38.1563993158584;
 Wed, 24 Jul 2019 11:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble> <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble> <20190724133516.GB31381@hirez.programming.kicks-ass.net>
 <20190724141040.GA31425@hirez.programming.kicks-ass.net> <20190724164821.GB31425@hirez.programming.kicks-ass.net>
 <CA+icZUVt0QK9SoWHU3G8e8MXOYOJSsh70+PCCWx15buZDvu8nQ@mail.gmail.com>
In-Reply-To: <CA+icZUVt0QK9SoWHU3G8e8MXOYOJSsh70+PCCWx15buZDvu8nQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Jul 2019 20:32:27 +0200
Message-ID: <CA+icZUUauLqH8JL6NNA2WZHByOLvTSboSN8CxF0RYOpwSfi4jw@mail.gmail.com>
Subject: Re: [PATCH] objtool: Improve UACCESS coverage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 8:30 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 24, 2019 at 6:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 24, 2019 at 04:10:40PM +0200, Peter Zijlstra wrote:
> > > And that most certainly should trigger...
> > >
> > > Let me gdb that objtool thing.
> >
> > ---
> > Subject: objtool: Improve UACCESS coverage
> >
> > A clang build reported an (obvious) double CLAC while a GCC build did
> > not; it turns out we only re-visit instructions if the first visit was
> > with AC=0. If OTOH the first visit was with AC=1, we completely ignore
> > any subsequent visit, even when it has AC=0.
> >
> > Fix this by using a visited mask, instead of boolean and (explicitly)
> > mark the AC state.
> >
> > $ ./objtool check -b --no-fp --retpoline --uaccess ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
> > ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)
> >
> > Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Thanks Peter Z. and Josh P.!
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Please, add this reference:

Link: https://github.com/ClangBuiltLinux/linux/issues/617

> [1] https://github.com/ClangBuiltLinux/linux/issues/617
>
> > ---
> >  tools/objtool/check.c | 7 ++++---
> >  tools/objtool/check.h | 3 ++-
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 5f26620f13f5..176f2f084060 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -1946,6 +1946,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >         struct alternative *alt;
> >         struct instruction *insn, *next_insn;
> >         struct section *sec;
> > +       u8 visited;
> >         int ret;
> >
> >         insn = first;
> > @@ -1972,12 +1973,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >                         return 1;
> >                 }
> >
> > +               visited = 1 << state.uaccess;
> >                 if (insn->visited) {
> >                         if (!insn->hint && !insn_state_match(insn, &state))
> >                                 return 1;
> >
> > -                       /* If we were here with AC=0, but now have AC=1, go again */
> > -                       if (insn->state.uaccess || !state.uaccess)
> > +                       if (insn->visited & visited)
> >                                 return 0;
> >                 }
> >
> > @@ -2024,7 +2025,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >                 } else
> >                         insn->state = state;
> >
> > -               insn->visited = true;
> > +               insn->visited |= visited;
> >
> >                 if (!insn->ignore_alts) {
> >                         bool skip_orig = false;
> > diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> > index b881fafcf55d..6d875ca6fce0 100644
> > --- a/tools/objtool/check.h
> > +++ b/tools/objtool/check.h
> > @@ -33,8 +33,9 @@ struct instruction {
> >         unsigned int len;
> >         enum insn_type type;
> >         unsigned long immediate;
> > -       bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
> > +       bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> >         bool retpoline_safe;
> > +       u8 visited;
> >         struct symbol *call_dest;
> >         struct instruction *jump_dest;
> >         struct instruction *first_jump_src;
