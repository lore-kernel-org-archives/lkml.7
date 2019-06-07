Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1967C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C8E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WM1e31oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfFGTwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:52:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFGTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:52:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57Ji7Pf098374;
        Fri, 7 Jun 2019 19:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=h20eNXbF2T9I6EYxoI8GMMkB1AYu7GLH9AgHVLr4/0A=;
 b=WM1e31oaMITDOzHOc7spEYmLnA1r4jVcBXtMdHMDe75ySBEwQ/6nbVOESV9POrXXK2bp
 jpjSJASp4VTSOk8CJs0zgNOUsDGHojKRIX0ng6VXuDt2pWW5YHSYo93BFCU/iyVc/4gU
 s16gib10EfXfu9s56D1G+SYsb/Zs7wQXU9VK4nTqLzx1mS/PbFiqIBiIOpWXZAzMhXxn
 EmcjWjZz+4jjDSYKcQvQI2vGDALk6FTqJ+hcR/LUQBvmWgr8Ahai5BXVoF5/kFPt80Si
 sQten/L/iC/rFfB9RGGuv6FDb1KHKqp89rdkcDIhVvN4bl5uqDOyhQY4u60d8ZGTYgDc Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2suj0r05yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 19:52:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57Jp7DQ022696;
        Fri, 7 Jun 2019 19:52:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2swngn8kce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 19:52:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57JqS5p019893;
        Fri, 7 Jun 2019 19:52:28 GMT
Received: from oracle.com (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 12:52:28 -0700
From:   Larry Bassel <larry.bassel@oracle.com>
To:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     Larry Bassel <larry.bassel@oracle.com>
Subject: [RFC PATCH v2 1/2] Rename CONFIG_ARCH_WANT_HUGE_PMD_SHARE to CONFIG_ARCH_HAS_HUGE_PMD_SHARE
Date:   Fri,  7 Jun 2019 12:51:02 -0700
Message-Id: <1559937063-8323-2-git-send-email-larry.bassel@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
References: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 arch/arm64/Kconfig          | 2 +-
 arch/arm64/mm/hugetlbpage.c | 2 +-
 arch/x86/Kconfig            | 2 +-
 mm/hugetlb.c                | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea05..36d6189 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -901,7 +901,7 @@ config HW_PERF_EVENTS
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
-config ARCH_WANT_HUGE_PMD_SHARE
+config ARCH_HAS_HUGE_PMD_SHARE
 	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 
 config ARCH_HAS_CACHE_LINE_SIZE
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f475e54..4f3cb3f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -241,7 +241,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		 */
 		ptep = pte_alloc_map(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
-		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
+		if (IS_ENABLED(CONFIG_ARCH_HAS_HUGE_PMD_SHARE) &&
 		    pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, addr, pudp);
 		else
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d..fdbddb9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -301,7 +301,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-config ARCH_WANT_HUGE_PMD_SHARE
+config ARCH_HAS_HUGE_PMD_SHARE
 	def_bool y
 
 config ARCH_WANT_GENERAL_HUGETLB
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac843d3..3a54c9d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4652,7 +4652,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+#ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
 static unsigned long page_table_shareable(struct vm_area_struct *svma,
 				struct vm_area_struct *vma,
 				unsigned long addr, pgoff_t idx)
@@ -4807,7 +4807,7 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	return 1;
 }
 #define want_pmd_share()	(1)
-#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+#else /* !CONFIG_ARCH_HAS_HUGE_PMD_SHARE */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
 	return NULL;
@@ -4823,7 +4823,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 {
 }
 #define want_pmd_share()	(0)
-#endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+#endif /* CONFIG_ARCH_HAS_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 pte_t *huge_pte_alloc(struct mm_struct *mm,
-- 
1.8.3.1

