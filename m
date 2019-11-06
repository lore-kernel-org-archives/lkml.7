Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B6C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E488E217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y4k61BKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfKFDIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33778 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbfKFDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so17751369pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oafRhfLZXVvkNwF2H2KONz+tM53VMEIpGfIk11cYT7o=;
        b=Y4k61BKpVSdUq1hUuFtW/xmyewN1YgbHYyyMU7vuemwnvexsjloHlcznh907I40GBy
         WGMHcJhiX9k4GkPZQ863Gpx0tA8vqTBD1viY0NbVVluIiLm+uTVPh/BhVpGKEkw3Ag5e
         5OfScGkXC1ewP1+9tTPt6rsAfvEdnXTC9uTndO59fcth2N7JL64EGQtCwcSVnW/+k35k
         NwNcYxFUsojkbWR7FGhI+itVIIjuWKwFzbjSSLfremPEwrpF9YbU5gXfaO8YvorheY0e
         n09Y35AY4OKonEkfH7uqXhbgQZLQWrwVJNwIg86afm/jwA3kh9QZawwmLX4qUMh3jF04
         ZPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oafRhfLZXVvkNwF2H2KONz+tM53VMEIpGfIk11cYT7o=;
        b=fjlS/hr3T5ual2cb1qADyxjb54pY/8jDNB/rG8MsHMWVo810Nbr97kC2Q+RNtmZZqP
         phFGsZNqGOufgxMU5xT8zVngmWIJHK22s8tG73x5C/VgHlUlh8g7qm2Zd62f9/Uwtq+/
         xvy8c8emsxucFcv5mf4Vn0sssKDMY+vP+vKUFyRHrd6sBYQzzzKvjcNfwu1rvvvgGuST
         a/qULOY4OdKU9T8OycJC6IGswjH+NDeVHKkAxcw+37sMPvvJRJvg+lNr+Zx0NsV6rdVU
         vGKwqkXfqpbDdPgHmR79ZJWTbJ8YW9QbmlER5oQ79QVR/eKeHhgdkdBrhDcttYMXIaJ9
         zdZw==
X-Gm-Message-State: APjAAAUBOvLOyShm4emPENsjeM5h7vtD/9+S5Ntw5yUyFuNG50hraLwU
        I4r2DkUMU7/CW49EGqBGsAdiXbfE9/M=
X-Google-Smtp-Source: APXvYqx0N6Ls9JxkM2/lsi+60+JBohGbdJbpJdnkQjTuFpcT+CUTDvWHod1g4DClHj4T3W+dDinUJg==
X-Received: by 2002:a17:90a:bd10:: with SMTP id y16mr557120pjr.111.1573009723166;
        Tue, 05 Nov 2019 19:08:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:42 -0800 (PST)
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 41/50] x86: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:32 +0000
Message-Id: <20191106030542.868541-42-dima@arista.com>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/dumpstack.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 147a06ee4a48..940cd4c27b17 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -279,7 +279,8 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	task = task ? : current;
 
@@ -290,7 +291,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (!sp && task == current)
 		sp = get_stack_pointer(current, NULL);
 
-	show_trace_log_lvl(task, NULL, sp, KERN_DEFAULT);
+	show_trace_log_lvl(task, NULL, sp, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 void show_stack_regs(struct pt_regs *regs)
-- 
2.23.0

