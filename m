Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5267AC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C392133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfEYHJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 03:09:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfEYHJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 03:09:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D45CB5C057E2B867E12;
        Sat, 25 May 2019 15:09:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 15:09:06 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <khandual@linux.vnet.ibm.com>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <aarcange@redhat.com>
CC:     <rcampbell@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/mempolicy: Fix an incorrect rebind node in mpol_rebind_nodemask
Date:   Sat, 25 May 2019 15:07:23 +0800
Message-ID: <1558768043-23184-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We bind an different node to different vma, Unluckily,
it will bind different vma to same node by checking the /proc/pid/numa_maps.   
Commit 213980c0f23b ("mm, mempolicy: simplify rebinding mempolicies when updating cpusets")
has introduced the issue.  when we change memory policy by seting cpuset.mems,
A process will rebind the specified policy more than one times. 
if the cpuset_mems_allowed is not equal to user specified nodes. hence the issue will trigger.
Maybe result in the out of memory which allocating memory from same node.

Fixes: 213980c0f23b ("mm, mempolicy: simplify rebinding mempolicies when updating cpusets") 
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e3ab1d9..a60a3be 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -345,7 +345,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	else {
 		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
 								*nodes);
-		pol->w.cpuset_mems_allowed = tmp;
+		pol->w.cpuset_mems_allowed = *nodes;
 	}
 
 	if (nodes_empty(tmp))
-- 
1.7.12.4

