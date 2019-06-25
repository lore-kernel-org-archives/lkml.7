Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B05C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595392085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfFYTE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:04:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfFYTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:04:55 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfqkC-0006TO-T1; Tue, 25 Jun 2019 21:04:41 +0200
Date:   Tue, 25 Jun 2019 21:04:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/boot/64: Fix crash if kernel images crosses page
 table boundary
In-Reply-To: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906252100290.32342@nanos.tec.linutronix.de>
References: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
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

On Thu, 20 Jun 2019, Kirill A. Shutemov wrote:
> @@ -190,18 +190,18 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
>  		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
>  
> -		i = (physaddr >> P4D_SHIFT) % PTRS_PER_P4D;
> -		p4d[i + 0] = (pgdval_t)pud + pgtable_flags;
> -		p4d[i + 1] = (pgdval_t)pud + pgtable_flags;
> +		i = physaddr >> P4D_SHIFT;
> +		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
> +		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
>  	} else {
>  		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
>  		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
>  		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
>  	}
>  
> -	i = (physaddr >> PUD_SHIFT) % PTRS_PER_PUD;
> -	pud[i + 0] = (pudval_t)pmd + pgtable_flags;
> -	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
> +	i = physaddr >> PUD_SHIFT;
> +	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
> +	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
>  
>  	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
>  	/* Filter out unsupported __PAGE_KERNEL_* bits: */
> @@ -211,8 +211,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	pmd_entry +=  physaddr;
>  
>  	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
> -		int idx = i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
> -		pmd[idx] = pmd_entry + i * PMD_SIZE;
> +		int idx = i + (physaddr >> PMD_SHIFT);;

double semicolon

> +		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;

This part is functionally equivivalent. So what's the value of this change?

Thanks,

	tglx


