Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3E24A7D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ryh7EsoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFDHPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:15:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfFDHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aUpWXapFqRcH+22hJWom89K7PcnuvJBUrOL5F8d3PbA=; b=Ryh7EsoDFXW31Ne9EsNvr3uuiL
        y91s39SQgAGebEeem3K43kLD9OMcgucKtoK2obTYs+McPllWf+V/+H3OcZ5eMLilYtmSNmGNohhmJ
        KcUeDl8c9vroPi7Va1vg1/VTqjjbJSqHRWXmBMTlFGZeuBPsMPuszzBSzZiCU6BsHyUfMIji+9BgP
        3L+3tPN/a0uj1+XwFtx9N33iit9Gt/Rew91ti1wFiQ5x2wgbEFHZBpkgeN7oRLD0Soq8wDQGT3g32
        uo+KlP8O6gvoV0NDyxloTC0nr/0gCmBlDAEZeRaTJ5NhKHwEmPK5RWHipFyz4XoZASD3h7iUbS5wI
        qDkPIqvw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3fR-0004EG-7j; Tue, 04 Jun 2019 07:15:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/fpu: Simplify kernel_fpu_begin
Date:   Tue,  4 Jun 2019 09:15:23 +0200
Message-Id: <20190604071524.12835-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604071524.12835-1-hch@lst.de>
References: <20190604071524.12835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge two helpers into the main function, remove a pointless local
variable and flatten a conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/fpu/core.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1d09af1158e1..03c2d306e6f2 100644
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
@@ -88,32 +82,25 @@ bool irq_fpu_usable(void)
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
 
-	if (current->mm) {
-		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-			set_thread_flag(TIF_NEED_FPU_LOAD);
-			/*
-			 * Ignore return value -- we don't care if reg state
-			 * is clobbered.
-			 */
-			copy_fpregs_to_fpstate(fpu);
-		}
+	if (current->mm && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
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
-- 
2.20.1

