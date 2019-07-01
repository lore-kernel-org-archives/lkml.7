Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF5320881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3bx48N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfGAMYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:24:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45326 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfGAMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:24:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so7281152plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ubi5D4xV2S3/wNwBXGfEmWFyoOOdOltJmtxY+PQKiz8=;
        b=m3bx48N+5S8Y2Wl3rEztnhJBYYZVh68sdbfG8URfxRxlgCOI5eT8jz+E9gFWONTC8l
         YGLNjpgVK320S4qkyeI0HMQVKh5MJEY7kFxXCvioIHuzeFW2+k7fOcuBCjetm1S/jIgz
         csK8lDMKYyqxcBdaBMzkdbLvuMPamAMQEOMWwUqQ13/Gwh90EYAPrTsR2WYtYoh7b9VO
         USbriolp3xtH1cYalukPw0GI9NsJ1cFaeDPdjjK0tVbOKfsPv6dQwbCXYCwmUy7610Ke
         bEAgQ8m+9xOBrqjV29DPPbNP4jQhztYinyB+zlxmhgELDFvU98zmwshbiqltosLGdPHK
         fCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ubi5D4xV2S3/wNwBXGfEmWFyoOOdOltJmtxY+PQKiz8=;
        b=l8sxSdESMWyNvm7i6P7Oa5IA/7hUylf2LR7r22PeuzswYC3yPvnTFvnjTqKFkG8X2u
         4OXEBnZnWEcdiY2As4psKf2KD3vwMdy/YVfFTT/mEn8d3RFIQmMi9zMc8d6YrRzThmF9
         it6cvodZMHdihlhvnLBg+rGZQWQl4Bj42T+DRIlsfqncSs2dFdvVK3dQVGbOp0RmkIQd
         OTLevEl6sGJrcpUSriuvIZwXkJfp5mjwdCTOJAY1C/sGWWkNp44qN9fngr0a9OgBfs4D
         j9hds7p+HEnZSDSPIbGlE++v3j9Q/9W8nKmkV39iapL5hZVjzryMtuFpg+zyb58Omvyf
         2+Ag==
X-Gm-Message-State: APjAAAVp41jZjnLAA2kQ5XC4WYLYsCVXgi+lxopjXqqEtFzNHrZg3ebb
        HpK3ofipLQ6k+yNgvDPVb+Sogtxm
X-Google-Smtp-Source: APXvYqyixNNCiUMC77paFbOwFhwOSYsJbuYGp3cL2Pr1Oktawkz1QrXTSR/9GuLTNQF6+zST5BKdFQ==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr27568695pls.318.1561983884759;
        Mon, 01 Jul 2019 05:24:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id u21sm12415036pfm.70.2019.07.01.05.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 05:24:44 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/core: Cache timer busy housekeeping target
Date:   Mon,  1 Jul 2019 20:24:37 +0800
Message-Id: <1561983877-4727-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Cache the busy housekeeping target for timer instead of researching each time.
This patch reduces the total time of get_nohz_timer_target() for busy housekeeping 
CPU from 2u~3us to less than 1us which can be observed by ftrace.

Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 include/linux/hrtimer.h    | 1 +
 include/linux/sched/nohz.h | 2 +-
 kernel/sched/core.c        | 6 +++++-
 kernel/time/hrtimer.c      | 6 ++++--
 kernel/time/timer.c        | 7 +++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957e..0d8b271 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -198,6 +198,7 @@ enum  hrtimer_base_type {
 struct hrtimer_cpu_base {
 	raw_spinlock_t			lock;
 	unsigned int			cpu;
+	unsigned int			last_target_cpu;
 	unsigned int			active_bases;
 	unsigned int			clock_was_set_seq;
 	unsigned int			hres_active		: 1,
diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91f..0afb094 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -8,7 +8,7 @@
 
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
-extern int get_nohz_timer_target(void);
+extern int get_nohz_timer_target(unsigned int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7968e0f..f4ba63e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -549,11 +549,15 @@ void resched_cpu(int cpu)
  * selecting an idle CPU will add more delays to the timers than intended
  * (as that CPU's timer base may not be uptodate wrt jiffies etc).
  */
-int get_nohz_timer_target(void)
+int get_nohz_timer_target(unsigned int last_target_cpu)
 {
 	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
+	if (!idle_cpu(last_target_cpu) &&
+		housekeeping_cpu(last_target_cpu, HK_FLAG_TIMER))
+		return last_target_cpu;
+
 	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
 		if (!idle_cpu(cpu))
 			return cpu;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff2..0d49bef 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -195,8 +195,10 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
 					 int pinned)
 {
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) && !pinned)
-		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
+	if (static_branch_likely(&timers_migration_enabled) && !pinned) {
+		base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
+		return &per_cpu(hrtimer_bases, base->last_target_cpu);
+	}
 #endif
 	return base;
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 343c7ba..6ae045a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -199,6 +199,7 @@ struct timer_base {
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
+	unsigned int		last_target_cpu;
 	bool			is_idle;
 	bool			must_forward_clk;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
@@ -865,8 +866,10 @@ get_target_base(struct timer_base *base, unsigned tflags)
 {
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
+	    !(tflags & TIMER_PINNED)) {
+		base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
+		return get_timer_cpu_base(tflags, base->last_target_cpu);
+	}
 #endif
 	return get_timer_this_cpu_base(tflags);
 }
-- 
2.7.4

