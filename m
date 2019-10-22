Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B73CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9071A2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbfJVMwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:52:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388890AbfJVMwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:52:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2FAB5611C6A600EF6DD7;
        Tue, 22 Oct 2019 20:52:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 20:52:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfr@canb.auug.org.au>, <khlebnikov@yandex-team.ru>,
        <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <vbabka@suse.cz>, <yuehaibing@huawei.com>,
        <jannh@google.com>, <gregkh@linuxfoundation.org>,
        <janne.huttunen@nokia.com>, <arunks@codeaurora.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH -next] mm/vmstat: Fix build error without CONFIG_VM_EVENT_COUNTERS
Date:   Tue, 22 Oct 2019 20:51:24 +0800
Message-ID: <20191022125124.32812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_VM_EVENT_COUNTERS is n but CONFIG_MEMCG is y,
vmstat_text is not equal stat_items_size:

mm/vmstat.c: In function vmstat_start:
./include/linux/compiler.h:350:38: error: call to __compiletime_assert_1659 declared
 with attribute error: BUILD_BUG_ON failed: stat_items_size != ARRAY_SIZE(vmstat_text) * sizeof(unsigned long)
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2fdf561910a9 ("mm/memcontrol: use vmstat names for printing statistics")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/vmstat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2fd344..a19ed6e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1655,8 +1655,6 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	stat_items_size += sizeof(struct vm_event_state);
 #endif
 
-	BUILD_BUG_ON(stat_items_size !=
-		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
 	v = kmalloc(stat_items_size, GFP_KERNEL);
 	m->private = v;
 	if (!v)
-- 
2.7.4


