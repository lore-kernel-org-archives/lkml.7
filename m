Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD85C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4CB23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="V6Ps4YjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfH3UVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:21:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56113 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfH3UVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:21:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46KrV86Md0z9v7DV;
        Fri, 30 Aug 2019 22:21:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=V6Ps4YjA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IyCuknZygVPR; Fri, 30 Aug 2019 22:21:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46KrV859B7z9v7DT;
        Fri, 30 Aug 2019 22:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567196496; bh=yamZ/uoZZ/8N8l60SIEdp4gAbxpE6C6fN89lCQF9GyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V6Ps4YjAJcG1xn8iVemR4dWplz6+YHrm5TUEci82McqyDzka3geO/zdxuYz+YUj9r
         9VwyYzFddQcrFACr222SVJeo/rJBTkQgVIs3P/FVMQpxbo0UEOjoYDYdft7I3Ptt+1
         KMmpXoX5CVDXCUjkyaB6f9AgBm8kQe8UIKD17Kms=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 060658B911;
        Fri, 30 Aug 2019 22:21:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3ST1DPzSo99M; Fri, 30 Aug 2019 22:21:36 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC7028B90B;
        Fri, 30 Aug 2019 22:21:35 +0200 (CEST)
Subject: Re: [PATCH v6 3/6] powerpc/perf: consolidate read_user_stack_32
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <cover.1567188299.git.msuchanek@suse.de>
 <630c0889c1fb841bcd2054d90205e61d175b965b.1567188299.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <688e9db0-f00f-7629-5162-f711c3627708@c-s.fr>
Date:   Fri, 30 Aug 2019 22:21:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <630c0889c1fb841bcd2054d90205e61d175b965b.1567188299.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/08/2019 à 20:57, Michal Suchanek a écrit :
> There are two almost identical copies for 32bit and 64bit.
> 
> The function is used only in 32bit code which will be split out in next
> patch so consolidate to one function.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Christophe.Leroy@c-s.fr

> ---
> new patch in v6
> ---
>   arch/powerpc/perf/callchain.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index c84bbd4298a0..b7cdcce20280 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -165,22 +165,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
>   	return read_user_stack_slow(ptr, ret, 8);
>   }
>   
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> -{
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> -		return 0;
> -	}
> -	pagefault_enable();
> -
> -	return read_user_stack_slow(ptr, ret, 4);
> -}
> -
>   static inline int valid_user_sp(unsigned long sp, int is_64)
>   {
>   	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
> @@ -295,6 +279,12 @@ static inline int current_is_64bit(void)
>   }
>   
>   #else  /* CONFIG_PPC64 */
> +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_PPC64 */
> +
>   /*
>    * On 32-bit we just access the address and let hash_page create a
>    * HPTE if necessary, so there is no need to fall back to reading
> @@ -313,9 +303,12 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>   	rc = __get_user_inatomic(*ret, ptr);
>   	pagefault_enable();
>   
> +	if (IS_ENABLED(CONFIG_PPC64) && rc)
> +		return read_user_stack_slow(ptr, ret, 4);
>   	return rc;
>   }
>   
> +#ifndef CONFIG_PPC64
>   static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>   					  struct pt_regs *regs)
>   {
> 
