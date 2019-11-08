Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD3A2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG+3TGFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKHApC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:45:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44845 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:45:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id v4so3043160lfd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SncMCZY11gPJIfKbfsmrvxmuN/67o00wSU4yUgQ2zL0=;
        b=JG+3TGFrcv/9M9GIXFwmuqadILvxRaOJD6hZNFXM928X+RZ2USWGkQ1+IuQWVZ/NMK
         ZtJo2s+KTeIF3ceufpu/jBJzuz/WxGSbfnss4XgB+ne5tX73CYGixbfD6KrymjvndVkE
         JHQ8+4jmZA81gPeoTmM61ZEQIZ5dwHFQ3W6Nrjl6bxU7KxkA54JtN0tHzz6jx1kXvsD7
         JQMRWR+qlCJyR7aOroxmXMaMZzfw+GRo10VTJPgRmNk5acjYCYT+NzPYorkCFbaa+nVm
         FMLdBRKPu4JE02giveSEKuwW0owEIaumTYmRfU0C00ZIJ1VvWv7vp/UV9hefbUcpWcNE
         FB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SncMCZY11gPJIfKbfsmrvxmuN/67o00wSU4yUgQ2zL0=;
        b=naSWimY9Mcv9c4WPEGB46c7b4TkaT1u8dp85LO3z2lfjF3MR6KyGhitxpPLzWuN+Xf
         GQDlIUCMpk9o0O5Y2wHB9xIfK3oWJMMU+K2E+MCVg0BbIVbZYG4kvBPgi+pRdAAatGDu
         9N2pw2SSXGKD4RLviim2/lCNrmIWYAbyMu76yVtx+F6ESkdamEBubfTJtDHHPZMQJJIg
         7Ye8JDNXW9DCzwxzkuixh+NC95K+cwR8JeZ7F3wiTEapEwKkSLKhxphJ6P2cuZRvou4u
         Dueb+uZIxRv/PaV6kB/qsbMFix39ieu1TJfXdiGBjYFaAOzunLqc6f2whIDopcO9s4wD
         TwAg==
X-Gm-Message-State: APjAAAVeuOL9uSJbZBjN1t26j9q/SH/VRTTKaizdM1JBUL9I8idd93To
        v0mj9tmKQ8GTpwiwRZnyIeE=
X-Google-Smtp-Source: APXvYqwM1abusWEJ9GBD5a7TrzO7cvXBlvs/lyTxJwFfjI971RgSgp9eXL8yJ0PQ6mYK4iAlrdWITA==
X-Received: by 2002:a19:fc1e:: with SMTP id a30mr4467814lfi.167.1573173899613;
        Thu, 07 Nov 2019 16:44:59 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id y6sm2029544ljn.40.2019.11.07.16.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:44:58 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: improve stack dumping
Date:   Thu,  7 Nov 2019 16:44:48 -0800
Message-Id: <20191108004448.5386-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate printable stack size and use print_hex_dump instead of
opencoding it.
Make size of stack dump configurable.
Drop extra newline output in show_trace as its output format does not
depend on CONFIG_KALLSYMS.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- use print_hex_dump.

 arch/xtensa/Kconfig.debug  |  7 +++++++
 arch/xtensa/kernel/traps.c | 24 ++++++++----------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
index 39de98e20018..83cc8d12fa0e 100644
--- a/arch/xtensa/Kconfig.debug
+++ b/arch/xtensa/Kconfig.debug
@@ -31,3 +31,10 @@ config S32C1I_SELFTEST
 	  It is easy to make wrong hardware configuration, this test should catch it early.
 
 	  Say 'N' on stable hardware.
+
+config PRINT_STACK_DEPTH
+	int "Stack depth to print" if DEBUG_KERNEL
+	default 64
+	help
+	  This option allows you to set the stack depth that the kernel
+	  prints in stack traces.
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4a6c495ce9b6..fe090ab1cab8 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -491,32 +491,24 @@ void show_trace(struct task_struct *task, unsigned long *sp)
 
 	pr_info("Call Trace:\n");
 	walk_stackframe(sp, show_trace_cb, NULL);
-#ifndef CONFIG_KALLSYMS
-	pr_cont("\n");
-#endif
 }
 
-static int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
-	int i = 0;
-	unsigned long *stack;
+	size_t len;
 
 	if (!sp)
 		sp = stack_pointer(task);
-	stack = sp;
 
-	pr_info("Stack:\n");
+	len = min((-(unsigned long)sp) & (THREAD_SIZE - 4),
+		  kstack_depth_to_print * 4ul);
 
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (kstack_end(sp))
-			break;
-		pr_cont(" %08lx", *sp++);
-		if (i % 8 == 7)
-			pr_cont("\n");
-	}
-	show_trace(task, stack);
+	pr_info("Stack:\n");
+	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE, 32, 4,
+		       sp, len, false);
+	show_trace(task, sp);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.20.1

