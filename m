Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D543522CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tiBik0Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfH3UWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:22:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31364 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3UWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:22:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46KrWP2CQTz9v7DV;
        Fri, 30 Aug 2019 22:22:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tiBik0Ug; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UPE7pN6RCdlH; Fri, 30 Aug 2019 22:22:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46KrWP14Mkz9v7DT;
        Fri, 30 Aug 2019 22:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567196561; bh=/rJmGIEQWuJ0LF6lPlvlARESl/QdAahuYDIB8EE/APA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tiBik0UgPJWWdXmzvxl7AI/nRGtosfr2HeowK/NA6W/p9S2w89Cyh8W/ktkDP/ZiM
         Dcs8mI/DLZRE8DmdOWuyFhtHasDvv7RvQ4aatFwlWnLCwr57DQdnqAUSjtNnhlt4QS
         Y4V+E6v6pDWDe9Xy0V/7F9fDv9XzDyjPkdMI40Po=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F6558B911;
        Fri, 30 Aug 2019 22:22:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uphW0UXcMZhi; Fri, 30 Aug 2019 22:22:41 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EFE078B90B;
        Fri, 30 Aug 2019 22:22:39 +0200 (CEST)
Subject: Re: [PATCH v6 2/6] powerpc: move common register copy functions from
 signal_32.c to signal.c
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
 <36b04bccb129087a78a068207fc71194a1064667.1567188299.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b4eba1ab-2659-53a8-d7dd-c4715e64fe36@c-s.fr>
Date:   Fri, 30 Aug 2019 22:22:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <36b04bccb129087a78a068207fc71194a1064667.1567188299.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/08/2019 à 20:57, Michal Suchanek a écrit :
> These functions are required for 64bit as well.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: christophe.leroy@c-s.fr


> ---
>   arch/powerpc/kernel/signal.c    | 141 ++++++++++++++++++++++++++++++++
>   arch/powerpc/kernel/signal_32.c | 140 -------------------------------
>   2 files changed, 141 insertions(+), 140 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index e6c30cee6abf..60436432399f 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -18,12 +18,153 @@
>   #include <linux/syscalls.h>
>   #include <asm/hw_breakpoint.h>
>   #include <linux/uaccess.h>
> +#include <asm/switch_to.h>
>   #include <asm/unistd.h>
>   #include <asm/debug.h>
>   #include <asm/tm.h>
>   
>   #include "signal.h"
>   
> +#ifdef CONFIG_VSX
> +unsigned long copy_fpr_to_user(void __user *to,
> +			       struct task_struct *task)
> +{
> +	u64 buf[ELF_NFPREG];
> +	int i;
> +
> +	/* save FPR copy to local buffer then write to the thread_struct */
> +	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> +		buf[i] = task->thread.TS_FPR(i);
> +	buf[i] = task->thread.fp_state.fpscr;
> +	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
> +}
> +
> +unsigned long copy_fpr_from_user(struct task_struct *task,
> +				 void __user *from)
> +{
> +	u64 buf[ELF_NFPREG];
> +	int i;
> +
> +	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
> +		return 1;
> +	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> +		task->thread.TS_FPR(i) = buf[i];
> +	task->thread.fp_state.fpscr = buf[i];
> +
> +	return 0;
> +}
> +
> +unsigned long copy_vsx_to_user(void __user *to,
> +			       struct task_struct *task)
> +{
> +	u64 buf[ELF_NVSRHALFREG];
> +	int i;
> +
> +	/* save FPR copy to local buffer then write to the thread_struct */
> +	for (i = 0; i < ELF_NVSRHALFREG; i++)
> +		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
> +	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
> +}
> +
> +unsigned long copy_vsx_from_user(struct task_struct *task,
> +				 void __user *from)
> +{
> +	u64 buf[ELF_NVSRHALFREG];
> +	int i;
> +
> +	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
> +		return 1;
> +	for (i = 0; i < ELF_NVSRHALFREG ; i++)
> +		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +unsigned long copy_ckfpr_to_user(void __user *to,
> +				  struct task_struct *task)
> +{
> +	u64 buf[ELF_NFPREG];
> +	int i;
> +
> +	/* save FPR copy to local buffer then write to the thread_struct */
> +	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> +		buf[i] = task->thread.TS_CKFPR(i);
> +	buf[i] = task->thread.ckfp_state.fpscr;
> +	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
> +}
> +
> +unsigned long copy_ckfpr_from_user(struct task_struct *task,
> +					  void __user *from)
> +{
> +	u64 buf[ELF_NFPREG];
> +	int i;
> +
> +	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
> +		return 1;
> +	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> +		task->thread.TS_CKFPR(i) = buf[i];
> +	task->thread.ckfp_state.fpscr = buf[i];
> +
> +	return 0;
> +}
> +
> +unsigned long copy_ckvsx_to_user(void __user *to,
> +				  struct task_struct *task)
> +{
> +	u64 buf[ELF_NVSRHALFREG];
> +	int i;
> +
> +	/* save FPR copy to local buffer then write to the thread_struct */
> +	for (i = 0; i < ELF_NVSRHALFREG; i++)
> +		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
> +	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
> +}
> +
> +unsigned long copy_ckvsx_from_user(struct task_struct *task,
> +					  void __user *from)
> +{
> +	u64 buf[ELF_NVSRHALFREG];
> +	int i;
> +
> +	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
> +		return 1;
> +	for (i = 0; i < ELF_NVSRHALFREG ; i++)
> +		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
> +	return 0;
> +}
> +#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#else
> +inline unsigned long copy_fpr_to_user(void __user *to,
> +				      struct task_struct *task)
> +{
> +	return __copy_to_user(to, task->thread.fp_state.fpr,
> +			      ELF_NFPREG * sizeof(double));
> +}
> +
> +inline unsigned long copy_fpr_from_user(struct task_struct *task,
> +					void __user *from)
> +{
> +	return __copy_from_user(task->thread.fp_state.fpr, from,
> +			      ELF_NFPREG * sizeof(double));
> +}
> +
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +inline unsigned long copy_ckfpr_to_user(void __user *to,
> +					 struct task_struct *task)
> +{
> +	return __copy_to_user(to, task->thread.ckfp_state.fpr,
> +			      ELF_NFPREG * sizeof(double));
> +}
> +
> +inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
> +						 void __user *from)
> +{
> +	return __copy_from_user(task->thread.ckfp_state.fpr, from,
> +				ELF_NFPREG * sizeof(double));
> +}
> +#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#endif
> +
>   /* Log an error when sending an unhandled signal to a process. Controlled
>    * through debug.exception-trace sysctl.
>    */
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 98600b276f76..c93c937ea568 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -235,146 +235,6 @@ struct rt_sigframe {
>   	int			abigap[56];
>   };
>   
> -#ifdef CONFIG_VSX
> -unsigned long copy_fpr_to_user(void __user *to,
> -			       struct task_struct *task)
> -{
> -	u64 buf[ELF_NFPREG];
> -	int i;
> -
> -	/* save FPR copy to local buffer then write to the thread_struct */
> -	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> -		buf[i] = task->thread.TS_FPR(i);
> -	buf[i] = task->thread.fp_state.fpscr;
> -	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
> -}
> -
> -unsigned long copy_fpr_from_user(struct task_struct *task,
> -				 void __user *from)
> -{
> -	u64 buf[ELF_NFPREG];
> -	int i;
> -
> -	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
> -		return 1;
> -	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> -		task->thread.TS_FPR(i) = buf[i];
> -	task->thread.fp_state.fpscr = buf[i];
> -
> -	return 0;
> -}
> -
> -unsigned long copy_vsx_to_user(void __user *to,
> -			       struct task_struct *task)
> -{
> -	u64 buf[ELF_NVSRHALFREG];
> -	int i;
> -
> -	/* save FPR copy to local buffer then write to the thread_struct */
> -	for (i = 0; i < ELF_NVSRHALFREG; i++)
> -		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
> -	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
> -}
> -
> -unsigned long copy_vsx_from_user(struct task_struct *task,
> -				 void __user *from)
> -{
> -	u64 buf[ELF_NVSRHALFREG];
> -	int i;
> -
> -	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
> -		return 1;
> -	for (i = 0; i < ELF_NVSRHALFREG ; i++)
> -		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -unsigned long copy_ckfpr_to_user(void __user *to,
> -				  struct task_struct *task)
> -{
> -	u64 buf[ELF_NFPREG];
> -	int i;
> -
> -	/* save FPR copy to local buffer then write to the thread_struct */
> -	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> -		buf[i] = task->thread.TS_CKFPR(i);
> -	buf[i] = task->thread.ckfp_state.fpscr;
> -	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
> -}
> -
> -unsigned long copy_ckfpr_from_user(struct task_struct *task,
> -					  void __user *from)
> -{
> -	u64 buf[ELF_NFPREG];
> -	int i;
> -
> -	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
> -		return 1;
> -	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
> -		task->thread.TS_CKFPR(i) = buf[i];
> -	task->thread.ckfp_state.fpscr = buf[i];
> -
> -	return 0;
> -}
> -
> -unsigned long copy_ckvsx_to_user(void __user *to,
> -				  struct task_struct *task)
> -{
> -	u64 buf[ELF_NVSRHALFREG];
> -	int i;
> -
> -	/* save FPR copy to local buffer then write to the thread_struct */
> -	for (i = 0; i < ELF_NVSRHALFREG; i++)
> -		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
> -	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
> -}
> -
> -unsigned long copy_ckvsx_from_user(struct task_struct *task,
> -					  void __user *from)
> -{
> -	u64 buf[ELF_NVSRHALFREG];
> -	int i;
> -
> -	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
> -		return 1;
> -	for (i = 0; i < ELF_NVSRHALFREG ; i++)
> -		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
> -	return 0;
> -}
> -#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> -#else
> -inline unsigned long copy_fpr_to_user(void __user *to,
> -				      struct task_struct *task)
> -{
> -	return __copy_to_user(to, task->thread.fp_state.fpr,
> -			      ELF_NFPREG * sizeof(double));
> -}
> -
> -inline unsigned long copy_fpr_from_user(struct task_struct *task,
> -					void __user *from)
> -{
> -	return __copy_from_user(task->thread.fp_state.fpr, from,
> -			      ELF_NFPREG * sizeof(double));
> -}
> -
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -inline unsigned long copy_ckfpr_to_user(void __user *to,
> -					 struct task_struct *task)
> -{
> -	return __copy_to_user(to, task->thread.ckfp_state.fpr,
> -			      ELF_NFPREG * sizeof(double));
> -}
> -
> -inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
> -						 void __user *from)
> -{
> -	return __copy_from_user(task->thread.ckfp_state.fpr, from,
> -				ELF_NFPREG * sizeof(double));
> -}
> -#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> -#endif
> -
>   /*
>    * Save the current user registers on the user stack.
>    * We only save the altivec/spe registers if the process has used
> 
