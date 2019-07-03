Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B3C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA1D218BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGCOsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfGCOsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E89218B8;
        Wed,  3 Jul 2019 14:48:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1higYn-0005i4-Nw; Wed, 03 Jul 2019 10:48:37 -0400
Message-Id: <20190703144837.629823351@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 10:47:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Takeshi Misawa <jeliantsurux@gmail.com>
Subject: [for-linus][PATCH 3/5] tracing: Fix memory leak in tracing_err_log_open()
References: <20190703144741.181267753@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Misawa <jeliantsurux@gmail.com>

When tracing_err_log_open() calls seq_open(), allocated memory is not freed.

kmemleak report:

unreferenced object 0xffff92c0781d1100 (size 128):
  comm "tail", pid 15116, jiffies 4295163855 (age 22.704s)
  hex dump (first 32 bytes):
    00 f0 08 e5 c0 92 ff ff 00 10 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000000d0687d5>] kmem_cache_alloc+0x11f/0x1e0
    [<000000003e3039a8>] seq_open+0x2f/0x90
    [<000000008dd36b7d>] tracing_err_log_open+0x67/0x140
    [<000000005a431ae2>] do_dentry_open+0x1df/0x3a0
    [<00000000a2910603>] vfs_open+0x2f/0x40
    [<0000000038b0a383>] path_openat+0x2e8/0x1690
    [<00000000fe025bda>] do_filp_open+0x9b/0x110
    [<00000000483a5091>] do_sys_open+0x1ba/0x260
    [<00000000c558b5fd>] __x64_sys_openat+0x20/0x30
    [<000000006881ec07>] do_syscall_64+0x5a/0x130
    [<00000000571c2e94>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by calling seq_release() in tracing_err_log_fops.release().

Link: http://lkml.kernel.org/r/20190628105640.GA1863@DESKTOP

Fixes: 8a062902be725 ("tracing: Add tracing error log")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..4122ccde6ec2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7126,12 +7126,24 @@ static ssize_t tracing_err_log_write(struct file *file,
 	return count;
 }
 
+static int tracing_err_log_release(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+
+	trace_array_put(tr);
+
+	if (file->f_mode & FMODE_READ)
+		seq_release(inode, file);
+
+	return 0;
+}
+
 static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= tracing_release_generic_tr,
+	.release        = tracing_err_log_release,
 };
 
 static int tracing_buffers_open(struct inode *inode, struct file *filp)
-- 
2.20.1


