Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE38C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07C222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfDPNrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:47:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729672AbfDPNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:47:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GDlNP8091859
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:47:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwfsus807-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:47:30 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Tue, 16 Apr 2019 14:45:59 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 14:45:48 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GDjkYU44237050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 13:45:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29A84C050;
        Tue, 16 Apr 2019 13:45:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 601804C062;
        Tue, 16 Apr 2019 13:45:45 +0000 (GMT)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.33])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 13:45:45 +0000 (GMT)
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
Subject: [PATCH v12 08/31] mm: introduce INIT_VMA()
Date:   Tue, 16 Apr 2019 15:44:59 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-0016-0000-0000-0000026F726C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-0017-0000-0000-000032CBBD7E
Message-Id: <20190416134522.17540-9-ldufour@linux.ibm.com>
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

Some VMA struct fields need to be initialized once the VMA structure is
allocated.
Currently this only concerns anon_vma_chain field but some other will be
added to support the speculative page fault.

Instead of spreading the initialization calls all over the code, let's
introduce a dedicated inline function.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 fs/exec.c          | 1 +
 include/linux/mm.h | 5 +++++
 kernel/fork.c      | 2 +-
 mm/mmap.c          | 3 +++
 mm/nommu.c         | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2e0033348d8e..9762e060295c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -266,6 +266,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 	vma->vm_start = vma->vm_end - PAGE_SIZE;
 	vma->vm_flags = VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+	INIT_VMA(vma);
 
 	err = insert_vm_struct(mm, vma);
 	if (err)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4ba2f53f9d60..2ceb1d2869a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1407,6 +1407,11 @@ struct zap_details {
 	pgoff_t last_index;			/* Highest page->index to unmap */
 };
 
+static inline void INIT_VMA(struct vm_area_struct *vma)
+{
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+}
+
 struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte, bool with_public_device);
 #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
diff --git a/kernel/fork.c b/kernel/fork.c
index 915be4918a2b..f8dae021c2e5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -341,7 +341,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 	if (new) {
 		*new = *orig;
-		INIT_LIST_HEAD(&new->anon_vma_chain);
+		INIT_VMA(new);
 	}
 	return new;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..5ad3a3228d76 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1765,6 +1765,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_flags = vm_flags;
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
+	INIT_VMA(vma);
 
 	if (file) {
 		if (vm_flags & VM_DENYWRITE) {
@@ -3037,6 +3038,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	}
 
 	vma_set_anonymous(vma);
+	INIT_VMA(vma);
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_pgoff = pgoff;
@@ -3395,6 +3397,7 @@ static struct vm_area_struct *__install_special_mapping(
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
 
+	INIT_VMA(vma);
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 749276beb109..acf7ca72ca90 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1210,6 +1210,7 @@ unsigned long do_mmap(struct file *file,
 	region->vm_flags = vm_flags;
 	region->vm_pgoff = pgoff;
 
+	INIT_VMA(vma);
 	vma->vm_flags = vm_flags;
 	vma->vm_pgoff = pgoff;
 
-- 
2.21.0

