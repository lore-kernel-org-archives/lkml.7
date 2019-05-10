Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D72AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727B216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfEJJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:01:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbfEJJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:01:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4A8tHPJ093359;
        Fri, 10 May 2019 05:01:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sd468dn3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 05:01:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4A333f2010291;
        Fri, 10 May 2019 03:05:38 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2s92c47rvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 May 2019 03:05:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4A91OnN36569210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 09:01:24 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3E0AC05F;
        Fri, 10 May 2019 09:01:24 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20120AC059;
        Fri, 10 May 2019 09:01:24 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.248])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 May 2019 09:01:24 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 9C4EA2E3788; Fri, 10 May 2019 14:31:22 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Fix cpu_hotplug_lock acquisition in resize_hpt
Date:   Fri, 10 May 2019 14:31:11 +0530
Message-Id: <1557478871-31808-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

During a memory hotplug operations involving resizing of the HPT, we
invoke a stop_machine() to perform the resizing. In this code path, we
end up recursively taking the cpu_hotplug_lock, first in
memory_hotplug_begin() and then subsequently in stop_machine(). This
causes the system to hang. With lockdep enabled we get the following
error message before the hang.

  swapper/0/1 is trying to acquire lock:
  (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: stop_machine+0x2c/0x60

  but task is already holding lock:
  (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: mem_hotplug_begin+0x20/0x50

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(cpu_hotplug_lock.rw_sem);
    lock(cpu_hotplug_lock.rw_sem);

   *** DEADLOCK ***

Fix this issue by
  1) Requiring all the calls to pseries_lpar_resize_hpt() be made
     with cpu_hotplug_lock held.

  2) In pseries_lpar_resize_hpt() invoke stop_machine_cpuslocked()
     as a consequence of 1)

  3) To satisfy 1), in hpt_order_set(), call mmu_hash_ops.resize_hpt()
     with cpu_hotplug_lock held.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c       | 9 ++++++++-
 arch/powerpc/platforms/pseries/lpar.c | 8 ++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0a4f939..b05c79c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
 #include <linux/pkeys.h>
+#include <linux/cpu.h>
 
 #include <asm/debugfs.h>
 #include <asm/processor.h>
@@ -1890,10 +1891,16 @@ static int hpt_order_get(void *data, u64 *val)
 
 static int hpt_order_set(void *data, u64 val)
 {
+	int ret;
+
 	if (!mmu_hash_ops.resize_hpt)
 		return -ENODEV;
 
-	return mmu_hash_ops.resize_hpt(val);
+	cpus_read_lock();
+	ret = mmu_hash_ops.resize_hpt(val);
+	cpus_read_unlock();
+
+	return ret;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_hpt_order, hpt_order_get, hpt_order_set, "%llu\n");
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f2a9f0a..65df95b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -859,7 +859,10 @@ static int pseries_lpar_resize_hpt_commit(void *data)
 	return 0;
 }
 
-/* Must be called in user context */
+/*
+ * Must be called in user context. The caller should hold the
+ * cpus_lock.
+ */
 static int pseries_lpar_resize_hpt(unsigned long shift)
 {
 	struct hpt_resize_state state = {
@@ -911,7 +914,8 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 
 	t1 = ktime_get();
 
-	rc = stop_machine(pseries_lpar_resize_hpt_commit, &state, NULL);
+	rc = stop_machine_cpuslocked(pseries_lpar_resize_hpt_commit,
+				     &state, NULL);
 
 	t2 = ktime_get();
 
-- 
1.9.4

