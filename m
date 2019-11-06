Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD99C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C7217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iReoUOAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfKFDHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35191 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387956AbfKFDHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id q22so8509416pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkTObIsF61Z45Fw03drbWYyon2r40d8DXxhztGRtNkQ=;
        b=iReoUOAfBSC2lgcmJ99cOUC/KPegZvtwylc18oc4U5ole2l6I079nnCxDbzwKQiDlb
         I25rB42ARn0898alSF75+Zq9Gy8JIPLgVJfb08lQw1dZplx+sMUCSQEs6MvQfaFCssFc
         NejOZ3U7N5LvtC9gAIqW+LA4LYkei1D/E0+8dn2Ryz4IuHMSgilonPtueqSXn6LwuIFe
         iwIMe82LFLFL0uLPcNg2POGoyJg+FLZRUv3Ayen6ciKnIwERzQ3uSjX+LhTKP17iz+4s
         p0SRN1X7twG9WgVFI4IdYs4A5rOz1sZ7sViv7E3/fPBHwBGYD0pXm0vPMgGWZehpjb0r
         l7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkTObIsF61Z45Fw03drbWYyon2r40d8DXxhztGRtNkQ=;
        b=DtY2hPXqAAIxmIY6TYbK++S6iksToRQEvFDDY477PGSBW20JkT4Cr8FYkJ4REBRe9/
         ZNVryRThs+IzG+q3jCtUvEYYC8NNCvnOuOzpLCLR63aDML+JPu+vSTbY+jLNDZfFdMoY
         y3Q/Hjh5MYHHtpBv4IsR6VBIdlY3gVTj1DYlIep2JtXJ7FH8CCBve6fnZI9LXAQa5OsC
         kJmNtuVoqLCvsBaR0Od+tPilocNXiriZWIy+GosR7gEmssOp5GKz5QWGmrbGQjEFl5TC
         +/MT0LxlFvffYWLDe8vytx4r4X6J9aKEVfoyn0AHICfoWURhu7qFaQQdxKDdL1IQRD/p
         jq+w==
X-Gm-Message-State: APjAAAVbBtfbruZbcAmLyNHX9581skbTgVK2PVTo916zdHvUGd05X+VM
        Ds/i0nsPRpkZE25QG8bMMcigC0Sb0iQ=
X-Google-Smtp-Source: APXvYqy0KbKuP6VArvuqXZXCebMSGwIVmT/hisdmPtRqIvTKjarofAjqgV7zTiu4mCb/OV/NRGXpFw==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr473262pfn.24.1573009661131;
        Tue, 05 Nov 2019 19:07:41 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:40 -0800 (PST)
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
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH 24/50] openrisc: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:15 +0000
Message-Id: <20191106030542.868541-25-dima@arista.com>
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/openrisc/kernel/traps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 932a8ec2b520..9d5a85dd1992 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -41,18 +41,26 @@ unsigned long __user *lwa_addr;
 
 void print_trace(void *data, unsigned long addr, int reliable)
 {
-	pr_emerg("[<%p>] %s%pS\n", (void *) addr, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
 	       (void *) addr);
 }
 
 /* displays a short stack trace */
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		const char *loglvl)
 {
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	pr_emerg("Call trace:\n");
-	unwind_stack(NULL, esp, print_trace);
+	printk("%sCall trace:\n", loglvl);
+	unwind_stack((void *)loglvl, esp, print_trace);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_EMERG);
 }
 
 void show_trace_task(struct task_struct *tsk)
-- 
2.23.0

