Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6C42196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/1fMe+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLWpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:45:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38398 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLWpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:45:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so278141ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqdCzBL4fzIXodZM8rkfZwLaj0b1Yk/Q6aPJ7Os6kwc=;
        b=P/1fMe+wWJX6jbZLLBGY43qw5To0b0bMXsmhg4Xzi7df/LmWiEtUG+9FZJBIKjgq77
         jGsBMRPolKqk+zUbDMcWiKiGsB/TMmUncwm8yq9/OD1frdeqR6jsN+CTw/68ahtqlOK5
         EpMoXR+iQhtsyjDCmkz31fNJ6Qm6/S9Vr23Hx+WRxcZiIjLj2oJCG1uac83V9UbZBqt6
         rd9lteccBEdsmaKpBby6jWo3CAI0Xgfx9AbBKtGlWr+hUmE/6ha3+FT/Gw7YqEpLXOL8
         piF2PbrZS2lZTF1UjPa/z3ukWhK71JU2BsBlbp2UE/33GkUw7z8HPF71PiZuDMTz3aB3
         kgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqdCzBL4fzIXodZM8rkfZwLaj0b1Yk/Q6aPJ7Os6kwc=;
        b=ChIqSyjx10QthVKbBw4XQZUFozjmXb4Im2iSE3GvFoYHSA5CkYOFwMfD0pcpb5cHjN
         7b5f7JuQfdXlUXDk/tnvwlpIBp5hbqO88/3maIoizWN/l7gVHX2nUpdjUoL8nCNzgwXY
         VVQm/npcPI86q5yqUdSbw+aFL4iYf03k4GRNTg4s28MMOo22rnco8J1pNtR5qkMl4uu7
         BJaRL+KXIxe1HEqZgQwuJVZmHZlDMWoOsxTUVxPMQLQE7tnwpcYBinfotXKhzJAhVEzY
         5FinsbTFojbpTAP8xJ5YKdn9j05YEOKL5KKUNclX61qEQj30BvNxMw2IuYH/kjt5npw/
         zL3A==
X-Gm-Message-State: APjAAAVTfTqsbb3HvZm2lJlKwjYWaEXiHA1rGCwY6O8hn6hdotlvr7GD
        oXF6l4YQr+lVpcHCOq2J8Bc=
X-Google-Smtp-Source: APXvYqz+T2TMWjJnUBOSvqZJioA+3O5QAvhm3vOu3bzPdA6fARtUGFlh1R1OJY3Lyl+yQ1eNyLuJXw==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr127776ljg.154.1573598714419;
        Tue, 12 Nov 2019 14:45:14 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x16sm38677ljd.69.2019.11.12.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:45:13 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 1/2] xtensa: improve stack dumping
Date:   Tue, 12 Nov 2019 14:44:42 -0800
Message-Id: <20191112224443.12267-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112224443.12267-1-jcmvbkbc@gmail.com>
References: <20191112224443.12267-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate printable stack size and use print_hex_dump instead of
opencoding it.
Drop extra newline output in show_trace as its output format does not
depend on CONFIG_KALLSYMS.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- split Kconfig change into separate patch
- use symbolic names instead of hardcoded numbers

Changes v1->v2:
- use print_hex_dump.

 arch/xtensa/kernel/traps.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4a6c495ce9b6..be26ec6c0e0e 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -491,32 +491,27 @@ void show_trace(struct task_struct *task, unsigned long *sp)
 
 	pr_info("Call Trace:\n");
 	walk_stackframe(sp, show_trace_cb, NULL);
-#ifndef CONFIG_KALLSYMS
-	pr_cont("\n");
-#endif
 }
 
-static int kstack_depth_to_print = 24;
+#define STACK_DUMP_ENTRY_SIZE 4
+#define STACK_DUMP_LINE_SIZE 32
+static size_t kstack_depth_to_print = 24;
 
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
-	int i = 0;
-	unsigned long *stack;
+	size_t len;
 
 	if (!sp)
 		sp = stack_pointer(task);
-	stack = sp;
 
-	pr_info("Stack:\n");
+	len = min((-(size_t)sp) & (THREAD_SIZE - STACK_DUMP_ENTRY_SIZE),
+		  kstack_depth_to_print * STACK_DUMP_ENTRY_SIZE);
 
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (kstack_end(sp))
-			break;
-		pr_cont(" %08lx", *sp++);
-		if (i % 8 == 7)
-			pr_cont("\n");
-	}
-	show_trace(task, stack);
+	pr_info("Stack:\n");
+	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
+		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
+		       sp, len, false);
+	show_trace(task, sp);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.20.1

