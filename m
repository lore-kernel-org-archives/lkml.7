Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8E2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJKILu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:11:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfJKILt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:11:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6DFA1D90DC880845E81A;
        Fri, 11 Oct 2019 16:11:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 16:11:42 +0800
Subject: [PATCH v2] async: Let kfree() out of the critical area of the lock
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>, <dsterba@suse.cz>,
        <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "Alexander Duyck" <alexander.h.duyck@linux.intel.com>,
        <sakari.ailus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ae3b790d-9883-0ec0-425d-5ac9b32c2d0f@huawei.com>
Message-ID: <9bfecf17-3c1b-414e-b271-4fd2d884faa3@huawei.com>
Date:   Fri, 11 Oct 2019 16:11:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ae3b790d-9883-0ec0-425d-5ac9b32c2d0f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The async_lock is big global lock, and kfree() is not always cheap, it
will increase lock contention. it's better let kfree() outside the lock
to keep the critical area as short as possible.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v1 -> v2:
 - update the description
 - add "Reviewed-by"

 kernel/async.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index 4f9c1d6..1de270d 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
 	list_del_init(&entry->domain_list);
 	list_del_init(&entry->global_list);

-	/* 3) free the entry */
-	kfree(entry);
 	atomic_dec(&entry_count);
-
 	spin_unlock_irqrestore(&async_lock, flags);

+	/* 3) free the entry */
+	kfree(entry);
+
 	/* 4) wake up any waiters */
 	wake_up(&async_done);
 }
-- 
2.7.4


