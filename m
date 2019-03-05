Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06519C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC21220663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfCEXjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:39:31 -0500
Received: from foss.arm.com ([217.140.101.70]:54332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfCEXja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:39:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BFDA78;
        Tue,  5 Mar 2019 15:39:30 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB1A3F703;
        Tue,  5 Mar 2019 15:39:21 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: drop unnecessary WASM
To:     Stefan Agner <stefan@agner.ch>, linux@armlinux.org.uk
Cc:     nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, will.deacon@arm.com,
        julien.thierry@arm.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
Date:   Tue, 5 Mar 2019 23:39:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 2019-03-05 10:18 pm, Stefan Agner wrote:
> The W macro for generating wide instructions when targeting Thumb-2
> is not required for the preload data instructions (pld, pldw) since
> they are only available as wide instructions. The GNU assembler seems
> to work with or without the .w appended when compiling an Thumb-2
> kernel. However, Clang's integrated assembler does not consider the
> .w variants as valid instructions:
> 
>    ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
>                            "pldw.w\t%a0 \n"
>                             ^
>    <inline asm>:2:1: note: instantiated into assembly here
>    pldw.w  [r0]
>    ^
>    1 error generated.

Have you filed a bug against Clang for that? Something like "pldwal.w" 
may be super-redundant, but it's still perfectly valid syntax. The 
"Standard assembler syntax fields" section of the Arm ARM even calls out 
that "...the .W qualifier has no effect" on ARM/A32 instructions since 
they are inherently 32-bit; that should equally apply for 32-bit only 
Thumb/T32 instructions. There are certainly a few instructions which 
don't allow a condition code (even "AL"), but off-hand I don't remember 
any not having the optional {<q>} field in their syntax.

That said, obviously the patch itself is no problem since the syntax 
*is* redundant here, but it really is just a workaround for an assembler 
bug.

Robin.

> Drop the macro to make sure non-wide variants of pld and pldw are
> emitted in all cases.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   arch/arm/include/asm/processor.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 120f4c9bbfde..042d77cf686d 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -131,8 +131,8 @@ static inline void prefetchw(const void *ptr)
>   	__asm__ __volatile__(
>   		".arch_extension	mp\n"
>   		__ALT_SMP_ASM(
> -			WASM(pldw)		"\t%a0",
> -			WASM(pld)		"\t%a0"
> +			"pldw\t%a0",
> +			"pld\t%a0"
>   		)
>   		:: "p" (ptr));
>   }
> 
