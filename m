Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16968C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E809B23717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfICOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:34:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:34:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FBB5337;
        Tue,  3 Sep 2019 07:34:43 -0700 (PDT)
Received: from [10.37.8.116] (unknown [10.37.8.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255533F246;
        Tue,  3 Sep 2019 07:34:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] arm64: compat: vdso: Expose BUILD_VDSO32
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, 0x7f454c46@gmail.com, salyzyn@android.com,
        paul.burton@mips.com, luto@kernel.org, tglx@linutronix.de,
        will@kernel.org
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-2-vincenzo.frascino@arm.com>
Message-ID: <c0b1673d-e37d-a526-0862-ad07f779f5bf@arm.com>
Date:   Tue, 3 Sep 2019 15:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190830135902.20861-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin and Will,

On 8/30/19 2:58 PM, Vincenzo Frascino wrote:
> clock_gettime32 and clock_getres_time32 should be compiled only with the
> 32 bit vdso library.
> 
> Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
> indication to the generic library to include these symbols.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> index c50ee1b7d5cd..fe7afe0f1a3d 100644
> --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> @@ -17,6 +17,7 @@
>  #define VDSO_HAS_CLOCK_GETRES		1
>  
>  #define VDSO_HAS_32BIT_FALLBACK		1
> +#define BUILD_VDSO32			1
>  
>  static __always_inline
>  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
> 

This patch is independent from the rest and touches only arch code. Can it go in
via the arm64 tree?

-- 
Regards,
Vincenzo
