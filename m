Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DE218DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfI2UIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfI2UHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:07:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2900420863;
        Sun, 29 Sep 2019 20:07:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iEfTw-00081G-Bk; Sun, 29 Sep 2019 16:07:48 -0400
Message-Id: <20190929200748.253881278@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Sep 2019 16:06:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/5] tracing/probe: Fix to check the difference of nr_args before adding
 probe
References: <20190929200642.036511084@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Steven reported that a test triggered:

==================================================================
 BUG: KASAN: slab-out-of-bounds in trace_kprobe_create+0xa9e/0xe40
 Read of size 8 at addr ffff8880c4f25a48 by task ftracetest/4798

 CPU: 2 PID: 4798 Comm: ftracetest Not tainted 5.3.0-rc6-test+ #30
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  dump_stack+0x7c/0xc0
  ? trace_kprobe_create+0xa9e/0xe40
  print_address_description+0x6c/0x332
  ? trace_kprobe_create+0xa9e/0xe40
  ? trace_kprobe_create+0xa9e/0xe40
  __kasan_report.cold.6+0x1a/0x3b
  ? trace_kprobe_create+0xa9e/0xe40
  kasan_report+0xe/0x12
  trace_kprobe_create+0xa9e/0xe40
  ? print_kprobe_event+0x280/0x280
  ? match_held_lock+0x1b/0x240
  ? find_held_lock+0xac/0xd0
  ? fs_reclaim_release.part.112+0x5/0x20
  ? lock_downgrade+0x350/0x350
  ? kasan_unpoison_shadow+0x30/0x40
  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
  ? trace_kprobe_create+0xe40/0xe40
  ? trace_kprobe_create+0xe40/0xe40
  create_or_delete_trace_kprobe+0x2e/0x60
  trace_run_command+0xc3/0xe0
  ? trace_panic_handler+0x20/0x20
  ? kasan_unpoison_shadow+0x30/0x40
  trace_parse_run_command+0xdc/0x163
  vfs_write+0xe1/0x240
  ksys_write+0xba/0x150
  ? __ia32_sys_read+0x50/0x50
  ? tracer_hardirqs_on+0x61/0x180
  ? trace_hardirqs_off_caller+0x43/0x110
  ? mark_held_locks+0x29/0xa0
  ? do_syscall_64+0x14/0x260
  do_syscall_64+0x68/0x260

Fix to check the difference of nr_args before adding probe
on existing probes. This also may set the error log index
bigger than the number of command parameters. In that case
it sets the error position is next to the last parameter.

Link: http://lkml.kernel.org/r/156966474783.3478.13217501608215769150.stgit@devnote2

Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index baf58a3612c0..905b10af5d5c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -178,6 +178,16 @@ void __trace_probe_log_err(int offset, int err_type)
 	if (!command)
 		return;
 
+	if (trace_probe_log.index >= trace_probe_log.argc) {
+		/**
+		 * Set the error position is next to the last arg + space.
+		 * Note that len includes the terminal null and the cursor
+		 * appaers at pos + 1.
+		 */
+		pos = len;
+		offset = 0;
+	}
+
 	/* And make a command string from argv array */
 	p = command;
 	for (i = 0; i < trace_probe_log.argc; i++) {
@@ -1084,6 +1094,12 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 {
 	int i;
 
+	/* In case of more arguments */
+	if (a->nr_args < b->nr_args)
+		return a->nr_args + 1;
+	if (a->nr_args > b->nr_args)
+		return b->nr_args + 1;
+
 	for (i = 0; i < a->nr_args; i++) {
 		if ((b->nr_args <= i) ||
 		    ((a->args[i].type != b->args[i].type) ||
-- 
2.20.1


