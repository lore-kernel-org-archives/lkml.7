Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36AC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A87120693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="iMEF+SDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGJG1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:27:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32459 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfGJG1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:27:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45k8PL3n6LzB09ZJ;
        Wed, 10 Jul 2019 08:27:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iMEF+SDR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kZJ0oZwqf6QV; Wed, 10 Jul 2019 08:27:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45k8PL2KCZzB09ZH;
        Wed, 10 Jul 2019 08:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562740054; bh=5TKgHRk+ZhXPsN436WT7n5/+4+4dtwAsOBIgxcM04Oc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iMEF+SDR/JTZbuCdrjKLQHwP439R9Zt2pXbklgTaNevchf62aJgEuqher1yOA20gs
         epxjVHwTlhR+2ViWSCvd8Cq3G56ke4RYjALs7SuFgGMBFTLaHhhgLHQ7ZwaRzln6vx
         vobsQHfXQ5reY/sFqyE+G7DFj8yFLGd1HYrwySYE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DEA58B7F2;
        Wed, 10 Jul 2019 08:27:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1kiCeoAIjYgE; Wed, 10 Jul 2019 08:27:35 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DF2D8B7EE;
        Wed, 10 Jul 2019 08:27:34 +0200 (CEST)
Subject: Re: [PATCH v3 2/3] Powerpc64/Watchpoint: Don't ignore extraneous
 exceptions
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com
References: <20190710045445.31037-1-ravi.bangoria@linux.ibm.com>
 <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1f3fd425-3d2f-8d18-eff1-01ca5b605ba0@c-s.fr>
Date:   Wed, 10 Jul 2019 08:27:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/07/2019 à 06:54, Ravi Bangoria a écrit :
> On Powerpc64, watchpoint match range is double-word granular. On
> a watchpoint hit, DAR is set to the first byte of overlap between
> actual access and watched range. And thus it's quite possible that
> DAR does not point inside user specified range. Ex, say user creates
> a watchpoint with address range 0x1004 to 0x1007. So hw would be
> configured to watch from 0x1000 to 0x1007. If there is a 4 byte
> access from 0x1002 to 0x1005, DAR will point to 0x1002 and thus
> interrupt handler considers it as extraneous, but it's actually not,
> because part of the access belongs to what user has asked. So, let
> kernel pass it on to user and let user decide what to do with it
> instead of silently ignoring it. The drawback is, it can generate
> false positive events.

Why adding some #ifdefs based on CONFIG_8xx ?

I see your commit log mentions 'Powerpc64'. What about BOOK3S/32 ?

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 5c876e986c18..c457d52778e3 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -204,9 +204,10 @@ int hw_breakpoint_handler(struct die_args *args)
>   #ifndef CONFIG_PPC_8xx
>   	int stepped = 1;
>   	unsigned int instr;
> +#else
> +	unsigned long dar = regs->dar;
>   #endif
>   	struct arch_hw_breakpoint *info;
> -	unsigned long dar = regs->dar;
>   
>   	/* Disable breakpoints during exception handling */
>   	hw_breakpoint_disable();
> @@ -240,14 +241,14 @@ int hw_breakpoint_handler(struct die_args *args)
>   
>   	/*
>   	 * Verify if dar lies within the address range occupied by the symbol
> -	 * being watched to filter extraneous exceptions.  If it doesn't,
> -	 * we still need to single-step the instruction, but we don't
> -	 * generate an event.
> +	 * being watched to filter extraneous exceptions.
>   	 */
>   	info->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
> +#ifdef CONFIG_PPC_8xx
>   	if (!((bp->attr.bp_addr <= dar) &&
>   	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
>   		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
> +#endif
>   
>   #ifndef CONFIG_PPC_8xx
>   	/* Do not emulate user-space instructions, instead single-step them */
> 
