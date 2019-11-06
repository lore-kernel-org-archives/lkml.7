Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA4C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A1D222CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lZUd+XeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbfKFDIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47086 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfKFDIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so5489717plt.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/FjuDAVkneSIjXNySmoeQ30sSkwXAW/X+I2KPagVxs=;
        b=lZUd+XeV+6JlA/p7WuA8YgGZ6G+cSfc+aU1Vhkf1btBpOtEBVP30HHGiXZboWhhpkR
         DmIsjS3MpYSJ2O47TecrvGkX0QrbSqkHD5wPEl7a+GkfeZ/kSsox7QSXTMqz4D54vvpl
         X3rXOQx0sz0Ja3xuIsfeJWpx8NJHSkSLKvcx2I5zirnhVZi/VQxh4v3j5OsFm5n0eD5l
         mjN7RT5vkVrn9IrbU0pg6dapX6Zcd57I1QCypFqaxg1KRNrWBemoyWjdjzNST6U0hZDH
         rQci0XQwnu39Suqwm34YTZXxQqGptjK9cZ+GSdp26GLt2ehUU1XksgwZzi5zdeUvZQZM
         wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/FjuDAVkneSIjXNySmoeQ30sSkwXAW/X+I2KPagVxs=;
        b=G3wtBB0F6X7G0WPgAePGIBXPov0STC+O4+9xGVYmHQBoJy/Cz92dnh3Nq545VJhkFo
         vZbkXUGhHugnHFOUwfQB2cMajftELB0Z1bpBdkJ0axICOj8fCK/veZhLJibca14PwWXr
         plB+SgrjFWsRNTcHm/Lap0ODBJmlwX7cCuAU+18MO6UCVoY9NB3zE8LqG0J+cYQzdlUZ
         sar37yi/aj/alfjR8ykOPYJG6h2HC+wA+p1zXhmecVkcgaR2OrUv03+rWG+LyqgTP60S
         CwjciqkkOTrMqY/ehuHkn0GFUhyCxR/Mp40nz3TwmUXPLWhimGk0++m+trfUhVfzB9YA
         iqig==
X-Gm-Message-State: APjAAAX9GbxfXDctB83Hkl8BrxMBXIhjiP48N0DCul5wFEEgNrTj3Jf5
        paHgiumL1SdzZEBAlyezHl1Gt2X6HdA=
X-Google-Smtp-Source: APXvYqxL8zZAN4mEkInLc5fYB8uuO1lkZp8edmG/h4I+MQlWU8B9jGat3umuCJn57DhOZIdcMfzGIQ==
X-Received: by 2002:a17:902:8494:: with SMTP id c20mr155757plo.137.1573009697604;
        Tue, 05 Nov 2019 19:08:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:16 -0800 (PST)
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
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 34/50] sparc: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:25 +0000
Message-Id: <20191106030542.868541-35-dima@arista.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/kernel/process_32.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 26cca65e9246..d2f3aea7b977 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -145,10 +145,12 @@ void show_regs(struct pt_regs *r)
 }
 
 /*
- * The show_stack is an external API which we do not use ourselves.
+ * The show_stack(), show_stack_loglvl() are external APIs which
+ * we do not use ourselves.
  * The oops is printed in die_if_kernel.
  */
-void show_stack(struct task_struct *tsk, unsigned long *_ksp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long pc, fp;
 	unsigned long task_base;
@@ -170,11 +172,16 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 			break;
 		rw = (struct reg_window32 *) fp;
 		pc = rw->ins[7];
-		printk("[%08lx : ", pc);
-		printk("%pS ] ", (void *) pc);
+		printk("%s[%08lx : ", loglvl, pc);
+		printk("%s%pS ] ", loglvl, (void *) pc);
 		fp = rw->ins[6];
 	} while (++count < 16);
-	printk("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 /*
-- 
2.23.0

