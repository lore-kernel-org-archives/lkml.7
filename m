Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66F821841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDKFHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbfDKFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:07:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B4xsLo014455
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:07:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rswg0uqsf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:07:08 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 11 Apr 2019 06:07:06 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 06:07:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B572XI50069724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 05:07:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B224AE059;
        Thu, 11 Apr 2019 05:07:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD1C2AE045;
        Thu, 11 Apr 2019 05:07:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.73.26])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 05:07:00 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/15] Refactor pgalloc stuff
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
Date:   Thu, 11 Apr 2019 10:36:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041105-0020-0000-0000-0000032E9247
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041105-0021-0000-0000-00002180C04A
Message-Id: <87wok13zbg.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This series converts book3e64 to pte_fragment and refactor
> things that are common among subarches.
>
> Christophe Leroy (15):
>   powerpc/mm: drop __bad_pte()
>   powerpc/mm: define __pud_free_tlb() at all time on nohash/64
>   powerpc/mm: convert Book3E 64 to pte_fragment
>   powerpc/mm: move pgtable_t in asm/mmu.h
>   powerpc/mm: get rid of nohash/32/mmu.h and nohash/64/mmu.h
>   powerpc/Kconfig: select PPC_MM_SLICES from subarch type
>   powerpc/book3e: move early_alloc_pgtable() to init section
>   powerpc/mm: don't use pte_alloc_kernel() until slab is available on
>     PPC32
>   powerpc/mm: inline pte_alloc_one_kernel() and pte_alloc_one() on PPC32
>   powerpc/mm: refactor pte_alloc_one() and pte_free() families
>     definition.
>   powerpc/mm: refactor definition of pgtable_cache[]
>   powerpc/mm: Only keep one version of pmd_populate() functions on
>     nohash/32
>   powerpc/mm: refactor pgtable freeing functions on nohash
>   powerpc/mm: refactor pmd_pgtable()
>   powerpc/mm: refactor pgd_alloc() and pgd_free() on nohash
>
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |   4 -
>  arch/powerpc/include/asm/book3s/32/pgalloc.h  |  41 ---------
>  arch/powerpc/include/asm/book3s/64/mmu.h      |   8 --
>  arch/powerpc/include/asm/book3s/64/pgalloc.h  |  49 ----------
>  arch/powerpc/include/asm/mmu.h                |   3 +
>  arch/powerpc/include/asm/mmu_context.h        |   6 --
>  arch/powerpc/include/asm/nohash/32/mmu.h      |  25 ------
>  arch/powerpc/include/asm/nohash/32/pgalloc.h  | 123 ++------------------------
>  arch/powerpc/include/asm/nohash/64/mmu.h      |  12 ---
>  arch/powerpc/include/asm/nohash/64/pgalloc.h  | 117 +-----------------------
>  arch/powerpc/include/asm/nohash/mmu.h         |  16 +++-
>  arch/powerpc/include/asm/nohash/pgalloc.h     |  56 ++++++++++++
>  arch/powerpc/include/asm/pgalloc.h            |  51 +++++++++++
>  arch/powerpc/mm/Makefile                      |   4 +-
>  arch/powerpc/mm/mmu_context.c                 |   2 +-
>  arch/powerpc/mm/pgtable-book3e.c              |   4 +-
>  arch/powerpc/mm/pgtable_32.c                  |  42 +++++----
>  arch/powerpc/platforms/Kconfig.cputype        |   4 +-
>  18 files changed, 165 insertions(+), 402 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
>  delete mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
>
> -- 
> 2.13.3

Looks good. You can add for the series

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> 

