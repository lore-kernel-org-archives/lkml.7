Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E7CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0BB2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTUTQ4ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfJUGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:12:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44265 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:12:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so12353753wrl.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azBxEHDWCdsU7wz/faY/PPe9l3d9cjGBlYkkkxlsXNw=;
        b=qTUTQ4ZTdm9DHInhDE6X3VmBqT/KyH/eg44Ie2ZyppNJ+Mq7Gzf0scMCqvZQU3nPkq
         9RuuuXt9ohJ5GGZ8h2flwhyvHo+h+mwCU3HJf+NkGF1ALj5/Q88VB5OWwPcY/IliqH+l
         L56F8Nihrbg51/Fsns1XWsTOeLYFw3fUNOlGzbLGBm3uO+epkCWsGR+NC1kxNQYUTroR
         SzEk6Ha++yb8a85i+5pTuUxz2bAL3RQbU/K5HeDKEBB8dlhFE55Qgv18UJrCUJZZh8vr
         uJ/G08ebShEM/n6IRWP8xr4T4msq/l2sffgnnJdXZSAWT/ipDYKo74mYhYFdnpTIOzIk
         VfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azBxEHDWCdsU7wz/faY/PPe9l3d9cjGBlYkkkxlsXNw=;
        b=Mbj1qhwesKYNxUs8PbjZqZptqVM1mqCiFvtv9GJquQri9LKesEHucNw4Ny5180XusH
         Eg5O7rCLh/tsJcQkP/5UrLdWZ/kYSThxorKKV88tJ/N2E0MAb7dCvvzlubDSjb81Gp7F
         /vCa6gabhC4r3Zk+f4A/vrfPXOngbTizOCXabJ42+DJeeSKRslD+eTEBzC4aH5KkHIO5
         XB8/B/ZXGvxgdb5fPktNqFoLnILIfU+Vjxv17Wgf3tXHNQEzIZl8At0H1QJ9zYWq4T4f
         jcX7ldgN/bB7IntPsPHvA1xIe0MgcG/EVts6TIirLvWvvXyc7evSvP40HDme6h/ohjB5
         kFMQ==
X-Gm-Message-State: APjAAAVyr4cjTmOOHrIP4kRQ3N6dEh24uto04cxT2jCeY6aNCq7p2Zk/
        IBVjFrWFHMjoMh4xdwiAz65Va++Jv1B95pAFBrje50tQ7qs=
X-Google-Smtp-Source: APXvYqxnJb93TF5nD3jcoXnbupalitg5Dj+VYy2V93E3Z3QMw/jysu5nCOppGEaOWgZsmIzV8081S3I2H2bbczBjiHs=
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr17063430wrw.32.1571638357257;
 Sun, 20 Oct 2019 23:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-6-samitolvanen@google.com> <CAKwvOd=SZ+f6hiLb3_-jytcKMPDZ77otFzNDvbwpOSsNMnifSg@mail.gmail.com>
 <CABCJKuf1cTHqvAC2hyCWjQbNEdGjx8dtfHGWwEvrEWzv+f7vZg@mail.gmail.com>
In-Reply-To: <CABCJKuf1cTHqvAC2hyCWjQbNEdGjx8dtfHGWwEvrEWzv+f7vZg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Oct 2019 08:12:26 +0200
Message-ID: <CAKv+Gu92eR81+W1iXOXZHWgub-fNPcKaa+NCpGS_Yy4K4=7t+Q@mail.gmail.com>
Subject: Re: [PATCH 05/18] arm64: kbuild: reserve reg x18 from general
 allocation by the compiler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 21:00, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Fri, Oct 18, 2019 at 10:32 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > > and remove the mention from
> > > the LL/SC compiler flag override.
> >
> > was that cut/dropped from this patch?
> >
> > >
> > > Link: https://patchwork.kernel.org/patch/9836881/
> >
> > ^ Looks like it. Maybe it doesn't matter, but if sending a V2, maybe
> > the commit message to be updated?
>
> True. The original patch is from 2017 and the relevant part of
> arm64/lib/Makefile no longer exists. I'll update this accordingly.
>
> > I like how this does not conditionally reserve it based on the CONFIG
> > for SCS.  Hopefully later patches don't wrap it, but I haven't looked
> > through all of them yet.
>
> In a later patch x18 is only reserved with SCS. I'm fine with dropping
> that patch and reserving it always, but wouldn't mind hearing thoughts
> from the maintainers about this first.
>

Why would you reserve x18 if SCS is disabled? Given that this is a
choice that is made at code generation time, there is no justification
for always reserving it, since it will never be used for anything. (Of
course, this applies to generated code only - .S files should simply
be updated to avoid x18 altogether)

Also, please combine this patch with the one that reserves it
conditionally, no point in having both in the same series.
