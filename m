Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEAAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898BD2187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lvr3Drg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgAGVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:00:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4752 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgAGVAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14f1260000>; Tue, 07 Jan 2020 12:59:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 13:00:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 13:00:06 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:00:05 +0000
Subject: Re: [PATCH] mm: pagewalk: fix unused variable warning
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        "Andy Lutomirski" <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Ralph Campbell <rcampbell@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20200107204607.1533842-1-arnd@arndb.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <06c40b1a-7843-032e-0fdd-595a3218a93b@nvidia.com>
Date:   Tue, 7 Jan 2020 13:00:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107204607.1533842-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578430758; bh=2y9SbDifCqydLsranHq2MGk1cgxqovEofk7PktM8JC4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Lvr3Drg7yMYsKKJHWyrxpA58jVSoQ31IKCrCRfMgYqWis1QhgtabJ7AUQlW/eaBMF
         OAp4OrqBevGIRXv4cuuOmJz5B59a852m5k9DK5xvQhpRdT4jq7eIEobAcwExoT+tcS
         /dlqYVNYJw9MnY+XTvfBwerIuAoEKkDVmpeyjRsfvgpzQyodXITiLdyF2vUBuU89vW
         IyrpqSlhCbAlC7uqSAY36+8sHP4iq1Z6PaBrP9/gDO8IBlszoWbTpNSEMENRn9ziso
         /blWeUywiNoQBaMJrg4E7Ugn3k0SxE3D5VsWFauBVq4PI9qMlEIkcdyguobm3f+O0f
         FK4qpE5qnvDHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 12:45 PM, Arnd Bergmann wrote:
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
> ---
>  mm/hmm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

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
> 
