Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3F820863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfCZMmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZMmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:42:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2769420856;
        Tue, 26 Mar 2019 12:42:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h8lP5-0005ZG-Af; Tue, 26 Mar 2019 08:42:07 -0400
Message-Id: <20190326124207.218684720@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 26 Mar 2019 08:41:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 1/3] tracing: Remove unnecessary var_ref destroy in track_data_destroy()
References: <20190326124143.521905652@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Commit 656fe2ba85e8 (tracing: Use hist trigger's var_ref array to
destroy var_refs) centralized the destruction of all the var_refs
in one place so that other code didn't have to do it.

The track_data_destroy() added later ignored that and also destroyed
the track_data var_ref, causing a double-free error flagged by KASAN.

==================================================================
BUG: KASAN: use-after-free in destroy_hist_field+0x30/0x70
Read of size 8 at addr ffff888086df2210 by task bash/1694

CPU: 6 PID: 1694 Comm: bash Not tainted 5.1.0-rc1-test+ #15
Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03
07/14/2016
Call Trace:
 dump_stack+0x71/0xa0
 ? destroy_hist_field+0x30/0x70
 print_address_description.cold.3+0x9/0x1fb
 ? destroy_hist_field+0x30/0x70
 ? destroy_hist_field+0x30/0x70
 kasan_report.cold.4+0x1a/0x33
 ? __kasan_slab_free+0x100/0x150
 ? destroy_hist_field+0x30/0x70
 destroy_hist_field+0x30/0x70
 track_data_destroy+0x55/0xe0
 destroy_hist_data+0x1f0/0x350
 hist_unreg_all+0x203/0x220
 event_trigger_open+0xbb/0x130
 do_dentry_open+0x296/0x700
 ? stacktrace_count_trigger+0x30/0x30
 ? generic_permission+0x56/0x200
 ? __x64_sys_fchdir+0xd0/0xd0
 ? inode_permission+0x55/0x200
 ? security_inode_permission+0x18/0x60
 path_openat+0x633/0x22b0
 ? path_lookupat.isra.50+0x420/0x420
 ? __kasan_kmalloc.constprop.12+0xc1/0xd0
 ? kmem_cache_alloc+0xe5/0x260
 ? getname_flags+0x6c/0x2a0
 ? do_sys_open+0x149/0x2b0
 ? do_syscall_64+0x73/0x1b0
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
 ? _raw_write_lock_bh+0xe0/0xe0
 ? __kernel_text_address+0xe/0x30
 ? unwind_get_return_address+0x2f/0x50
 ? __list_add_valid+0x2d/0x70
 ? deactivate_slab.isra.62+0x1f4/0x5a0
 ? getname_flags+0x6c/0x2a0
 ? set_track+0x76/0x120
 do_filp_open+0x11a/0x1a0
 ? may_open_dev+0x50/0x50
 ? _raw_spin_lock+0x7a/0xd0
 ? _raw_write_lock_bh+0xe0/0xe0
 ? __alloc_fd+0x10f/0x200
 do_sys_open+0x1db/0x2b0
 ? filp_open+0x50/0x50
 do_syscall_64+0x73/0x1b0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fa7b24a4ca2
Code: 25 00 00 41 00 3d 00 00 41 00 74 4c 48 8d 05 85 7a 0d 00 8b 00 85 c0
75 6d 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff
0f 87 a2 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
RSP: 002b:00007fffbafb3af0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d3648ade30 RCX: 00007fa7b24a4ca2
RDX: 0000000000000241 RSI: 000055d364a55240 RDI: 00000000ffffff9c
RBP: 00007fffbafb3bf0 R08: 0000000000000020 R09: 0000000000000002
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000001 R15: 000055d364a55240
==================================================================

So remove the track_data_destroy() destroy_hist_field() call for that
var_ref.

Link: http://lkml.kernel.org/r/1deffec420f6a16d11dd8647318d34a66d1989a9.camel@linux.intel.com

Fixes: 466f4528fbc69 ("tracing: Generalize hist trigger onmax and save action")
Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca46339f3009..795aa2038377 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3713,7 +3713,6 @@ static void track_data_destroy(struct hist_trigger_data *hist_data,
 	struct trace_event_file *file = hist_data->event_file;
 
 	destroy_hist_field(data->track_data.track_var, 0);
-	destroy_hist_field(data->track_data.var_ref, 0);
 
 	if (data->action == ACTION_SNAPSHOT) {
 		struct track_data *track_data;
-- 
2.20.1


