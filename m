Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7952082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDNVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 17:10:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 17:10:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ELA7mj2699346
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 14:10:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ELA6PN2699341;
        Sun, 14 Apr 2019 14:10:06 -0700
Date:   Sun, 14 Apr 2019 14:10:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2f5fb19341883bb6e37da351bc3700489d8506a7@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, mikhail.v.gavrilov@gmail.com,
        thomas.lendacky@amd.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: thomas.lendacky@amd.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mikhail.v.gavrilov@gmail.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation: Prevent deadlock on
 ssb_state::lock
Git-Commit-ID: 2f5fb19341883bb6e37da351bc3700489d8506a7
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

Commit-ID:  2f5fb19341883bb6e37da351bc3700489d8506a7
Gitweb:     https://git.kernel.org/tip/2f5fb19341883bb6e37da351bc3700489d8506a7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 19:51:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 23:05:52 +0200

x86/speculation: Prevent deadlock on ssb_state::lock

Mikhail reported a lockdep splat related to the AMD specific ssb_state
lock:

  CPU0                       CPU1
  lock(&st->lock);
                             local_irq_disable();
                             lock(&(&sighand->siglock)->rlock);
                             lock(&st->lock);
  <Interrupt>
     lock(&(&sighand->siglock)->rlock);

  *** DEADLOCK ***

The connection between sighand->siglock and st->lock comes through seccomp,
which takes st->lock while holding sighand->siglock.

Make sure interrupts are disabled when __speculation_ctrl_update() is
invoked via prctl() -> speculation_ctrl_update(). Add a lockdep assert to
catch future offenders.

Fixes: 1f50ddb4f418 ("x86/speculation: Handle HT correctly on AMD")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Thomas Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1904141948200.4917@nanos.tec.linutronix.de

---
 arch/x86/kernel/process.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ac7be52c7a..957eae13b370 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -426,6 +426,8 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 	u64 msr = x86_spec_ctrl_base;
 	bool updmsr = false;
 
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * If TIF_SSBD is different, select the proper mitigation
 	 * method. Note that if SSBD mitigation is disabled or permanentely
@@ -477,10 +479,12 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 
 void speculation_ctrl_update(unsigned long tif)
 {
+	unsigned long flags;
+
 	/* Forced update. Make sure all relevant TIF flags are different */
-	preempt_disable();
+	local_irq_save(flags);
 	__speculation_ctrl_update(~tif, tif);
-	preempt_enable();
+	local_irq_restore(flags);
 }
 
 /* Called from seccomp/prctl update */
