Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2035C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 03:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B920637
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 03:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLGDrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 22:47:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfLGDrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 22:47:47 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96279676AA260FA1F035;
        Sat,  7 Dec 2019 11:47:44 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Dec 2019
 11:46:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <xiyou.wangcong@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tracing: remove set but not used variable 'buffer'
Date:   Sat, 7 Dec 2019 11:44:09 +0800
Message-ID: <20191207034409.25668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/trace/trace_events_inject.c: In function trace_inject_entry:
kernel/trace/trace_events_inject.c:20:22: warning: variable buffer set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/trace/trace_events_inject.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index d437107..d45079e 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -17,12 +17,10 @@ static int
 trace_inject_entry(struct trace_event_file *file, void *rec, int len)
 {
 	struct trace_event_buffer fbuffer;
-	struct ring_buffer *buffer;
 	int written = 0;
 	void *entry;
 
 	rcu_read_lock_sched();
-	buffer = file->tr->trace_buffer.buffer;
 	entry = trace_event_buffer_reserve(&fbuffer, file, len);
 	if (entry) {
 		memcpy(entry, rec, len);
-- 
2.7.4


