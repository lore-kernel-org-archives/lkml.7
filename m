Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1ABC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740A20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLQHRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:17:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbfLQHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:17:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH7HT88083014;
        Tue, 17 Dec 2019 02:17:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wxpvwdx17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 02:17:31 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBH7HVkO083309;
        Tue, 17 Dec 2019 02:17:31 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wxpvwdx02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 02:17:31 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBH7Ev8j003103;
        Tue, 17 Dec 2019 07:17:29 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 2wvqc6gnqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 07:17:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBH7HSIX50266446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 07:17:28 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D27B6E04C;
        Tue, 17 Dec 2019 07:17:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CC7E6E050;
        Tue, 17 Dec 2019 07:17:25 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 07:17:25 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        peterz@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 2/2] mm/mmu_gather: Avoid multiple page walk cache flush
Date:   Tue, 17 Dec 2019 12:47:13 +0530
Message-Id: <20191217071713.93399-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=2 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On tlb_finish_mmu() kernel does a tlb flush before  mmu gather table invalidate.
The mmu gather table invalidate depending on kernel config also does another
TLBI. Avoid the later on tlb_finish_mmu().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/mmu_gather.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7c1b8f67af7b..7e2bd43b9084 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -143,17 +143,23 @@ static void tlb_remove_table_rcu(struct rcu_head *head)
 	free_page((unsigned long)batch);
 }
 
-static void tlb_table_flush(struct mmu_gather *tlb)
+static void __tlb_table_flush(struct mmu_gather *tlb, bool table_inval)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
 	if (*batch) {
-		tlb_table_invalidate(tlb);
+		if (table_inval)
+			tlb_table_invalidate(tlb);
 		call_rcu(&(*batch)->rcu, tlb_remove_table_rcu);
 		*batch = NULL;
 	}
 }
 
+static void tlb_table_flush(struct mmu_gather *tlb)
+{
+	__tlb_table_flush(tlb, true);
+}
+
 void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
@@ -178,7 +184,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
+	__tlb_table_flush(tlb, false);
 #endif
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 	tlb_batch_pages_flush(tlb);
-- 
2.23.0

