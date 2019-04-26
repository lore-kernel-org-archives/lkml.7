Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDZGpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:45:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfDZGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:45:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q6ck8I069858
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3sa58npa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 26 Apr 2019 07:45:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 07:45:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3Q6jkGG49873026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 06:45:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78CFE4203F;
        Fri, 26 Apr 2019 06:45:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E130642045;
        Fri, 26 Apr 2019 06:45:44 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 06:45:44 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] powerpc/mm: get rid of mm_ctx_slice_mask_xxx()
In-Reply-To: <cc95821273df454eb146871bf6e5eeabef7c4ac9.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr> <cc95821273df454eb146871bf6e5eeabef7c4ac9.1556202029.git.christophe.leroy@c-s.fr>
Date:   Fri, 26 Apr 2019 12:07:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-0020-0000-0000-000003365EFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-0021-0000-0000-00002188CE73
Message-Id: <87wojh9srb.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Now that slice_mask_for_size() is in mmu.h, the mm_ctx_slice_mask_xxx()
> are not needed anymore, so drop them. Note that the 8xx ones where
> not used anyway.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h     | 32 ++++------------------------
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 17 ---------------
>  2 files changed, 4 insertions(+), 45 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index ad00355f874f..e3d7f1404e20 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -179,45 +179,21 @@ static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long li
>  	ctx->hash_context->slb_addr_limit = limit;
>  }
>  
> -#ifdef CONFIG_PPC_64K_PAGES
> -static inline struct slice_mask *mm_ctx_slice_mask_64k(mm_context_t *ctx)
> -{
> -	return &ctx->hash_context->mask_64k;
> -}
> -#endif
> -
> -static inline struct slice_mask *mm_ctx_slice_mask_4k(mm_context_t *ctx)
> -{
> -	return &ctx->hash_context->mask_4k;
> -}
> -
> -#ifdef CONFIG_HUGETLB_PAGE
> -static inline struct slice_mask *mm_ctx_slice_mask_16m(mm_context_t *ctx)
> -{
> -	return &ctx->hash_context->mask_16m;
> -}
> -
> -static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
> -{
> -	return &ctx->hash_context->mask_16g;
> -}
> -#endif
> -
>  static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
>  {
>  #ifdef CONFIG_PPC_64K_PAGES
>  	if (psize == MMU_PAGE_64K)
> -		return mm_ctx_slice_mask_64k(&ctx);
> +		return &ctx->hash_context->mask_64k;
>  #endif
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (psize == MMU_PAGE_16M)
> -		return mm_ctx_slice_mask_16m(&ctx);
> +		return &ctx->hash_context->mask_16m;
>  	if (psize == MMU_PAGE_16G)
> -		return mm_ctx_slice_mask_16g(&ctx);
> +		return &ctx->hash_context->mask_16g;
>  #endif
>  	VM_BUG_ON(psize != MMU_PAGE_4K);
>  
> -	return mm_ctx_slice_mask_4k(&ctx);
> +	return &ctx->hash_context->mask_4k;
>  }
>  
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> index a0f6844a1498..beded4df1f50 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> @@ -255,23 +255,6 @@ static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long li
>  	ctx->slb_addr_limit = limit;
>  }
>  
> -static inline struct slice_mask *mm_ctx_slice_mask_base(mm_context_t *ctx)
> -{
> -	return &ctx->mask_base_psize;
> -}
> -
> -#ifdef CONFIG_HUGETLB_PAGE
> -static inline struct slice_mask *mm_ctx_slice_mask_512k(mm_context_t *ctx)
> -{
> -	return &ctx->mask_512k;
> -}
> -
> -static inline struct slice_mask *mm_ctx_slice_mask_8m(mm_context_t *ctx)
> -{
> -	return &ctx->mask_8m;
> -}
> -#endif
> -
>  static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
>  {
>  #ifdef CONFIG_HUGETLB_PAGE
> -- 
> 2.13.3

