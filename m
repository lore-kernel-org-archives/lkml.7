Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B701C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A82B217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mvb6Iz5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfKFDIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46923 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbfKFDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so16424185pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fXE9czW8hWaOtj01khUGwi1SAyRucZp67h3RqZ+R3M=;
        b=mvb6Iz5U3YsLez5cPxYyq5dhNroBU84x+gbHAcNOmSxPjJTP/akePTmzDy0SPubeon
         q5puo0iDLJdhWopUyEtB7cKz2EPeoSn5/A+bJVMe8gKQdyLzXyp43gqTItXWa3WZ7dzY
         K9avoMupjfsV3FqdzNQufdrphYS+uuZqooDffyfL5M2HaCnjRr8ntBkvtyXDrGpXi7S6
         vQSeeQXIKUlz9OI1cBHQVuAdI0Bx0JR/GE47jntGqX3vhSrAlboIT+yIB26HVgzbJIEL
         qskY3Zd1aqBT/CcFsFODvnHPlCdcxqjGnH8Tt8M+mBJPQ0/o+fGmRTn4AhqEweV+Jop1
         KV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fXE9czW8hWaOtj01khUGwi1SAyRucZp67h3RqZ+R3M=;
        b=Lp9eqpPipobGDExdiqH5dX4p+BGLEwC0U6KvKjAiP1UaOCCdnPx70Fx8G+P09lfzhr
         UOnODUiYDhgQuVTPVfzmyyk3eAGvcQZVpqje4enFDQGQ6oLptcDGd/WFawpQJhf3A0iH
         YnHmJU0Q5Uuwf9NH+dsrAqR/EZGw8ovluy5oQfPXXBXFXrqSgfJ4v2Slz1nhk4bk+h0U
         eBRGz6R7cbiuB831S+6Fwf8oCSiayDmBCvZz1jkWEuWYKxEeheil2XzKyoW2n5hDODCL
         eEMafo/2cpIZhDuI7K3vjOq0fjpDTLMlz976GuDr0eeP7P81fowBKp7R2ewvrV7EbG2R
         Hh4A==
X-Gm-Message-State: APjAAAVAs1nn5CBJG9/YrKZtsHgey6XKhLI5zLsiuoyvfnZG/Alg1P3s
        zoh+Dfkc6PJeCyiarIFGPlrsfEb2ohE=
X-Google-Smtp-Source: APXvYqxBMkMj52pcKKND54Tj38Fn9IYZBcWPZf25EpL+praWo4AH7Nru3egE6LZe2Xkd2W2EEYurHQ==
X-Received: by 2002:a62:174d:: with SMTP id 74mr408115pfx.145.1573009708474;
        Tue, 05 Nov 2019 19:08:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:27 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 37/50] unicore32: Remove unused pmode argument in c_backtrace()
Date:   Wed,  6 Nov 2019 03:05:28 +0000
Message-Id: <20191106030542.868541-38-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmode parameter isn't used in assembly - remove it.
Second argument will be reused for printk() log level.

Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/setup.h |  2 +-
 arch/unicore32/kernel/traps.c | 14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/setup.h b/arch/unicore32/kernel/setup.h
index e40d3603c7e7..03e70e37f472 100644
--- a/arch/unicore32/kernel/setup.h
+++ b/arch/unicore32/kernel/setup.h
@@ -29,7 +29,7 @@ extern void kernel_thread_helper(void);
 extern void __init early_signal_init(void);
 
 extern asmlinkage void __backtrace(void);
-extern asmlinkage void c_backtrace(unsigned long fp, int pmode);
+extern asmlinkage void c_backtrace(unsigned long fp);
 
 extern void __show_regs(struct pt_regs *);
 
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index e24f67283864..3682a4c5d927 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -137,7 +137,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
-	unsigned int fp, mode;
+	unsigned int fp;
 	int ok = 1;
 
 	printk(KERN_DEFAULT "Backtrace: ");
@@ -145,16 +145,12 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	if (!tsk)
 		tsk = current;
 
-	if (regs) {
+	if (regs)
 		fp = regs->UCreg_fp;
-		mode = processor_mode(regs);
-	} else if (tsk != current) {
+	else if (tsk != current)
 		fp = thread_saved_fp(tsk);
-		mode = 0x10;
-	} else {
+	else
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
-		mode = 0x10;
-	}
 
 	if (!fp) {
 		printk("no frame pointer");
@@ -167,7 +163,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	printk("\n");
 
 	if (ok)
-		c_backtrace(fp, mode);
+		c_backtrace(fp);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
-- 
2.23.0

