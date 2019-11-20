Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E1DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E320715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKTT0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:26:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbfKTT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:26:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKJI4iL111464;
        Wed, 20 Nov 2019 14:25:59 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf48p4ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 14:25:59 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAKJJ7nV114325;
        Wed, 20 Nov 2019 14:25:58 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf48p4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 14:25:58 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAKJFFxt022385;
        Wed, 20 Nov 2019 19:25:58 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 2wa8r6qg5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 19:25:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAKJPvjI58917170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:25:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47DF5136051;
        Wed, 20 Nov 2019 19:25:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C727113604F;
        Wed, 20 Nov 2019 19:25:56 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 19:25:56 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: [PATCH] memory subsystem: cache memory blocks in radix tree to accelerate lookup
Date:   Wed, 20 Nov 2019 13:25:36 -0600
Message-Id: <20191120192536.1980-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_06:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911200160
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
---
On a 40GB Power9 VM I'm seeing nice initialization speed improvements
consistent with the change in data structure.  Here's the per-block
timings before the patch:

# uptime        elapsed         block-id
0.005121        0.000033        0
0.005154        0.000028        1
0.005182        0.000035        2
0.005217        0.000030        3
0.005247        0.000039        4
0.005286        0.000031        5
0.005317        0.000030        6
0.005347        0.000031        7
0.005378        0.000030        8
0.005408        0.000031        9
[...]
0.091603        0.000143        999
0.091746        0.000175        1000
0.091921        0.000143        1001
0.092064        0.000142        1002
0.092206        0.000143        1003
0.092349        0.000143        1004
0.092492        0.000143        1005
0.092635        0.000144        1006
0.092779        0.000143        1007
0.092922        0.000144        1008
[...]
0.301879        0.000258        2038
0.302137        0.000267        2039
0.302404        0.000291        2040
0.302695        0.000259        2041
0.302954        0.000258        2042
0.303212        0.000259        2043
0.303471        0.000260        2044
0.303731        0.000258        2045
0.303989        0.000259        2046
0.304248        0.000260        2047

Obviously a linear growth with each block.

With the patch:

# uptime        elapsed         block-id
0.004701        0.000029        0
0.004730        0.000028        1
0.004758        0.000028        2
0.004786        0.000027        3
0.004813        0.000037        4
0.004850        0.000027        5
0.004877        0.000027        6
0.004904        0.000027        7
0.004931        0.000026        8
0.004957        0.000027        9
[...]
0.032718        0.000027        999
0.032745        0.000027        1000
0.032772        0.000026        1001
0.032798        0.000027        1002
0.032825        0.000027        1003
0.032852        0.000026        1004
0.032878        0.000027        1005
0.032905        0.000027        1006
0.032932        0.000026        1007
0.032958        0.000027        1008
[...]
0.061148        0.000027        2038
0.061175        0.000027        2039
0.061202        0.000026        2040
0.061228        0.000027        2041
0.061255        0.000027        2042
0.061282        0.000026        2043
0.061308        0.000027        2044
0.061335        0.000026        2045
0.061361        0.000026        2046
0.061387        0.000027        2047

It flattens out.

I'm seeing similar changes on my development PC but the numbers are
less drastic because the block size on a PC grows with the amount
of memory.  On powerpc the gains are a lot more visible because the
block size tops out at 256MB.

 drivers/base/memory.c | 53 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 84c4e1f72cbd..fc0a4880c321 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -20,6 +20,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/radix-tree.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 
@@ -59,6 +60,13 @@ static struct bus_type memory_subsys = {
 	.offline = memory_subsys_offline,
 };
 
+/*
+ * Memory blocks are cached in a local radix tree to avoid
+ * a costly linear search for the corresponding device on
+ * the subsystem bus.
+ */
+static RADIX_TREE(memory_block_tree, GFP_KERNEL);
+
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
@@ -580,20 +588,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 /* A reference for the returned memory block device is acquired. */
 static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
-	struct device *dev;
+	struct memory_block *mem;
 
-	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
-	return dev ? to_memory_block(dev) : NULL;
+	mem = radix_tree_lookup(&memory_block_tree, block_id);
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
@@ -636,9 +638,15 @@ int register_memory(struct memory_block *memory)
 	memory->dev.offline = memory->state == MEM_OFFLINE;
 
 	ret = device_register(&memory->dev);
-	if (ret)
+	if (ret) {
 		put_device(&memory->dev);
-
+		return ret;
+	}
+	ret = radix_tree_insert(&memory_block_tree, memory->dev.id, memory);
+	if (ret) {
+		put_device(&memory->dev);
+		device_unregister(&memory->dev);
+	}
 	return ret;
 }
 
@@ -696,6 +704,8 @@ static void unregister_memory(struct memory_block *memory)
 	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
 		return;
 
+	WARN_ON(radix_tree_delete(&memory_block_tree, memory->dev.id) == NULL);
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
@@ -851,20 +861,21 @@ void __init memory_dev_init(void)
 int walk_memory_blocks(unsigned long start, unsigned long size,
 		       void *arg, walk_memory_blocks_func_t func)
 {
-	const unsigned long start_block_id = phys_to_block_id(start);
-	const unsigned long end_block_id = phys_to_block_id(start + size - 1);
+	struct radix_tree_iter iter;
+	const unsigned long start_id = phys_to_block_id(start);
+	const unsigned long end_id = phys_to_block_id(start + size - 1);
 	struct memory_block *mem;
-	unsigned long block_id;
+	void **slot;
 	int ret = 0;
 
 	if (!size)
 		return 0;
 
-	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id);
-		if (!mem)
-			continue;
-
+	radix_tree_for_each_slot(slot, &memory_block_tree, &iter, start_id) {
+		mem = radix_tree_deref_slot(slot);
+		if (mem->dev.id > end_id)
+			break;
+		get_device(&mem->dev);
 		ret = func(mem, arg);
 		put_device(&mem->dev);
 		if (ret)
-- 
2.24.0.rc1

