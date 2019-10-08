Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC2ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174020673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfJHLb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:31:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34431 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfJHLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:31:57 -0400
X-Originating-IP: 81.185.168.180
Received: from [192.168.43.237] (180.168.185.81.rev.sfr.net [81.185.168.180])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4F5AEFF809;
        Tue,  8 Oct 2019 11:31:43 +0000 (UTC)
Subject: Re: [PATCH v11 07/22] riscv: mm: Add p?d_leaf() definitions
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
References: <20191007153822.16518-1-steven.price@arm.com>
 <20191007153822.16518-8-steven.price@arm.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <69a56736-4093-202a-4eaf-feeaaa0216d1@ghiti.fr>
Date:   Tue, 8 Oct 2019 07:31:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007153822.16518-8-steven.price@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 11:38 AM, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_leaf() functions/macros.
>
> For riscv a page is a leaf page when it has a read, write or execute bit
> set on it.
>
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/riscv/include/asm/pgtable-64.h | 7 +++++++
>   arch/riscv/include/asm/pgtable.h    | 7 +++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 74630989006d..e88a8e8acbdf 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -43,6 +43,13 @@ static inline int pud_bad(pud_t pud)
>   	return !pud_present(pud);
>   }
>   
> +#define pud_leaf	pud_leaf
> +static inline int pud_leaf(pud_t pud)
> +{
> +	return pud_present(pud)
> +		&& (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>   static inline void set_pud(pud_t *pudp, pud_t pud)
>   {
>   	*pudp = pud;
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7255f2d8395b..b9a679153265 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -130,6 +130,13 @@ static inline int pmd_bad(pmd_t pmd)
>   	return !pmd_present(pmd);
>   }
>   
> +#define pmd_leaf	pmd_leaf
> +static inline int pmd_leaf(pmd_t pmd)
> +{
> +	return pmd_present(pmd)
> +		&& (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +}
> +
>   static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>   {
>   	*pmdp = pmd;

Hi Steven,

The way you check leaf entries is correct: we do the same for hugepages. 
So is
there a reason you did not use the pmd/pud_huge functions that are 
defined in
arch/riscv/mm/hugetlbpage.c ?

Anyway, FWIW:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex

