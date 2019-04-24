Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE99C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4825420811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfDXKoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:44:32 -0400
Received: from foss.arm.com ([217.140.101.70]:41370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfDXKob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:44:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546D8A78;
        Wed, 24 Apr 2019 03:44:31 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3E33F5AF;
        Wed, 24 Apr 2019 03:44:28 -0700 (PDT)
Subject: Re: [RFC 4/6] arm64: assembler: Add macro to annotate asm function
 having non standard stack-frame.
To:     Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-5-raphael.gault@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <c14b8e06-3916-9936-0093-6a8935019d26@arm.com>
Date:   Wed, 24 Apr 2019 11:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190409135243.12424-5-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphaël,

On 09/04/2019 14:52, Raphael Gault wrote:
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>

Even there is not much to say, we include a commit message to explain
what the patch does and/or why we want it.

> ---
>  arch/arm64/include/asm/assembler.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 4feb6119c3c9..636a07a7eb76 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -748,4 +748,22 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>  .Lyield_out_\@ :
>  	.endm
>  
> +
> +#ifdef	CONFIG_STACK_VALIDATION
> +	/*
> +	 * This macro is the arm64 assembler equivalent of the
> +	 * macro STACK_FRAME_NON_STANDARD define at
> +	 * ~/include/linux/frame.h
> +	 */
> +	.macro	asm_stack_frame_non_standard	func
> +	.pushsection ".discard.func_stack_frame_non_standard"
> +	.8byte	\func
> +	.popsection
> +	.endm
> +#else
> +	.macro	asm_stack_frame_non_standard	func
> +	.endm
> +#endif
> +
> +

This can be simplified as:

	.macro asm_stack_frame_non_standard func
#ifdef CONFIG_STACK_VALIDATION
	[...]
#endif
	.endm

>  #endif	/* __ASM_ASSEMBLER_H */
> 

Cheers,

-- 
Julien Thierry
