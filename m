Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384F8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfG3NcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:32:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfG3NcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:32:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 483AFB7D026684F4B264;
        Tue, 30 Jul 2019 21:32:00 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 21:31:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <stable@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v4 1/5] lib: logic_pio: Fix RCU usage
Date:   Tue, 30 Jul 2019 21:29:52 +0800
Message-ID: <1564493396-92195-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1564493396-92195-1-git-send-email-john.garry@huawei.com>
References: <1564493396-92195-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The traversing of io_range_list with list_for_each_entry_rcu()
is not properly protected by rcu_read_lock() and rcu_read_unlock(),
so add them.

These functions mark the critical section scope where the list is
protected for the reader, it cannot be  "reclaimed". Any updater - in
this case, the logical PIO registration functions - cannot update the
list until the reader exits this critical section.

In addition, the list traversing used in logic_pio_register_range()
does not need to use the rcu variant.

This is because we are already using io_range_mutex to guarantee mutual
exclusion from mutating the list.

Cc: stable@vger.kernel.org
Fixes: 031e3601869c ("lib: Add generic PIO mapping method")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index feea48fd1a0d..761296376fbc 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -46,7 +46,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	end = new_range->hw_start + new_range->size;
 
 	mutex_lock(&io_range_mutex);
-	list_for_each_entry_rcu(range, &io_range_list, list) {
+	list_for_each_entry(range, &io_range_list, list) {
 		if (range->fwnode == new_range->fwnode) {
 			/* range already there */
 			goto end_register;
@@ -108,26 +108,38 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
  */
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
 {
-	struct logic_pio_hwaddr *range;
+	struct logic_pio_hwaddr *range, *found_range = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
-		if (range->fwnode == fwnode)
-			return range;
+		if (range->fwnode == fwnode) {
+			found_range = range;
+			break;
+		}
 	}
-	return NULL;
+	rcu_read_unlock();
+
+	return found_range;
 }
 
 /* Return a registered range given an input PIO token */
 static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 {
-	struct logic_pio_hwaddr *range;
+	struct logic_pio_hwaddr *range, *found_range = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
-		if (in_range(pio, range->io_start, range->size))
-			return range;
+		if (in_range(pio, range->io_start, range->size)) {
+			found_range = range;
+			break;
+		}
 	}
-	pr_err("PIO entry token %lx invalid\n", pio);
-	return NULL;
+	rcu_read_unlock();
+
+	if (!found_range)
+		pr_err("PIO entry token 0x%lx invalid\n", pio);
+
+	return found_range;
 }
 
 /**
@@ -180,14 +192,23 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 {
 	struct logic_pio_hwaddr *range;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(range, &io_range_list, list) {
 		if (range->flags != LOGIC_PIO_CPU_MMIO)
 			continue;
-		if (in_range(addr, range->hw_start, range->size))
-			return addr - range->hw_start + range->io_start;
+		if (in_range(addr, range->hw_start, range->size)) {
+			unsigned long cpuaddr;
+
+			cpuaddr = addr - range->hw_start + range->io_start;
+
+			rcu_read_unlock();
+			return cpuaddr;
+		}
 	}
-	pr_err("addr %llx not registered in io_range_list\n",
-	       (unsigned long long) addr);
+	rcu_read_unlock();
+
+	pr_err("addr %pa not registered in io_range_list\n", &addr);
+
 	return ~0UL;
 }
 
-- 
2.17.1

