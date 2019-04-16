Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0BBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97621B26
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfDPNrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:47:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729596AbfDPNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:47:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GDlEKD060560
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:47:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rwe3k5v9k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:47:18 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Tue, 16 Apr 2019 14:46:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 14:46:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GDkMSN40894698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 13:46:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 983514C040;
        Tue, 16 Apr 2019 13:46:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326344C044;
        Tue, 16 Apr 2019 13:46:21 +0000 (GMT)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.33])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 13:46:21 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v12 20/31] mm: introduce vma reference counter
Date:   Tue, 16 Apr 2019 15:45:11 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-4275-0000-0000-000003287655
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-4276-0000-0000-00003837A75C
Message-Id: <20190416134522.17540-21-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final goal is to be able to use a VMA structure without holding the
mmap_sem and to be sure that the structure will not be freed in our back.

The lockless use of the VMA will be done through RCU protection and thus a
dedicated freeing service is required to manage it asynchronously.

As reported in a 2010's thread [1], this may impact file handling when a
file is still referenced while the mapping is no more there.  As the final
goal is to handle anonymous VMA in a speculative way and not file backed
mapping, we could close and free the file pointer in a synchronous way, as
soon as we are guaranteed to not use it without holding the mmap_sem. For
sanity reason, in a minimal effort, the vm_file file pointer is unset once
the file pointer is put.

[1] https://lore.kernel.org/linux-mm/20100104182429.833180340@chello.nl/

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 include/linux/mm.h       |  4 ++++
 include/linux/mm_types.h |  3 +++
 mm/internal.h            | 27 +++++++++++++++++++++++++++
 mm/mmap.c                | 13 +++++++++----
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f14b2c9ddfd4..f761a9c65c74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -529,6 +529,9 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	atomic_set(&vma->vm_ref_count, 1);
+#endif
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
@@ -1418,6 +1421,7 @@ static inline void INIT_VMA(struct vm_area_struct *vma)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 	seqcount_init(&vma->vm_sequence);
+	atomic_set(&vma->vm_ref_count, 1);
 #endif
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24b3f8ce9e42..6a6159e11a3f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -285,6 +285,9 @@ struct vm_area_struct {
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	atomic_t vm_ref_count;
+#endif
 	struct rb_node vm_rb;
 
 	/*
diff --git a/mm/internal.h b/mm/internal.h
index 9eeaf2b95166..302382bed406 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -40,6 +40,33 @@ void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
+
+extern void __free_vma(struct vm_area_struct *vma);
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static inline void get_vma(struct vm_area_struct *vma)
+{
+	atomic_inc(&vma->vm_ref_count);
+}
+
+static inline void put_vma(struct vm_area_struct *vma)
+{
+	if (atomic_dec_and_test(&vma->vm_ref_count))
+		__free_vma(vma);
+}
+
+#else
+
+static inline void get_vma(struct vm_area_struct *vma)
+{
+}
+
+static inline void put_vma(struct vm_area_struct *vma)
+{
+	__free_vma(vma);
+}
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index f7f6027a7dff..c106440dcae7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -188,6 +188,12 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
 }
 #endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
 
+void __free_vma(struct vm_area_struct *vma)
+{
+	mpol_put(vma_policy(vma));
+	vm_area_free(vma);
+}
+
 /*
  * Close a vm structure and free it, returning the next.
  */
@@ -200,8 +206,8 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
-	mpol_put(vma_policy(vma));
-	vm_area_free(vma);
+	vma->vm_file = NULL;
+	put_vma(vma);
 	return next;
 }
 
@@ -990,8 +996,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		if (next->anon_vma)
 			anon_vma_merge(vma, next);
 		mm->map_count--;
-		mpol_put(vma_policy(next));
-		vm_area_free(next);
+		put_vma(next);
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
 		 * we must remove another next too. It would clutter
-- 
2.21.0

