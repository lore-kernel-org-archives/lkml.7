Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD57C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651B62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXybgiMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbfFYSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:16:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40260 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbfFYSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:16:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so9338487pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQ8aR9MobAP+iL+tI1Q5J82/P3Cfcmmw4MFyUaY/emA=;
        b=SXybgiMd9XIBVJ2AWLaaO0jtvlKzKjrHVt4nNUuRDbIM7p3aoZNnNWCYt6JNyFAfkh
         tPBG73373keGsnRIury4Ny2gnTYnDu8OzmZx5voq5S2z+js8T6vvVRWZHsfD3HsLR95C
         3ZGlVyj6PBlqxJkBOlMXNmDHm0YloTx6wlUXxfcjm5SWg85GcUZAzVv2O/6lOHpPBwWw
         J/4SJFmKuac3h8x79erjI2NoQ8RXSW94sIccryQnX93NOPF6RB5pbsmXlFopgwm3ODWE
         yP8YZMIzB3FCu9tlbGbuxtRV4Zcy1/vaxpsAvSUABUFxSs0ZlHl4tdCuQW4OfZSpvM5f
         DSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ8aR9MobAP+iL+tI1Q5J82/P3Cfcmmw4MFyUaY/emA=;
        b=UvpJtgM22QE9lq4Xk7fjrykdnYU8LuTbjHrNTqV/tHhhtXCYsGU/po+Pl3kjw26KF1
         eMk3L5jh1hr2PHx1J3Eb+XlUHFOXrEP0m7VcbZga/e94geYqS2wYYgTcGApnaP42oPKO
         cV2/qZqRLfxLnvDrjkghCv52ewwB0cZPYeF7pK+h5bvN6mtnl88SQm49lscQDHws+bKl
         JRRJXx9F+mHRMBo1/4mtEtVhcMaYM5LvbdgnlKFxgC9OF0fNzmPxPRGeNM0+1tz91a13
         mju00J3JgUgMEYB3X5nIAeHEqhqGIlWpFW0e2SJiB2G1bPVrBl9HBcZ8BObeSGaOUmFu
         hdIQ==
X-Gm-Message-State: APjAAAXlMSySmdW/zMB37IXRlKkBs/YcBThwGkJCEMcAw88D55Z5oSMw
        ezgS77obaLlBUY994thGdhzRAQS3a6qxTGQgDJnzYw==
X-Google-Smtp-Source: APXvYqw51vig9H43plN4+D7JdrUK8SF7YWi34lTbu1iG44vuXV1cwsMGq7qeotui/oTYnybix35A27rcoQtXzQXEOfA=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr178357pjq.134.1561486568901;
 Tue, 25 Jun 2019 11:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
In-Reply-To: <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 11:15:57 -0700
Message-ID: <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
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
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 5:47 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jun 25, 2019 at 9:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Can it build a kernel without patches yet? That is, why should I care
> > what LLVM does?

Unreleased versions of Clang built from source can; the latest release
of Clang-8 doesn't have asm goto support required for
CONFIG_JUMP_LABEL.  Things can get complicated based on which kernel
tree/branch (mainline, -next, stable), arch, and configs, but I think
we just have a few long tail bugs left.

We're currently planning multiple output constraint support w/ asm
goto, and have recently implemented things like
__GCC_ASM_FLAG_OUTPUTS__.  If there's other features that we should
start implementing, please let us know.

Give it a shot and let us know what works or doesn't.

For more info, see our
site: https://clangbuiltlinux.github.io/
CI: https://travis-ci.com/ClangBuiltLinux/continuous-integration
Bug tracker: https://github.com/ClangBuiltLinux/linux/issues
wiki: https://github.com/ClangBuiltLinux/linux/wiki

Or reach out to us via
email: clang-built-linux@googlegroups.com
irc: #clangbuiltlinux on chat.freenode.net
or attend our public bi-weekly (once ever 2 weeks, not twice a week) meeting

>
> Having more than a single compiler is always a good idea. You benefit
> from more warnings, more tooling, a second implementation for
> reference/comparison, etc.
>
> As for what is the current state, I think they are close, specially
> for aarch64, but I let Nick, Nathan et. al. answer that! :-) (Cc'd).
> They had a talk in FOSDEM 2019 about it, too.
>
> Also CC'ing Luc since he changed sparse to stop ignoring the attribute
> so that __has_attribute() would work, but I am not sure if there has
> been further work on supporting it properly.
>
> > > Also note that C2x may get [[fallthrough]]. See N2267 and N2335. At
> > > that point, surely tools/IDEs/analyzers will support it :-) The
> > > question is whether we want to wait that long to replace the comments.
> >
> > #define __fallthrough [[fallthrough]]
> >
> > right?
>
> Yes and no. The exact spelling we use does not matter much. My point
> with that paragraph was that since C2x will (maybe) add fallthrough,
> as C++17 did, every compiler/analyzer/IDE/etc. that is still missing
> support for it will have to eventually add it even if they ignore GNU
> attributes. At that point, I would guess most will likely add all
> spellings too.

Regarding __attribute__((fallthrough)), it's currently a work in
progress in Clang:
https://bugs.llvm.org/show_bug.cgi?id=37135
https://reviews.llvm.org/D63260

-- 
Thanks,
~Nick Desaulniers
