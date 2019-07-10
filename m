Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9047C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC4620838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xnmpTU4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGJIty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:49:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20104 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:49:53 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x6A8nZdo002597
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 17:49:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x6A8nZdo002597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562748576;
        bh=gRr2ZHUsW0batlIlf8edBpkoC6M7UhDY2/Z2A5dF2Ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xnmpTU4IcXS6svt7Sp0VlAPV2kVqUlLzi5fdSVKo5ncwjrjfGnO31Y1/ry2qiq+MO
         HTyR8jI99t2xgBK3uaIKPqn9AIyBS6LHKT8WfBxtSGlUyMU4obiu0Z5C08IIjkhGCD
         w0cEV7UqVLUlCJxf47GlLed9hQHBPAe++3oqSKDFuy/tB9Am9g1wIT2EaMtH5Gx3Dt
         ryeIyD392ScrSRuIt0ndiHVW8qVdvkysXpEZCs6+3+VuezFHwrc5VzpUkXBTRnS3ZF
         oeuZ9UqN7otAP3nOwS4B6F4vSv8YJzr6ZXyROzHWimX8Ow2lAcEiQd2nCTweIKID5L
         53NYPatHHT9lQ==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id 190so983754vsf.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:49:35 -0700 (PDT)
X-Gm-Message-State: APjAAAV0ekKGAz2fU+SLtzefT4v5+zZDTurm2g98A/ZNtgKH8ORUGX3f
        DoeIv+CrOsaMRC5X7BTfuOymKuLOc0Xbj4rD6M8=
X-Google-Smtp-Source: APXvYqzFxzkXZ2NAx0kDLHL52rsFnvrI7eVB2fACWs44a57/zNDvmjzCiZgA+le0ZccJ22O59ldz9VzzgKa9qZwZZCU=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr16648858vsl.155.1562748574672;
 Wed, 10 Jul 2019 01:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190617104237.2082388-1-arnd@arndb.de> <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com> <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
 <20190617164553.GI30800@fuggles.cambridge.arm.com> <20190618120259.GA31041@fuggles.cambridge.arm.com>
 <CAK8P3a2NQSm3sPcJq=6=Espa5da_L+2RNtyS=jkkzD3tx-4ehA@mail.gmail.com>
 <95d721d1-2ccc-321c-f688-15e5bb53c30b@redhat.com> <20190710081515.ffghx4kouqpsh4m3@willie-the-truck>
In-Reply-To: <20190710081515.ffghx4kouqpsh4m3@willie-the-truck>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 17:48:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV6Txo-yKq+zSGiyts4cNdNwgXz0w4yFRMFJ3ozHcH7A@mail.gmail.com>
Message-ID: <CAK7LNASV6Txo-yKq+zSGiyts4cNdNwgXz0w4yFRMFJ3ozHcH7A@mail.gmail.com>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
To:     Will Deacon <will@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 5:15 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Laura, [+Masahiro]
>
> On Tue, Jul 09, 2019 at 03:06:49PM -0400, Laura Abbott wrote:
> > On 6/18/19 10:15 AM, Arnd Bergmann wrote:
> > > On Tue, Jun 18, 2019 at 2:03 PM Will Deacon <will.deacon@arm.com> wrote:
> > > >  From 6e004b8824d4eb6a4e61cd794fbc3a761b50135b Mon Sep 17 00:00:00 2001
> > > > From: Will Deacon <will.deacon@arm.com>
> > > > Date: Tue, 18 Jun 2019 12:56:49 +0100
> > > > Subject: [PATCH] genksyms: Teach parse about __uint128_t built-in type
> > > >
> > > > __uint128_t crops up in a few files that export symbols to modules, so
> > > > teach genksyms about it so that we don't end up skipping the CRC
> > > > generation for some symbols due to the parser failing to spot them:
> > > >
> > > >    | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
> > > >    |          generation failed, symbol will not be versioned.
> > > >    | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
> > > >    |     `__crc_kernel_neon_begin' can not be used when making a shared
> > > >    |     object
> > > >    | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
> > > >    |     unsupported relocation
> > > >
> > > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > >
> > > Looks good to me,
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I've added this to my randconfig build setup, replacing my earlier
> > > patch, and will let you know if any problems with it remain.
> > >
> >
> > I just hit this on 5ad18b2e60b75c7297a998dea702451d33a052ed on Linus'
> > branch. The fix works for me (feel free to add Tested-by). Is this
> > already queued up for Linus?
>
> I think there's a fix queued via the kbuild tree:
>
> https://lkml.kernel.org/r/CAK7LNAQRMnovWQA0F8A6mEqDjPxXOGM-1AHoyh1gQa367f+FqQ@mail.gmail.com
>
> Will


Yes, I will send a pull request shortly.



-- 
Best Regards
Masahiro Yamada
