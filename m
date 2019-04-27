Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F35C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF4206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfD0PXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33688 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbfD0PPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:30 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP30-00014G-UV; Sat, 27 Apr 2019 16:15:27 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2l-0004YN-Ec; Sat, 27 Apr 2019 16:15:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.307922336@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 124/202] powerpc: Use sigsp()
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

commit 059ade650ae57cfd371af690fdba887af04aded8 upstream.

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
[bwh: Backported to 3.16 as dependency of commit 35634ffa1751
 "signal: Always notice exiting tasks"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/signal.c    | 10 ++--------
 arch/powerpc/kernel/signal_32.c |  4 ++--
 arch/powerpc/kernel/signal_64.c |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -31,20 +31,14 @@ int show_unhandled_signals = 1;
 /*
  * Allocate space for the signal frame
  */
-void __user * get_sigframe(struct k_sigaction *ka, unsigned long sp,
+void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
 			   size_t frame_size, int is_32)
 {
         unsigned long oldsp, newsp;
 
         /* Default to using normal stack */
         oldsp = get_clean_sp(sp, is_32);
-
-	/* Check for alt stack */
-	if ((ka->sa.sa_flags & SA_ONSTACK) &&
-	    current->sas_ss_size && !on_sig_stack(oldsp))
-		oldsp = (current->sas_ss_sp + current->sas_ss_size);
-
-	/* Get aligned frame */
+	oldsp = sigsp(oldsp, ksig);
 	newsp = (oldsp - frame_size) & ~0xFUL;
 
 	/* Check access */
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1014,7 +1014,7 @@ int handle_rt_signal32(struct ksignal *k
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
@@ -1445,7 +1445,7 @@ int handle_signal32(struct ksignal *ksig
 	unsigned long tramp;
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*frame), 1);
+	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -749,7 +749,7 @@ int handle_rt_signal64(struct ksignal *k
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(&ksig->ka, get_tm_stackpointer(regs), sizeof(*frame), 0);
+	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 

