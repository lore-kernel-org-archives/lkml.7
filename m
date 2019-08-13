Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A620842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfHMKJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728784AbfHMKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:09:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DA8BN7112575
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:09:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubsw2uh7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:09:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 13 Aug 2019 11:09:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Aug 2019 11:09:23 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7DA9Mcm50266166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 10:09:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D49BA405C;
        Tue, 13 Aug 2019 10:09:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 286A9A405B;
        Tue, 13 Aug 2019 10:09:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Aug 2019 10:09:21 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 13 Aug 2019 13:09:20 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] microblaze: switch to generic version of pte allocation
Date:   Tue, 13 Aug 2019 13:09:12 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19081310-0016-0000-0000-0000029E1D2F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081310-0017-0000-0000-000032FE30EB
Message-Id: <1565690952-32158-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microblaze implementation of pte_alloc_one() has a provision to
allocated PTEs from high memory, but neither CONFIG_HIGHPTE nor pte_map*()
versions for suitable for HIGHPTE are defined.

Except that, microblaze version of pte_alloc_one() is identical to the
generic one as well as the implementations of pte_free() and
pte_free_kernel().

Switch microblaze to use the generic versions of these functions.
Also remove pte_free_slow() that is not referenced anywhere in the code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
The patch is vs. mmots/master since this tree contains bothi "mm: remove
quicklist page table caches" and "mm: treewide: clarify
pgtable_page_{ctor,dtor}() naming" patches that had a conflict resulting in
a build failure [1].

[1] https://lore.kernel.org/linux-mm/201908131204.B910fkl1%25lkp@intel.com/

 arch/microblaze/include/asm/pgalloc.h | 39 +++--------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index dbf25a3..7ecb05b 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -21,6 +21,9 @@
 #include <asm/cache.h>
 #include <asm/pgtable.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#include <asm-generic/pgalloc.h>
+
 extern void __bad_pte(pmd_t *pmd);
 
 static inline pgd_t *get_pgd(void)
@@ -47,42 +50,6 @@ static inline void free_pgd(pgd_t *pgd)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *ptepage;
-
-#ifdef CONFIG_HIGHPTE
-	int flags = GFP_KERNEL | __GFP_ZERO | __GFP_HIGHMEM;
-#else
-	int flags = GFP_KERNEL | __GFP_ZERO;
-#endif
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free_slow(struct page *ptepage)
-{
-	__free_page(ptepage);
-}
-
-static inline void pte_free(struct mm_struct *mm, struct page *ptepage)
-{
-	pgtable_pte_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
 
 #define pmd_populate(mm, pmd, pte) \
-- 
2.7.4

