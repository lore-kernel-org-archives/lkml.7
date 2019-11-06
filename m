Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A68C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481172166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/eQWTe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfKFSQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:16:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33506 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKFSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:16:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so27252257ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xT8iUzv28AccBALCzubNLTgJqXnu61TsgsHE/dDWhrM=;
        b=r/eQWTe/mz/PiMRmWAOPO09nJRU7KWxRCz+PhtRqScjowOS3NAMuGMfOEC+UGAD5ou
         E7DrVWBlm75uEUrk6j6kWo4bYobY/eYzZ6z9g/6Rc5rf/wezJOUyh21FUtkyY09ROYUH
         BPZ71nklPlzf1SZ5DhOws/ac3xmCbDx2luvwlKuuCC0yYY0wZNP6TOOX4KPArMKf5JnG
         t3GIeDHZGkY7iX7gx25Ppn7uKrdM3tVPO+3xovdQ8GO5rMEUtCj4NdNYAoWtHEnlHKvv
         C+hb6Hw+xLZg/WEzWms7pPYiSFL9bn+pI1Awp2VEhqZoacNlidZaAnc0QihEx/N6mNdt
         RJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xT8iUzv28AccBALCzubNLTgJqXnu61TsgsHE/dDWhrM=;
        b=eoGTcds33llq2nr41twKoSC54dd+jIoQtgn1jjluWO+Y1qKurApW7ENfiKby47ZIpA
         vr/bC1PGhkAukirLQ4FasC2ODWYllkCyDq62Row8oL4mLgefrhLFz9ZWo/r190O/82D6
         I4vfZ/q50sofolCFacXkGUXU59JhEDuHQRra4eYyvxEU5GZp65Nn9sqh5N3fu2Uh37U4
         nYu24XOeCm/L2loSuV7M9z2yXrHmTULhAQ/hn/qHIg3CxvJz/PZsyxiBAqPedWjJMc8A
         +89njlAzHuiAhr0KJxOvgSekxQU14eePWhyEG6xPlIno+2bSf8grnku2qRZkyzP/wQFH
         sDvg==
X-Gm-Message-State: APjAAAVs75atsCXJPKnByOGXL2nzHJeiLqwwf0osi8danI7sz/6IPz5k
        zP15ZRZdRtKp2ix0D33sOCM=
X-Google-Smtp-Source: APXvYqxVZqs41D0CX2V7LeMkINUOFsrvTXPdCEHvmi9XfmCDf8wQacmREboXQxenEPTsuj/4vJ/DUg==
X-Received: by 2002:a2e:90b:: with SMTP id 11mr2873372ljj.233.1573064200610;
        Wed, 06 Nov 2019 10:16:40 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id l82sm11318139lfd.81.2019.11.06.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:16:40 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: improve stack dumping
Date:   Wed,  6 Nov 2019 10:16:17 -0800
Message-Id: <20191106181617.1832-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect whole stack dump lines in a buffer and print the whole buffer
when it's ready with pr_info instead of pr_cont. This makes stack dump
lines consistent in SMP case and relies less on pr_cont/printk
differences related to timestamps.
Make size of stack dump configurable.
Drop extra newline output in show_trace as its output format does not
depend on CONFIG_KALLSYMS.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig.debug  |  7 +++++++
 arch/xtensa/kernel/traps.c | 12 ++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index 4a6c495ce9b6..b0c952652c73 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -491,17 +491,15 @@ void show_trace(struct task_struct *task, unsigned long *sp)
 
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
 	int i = 0;
 	unsigned long *stack;
+	char buf[9 * 8 + 1];
 
 	if (!sp)
 		sp = stack_pointer(task);
@@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(sp))
 			break;
-		pr_cont(" %08lx", *sp++);
+		sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
 		if (i % 8 == 7)
-			pr_cont("\n");
+			pr_info("%s\n", buf);
 	}
+	if (i % 8)
+		pr_info("%s\n", buf);
 	show_trace(task, stack);
 }
 
-- 
2.20.1

