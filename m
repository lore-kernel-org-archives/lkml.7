Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA1EECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2721835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194658;
	bh=7xLrSm/8DD98qQIY/fAys7wWXyhagREFGsFMcV5QcWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yBafitR9MXRINoaMAbhbrWkAStBIqbtxRx8Wl+ivL2haOxcfgb7vuvXvpB8W9DPJn
	 BNo0s4nh+V7HNbdpqUu/m0FN8Rj4MHucbo0e6jMOz1GlDhJi4uWta+Qus4x6Fk08rX
	 tpGVfJLErRSiawQPV+vW4xb+oTqoC5CoWrd05spQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbfJPC5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390747AbfJPC5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:33 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0BD217D6;
        Wed, 16 Oct 2019 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194653;
        bh=7xLrSm/8DD98qQIY/fAys7wWXyhagREFGsFMcV5QcWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0FS2Ic7DEvBpmctdttCi3Zl3IEF2DvRkF01qQN9TgJUXx2O5/biqdrYDftJ5JuxJ
         Z/FUOPq6gIT1Vhn3Ra2/eC4tGcB0wQwR9Hj7K0gQiQAB+HKSGp1dtDNJtCbSl4CY3H
         uZuNpGXYY+PR8gl7/vFspM6Ev8LU0GlOxVdCGK0E=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 09/14] sched/vtime: Introduce vtime_accounting_enabled_cpu()
Date:   Wed, 16 Oct 2019 04:56:55 +0200
Message-Id: <20191016025700.31277-10-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to check if a remote CPU runs vtime accounting
(ie: is nohz_full). We'll need that to reliably support reading kcpustat
on nohz_full CPUs.

Also simplify a bit the condition in the local flavoured function while
at it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index eb2e7a19054b..e2733bf33541 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -31,14 +31,14 @@ static inline bool vtime_accounting_enabled(void)
 	return context_tracking_enabled();
 }
 
+static inline bool vtime_accounting_enabled_cpu(int cpu)
+{
+	return (vtime_accounting_enabled() && context_tracking_enabled_cpu(cpu));
+}
+
 static inline bool vtime_accounting_enabled_this_cpu(void)
 {
-	if (vtime_accounting_enabled()) {
-		if (context_tracking_enabled_this_cpu())
-			return true;
-	}
-
-	return false;
+	return (vtime_accounting_enabled() && context_tracking_enabled_this_cpu());
 }
 
 extern void vtime_task_switch_generic(struct task_struct *prev);
@@ -51,6 +51,7 @@ static inline void vtime_task_switch(struct task_struct *prev)
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
+static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
-- 
2.23.0

