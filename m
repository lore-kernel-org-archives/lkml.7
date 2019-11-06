Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14444C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D48217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YS81HEYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfKFDJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfKFDJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:09:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so17722225pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dB7fFw32rtoRG2JD28kol5jcf3rR2T1j0ow9Tcr0Ndo=;
        b=YS81HEYNXq+/54UHLJ3cwesb4UYyI4Z0SgZ3bISdz06YMV1TRRTSQQRmbp1u276VyT
         oDqJOGIRTnlqhRCKHx2vgq2yT0ZjhpletQzgLJ6nlhkmFTRNEpxyGDiN3o1fS3u0aGqS
         BDpg2SYzZGOtQc1IDTYpD90OFAvqor24PwYTIV7fN3hPbqlnhJKhXQSAN0bEhTEzTAjP
         jMWCcUfl7vkvuiJQCFzCQbQ5NFssmIeSt+va5LBjbZeWHzSIfyItu8POCO/S6TtFKMVD
         mG6d1WjRTEphxRI86yGAnbZ8/FB3qReOBDJ7GSdmLxHbG3/NhKV6Nnury5sKSnL9HkDl
         t81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dB7fFw32rtoRG2JD28kol5jcf3rR2T1j0ow9Tcr0Ndo=;
        b=Pk5HE/VNn8KDEMghgyx2w0xVzgqIO7LvQkMQ6HPNS2ZK+4A/1Dg4hvnnxKdowS5GmQ
         evSNEpsTElHSGtwActbG5j5TmLyI+O74UcUeTjiPqBAm/pNcbEyea8HqODKfJGFtYHfa
         pfs7Zl6BnMU4byygGHvmKI2xcrUGZwXYYaUQBxH2NS6UacVMaAZOv1M9WYpWeJTXBTsp
         bFFEMKzgsmSbxKWv/Hxhwl2Y6TEgLXOtTZcQIUOvcch98oZAOpAgOsI4Vuer9OMjJIcz
         u37f6pWaE88a15vb8iBs0odhEk00EmHSMFfP6nQ5ScGulMPYIaU4PUBpF/q/sCx4nakt
         91Fg==
X-Gm-Message-State: APjAAAUNG0wTk3d539xJENueLxfqgwm+I4FF0UGL5mWSUSx19yUOKHF4
        okoeemAZL6GY6GL2mseqnn5W151PrVU=
X-Google-Smtp-Source: APXvYqzj5jp+Mwfalxwrqp2vavSt0MHXskm5wqlU05HKC/SIXB1uovgVJKU9J9MkMKmfIrqr/PDL8A==
X-Received: by 2002:a63:af13:: with SMTP id w19mr177011pge.189.1573009753631;
        Tue, 05 Nov 2019 19:09:13 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:09:12 -0800 (PST)
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 49/50] kernel: Use show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:40 +0000
Message-Id: <20191106030542.868541-50-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the last users of show_stack() by KERN_DEFAULT as the surrounding
headers/messages.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/locking/rtmutex-debug.c | 2 +-
 lib/dump_stack.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index fd4fe1f5b458..5e63d6e8a223 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -125,7 +125,7 @@ void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
 
 	printk("\n%s/%d's [blocked] stackdump:\n\n",
 		task->comm, task_pid_nr(task));
-	show_stack(task, NULL);
+	show_stack_loglvl(task, NULL, KERN_DEFAULT);
 	printk("\n%s/%d's [current] stackdump:\n\n",
 		current->comm, task_pid_nr(current));
 	dump_stack();
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..efb8e651709d 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -74,7 +74,7 @@ void show_regs_print_info(const char *log_lvl)
 static void __dump_stack(void)
 {
 	dump_stack_print_info(KERN_DEFAULT);
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_DEFAULT);
 }
 
 /**
-- 
2.23.0

