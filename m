Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98AC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B93720665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JZIFNKan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFVKLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:11:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:11:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA941n2096933
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:09:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA941n2096933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198145;
        bh=KZRV5lP8eqWytYnhcJQxfNWwkoF2Xm+rM4UWfgSESHU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JZIFNKanimrqB1/J5DyQGdBsA+ijyR1NaLKJLoVZsEo4jI+ouT3GUmZT625Za8/F5
         z/GDMUTwFwBIWZ5RizzveG6EyAZJtjVHM0tO5j1MPIirgdMYhcGkmloo2tSPIovCyo
         6bCsdkmprJ97cTlS+YhBFNBYdLspfv7eLhFKyM1HsUVnnIhut86jTH/LetcYgi9QaJ
         9H1Z4qLQlxG1Mn/pEns2RM7OHw4SVuyOEa7nITFGUe6WkJfQWu667H3QBILt05WXyS
         4m1Qgq+BdLiQQVFn7SsJzVDJ0/vi/T87Bve2jGvKj1T2ga989H0K5su0XyeppY4Ctn
         cSCLy788XkNLA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA94qC2096928;
        Sat, 22 Jun 2019 03:09:04 -0700
Date:   Sat, 22 Jun 2019 03:09:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-f60a83df4593c5e03e746ded66d8b436c4ad6e41@git.kernel.org>
Cc:     hpa@zytor.com, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ravi.v.shankar@intel.com, ak@linux.intel.com,
        chang.seok.bae@intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, luto@kernel.org, chang.seok.bae@intel.com,
          ak@linux.intel.com, ravi.v.shankar@intel.com
In-Reply-To: <1557309753-24073-9-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-9-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/process/64: Use FSGSBASE instructions on thread
 copy and ptrace
Git-Commit-ID: f60a83df4593c5e03e746ded66d8b436c4ad6e41
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

Commit-ID:  f60a83df4593c5e03e746ded66d8b436c4ad6e41
Gitweb:     https://git.kernel.org/tip/f60a83df4593c5e03e746ded66d8b436c4ad6e41
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:23 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:53 +0200

x86/process/64: Use FSGSBASE instructions on thread copy and ptrace

When FSGSBASE is enabled, copying threads and reading fsbase and gsbase
using ptrace must read the actual values.

When copying a thread, use save_fsgs() and copy the saved values.  For
ptrace, the bases must be read from memory regardless of the selector if
FSGSBASE is enabled.

[ tglx: Invoke __rdgsbase_inactive() with interrupts disabled ]
[ luto: Massage changelog ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-9-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/kernel/process_64.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 59013f480b86..8f239091c15d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -245,13 +245,17 @@ static __always_inline void save_fsgs(struct task_struct *task)
 	savesegment(fs, task->thread.fsindex);
 	savesegment(gs, task->thread.gsindex);
 	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
 		/*
 		 * If FSGSBASE is enabled, we can't make any useful guesses
 		 * about the base, and user code expects us to save the current
 		 * value.  Fortunately, reading the base directly is efficient.
 		 */
 		task->thread.fsbase = rdfsbase();
+		local_irq_save(flags);
 		task->thread.gsbase = __rdgsbase_inactive();
+		local_irq_restore(flags);
 	} else {
 		save_base_legacy(task, task->thread.fsindex, FS);
 		save_base_legacy(task, task->thread.gsindex, GS);
@@ -433,7 +437,8 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -447,7 +452,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
@@ -487,10 +493,11 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap_ptr = NULL;
 
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
+	save_fsgs(me);
+	p->thread.fsindex = me->thread.fsindex;
+	p->thread.fsbase = me->thread.fsbase;
+	p->thread.gsindex = me->thread.gsindex;
+	p->thread.gsbase = me->thread.gsbase;
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
