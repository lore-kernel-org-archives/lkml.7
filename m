Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F907C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654B92083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCUJJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:09:26 -0400
Received: from mx58.baidu.com ([61.135.168.58]:46641 "EHLO
        tc-sys-mailedm04.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbfCUJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:09:25 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id 5CB17236C05B;
        Thu, 21 Mar 2019 17:09:13 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH] mm, slab: remove unneed check in cpuup_canceled
Date:   Thu, 21 Mar 2019 17:09:13 +0800
Message-Id: <1553159353-5056-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nc is a member of percpu allocation memory, and impossible NULL

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/slab.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 28652e4218e0..f1420e14875a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -990,10 +990,8 @@ static void cpuup_canceled(long cpu)
 
 		/* cpu is dead; no one can alloc from it. */
 		nc = per_cpu_ptr(cachep->cpu_cache, cpu);
-		if (nc) {
-			free_block(cachep, nc->entry, nc->avail, node, &list);
-			nc->avail = 0;
-		}
+		free_block(cachep, nc->entry, nc->avail, node, &list);
+		nc->avail = 0;
 
 		if (!cpumask_empty(mask)) {
 			spin_unlock_irq(&n->list_lock);
-- 
2.16.2

