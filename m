Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5091B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568697104;
	bh=6OhqaKVo+45Hb0VMugIwa8wKLF4KJrE+u/OOmLKam2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1xgpVTOCDzdhm30b+gY7WmpwJ30c+wPGGdX7omEgEo/pkxHMGda1MywdMB21lwHtu
	 hH/8Ru0Nk0LwXZJapo9lzPQzk4u/ZHzXr1+l3Y5tecqdQiZUO3yh/Qi+lWeV7HGu4B
	 7uj25cu5mFLZfh6xB4EX82+UKzQJ+vKdl+IB/Wdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbfIQFLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391009AbfIQFLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:11:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B985321670;
        Tue, 17 Sep 2019 05:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568697102;
        bh=6OhqaKVo+45Hb0VMugIwa8wKLF4KJrE+u/OOmLKam2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4juVO3qnTAszfERWMBKmck22DwyWiBdtsZSDXQ3Vxl4v9pmf9ReSo4s66gftY2hJ
         h/iaYdcn3bU6Ldc4A4pBetzsjiLbtqDtiiT2HDasqe5D7gRl6OVgYZqQqIqFiBhLVW
         TrSWHC7uoMGj9bXO1UEcpI/BKXSkoPgIM8Fa5pKM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com
Subject: [PATCH] tracing/kprobe: Fix NULL pointer access in trace_porbe_unlink()
Date:   Tue, 17 Sep 2019 14:11:37 +0900
Message-Id: <156869709721.22406.5153754822203046939.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0000000000003006220592b41c5b@google.com>
References: <0000000000003006220592b41c5b@google.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer access in trace_probe_unlink() by initializing
trace_probe.list correctly in trace_probe_init().

In the error case of trace_probe_init(), it can call trace_probe_unlink()
before initializing trace_probe.list member. This causes NULL pointer
dereference at list_del_init() in trace_probe_unlink().

Syzbot reported :

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8633 Comm: syz-executor797 Not tainted 5.3.0-rc8-next-20190915
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x85/0xf5 lib/list_debug.c:51
Code: 0f 84 e1 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75
53 49 8b 14 24 4c 39 f2 0f 85 99 00 00 00 49 8d 7d
RSP: 0018:ffff888090a7f9d8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88809b6f90c0 RCX: ffffffff817c0ca9
RDX: 0000000000000000 RSI: ffffffff817c0a73 RDI: ffff88809b6f90c8
RBP: ffff888090a7f9f0 R08: ffff88809a04e600 R09: ffffed1015d26aed
R10: ffffed1015d26aec R11: ffff8880ae935763 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88809b6f90c0 R15: ffff88809b6f90d0
FS:  0000555556f99880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cc090 CR3: 00000000962b2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:131 [inline]
  list_del_init include/linux/list.h:190 [inline]
  trace_probe_unlink+0x1f/0x200 kernel/trace/trace_probe.c:959
  trace_probe_cleanup+0xd3/0x110 kernel/trace/trace_probe.c:973
  trace_probe_init+0x3f2/0x510 kernel/trace/trace_probe.c:1011
  alloc_trace_uprobe+0x5e/0x250 kernel/trace/trace_uprobe.c:353
  create_local_trace_uprobe+0x109/0x4a0 kernel/trace/trace_uprobe.c:1508
  perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:314
  perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8898
  perf_try_init_event+0x135/0x590 kernel/events/core.c:10184
  perf_init_event kernel/events/core.c:10228 [inline]
  perf_event_alloc.part.0+0x1b89/0x33d0 kernel/events/core.c:10505
  perf_event_alloc kernel/events/core.c:10887 [inline]
  __do_sys_perf_event_open+0xa2d/0x2d00 kernel/events/core.c:10989
  __se_sys_perf_event_open kernel/events/core.c:10871 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10871
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: syzbot+2f807f4d3a2a4e87f18f@syzkaller.appspotmail.com
Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1e67fef06e53..baf58a3612c0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -986,6 +986,12 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 	if (!tp->event)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&tp->event->files);
+	INIT_LIST_HEAD(&tp->event->class.fields);
+	INIT_LIST_HEAD(&tp->event->probes);
+	INIT_LIST_HEAD(&tp->list);
+	list_add(&tp->event->probes, &tp->list);
+
 	call = trace_probe_event_call(tp);
 	call->class = &tp->event->class;
 	call->name = kstrdup(event, GFP_KERNEL);
@@ -999,11 +1005,6 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 		ret = -ENOMEM;
 		goto error;
 	}
-	INIT_LIST_HEAD(&tp->event->files);
-	INIT_LIST_HEAD(&tp->event->class.fields);
-	INIT_LIST_HEAD(&tp->event->probes);
-	INIT_LIST_HEAD(&tp->list);
-	list_add(&tp->event->probes, &tp->list);
 
 	return 0;
 

