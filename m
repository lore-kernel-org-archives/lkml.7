Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00F5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942AB2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfCXU6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:58:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44299 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfCXU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:58:38 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8ACQ-0006Pd-WD; Sun, 24 Mar 2019 21:58:35 +0100
Date:   Sun, 24 Mar 2019 21:58:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, thgarnie@google.com
Subject: Re: [PATCH v4 4/6] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
In-Reply-To: <20190314094645.4883-5-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1903242144160.1798@nanos.tec.linutronix.de>
References: <20190314094645.4883-1-bhe@redhat.com> <20190314094645.4883-5-bhe@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, Baoquan He wrote:
> In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> the initial size of the direct mapping region. This is correct in
> the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46 bits, and only 4-level mode was supported.
> 
> Later, in commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
> 5-level or 4-level. This is wrong for 4-level paging. Then when we
> adapt physical memory region size based on available memory, it
> will overflow if the amount of system RAM and the padding is bigger
> than 64 TB.

I have no idea what that sentence means and what will overflow. Neither I
have the time to stare at the code to figure it out. Changelogs need to be
self explanatory. Providing a simple example with numbers or an
illustration would be helpful.

> In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>

So this is an actual bug fix, which is in the middle of this series. Bug
fixes go first and need to be independent of the rest of the series.

They also need a Fixes: tag.

> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index d7ea6b252594..ebf6d1d92385 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -131,7 +131,7 @@ void __init kernel_randomize_memory(void)
>  	if (!kaslr_memory_enabled())
>  		return;
>  
> -	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> +	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;

That said, I surely can understand why this change needs to be done, but
the changelog needs to explain the issue so someone with less experience or
someone looking at this in a year from now doesn't have to bang his head
against the wall.

Thanks,

	tglx
