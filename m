Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7DAC31E53
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8152184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFOMnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfFOMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:43:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC47521850;
        Sat, 15 Jun 2019 12:43:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hc81Z-0006dA-0u; Sat, 15 Jun 2019 08:43:13 -0400
Message-Id: <20190615124312.912679595@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 15 Jun 2019 08:42:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [for-linus][PATCH 3/7] tracing: Make two symbols static
References: <20190615124216.188179157@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

kernel/trace/trace.c:6927:24: warning:
 symbol 'get_tracing_log_err' was not declared. Should it be static?
kernel/trace/trace.c:8196:15: warning:
 symbol 'trace_instance_dir' was not declared. Should it be static?

Link: http://lkml.kernel.org/r/20190614153210.24424-1-yuehaibing@huawei.com

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521fd436..83e08b78dbee 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6923,7 +6923,7 @@ struct tracing_log_err {
 
 static DEFINE_MUTEX(tracing_err_log_lock);
 
-struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
+static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 {
 	struct tracing_log_err *err;
 
@@ -8192,7 +8192,7 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
-struct dentry *trace_instance_dir;
+static struct dentry *trace_instance_dir;
 
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
-- 
2.20.1


