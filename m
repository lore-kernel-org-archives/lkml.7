Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6657C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE82184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pzUjqjfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCNFqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:46:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24816 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCNFqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:46:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Kd476LHyz9tyvj;
        Thu, 14 Mar 2019 06:46:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pzUjqjfB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QVhScbPFhy31; Thu, 14 Mar 2019 06:46:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Kd47599hz9tyvg;
        Thu, 14 Mar 2019 06:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552542375; bh=aDIk8/hnkdKEojmbeEOk2Wak98qNGcNYj/PbnsmyxC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pzUjqjfBozoYw+FEosznude4NAYAVL4uGSjrBy1ypISwnp/Q0/fgLab0qBgctOWcZ
         0Gn3EIO4lCRgtikcX8z6xz8Q0RDG9xiaH01oKyfk6p1fWXDmJcAWY/8vTR8ovzLHYa
         j+RnD8FhUMvoreJgp8kK5XfBYM5zEKmqTGpnnnFk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7231E8B74F;
        Thu, 14 Mar 2019 06:46:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 34z0MuP418fP; Thu, 14 Mar 2019 06:46:15 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B7B58B781;
        Thu, 14 Mar 2019 06:46:14 +0100 (CET)
Subject: Re: [PATCH v2] arch/powerpc: Rework local_paca to avoid LTO warnings
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190313034208.13134-1-alastair@au1.ibm.com>
 <20190314023125.10076-1-alastair@au1.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <38922e32-3048-e45b-203e-63704a78e7d0@c-s.fr>
Date:   Thu, 14 Mar 2019 06:46:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314023125.10076-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/03/2019 à 03:31, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When building an LTO kernel, the existing code generates warnings:
>      ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>          ‘local_paca’ used for multiple global register variables
>       register struct paca_struct *local_paca asm("r13");
>                                    ^
>      ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>          ‘local_paca’
> 
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.
> 
> Changelog:
> V2
>    - Address whitespace issues
>    - keep new implementation close to where the old implementation was
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--------
>   arch/powerpc/kernel/paca.c      |  2 +-
>   2 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index e843bc5d1a0f..2fa0b43357c9 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -34,19 +34,38 @@
>   #include <asm/cpuidle.h>
>   #include <asm/atomic.h>
>   
> -register struct paca_struct *local_paca asm("r13");
> -
>   #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
>   extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
> -/*
> - * Add standard checks that preemption cannot occur when using get_paca():
> - * otherwise the paca_struct it points to may be the wrong one just after.
> - */
> -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
> -#else
> -#define get_paca()	local_paca
>   #endif
>   
> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");
> +
> +	return paca;
> +}
> +
> +static inline struct paca_struct *get_paca(void)
> +{
> +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> +	/*
> +	 * Add standard checks that preemption cannot occur when using get_paca():
> +	 * otherwise the paca_struct it points to may be the wrong one just after.
> +	 */
> +	debug_smp_processor_id();
> +#endif
> +	return get_paca_no_preempt_check();
> +}
> +
> +#define local_paca	get_paca_no_preempt_check()
> +
> +static inline void set_paca(struct paca_struct *new)
> +{
> +	register struct paca_struct *paca asm("r13");
> +
> +	paca = new;
> +}
> +
>   #ifdef CONFIG_PPC_PSERIES
>   #define get_lppaca()	(get_paca()->lppaca_ptr)
>   #endif
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 913bfca09c4f..ae5c243f9d5a 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
>   void setup_paca(struct paca_struct *new_paca)
>   {
>   	/* Setup r13 */
> -	local_paca = new_paca;
> +	set_paca(new_paca);
>   
>   #ifdef CONFIG_PPC_BOOK3E
>   	/* On Book3E, initialize the TLB miss exception frames */
> 
