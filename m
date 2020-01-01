Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE5AC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1164A2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trMtSEBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAAHUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 02:20:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40730 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 02:20:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so20537092pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 23:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vy4x1uZ6KviudWnvu6W2UMmvm4EQwTGZG2bElmjYCN8=;
        b=trMtSEBmMAZrGlO66FIry9BOrqXyvdjGQq6m9t53Dz8bt3tj8h7gBxEaZUQkYmxg9l
         QMwvTW5T6y8ZKbF2EXpd8eQxtTUVyi3EhfGk9QA4XEo5aADu3NDyFR3vaddU3GZJD2jq
         IcHM4g5RQASd4XzqbIGSpt5ka6i1XTytRE3Ao3qmWK0uWi3L87wX9OoJMyXhjOmtCmyk
         Ufc/clPY4khUoiSfOWJeaZuTSPnVo9JtISHmnqxW+t2s34sYjtwD5U4VxfA93FkXCaTY
         A4pqVAVcAEQ9J+QOgvSIqO3bknNvAbk3ml9EgbshkYPD21moXPjDDVCYZ2cJYzuQd9Gm
         +CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vy4x1uZ6KviudWnvu6W2UMmvm4EQwTGZG2bElmjYCN8=;
        b=Ow961hQ1bNVruppbGOZWK8JBjrzVGMH1uYG2OQ8nCJhs+U7xagTo/tJiddteAF4w2K
         IXsKiiLinw+4TIza+TxslzuUKLxNVpLS8ep9bnPm5AMvGTk00J05neR/l8OTxD356Jex
         n0DY2CBvEngEpI/m21ll8+ER6Pd2eb8B/NEzcYpIJrKnFx5jNZnqOVInGNE23TTDVedy
         SkPS25Bl0fUyKbDBf95klTDU745pBfDkuKkC6ZFKnPsag/HrwEEwitGQKogp3gZuAm9A
         /t1xakjkSorLw6GhywJ6AJb2H3W04RS87heJePMGMbihqaLMPCweOoOjtQTS+QmohRFu
         oCVA==
X-Gm-Message-State: APjAAAXVL7Z69Zw5DSB9xICs6H3gYZ4pM1yFgpCGvQ5lI3ARKaHTsanM
        ziGkxYoaPuBn6vxMvqO+zs0=
X-Google-Smtp-Source: APXvYqy5fr+0W52631Igzr71SbvaPZfYIQgYCLSUBBCxchNuyMa+KeaxXy/U1JlCE0pkBOyD6kpW0g==
X-Received: by 2002:a63:62c2:: with SMTP id w185mr79715130pgb.271.1577863229319;
        Tue, 31 Dec 2019 23:20:29 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id c68sm59993423pfc.156.2019.12.31.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 23:20:28 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] x86/nmi: remove the irqwork from long duration nmi handler
Date:   Wed,  1 Jan 2020 15:20:17 +0800
Message-Id: <20200101072017.82990-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, printk is NMI context safe now since the safe printk has been
implemented. The safe printk already has an irqwork to make NMI context
safe.

Second, the NMI irqwork actually does not work if a NMI handler causes
panic by watchdog timeout. This NMI irqwork have no chance to run in such
case, while the safe printk will flush its per-cpu buffer before panic.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/x86/include/asm/nmi.h |  1 -
 arch/x86/kernel/nmi.c      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 75ded1d13d98..9d5d949e662e 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -41,7 +41,6 @@ struct nmiaction {
 	struct list_head	list;
 	nmi_handler_t		handler;
 	u64			max_duration;
-	struct irq_work		irq_work;
 	unsigned long		flags;
 	const char		*name;
 };
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e676a9916c49..aa15d4f2340f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -104,18 +104,22 @@ static int __init nmi_warning_debugfs(void)
 }
 fs_initcall(nmi_warning_debugfs);
 
-static void nmi_max_handler(struct irq_work *w)
+static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	struct nmiaction *a = container_of(w, struct nmiaction, irq_work);
 	int remainder_ns, decimal_msecs;
-	u64 whole_msecs = READ_ONCE(a->max_duration);
+	u64 whole_msecs = READ_ONCE(action->max_duration);
+
+	if (duration < nmi_longest_ns || duration < action->max_duration)
+		return;
+
+	action->max_duration = duration;
 
 	remainder_ns = do_div(whole_msecs, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		a->handler, whole_msecs, decimal_msecs);
+		action->handler, whole_msecs, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
@@ -142,11 +146,7 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 		delta = sched_clock() - delta;
 		trace_nmi_handler(a->handler, (int)delta, thishandled);
 
-		if (delta < nmi_longest_ns || delta < a->max_duration)
-			continue;
-
-		a->max_duration = delta;
-		irq_work_queue(&a->irq_work);
+		nmi_check_duration(a, delta);
 	}
 
 	rcu_read_unlock();
@@ -164,8 +164,6 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	if (!action->handler)
 		return -EINVAL;
 
-	init_irq_work(&action->irq_work, nmi_max_handler);
-
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
 	/*
-- 
2.24.0

