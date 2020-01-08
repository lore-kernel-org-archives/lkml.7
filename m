Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8AC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD977206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAHLWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:22:35 -0500
Received: from foss.arm.com ([217.140.110.172]:42756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgAHLWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:22:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AAFD30E;
        Wed,  8 Jan 2020 03:22:34 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22C303F703;
        Wed,  8 Jan 2020 03:22:30 -0800 (PST)
Date:   Wed, 8 Jan 2020 11:22:22 +0000
From:   Steven Price <steven.price@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        James Morse <James.Morse@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: pagewalk: fix unused variable warning
Message-ID: <20200108112221.GA37977@arm.com>
References: <20200107204607.1533842-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107204607.1533842-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 08:45:50PM +0000, Arnd Bergmann wrote:
> One of the pagewalk patches introduced a harmless warning:
> 
> mm/hmm.c: In function 'hmm_vma_walk_pud':
> mm/hmm.c:478:9: error: unused variable 'pmdp' [-Werror=unused-variable]
>   pmd_t *pmdp;
>          ^~~~
> mm/hmm.c:477:30: error: unused variable 'next' [-Werror=unused-variable]
>   unsigned long addr = start, next;
>                               ^~~~
> 
> Remove both of the now-unused variables.
> 
> Fixes: cb4d03d5fb4c ("mm: pagewalk: add p4d_entry() and pgd_entry()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Gah! Sorry about that, thanks for fixing it up.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  mm/hmm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index a71295e99968..72e5a6d9a417 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -474,8 +474,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
> -	unsigned long addr = start, next;
> -	pmd_t *pmdp;
> +	unsigned long addr = start;
>  	pud_t pud;
>  	int ret = 0;
>  	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
> -- 
> 2.20.0
> 
