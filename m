Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B017C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTVrRYo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfFYW5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:57:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41898 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:57:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so237564pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHYIfR8trhI2rNFC3ibIEvgRKKuaaq5ZY41gybAYpP4=;
        b=uTVrRYo7EdSjw++LHVYFDRppnxPIdal7egJsg7AD/O9KOPaRZ3iMa4V9KRASIS3nTW
         n+kpqDXlZ2rirzU1V5xXG4dqG/xp1O7mmOcbg3Cj5TBN5rqC+aNQX9cEqhsHaDPkTJ3l
         +JuVUubJUj/AMTsLKC7rTqwMK2HakR3k2JFpKbVytMLo6FrHE0UQJMksiIdWIFddSK8B
         DzzxNey7L5+qWmexaFd33TwZRreFGQut2XpeNIZYIjtATqKX2Ugf4i/WbPtiBryift9C
         GcF4oyOUMP9fF8a6VKRh/5Lm6dXCbwGtN1Y9pYWcX+p90P8vdlrdoTMvIlUAhF+mwulB
         08NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHYIfR8trhI2rNFC3ibIEvgRKKuaaq5ZY41gybAYpP4=;
        b=ijNTLT3cIhL1rQzgfOwLfCFN4xCyavp0fXAMNrZCTuYWnWlN/B73Cknc54DRaBtVUL
         kyb0AgThYUWaaK4Yy51NRXm5O5TiTNX5vuypZ4SIZQ+obrP/7KLaMR7O0RuMD11NECdS
         /96xdv03RVyHU5qzYW9JRioPK37dUSTVMh1p/29AlPhHKvLKLZ+gIwpbG3NXJGVWnhaD
         bKZc2bNud8OZHpoiuZtV+OQCi7lO9+rkWZLkevtbxiv2qIGPHgoK3xzr9qERaaINLVZ0
         xjWzsT0vzu6qoNyf1U69KmVWwLM1/VgCIDw5GKUTTKtRX6rfbId5bc8JpQIHxvW7vvji
         TDxA==
X-Gm-Message-State: APjAAAVx6TlCbsOJyX+6vWGt7rUPl99MB2iNfEvQfAl+QduLsdhmX1cZ
        rPHlqn5IMjcZVZldbw/+oOYuxMrRqTUIyfqx+AcsKA==
X-Google-Smtp-Source: APXvYqwif0MgeybkJoqGScYSsYeZ20mZcnYYEC9X4fgQhU7lkqEKZO9sKLfYMyZ4yTdDkKysIIF7qLs1lUYjWEb/MPg=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr1172358pld.119.1561503435278;
 Tue, 25 Jun 2019 15:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com> <1336988f46fb7ffda925ab86a6e4d5437cfdb275.camel@perches.com>
In-Reply-To: <1336988f46fb7ffda925ab86a6e4d5437cfdb275.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 15:57:04 -0700
Message-ID: <CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 3:29 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-06-25 at 11:15 -0700, Nick Desaulniers wrote:
> > Unreleased versions of Clang built from source can; the latest release
> > of Clang-8 doesn't have asm goto support required for
> > CONFIG_JUMP_LABEL.  Things can get complicated based on which kernel
> > tree/branch (mainline, -next, stable), arch, and configs, but I think
> > we just have a few long tail bugs left.
>
> At some point, when clang generically compiles the kernel,
> I believe it'd be good to remove the various bits that
> are unusual like CONFIG_CC_HAS_ASM_GOTO in Makefile
> and the scripts/clang-version.sh and the like.
>
> This could help when compiling a specific .config on
> different systems.
>
> Maybe add the equivalent compiler-gcc.h #define below
> even before the removals
>
> (whatever minor/patchlevel appropriate)
> ---
>  include/linux/compiler-clang.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 333a6695a918..b46aece0f9ca 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -5,6 +5,14 @@
>
>  /* Compiler specific definitions for Clang compiler */
>
> +#define CLANG_VERSION (__clang_major__ * 10000 \
> +                      + __clang_minor__ * 100  \
> +                      + __clang_patchlevel__)
> +
> +#if CLANG_VERSION < 90000
> +# error Sorry, your compiler is too old - please upgrade it.
> +#endif
> +

Heh, I've definitely thought about clang version checks.  And I agree
with your implementation which matches the gcc 4.6 check in
include/linux/compiler-gcc.h.

There are cases when it's appropriate, such as when a certain language
feature has no way of feature detection.  Let's take for example 2
different GNU C extensions.

On one hand, consider __GCC_ASM_FLAG_OUTPUTS__
(https://developers.redhat.com/blog/2016/02/25/new-asm-flags-feature-for-x86-in-gcc-6/).
I like the design of __GCC_ASM_FLAG_OUTPUTS__ because it's
straightforward to do feature detection via preprocessor checks.  This
makes it easy to use the feature when the compiler supports it, or
provide another implementation, regardless of compiler, compiler
version preprocessor defines, etc.  It's compiler agnostic; if the
feature is there then use it or provide a fallback (or error).  I
think the code in include/linux/compiler_attributes.h also exemplifies
this mindset.  (I hope
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66970 can be implemented
soon, too, towards this goal of more portable C code).

On the other hand, consider most other GNU C extensions.  How do I
test whether they exist in my compiler or not?  Is it everything or
nothing (do they all have to exist?).  In those cases you either end
up shelling out to something like autoconf (which is what I consider
the current infra around CONFIG_CC_HAS_ASM_GOTO), or code filled with
tons of version checks for specific compilers which are brittle.

Of the two cases, now consider what happens when my compiler that
previously did not support a particular feature now does.  In the
first case, the guards were compiler agnostic, and I *don't have to
change the source* to make use of the feature in the new compiler.  In
the second case, I *need to modify the source* to update the version
checks to be correct.

That's why I consider version checks to be brittle.  Just to hammer
this point away a little more, consider this code in glib for asm goto
detection: https://github.com/GNOME/glib/blob/cbfa776fc149fcc3e351fbdf68c1a299519f4905/glib/gbitlock.c#L182.
This version check literally will not work for clang-9, though it does
support asm goto.  Unfortunately, asm goto doesn't have nice
preprocessor defines like __GCC_ASM_FLAG_OUTPUTS__ does, so someone
literally *needs to edit the source* of glib to make it take advantage
of asm goto in clang-9+ (even though clang-9+ supports the feature in
question).  Feature detection and its benefits over version detection
are well understood in the web development community where devs there
have to worry about implementations from different vendors.

Back to your point about adding a minimal version of Clang to the
kernel; I don't really want to do this.  For non-x86 architectures,
people are happily compiling their kernels with versions of clang as
old as clang-4.  And if it continues to work for them; I'm happy.  And
if it doesn't, and they raise an alarm, we're happy to take a look.
Old LTS distros may have ancient builds of clang, so maybe some kind
of hint would be nice, but I'd also like to support older versions
where we can and I think choosing clang-9 for x86's sake is too
x86-centric.  A version check on CONFIG_JUMP_LABEL is maybe more
appropriate, so it cannot be selected if you're using clang && your
version of clang is not clang-9 or greater?
-- 
Thanks,
~Nick Desaulniers
