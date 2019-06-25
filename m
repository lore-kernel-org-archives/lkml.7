Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983502080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+vhY6j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfFYPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:30:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40386 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfFYPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:30:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so9047901pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FFrIqfPVc5gl2KEfpAFI195WSUdWVmRdZsn8j+n7taA=;
        b=s+vhY6j7H+YWSqe48HW6tZxmlabxJ2syenwjd4RmZJBjpKHXMrBTrZig+dbii3zhhA
         +VGR1Jab8A4uPk88ZtuDWtnMuCH5r5HiDl8eH0yhOENu+DwXbJoiLA1Whwf4wWM+o1UR
         YvS3wqKvxshLiVlN2+2V9qLKrw5ZN8kn29edChmgB30MAP3HQGMSn3wpXbC1RncCxWTl
         WVsqOt/88pwBwr/+icoKD9E3LaSn3y/R5XSwo8+SlJGpTpdO229+GXK7VmRRW3vyLZ3h
         veyOuQudgCLKeUycWD3mWZypA7RlISjm9BoY51XjfRELcjIZm/EzGdPUSS5M0HiC/0n/
         Rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FFrIqfPVc5gl2KEfpAFI195WSUdWVmRdZsn8j+n7taA=;
        b=tr01R7BZGw0bxh5o55IYB2N3evRYndEJpsA8Hayy389uKuYnHQqRsJXUmtALZ9ONV8
         qZnbMEmunXrqrrNxFS9/1KiMR5/gycfOrfgW01A/43G0Rw3qDhNaNVTTjBO1H1bdWOL7
         0UZRjRwunbNJAzGrE0D+vdLxE26oJz+A/P1cap7SfM3k9KP44zHKytINpBJnQmRO91C4
         /sPTLq1ZvHNNl+hAMX44RJ94N7hxx0jclrOjJFkN6wevhRbjSB1fDbWaMc7eM4pR8Ue+
         +ECieuyEREDujxTux7Ri1c5xmvWFicEc65c4F6o7bTYvvv6MIXiHMMOT73n7E35676qC
         kQBg==
X-Gm-Message-State: APjAAAX99OWQDli85X4FdQS9g7k9JJjZfFLZSjCvwTmHqVk5D682DU10
        bziSbTbUYBrqPexaPOPDMhE=
X-Google-Smtp-Source: APXvYqz/E3dr+kRNBgxIj8dEMGWgYKn8tmxU5oMsJvYVKbzi+wn8aJnJN7Ico2gACGEoNGLGqPbFpg==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16mr83984196pls.54.1561476627712;
        Tue, 25 Jun 2019 08:30:27 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id x23sm22502594pfo.112.2019.06.25.08.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 08:30:26 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH v2] x86/ptrace: Fix possible spectre-v1 in ptrace_get_debugreg()
Date:   Tue, 25 Jun 2019 23:30:17 +0800
Message-Id: <1561476617-3759-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index to access the threads ptrace_bps is controlled by userspace
via syscall: sys_ptrace(), hence, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.
The n can be controlled from:
    ptrace -> arch_ptrace -> ptrace_get_debugreg.

Fix this by sanitizing n before using it to index thread->ptrace_bps.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/ptrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a166c96..cbac646 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -643,9 +644,11 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 {
 	struct thread_struct *thread = &tsk->thread;
 	unsigned long val = 0;
+	int index = n;
 
 	if (n < HBP_NUM) {
-		struct perf_event *bp = thread->ptrace_bps[n];
+		index = array_index_nospec(index, HBP_NUM);
+		struct perf_event *bp = thread->ptrace_bps[index];
 
 		if (bp)
 			val = bp->hw.info.address;
-- 
2.7.4

