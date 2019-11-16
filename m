Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3E420723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 08:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYBP+Mc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfKPIst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 03:48:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35048 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfKPIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 03:48:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so12934567wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXK8i3dcP0wrlupZd2syn0RAvq63einR0Js8n3kXDKU=;
        b=bYBP+Mc0aBAuqpK0IA27BZ/v66eES1UImafLgG20OvK0dZt/CYrruegMIC55VjXffY
         sZdUbk8h04brIJHW8PLu+oX4QbxttezEZxdVB4lLQETTOclFjroIPfZJP3qTcAskBS6G
         uZdc1EQuWmjFeTWkOvEd6IDZpPPD/w/E6l9f1ohTLg5feDW/ckxMQrVyH/VqAizzTvhp
         30zylcW+gVWSGxsw/bBjJsvJG/l9JXEOpsWFbWbbB7uUZOnNutsQg+79Qmsal7FfLwBy
         nCCEDoCC3v24x7Fl1zu5R9/PJ3GqBNMZf1p9MpdqkMiO4LTtcQCbpr1+zNwkBCj3/9yN
         DJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXK8i3dcP0wrlupZd2syn0RAvq63einR0Js8n3kXDKU=;
        b=LL8x1Fbb8A648EatUHiv0lSxghVi8BB8TQUXBKcudJDNePC7Azmsi3duYGdltSn9OC
         EfN0o7hmlcxoS+ENODrD/9vrtY1/I7d+NnJnrOhQuZKjTyW77SfuRajsineoX6bolFq3
         Pi5XWa8C9KdrExtGwSQTezhFAdQ3zS0Tl3VX1UBWE1pjlZXSPaIZnIYTKna+knOIg63u
         20hxtBPwF8Pcf01RbLCPb9Vzj6lLO8Lve65WvHHnBxlxao0uVm5vJ+v7WrymFJvzkwPn
         WEhFDskedwHL3TTXGOA7c1jyglfhRmJSIBcqg7hU2JPOARwiWNAFaodwAmAstUqUCXMv
         BXzw==
X-Gm-Message-State: APjAAAWs2g5ob31DeyjfMGYPMEoWU6qCHFnPqymSzQXym/yXsBAF8S+Y
        +VhhoPuQR2LYZRDYuxTUSXU=
X-Google-Smtp-Source: APXvYqw4PZvztSBAngMLI49hn91f34UJivYIkbJKvbHV+zh8P07Mp1MiEjQwEVWaOshFXaoSXZhPOg==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr18594011wme.57.1573894125367;
        Sat, 16 Nov 2019 00:48:45 -0800 (PST)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id g184sm13460814wma.8.2019.11.16.00.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 00:48:43 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH] x86/nmi: remove the irqwork for long nmi handler duration warning
Date:   Sat, 16 Nov 2019 16:48:35 +0800
Message-Id: <20191116084835.3524-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, printk is NMI context safe now since the safe printk has been
implemented. The safe printk will help us to do such work in its irqwork.

Second, the NMI irqwork actually does not work if a NMI handler causes
watchdog timeout panic. The NMI irqwork have no chance to run in such
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
index 4df7705022b9..0fa51f80ad73 100644
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
2.20.1

