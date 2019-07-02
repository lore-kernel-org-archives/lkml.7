Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF105C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B462173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 05:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="SmMt1JgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGBFcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:32:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35414 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBFcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 01:32:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so7108807pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI+ZBN6ChSqbAtZm65019T9P4VT9tQrNvOg71cMTFSY=;
        b=SmMt1JgS293R269mfBTCHcGN+JTBSaL6brVIX+JxhWKry9bTyF9faKtiIWx8hylkG8
         KdD4h1+/WO+c3sH2DR6r9zfXEWOFLXJ0rfj5PhGWGNXeINQJNKwVADDGSHhfcnyoKWqs
         i++/ihc9767U6YvYquutHZ/z1aEg9GQikW1uaJDJeSIXVVw0VCl5r0jX3BiH3ZUFYPoe
         2B8fbHdMJ6kgyGtBn6slotYGJhwxGPgtA0ywHQOTmpw7xtA8Qa4+xqRKcxvxLpIsV7EW
         zfDaztJHiIAZ6HbKP+p558xX33IJKe/IIFfUbZEjOSoVoz7+/CFoz650LS4UKZQ5SZ1+
         ueTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DI+ZBN6ChSqbAtZm65019T9P4VT9tQrNvOg71cMTFSY=;
        b=XDtYE9L6/4j5rpd8wcj8cr2yOx7u6asTJTEC92C5AP9Jxjakz5igmRA5f2m0DuOWcH
         qsOIi5VzSEUFMWP7C6V3a2E1ltAs6dHNDrflCGRdlQCbjd3x05Hg8SNrTepjM399edS2
         1a0jMr11j3HIs/nuOPodYkgaN66ROjVy2yiDBTqSkTpX8k8VJZenwkqE/ujmirSmBEjL
         qpyMV62FR7d8X9Kuxuyl7NjtzPM6FLAJlUh3gLt8XiM8PBHIu9xlWw8QvM5+mctRwwhk
         PDB/27sLLd63A8wTtY5c34X6Sdx4f2E5gEQnS3+Mn5ivTHgqT8Q16yvVdJ33s3pEMvPm
         Vshw==
X-Gm-Message-State: APjAAAV4BRIF+ZONgAzd1nWcMFXtzAdcrclet4oV49EOr4gI5nbSBJXY
        QSncEJh4XEKfxwvbVpXGlVz/HQ==
X-Google-Smtp-Source: APXvYqz5R3H2aatnG/iASy9NOqr4LruL0r8shyydNHGbD9q5v76hCjlHYXUhV829QE/KxznGlPMx4g==
X-Received: by 2002:a63:5c19:: with SMTP id q25mr29206306pgb.215.1562045522046;
        Mon, 01 Jul 2019 22:32:02 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id x7sm12857733pfa.125.2019.07.01.22.31.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 22:32:01 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, edwintorok@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] x86/stacktrace: Do not access user space memory unnecessarily
Date:   Tue,  2 Jul 2019 14:31:51 +0900
Message-Id: <20190702053151.26922-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the boundary check before it accesses user space to prevent unnecessary
access which might crash the machine.

Especially, ftrace preemptirq/irq_disable event with user stack trace
option can trigger SEGV in pid 1 which leads to panic.

Reproducer:

  CONFIG_PREEMPTIRQ_TRACEPOINTS=y
  # echo 1 > events/preemptirq/enable
  # echo userstacktrace > trace_options

Output:

  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  CPU: 1 PID: 1 Comm: systemd Not tainted 5.2.0-rc7+ #10
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Call Trace:
   dump_stack+0x67/0x90
   panic+0x100/0x2c6
   do_exit.cold+0x4e/0x101
   do_group_exit+0x3a/0xa0
   get_signal+0x14a/0x8e0
   do_signal+0x36/0x650
   exit_to_usermode_loop+0x92/0xb0
   prepare_exit_to_usermode+0x6f/0xb0
   retint_user+0x8/0x18
  RIP: 0033:0x55be7ad1c89f
  Code: Bad RIP value.
  RSP: 002b:00007ffe329a4b00 EFLAGS: 00010202
  RAX: 0000000000000768 RBX: 00007ffe329a4ba0 RCX: 00007ff0063aa469
  RDX: 00007ff0066761de RSI: 00007ffe329a4b20 RDI: 0000000000000768
  RBP: 000000000000000b R08: 0000000000000000 R09: 00007ffe329a4e2f
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000768
  R13: 0000000000000000 R14: 0000000000000004 R15: 000055be7b3d3560
  Kernel Offset: 0x2a000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Fixes: 02b67518e2b1 ("tracing: add support for userspace stacktraces in tracing/iter_ctrl")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 arch/x86/kernel/stacktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..6d0c608ffe34 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -123,12 +123,12 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 	while (1) {
 		struct stack_frame_user frame;
 
+		if ((unsigned long)fp < regs->sp)
+			break;
 		frame.next_fp = NULL;
 		frame.ret_addr = 0;
 		if (!copy_stack_frame(fp, &frame))
 			break;
-		if ((unsigned long)fp < regs->sp)
-			break;
 		if (frame.ret_addr) {
 			if (!consume_entry(cookie, frame.ret_addr, false))
 				return;
-- 
2.21.0

