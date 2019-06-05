Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4662C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0E62075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SeI7bF0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFEJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:02:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33750 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFEJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:02:00 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x5591lT9005012
        for <linux-kernel@vger.kernel.org>; Wed, 5 Jun 2019 18:01:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x5591lT9005012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559725310;
        bh=4heQMOeUYxMT3vJUuhyF+RiSNQYhKDyB7w/dctvl+6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SeI7bF0L1HMB9F7KCilotuNHnv6pAioBe2+XH9Wot6g3YTSYtxcXsgGs9wTnofC7F
         6X82w/+oQEUy/Pw9qRwu425DyqOkivFKHjcmREbVm5h4r4uHFMVqCH6fn0brIwQZ1s
         TcRUCieJT+TcxLo557uJHEFg4ZLxi0KChwSxPMc9522Jquf0Rn8shMN8/Pq454faGc
         5PpP0oj43dLvVfzYn2z2s7cUBDoYTq3ULOyqQdXezk2cI/iujdYj0s6LeXuaqmRijV
         9qoGOFEFHPMx3eDyddYtimoLAHMBjitMuFmkoS3WjYHUSRarVtQE4YcEXZQma1vFpo
         BKzGifODKgDZA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id d128so15227850vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 02:01:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWVOUhk2kXtGlWUyxH1IMv6kKW32Tz7AKmJf7sgqRYZK3S51dEk
        YcHidyxDmUcRqeXAe1nKqPuMhlSUojbxPw7h+P4=
X-Google-Smtp-Source: APXvYqzeIRg6colne+y2aqfBRfPeHx02Mun1CpteDFhWzEa2w0ohGhvri+gUFERzTepayGbUr6HKEcJgKfnX9xi06VY=
X-Received: by 2002:a67:7fcc:: with SMTP id a195mr443645vsd.181.1559725306637;
 Wed, 05 Jun 2019 02:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190527083412.26651-1-yamada.masahiro@socionext.com> <20190605073406.geesp3rbrxajmac6@mbp>
In-Reply-To: <20190605073406.geesp3rbrxajmac6@mbp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Jun 2019 18:01:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJPMsRtNRYUH+dib0ZMAPqOe5HO0UcAW7zRdjyWWyQWQ@mail.gmail.com>
Message-ID: <CAK7LNAQJPMsRtNRYUH+dib0ZMAPqOe5HO0UcAW7zRdjyWWyQWQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow assembly code to use BIT(), GENMASK(), etc. and
 clean-up arm64 header
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 4:36 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, May 27, 2019 at 05:34:10PM +0900, Masahiro Yamada wrote:
> > Some in-kernel headers use _BITUL() instead of BIT().
> >
> >  arch/arm64/include/asm/sysreg.h
> >  arch/s390/include/asm/*.h
> >
> > I think the reason is because BIT() is currently not available
> > in assembly. It hard-codes 1UL, which is not available in assembly.
> [...]
> > Masahiro Yamada (2):
> >   linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
> >   arm64: replace _BITUL() with BIT()
> >
> >  arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
> >  include/linux/bits.h            | 17 ++++---
>
> I'm not sure it's worth the hassle. It's nice to have the same BIT macro
> but a quick grep shows arc, arm64, s390 and x86 using _BITUL. Maybe a
> tree-wide clean-up would be more appropriate.


I am happy to clean-up the others
in the next development cycle
once 1/2 lands in the mainline.


Since there is no subsystem that
takes care of include/linux/bits.h,
I just asked Will to pick up both.
I planed per-arch patch submission
to reduce the possibility of merge conflict.


If you guys are not willing to pick up them,
is it better to send treewide conversion to Andrew?


-- 
Best Regards
Masahiro Yamada
