Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2EE2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfC2NTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:19:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfC2NTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:19:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TDJHSn3797645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 06:19:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TDJHWu3797637;
        Fri, 29 Mar 2019 06:19:17 -0700
Date:   Fri, 29 Mar 2019 06:19:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-aba0954327c831f593702e3a81ef3ad4bec7a838@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, valentin.schneider@arm.com,
        mojha@codeaurora.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          fweisbec@gmail.com, bp@suse.de, valentin.schneider@arm.com,
          mojha@codeaurora.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190329110508.6621-1-bp@alien8.de>
References: <20190329110508.6621-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick/broadcast: Fix warning about undefined
 tick_broadcast_oneshot_offline()
Git-Commit-ID: aba0954327c831f593702e3a81ef3ad4bec7a838
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

Commit-ID:  aba0954327c831f593702e3a81ef3ad4bec7a838
Gitweb:     https://git.kernel.org/tip/aba0954327c831f593702e3a81ef3ad4bec7a838
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 29 Mar 2019 11:28:52 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 29 Mar 2019 14:13:44 +0100

tick/broadcast: Fix warning about undefined tick_broadcast_oneshot_offline()

Randconfig builds with

  CONFIG_TICK_ONESHOT=y
  CONFIG_HOTPLUG_CPU=n

trigger

  kernel/time/tick-broadcast.c:39:13: warning: ‘tick_broadcast_oneshot_offline’ \
	  declared ‘static’ but never defined [-Wunused-function]

due to that function's definition missing.

Move the CONFIG_HOTPLUG_CPU ifdeffery around its declaration too.

Fixes: 1b72d4323798 ("tick: Remove outgoing CPU from broadcast masks")
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190329110508.6621-1-bp@alien8.de
---
 kernel/time/tick-broadcast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0283523de045..7541cbca695e 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -36,12 +36,16 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
+# ifdef CONFIG_HOTPLUG_CPU
 static void tick_broadcast_oneshot_offline(unsigned int cpu);
+# endif
 #else
 static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
 static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
+# ifdef CONFIG_HOTPLUG_CPU
 static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
+# endif
 #endif
 
 /*
