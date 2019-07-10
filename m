Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F760C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562746525;
	bh=0hVSMMzYKhoDy/P2YBDNHPfBe2NC0mq8TrsMJzmaHwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqECb0DT4uNWQCODDTbBxyLmjtKs0XzdPqW5uT9aG8PKObYPDpVkaoUWfKtYSrWsR
	 ygeNrOUBYwKGA9T+6918bjTzODEA1L8DgYEwdA2Xc62mDysYnkiqFNRTdZhOi3DgkE
	 iFtS8O99AaZfb87kSNtPdUP+hyYGm/B7uGTKCvJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGJIPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfGJIPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:15:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B7620693;
        Wed, 10 Jul 2019 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562746522;
        bh=0hVSMMzYKhoDy/P2YBDNHPfBe2NC0mq8TrsMJzmaHwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmJZmlKlnaFfL5jmZfXyc1SwABp4fxxLEIH0I4NI0PTc9Jckm0hy/G292/9EH0ULM
         dyGiwnSKwxIjKWP40NPCTClD6HbFwyFD9KvJRovS6HODiUAZn0LmbCiq/Lu+ToImqD
         7du/8H2Z1tKHqbrjS7OhtuInc3rJLBFGwSQ66WGE=
Date:   Wed, 10 Jul 2019 09:15:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Laura Abbott <labbott@redhat.com>, yamada.masahiro@socionext.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
Message-ID: <20190710081515.ffghx4kouqpsh4m3@willie-the-truck>
References: <20190617104237.2082388-1-arnd@arndb.de>
 <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com>
 <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
 <20190617164553.GI30800@fuggles.cambridge.arm.com>
 <20190618120259.GA31041@fuggles.cambridge.arm.com>
 <CAK8P3a2NQSm3sPcJq=6=Espa5da_L+2RNtyS=jkkzD3tx-4ehA@mail.gmail.com>
 <95d721d1-2ccc-321c-f688-15e5bb53c30b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d721d1-2ccc-321c-f688-15e5bb53c30b@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura, [+Masahiro]

On Tue, Jul 09, 2019 at 03:06:49PM -0400, Laura Abbott wrote:
> On 6/18/19 10:15 AM, Arnd Bergmann wrote:
> > On Tue, Jun 18, 2019 at 2:03 PM Will Deacon <will.deacon@arm.com> wrote:
> > >  From 6e004b8824d4eb6a4e61cd794fbc3a761b50135b Mon Sep 17 00:00:00 2001
> > > From: Will Deacon <will.deacon@arm.com>
> > > Date: Tue, 18 Jun 2019 12:56:49 +0100
> > > Subject: [PATCH] genksyms: Teach parse about __uint128_t built-in type
> > > 
> > > __uint128_t crops up in a few files that export symbols to modules, so
> > > teach genksyms about it so that we don't end up skipping the CRC
> > > generation for some symbols due to the parser failing to spot them:
> > > 
> > >    | WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version
> > >    |          generation failed, symbol will not be versioned.
> > >    | ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against
> > >    |     `__crc_kernel_neon_begin' can not be used when making a shared
> > >    |     object
> > >    | ld: arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation:
> > >    |     unsupported relocation
> > > 
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > Looks good to me,
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I've added this to my randconfig build setup, replacing my earlier
> > patch, and will let you know if any problems with it remain.
> > 
> 
> I just hit this on 5ad18b2e60b75c7297a998dea702451d33a052ed on Linus'
> branch. The fix works for me (feel free to add Tested-by). Is this
> already queued up for Linus?

I think there's a fix queued via the kbuild tree:

https://lkml.kernel.org/r/CAK7LNAQRMnovWQA0F8A6mEqDjPxXOGM-1AHoyh1gQa367f+FqQ@mail.gmail.com

Will
