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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B154208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti3NlNQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfFYQXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:23:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44789 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so9724186pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PEwqdcBJhdsaGNwQ8qE4axyMsE12bW7MvOTK5Jf6qqU=;
        b=ti3NlNQ62g67PQgPc9j9llrb2zEXYEBG+Q5EGe0fV3A64ndBCBOu3k+b46nE1nbCpG
         x+/FVoVhF5daJhzBCgl+Ix9APbMaph1HrCt3Bf/ZeN62s5qPQy7UHbFB0DllWPnTx8St
         T1RZx8QYUJScxpD9lLoL2bj/nS+VJFo/TNS2HIATAURqVW7qZIQEwEfZ4ieRkSv5BQPO
         gTFuPtKbss9dUwucRDmTxsCnc6sMvO9u2HgBnZzr9quBjJmwTGO6PeixYrOVznfFpCdT
         2FXBHwCtSJmw3Zn4rt9xwb1o9/fvdyD0iGh64DpKs9B5rTI/5hTdoHFX/OuLYx++LSc6
         CIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PEwqdcBJhdsaGNwQ8qE4axyMsE12bW7MvOTK5Jf6qqU=;
        b=Zlg0e5ZuhR3eQY284pFpjAndvA6qbZHCp+hGZeHIkBUIsEkX35Q+jD7OdvC7lZtYSj
         nHM2ZofykHDk3HW8ijAgkR0nQ8YyIoAR/dQ1cLXEFM0/UoyUUqCZBBjcuep/MLOsu8aG
         BVeFP7byc9mFw3Wxx5kPOJIlcAu8LHNEQNDFW9QVGm8xp/LFkX4MJlwu+RKstC7b/mrQ
         /fR1J+5y6l2qe9D51UvUFFg3J+mablgdhi1L7Yozs2IhT1QQAyggZN/TPXQFWARnQUW4
         asWwGHOHi+TLHn1bk623PdAgdEWV46DizgDLMUE2gGsufVpDQXaLUWHMy7HSfUgvJZ8N
         Tv+g==
X-Gm-Message-State: APjAAAU1oKIdPl8tVDM8/PIO1Y4RaiuIX7EpB80YaddtcMQ/vUCVzrZt
        3QHKqjxelXRoFQ7TxmwgJiU=
X-Google-Smtp-Source: APXvYqwFffUXMloGSwcQ0uCKL1gdoNJnYRtkhQmJNUhI61gpurLfOgWdCOFsCrgpRaSBy+4lHau6kA==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr33213904pjq.120.1561479794311;
        Tue, 25 Jun 2019 09:23:14 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id w132sm16436090pfd.78.2019.06.25.09.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:23:13 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH v2] x86/tls: Fix possible spectre-v1 in do_get_thread_area()
Date:   Wed, 26 Jun 2019 00:22:59 +0800
Message-Id: <1561479779-6660-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index to access the threads tls array is controlled by userspace
via syscall: sys_ptrace(), hence leading to a potential exploitation
of the Spectre variant 1 vulnerability.
The idx can be controlled from:
        ptrace -> arch_ptrace -> do_get_thread_area.

Fix this by sanitizing idx before using it to index p->thread.tls_array.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/tls.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a..424cff5 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,9 @@ int do_get_thread_area(struct task_struct *p, int idx,
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+	index = idx - GDT_ENTRY_TLS_MIN;
+
+	fill_user_desc(&info, idx, &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;
-- 
2.7.4

