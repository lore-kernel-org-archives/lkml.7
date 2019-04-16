Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4720EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9C222E5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfDPNsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:48:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726645AbfDPNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:48:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GDlGY3060623
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:48:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rwe3k5vmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:47:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Tue, 16 Apr 2019 14:46:59 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 14:46:49 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GDklaL24838310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 13:46:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0ADD4C044;
        Tue, 16 Apr 2019 13:46:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCED4C05E;
        Tue, 16 Apr 2019 13:46:46 +0000 (GMT)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.33])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 13:46:45 +0000 (GMT)
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
Subject: [PATCH v12 29/31] powerpc/mm: add speculative page fault
Date:   Tue, 16 Apr 2019 15:45:20 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-0008-0000-0000-000002DA6FC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-0009-0000-0000-00002246A849
Message-Id: <20190416134522.17540-30-ldufour@linux.ibm.com>
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

This patch enable the speculative page fault on the PowerPC
architecture.

This will try a speculative page fault without holding the mmap_sem,
if it returns with VM_FAULT_RETRY, the mmap_sem is acquired and the
traditional page fault processing is done.

The speculative path is only tried for multithreaded process as there is no
risk of contention on the mmap_sem otherwise.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/mm/fault.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index ec74305fa330..5d48016073cb 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -491,6 +491,21 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+	/*
+	 * Try speculative page fault before grabbing the mmap_sem.
+	 * The Page fault is done if VM_FAULT_RETRY is not returned.
+	 * But if the memory protection keys are active, we don't know if the
+	 * fault is due to key mistmatch or due to a classic protection check.
+	 * To differentiate that, we will need the VMA we no more have, so
+	 * let's retry with the mmap_sem held.
+	 */
+	fault = handle_speculative_fault(mm, address, flags);
+	if (fault != VM_FAULT_RETRY && (IS_ENABLED(CONFIG_PPC_MEM_KEYS) &&
+					fault != VM_FAULT_SIGSEGV)) {
+		perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, address);
+		goto done;
+	}
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -600,6 +615,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	up_read(&current->mm->mmap_sem);
 
+done:
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
-- 
2.21.0

