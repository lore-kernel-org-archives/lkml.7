Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A373C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDBC2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfH2Gkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:40:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49053 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfH2Gkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:40:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3E6n-0002qD-96; Thu, 29 Aug 2019 08:40:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 220B51C07C3;
        Thu, 29 Aug 2019 08:40:36 +0200 (CEST)
Date:   Thu, 29 Aug 2019 06:40:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Unbreak CONFIG_POSIX_TIMERS=n build
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156706083595.5671.10077704238426235734.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8f2edb4a78f7f5fa35c025849152b1d2dfaee4eb
Gitweb:        https://git.kernel.org/tip/8f2edb4a78f7f5fa35c025849152b1d2dfaee4eb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Aug 2019 08:19:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2019 08:25:21 +02:00

posix-timers: Unbreak CONFIG_POSIX_TIMERS=n build

The rework of the posix-cpu-timers patch series dropped the empty
declaration of struct cpu_timer for the CONFIG_POSIX_TIMERS=n case which
causes the build to fail:

./include/linux/posix-timers.h:218:20: error: field 'cpu' has incomplete type

Add it back.

Fixes: 60bda037f1dd ("posix-cpu-timers: Utilize timerqueue for storage")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index f9fbb4c..e685916 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -161,6 +161,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 	},
 #else
 struct posix_cputimers { };
+struct cpu_timer { };
 #define INIT_CPU_TIMERS(s)
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
