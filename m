Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68818C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FD72071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wQSFsTt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0FlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:41:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60768 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfK0FlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:41:13 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47N8lB4zCpz9tysk;
        Wed, 27 Nov 2019 06:41:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wQSFsTt9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ioOz1oZBDhmO; Wed, 27 Nov 2019 06:41:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47N8lB3cJ4z9tysj;
        Wed, 27 Nov 2019 06:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574833270; bh=hF4O3c/eGWDgrTc5H8GaCkgtjbbpw3OdnkIyDRrWDLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wQSFsTt9qoFnjvCZTCZuwndaKfq7d6l5nBde8BRossKAePsEKATcpRWKFX6bnF4dK
         BSdcca7DaOrDog4rjNriF6jFy/xPqzQ5S9bgRLv09mjFbGLQWgz1wRtu0SjFt6kIxI
         TospyT5I+uxd4cHHottPoIempb6RtopoN5owQZZ8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 406248B837;
        Wed, 27 Nov 2019 06:41:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sckFHEe4BP-g; Wed, 27 Nov 2019 06:41:11 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 428BB8B770;
        Wed, 27 Nov 2019 06:41:09 +0100 (CET)
Subject: Re: [PATCH v2 29/35] powerpc/perf: remove current_is_64bit()
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1574798487.git.msuchanek@suse.de>
 <83795e9690ad8b51a2d991919bc102351a3bbb20.1574798487.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ecceebf5-391a-c75d-28a7-44623adc06e8@c-s.fr>
Date:   Wed, 27 Nov 2019 06:41:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <83795e9690ad8b51a2d991919bc102351a3bbb20.1574798487.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/11/2019 à 21:13, Michal Suchanek a écrit :
> Since commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> current_is_64bit() is quivalent to !is_32bit_task().
> Remove the redundant function.
> 
> Link: https://github.com/linuxppc/issues/issues/275
> Link: https://lkml.org/lkml/2019/9/12/540
> 
> Fixes: linuxppc#275
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

This change is already in powerpc/next, see 
https://github.com/linuxppc/linux/commit/42484d2c0f82b666292faf6668c77b49a3a04bc0

Christophe

> ---
>   arch/powerpc/perf/callchain.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index c84bbd4298a0..35d542515faf 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -284,16 +284,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>   	}
>   }
>   
> -static inline int current_is_64bit(void)
> -{
> -	/*
> -	 * We can't use test_thread_flag() here because we may be on an
> -	 * interrupt stack, and the thread flags don't get copied over
> -	 * from the thread_info on the main stack to the interrupt stack.
> -	 */
> -	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> -}
> -
>   #else  /* CONFIG_PPC64 */
>   /*
>    * On 32-bit we just access the address and let hash_page create a
> @@ -321,11 +311,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
>   {
>   }
>   
> -static inline int current_is_64bit(void)
> -{
> -	return 0;
> -}
> -
>   static inline int valid_user_sp(unsigned long sp, int is_64)
>   {
>   	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> @@ -486,7 +471,7 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>   void
>   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>   {
> -	if (current_is_64bit())
> +	if (!is_32bit_task())
>   		perf_callchain_user_64(entry, regs);
>   	else
>   		perf_callchain_user_32(entry, regs);
> 
