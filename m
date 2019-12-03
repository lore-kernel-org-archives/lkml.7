Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57A3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DCF2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNFVfbfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLCSpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:45:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38519 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:45:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so1865650pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bG8Nt6cVodf34zynBURXT0B9txwe3S1q7fxCr2Als+4=;
        b=XNFVfbfC7D0GHt+6f17UiXwk5O1VQiJ9OqACo8IuzMrbOpSouHNZB4OUQfjJ34Xjc7
         ijHp49f03VSRiLfBb6wCJS6WGBk0M+hgYqwBskCc0JbS8dxIy+TnmyPfKu+aTUSflR9G
         mHmeGQzJZZPgeOgdEIMR72fk0f199IwgQ9rlHrtEkKOVdnoiPC82tvtLNzTc7POPrOQ/
         DA5TI2WvOiHU7ExYS7VixDjB/pZ2HnpjLFGnydGmakwQ/RbVUIEEcx10+D9Oq6DgUO6o
         ySTQVf9t6dyl83TCX+3hhU4djYIBm58Pabp+js0rioH8HgwUy5ehHAskL7fHOT/wGHnJ
         SeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bG8Nt6cVodf34zynBURXT0B9txwe3S1q7fxCr2Als+4=;
        b=C+2JVFP7uhJnGlWxXPvds3O0batpy2Gro5mzdEhWiww2TWkFidGlZjh/VE/FPNaA1I
         By9S0EDd3xUMOAs0kSv/7AWD/NLoWwkGhllIqI5Jm7GOChH4H5LjtLcuEPHlQoRAx+l+
         k8lwhYve0pFyrasS8PsajIOiMbgT/CiJwjCCyEvAHSNnXVXa96K/CCtAjXnWweL8br8J
         VnKTUPyP9IhVUsuhBl7OMw03BE0QnjWuxpyWm2L9i5Nh1tZ3M1GmSH8wFHI/qn80accp
         K4J+O7XyzCAPBLqNGJapi0qr4UeYkNc0S3kw0ArMWHgHL+hshM1zPKk/xudI8rdJdair
         Dlog==
X-Gm-Message-State: APjAAAVv+MD7CriwnM0kUH3jgSNrLsJCA9DxiEP514moBQK4DdCVr8A+
        Vg4OW7oVGe9rlY7t24j7m/9yi1x3zJXHD5OaNN8BC6F5JMA=
X-Google-Smtp-Source: APXvYqyJSYetniu+3O10Y+swpRRlYVv6h/vvB7BpZkKQn3U4GNGfYC5OL6WuMn+ci7f92JAk5XdjkjrWgC9nKuqHGD0=
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr6052422plo.119.1575398733219;
 Tue, 03 Dec 2019 10:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20191123195321.41305-1-natechancellor@gmail.com>
 <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
 <CAKwvOdniXqn3xt3-W0Pqi-X1nWjJ2vUVofjCm1O-UPXZ7_4rXw@mail.gmail.com> <157538056769.7230.15356495786856166580@skylake-alporthouse-com>
In-Reply-To: <157538056769.7230.15356495786856166580@skylake-alporthouse-com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Dec 2019 10:45:22 -0800
Message-ID: <CAKwvOd=ov789Lixdq8QE+MVXeYyh=W_sODSuj++4T8uF-hpVMw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 5:42 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Nick Desaulniers (2019-12-02 19:18:20)
> > On Sat, Nov 23, 2019 at 12:05 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Nathan Chancellor (2019-11-23 19:53:22)
> > > > -Wtautological-compare was recently added to -Wall in LLVM, which
> > > > exposed an if statement in i915 that is always false:
> > > >
> > > > ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > > > result of comparison of constant 576460752303423487 with expression of
> > > > type 'unsigned int' is always false
> > > > [-Wtautological-constant-out-of-range-compare]
> > > >         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > > >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Since remain is an unsigned int, it can never be larger than UINT_MAX,
> > > > which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
> > > > Remove this statement to fix the warning.
> > >
> > > The check should remain as we do want to document the overflow
> > > calculation, and it should represent the types used -- it's much easier
> >
> > What do you mean "represent the types used?"  Are you concerned that
> > the type of drm_i915_gem_exec_object2->relocation_count might change
> > in the future?
>
> We may want to change the restriction, yes.
>
> > > to review a stub than trying to find a missing overflow check. If the
> > > overflow cannot happen as the types are wide enough, no problem, the
> > > compiler can remove the known false branch.
> >
> > What overflow are you trying to protect against here?
>
> These values are under user control, our validation steps should be
> clear and easy to check. If we have the types wrong, if the checks are
> wrong, we need to fix them. If the code is removed because it can be
> evaluated by the compiler to be redundant, it is much harder for us to
> verify that we have tried to validate user input.
>
> > > Tautology here has a purpose for conveying information to the reader.
> >
> > Well leaving a warning unaddressed is also not a solution.  Either
> > replace it with a comment or turn off the warning for your subdir.
>
> My personal preference would be to use a bunch of central macros for the
> various type/kmalloc overflows, and have the warnings suppressed there
> since they are very much about documenting user input validation.
> -Chris

Is kmalloc_array what you're looking for?  Looks like it has the
`check_mul_overflow` call in it.

-- 
Thanks,
~Nick Desaulniers
