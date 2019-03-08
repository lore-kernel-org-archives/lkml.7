Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589A20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCHHYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:24:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfCHHYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:24:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00621220D048E47D63C5;
        Fri,  8 Mar 2019 15:24:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 8 Mar 2019 15:24:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        <syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com>
Subject: [PATCH] workqueue: unregister wq lockdep on error path in alloc_workqueue()
Date:   Fri, 8 Mar 2019 15:37:13 +0800
Message-ID: <20190308073713.39853-1-wangkefeng.wang@huawei.com>
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

syzkaller report an issue "KASAN: use-after-free Read in alloc_workqueue",

alloc_workqueue
 - kzalloc wq
 - wq_init_lockdep(wq);
   - lockdep_register_key(&wq->key);  // add to hlist
 - kfree wq

But forget to call wq_unregister_lockdep()->lockdep_unregister_key(), it
will delete the entry from hlist.

Reported-by: syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7abbeed13421..9209d25dfade 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4291,6 +4291,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_wq:
+	wq_unregister_lockdep(wq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
-- 
2.20.1

