Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B4C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C9B2087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564999265;
	bh=rXRs98rcvgGFy2+Yx+06Sk5a077Kv9Ajpn2E+APiZpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eaEQ/4BIMCvCYfWZaTzgSWJQWJflok61jkYPtdQT6U3F88u1mB+zehnDS7DG1z0SJ
	 MxStoQBO3pMjyqd7S1FHELn0AmDcutMXz0WOTnEGpdrdB+8mCJleeZ65i6NuIJHAzE
	 AfTZwCEapgtsbjWikkGXyGSLOpkHy1ahdYBqnl3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfHEKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfHEKBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:01:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709EF2075B;
        Mon,  5 Aug 2019 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564999263;
        bh=rXRs98rcvgGFy2+Yx+06Sk5a077Kv9Ajpn2E+APiZpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJL4Ha22lZYgS1afwJ111lx0LN7wCuFeKb++N3WeaHdHoJ9XS0YZgwgP6hjLkJqxq
         8Nfd+hxkPPe4xhJKhIKOHYyYES90vLcgVeajLH5uTLBIZl0G+boJfEO9hYfBIy9bLr
         tdZ9njPPPFpyVvkLMTT7LF1MlJGnnpN9GHBj0PLU=
Date:   Mon, 5 Aug 2019 11:00:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, rrichter@cavium.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/prefetch: fix a -Wtype-limits warning
Message-ID: <20190805100059.4gml6c4kclz2iin3@willie-the-truck>
References: <20190803003358.992-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803003358.992-1-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:33:58PM -0400, Qian Cai wrote:
> The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
> CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
> used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
> warning from GCC,
> 
> In file included from ./arch/arm64/include/asm/cache.h:8,
>                 from ./include/linux/cache.h:6,
>                 from ./include/linux/printk.h:9,
>                 from ./include/linux/kernel.h:15,
>                 from ./include/linux/cpumask.h:10,
>                 from arch/arm64/kernel/cpufeature.c:11:
> arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
> ./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
> unsigned expression >= 0 is always true [-Wtype-limits]
>  _model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
>                          ^~
> arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
> 'MIDR_IS_CPU_MODEL_RANGE'
>  return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
>         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by making "rv" a "s32".
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Use "s32" for "rv", so "variant 0/revision 0" can be covered.
> 
>  arch/arm64/include/asm/cputype.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index e7d46631cc42..d52fe8651c2d 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -54,7 +54,7 @@
>  #define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		\
>  ({									\
>  	u32 _model = (midr) & MIDR_CPU_MODEL_MASK;			\
> -	u32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
> +	s32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\

Hmm, but this really isn't a signed quantity: it's two fields extracted
from an ID register. I think the code is fine. Are you explicitly enabling
-Wtype-limits somehow?

Will
