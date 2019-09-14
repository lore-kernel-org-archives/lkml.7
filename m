Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631ADC4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312CE2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtYGqEBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfINE5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:57:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42682 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfINE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:57:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so3102801pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 21:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXK8i3dcP0wrlupZd2syn0RAvq63einR0Js8n3kXDKU=;
        b=jtYGqEBWfPnvYYkUJ4rTSGo5nxzlwAtfWjmrPKJcrgNiowDrdgk8C1UCVY8Gr26Ajg
         gf//G8gkGX77zQi+bpNSjz8V0QZ4wVgIru5SEthDVAhaYGaX4Jb0PzdeIL1tEWFaq2z1
         A+KSBoamuAPpHKMo5qCXavT1C+Sst0c8kbmw+QmGmEk8uFdK354EEpbYPs5wy+jdAhdl
         pU2Npk61osNGbx18SnHdMNSdkxjJU1gw9yV7QUn8/PimaOKwPya1CJkd4G3zb7gaZiQD
         w9MfShEVRzL//O3HB0rRLsOV4nxt3DJY5j3H6RwJStljvBh8h8G1rOVvBkY5zlTrokFt
         O53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXK8i3dcP0wrlupZd2syn0RAvq63einR0Js8n3kXDKU=;
        b=L59attIuFm6XfMhpl4sl6gUFuWN9tUiYSZ1FbwAwgTqY2YhhDIrJmVxWWR2CNJsg3l
         32VLYmfGuw0RevVPubKARApjwKs+Vbk2sWp/xsSEtiq2AhtmjgE1pGM1Y+ZQVBy6XODn
         fwsRMQpD1/GxyanJVNQ3UZ7fHHQsHmX6heUldID2fTA0neuGJOhQJJgpeB1CdnIXCmGY
         8OvCV1TToDmRGgyf+9EbJmu/QckQZGCNuGP5zyI9dmvb7G25eLHL3vN/36uPKqha//6d
         Ry0Rr30urdgx5gk0ZdyRQViJ/7R1EuXLsDYyDK+XgGgOJBdsKjnbZa6GRIL7SvL/RYTG
         LtUA==
X-Gm-Message-State: APjAAAXwY1RYpkb4pHn93+ptG4SfEPCW/myzolQNk9wBko6fg8F/Zslj
        FuKkp2lLxa8xM4Fpw4Q5V6w=
X-Google-Smtp-Source: APXvYqwGqs+Am5nbTA0K7R4+WDqaFr+KuXxSZruY6kirchYRbgyJGZcMW0zAJEhhINeeWyLfBrUmLA==
X-Received: by 2002:a17:902:20c9:: with SMTP id v9mr51336181plg.293.1568437021853;
        Fri, 13 Sep 2019 21:57:01 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id b14sm3468108pjo.13.2019.09.13.21.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 21:57:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] x86/nmi: remove the irqwork for long nmi handler duration warning
Date:   Sat, 14 Sep 2019 12:56:46 +0800
Message-Id: <20190914045646.24387-1-changbin.du@gmail.com>
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

