Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C9C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFED521726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfH3C2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:28:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfH3C2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:28:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A529C1DC4CE9E7019F7;
        Fri, 30 Aug 2019 10:28:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 10:28:41 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <mhocko@suse.com>, <anshuman.khandual@arm.com>,
        <adobriyan@gmail.com>, <cai@lca.pw>, <robin.murphy@arm.com>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] arm64: numa: check the node id before accessing node_to_cpumask_map
Date:   Fri, 30 Aug 2019 10:26:31 +0800
Message-ID: <1567131991-189761-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buggy bios may not set the device' numa id, and dev_to_node
will return -1, which may cause global-out-of-bounds error
detected by KASAN.

This patch changes cpumask_of_node to return cpu_none_mask if the
node is not valid, and sync the cpumask_of_node between the
cpumask_of_node function in numa.h and numa.c.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 arch/arm64/include/asm/numa.h | 6 ++++++
 arch/arm64/mm/numa.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 626ad01..da891ed 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -25,6 +25,12 @@ const struct cpumask *cpumask_of_node(int node);
 /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
 static inline const struct cpumask *cpumask_of_node(int node)
 {
+	if (node >= nr_node_ids || node < 0)
+		return cpu_none_mask;
+
+	if (!node_to_cpumask_map[node])
+		return cpu_online_mask;
+
 	return node_to_cpumask_map[node];
 }
 #endif
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4f241cc..3846313 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -46,7 +46,7 @@ EXPORT_SYMBOL(node_to_cpumask_map);
  */
 const struct cpumask *cpumask_of_node(int node)
 {
-	if (WARN_ON(node >= nr_node_ids))
+	if (WARN_ON(node >= nr_node_ids || node < 0))
 		return cpu_none_mask;
 
 	if (WARN_ON(node_to_cpumask_map[node] == NULL))
-- 
2.8.1

