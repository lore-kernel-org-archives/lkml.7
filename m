Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA2AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5D722459
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WKQAqp4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfKFDH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:07:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36836 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfKFDH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id v19so17727483pfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8wfp8CVonkd1KDc92yB+5e/4fhrbHakXVINZbBJDY0=;
        b=WKQAqp4DTIRRnKqV0wgqpT2ml6cJyMnG3v5CJEgQYW6ycKM/61NuL/+SXDCE+/d7ap
         fi7zff/Kesun9PZ7AGzN8FcbtSPClsKciNt71h7izoadIIDcRUzjYLjcvXnY363MRYSd
         Yh9J3Sn2gr4g2VTJ4ma9fmWuS7cCE0PuksCir6bBLfHFsAzo2pp9drH0Tzl2Zpm23TMo
         ZF1lPbtScWSc/2zJh4hkNDiTu9gzJ6AltROMR0V13z+XO5uPRT92zcxI2frnSuLOhWbA
         UWCFlkK+UCq5vA7iFSH6cU+d5iaMwCNACvUr2xor/X2//FXkvJyKFg8G/+SsEZrnpU1u
         ly3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8wfp8CVonkd1KDc92yB+5e/4fhrbHakXVINZbBJDY0=;
        b=YgMpMKlJKAXvDY8PzpUWxeR+d4oKTscd8kif/JW1v+4CcQ3dk/5Il1+y1Gh/vDRMJ6
         6bC1Fr/9ijgCa/UyesLN2tqe1Fc4mN4P57WXL0BIo3ETPzTnSP9EsH7wRIfaopOsGGpf
         Pz7aXi//FGYEX+RscYHFVV3iDUU1s+b9O/e5KqvjfdJPUo+jaRSYEg7G0Qp6IQcORti4
         +vshm0GSFH9XtcalJ/puopVpmphBQPbxgq3KfCbklj/K6eygT/NTu099Gb2Jafbixbcj
         Wyc+pG8uSMjroSQUpJKh0VYVxIRX37prigelj0eufFn7S4JgCChLS+YCeg24Cf/byOOP
         hE3A==
X-Gm-Message-State: APjAAAUpVDL3v/MPs6hsMQDQp0Frt6vU6TL9NcT4WDZvbRXLYvnO4LrF
        aef7whRg2aLt9nm628NQ8kSJTbMbiGc=
X-Google-Smtp-Source: APXvYqzFHyEb4E+8kYCkYlZFA/5c1zVRFVS5U2mAAqAz1H6gH9Zl4WUZ4feHOJK6HJ24n5tsCa8f9Q==
X-Received: by 2002:a63:480c:: with SMTP id v12mr163101pga.385.1573009646284;
        Tue, 05 Nov 2019 19:07:26 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:25 -0800 (PST)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 20/50] microblaze: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:11 +0000
Message-Id: <20191106030542.868541-21-dima@arista.com>
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

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/kernel/traps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index be726ee120fb..149ae534937e 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -31,7 +31,8 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long words_to_show;
 	u32 fp = (u32) sp;
@@ -50,7 +51,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (kstack_depth_to_print && (words_to_show > kstack_depth_to_print))
 		words_to_show = kstack_depth_to_print;
 
-	pr_info("Kernel Stack:\n");
+	printk("%sKernel Stack:\n", loglvl);
 
 	/*
 	 * Make the first line an 'odd' size if necessary to get
@@ -65,14 +66,19 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 			words_to_show -= line1_words;
 		}
 	}
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
+	print_hex_dump(loglvl, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
 		       words_to_show << 2, 0);
-	pr_info("\n\nCall Trace:\n");
-	microblaze_unwind(task, NULL, KERN_INFO);
-	pr_info("\n");
+	printk("%s\n\nCall Trace:\n", loglvl);
+	microblaze_unwind(task, NULL, loglvl);
+	printk("%s\n", loglvl);
 
 	if (!task)
 		task = current;
 
 	debug_show_held_locks(task);
 }
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_INFO);
+}
-- 
2.23.0

