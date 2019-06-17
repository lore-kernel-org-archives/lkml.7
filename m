Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A003C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE592084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hUySENJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfFQKc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:32:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:32:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HAVnjm3369309
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 03:31:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HAVnjm3369309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560767510;
        bh=FKfxDG6dJMYpWrzCl1adpOClPJSHxmUfRMnxFDyTbM0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hUySENJ2JrZTlEGDqdcq5VIVHuX77lKE9vApmTAWmhA6w2owRF834cCmq+oGYVPwQ
         oPAxmR8n9GwFh2vRPiGXJObXsPW+5EKv4WViy5NEkUf3vUZtFFvWoMZmiEZRsMl0lo
         zwX13f5zVWyvwLcb6SLnFHGiZCwT3GGlztMGAiSnEPdmftO96vD27RYxghT5fq8aYi
         wiTHW7LqoDzU7tEGZOADXSDjmlAwauGcLEJo09IxPKyFSbnskdU2tj35XueugNYTGW
         bTqnMD8GjFL0YV6adeHZmy4pcMoM6Ja4PxITh7F1TOx1rMwnuSVW/JoHT/Rt7lqC0O
         oX6/oIYwT1oLA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HAVnro3369306;
        Mon, 17 Jun 2019 03:31:49 -0700
Date:   Mon, 17 Jun 2019 03:31:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-6d79d86f9600510e08ad45c72b9d7e664e439e62@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, hch@lst.de, bp@suse.de,
        bigeasy@linutronix.de, x86@kernel.org, riel@surriel.com,
        nstange@suse.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
          x86@kernel.org, hch@lst.de, bp@suse.de, riel@surriel.com,
          nstange@suse.de, tglx@linutronix.de, dave.hansen@intel.com,
          linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20190604071524.12835-3-hch@lst.de>
References: <20190604071524.12835-3-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Simplify kernel_fpu_begin()
Git-Commit-ID: 6d79d86f9600510e08ad45c72b9d7e664e439e62
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

Commit-ID:  6d79d86f9600510e08ad45c72b9d7e664e439e62
Gitweb:     https://git.kernel.org/tip/6d79d86f9600510e08ad45c72b9d7e664e439e62
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Tue, 4 Jun 2019 09:15:23 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 17 Jun 2019 12:19:49 +0200

x86/fpu: Simplify kernel_fpu_begin()

Merge two helpers into the main function, remove a pointless local
variable and flatten a conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190604071524.12835-3-hch@lst.de
---
 arch/x86/kernel/fpu/core.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8e046068d20f..3f92cfad88f0 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -43,12 +43,6 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static void kernel_fpu_disable(void)
-{
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, true);
-}
-
 static bool kernel_fpu_disabled(void)
 {
 	return this_cpu_read(in_kernel_fpu);
@@ -88,32 +82,26 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
-static void __kernel_fpu_begin(void)
+void kernel_fpu_begin(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	preempt_disable();
 
 	WARN_ON_FPU(!irq_fpu_usable());
+	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
-	kernel_fpu_disable();
+	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & PF_KTHREAD)) {
-		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-			set_thread_flag(TIF_NEED_FPU_LOAD);
-			/*
-			 * Ignore return value -- we don't care if reg state
-			 * is clobbered.
-			 */
-			copy_fpregs_to_fpstate(fpu);
-		}
+	if (!(current->flags & PF_KTHREAD) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+		/*
+		 * Ignore return value -- we don't care if reg state
+		 * is clobbered.
+		 */
+		copy_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 }
-
-void kernel_fpu_begin(void)
-{
-	preempt_disable();
-	__kernel_fpu_begin();
-}
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
 void kernel_fpu_end(void)
