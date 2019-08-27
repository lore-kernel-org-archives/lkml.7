Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE162070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNoJCtJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfH0V4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:56:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0V4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:56:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so185576pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgrXiX6w+iXAJx451uKI5IvGXQ8JzxadwvN8II0tDoE=;
        b=BNoJCtJR9DudUn5uIPXEstToXgIyaeuQKR8gPCMk32BwoLZ3w+Bq0EcyxwGluhWtrT
         N61JFyt/usomSRCx1GADBeEqDWHq4/88rlPVf0x/eDnEyMqIPl1qK1QMTZTjOqCHnkj8
         wrBP1Ly28xFm9WHlxqhpg6fyxD8AZd/D/u10HDmnmv6AwK2q9J2XUEvE50evh7EQQrPA
         M/G5iQ7RCfP1GGZZ8RqvGqroXqBktdOTzIqYem2OOFsiRxSvVdeTXcYliA8oFfi+anav
         khxlF58mako4lJsz7h3+PfJ9K3+IYMqzgxbqEXTpEFPqyUns4uX5xakK00sIZe+S4vaM
         54vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgrXiX6w+iXAJx451uKI5IvGXQ8JzxadwvN8II0tDoE=;
        b=nOT4+YnArzd9fCpjFKJZ+wW4nXtnRXSe2XZ3QFCSMIVYCKIRvknOMs+Qc1TxiAu71e
         9kU6huxnLJr5w6d7mvIoJ9tZAro7VwSfzY4FSGnpETsiXAn9bjDjJ2V6AwGDnyaZScWc
         Bixu4Qe2OUuoXfpP4SEOrrmhT1jkamzR7cfmoYF5CJDpQqxG2oWfx9hb45PzbzeTtMHT
         tz7hr6uYZB9Sg7UIiEce4OlO8mpw+400PPcvvvtSIZQxbaQHR7Udso5M0A3vu5IWg2NG
         GYceQMU9QFYdlrjSAJnPrIk83hLAh3l57a+Qr6qHuY1D/2NY3Dc7kqps0bojHLn2eNXi
         i2nA==
X-Gm-Message-State: APjAAAWdsMpKswuk7T+Az94DlkACGJiFs8Xl+9h8aDOwocS4+Q/H8pkz
        BOm3/rn9Nn7lHJq3QZ6g3IBI8XMOpmp5kjUBcncrKw==
X-Google-Smtp-Source: APXvYqyLXu8oCvZW+1b5S65SZDsQkreDEfq4D9XrqvMgvpefkLpjNcNf3isA6dhIzL9TGBYSa1flhyqbql93k4uReWk=
X-Received: by 2002:a65:690b:: with SMTP id s11mr573264pgq.10.1566942980152;
 Tue, 27 Aug 2019 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190827103621.1073-1-yamada.masahiro@socionext.com>
 <20190827192811.GA24626@archlinux-threadripper> <CAKwvOd=7Jf13PDC9Q1FMhZUJQsq7Ggn=wRz5xpRY0YrU6tP9Kw@mail.gmail.com>
 <20190827213447.GA26954@archlinux-threadripper>
In-Reply-To: <20190827213447.GA26954@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 14:56:07 -0700
Message-ID: <CAKwvOd=pQm7ytZSJeRzXoWwzouDADOYkO8S_+zSPtXOAO3Jc5g@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: enable unused-function warnings for W= build
 with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 2:34 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Aug 27, 2019 at 01:58:05PM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 27, 2019 at 12:28 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 07:36:21PM +0900, Masahiro Yamada wrote:
> > > > GCC and Clang have different policy for -Wunused-function; GCC never
> > > > reports unused-function warnings for 'static inline' functions whereas
> > > > Clang reports them if they are defined in source files instead of
> > > > included headers although it has been suppressed since commit
> > > > abb2ea7dfd82 ("compiler, clang: suppress warning for unused static
> > > > inline functions").
> > > >
> > > > We often miss to remove unused functions where 'static inline' is used
> > > > in .c files since there is no tool to detect them. Unused code remains
> > > > until somebody notices. For example, commit 075ddd75680f ("regulator:
> > > > core: remove unused rdev_get_supply()").
> > > >
> > > > Let's remove __maybe_unused from the inline macro to allow Clang to
> > > > start finding unused static inline functions. As always, it is not a
> > > > good idea to sprinkle warnings for the normal build, so I added
> > > > -Wno-unsued-function for no W= build.
> >
> > s/unsued/unused/
> >
> > > >
> > > > Per the documentation [1], -Wno-unused-function will also disable
> > > > -Wunneeded-internal-declaration, which can help find bugs like
> > > > commit 8289c4b6f2e5 ("platform/x86: mlx-platform: Properly use
> > > > mlxplat_mlxcpld_msn201x_items"). (pointed out by Nathan Chancellor)
> > > > I added -Wunneeded-internal-declaration to address it.
> > > >
> > > > If you contribute to code clean-up, please run "make CC=clang W=1"
> > > > and check -Wunused-function warnings. You will find lots of unused
> > > > functions.
> > > >
> > > > Some of them are false-positives because the call-sites are disabled
> > > > by #ifdef. I do not like to abuse the inline keyword for suppressing
> > > > unused-function warnings because it is intended to be a hint for the
> > > > compiler's optimization. I prefer __maybe_unused or #ifdef around the
> > > > definition.
> >
> > I'd say __maybe_unused for function parameters that are used depending
> > of ifdefs in the body of the function, otherwise strictly ifdefs.
> >
> > > >
> > > > [1]: https://clang.llvm.org/docs/DiagnosticsReference.html#wunused-function
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > I am still not a big fan of this as I think it weakens clang as a
> > > standalone compiler but the change itself looks good so if it is going
> > > in anyways:
> > >
> > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > I'm sure Nick would like to weigh in as well before this gets merged.
> >
> > So right away for an x86_64 defconfig w/ this patch, clang points out:
> >
> > drivers/gpu/drm/i915/i915_sw_fence.c:84:20: warning: unused function
> > 'debug_fence_init_onstack' [-Wunused-function]
> > static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
> >                    ^
> > drivers/gpu/drm/i915/i915_sw_fence.c:105:20: warning: unused function
> > 'debug_fence_free' [-Wunused-function]
> > static inline void debug_fence_free(struct i915_sw_fence *fence)
> >                    ^
> >
> > The first looks fishy (grep -r debug_fence_init_onstack), the second
> > only has a callsite ifdef CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS.
> >
> > drivers/gpu/drm/i915/intel_guc_submission.c:1117:20: warning: unused
> > function 'ctx_save_restore_disabled' [-Wunused-function]
> > static inline bool ctx_save_restore_disabled(struct intel_context *ce)
> >                    ^
> > drivers/gpu/drm/i915/display/intel_hdmi.c:1696:26: warning: unused
> > function 'intel_hdmi_hdcp2_protocol' [-Wunused-function]
> > enum hdcp_wired_protocol intel_hdmi_hdcp2_protocol(void)
> >                          ^
> > arm64 defconfig builds cleanly, same with arm.  Things might get more
> > hairy with all{yes|mod}config, but the existing things it finds don't
> > look insurmountable to me.  In fact, I'll file bugs in our issue
> > tracker (https://github.com/ClangBuiltLinux/linux/issues) for the
> > above.
> >
> > So I'm not certain this patch weakens existing checks.
>
> Well, we no longer get -Wunused-function warnings without W=1.
> Sometimes, that warning is just a result of missed clean up but there
> have been instances where it was a real bug:
>
> https://lore.kernel.org/lkml/20190523010235.GA105588@archlinux-epyc/
>
> https://lore.kernel.org/lkml/1558574945-19275-1-git-send-email-skomatineni@nvidia.com/
>
> Having warnings not be equal between compilers out of the box causes
> confusion and irritation: https://crbug.com/974884
>
> Is not the objective of ClangBuiltLinux to rely on GCC less?
>
> The only reason that we see the warnings crop up in i915 is because
> they add -Wall after all of the warnings get disabled (i.e.
> -Wno-unused-function -Wall so -Wunused-function gets enabled again).
>
> To get these warnings after this patch, W=1 has to be used and that
> results in a lot of extra warnings. x86_64 defconfig has one objtool
> warning right now, W=1 adds plenty more (from both -W flags and lack of
> kerneldoc annotations):
>
> https://gist.github.com/175afbca29ead14bd039ad46f4ab0ded
>
> This is just food for thought though.

So if we took just the hunk against include/linux/compiler_types.h
from this patch, we'd be back in a situation pre-commit-abb2ea7dfd82
("compiler, clang: suppress warning for unused static inline
functions").  Hmm...

I would like to minimize the number of Clang specific warnings that
are disabled in scripts/Makefile.extrawarn.

Masahiro, does your patch correctly make -Wunused-function work for
clang at W=1?  It looks like -Wunused gets added to warning-1, but
then -Wno-unused-function gets added to KBUILD_CFLAGS after `warning`
does.  Will that work correctly?  I'd imagine that at W=1,
KBUILD_CFLAGS for clang will look like:
... -Wunused -Wno-unused-function ...
which is probably not what we want?
-- 
Thanks,
~Nick Desaulniers
