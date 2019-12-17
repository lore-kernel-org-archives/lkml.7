Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1A9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1862920733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLQHQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:16:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbfLQHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:16:33 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH77r0x000849;
        Tue, 17 Dec 2019 02:16:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe3720w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 02:16:23 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBH78p3E003612;
        Tue, 17 Dec 2019 02:16:23 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe3720vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 02:16:23 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBH7Ex5q007090;
        Tue, 17 Dec 2019 07:16:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2wvqc6gmh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 07:16:22 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBH7GL3m60424634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 07:16:21 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF9BC13605E;
        Tue, 17 Dec 2019 07:16:20 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6261213604F;
        Tue, 17 Dec 2019 07:16:18 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.204.201.20])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 07:16:17 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 2/2] mm/mmu_gather: Avoid multiple page walk cache flush
Date:   Tue, 17 Dec 2019 12:46:01 +0530
Message-Id: <20191217071601.93141-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217071601.93141-1-aneesh.kumar@linux.ibm.com>
References: <20191217071601.93141-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170062
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

