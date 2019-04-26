Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E39206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:45:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfDZGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:45:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q6dN6X121478
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:22 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3vjmh5mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:45:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 26 Apr 2019 07:45:20 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 07:45:16 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3Q6jFsP41222220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 06:45:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 912A7A4059;
        Fri, 26 Apr 2019 06:45:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01607A405D;
        Fri, 26 Apr 2019 06:45:14 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.193.89.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 06:45:13 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] powerpc/mm: fix erroneous duplicate slb_addr_limit init
In-Reply-To: <3814377306ac3acdd404e2f23ff05dcf7e6bee26.1556202029.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr> <3814377306ac3acdd404e2f23ff05dcf7e6bee26.1556202029.git.christophe.leroy@c-s.fr>
Date:   Fri, 26 Apr 2019 12:02:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19042606-0028-0000-0000-000003675F3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042606-0029-0000-0000-00002426B888
Message-Id: <878svxb7jj.fsf@linux.ibm.com>
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

> Commit 67fda38f0d68 ("powerpc/mm: Move slb_addr_linit to
> early_init_mmu") moved slb_addr_limit init out of setup_arch().
>
> Commit 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t
> for radix") brought it back into setup_arch() by error.
>
> This patch reverts that erroneous regress.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t for radix")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/setup-common.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 1729bf409562..7af085b38cd1 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -950,12 +950,6 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.end_data = (unsigned long) _edata;
>  	init_mm.brk = klimit;
>  
> -#ifdef CONFIG_PPC_MM_SLICES
> -#if defined(CONFIG_PPC_8xx)
> -	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> -#endif
> -#endif
> -
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  	mm_iommu_init(&init_mm);
>  #endif
> -- 
> 2.13.3

