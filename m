Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9353DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2902082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="46cDyLah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfHSNtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:49:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:49:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JDn8V94166449
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 06:49:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JDn8V94166449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566222549;
        bh=bt9qBxsW1yj/rc8BAQPZI2Fpcuazh9VG5NsUKCp6KPU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=46cDyLahblbPlji6Y727Sf3dn5OGX6uzqSuocI56qhYdw0U+ugG1Q0U3raILDihcf
         gXv+Th5FSod5HhZD2a6Vd3lgPWoWYxn6aEN7nKi6IwOlzJQ6lTg9IvsDlkJX0q2TDR
         szexbLQhwbotXYRhDPITx+SXR8JN6ciqtG+aBIOIiOFwXr9JN46vQiHMb3TvwMRgZY
         J+T5xNsPdLza10Xm8NmL/KGZI9IuKiHiBIYJzQh7cUEbN95JesWFdpy/K69ZRbRTPj
         7ie5gXlcj4GzoloY1RUpLlZkNahIjhZV5fCaESbDlwJAReomjBe42glGEtNHXQm5yg
         Vm5uW/xZCyktw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JDn8So4166445;
        Mon, 19 Aug 2019 06:49:08 -0700
Date:   Mon, 19 Aug 2019 06:49:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b6a32bbd8735def2d0d696ba59205d1874b7800f@git.kernel.org>
Cc:     mingo@kernel.org, bigeasy@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190816160923.12855-1-bigeasy@linutronix.de>
References: <20190816160923.12855-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Force interrupt threading on RT
Git-Commit-ID: b6a32bbd8735def2d0d696ba59205d1874b7800f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b6a32bbd8735def2d0d696ba59205d1874b7800f
Gitweb:     https://git.kernel.org/tip/b6a32bbd8735def2d0d696ba59205d1874b7800f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 16 Aug 2019 18:09:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 19 Aug 2019 15:45:48 +0200

genirq: Force interrupt threading on RT

Switch force_irqthreads from a boot time modifiable variable to a compile
time constant when CONFIG_PREEMPT_RT is enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190816160923.12855-1-bigeasy@linutronix.de

---
 include/linux/interrupt.h | 4 ++++
 kernel/irq/manage.c       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a99b2a..07b527dca996 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -472,7 +472,11 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 				 bool state);
 
 #ifdef CONFIG_IRQ_FORCED_THREADING
+# ifdef CONFIG_PREEMPT_RT
+#  define force_irqthreads	(true)
+# else
 extern bool force_irqthreads;
+# endif
 #else
 #define force_irqthreads	(0)
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f179bf77..97de1b7d43af 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -23,7 +23,7 @@
 
 #include "internals.h"
 
-#ifdef CONFIG_IRQ_FORCED_THREADING
+#if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
 __read_mostly bool force_irqthreads;
 EXPORT_SYMBOL_GPL(force_irqthreads);
 
