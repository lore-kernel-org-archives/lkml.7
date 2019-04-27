Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F767206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfD0PXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33728 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbfD0PPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:30 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP31-0000zM-LL; Sat, 27 Apr 2019 16:15:27 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004Y3-Ax; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.192745922@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 120/202] mips: Use sigsp()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 7c4f563507c33ca97dcfbd62dba1e9232575d499 upstream.

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/signal.c     | 10 ++++------
 arch/mips/kernel/signal32.c   |  4 ++--
 arch/mips/kernel/signal_n32.c |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -280,7 +280,7 @@ int restore_sigcontext(struct pt_regs *r
 	return err;
 }
 
-void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 			  size_t frame_size)
 {
 	unsigned long sp;
@@ -295,9 +295,7 @@ void __user *get_sigframe(struct k_sigac
 	 */
 	sp -= 32;
 
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
+	sp = sigsp(sp, ksig);
 
 	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
 }
@@ -434,7 +432,7 @@ static int setup_frame(void *sig_return,
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
@@ -473,7 +471,7 @@ static int setup_rt_frame(void *sig_retu
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -494,7 +494,7 @@ static int setup_frame_32(void *sig_retu
 	struct sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
@@ -534,7 +534,7 @@ static int setup_rt_frame_32(void *sig_r
 	struct rt_sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -108,7 +108,7 @@ static int setup_rt_frame_n32(void *sig_
 	struct rt_sigframe_n32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 

