Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0207222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOx/61N0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKLTq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:46:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:46:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACJhqWI145328;
        Tue, 12 Nov 2019 19:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=h8q93y3xwYBSDhB2y/fm8YR2reNtkgSZaYrPEBHtLt8=;
 b=gOx/61N04CYfS8WWw3AJPLBCbLnDO4KlY8B6/uen28vnERZeGHqT2HuEqw7JWw+4Y/d0
 oFS/Anu4nl9xgWlHRHbNZRiUSzChapRgAuUetiUmuxpBdiNzF4EGB+CysXIj7mHqRJWY
 hEbd6zXAJkEpSOOfX19BeZxyvWei+6xy7qoP697Xwf6yVWDmGFNToU1DtHYWgZARMcvs
 LMHBIO4uT5NiDbgEpFxxWj8+GnR1EH3NNdGB/gKIhzsX9yo04Tmt50Kf+oYU8m+4aNWR
 7dHbgpFBgVFDfn3JtQE+Br3SsL9FqKMnBaSVmxA2k3+BxCVPcXc3hc6yMGutVuAWK+pJ 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w5mvtq81w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:46:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACJbfoO123412;
        Tue, 12 Nov 2019 19:46:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w7j02grgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:46:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xACJk7gj031577;
        Tue, 12 Nov 2019 19:46:08 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 11:46:07 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, kbuild@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/2] powerpc/mm: remove pmd_huge/pud_huge stubs and include hugetlb.h
Date:   Tue, 12 Nov 2019 11:45:57 -0800
Message-Id: <20191112194558.139389-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112194558.139389-1-mike.kravetz@oracle.com>
References: <20191112194558.139389-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the power specific stubs created by commit aad71e3928be
("powerpc/mm: Fix build break with RADIX=y & HUGETLBFS=n") used when
!CONFIG_HUGETLB_PAGE.  Instead, it addresses the build break by
getting the definitions from <linux/hugetlb.h>.  This allows the
macros in <linux/hugetlb.h> to be replaced with static inlines.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  | 3 ---
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 3 ---
 arch/powerpc/mm/book3s64/radix_pgtable.c         | 1 +
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index a069dfcac9a9..4e697bc2f4cd 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -70,9 +70,6 @@ static inline int get_hugepd_cache_index(int index)
 	/* should not reach */
 }
 
-#else /* !CONFIG_HUGETLB_PAGE */
-static inline int pmd_huge(pmd_t pmd) { return 0; }
-static inline int pud_huge(pud_t pud) { return 0; }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index e3d4dd4ae2fa..34d1018896b3 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -59,9 +59,6 @@ static inline int get_hugepd_cache_index(int index)
 	BUG();
 }
 
-#else /* !CONFIG_HUGETLB_PAGE */
-static inline int pmd_huge(pmd_t pmd) { return 0; }
-static inline int pud_huge(pud_t pud) { return 0; }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 6ee17d09649c..974109bb85db 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -13,6 +13,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 #include <linux/string_helpers.h>
 #include <linux/stop_machine.h>
 
-- 
2.23.0

