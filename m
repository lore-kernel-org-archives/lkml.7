Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F121C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9320645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfDSTD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDSTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:27 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHRBB-0002lN-E1; Fri, 19 Apr 2019 12:55:37 +0200
Date:   Fri, 19 Apr 2019 12:55:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <20190401141549.3F4721FE@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
References: <20190401141549.3F4721FE@viggo.jf.intel.com>
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

On Mon, 1 Apr 2019, Dave Hansen wrote:
> diff -puN mm/mmap.c~mpx-rss-pass-no-vma mm/mmap.c
> --- a/mm/mmap.c~mpx-rss-pass-no-vma	2019-04-01 06:56:53.409411123 -0700
> +++ b/mm/mmap.c	2019-04-01 06:56:53.423411123 -0700
> @@ -2731,9 +2731,17 @@ int __do_munmap(struct mm_struct *mm, un
>  		return -EINVAL;
>  
>  	len = PAGE_ALIGN(len);
> +	end = start + len;
>  	if (len == 0)
>  		return -EINVAL;
>  
> +	/*
> +	 * arch_unmap() might do unmaps itself.  It must be called
> +	 * and finish any rbtree manipulation before this code
> +	 * runs and also starts to manipulate the rbtree.
> +	 */
> +	arch_unmap(mm, start, end);

...
  
> -static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
> -			      unsigned long start, unsigned long end)
> +static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
> +			      unsigned long end)

While you fixed up the asm-generic thing, this breaks arch/um and
arch/unicorn32. For those the fixup is trivial by removing the vma
argument.

But itt also breaks powerpc and there I'm not sure whether moving
arch_unmap() to the beginning of __do_munmap() is safe. Micheal???

Aside of that the powerpc variant looks suspicious:

static inline void arch_unmap(struct mm_struct *mm,
                              unsigned long start, unsigned long end)
{
 	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
                mm->context.vdso_base = 0;
}

Shouldn't that be: 

 	if (start >= mm->context.vdso_base && mm->context.vdso_base < end)

Hmm?

Thanks,

	tglx

