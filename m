Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFAFC71142
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779572084B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iJV8Nlbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfGMWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 18:46:04 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62678 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfGMWqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 18:46:04 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x6DMjqRg025768
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 07:45:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x6DMjqRg025768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563057953;
        bh=2B0eoRLN/QxxtkdUxZQChDJli/p9qNNDk0Cj2e0NbjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJV8NlbgLLyjOdQzd0WU/ngkle30sPGidPI+v/cHpJb+a98gMYjzra14tFnIARINi
         4R8oltWuz2SAJwU9zVVT831M6h1Fa7cGzpYgqBBM458I8Jos/WtK4rZZE5S0KmRA4N
         OZQlW9Eo8UFtw32EWHaKX8PXE+XVVMY137aXIzn3DbPtZe180SKtW86Rzddr3bxacJ
         bvq0UzNDU4UkbCRdhZx78YfB4s2bNUfOCmhuBmBt30A2MKbJaGDL3YTo6pJUo9729U
         Q+kaBM0j39W3ggCydF8NsqqT5OFHGH97TvylV+1JKMAduzZc15getcP/aCfZn3Fgw7
         SPZCgnz8dXRYQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id r3so8985358vsr.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 15:45:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVbF94CG8DfRomYcHTQb7sCx2Z0rc8km3MugeG7/s4BY18OMZLa
        LZP48kriZK0GGY6zWLPAK2KXV1OySwn9vtXv12Q=
X-Google-Smtp-Source: APXvYqwaJCYaD7FyOraVN43rm+oRFuRY8JwMqKhwH/pNANSe5RZmLraqehxV3P7wNjBNcpGqo917kKMd4l4gROBoMf4=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr12236102vsl.155.1563057951561;
 Sat, 13 Jul 2019 15:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org>
In-Reply-To: <20190713131642.GU14074@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 14 Jul 2019 07:45:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
Message-ID: <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 10:17 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Jul 13, 2019 at 07:47:44AM -0500, Segher Boessenkool wrote:
> > On Sat, Jul 13, 2019 at 12:21:06PM +0900, Masahiro Yamada wrote:
> > > The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
> > > in a useful way because it is always overridden by the following code
> > > in the top Makefile:
> > >
> > >   # use the deterministic mode of AR if available
> > >   KBUILD_ARFLAGS := $(call ar-option,D)
> > >
> > > The code in the top Makefile was added in 2011, by commit 40df759e2b9e
> > > ("kbuild: Fix build with binutils <= 2.19").
> > >
> > > The KBUILD_ARFLAGS addition for ppc has always been dead code from the
> > > beginning.
> >
> > That was added in 43c9127d94d6 to replace my 8995ac870273 from 2007.
> >
> > Is it no longer supported to build a 64-bit kernel with a toolchain
> > that defaults to 32-bit, or the other way around?  And with non-native
> > toolchains (this one didn't run on Linux, even).
>
> It was an --enable-targets=all toolchain, somewhat common for crosses,
> if that matters.


I always use the same toolchain
for compile-testing PPC32/64.

I have never been hit by the issue you mention.
Somebody would have reported it if it were still a problem.

Moreover, commit 43c9127d94d6
translated the environment variable "GNUTARGET"
into the command option "--target="

My powerpc-linux-ar does not know it:

powerpc-linux-ar: -t: No such file or directory




-- 
Best Regards
Masahiro Yamada
