Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2ABC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D330A20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbfFJRbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:31:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:61912 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfFJRbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:31:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 10:31:32 -0700
X-ExtLoop1: 1
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.107]) ([10.24.14.107])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2019 10:31:31 -0700
Subject: Re: [PATCH] x86/resctrl: Use _ASM_BX to avoid #ifdef CONFIG_X86_64
To:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, acme@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>
References: <20190606200044.5730-1-ubizjak@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <14baa8db-1989-4d9b-d6fb-ada9a9f1137b@intel.com>
Date:   Mon, 10 Jun 2019 10:31:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606200044.5730-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uros,

On 6/6/2019 1:00 PM, Uros Bizjak wrote:
> Depending on CONFIG_X86_64 _ASM_BX expands to either rbx or ebx.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 604c0e3bcc83..09408794eab2 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -431,11 +431,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>  #else
>  	register unsigned int line_size asm("esi");
>  	register unsigned int size asm("edi");
> -#ifdef CONFIG_X86_64
> -	register void *mem_r asm("rbx");
> -#else
> -	register void *mem_r asm("ebx");
> -#endif /* CONFIG_X86_64 */
> +	register void *mem_r asm(_ASM_BX);
>  #endif /* CONFIG_KASAN */
>  
>  	/*
> 

Thank you very much for catching this. I was not aware of this macro.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
