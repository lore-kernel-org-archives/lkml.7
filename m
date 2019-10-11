Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BEC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6736A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfJKOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:22:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:58784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbfJKOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51A5AB664;
        Fri, 11 Oct 2019 14:22:00 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] trace: Initialize iter->seq after zeroing in tracing_read_pipe()
Date:   Fri, 11 Oct 2019 16:21:34 +0200
Message-Id: <20191011142134.11997-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer reported the following softlockup:

[899688.160002] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [test.sh:16464]
[899688.160002] CPU: 0 PID: 16464 Comm: test.sh Not tainted 4.12.14-6.23-azure #1 SLE12-SP4
[899688.160002] RIP: 0010:up_write+0x1a/0x30
[899688.160002] Kernel panic - not syncing: softlockup: hung tasks
[899688.160002] RIP: 0010:up_write+0x1a/0x30
[899688.160002] RSP: 0018:ffffa86784d4fde8 EFLAGS: 00000257 ORIG_RAX: ffffffffffffff12
[899688.160002] RAX: ffffffff970fea00 RBX: 0000000000000001 RCX: 0000000000000000
[899688.160002] RDX: ffffffff00000001 RSI: 0000000000000080 RDI: ffffffff970fea00
[899688.160002] RBP: ffffffffffffffff R08: ffffffffffffffff R09: 0000000000000000
[899688.160002] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8b59014720d8
[899688.160002] R13: ffff8b59014720c0 R14: ffff8b5901471090 R15: ffff8b5901470000
[899688.160002]  tracing_read_pipe+0x336/0x3c0
[899688.160002]  __vfs_read+0x26/0x140
[899688.160002]  vfs_read+0x87/0x130
[899688.160002]  SyS_read+0x42/0x90
[899688.160002]  do_syscall_64+0x74/0x160

It caught the process in the middle of trace_access_unlock(). There is
no loop. So, it must be looping in the caller tracing_read_pipe()
via the "waitagain" label.

Crashdump analyze uncovered that iter->seq was completely zeroed
at this point, including iter->seq.seq.size. It means that
print_trace_line() was never able to print anything and
there was no forward progress.

The culprit seems to be in the code:

	/* reset all but tr, trace, and overruns */
	memset(&iter->seq, 0,
	       sizeof(struct trace_iterator) -
	       offsetof(struct trace_iterator, seq));

It was added by the commit 53d0aa773053ab182877 ("ftrace:
add logic to record overruns"). It was v2.6.27-rc1.
It was the time when iter->seq looked like:

     struct trace_seq {
	unsigned char		buffer[PAGE_SIZE];
	unsigned int		len;
     };

There was no "size" variable and zeroing was perfectly fine.

The solution is to reinitialize the structure after or without
zeroing.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 252f79c435f8..e758674b0c07 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5999,6 +5999,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	       sizeof(struct trace_iterator) -
 	       offsetof(struct trace_iterator, seq));
 	cpumask_clear(iter->started);
+	trace_seq_init(&iter->seq);
 	iter->pos = -1;
 
 	trace_event_read_lock();
-- 
2.16.4

