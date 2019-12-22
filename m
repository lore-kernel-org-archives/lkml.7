Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64173C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 03:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2477D206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 03:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J//ypFVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLVDJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 22:09:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39797 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfLVDJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 22:09:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so17350691oty.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLxLMHWzhvsAyc7YSZ1UcqmlBwxpr3w938KiSSxaokg=;
        b=J//ypFVJPHCHhD3mOZb7/3Ti3EJCW6jmrc3PIdLwqX4nQxX4Lmwah28XNfXUoXIl0O
         xDwdR/qYwLFvn3mcvv10Q55wtQnb3Ar07tzDUwFHRbOf4aFJQQvzdG95mw2TD/YQm/3G
         zk9Mnu8tU8jZoAqdk+huPCtjYQz6MEBaRZ55aK96mAbIP77k7ff30hAdpwtW/cxmKa45
         Qdhbm0Pgklj6g2XvVUxY3+SWJU5L733Za8z3iE+LnFfEt/5PBD9IXUtkAtKwkiPEwY+W
         nPTYpq+XviR4cUR0S/KRpKrcmRwhGXN5pdVITJJ3Fn3ryv0dwEVfbk3CNcODs6toZHsz
         OeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLxLMHWzhvsAyc7YSZ1UcqmlBwxpr3w938KiSSxaokg=;
        b=OZs9HOA9EegqqUMV9vC+XhSGUwRiqZz6unBl2i/W+75WHZBKriwqNkd8P+ERR9sx8x
         s5qAAltgqMPl/0yaWGYr1pfQ/8odKQmz7NmbrD2VkDTyo8fBFKUaoYr4dWsN0MrUNo/T
         2EQkbty3IGzs3WbpJzENqbwaiIJ2gToZELhM8TbmMRHwl2aD9T88uk1R7xGNjN+8yhKD
         ygOGVZYMefuYCWloljlCVWueFC4S6n+ML4dR6rR/ClEUHeFhaExLdt5x2nR+QFwz4MRC
         JXonyWBVOw0iK1DLhLKU8PC1buuYBkB7zdg/b+NoJyjUVBEQBx+EA9DomA1RzhKMXZ3N
         SuyQ==
X-Gm-Message-State: APjAAAXDTNFpzilD+leCY39M2itbOjUpHcTKlZuaIquLyFVmc3Ow0CuD
        nx7UUcxYx/dj7yZqql0x5EfR7Sln
X-Google-Smtp-Source: APXvYqyH0YdvlwZOmLznIfhOeX/61Ru+3ctFbQQRQ5fYVPyH5b/V4PXFyQhY6hkOAQvp3okcFpPSfg==
X-Received: by 2002:a05:6830:1cd3:: with SMTP id p19mr8523090otg.70.1576984157645;
        Sat, 21 Dec 2019 19:09:17 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 47sm5494666otf.54.2019.12.21.19.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 19:09:16 -0800 (PST)
Date:   Sat, 21 Dec 2019 20:09:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
Message-ID: <20191222030915.GA27679@ubuntu-m2-xlarge-x86>
References: <20191123195321.41305-1-natechancellor@gmail.com>
 <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
 <CAKwvOdniXqn3xt3-W0Pqi-X1nWjJ2vUVofjCm1O-UPXZ7_4rXw@mail.gmail.com>
 <157538056769.7230.15356495786856166580@skylake-alporthouse-com>
 <CAKwvOd=ov789Lixdq8QE+MVXeYyh=W_sODSuj++4T8uF-hpVMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ov789Lixdq8QE+MVXeYyh=W_sODSuj++4T8uF-hpVMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:45:22AM -0800, Nick Desaulniers wrote:
> On Tue, Dec 3, 2019 at 5:42 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > Quoting Nick Desaulniers (2019-12-02 19:18:20)
> > > On Sat, Nov 23, 2019 at 12:05 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > >
> > > > Quoting Nathan Chancellor (2019-11-23 19:53:22)
> > > > > -Wtautological-compare was recently added to -Wall in LLVM, which
> > > > > exposed an if statement in i915 that is always false:
> > > > >
> > > > > ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > > > > result of comparison of constant 576460752303423487 with expression of
> > > > > type 'unsigned int' is always false
> > > > > [-Wtautological-constant-out-of-range-compare]
> > > > >         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > > > >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Since remain is an unsigned int, it can never be larger than UINT_MAX,
> > > > > which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
> > > > > Remove this statement to fix the warning.
> > > >
> > > > The check should remain as we do want to document the overflow
> > > > calculation, and it should represent the types used -- it's much easier
> > >
> > > What do you mean "represent the types used?"  Are you concerned that
> > > the type of drm_i915_gem_exec_object2->relocation_count might change
> > > in the future?
> >
> > We may want to change the restriction, yes.
> >
> > > > to review a stub than trying to find a missing overflow check. If the
> > > > overflow cannot happen as the types are wide enough, no problem, the
> > > > compiler can remove the known false branch.
> > >
> > > What overflow are you trying to protect against here?
> >
> > These values are under user control, our validation steps should be
> > clear and easy to check. If we have the types wrong, if the checks are
> > wrong, we need to fix them. If the code is removed because it can be
> > evaluated by the compiler to be redundant, it is much harder for us to
> > verify that we have tried to validate user input.
> >
> > > > Tautology here has a purpose for conveying information to the reader.
> > >
> > > Well leaving a warning unaddressed is also not a solution.  Either
> > > replace it with a comment or turn off the warning for your subdir.
> >
> > My personal preference would be to use a bunch of central macros for the
> > various type/kmalloc overflows, and have the warnings suppressed there
> > since they are very much about documenting user input validation.
> > -Chris
> 
> Is kmalloc_array what you're looking for?  Looks like it has the
> `check_mul_overflow` call in it.

I don't think kmalloc_array is right because we are not validating an
allocation. I am not sure that any of these overflow macros are correct,
we would probably need something new but I am not sure.

Cheers,
Nathan
