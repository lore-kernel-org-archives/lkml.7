Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84560C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9A8214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofPd/sJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfLBTSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:18:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37997 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:18:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so146807pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG/LZstzo//ptLVf07PatyOsdS+AHHPAwpIXLlE6z3Q=;
        b=ofPd/sJG1S0B0dPuZvEuwVEnta6pLrb2ze2cDFyASH+9cicpvVoSXin1a28KC1uw+8
         A1zEeq6ZSTIb+mv4SqffAInNcaih6mMYQdKn3P1tWDJYo81FPRS1fLZrzho/xgiDm8SC
         YOhQaxeWaQnX+pq28UmTQjVjcOGSrcQztu3QcM0dLbmS4HkmH+6+uaSnhPZ6QyM+Kpuf
         O25gQvWrczJ6AQNj+mOf5ExZdJtaFVULHquVeMHHBeZDHdeLWb9dMIctEZvYFV8oR3cs
         kRT1gazLrRcIoDGasBeKRreFz2tyPPID3Ya/K80xcDHhS1E1QjS4D+HGae5pA+TeVSCn
         E3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG/LZstzo//ptLVf07PatyOsdS+AHHPAwpIXLlE6z3Q=;
        b=ksxcrKOuludJHGOxAT5BbrWL33IW3h+Dm+vBPzlpfVas53Gvgsatc0A4To1P0k6vrl
         VGSpW9cLJUCgb2yNbcIib6awK8KTr+JKoqvwrprc1zbB3FzMa0XBRLxgIgL85hWCkhPV
         rm8ucl+foPhar3YNpo5wRg/kk79FI2ASyVGjlVFDn1LfZVkw70f7EnLs+ZnIl9d+qgED
         6jtO3eVqkPgh1ttFQfizZ+U5Z7aYQB/MUQzi2OLZZFMYvtLe0Uqqg1VZx21gC5p4bout
         LyF0ZWg6pa7lVhVgCFv2OmIu+9zx7/iAnbw6RtXeZsk2y8+Ffnk7x4IFRQP2H/SwMWva
         +vvQ==
X-Gm-Message-State: APjAAAUYp3x61j8zd15gu0Oj7o9kkaydpdXW352TxfDXRhoYK9e7xklG
        ux24+inedzog8WNWd1w5+FWFN9qzAtVx34tYgT/Smw==
X-Google-Smtp-Source: APXvYqx4981BLNDeOn62kzvLoj/j1kEDcJo+0UePcbQi+8VI03sKun8IkhkPLZsWMAv1Pcyofy6UuuetlJSBs1CKAcU=
X-Received: by 2002:a65:64c1:: with SMTP id t1mr677588pgv.263.1575314311159;
 Mon, 02 Dec 2019 11:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20191123195321.41305-1-natechancellor@gmail.com> <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
In-Reply-To: <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Dec 2019 11:18:20 -0800
Message-ID: <CAKwvOdniXqn3xt3-W0Pqi-X1nWjJ2vUVofjCm1O-UPXZ7_4rXw@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:05 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Nathan Chancellor (2019-11-23 19:53:22)
> > -Wtautological-compare was recently added to -Wall in LLVM, which
> > exposed an if statement in i915 that is always false:
> >
> > ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > result of comparison of constant 576460752303423487 with expression of
> > type 'unsigned int' is always false
> > [-Wtautological-constant-out-of-range-compare]
> >         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >
> > Since remain is an unsigned int, it can never be larger than UINT_MAX,
> > which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
> > Remove this statement to fix the warning.
>
> The check should remain as we do want to document the overflow
> calculation, and it should represent the types used -- it's much easier

What do you mean "represent the types used?"  Are you concerned that
the type of drm_i915_gem_exec_object2->relocation_count might change
in the future?

> to review a stub than trying to find a missing overflow check. If the
> overflow cannot happen as the types are wide enough, no problem, the
> compiler can remove the known false branch.

What overflow are you trying to protect against here?

>
> Tautology here has a purpose for conveying information to the reader.

Well leaving a warning unaddressed is also not a solution.  Either
replace it with a comment or turn off the warning for your subdir.

The warning here looks valid to me; you have a guard for something
that's impossible.
-- 
Thanks,
~Nick Desaulniers
