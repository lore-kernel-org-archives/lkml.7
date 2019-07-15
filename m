Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D88FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD94120868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="w00yTOzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfGOMEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:04:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48525 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfGOMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:04:47 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6FC4NmB010439
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 21:04:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6FC4NmB010439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563192264;
        bh=7Onnwj4Aol7vBEfdqH7wYkCIRDkp83Cer5+EmKQdOFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w00yTOzIaj5vl2FtI+QcSJXcMye06NqSFvXFLwxK6Xa5KcQPEG/PP3Kqv0UoFuuX+
         y12fzYi1JP/P8qGSihacuSJ6KEvFmiIp76xAtOUCxidESiXiqWy1MHGbchMGlZVciU
         hdfOOz/NSNlV/Uh7QxM8iROXSzRF8uMWxEJTGx0BO1LCR7G1AENoJx4Pv1c3fZYgpf
         UQKK8Mp52j3xI+Xer660ENag//H+hmP/BNbAPaosbDTgL6epk8+OK44rt7KE7/t/6y
         WFLXdA51u/LWT8zTQnGVh8fPD6v/FgmcwQ7TBuG7Okv4pNMYYnAjgMMVoJKHIML2EU
         A/1mh4sdcHKnQ==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id 190so11143053vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 05:04:23 -0700 (PDT)
X-Gm-Message-State: APjAAAUwOQxY0auZIwdAPX0W0fCSVx6YItK4tXXCbfP9vXRe6rdrf5jW
        00nfHpiJjnRIJf63bvLopWEIeKTJeXDTNi1iPrQ=
X-Google-Smtp-Source: APXvYqyfxSL5TnyJM5fr7O8sQTCclOIa1SfvEyoOE8HnRW8P/3ts/cp1Og/3hK/v5vJ9PY5O3OefkCqQJGfEon2W6l8=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr15874928vsq.179.1563192262732;
 Mon, 15 Jul 2019 05:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org>
In-Reply-To: <20190715072959.GB20882@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Jul 2019 21:03:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGEK9wxz87J3sTNOYPdtAFXaegQU9EctEBGULQL-ZC4w@mail.gmail.com>
Message-ID: <CAK7LNATGEK9wxz87J3sTNOYPdtAFXaegQU9EctEBGULQL-ZC4w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 4:30 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Jul 15, 2019 at 05:05:34PM +1000, Michael Ellerman wrote:
> > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > > Yes, that is why I used the environment variable, all binutils work
> > > with that.  There was no --target option in GNU ar before 2.22.

I use binutils 2.30
It does not understand --target option.

$ powerpc-linux-ar --version
GNU ar (GNU Binutils) 2.30
Copyright (C) 2018 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later version.
This program has absolutely no warranty.

If I give --target=elf$(BITS)-$(GNUTARGET) option, I see this:
powerpc-linux-ar: -t: No such file or directory



> > Yeah, we're not very good at testing with really old binutils, so I
> > guess we broke that.
> >
> > I'm inclined to merge this, it doesn't seem to break anything, and it
> > fixes using --target on old binutils that don't have it.
>
> But we don't set the target any other way either.  I don't think this
> will work with a 32-bit toolchain (default target 32 bit) and a 64-bit
> kernel, or the other way around.
>
> Then again, does that work at *all* nowadays?  Do we even consider that
> important, *should* it work?


Let me confirm if I understood this discussion.


[1] KBUILD_ARFLAGS += --target=elf$(BITS)-$(GNUTARGET)
    is pointless since it is always overridden by another
    KBUILD_ARFLAGS assignment.

[2] If we stop overriding it, it would cause build errors.
    So, --target is not only useless, but it is rather harmful.


So, we all agreed with this patch, right?


We are discussing whether or not to revive
GNUTARGET=elf$(BITS)-$(GNUTARGET)
in a *separate* patch, correct?


-- 
Best Regards
Masahiro Yamada
