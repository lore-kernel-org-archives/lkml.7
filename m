Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F639206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XT+Q14K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfDWXAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:00:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33525 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWXAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:00:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so8236168pfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNNYz6XkknHCgdqnTmfxU2vJobB46xH4YOiKMilZ1ts=;
        b=XT+Q14K6KmmMErBkCEWC6sr1yX8+jnzr5QaTsDcZwWBoWgX3tzgsFxNPmy+ZyzEu6l
         onZG8+RiAg9QOsSlaUNxWHaBG7zkIxYn4jDuPnCow2UKLs933xapLO9KjVx3d+CliVAk
         JQ1YSrERAbvXAe73qlpQI7vOANyPqgr20nhGX+7RdNRnKJAvnbmYnidr8vXuCkck0R/V
         hI2Ghbe9wlnJu+bknjODaMWEbh9C0RJPV686D64yNfquwIIRIojv2eYnbdHmMz6KANMy
         b2Nh5r0R7YRXLBwZ8WZimab5Dvs2LvsUunW//sgydR20BYw8uNAlweo9BEs9CzxAjJpF
         XdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNNYz6XkknHCgdqnTmfxU2vJobB46xH4YOiKMilZ1ts=;
        b=jZ4VAVWzx7yjw5ePxbjLnPVnItclyQ3Y5HXPuqs5ys8MKdSEQ7cCoURXLZ/OFfGv+z
         6uUGdhUbZsQQ6S6s/giCNpzDElLjl2MR4vs1ojVkaZBdGPv7WHtokB1xfqb2tCk7z72B
         Z6bDYhMwvVpNqAyPP4QRoRu7UWAgjNG85vFy6AJR/gKHVA7wAHFKBdnJXXuH9msgykYy
         4fE0ZX2p9qFUam6o7G8h/QpWPMODe4fuxOop3ydmrs8N2EclqzBWumyvjc5lO4un2BzY
         8PbPx500cXqezjDDkGxMYhZaRoxMJEiQFM4+bTB6rYrHiWeIreZs4JIShvznbYwvdtJI
         9fMg==
X-Gm-Message-State: APjAAAW6HtMAezvPelfBC86rU4mX1YL5nPCvYQ478x7KqMjBgo1NzKkl
        2Dw724IQQJB+te4t6E1efrLwMPxMTr8L6KdJ6UKj3g==
X-Google-Smtp-Source: APXvYqx9Gj/GOsmPDmr961Kt84xSE2MVUd0Irm2KemVHpolDUOyuW+FLAKkLBZVyr+HwYRfiWMdTmLShInUozlzB1Ro=
X-Received: by 2002:a62:19ca:: with SMTP id 193mr1832054pfz.227.1556060406351;
 Tue, 23 Apr 2019 16:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
 <CAKv+Gu-ZxvK7L90Xkf=U=GEeucGg9qJ+TDabuguFCxeUbn_GeQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-ZxvK7L90Xkf=U=GEeucGg9qJ+TDabuguFCxeUbn_GeQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Apr 2019 15:59:54 -0700
Message-ID: <CAKwvOdn3DA9HbtQ7ZAXeamdmoRn+_kYn2DdQXX9oxt+nruz0kw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:57 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 24 Apr 2019 at 00:55, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Apr 15, 2019 at 7:38 AM Kees Cook <keescook@chromium.org> wrote:
> > > +#define __msr_s(r, v)                                          \
> > > +       DEFINE_MSR_S                                            \
> > > +"      msr_s " __stringify(r) ", %x0\n"                        \
> > > +       UNDEFINE_MSR_S : : "rZ" (v)
> >
> > BTW ... is "%x0" a typo here? Shouldn't this just be "%0"?
> >
>
> No, iirc, that is required to force clang to choose a x# encoding
> (which is the only one supported by msr/mrs instructions). Otherwise,
> it will infer from the operand size which encoding to use, and attempt
> to use w# for 32-bit system registers.

Yes: https://github.com/llvm/llvm-project/blob/80b578c7325352187d0aff7bd2bdb5a76b51cf37/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp#L466

-- 
Thanks,
~Nick Desaulniers
