Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D6FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB1D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfFRQVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:21:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfFRQVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0E0CFC;
        Tue, 18 Jun 2019 09:21:02 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3A563F246;
        Tue, 18 Jun 2019 09:21:01 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:20:21 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] genksyms: Teach parser about 128-bit built-in types
Message-ID: <20190618162021.GA4270@fuggles.cambridge.arm.com>
References: <20190618131048.543-1-will.deacon@arm.com>
 <CAK8P3a3phkiL8LFQM_AewMCE0EpQaCTOmgkVJe4x9oV84F4_7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3phkiL8LFQM_AewMCE0EpQaCTOmgkVJe4x9oV84F4_7g@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jun 18, 2019 at 04:17:35PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 18, 2019 at 3:10 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > +       { "__int128", BUILTIN_INT_KEYW },
> > +       { "__int128_t", BUILTIN_INT_KEYW },
> > +       { "__uint128_t", BUILTIN_INT_KEYW },
> 
> I wonder if it's safe to treat them as the same type, since
> __int128_t and __uint128_t differ in signedness.
> 
> If someone exports a symbol with one and changes it to the other, they
> would appear to be the same type.

My understanding is that the actual CRC generation for normal symbols is
based purely on the string-representation of the function signature, and
so the underlying type information isn't relevant to that. I can also
confirm that the CRC for an exported symbol that returns a __uint128_t
is not the same if you change it to return a __int128_t instead.

Will
