Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0C2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfJMRo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfJMRoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:44:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11CF2089C;
        Sun, 13 Oct 2019 17:44:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJhum-00025F-1A; Sun, 13 Oct 2019 13:44:20 -0400
Message-Id: <20191013174419.917699324@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 13 Oct 2019 13:43:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [for-linus][PATCH 11/11] tracing: Initialize iter->seq after zeroing in tracing_read_pipe()
References: <20191013174342.381019558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

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

Link: http://lkml.kernel.org/r/20191011142134.11997-1-pmladek@suse.com

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b4eff383505..6a0ee9178365 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6036,6 +6036,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	       sizeof(struct trace_iterator) -
 	       offsetof(struct trace_iterator, seq));
 	cpumask_clear(iter->started);
+	trace_seq_init(&iter->seq);
 	iter->pos = -1;
 
 	trace_event_read_lock();
-- 
2.23.0


