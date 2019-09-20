Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FBB20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfITTwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436819AbfITTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:52:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KJlwQP134589;
        Fri, 20 Sep 2019 15:51:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v53ju40ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 15:51:50 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8KJn4bt144821;
        Fri, 20 Sep 2019 15:51:50 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v53ju40e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 15:51:50 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8KJoHCX015549;
        Fri, 20 Sep 2019 19:51:48 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 2v3vbu8p4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 19:51:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8KJplkp52625704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 19:51:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 651037805E;
        Fri, 20 Sep 2019 19:51:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B6B78063;
        Fri, 20 Sep 2019 19:51:42 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.184])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Sep 2019 19:51:42 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 06/11] powerpc/mm/book3s64/hash: Applies counting method to monitor lockless pgtbl walks
Date:   Fri, 20 Sep 2019 16:50:42 -0300
Message-Id: <20190920195047.7703-7-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920195047.7703-1-leonardo@linux.ibm.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=754 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909200161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applies the counting-based method for monitoring all hash-related functions
that do lockless pagetable walks.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c   | 2 ++
 arch/powerpc/mm/book3s64/hash_utils.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 4a70d8dd39cd..5e5213c3f7c4 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -209,6 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	 * to being hashed). This is not the most performance oriented
 	 * way to do things but is fine for our needs here.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
@@ -230,6 +231,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	}
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b8ad14bb1170..299946cedc3a 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1322,6 +1322,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
+	start_lockless_pgtbl_walk(mm);
 	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
@@ -1438,6 +1439,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	DBG_LOW(" -> rc=%d\n", rc);
 
 bail:
+	end_lockless_pgtbl_walk(mm);
 	exception_exit(prev_state);
 	return rc;
 }
@@ -1547,10 +1549,12 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
+
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 
 	/*
@@ -1597,6 +1601,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   pte_val(*ptep));
 out_exit:
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
@@ -1613,11 +1618,13 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 	if (!mm || !mm->pgd)
 		return 0;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
 	if (ptep)
 		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 
 	return pkey;
 }
-- 
2.20.1

