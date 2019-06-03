Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4412C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CEA27EEC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfFCJOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:14:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729032AbfFCJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:14:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E475A1C793E5AEDA66D9;
        Mon,  3 Jun 2019 17:14:38 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:14:28 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <stable@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        <koujilong@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2] sched/core: add __sched tag for io_schedule()
Date:   Mon, 3 Jun 2019 17:13:38 +0800
Message-ID: <20190603091338.2695-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531082912.80724-1-gaoxiang25@huawei.com>
References: <20190531082912.80724-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

non-inline io_schedule() was introduced in
commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
Keep in line with io_schedule_timeout, Otherwise
"/proc/<pid>/wchan" will report io_schedule()
rather than its callers when waiting io.

Reported-by: Jilong Kou <koujilong@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Fixes: 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
Cc: <stable@vger.kernel.org> # 4.11+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
 - add missing tags

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..4d5962232a55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5123,7 +5123,7 @@ long __sched io_schedule_timeout(long timeout)
 }
 EXPORT_SYMBOL(io_schedule_timeout);
 
-void io_schedule(void)
+void __sched io_schedule(void)
 {
 	int token;
 
-- 
2.17.1

