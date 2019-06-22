Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37BBC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CDA206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mUZZN48f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFVKJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:09:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfFVKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:09:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA8MNV2096425
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:08:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA8MNV2096425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198102;
        bh=yiRSbPD9BTJI1z+tx4GOHsGFUJgiwsADvMFwMvwnu54=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mUZZN48fk2yCX8Vu0qMghuZwRBSMCguEw+ZkAXyQ8nmuvwTUfonESvuUw/oQL8vNe
         dU9pDH81y+NZ1DsJI/qxIusxP/UlIe1DVbsivN2Ci2OVBeS+n3C4Y/CMH+L11wNCpm
         osmNaf3qElZDJTcFSx1mSums3QFNIE2l6yP/3U43oglPVrjwc762Zb6745xile0LwZ
         WZ8RzZHgcVeySTtUYCiWIjyoNd4zhb16gpW5IJpSpxDOwzo/WzzlCcf/kJOZX/RCUa
         mDr3uODF0IpIaUmGjEySlwB9FnxdooWrmQh+MEwF5lpfsFrByivAhsXMpfx7eJX9vQ
         blN+IvqVI1dSA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA8L0O2096415;
        Sat, 22 Jun 2019 03:08:21 -0700
Date:   Sat, 22 Jun 2019 03:08:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-1ab5f3f7fe3d7548b4361b68c1fed140c6841af9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        chang.seok.bae@intel.com, luto@kernel.org,
        ravi.v.shankar@intel.com, mingo@kernel.org, ak@linux.intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, mingo@kernel.org, ravi.v.shankar@intel.com,
          luto@kernel.org, chang.seok.bae@intel.com, hpa@zytor.com
In-Reply-To: <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/process/64: Use FSBSBASE in switch_to() if
 available
Git-Commit-ID: 1ab5f3f7fe3d7548b4361b68c1fed140c6841af9
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

Commit-ID:  1ab5f3f7fe3d7548b4361b68c1fed140c6841af9
Gitweb:     https://git.kernel.org/tip/1ab5f3f7fe3d7548b4361b68c1fed140c6841af9
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 8 May 2019 03:02:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:52 +0200

x86/process/64: Use FSBSBASE in switch_to() if available

With the new FSGSBASE instructions, FS and GSABSE can be efficiently read
and writen in __switch_to().  Use that capability to preserve the full
state.

This will enable user code to do whatever it wants with the new
instructions without any kernel-induced gotchas.  (There can still be
architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GSBASE if
WRGSBASE was used, but users are expected to read the CPU manual before
doing things like that.)

This is a considerable speedup.  It seems to save about 100 cycles
per context switch compared to the baseline 4.6-rc1 behavior on a
Skylake laptop.

[ chang: 5~10% performance improvements were seen with a context switch
  benchmark that ran threads with different FS/GSBASE values (to the
  baseline 4.16). Minor edit on the changelog. ]

[ tglx: Masaage changelog ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-8-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c34ee0f72378..59013f480b86 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -244,8 +244,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
 {
 	savesegment(fs, task->thread.fsindex);
 	savesegment(gs, task->thread.gsindex);
-	save_base_legacy(task, task->thread.fsindex, FS);
-	save_base_legacy(task, task->thread.gsindex, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * If FSGSBASE is enabled, we can't make any useful guesses
+		 * about the base, and user code expects us to save the current
+		 * value.  Fortunately, reading the base directly is efficient.
+		 */
+		task->thread.fsbase = rdfsbase();
+		task->thread.gsbase = __rdgsbase_inactive();
+	} else {
+		save_base_legacy(task, task->thread.fsindex, FS);
+		save_base_legacy(task, task->thread.gsindex, GS);
+	}
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -324,10 +334,22 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/* Update the FS and GS selectors if they could have changed. */
+		if (unlikely(prev->fsindex || next->fsindex))
+			loadseg(FS, next->fsindex);
+		if (unlikely(prev->gsindex || next->gsindex))
+			loadseg(GS, next->gsindex);
+
+		/* Update the bases. */
+		wrfsbase(next->fsbase);
+		__wrgsbase_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->fsindex, prev->fsbase,
+				next->fsindex, next->fsbase, FS);
+		load_seg_legacy(prev->gsindex, prev->gsbase,
+				next->gsindex, next->gsbase, GS);
+	}
 }
 
 static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
