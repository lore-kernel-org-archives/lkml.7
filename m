Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EEB2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFNPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:32:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfFNPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:32:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79BD5675A9989552722D;
        Fri, 14 Jun 2019 23:32:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:32:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <tom.zanussi@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tracing: Make two symbols static
Date:   Fri, 14 Jun 2019 23:32:10 +0800
Message-ID: <20190614153210.24424-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

kernel/trace/trace.c:6927:24: warning:
 symbol 'get_tracing_log_err' was not declared. Should it be static?
kernel/trace/trace.c:8196:15: warning:
 symbol 'trace_instance_dir' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a092e40..650b141 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6924,7 +6924,7 @@ struct tracing_log_err {
 
 static DEFINE_MUTEX(tracing_err_log_lock);
 
-struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
+static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 {
 	struct tracing_log_err *err;
 
@@ -8193,7 +8193,7 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
-struct dentry *trace_instance_dir;
+static struct dentry *trace_instance_dir;
 
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
-- 
2.7.4


