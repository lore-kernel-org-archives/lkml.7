Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF8C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DF4217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hwEVVRAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfKFDJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43820 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfKFDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:09:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so16115387pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQVs5wwFF+ZXBQRWhQmdDS/dpWCW86lqTZTcB1oCVCs=;
        b=hwEVVRAjUSZdGmd+zIYiiAm0BS6vQRqT7Np8QLCJa9rwgas6NUYjnhfkxHtysM2NyL
         3gqqp68+OE4P2hnz0GpO+I46aH+QG3hAxxxcnelkgX2r/YMrlvKrsawetAKp9JCiRRqE
         OAGyhs55+Hnz0vlSMDamrklsOrmY5Pcm97Z91Y30EhluCasiFBZpNilghWULDcjczBqO
         mygnTgXwjiCXE0sqnj6Jz/SU6uHZH3yEKabR4lbld4B0wynD8fnk4lR02tSLVmIhdYu8
         XJ/GpU/rAbDRkgoh8bFh0hg7qQaCVAbssY8fkgRhfF7uJO84arARAzE72rim2JzgLg06
         wXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQVs5wwFF+ZXBQRWhQmdDS/dpWCW86lqTZTcB1oCVCs=;
        b=kzhJlMbSKj1ARRB18aWV5/Bg4kIHa6q9mfX9qoNENeVPYgzLQ7hzxlFcz5pOObcZs5
         flvkUI0NuqsVTammf9SVlhF0yNF9JYpcFSSc/MOrrzw0Swy5QJF9a+w4bDL0bEl42sao
         vO2cW/bSa5H8jmQcX68x487cMb+bvuSFQ2GLK6uNH0QLNBDYVr20mLZOqk/i0yT1Hqft
         MBwjx0gWFpKq8MVXzQGZYfXe9Y0LoQAYA3iFBdjb9aIUoMgsCX+dEWZePIpfTZha9iKH
         ry6FuS5sc4gw2Vqc9o2BlbakwLZsk3jMHetGvZPN10ot+WUDP7tb5qAc6kwvRmaphkeK
         m6CA==
X-Gm-Message-State: APjAAAX3kujK/N3VaExQThNlIiAV0IshIz1l2daploZQJjFWsmp0D5Zj
        SK9qDpMX+d4XTAIpgmGA+X6XKcnInGA=
X-Google-Smtp-Source: APXvYqzO/MiX6rzUz7ULsfgX2r4ZuEI8e6SlpcEQ3E12/qqbszPZo0vGvcYI2lG10DGwQ7pYN8yQaA==
X-Received: by 2002:a63:c405:: with SMTP id h5mr240542pgd.60.1573009745814;
        Tue, 05 Nov 2019 19:09:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:09:05 -0800 (PST)
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH 47/50] kdb: Don't play with console_loglevel
Date:   Wed,  6 Nov 2019 03:05:38 +0000
Message-Id: <20191106030542.868541-48-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the stack trace with KERN_EMERG - it should be always visible.

Playing with console_loglevel is a bad idea as there may be more
messages printed than wanted. Also the stack trace might be not printed
at all if printk() was deferred and console_loglevel was raised back
before the trace got flushed.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/debug/kdb/kdb_bt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379aa0a1e..5ce1fe082a38 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -21,22 +21,19 @@
 
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
-	int old_lvl = console_loglevel;
-	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 	kdb_trap_printk++;
 	kdb_set_current_task(p);
 	if (addr) {
-		show_stack((struct task_struct *)p, addr);
+		show_stack_loglvl(p, addr, KERN_EMERG);
 	} else if (kdb_current_regs) {
 #ifdef CONFIG_X86
-		show_stack(p, &kdb_current_regs->sp);
+		show_stack_loglvl(p, &kdb_current_regs->sp, KERN_EMERG);
 #else
-		show_stack(p, NULL);
+		show_stack_loglvl(p, NULL, KERN_EMERG);
 #endif
 	} else {
-		show_stack(p, NULL);
+		show_stack_loglvl(p, NULL, KERN_EMERG);
 	}
-	console_loglevel = old_lvl;
 	kdb_trap_printk--;
 }
 
-- 
2.23.0

