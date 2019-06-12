Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E7C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310AB21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LXPv+FsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfFLRz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:55:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390620AbfFLRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:55:53 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBB9E1EC0911;
        Wed, 12 Jun 2019 19:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560362152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4grj3QejwCBpNAM+uJrsty+0eljwAkLiJVXJTISRSCE=;
        b=LXPv+FsCSb2KZhF5X4iNxoRJpb0Z1kGoBe+7M+NW2reHoN0cDNfzqAO3pCM7ZSv4vYZqtX
        G2OCt0WaTavhfJUK1OtJZf2iTKWifMyvMYRwqeF3coUjgKsdQJl8Njcdsd8i43ja3BVtkN
        a/73KFoTXR4OhWBjj5LdkOzSSXo2mjw=
Date:   Wed, 12 Jun 2019 19:55:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/mm: fix an unused variable "tsk" warning
Message-ID: <20190612175543.GO32652@zn.tnic>
References: <1559338641-6145-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1559338641-6145-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 05:37:21PM -0400, Qian Cai wrote:
> Since the commit "signal: Remove the task parameter from
> force_sig_fault", "tsk" is only used when MEMORY_FAILURE=y and generates
> a compilation warning without it.
> 
> arch/x86/mm/fault.c: In function 'do_sigbus':
> arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk'
> [-Wunused-variable]
> 
> Also, change to use IS_ENABLED() instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/fault.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 46ac96aa7c81..40d70bd3fa84 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1014,8 +1014,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>  	  vm_fault_t fault)
>  {
> -	struct task_struct *tsk = current;
> -
>  	/* Kernel mode? Handle exceptions or die: */
>  	if (!(error_code & X86_PF_USER)) {
>  		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> @@ -1028,9 +1026,10 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>  
>  	set_signal_archinfo(address, error_code);
>  
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
> +	    (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))) {
>  		unsigned lsb = 0;
> +		struct task_struct *tsk = current;
>  
>  		pr_err(
>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> @@ -1042,7 +1041,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>  		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
>  		return;
>  	}
> -#endif
>  	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>  }
>  
> -- 

I was puzzled just like Dave because this code is not in tip.

Turns out there's this in linux-next:

commit 318759b4737c3b3789e2fd64d539f437d52386f5
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Mon Jun 3 10:23:58 2019 -0500

    signal/x86: Move tsk inside of CONFIG_MEMORY_FAILURE in do_sigbus


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
