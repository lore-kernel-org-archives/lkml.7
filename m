Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA7C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8935B2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCNFxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:53:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfCNFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:53:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E5nG7V041970
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:53:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7gsqgue5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:53:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 14 Mar 2019 05:52:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 05:52:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2E5qmkN29294708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 05:52:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689BBAE05D;
        Thu, 14 Mar 2019 05:52:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5193AE056;
        Thu, 14 Mar 2019 05:52:43 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.31.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 05:52:43 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
In-Reply-To: <20190307132015.26970-5-alex@ghiti.fr>
References: <20190307132015.26970-1-alex@ghiti.fr> <20190307132015.26970-5-alex@ghiti.fr>
Date:   Thu, 14 Mar 2019 11:22:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19031405-0028-0000-0000-00000353D00E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031405-0029-0000-0000-000024125AE4
Message-Id: <87va0movdh.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alex@ghiti.fr> writes:

> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
> ---
>  arch/arm64/Kconfig                           |  2 +-
>  arch/arm64/include/asm/hugetlb.h             |  4 --
>  arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>  arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>  arch/s390/Kconfig                            |  2 +-
>  arch/s390/include/asm/hugetlb.h              |  3 --
>  arch/sh/Kconfig                              |  2 +-
>  arch/sparc/Kconfig                           |  2 +-
>  arch/x86/Kconfig                             |  2 +-
>  arch/x86/include/asm/hugetlb.h               |  4 --
>  include/linux/gfp.h                          |  2 +-
>  mm/hugetlb.c                                 | 57 ++++++++++++--------
>  mm/page_alloc.c                              |  4 +-
>  13 files changed, 44 insertions(+), 49 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 091a513b93e9..af687eff884a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -18,7 +18,7 @@ config ARM64
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
> +	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index fb6609875455..59893e766824 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -65,8 +65,4 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #include <asm-generic/hugetlb.h>
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void) { return true; }
> -#endif
> -
>  #endif /* __ASM_HUGETLB_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 5b0177733994..d04a0bcc2f1c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -32,13 +32,6 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  	}
>  }
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void)
> -{
> -	return true;
> -}
> -#endif
> -
>  /* hugepd entry valid bit */
>  #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
>  

As explained in https://patchwork.ozlabs.org/patch/1047003/
architectures like ppc64 have a hypervisor assisted mechanism to indicate
where to find gigantic huge pages(16G pages). At this point, we don't use this
reserved pages for anything other than hugetlb backing and hence there
is no runtime free of this pages needed ( Also we don't do
runtime allocation of them).

I guess you can still achieve what you want to do in this patch by
keeping gigantic_page_supported()?

NOTE: We should rename gigantic_page_supported to be more specific to
support for runtime_alloc/free of gigantic pages

-aneesh

