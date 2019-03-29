Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D8C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QOt2QjQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfC2LFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:05:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfC2LFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:05:10 -0400
Received: from zn.tnic (p200300EC2F148A00A084EDD1F3CAD6FC.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:a084:edd1:f3ca:d6fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A6A51EC082D;
        Fri, 29 Mar 2019 12:05:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553857508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ra2S2wFC5PpsTLHVm49Gh7MFSZZqaaI47tLoaLHTSao=;
        b=QOt2QjQd/ocot5O9Yh+sQNOWw8Kov3uGYPPH9zl/GrVU2yD6I9jQGOUauV3Wg19arg4tqh
        bUcXbI4qSS154DCVLiEA+BkPFhbB0rUaxQZIACSVGvMft/mTKiOzShS/4ThJwFPsH0Fy6b
        vDuH26opQDi24xtr7DNMvPBnzUdofgU=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org
Subject: [PATCH] tick/broadcast: Fix warning about undefined tick_broadcast_oneshot_offline()
Date:   Fri, 29 Mar 2019 12:05:08 +0100
Message-Id: <20190329110508.6621-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: x86@kernel.org
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
-- 
2.21.0

