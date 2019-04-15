Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfDOKMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:12:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfDOKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:12:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FA999V142181
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:12:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvq6wjhxp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:12:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Mon, 15 Apr 2019 11:12:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 11:12:16 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FACFUI57344138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 10:12:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 638EB5205A;
        Mon, 15 Apr 2019 10:12:15 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.161.180])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 400A752069;
        Mon, 15 Apr 2019 10:12:14 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH v4 2/5] powerpc/perf: Rearrange setting of ldbar for thread-imc
Date:   Mon, 15 Apr 2019 15:42:01 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
References: <20190415101204.15125-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041510-0028-0000-0000-00000360EB67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0029-0000-0000-000024201DC0
Message-Id: <20190415101204.15125-3-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDBAR holds the memory address allocated for each cpu. For thread-imc
the mode bit (i.e bit 1) of LDBAR is set to accumulation.
Currently, ldbar is loaded with per cpu memory address and mode set to
accumulation at boot time.

To enable trace-imc, the mode bit of ldbar should be set to 'trace'. So to
accommodate trace-mode of IMC, reposition setting of ldbar for thread-imc
to thread_imc_event_add(). Also reset ldbar at thread_imc_event_del().

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index b1c37cc3fa98..51f1d3eaaa6d 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -788,8 +788,11 @@ static int core_imc_event_init(struct perf_event *event)
 }
 
 /*
- * Allocates a page of memory for each of the online cpus, and write the
- * physical base address of that page to the LDBAR for that cpu.
+ * Allocates a page of memory for each of the online cpus, and load
+ * LDBAR with 0.
+ * The physical base address of the page allocated for a cpu will be
+ * written to the LDBAR for that cpu, when the thread-imc event
+ * is added.
  *
  * LDBAR Register Layout:
  *
@@ -807,7 +810,7 @@ static int core_imc_event_init(struct perf_event *event)
  */
 static int thread_imc_mem_alloc(int cpu_id, int size)
 {
-	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
+	u64 *local_mem = per_cpu(thread_imc_mem, cpu_id);
 	int nid = cpu_to_node(cpu_id);
 
 	if (!local_mem) {
@@ -824,9 +827,7 @@ static int thread_imc_mem_alloc(int cpu_id, int size)
 		per_cpu(thread_imc_mem, cpu_id) = local_mem;
 	}
 
-	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
-
-	mtspr(SPRN_LDBAR, ldbar_value);
+	mtspr(SPRN_LDBAR, 0);
 	return 0;
 }
 
@@ -977,6 +978,7 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 {
 	int core_id;
 	struct imc_pmu_ref *ref;
+	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, smp_processor_id());
 
 	if (flags & PERF_EF_START)
 		imc_event_start(event, flags);
@@ -985,6 +987,9 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 		return -EINVAL;
 
 	core_id = smp_processor_id() / threads_per_core;
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+
 	/*
 	 * imc pmus are enabled only when it is used.
 	 * See if this is triggered for the first time.
@@ -1016,11 +1021,7 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 	int core_id;
 	struct imc_pmu_ref *ref;
 
-	/*
-	 * Take a snapshot and calculate the delta and update
-	 * the event counter values.
-	 */
-	imc_event_update(event);
+	mtspr(SPRN_LDBAR, 0);
 
 	core_id = smp_processor_id() / threads_per_core;
 	ref = &core_imc_refc[core_id];
@@ -1039,6 +1040,11 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 		ref->refc = 0;
 	}
 	mutex_unlock(&ref->lock);
+	/*
+	 * Take a snapshot and calculate the delta and update
+	 * the event counter values.
+	 */
+	imc_event_update(event);
 }
 
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
-- 
2.17.2

