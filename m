Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21022C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D0C20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1HhJyuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAFPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:44:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39489 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:44:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so7931415pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0l5A9UoqjVI1sY5PPJyL17z33+kBWrkankas44MyTI=;
        b=t1HhJyuhMF6b2u0cHsve67RMCFv+L2YN1phOPEJ39G+0kiSGSPX12N3z9hbQUyHnP2
         qavWAIKWz4aJZrmtIDX6lDLsjNScEXEKoxUAayeV2RpdtN3n8D8fXKUE6B1CSyGPc6Uu
         qhVHYgAHNZHogm30G35nMn38lRSJES6cnUzsH22Fvcc2CpTZ4FJmyBJ/BLw6Qi0tzCTV
         I8ed4V4pNvcDUWu7TsAFHsw59BhMgxFITZp9u99jJPwndvwK0czkDXnYZOX3O0BMiKmw
         eAjeVpm0z3sgjST5Lo3bOuTGYjKJpH6/6Le0qkg97XQ9qLHShGOqSWijJaEli0YvCUyY
         U8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0l5A9UoqjVI1sY5PPJyL17z33+kBWrkankas44MyTI=;
        b=YjG6JD9NsZlTqYkHGN0Xgm2EZUskQHCfK35LL8QNq65q3j1hmMRE5HTPtlnIFEYgwW
         57jpBAsXmgKLI2vbzEaf1K5gdT27ISleS4bGWHDEPhVKzcFxfjqeUOorGwnuAPd/DGwe
         d8/1ucHDWTsn7jArRQfkP6+3bZ4iFk5/hp3+XiViMKu1/VjnSbjBUk2xHnasTQIuYTU2
         o68NAk1DTtJk2Af1naGbpGdiAxQtJydNdtnpmHi7zEEUVvNUKP620KqhiE36GsD3f+TG
         3P90SDhSU9taUxryRhX3COcKvY+wgn0ZpUOKAP5tqULZLygwdNR5JPsXmHvelh/1+rvC
         kSew==
X-Gm-Message-State: APjAAAUBasAWjTjrQ/IOmVB+pEWkP5xLRIomTEJsn6mgbLxtQQxxnFxu
        5vgQjUuURglQwnJxnZxE+A0WM5Cm
X-Google-Smtp-Source: APXvYqw/g9CEBUx5KdX3yMeBwP5RWe4LJN6oMi0ehtmKDq9tO/+zMagHk4t0MyaX/sCGHlFKbdINVg==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr44544482pjv.70.1578325490212;
        Mon, 06 Jan 2020 07:44:50 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:1523:ae70:55ad:68cb])
        by smtp.gmail.com with ESMTPSA id b185sm61935315pfa.102.2020.01.06.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:44:49 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, smuchun@gmail.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [RESEND v2] irq: Refactor irq_wait_for_interrupt info to simplify the code
Date:   Mon,  6 Jan 2020 07:44:30 -0800
Message-Id: <20200106154430.3413-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

Cleanup extra if(test_and_clear_bit), and put the other one in front.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/irq/manage.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..7266d0d30fa9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -863,21 +863,15 @@ static int irq_wait_for_interrupt(struct irqaction *action)
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
-			/* may need to run one last time */
-			if (test_and_clear_bit(IRQTF_RUNTHREAD,
-					       &action->thread_flags)) {
-				__set_current_state(TASK_RUNNING);
-				return 0;
-			}
+		if (test_and_clear_bit(IRQTF_RUNTHREAD,
+					&action->thread_flags)) {
 			__set_current_state(TASK_RUNNING);
-			return -1;
+			return 0;
 		}
 
-		if (test_and_clear_bit(IRQTF_RUNTHREAD,
-				       &action->thread_flags)) {
+		if (kthread_should_stop()) {
 			__set_current_state(TASK_RUNNING);
-			return 0;
+			return -1;
 		}
 		schedule();
 	}
-- 
2.20.1

