Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61556C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183120659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Jc8Zhbez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfKFDGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:06:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42392 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfKFDGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:06:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9471265pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mH9KBFdGIy02JZxT1QReQ3QmWD9fRQIiXWuOgQOgh+g=;
        b=Jc8ZhbezELpHMdltV8DPzafP6vQPlh9x0UnT0wZTbJ93Lv27yVRmw0i5uB6Sfry2Xw
         zHs4cDo0LnqrZ2Q/3dPFMmVATW/oOv7iF2B1g7gRWbYsCrIr74NZXnPkckBTS0lE3KFD
         mjQsEokBqEgD5N5oh2i94TH/aMRrY0RDS14DsUmfwuxPHzCaFdrMWU5wFlEbarOaf/zr
         M6lFGSdNkQ+ax9MBJKMJBsO8DLzLX0cEeO8Zf3A6/s2QQSf4NlewIwZwcrDfJOVYW2Qs
         A78WUTGbd4UxOgdaUV+DZRRFd8by+KR11frl8Mohd7YR6t16xtINiBkTBULikYl1wjab
         j3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mH9KBFdGIy02JZxT1QReQ3QmWD9fRQIiXWuOgQOgh+g=;
        b=njmMoD8JngC2NvNIrzREzDMbZqx+q2ufTvnePVRNm+tKpeeqHwBbPq+DUVAvFslscN
         DR/yesfyQnIUpBPc91oQg06ULabox9TC4eVUdbji3a4Gma5eJegkc0PL8u8YjmA4mvnT
         PuXdrRsVFHKWjdZNJhRF7EKJNYd0wlhqQtLoMvdwX1il6SmTNJbgcsqF0GhdORjJxscq
         xOkzJG84bGznnsrM9W/eAlWjnYOWrV2d/p2mT+1XZHF7FKRnVqvrz9Gpm8glIOKBQUg/
         DR9pBGB/iJf4RNcxRPO6nWi+ORp5lZqdTCiJnDt2IKcIKCsDX5DT4IxXuZRLZVp/NxJP
         1FMA==
X-Gm-Message-State: APjAAAVdq1+6nwBRcOyZSdRVwzcHWMsffpDDtLfpoSzpEyIzrhUksprg
        D0bUtb5zOJyDBxeXcVsIQId1Cvt1VHo=
X-Google-Smtp-Source: APXvYqxDneNdofpipCrXEwSDGjej3gjw6AcUjr3U7+ngBaLcpr/45Qz5Ohf6pjxPgm1QHxP2sjlCJg==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr664978pjw.2.1573009609310;
        Tue, 05 Nov 2019 19:06:49 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:06:48 -0800 (PST)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/50] arm64: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:01 +0000
Message-Id: <20191106030542.868541-11-dima@arista.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 59072c7b9fb4..5b3ae8ed33fd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -136,12 +136,18 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	put_task_stack(tsk);
 }
 
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

