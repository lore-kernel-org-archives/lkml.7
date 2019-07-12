Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81989C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E31020651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvull8Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGLWmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:42:36 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43716 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLWmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:42:35 -0400
Received: by mail-qt1-f201.google.com with SMTP id e14so8390151qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GPlldc1uUCaMqKOlqd707RfJFmN0vdU2ggLjnOu2mQQ=;
        b=Uvull8JsmAlDemDoFeLo0l6LKR9FI9L6JGngRgKyRPvHsDs77REgPEHGJVhR7epI3+
         vm1KXehBkmrPa2LG3Yd5SlHjnZ4bY1nXgoj1C07P8j2MJtPOKX+gfQnqO9tqwyN7n71/
         vHrqzKjVZRVy9zhIGHYo1Hjo/l5xY1ws6FKUAJoZ8x3hxkwAINDVgUf/oYF8d86EDMwv
         d71nKBNpdZRP5EDJ3CBPRaO5n4ygyG+0a3KX5hPap0QuZqFIfjA0EXIbQ7KCiC/Lh2R8
         bpS4K29r+e4qow1a9R14IOzU+YZet83p4gP3NyVVL0Y1kWAzHWgZ0pVlg3DC+OKSS/Vb
         z/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GPlldc1uUCaMqKOlqd707RfJFmN0vdU2ggLjnOu2mQQ=;
        b=bIzzFkArVzBwLmuLRdBw9452wAA3HaXIdDqqgq33HcTk+yCmvP2iYtDetJZ5D3wmsK
         lF1K0xauEJDZSb41WyDvYAnnhjOU6tcO1J2XCoDqFP3Uw9hYg/Qui9jFq0l0inLHWf6B
         Rea312KkdvKQ7PsrH89+oHv7mNiwsFrS5eid1jp1qGpN29R1sC7/kN/buZTED0fgZ7LM
         0oMuZIBQ5FgnSPvzQ1JX7VKYPDlkDGKENKgjtw4z/y2Uy8FqkWn5KC3Tqf6ZpjizaF6K
         ih1Pes6Ql0mdvlFhmocoLBm6QIbdfdZifqaqXHp6t6lGMjDFCzMqTtc1FHj1QmKS2A35
         YRUw==
X-Gm-Message-State: APjAAAWEz1bh0TBloklu3WvQiv1p1fAQqMSalrhbJockr/KoaHieQmH7
        NSjLBSgXzlYlQGiEzSLT4qXYQbVoAw==
X-Google-Smtp-Source: APXvYqx29k+eyzx3OqMKqjQWf0f4JOSEoTZz20Pa8EdvWRvAEPlpyUcqBPDVKy3YURgXPlZlKgTsuLPZmg==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr8313268qkg.51.1562971354608;
 Fri, 12 Jul 2019 15:42:34 -0700 (PDT)
Date:   Sat, 13 Jul 2019 00:41:52 +0200
Message-Id: <20190712224152.13129-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] x86/process: Delete useless check for dead process with LDT
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jannh@google.com
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At release_thread(), ->mm is NULL; and it is fine for the former mm to
still have an LDT. Delete this check in process_64.c, similar to
commit 2684927c6b93 ("[PATCH] x86: Deprecate useless bug"), which did the
same in process_32.c.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/process_64.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 250e4c4ac6d9..af64519b2695 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -143,17 +143,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 
 void release_thread(struct task_struct *dead_task)
 {
-	if (dead_task->mm) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		if (dead_task->mm->context.ldt) {
-			pr_warn("WARNING: dead process %s still has LDT? <%p/%d>\n",
-				dead_task->comm,
-				dead_task->mm->context.ldt->entries,
-				dead_task->mm->context.ldt->nr_entries);
-			BUG();
-		}
-#endif
-	}
+	WARN_ON(dead_task->mm);
 }
 
 enum which_selector {
-- 
2.22.0.510.g264f2c817a-goog

