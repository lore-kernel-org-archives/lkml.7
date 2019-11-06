Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7CDC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3820659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RN13XpUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbfKFDGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32942 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id u23so16138066pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXN4VoYXZLjoYLR8zStHwRbThHFXnU8fItsQR3wjSkM=;
        b=RN13XpUnxis0vk5gPGJp6+dY9DlNm0ZQrqCwj1T26hAGxXObJCbCXQVc9I2VKGte9X
         NfzEbyIStYyWaqh8Clu6LMnK+2y8wkiRkhD7iQ/ScpwJuP3DRyV7agtrG4XWiCX0STCz
         h5HFQ4X1K1/WT/0hzY7aKGYOAgleW6SpJhfFzHzmRp4MQfd8i7RHgDjcKptPWjcfX/UW
         vYDoJZFEvKMlpmxwDv5aLm4p4hFyyurvZ5oTdgk+jXHhWT03qO/DSJdp6mUyEQP3Yhty
         z/V+PgX/Zq8d7oQFmnTN1R97lsSiUldejfqyOINyzRY9L38E8DEAQpimASQEh+h6fglI
         5C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXN4VoYXZLjoYLR8zStHwRbThHFXnU8fItsQR3wjSkM=;
        b=ivUOQg8t24+uFslVgg0Ep0fpTpwt5CJiR6S7lLLJGg/NtOBCVR8ZEWbLYEN0xgNbXZ
         /+wthm48tNcZ05pgJZuBW21KZKvImutyXAB9Y1M5Vb0sZ0+Jh9mY0qP10jjqXlG/iAQQ
         HZJAFLpJF5O8NoebPErd7cmNcPMzIGl5/lVw4VxZ1xykhgSPviyeo0o/amsCqMflLic0
         8GRPmWivR3TlmfqjFoebCDrF749pTkihht2lhMdr8LPI+E8JVUZp2sd6AI9Tv9oBCckE
         4JUXh6kPuiWiMTzdgieY0BUDFQxRtWoBAMv0V16XFMNC9vEsinDiA2p2hVWUHwvSvS4E
         mRdg==
X-Gm-Message-State: APjAAAU6+AubOtJPMSK57U61IGNkD6N9RAb0bWgcZxXMbE0ncRmQsM2K
        0FIryOS80fggzsarghoU+722wqFG+qM=
X-Google-Smtp-Source: APXvYqzXQgzKriGqFThfTpYY4opwddI1pJhg56tQrXSwvvuR38gNJcnYpJcf43MM7J1IVkzKA44VnA==
X-Received: by 2002:a63:5951:: with SMTP id j17mr204680pgm.294.1573009600708;
        Tue, 05 Nov 2019 19:06:40 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:39 -0800 (PST)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH 08/50] arm: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:04:59 +0000
Message-Id: <20191106030542.868541-9-dima@arista.com>
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

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 16022b75a72f..f999a0e4bab8 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -246,12 +246,18 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 }
 #endif
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
-	dump_backtrace(NULL, tsk, KERN_DEFAULT);
+	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
+}
+
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
 #else
-- 
2.23.0

