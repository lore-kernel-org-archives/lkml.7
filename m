Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfC0SSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:18:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390539AbfC0SSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B2AECB9F3;
        Wed, 27 Mar 2019 18:18:33 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.242.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC59111DCFB;
        Wed, 27 Mar 2019 18:18:31 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, yamato@redhat.com
Subject: [PATCH v2] eventfd: prepare id to userspace via fdinfo
Date:   Thu, 28 Mar 2019 03:18:23 +0900
Message-Id: <20190327181823.20222-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Mar 2019 18:18:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Mar 2019 18:18:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding endpoints of an IPC channel is one of essential task to
understand how a user program works. Procfs and netlink socket provide
enough hints to find endpoints for IPC channels like pipes, unix
sockets, and pseudo terminals. However, there is no simple way to find
endpoints for an eventfd file from userland. An inode number doesn't
hint. Unlike pipe, all eventfd files share the same inode object.

To provide the way to find endpoints of an eventfd file, this patch
adds "eventfd-id" field to /proc/PID/fdinfo of eventfd as identifier.
Integers managed by an IDA are used as ids.

A tool like lsof can utilize the information to print endpoints.

Change in v2:
Use integers as ids instead of memory addresses of eventfd contexts.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 fs/eventfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 08d3bd602f73..ce8fa15cebe5 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -21,6 +21,9 @@
 #include <linux/eventfd.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/idr.h>
+
+DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
 	struct kref kref;
@@ -35,6 +38,7 @@ struct eventfd_ctx {
 	 */
 	__u64 count;
 	unsigned int flags;
+	int id;
 };
 
 /**
@@ -69,6 +73,8 @@ EXPORT_SYMBOL_GPL(eventfd_signal);
 
 static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
+	if (ctx->id >= 0)
+		ida_simple_remove(&eventfd_ida, ctx->id);
 	kfree(ctx);
 }
 
@@ -297,6 +303,7 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 	seq_printf(m, "eventfd-count: %16llx\n",
 		   (unsigned long long)ctx->count);
 	spin_unlock_irq(&ctx->wqh.lock);
+	seq_printf(m, "eventfd-id: %d\n", ctx->id);
 }
 #endif
 
@@ -400,6 +407,7 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
+	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
 	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
-- 
2.17.2

