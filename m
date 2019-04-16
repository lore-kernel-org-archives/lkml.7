Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1EC20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gecAjpj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfDPRLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:11:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbfDPRLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:11:10 -0400
Received: from zn.tnic (p200300EC2F0D69007D63E3F8FEB0C818.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:7d63:e3f8:feb0:c818])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A7011EC05B5;
        Tue, 16 Apr 2019 19:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555434668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9o6VSwwM5Gkhp0iqpea1qTmNdJF6G4fdFCgdaUfXL2M=;
        b=gecAjpj3GXtyyh1mWLr6spDIZShgv3rrxE2LzgMUIb6nDGYkg4MW96RRJputMjKL+xCXwV
        /vlEN+lwNhtfI4o3vJyw+WXbJ0Xbtjyj+vfVQTBiTxsL9AOGZ/G0OIndKXZnymUZAnEFej
        vV3fUByytoSJVB6bPhQdvJXGTMJc3gM=
Date:   Tue, 16 Apr 2019 19:11:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190416171104.GI31772@zn.tnic>
References: <20190409040502.55361-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409040502.55361-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Brijesh.

On Tue, Apr 09, 2019 at 12:05:02AM -0400, Qian Cai wrote:
> The first kmemleak_scan() after boot would trigger a crash below because
> 
> kernel_init
>   free_initmem
>     mem_encrypt_free_decrypted_mem
>       free_init_pages
> 
> unmapped some memory inside the .bss.
> 
> BUG: unable to handle kernel paging request at ffffffffbd402000
> CPU: 12 PID: 325 Comm: kmemleak Not tainted 5.1.0-rc4+ #4
> RIP: 0010:scan_block+0x58/0x160
> Call Trace:
>  scan_gray_list+0x1d9/0x280
>  kmemleak_scan+0x485/0xad0
>  kmemleak_scan_thread+0x9f/0xc4
>  kthread+0x1d2/0x1f0
>  ret_from_fork+0x35/0x40
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/mem_encrypt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 385afa2b9e17..614ab156024f 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -18,6 +18,7 @@
>  #include <linux/dma-direct.h>
>  #include <linux/swiotlb.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/kmemleak.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -369,6 +370,11 @@ void __init mem_encrypt_free_decrypted_mem(void)
>  		}
>  	}
>  
> +	/*
> +	 * Inform kmemleak about the hole in the .bss section since the
> +	 * corresponding pages will be unmapped with DEBUG_PAGEALLOC=y.
> +	 */
> +	kmemleak_free_part((void *)vaddr, vaddr_end - vaddr);
>  	free_init_pages("unused decrypted", vaddr, vaddr_end);

I don't understand what the logic here is: we have a couple of other
free_init_pages() calls but they don't have kmemleak_free_part() in
front.

Now, if kmemleak needs to be told that memory is getting freed, why
isn't kmemleak_free_part() called in free_init_pages() ?

This needs more explanation.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
