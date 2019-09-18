Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76771C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679C21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nSSdgw+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfIRPmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:42:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34673 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfIRPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:42:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so8536755qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxoYLfyiBUzPhqlCM4w4PwBwFKu/jtqQR2cCGb9YBT4=;
        b=nSSdgw+6FYaaStUyX2sA8rUkMZXoeQQ1Bhj98GeF7Gz7fo9nVGjBG+6KdBsfdcv5RB
         A34NyTjV5lYd/E//bk1eHCio4Y9+zd6V8vjqmhVzMVJgvx+ByAf2yrCUZtwkU8cOZgXO
         aMU83MmPolqXpB6/osYDW0cz5mf0aYSufpWrYJmFXoPR9+ZRrRozpVBP94KeBGHhpu20
         WN0SVFkgwuSDTkpCTSVtl3ieYTtGqEDj+JZHhWqnMrlilD7DCh1zsb5vtBGzIL/Vjr8H
         C17TB7sqDGFLObwXy71/6DeZR9PMN1q3y/MX/0MsB919oVmtLH6WRPbyq2ZWD9zCDc2D
         Spaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxoYLfyiBUzPhqlCM4w4PwBwFKu/jtqQR2cCGb9YBT4=;
        b=nDyRxBLGNg6gXrUOja96HPt0p+JipBSoI6BNNqAJF9t84ZszXLSVfKiMFl41gYJizT
         uy5rdQmE58zofj1KUhyzbmWJMzdgNljY/sxqdpRMmqqp/d/xSmK2rWZkybmB38yk4Qng
         Dn0QIYlCMCqszw7n29ZtMKsx006GCHCSTMqU0zrM7R8MJJzibSy8atSKvUBDBoGdtxoz
         h+X5tu0lVHYjzmhy57PPgGgS4ciQ9fVUk9Hc0yLyTUduDodnaDHhOTBdjBNfQEMTAzjI
         FjNKjHIR6laI3rgyI5b/KK11q1csWTU8jmOeu2/RzeUULI9Zn5JUw+wh2/8PggS97PFn
         BS7w==
X-Gm-Message-State: APjAAAXAqjyKwIBpH44gOGPb5A2xbVG6wEqKh8G0sPzTizRfS29e38oJ
        Jw9TMnudfwTkHuOLHD6UHtcO2Kth0zg=
X-Google-Smtp-Source: APXvYqwRPQBIvBID8wxxk+kHKEOudHk1TuWjSNq51em4yTV73znC4lOPaseqqlTF0JNOe7fXWkP9Tw==
X-Received: by 2002:a37:67c6:: with SMTP id b189mr4597177qkc.472.1568821326580;
        Wed, 18 Sep 2019 08:42:06 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n65sm2937218qkb.19.2019.09.18.08.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 08:42:05 -0700 (PDT)
Message-ID: <1568821324.5576.174.camel@lca.pw>
Subject: Re: [PATCH v4] powerpc/setup_64: fix -Wempty-body warnings
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Sep 2019 11:42:04 -0400
In-Reply-To: <1563215552-8166-1-git-send-email-cai@lca.pw>
References: <1563215552-8166-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, ping in case that you might forget this one forever as well.

On Mon, 2019-07-15 at 14:32 -0400, Qian Cai wrote:
> At the beginning of setup_64.c, it has,
> 
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
> 
> where DBG() could be compiled away, and generate warnings,
> 
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");
> 
> Fix it by using the suggestions from Michael:
> 
> "Neither of those sites should use DBG(), that's not really early boot
> code, they should just use pr_warn().
> 
> And the other uses of DBG() in initialize_cache_info() should just be
> removed.
> 
> In smp_release_cpus() the entry/exit DBG's should just be removed, and
> the spinning_secondaries line should just be pr_debug().
> 
> That would just leave the two calls in early_setup(). If we taught
> udbg_printf() to return early when udbg_putc is NULL, then we could just
> call udbg_printf() unconditionally and get rid of the DBG macro
> entirely."
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v4: Use the suggestions from Michael and __func__ per checkpatch.
> v3: Use no_printk() macro, and make sure that format and argument are always
>     verified by the compiler using a more generic form ##__VA_ARGS__ per Joe.
> v2: Fix it by using a NOP while loop per Tyrel.
> 
>  arch/powerpc/kernel/setup_64.c | 26 ++++++--------------------
>  arch/powerpc/kernel/udbg.c     | 14 ++++++++------
>  2 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 44b4c432a273..d2af4c228970 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -68,12 +68,6 @@
>  
>  #include "setup.h"
>  
> -#ifdef DEBUG
> -#define DBG(fmt...) udbg_printf(fmt)
> -#else
> -#define DBG(fmt...)
> -#endif
> -
>  int spinning_secondaries;
>  u64 ppc64_pft_size;
>  
> @@ -305,7 +299,7 @@ void __init early_setup(unsigned long dt_ptr)
>  	/* Enable early debugging if any specified (see udbg.h) */
>  	udbg_early_init();
>  
> - 	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
> +	udbg_printf(" -> %s(), dt_ptr: 0x%lx\n", __func__, dt_ptr);
>  
>  	/*
>  	 * Do early initialization using the flattened device
> @@ -362,11 +356,11 @@ void __init early_setup(unsigned long dt_ptr)
>  	 */
>  	this_cpu_enable_ftrace();
>  
> -	DBG(" <- early_setup()\n");
> +	udbg_printf(" <- %s()\n", __func__);
>  
>  #ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
>  	/*
> -	 * This needs to be done *last* (after the above DBG() even)
> +	 * This needs to be done *last* (after the above udbg_printf() even)
>  	 *
>  	 * Right after we return from this function, we turn on the MMU
>  	 * which means the real-mode access trick that btext does will
> @@ -436,8 +430,6 @@ void smp_release_cpus(void)
>  	if (!use_spinloop())
>  		return;
>  
> -	DBG(" -> smp_release_cpus()\n");
> -
>  	/* All secondary cpus are spinning on a common spinloop, release them
>  	 * all now so they can start to spin on their individual paca
>  	 * spinloops. For non SMP kernels, the secondary cpus never get out
> @@ -456,9 +448,7 @@ void smp_release_cpus(void)
>  			break;
>  		udelay(1);
>  	}
> -	DBG("spinning_secondaries = %d\n", spinning_secondaries);
> -
> -	DBG(" <- smp_release_cpus()\n");
> +	pr_debug("spinning_secondaries = %d\n", spinning_secondaries);
>  }
>  #endif /* CONFIG_SMP || CONFIG_KEXEC_CORE */
>  
> @@ -551,8 +541,6 @@ void __init initialize_cache_info(void)
>  	struct device_node *cpu = NULL, *l2, *l3 = NULL;
>  	u32 pvr;
>  
> -	DBG(" -> initialize_cache_info()\n");
> -
>  	/*
>  	 * All shipping POWER8 machines have a firmware bug that
>  	 * puts incorrect information in the device-tree. This will
> @@ -576,10 +564,10 @@ void __init initialize_cache_info(void)
>  	 */
>  	if (cpu) {
>  		if (!parse_cache_info(cpu, false, &ppc64_caches.l1d))
> -			DBG("Argh, can't find dcache properties !\n");
> +			pr_warn("Argh, can't find dcache properties !\n");
>  
>  		if (!parse_cache_info(cpu, true, &ppc64_caches.l1i))
> -			DBG("Argh, can't find icache properties !\n");
> +			pr_warn("Argh, can't find icache properties !\n");
>  
>  		/*
>  		 * Try to find the L2 and L3 if any. Assume they are
> @@ -604,8 +592,6 @@ void __init initialize_cache_info(void)
>  
>  	cur_cpu_spec->dcache_bsize = dcache_bsize;
>  	cur_cpu_spec->icache_bsize = icache_bsize;
> -
> -	DBG(" <- initialize_cache_info()\n");
>  }
>  
>  /*
> diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
> index a384e7c8b01c..01595e8cafe7 100644
> --- a/arch/powerpc/kernel/udbg.c
> +++ b/arch/powerpc/kernel/udbg.c
> @@ -120,13 +120,15 @@ int udbg_write(const char *s, int n)
>  #define UDBG_BUFSIZE 256
>  void udbg_printf(const char *fmt, ...)
>  {
> -	char buf[UDBG_BUFSIZE];
> -	va_list args;
> +	if (udbg_putc) {
> +		char buf[UDBG_BUFSIZE];
> +		va_list args;
>  
> -	va_start(args, fmt);
> -	vsnprintf(buf, UDBG_BUFSIZE, fmt, args);
> -	udbg_puts(buf);
> -	va_end(args);
> +		va_start(args, fmt);
> +		vsnprintf(buf, UDBG_BUFSIZE, fmt, args);
> +		udbg_puts(buf);
> +		va_end(args);
> +	}
>  }
>  
>  void __init udbg_progress(char *s, unsigned short hex)
