Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A181C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfDZGqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:46:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfDZGqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:46:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q6cjgT014721
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:46:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3umgusug-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:46:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 26 Apr 2019 07:46:04 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 07:46:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3Q6k0RJ58982634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 06:46:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AB8352057;
        Fri, 26 Apr 2019 06:46:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A47F52054;
        Fri, 26 Apr 2019 06:45:58 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] powerpc/mm: define get_slice_psize() all the time
In-Reply-To: <306daa20cb5b7c361b28831a190e45b16245779d.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr> <306daa20cb5b7c361b28831a190e45b16245779d.1556202029.git.christophe.leroy@c-s.fr>
Date:   Fri, 26 Apr 2019 12:12:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-0020-0000-0000-000003365F01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-0021-0000-0000-00002188CE76
Message-Id: <87r29p9sjk.fsf@linux.ibm.com>
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

> get_slice_psize() can be defined regardless of CONFIG_PPC_MM_SLICES
> to avoid ifdefs
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/slice.h | 5 +++++
>  arch/powerpc/mm/hugetlbpage.c    | 4 +---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
> index be8af667098f..c6f466f4c241 100644
> --- a/arch/powerpc/include/asm/slice.h
> +++ b/arch/powerpc/include/asm/slice.h
> @@ -36,6 +36,11 @@ void slice_setup_new_exec(void);
>  
>  static inline void slice_init_new_context_exec(struct mm_struct *mm) {}
>  
> +static inline unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_PPC_MM_SLICES */
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 9e732bb2c84a..5f67e7a4d1cc 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -578,14 +578,12 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>  {
> -#ifdef CONFIG_PPC_MM_SLICES
>  	/* With radix we don't use slice, so derive it from vma*/
> -	if (!radix_enabled()) {
> +	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled()) {
>  		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
>  
>  		return 1UL << mmu_psize_to_shift(psize);
>  	}
> -#endif
>  	return vma_kernel_pagesize(vma);
>  }
>  
> -- 
> 2.13.3

