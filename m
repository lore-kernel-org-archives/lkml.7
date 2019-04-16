Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D38C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A343120656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfDPPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:21:16 -0400
Received: from foss.arm.com ([217.140.101.70]:57748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfDPPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:21:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E195615A2;
        Tue, 16 Apr 2019 08:21:15 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4233A3F59C;
        Tue, 16 Apr 2019 08:21:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 16:21:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ido Schimmel <idosch@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops.h: sanitize rotate primitives
Message-ID: <20190416152111.GC4187@fuggles.cambridge.arm.com>
References: <20190410211906.2190-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410211906.2190-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:19:06PM +0200, Rasmus Villemoes wrote:
> The ror32 implementation (word >> shift) | (word << (32 - shift) has
> undefined behaviour if shift is outside the [1, 31] range. Similarly
> for the 64 bit variants. Most callers pass a compile-time
> constant (naturally in that range), but there's an UBSAN report that
> these may actually be called with a shift count of 0.
> 
> Instead of special-casing that, we can make them DTRT for all values
> of shift while also avoiding UB. For some reason, this was already
> partly done for rol32 (which was well-defined for [0, 31]). gcc 8
> recognizes these patterns as rotates, so for example
> 
> __u32 rol32(__u32 word, unsigned int shift)
> {
> 	return (word << (shift & 31)) | (word >> ((-shift) & 31));
> }
> 
> compiles to
> 
> 0000000000000020 <rol32>:
>   20:   89 f8                   mov    %edi,%eax
>   22:   89 f1                   mov    %esi,%ecx
>   24:   d3 c0                   rol    %cl,%eax
>   26:   c3                      retq
> 
> Older compilers unfortunately do not do as well, but this only affects
> the small minority of users that don't pass constants.
> 
> Due to integer promotions, ro[lr]8 were already well-defined for
> shifts in [0, 8], and ro[lr]16 were mostly well-defined for shifts in
> [0, 16] (only mostly - u16 gets promoted to _signed_ int, so if bit 15
> is set, word << 16 is undefined). For consistency, update those as
> well.
> 
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/bitops.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

I guess it would be possible to roll some of this up into macros using
sizeof, but perhaps that would make things even more difficult for the
compiler.

Will
