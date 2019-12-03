Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C347C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B412073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLCNm4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:42:56 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52688 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbfLCNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:42:56 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19443048-1500050 
        for multiple; Tue, 03 Dec 2019 13:42:48 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Nick Desaulniers <ndesaulniers@google.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAKwvOdniXqn3xt3-W0Pqi-X1nWjJ2vUVofjCm1O-UPXZ7_4rXw@mail.gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20191123195321.41305-1-natechancellor@gmail.com>
 <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
 <CAKwvOdniXqn3xt3-W0Pqi-X1nWjJ2vUVofjCm1O-UPXZ7_4rXw@mail.gmail.com>
Message-ID: <157538056769.7230.15356495786856166580@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
Date:   Tue, 03 Dec 2019 13:42:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Desaulniers (2019-12-02 19:18:20)
> On Sat, Nov 23, 2019 at 12:05 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > Quoting Nathan Chancellor (2019-11-23 19:53:22)
> > > -Wtautological-compare was recently added to -Wall in LLVM, which
> > > exposed an if statement in i915 that is always false:
> > >
> > > ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > > result of comparison of constant 576460752303423487 with expression of
> > > type 'unsigned int' is always false
> > > [-Wtautological-constant-out-of-range-compare]
> > >         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > >
> > > Since remain is an unsigned int, it can never be larger than UINT_MAX,
> > > which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
> > > Remove this statement to fix the warning.
> >
> > The check should remain as we do want to document the overflow
> > calculation, and it should represent the types used -- it's much easier
> 
> What do you mean "represent the types used?"  Are you concerned that
> the type of drm_i915_gem_exec_object2->relocation_count might change
> in the future?

We may want to change the restriction, yes.
 
> > to review a stub than trying to find a missing overflow check. If the
> > overflow cannot happen as the types are wide enough, no problem, the
> > compiler can remove the known false branch.
> 
> What overflow are you trying to protect against here?

These values are under user control, our validation steps should be
clear and easy to check. If we have the types wrong, if the checks are
wrong, we need to fix them. If the code is removed because it can be
evaluated by the compiler to be redundant, it is much harder for us to
verify that we have tried to validate user input.

> > Tautology here has a purpose for conveying information to the reader.
> 
> Well leaving a warning unaddressed is also not a solution.  Either
> replace it with a comment or turn off the warning for your subdir.

My personal preference would be to use a bunch of central macros for the
various type/kmalloc overflows, and have the warnings suppressed there
since they are very much about documenting user input validation.
-Chris
