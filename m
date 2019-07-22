Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F8222FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="Sb9TYCEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfGVIeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:34:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41877 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGVIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:34:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so17039471pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmRFn+abS8O4LAhWJqAmS3gYc/C8VlF47bLzkFvJ8as=;
        b=Sb9TYCEZmbjOx3qaxcr4sWNtQxGdJbaqWwnUomajirv9s0QBe5/2/vGgyPe8Q+KTuI
         qiukmKnMk1MEC0sMxBJ8Em5hN5b447rkHhaaDfICHxnkRwfS5aPgIL7FqW79s0G+LDIh
         S9RJgQeUuGceJp9JjfAiKoD/mM7kTmavMzSM9MECfltyIt6EGMsTN9tNJ8w6b3x2sb9Y
         y25qlKq4R8yqVPgz07AhBZL4qf2U/XYVbOmBKEVH7svL6kJHhlNsuC4IF+AWPvHeA45t
         2NdWqbrCLfDOCvgsrwy7KnTz5qhPTLLkwUBdB+JlbEd1CqVPgUj+P5uYnV5LejF42tYu
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmRFn+abS8O4LAhWJqAmS3gYc/C8VlF47bLzkFvJ8as=;
        b=nxk674jMBmko4cSrfjUhj+65g0N7dhJXB0I6eMglbNoZOwwD33b4Nk/QguaqvNy+Gd
         iEEVuUiITHQFpxl8cxPBFa2LMjPK4GTYZio61UsyQUJTyQYFaENTns9CUDwIUQGgwAur
         1w0CUjMSldXhIiW8KQ3f7J7AYlk2RdRjGHGCzUiQQVnoC5AEN5zgqEAd3QOibBCUensZ
         baTiJb6HtQAA620WciN+DFj8CxwrypuFZZ8aHbRLNpD+jHzgYF3FalV72BjCqOofSHPx
         KbIxR/y+dgsCdFIvo4VuJqitBcwEDRQiEd9wjdPX+FwaZ5+Wj6LgJVBhKeuz7abfZgyG
         tS5w==
X-Gm-Message-State: APjAAAVlNTKeaMqI5NSBrUGA225JdxVSwqDGvhjTceHCrFS0e2ahkcm3
        hUWyUJaY10QTVnOGx5xkBu0=
X-Google-Smtp-Source: APXvYqw2V7DteuHYX2si0LoZiy1ZwTKFUvtFkkRW9ltIQ91Epx8xL+itUmFB1YNpk93cxc6eiMhpSg==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr72742091pga.334.1563784453444;
        Mon, 22 Jul 2019 01:34:13 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id n89sm51344032pjc.0.2019.07.22.01.34.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 01:34:12 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     mhiramat@kernel.org
Cc:     juri.lelli@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        williams@redhat.com, Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH 1/1] x86/stacktrace: Fix userstacktrace access_ok() WARNING in irq events
Date:   Mon, 22 Jul 2019 17:32:16 +0900
Message-Id: <20190722083216.16192-2-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722083216.16192-1-devel@etsukata.com>
References: <20190621231232.259536faeea4b19cf39a7688@kernel.org>
 <20190722083216.16192-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arch_stack_walk_user() is called from irq context, access_ok() can
trigger the following WARNING if compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y.

Reproducer:

  // CONFIG_DEBUG_ATOMIC_SLEEP=y
  # cd /sys/kernel/debug/tracing
  # echo 1 > options/userstacktrace
  # echo 1 > events/irq/irq_handler_entry/enable

WARNING:

  WARNING: CPU: 0 PID: 2649 at arch/x86/kernel/stacktrace.c:103 arch_stack_walk_user+0x6e/0xf6
  Modules linked in:
  CPU: 0 PID: 2649 Comm: bash Not tainted 5.3.0-rc1+ #99
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  RIP: 0010:arch_stack_walk_user+0x6e/0xf6
  Code: 00 48 89 45 c8 48 89 da 49 89 c7 49 89 c5 65 8b 05 5f 3f 3c 72 a9 00 01 1f 00 74 10 48 8b 45 c8 8b 80 58 16 00 00 85 c0 75 02 <0f> 0b 49 8b 85 18 17 00 00 48 83 e8 10 48 39 c2 77 32 41 83 85 58
  RSP: 0018:ffff888068a09bc0 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 00005567f28dc6a0 RCX: ffffffff8ddf6b71
  RDX: 00005567f28dc6a0 RSI: 00007f3fcf7d20f8 RDI: ffff888068475048
  RBP: ffff888068a09bf8 R08: ffffffff8ddf6b4b R09: ffffed100ced26f1
  R10: ffffed100ced26f0 R11: ffff888067693787 R12: ffff88807c1bff58
  R13: ffff888067693780 R14: ffff888068a09c28 R15: ffff888067693780
  FS:  00007f3fcf6e3740(0000) GS:ffff888068a00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000055cd64646630 CR3: 000000005e230004 CR4: 0000000000160ef0
  Call Trace:
   <IRQ>
   ? stack_trace_save+0xc0/0xc0
   stack_trace_save_user+0x10a/0x16d
   ? stack_trace_save_tsk_reliable+0x1c0/0x1c0
   ? __kasan_check_read+0x11/0x20
   trace_buffer_unlock_commit_regs+0x185/0x240
   trace_event_buffer_commit+0xec/0x330
   trace_event_raw_event_irq_handler_entry+0x159/0x1e0
   ? perf_trace_softirq+0x250/0x250
   ? check_chain_key+0x1da/0x2d0
   ? perf_trace_softirq+0x250/0x250
   __handle_irq_event_percpu+0x22d/0x440
   handle_irq_event_percpu+0x70/0x100
   ? __handle_irq_event_percpu+0x440/0x440
   ? __kasan_check_read+0x11/0x20
   ? preempt_count_sub+0x1a/0x120
   handle_irq_event+0x5a/0x8b
   handle_edge_irq+0x12f/0x3f0
   handle_irq+0x34/0x40
   do_IRQ+0xa6/0x1f0
   common_interrupt+0xf/0xf
   </IRQ>

Fix it by calling __range_not_ok() directly instead of access_ok() as
copy_from_user_nmi() does. This is fine here because the actual copy is
inside a pagefault disabled region.

Reported-by: Juri Lelli <juri.lelli@gmail.com>
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 arch/x86/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 4f36d3241faf..2d6898c2cb64 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -100,7 +100,7 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 {
 	int ret;
 
-	if (!access_ok(fp, sizeof(*frame)))
+	if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
 		return 0;
 
 	ret = 1;
-- 
2.21.0

