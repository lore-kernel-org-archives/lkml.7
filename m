Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FFC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C12073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfLDNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:31:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfLDNa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:30:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47Sfqz4ZrXz9sRK; Thu,  5 Dec 2019 00:30:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 552263456215ada7ee8700ce022d12b0cffe4802
In-Reply-To: <a55eca3a5e85233838c2349783bcb5164dae1d09.1575273217.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 3/8] powerpc: Fix vDSO clock_getres()
Message-Id: <47Sfqz4ZrXz9sRK@ozlabs.org>
Date:   Thu,  5 Dec 2019 00:30:55 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-02 at 07:57:29 UTC, Christophe Leroy wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>     sec = 0;
>     ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the powerpc vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support
> to 32 bits kernel")
> Cc: stable@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> [chleroy: changed CLOCK_REALTIME_RES to CLOCK_HRTIMER_RES]
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/552263456215ada7ee8700ce022d12b0cffe4802

cheers
