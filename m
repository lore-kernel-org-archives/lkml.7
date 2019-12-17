Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2BA20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfLQTdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:33:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfLQTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:33:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHJ7x5f014772;
        Tue, 17 Dec 2019 14:33:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wy1u4ys7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 14:33:12 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBHJ97JO027081;
        Tue, 17 Dec 2019 14:33:12 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wy1u4ys6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 14:33:12 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBHJVDG1001886;
        Tue, 17 Dec 2019 19:33:11 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 2wvqc6pt6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 19:33:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBHJX93d53019100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 19:33:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 738A17805C;
        Tue, 17 Dec 2019 19:33:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D8BE78068;
        Tue, 17 Dec 2019 19:33:08 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 19:33:08 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
Date:   Tue, 17 Dec 2019 13:32:38 -0600
Message-Id: <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_03:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=839 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912170151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching for a particular memory block by id is slow because each block
device is kept in an unsorted linked list on the subsystem bus.

Lookup is much faster if we cache the blocks in a radix tree.  Memory
subsystem initialization and hotplug/hotunplug is at least a little faster
for any machine with more than ~100 blocks, and the speedup grows with
the block count.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
v2 incorporates suggestions from David Hildenbrand.

v3 changes:
  - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"

  - Be conservative: don't use radix_tree_for_each_slot() in
    walk_memory_blocks() yet.  It introduces RCU which could
    change behavior.  Walking the tree "by hand" with
    find_memory_block_by_id() is slower but keeps the patch
    simple.

 drivers/base/memory.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 799b43191dea..8902930d5ef2 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -19,6 +19,7 @@
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
+#include <linux/radix-tree.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 
@@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
 	.offline = memory_subsys_offline,
 };
 
+/*
+ * Memory blocks are cached in a local radix tree to avoid
+ * a costly linear search for the corresponding device on
+ * the subsystem bus.
+ */
+static RADIX_TREE(memory_blocks, GFP_KERNEL);
+
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
@@ -572,20 +580,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 /* A reference for the returned memory block device is acquired. */
 static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
-	struct device *dev;
+	struct memory_block *mem;
 
-	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
-	return dev ? to_memory_block(dev) : NULL;
+	mem = radix_tree_lookup(&memory_blocks, block_id);
+	if (mem)
+		get_device(&mem->dev);
+	return mem;
 }
 
-/*
- * For now, we have a linear search to go find the appropriate
- * memory_block corresponding to a particular phys_index. If
- * this gets to be a real problem, we can always use a radix
- * tree or something here.
- *
- * This could be made generic for all device subsystems.
- */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
 	unsigned long block_id = base_memory_block_id(__section_nr(section));
@@ -628,9 +630,15 @@ int register_memory(struct memory_block *memory)
 	memory->dev.offline = memory->state == MEM_OFFLINE;
 
 	ret = device_register(&memory->dev);
-	if (ret)
+	if (ret) {
 		put_device(&memory->dev);
-
+		return ret;
+	}
+	ret = radix_tree_insert(&memory_blocks, memory->dev.id, memory);
+	if (ret) {
+		put_device(&memory->dev);
+		device_unregister(&memory->dev);
+	}
 	return ret;
 }
 
@@ -688,6 +696,8 @@ static void unregister_memory(struct memory_block *memory)
 	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
 		return;
 
+	WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) == NULL);
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
-- 
2.24.0

