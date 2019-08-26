Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B8C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E42184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfHZLlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:41:45 -0400
Received: from ozlabs.org ([203.11.71.1]:48019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbfHZLlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:41:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46H98664TJz9sMr;
        Mon, 26 Aug 2019 21:41:42 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/time: use feature fixup in __USE_RTC() instead of cpu feature.
In-Reply-To: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr>
References: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr>
Date:   Mon, 26 Aug 2019 21:41:39 +1000
Message-ID: <87blwc40i4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> sched_clock(), used by printk(), calls __USE_RTC() to know
> whether to use realtime clock or timebase.
>
> __USE_RTC() uses cpu_has_feature() which is initialised by
> machine_init(). Before machine_init(), __USE_RTC() returns true,
> leading to a program check exception on CPUs not having realtime
> clock.
>
> In order to be able to use printk() earlier, use feature fixup.
> Feature fixups are applies in early_init(), enabling the use of
> printk() earlier.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/time.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

The other option would be just to make this a compile time decision, eg.
add CONFIG_PPC_601 and use that to gate whether we use RTC.

Given how many 601 users there are, maybe 1?, I think that would be a
simpler option and avoids complicating the code / binary for everyone
else.

cheers

> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
> index 54f4ec1f9fab..3455cb54c333 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -42,7 +42,14 @@ struct div_result {
>  /* Accessor functions for the timebase (RTC on 601) registers. */
>  /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
>  #ifdef CONFIG_PPC_BOOK3S_32
> -#define __USE_RTC()	(cpu_has_feature(CPU_FTR_USE_RTC))
> +static inline bool __USE_RTC(void)
> +{
> +	asm_volatile_goto(ASM_FTR_IFCLR("nop;", "b %1;", %0) ::
> +			  "i" (CPU_FTR_USE_RTC) :: l_use_rtc);
> +	return false;
> +l_use_rtc:
> +	return true;
> +}
>  #else
>  #define __USE_RTC()	0
>  #endif
> -- 
> 2.13.3
