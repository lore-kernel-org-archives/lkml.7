Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24BAC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37C32175B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfEZTTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfEZTSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17E821707;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfQ-0004eR-Ra; Sun, 26 May 2019 15:18:48 -0400
Message-Id: <20190526191848.738537461@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 15/16] tracing/kprobe: Do not run kprobe boot tests if kprobe_event is on
 cmdline
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When having kprobe trace event start up tests enabled and adding a
kprobe_event on the kernel command line, it produced the following:

 trace_kprobe: Testing kprobe tracing:
 WARNING: CPU: 5 PID: 1 at kernel/trace/trace_kprobe.c:1724 kprobe_trace_self_tests_init+0x32d/0x36b
 Modules linked in:
 CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-test+ #249
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 RIP: 0010:kprobe_trace_self_tests_init+0x32d/0x36b
 Code: b7 e8 4f 8d a2 fe 85 c0 74 10 0f 0b 48 c7 c7 c8 1b 0d b7 ff c3 e8 19 af 99 fe 48 c7 c7 40 93 27 b7 e8 7f 1a a5 fe 85 c0 74 10 <0f> 0b 48 c7 c7 f8 1b 0d b7 ff c3 e8 f9 ae
9 a0 fe 85
 RSP: 0018:ffffb36e40653e08 EFLAGS: 00010286
 RAX: 00000000fffffff0 RBX: 0000000000000000 RCX: ffffb36e40653d5c
 RDX: 0000000000000000 RSI: ffffffffb72776e0 RDI: 0000000000000246
 RBP: ffff98414fe58ff8 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: ffff98415d8aa940 R12: 0000000000000000
 R13: ffffffffb737c1b0 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff98415ea80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f959ce741b8 CR3: 000000011a210002 CR4: 00000000001606e0
 Call Trace:
  ? init_kprobe_trace+0x19e/0x19e
  ? do_early_param+0x8e/0x8e
  do_one_initcall+0x6f/0x2b4
  ? do_early_param+0x8e/0x8e
  kernel_init_freeable+0x21d/0x2c6
  ? rest_init+0x146/0x146
  kernel_init+0xa/0x10a
  ret_from_fork+0x3a/0x50
 ---[ end trace 488430c083a4c956 ]---

As with the trace events, if a trace event is set on the kernel command
line, the trace events start up tests are suspended. The kprobe start up
tests should do the same when a kprobe is enabled on the kernel command
line.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 004fffd24ec1..7958da2fd922 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -25,6 +25,7 @@
 
 /* Kprobe early definition from command line */
 static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
+static bool kprobe_boot_events_enabled __initdata;
 
 static int __init set_kprobe_boot_events(char *str)
 {
@@ -1538,6 +1539,8 @@ static __init void setup_boot_kprobe_events(void)
 		ret = trace_run_command(cmd, create_or_delete_trace_kprobe);
 		if (ret)
 			pr_warn("Failed to add event(%d): %s\n", ret, cmd);
+		else
+			kprobe_boot_events_enabled = true;
 
 		cmd = p;
 	}
@@ -1611,6 +1614,11 @@ static __init int kprobe_trace_self_tests_init(void)
 	if (tracing_is_disabled())
 		return -ENODEV;
 
+	if (kprobe_boot_events_enabled) {
+		pr_info("Skipping kprobe tests due to kprobe_event on cmdline\n");
+		return 0;
+	}
+
 	target = kprobe_trace_selftest_target;
 
 	pr_info("Testing kprobe tracing: ");
-- 
2.20.1


