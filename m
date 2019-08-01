Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA75206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfHAXOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:14:17 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:40226 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728834AbfHAXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:14:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3B420180A814E;
        Thu,  1 Aug 2019 23:14:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: baby46_24fe664d8034b
X-Filterd-Recvd-Size: 3608
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 23:14:14 +0000 (UTC)
Message-ID: <c7601163ffde2b14df520ae230746e6b75ecc2ee.camel@perches.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Date:   Thu, 01 Aug 2019 16:14:12 -0700
In-Reply-To: <20190801230358.4193-2-rikard.falkeborn@gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 01:03 +0200, Rikard Falkeborn wrote:
> GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> as the first argument and the low bit as the second argument. Mixing
> them will return a mask with zero bits set.
> 
> Recent commits show getting this wrong is not uncommon, see e.g.
> commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> macro").
> 
> To prevent such mistakes from appearing again, add compile time sanity
> checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> arguments are known at compile time, and the low bit is higher than the
> high bit, break the build to detect the mistake immediately.
> 
> Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> of __builtin_constant_p().
> 
> If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
> problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
> to unsigned long.
> 
> Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
> on the arguments passed to them, neither of them evaluate the expression
> unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
> expected.
> 
> Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> available in assembly") made the macros in linux/bits.h available in
> assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> compatible, disable the checks if the file is included in an asm file.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Changes in v2:
>   - Add comment about why inputs are not checked when used in asm file
>   - Use UL(0) instead of 0
>   - Extract mask creation in a separate macro to improve readability
>   - Use high and low instead of h and l (part of this was extracted to a
>     separate patch)
>   - Updated commit message
> 
> Joe Perches sent a series to fix the existing misuses of GENMASK() that
> needs to be merged before this to avoid build failures. Currently, 6 of
> the patches are not in Linus tree, and 2 are not in linux-next.

Thanks Rikard.

It wouldn't surprise me if this change finds more misuses
as the compiler will perform substitutions on #define
values where the search I did was just for decimal uses.

For instance, this new macro should build error on:

#define FOO	5
#define BAR	6

GENMASK(FOO, BAR)


