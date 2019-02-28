Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42171C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20103218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbfB1Rrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:47:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732473AbfB1Rrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:47:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F9AEBD;
        Thu, 28 Feb 2019 09:47:32 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26A7A3F720;
        Thu, 28 Feb 2019 09:47:31 -0800 (PST)
Date:   Thu, 28 Feb 2019 17:47:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ndesaulniers@google.com
Cc:     will.deacon@arm.com, ard.biesheuvel@linaro.org, arnd@arndb.de,
        broonie@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
Message-ID: <20190228174728.GE226495@arrakis.emea.arm.com>
References: <20190226040345.202047-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226040345.202047-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:03:42PM -0800, ndesaulniers@google.com wrote:
> Clang warns: vector initializers are not compatible with NEON intrinsics
> in big endian mode [-Wnonportable-vector-initialization]
> 
> While this is usually the case, it's not an issue for this case since
> we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> 
> Instead, use vdupq_n_u8 which both compilers lower into a single movi
> instruction: https://godbolt.org/z/vBrgzt
> 
> This avoids the static storage for a constant value.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/214
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  lib/raid6/neon.uc            | 5 ++---
>  lib/raid6/recov_neon_inner.c | 7 ++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Queued for 5.1. Thanks.

-- 
Catalin
