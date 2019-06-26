Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230CFC48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA4920665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFZQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:28:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbfFZQ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:28:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 430CA3F3D441F8870052;
        Thu, 27 Jun 2019 00:28:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 00:28:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 3/6] lib: logic_pio: Add logic_pio_unregister_range()
Date:   Thu, 27 Jun 2019 00:26:55 +0800
Message-ID: <1561566418-22714-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
References: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to unregister a logical PIO range.

Logical PIO space can still be leaked when unregistering certain
LOGIC_PIO_CPU_MMIO regions, but this acceptable for now since there are no
callers to unregister LOGIC_PIO_CPU_MMIO regions, and the logical PIO
region allocation scheme would need significant work to improve this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index cbd9d8495690..88e1e6304a71 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -117,6 +117,7 @@ struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
 int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range);
 resource_size_t logic_pio_to_hwaddr(unsigned long pio);
 unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
 
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index d0165c88f705..905027574e5d 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -98,6 +98,20 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	return ret;
 }
 
+/**
+ * logic_pio_unregister_range - unregister a logical PIO range for a host
+ * @range: pointer to the IO range which has been already registered.
+ *
+ * Unregister a previously-registered IO range node.
+ */
+void logic_pio_unregister_range(struct logic_pio_hwaddr *range)
+{
+	mutex_lock(&io_range_mutex);
+	list_del_rcu(&range->list);
+	mutex_unlock(&io_range_mutex);
+	synchronize_rcu();
+}
+
 /**
  * find_io_range_by_fwnode - find logical PIO range for given FW node
  * @fwnode: FW node handle associated with logical PIO range
-- 
2.17.1

