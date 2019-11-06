Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C795CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A36420659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="im6yHZSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfKFDIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34411 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbfKFDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so16139005pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMKveiS/I1oLFxNnJX6mb+TblVnDugqUDwwz1x5+ZRA=;
        b=im6yHZSJfo8L4m6qZbycgfw64Ks83E20oaNNxVimul3i6vilUfo1e2dhz07i9kWvOc
         z//W2vDKR0RC/fr3FbUWs0eMp7MtEiRO+vk8MK2bXDgGhMtbypRrbO8coLkkT00jTUDi
         3BZFWAzKk3SLpKuQOxpdanD6YH1h5o/fDT2dVZDfYoFIlgeWgo6g0VNyqlCptFrI1Jkx
         jWVl88FXbwBjnn4JFYDyTWpqXuXmGfeEwCsnxDT4B7KFhfFanqRp5XQEReNlhQkFTdF/
         piInrvmXr4Zy/6TAJbz60FNvDJ3PudP33RDmqWQjwX9VZ3p3L6QlzjKWlDSBYNQnKYpX
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMKveiS/I1oLFxNnJX6mb+TblVnDugqUDwwz1x5+ZRA=;
        b=KafqDO7jfZ4lSwP6IgOTlzfk9RP6D1y5tJU+WOEgl7h4WQ3fCouGUvsi59O3SISmcr
         LWkLoqXs6mOcMAR3xcTZqtbTWkGA7fhMN2g0qALGGKD+nUwweZOE8QoKbC4iA9SQEGL9
         Naho8VGne+q3PinMmHNQWUYgfdSpbzYvXJ7HMTDc6CqgGJrU94/1LVYVniTkDEkKYSjY
         Y9dpCPy9I4pSPECBIX3VkU8n/VBhkZM7/iESYszD05jt0UgEp8ijUpodrF7Wd45nOJb6
         lCnzN8cvIkR6qIun7ucucdVMSmNEgNuQzkSCsOhOimRJOhg2BiC5HiZcZ59DALuQlV9j
         kdLg==
X-Gm-Message-State: APjAAAXAorukYpn1zSfVZrwvBc8BPFp2GOfqlYCH2sjSwzzhNpzTp9bQ
        1ILkxOi9q6Vj2s474TnNka/MLBtFZvA=
X-Google-Smtp-Source: APXvYqyzL1xFgjtnsMosPZg882/6T97py585P6B0va/9kNqdi5yImDFpVjBQSTWAc3e8s748nF551A==
X-Received: by 2002:a63:4562:: with SMTP id u34mr161284pgk.399.1573009694064;
        Tue, 05 Nov 2019 19:08:14 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:13 -0800 (PST)
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
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCH 33/50] sh: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:24 +0000
Message-Id: <20191106030542.868541-34-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index d488a47a1f0f..cc51e9d74667 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -144,7 +144,8 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 	debug_show_held_locks(tsk);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long stack;
 
@@ -156,7 +157,12 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		sp = (unsigned long *)tsk->thread.sp;
 
 	stack = (unsigned long)sp;
-	dump_mem("Stack: ", KERN_DEFAULT, stack, THREAD_SIZE +
+	dump_mem("Stack: ", loglvl, stack, THREAD_SIZE +
 		 (unsigned long)task_stack_page(tsk));
-	show_trace(tsk, sp, NULL, KERN_DEFAULT);
+	show_trace(tsk, sp, NULL, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
-- 
2.23.0

