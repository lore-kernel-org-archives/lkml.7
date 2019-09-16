Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEAC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB929214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbfIPONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:13:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfIPONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:13:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0BE2813160E462C8145A;
        Mon, 16 Sep 2019 22:13:52 +0800 (CST)
Received: from huawei.com (10.175.104.232) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Sep 2019
 22:13:45 +0800
From:   KeMeng Shi <shikemeng@huawei.com>
To:     <akpm@linux-foundation.org>, <james.morris@microsoft.com>,
        <gregkh@linuxfoundation.org>, <mortonm@chromium.org>,
        <will.deacon@arm.com>, <kristina.martsenko@arm.com>,
        <yuehaibing@huawei.com>, <malat@debian.org>,
        <j.neuschaefer@gmx.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] connector: report comm change event when modifying /proc/pid/task/tid/comm
Date:   Mon, 16 Sep 2019 10:13:41 -0400
Message-ID: <20190916141341.658-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.232]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f786ecba41588 ("connector: add comm change event report to proc
 connector") added proc_comm_connector to report comm change event, and
prctl will report comm change event when dealing with PR_SET_NAME case.

prctl can only set the name of the calling thread. In order to set the name
of other threads in a process, modifying /proc/self/task/tid/comm is a
general way.It's exactly how pthread_setname_np do to set name of a thread.

It's unable to get comm change event of thread if the name of thread is set
by other thread via pthread_setname_np. This update provides a chance for
application to monitor and control threads whose name is set by other
threads.

Signed-off-by: KeMeng Shi <shikemeng@huawei.com>
---
 fs/proc/base.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..34ffe572ac69 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/cn_proc.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1549,10 +1550,12 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 	if (!p)
 		return -ESRCH;
 
-	if (same_thread_group(current, p))
+	if (same_thread_group(current, p)) {
 		set_task_comm(p, buffer);
-	else
+		proc_comm_connector(p);
+	} else {
 		count = -EINVAL;
+	}
 
 	put_task_struct(p);
 
-- 
2.19.1

