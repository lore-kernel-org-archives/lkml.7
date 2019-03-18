Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46681C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EAD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCRLrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:47:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfCRLrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:47:06 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C7D80C7EA37522962058;
        Mon, 18 Mar 2019 19:47:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 19:46:56 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ingo Molnar" <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] workqueue, lockdep: Fix new alloc_workqueue() error path
Date:   Mon, 18 Mar 2019 19:58:33 +0800
Message-ID: <20190318115833.67468-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If alloc_workqueue_attrs() fails, the workqueue lockdep is
uninitialized, it will trigger a warning in err_free_wq path
when try to unregister workqueue lockdep.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 009bb421b6ce ("workqueue, lockdep: Fix an alloc_workqueue() error path")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4026d1871407..2c19f2968bc7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4242,7 +4242,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (flags & WQ_UNBOUND) {
 		wq->unbound_attrs = alloc_workqueue_attrs(GFP_KERNEL);
 		if (!wq->unbound_attrs)
-			goto err_free_wq;
+			goto err_unbound_attrs;
 	}
 
 	va_start(args, max_active);
@@ -4296,6 +4296,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
 	free_workqueue_attrs(wq->unbound_attrs);
+err_unbound_attrs:
 	kfree(wq);
 	return NULL;
 err_destroy:
-- 
2.20.1

