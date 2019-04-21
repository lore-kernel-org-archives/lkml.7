Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B6C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B920821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555871083;
	bh=7vDeq4DcC0h5UrRR3AkJYlDi+GYIhk1E0DyjDnkwGAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DjoDv0aOPjqnTh/n79iJy3eDdLH8c68fS73mm6nFjsPDoT/+s+NqFBDwtskHBF/Hn
	 Bf5OpF6CkZfzkOYA4cRZZKzRsk5l2todcHADblMJa0L5S1dzPFoHb6nE8jBoGjewIv
	 q7kpvjmFlloS5HRFgOLrN0llMie8/J/OC7kg98EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDUSYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfDUSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:24:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so13336408wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rouN/2O/91Fj9bPoMMHAznPecSTB1pt/LF5uz7VIQfs=;
        b=PnXtDMXhm2cRiXkuHhd0eE0LU1z3VEHm+cnh9U0nlB1zI1cLK1RVIswKNEZgxvc+ew
         ntbj3M7NkD6G3NQgT3MwvjZxf+kOXcVAEnxZY2di2MARCyd1QG/Myjh9inxSwJ4/jAWM
         zoVWNNIxGMZP3xXq77jpBr5dbojy1iRBcYGdCo8Mgjhs+fZG7KERwU84iT7B9t93DjWj
         MMxeLlgF91juOT5U9iv8AcgPbIQOmGb04mxeYT/DJlJnBCIU3Ls17oFfIuqEs1YDaY/P
         9rqZsgqaeiALvQ2E/8VBOjnqlOM/aeuPlK52jnoxbUaHur3s7R0/8YsPxST6EgeSIsUg
         RQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rouN/2O/91Fj9bPoMMHAznPecSTB1pt/LF5uz7VIQfs=;
        b=TKoejd5LydlABd7E/K3+oqfrK8T9y3nuJUXSczfwkP3NmwtXLrvdIILNI7oJIY69CJ
         YT8Bz6gBVuz9xG34u4LxF+EkGagauMj7hVKiJmiPWcOLjTEm5p0796WXSrhepm3OxUZk
         iQfcxhY6BPQeR9fB93227wc/5xxwpiCO8pu4ktgMGnJJJOY7bUW+AnifEWfz6eNK3USO
         FIQlip0wrXjzlDQwPPUDeCMW+Cw8PnPlOfSdTtL/aqsTLYZZjEOqUjO4moXgJbiK3lrT
         55UPRhEE9MRWgWAJVhFsrE6vEeTNIZ+txK9wqMH0uck3L4GhMUIBPT3Ryzf3Kuf5FKN3
         t7+Q==
X-Gm-Message-State: APjAAAVHTTs2MeHz6XpXavYyyyAawdHu88jzxAhlkoVKx1JJR2/HGDbC
        DsaxPGzy0Aj7o+ZDG5zOjnXeDiw6
X-Google-Smtp-Source: APXvYqxzdF66hhlgeAwnlF3/khmQvVYn98wLelnrTbmjxSTRKdxq4vdxaFluvCWZ+mzaao0JYrRY/w==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr10623382wrx.32.1555871079873;
        Sun, 21 Apr 2019 11:24:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c11sm3484944wrs.86.2019.04.21.11.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 11:24:39 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:24:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com, bhe@redhat.com,
        piliu@redhat.com, Yinghai Lu <yinghai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] X86/kdump: move crashkernel=X to reserve under 4G by
 default
Message-ID: <20190421182436.GB35603@gmail.com>
References: <20190421035058.943630505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421035058.943630505@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Young <dyoung@redhat.com> wrote:

> The kdump crashkernel low reservation is limited to under 896M even for
> X86_64. This obscure and miserable limitation exists for old kexec-tools
> compatibility, but the reason is not documented anywhere.
> 
> Some more tests/investigations about the background:
> a) Previously old kexec-tools can only load purgatory to memory under 2G,
>    Eric remove that limitation in 2012 in kexec-tools:
>    Commit b4f9f8599679 ("kexec x86_64: Make purgatory relocatable anywhere
>    in the 64bit address space.")
> 
> b) back in 2013 Yinghai removed all the limitations in new kexec-tools,
>    bzImage64 can be loaded to anywhere.
>    Commit 82c3dd2280d2 ("kexec, x86_64: Load bzImage64 above 4G")
> 
> c) test results with old kexec-tools with old and latest kernels.
>   1. old kexec-tools can not build with modern toolchain anymore,
>      I built it in a RHEL6 vm
>   2. 2.0.0 kexec-tools does not work with latest kernel even with
>      memory under 896M and give an error:
>      "ELF core (kcore) parse failed", it needs below kexec-tools fix 
>      Commit ed15ba1b9977 ("build_mem_phdrs(): check if p_paddr is invalid")
>   3. even with patched kexec-tools which fixes 2),  it still needs some
>      other fixes to work correctly for kaslr enabled kernels.
> 
> So the situation is:
> * old kexec-tools is already broken with latest kernels
> * we can not keep this limitations forever just for compatibility of very
>   old kexec-tools.
> * If one must use old tools then he/she can choose crashkernel=X@Y
> * people have reported bugs crashkernel=384M failed because kaslr makes
>   the 0-896M space sparse, 
> * crashkernel can reserve in low or high area, it is natural to understand 
>   low as memory under 4G
> 
> Hence drop the 896M limitation, and change crashkernel low reservation to
> reserve under 4G by default.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/kernel/setup.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- linux-x86.orig/arch/x86/kernel/setup.c
> +++ linux-x86/arch/x86/kernel/setup.c
> @@ -71,6 +71,7 @@
>  #include <linux/tboot.h>
>  #include <linux/jiffies.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/sizes.h>
>  
>  #include <linux/usb/xhci-dbgp.h>
>  #include <video/edid.h>
> @@ -448,18 +449,17 @@ static void __init memblock_x86_reserve_
>  #ifdef CONFIG_KEXEC_CORE
>  
>  /* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		(16 << 20)
> +#define CRASH_ALIGN		SZ_16M
>  
>  /*
>   * Keep the crash kernel below this limit.  On 32 bits earlier kernels
>   * would limit the kernel to the low 512 MiB due to mapping restrictions.
> - * On 64bit, old kexec-tools need to under 896MiB.
>   */
>  #ifdef CONFIG_X86_32
> -# define CRASH_ADDR_LOW_MAX	(512 << 20)
> -# define CRASH_ADDR_HIGH_MAX	(512 << 20)
> +# define CRASH_ADDR_LOW_MAX	SZ_512M
> +# define CRASH_ADDR_HIGH_MAX	SZ_512M
>  #else
> -# define CRASH_ADDR_LOW_MAX	(896UL << 20)
> +# define CRASH_ADDR_LOW_MAX	SZ_4G
>  # define CRASH_ADDR_HIGH_MAX	MAXMEM
>  #endif

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
