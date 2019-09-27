Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCAD217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfI0Jul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0Jul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:50:41 -0400
Received: from oasis.local.home (unknown [65.39.69.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFCF2146E;
        Fri, 27 Sep 2019 09:50:39 +0000 (UTC)
Date:   Fri, 27 Sep 2019 05:50:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] tracing/probe: Test nr_args match in looking for same probe
 events
Message-ID: <20190927055035.4c3abae9@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Testing triggered:

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

The cause was that the args array to compare between two probe events only
looked at one of the probe events size. If the other one had a smaller
number of args, it would read out of bounds memory.

Fixes: fe60b0ce8e733 ("tracing/probe: Reject exactly same probe event")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 2 ++
 kernel/trace/trace_uprobe.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 402dc3ce88d3..d2543a403f25 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -537,6 +537,8 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
 
 	list_for_each_entry(pos, &tpe->probes, list) {
 		orig = container_of(pos, struct trace_kprobe, tp);
+		if (orig->tp.nr_args != comp->tp.nr_args)
+			continue;
 		if (strcmp(trace_kprobe_symbol(orig),
 			   trace_kprobe_symbol(comp)) ||
 		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index dd884341f5c5..11bcafdc93e2 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -420,6 +420,8 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 
 	list_for_each_entry(pos, &tpe->probes, list) {
 		orig = container_of(pos, struct trace_uprobe, tp);
+		if (orig->tp.nr_args != comp->tp.nr_args)
+			continue;
 		if (comp_inode != d_real_inode(orig->path.dentry) ||
 		    comp->offset != orig->offset)
 			continue;
-- 
2.20.1

