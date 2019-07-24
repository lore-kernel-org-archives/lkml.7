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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8ACC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12821911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llpCdpQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfGXSbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:31:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39866 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfGXSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:31:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so32131720wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8zlDZzsAAvON27k3Pf9Ie+llM2L+UReRB9e0skwMC2U=;
        b=llpCdpQjiEr91IN+xbNFB/IGplDjZohwxbnvVGRzJrHYsxPsc5kkRY4mBZG9NL0cnk
         e3IUyuouVc4Qx5qeDlI576aNfC9EwwSmEug09JFX7aosoa6fdxlevH/H7EInpqiw1cPI
         Iu/r4eiZQp2Ko7WTdR2Uvx9lPB+QEc2xU6xGClhOvQZlRI4bZKqvUSqcfOCDn8WtfsSZ
         +NDzunmxLtFZgs3hgW/9rP3Y1HtESI1Sw5A1w+mGKMI2glDtXIAhpRqveBynbNp3DHbF
         fut/ClaFICD1v2BiReqIuJyidwMYhBhZ0LV6R75YkRaabXzw81s32qKRHRkpJWXaVOcz
         laXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8zlDZzsAAvON27k3Pf9Ie+llM2L+UReRB9e0skwMC2U=;
        b=fp0rCp4/PezuMkQBZSuvAIfTmh8bSm/+fRr2gfbas3MQXpzE9ZV9f+FJfaCisDQEqM
         /fpETAilphYkKigexiOrXNZDkpbL4py6Hk2l9a1mS7Ao7VRalaBl4hvzwwhEXxGK8Hdq
         h5dw7KJNHz3vdwRwOHl+j12BdVr7vz0qJx7L0LskGFSggHR38zY2GzI3eh0WGJ0PYzv4
         v/m9/2UgOWuEjE4g49qi5RUd2cFyBUHkLPTkSNySZP9NRSZNxSINp1cBu+5JsyicdtDX
         MP6RPW81Y7pfzek8o9oQ0x7WqjnL8HdNTlcUPV3YmqzXj6C/GbxfFCNwwPQP9227Va2z
         bdog==
X-Gm-Message-State: APjAAAUb2slIEaGgE+ZsR/INstNFE0tESpPfundLbuU8KFThFixc7Rzj
        pnBdcPk0A3XU3t+V3qLAW32b6+l84qBHnhyDPWgH6OQ2P4c=
X-Google-Smtp-Source: APXvYqy96Q+Z3dmuuTeBXpdQsrGH4IhIyvBFz06LgBhSynEmQlIlk48HMlu5OPor977A4TkXeOaGhSf1VX4jYRtVPec=
X-Received: by 2002:a7b:c215:: with SMTP id x21mr75720175wmi.38.1563993066886;
 Wed, 24 Jul 2019 11:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble> <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble> <20190724133516.GB31381@hirez.programming.kicks-ass.net>
 <20190724141040.GA31425@hirez.programming.kicks-ass.net> <20190724164821.GB31425@hirez.programming.kicks-ass.net>
In-Reply-To: <20190724164821.GB31425@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Jul 2019 20:30:55 +0200
Message-ID: <CA+icZUVt0QK9SoWHU3G8e8MXOYOJSsh70+PCCWx15buZDvu8nQ@mail.gmail.com>
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

On Wed, Jul 24, 2019 at 6:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 24, 2019 at 04:10:40PM +0200, Peter Zijlstra wrote:
> > And that most certainly should trigger...
> >
> > Let me gdb that objtool thing.
>
> ---
> Subject: objtool: Improve UACCESS coverage
>
> A clang build reported an (obvious) double CLAC while a GCC build did
> not; it turns out we only re-visit instructions if the first visit was
> with AC=0. If OTOH the first visit was with AC=1, we completely ignore
> any subsequent visit, even when it has AC=0.
>
> Fix this by using a visited mask, instead of boolean and (explicitly)
> mark the AC state.
>
> $ ./objtool check -b --no-fp --retpoline --uaccess ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)
>
> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter Z. and Josh P.!

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

[1] https://github.com/ClangBuiltLinux/linux/issues/617

> ---
>  tools/objtool/check.c | 7 ++++---
>  tools/objtool/check.h | 3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5f26620f13f5..176f2f084060 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1946,6 +1946,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>         struct alternative *alt;
>         struct instruction *insn, *next_insn;
>         struct section *sec;
> +       u8 visited;
>         int ret;
>
>         insn = first;
> @@ -1972,12 +1973,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>                         return 1;
>                 }
>
> +               visited = 1 << state.uaccess;
>                 if (insn->visited) {
>                         if (!insn->hint && !insn_state_match(insn, &state))
>                                 return 1;
>
> -                       /* If we were here with AC=0, but now have AC=1, go again */
> -                       if (insn->state.uaccess || !state.uaccess)
> +                       if (insn->visited & visited)
>                                 return 0;
>                 }
>
> @@ -2024,7 +2025,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>                 } else
>                         insn->state = state;
>
> -               insn->visited = true;
> +               insn->visited |= visited;
>
>                 if (!insn->ignore_alts) {
>                         bool skip_orig = false;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index b881fafcf55d..6d875ca6fce0 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -33,8 +33,9 @@ struct instruction {
>         unsigned int len;
>         enum insn_type type;
>         unsigned long immediate;
> -       bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
> +       bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
>         bool retpoline_safe;
> +       u8 visited;
>         struct symbol *call_dest;
>         struct instruction *jump_dest;
>         struct instruction *first_jump_src;
