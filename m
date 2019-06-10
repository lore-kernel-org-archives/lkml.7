Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BFC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="s7rk88G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFJEAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:00:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38622 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfFJEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:00:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so3082572plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIKxS5OumGs3DzOoJ28/txvmHczgPmtglYZymkeJfGs=;
        b=s7rk88G9K+6B5PYi2FcqXaWBT6QDvAJHN8upCl4ncjO/+jHm5Cr8XE5HGlykOMn20M
         V2hx5xq5wgN+ZqI6aVRNOTA43ghy5qGMSFL4Pgs1M43Byp8UMYfHisFcICjsPgXpy914
         oivWlHS5xd+cmJc6UWpy1oBo377+AriAz1jX3EWkqSI4mFoWQ7aoS/P7vuXSp3kufs9B
         zEsAHYpqftSIRhm3I06aTLkY0kb3ln4ARfEIpwND+rG0/PVwNP39DctHefsm9JVhXmKQ
         Gljb2RsRJqgC8aTkGI01FqpH+r0od7NStanZfRyIhAh+dVNk9eu/RzgyrKHikorzQ1tI
         v3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIKxS5OumGs3DzOoJ28/txvmHczgPmtglYZymkeJfGs=;
        b=CFN7nFGikAE7JuHLy2S/awRW8i/JWapkp9ZFribVdrZrRO+DgYnFsAMpPuIRLENqtw
         W+F6S4H/Xnv5//VyWBLhHL6si8rklRirTzIHMChJdfIPZa/CvXbHYMOrHMVxLhxr+UCA
         qZYc3vnhiftZeQeL6AFeKn4ZIspSizDmFqaG00BU1ijwYJbDkxGMtoplnRDeaOARNmv3
         zZOu5xv4VZN2v4AusR5ZLBDMxgKcvOHyOB+mlwNA7umq1Ln6wcvreIgLE2ZtoDesLmEW
         P6Z94mZqkzhbVSA9ZJgj9XgLzeJH9rdEHYeSXc/LlTGrRHzB4QpBnrhYXVRmZBss0itI
         PgeA==
X-Gm-Message-State: APjAAAXGKX8fKNwuGF9mCxo/A8g4dTq8GMcI5j0iYZq3+sD3S3ClzEtr
        xSUOCbyZOaBIIsgsqgCPntH/cQ==
X-Google-Smtp-Source: APXvYqw8FceUzH3sUZBsf2yn4qoAcyyK6z6DXnnBoiVl34Sq8Dy7BY8zMB1FwAHC1F9I5J+KXvrXtA==
X-Received: by 2002:a17:902:29c3:: with SMTP id h61mr33792604plb.37.1560139230291;
        Sun, 09 Jun 2019 21:00:30 -0700 (PDT)
Received: from localhost.localdomain (p1227188-ipngn14401marunouchi.tokyo.ocn.ne.jp. [153.205.136.188])
        by smtp.gmail.com with ESMTPSA id x129sm9717461pfb.29.2019.06.09.21.00.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 21:00:29 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] tracing: Fix out-of-range read in trace_stack_print()
Date:   Mon, 10 Jun 2019 13:00:16 +0900
Message-Id: <20190610040016.5598-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 4a9bd3f134dec ("tracing: Have dynamic size event stack traces")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
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
2.21.0

