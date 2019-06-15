Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9376C31E54
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D732184D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFOMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfFOMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:43:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB6B21848;
        Sat, 15 Jun 2019 12:43:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hc81Y-0006cB-Ni; Sat, 15 Jun 2019 08:43:12 -0400
Message-Id: <20190615124312.621613580@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 15 Jun 2019 08:42:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eiichi Tsukata <devel@etsukata.com>
Subject: [for-linus][PATCH 1/7] tracing: Fix out-of-range read in trace_stack_print()
References: <20190615124216.188179157@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>

Puts range check before dereferencing the pointer.

Reproducer:

  # echo stacktrace > trace_options
  # echo 1 > events/enable
  # cat trace > /dev/null

KASAN report:

  ==================================================================
  BUG: KASAN: use-after-free in trace_stack_print+0x26b/0x2c0
  Read of size 8 at addr ffff888069d20000 by task cat/1953

  CPU: 0 PID: 1953 Comm: cat Not tainted 5.2.0-rc3+ #5
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  Call Trace:
   dump_stack+0x8a/0xce
   print_address_description+0x60/0x224
   ? trace_stack_print+0x26b/0x2c0
   ? trace_stack_print+0x26b/0x2c0
   __kasan_report.cold+0x1a/0x3e
   ? trace_stack_print+0x26b/0x2c0
   kasan_report+0xe/0x20
   trace_stack_print+0x26b/0x2c0
   print_trace_line+0x6ea/0x14d0
   ? tracing_buffers_read+0x700/0x700
   ? trace_find_next_entry_inc+0x158/0x1d0
   s_show+0xea/0x310
   seq_read+0xaa7/0x10e0
   ? seq_escape+0x230/0x230
   __vfs_read+0x7c/0x100
   vfs_read+0x16c/0x3a0
   ksys_read+0x121/0x240
   ? kernel_write+0x110/0x110
   ? perf_trace_sys_enter+0x8a0/0x8a0
   ? syscall_slow_exit_work+0xa9/0x410
   do_syscall_64+0xb7/0x390
   ? prepare_exit_to_usermode+0x165/0x200
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  RIP: 0033:0x7f867681f910
  Code: b6 fe ff ff 48 8d 3d 0f be 08 00 48 83 ec 08 e8 06 db 01 00 66 0f 1f 44 00 00 83 3d f9 2d 2c 00 00 75 10 b8 00 00 00 00 04
  RSP: 002b:00007ffdabf23488 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f867681f910
  RDX: 0000000000020000 RSI: 00007f8676cde000 RDI: 0000000000000003
  RBP: 00007f8676cde000 R08: ffffffffffffffff R09: 0000000000000000
  R10: 0000000000000871 R11: 0000000000000246 R12: 00007f8676cde000
  R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000000ec0

  Allocated by task 1214:
   save_stack+0x1b/0x80
   __kasan_kmalloc.constprop.0+0xc2/0xd0
   kmem_cache_alloc+0xaf/0x1a0
   getname_flags+0xd2/0x5b0
   do_sys_open+0x277/0x5a0
   do_syscall_64+0xb7/0x390
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  Freed by task 1214:
   save_stack+0x1b/0x80
   __kasan_slab_free+0x12c/0x170
   kmem_cache_free+0x8a/0x1c0
   putname+0xe1/0x120
   do_sys_open+0x2c5/0x5a0
   do_syscall_64+0xb7/0x390
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

  The buggy address belongs to the object at ffff888069d20000
   which belongs to the cache names_cache of size 4096
  The buggy address is located 0 bytes inside of
   4096-byte region [ffff888069d20000, ffff888069d21000)
  The buggy address belongs to the page:
  page:ffffea0001a74800 refcount:1 mapcount:0 mapping:ffff88806ccd1380 index:0x0 compound_mapcount: 0
  flags: 0x100000000010200(slab|head)
  raw: 0100000000010200 dead000000000100 dead000000000200 ffff88806ccd1380
  raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888069d1ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff888069d1ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff888069d20000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                     ^
   ffff888069d20080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff888069d20100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ==================================================================

Link: http://lkml.kernel.org/r/20190610040016.5598-1-devel@etsukata.com

Fixes: 4285f2fcef80 ("tracing: Remove the ULONG_MAX stack trace hackery")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..ba751f993c3b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1057,7 +1057,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 
 	trace_seq_puts(s, "<stack trace>\n");
 
-	for (p = field->caller; p && *p != ULONG_MAX && p < end; p++) {
+	for (p = field->caller; p && p < end && *p != ULONG_MAX; p++) {
 
 		if (trace_seq_has_overflowed(s))
 			break;
-- 
2.20.1


