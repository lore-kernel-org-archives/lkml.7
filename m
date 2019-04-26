Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1CB206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfDZGqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:46:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfDZGqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:46:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q6ciFF075566
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3u2ymn1m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 26 Apr 2019 07:45:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 07:45:54 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3Q6jrm050855956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 06:45:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE85A405B;
        Fri, 26 Apr 2019 06:45:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6EDBA405F;
        Fri, 26 Apr 2019 06:45:51 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 06:45:51 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] powerpc/mm: remove a couple of #ifdef CONFIG_PPC_64K_PAGES in mm/slice.c
In-Reply-To: <cf8573caf0896a7a1a7fee72280ca09f7096923b.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr> <cf8573caf0896a7a1a7fee72280ca09f7096923b.1556202029.git.christophe.leroy@c-s.fr>
Date:   Fri, 26 Apr 2019 12:10:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-4275-0000-0000-0000032E6D18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-4276-0000-0000-0000383DBC47
Message-Id: <87tvel9slg.fsf@linux.ibm.com>
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

> This patch replaces a couple of #ifdef CONFIG_PPC_64K_PAGES
> by IS_ENABLED(CONFIG_PPC_64K_PAGES) to improve code maintainability.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/slice.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 840c4118a185..ace97d953040 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -606,14 +606,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	newaddr = slice_find_area(mm, len, &potential_mask,
>  				  psize, topdown, high_limit);
>  
> -#ifdef CONFIG_PPC_64K_PAGES
> -	if (newaddr == -ENOMEM && psize == MMU_PAGE_64K) {
> +	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && newaddr == -ENOMEM &&
> +	    psize == MMU_PAGE_64K) {
>  		/* retry the search with 4k-page slices included */
>  		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
>  		newaddr = slice_find_area(mm, len, &potential_mask,
>  					  psize, topdown, high_limit);
>  	}
> -#endif
>  
>  	if (newaddr == -ENOMEM)
>  		return -ENOMEM;
> @@ -784,9 +783,9 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>  	VM_BUG_ON(radix_enabled());
>  
>  	maskp = slice_mask_for_size(&mm->context, psize);
> -#ifdef CONFIG_PPC_64K_PAGES
> +
>  	/* We need to account for 4k slices too */
> -	if (psize == MMU_PAGE_64K) {
> +	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
>  		const struct slice_mask *compat_maskp;
>  		struct slice_mask available;
>  
> @@ -794,7 +793,6 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>  		slice_or_mask(&available, maskp, compat_maskp);
>  		return !slice_check_range_fits(mm, &available, addr, len);
>  	}
> -#endif
>  
>  	return !slice_check_range_fits(mm, maskp, addr, len);
>  }
> -- 
> 2.13.3

