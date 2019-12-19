Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E43C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BF524672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MCXmEwVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLSLnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:43:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfLSLnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:43:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dqkr062jz9sQp;
        Thu, 19 Dec 2019 22:43:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576755798;
        bh=lcmpp8435heHWbtamXbY25s9q0noKpvN6s1RHv0A4dU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MCXmEwVeEGSrPzejttS1VELaA0lq2R8UNCc4QCqV43s78jIlcRjRXv1S8XBvlhbxW
         IkoYXHNqhQIeWBcAK6QQ13jD2l+4fY8dZxbNHccQLM7IXL5pmxQI8SonUryHqe143E
         Z00iIdazUTC/s2Q8EHdFfNg7Ozt6zULqhv2xHWD+R9htzkF/bRwYvd73/AOrTTEEzZ
         RF6zQlsPZB1V6Z45dFQG3KhR0AhsMDUNphcJKr7Glfg7XsKDR/CjV++nR30kBwX+Sf
         rXWV3SJUWjIFPjwluKiKRajaxNNvAsba4tI/inSmk+mwbxQYOB9QU/pZrP4DMMAjkc
         3czhs1rexhIeg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang\, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v17 01/23] mm: Add generic p?d_leaf() macros
In-Reply-To: <20191218162402.45610-2-steven.price@arm.com>
References: <20191218162402.45610-1-steven.price@arm.com> <20191218162402.45610-2-steven.price@arm.com>
Date:   Thu, 19 Dec 2019 22:43:14 +1100
Message-ID: <878sn8mtgt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Price <steven.price@arm.com> writes:
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
>
> For architectures that don't provide all p?d_leaf() macros, provide
> generic do nothing default that are suitable where there cannot be leaf
> pages at that level. Futher patches will add implementations for
> individual architectures.
>
> The name p?d_leaf() is chosen to minimize the confusion with existing
> uses of "large" pages and "huge" pages which do not necessary mean that
> the entry is a leaf (for example it may be a set of contiguous entries
> that only take 1 TLB slot). For the purpose of walking the page tables
> we don't need to know how it will be represented in the TLB, but we do
> need to know for sure if it is a leaf of the tree.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  include/asm-generic/pgtable.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 798ea36a0549..e2e2bef07dd2 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1238,4 +1238,24 @@ static inline bool arch_has_pfn_modify_check(void)
>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>  #endif
>  
> +/*
> + * p?d_leaf() - true if this entry is a final mapping to a physical address.
> + * This differs from p?d_huge() by the fact that they are always available (if
> + * the architecture supports large pages at the appropriate level) even
> + * if CONFIG_HUGETLB_PAGE is not defined.
> + * Only meaningful when called on a valid entry.
> + */
> +#ifndef pgd_leaf
> +#define pgd_leaf(x)	0
> +#endif
> +#ifndef p4d_leaf
> +#define p4d_leaf(x)	0
> +#endif
> +#ifndef pud_leaf
> +#define pud_leaf(x)	0
> +#endif
> +#ifndef pmd_leaf
> +#define pmd_leaf(x)	0
> +#endif

Any reason you made these #defines rather than static inlines?

cheers
