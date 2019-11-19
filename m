Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A082245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKSVCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:02:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKSVCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:02:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXAdI-0003Cs-NZ; Tue, 19 Nov 2019 22:01:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 535981C19F2;
        Tue, 19 Nov 2019 22:01:56 +0100 (CET)
Date:   Tue, 19 Nov 2019 21:01:56 -0000
From:   "tip-bot2 for Jan Beulich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/xen/32: Simplify ring check in xen_iret_crit_fixup()
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com>
References: <a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com>
MIME-Version: 1.0
Message-ID: <157419731617.12247.7937196185823441455.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     922eea2ce5c799228d9ff1be9890e6873ce8fff6
Gitweb:        https://git.kernel.org/tip/922eea2ce5c799228d9ff1be9890e6873ce8fff6
Author:        Jan Beulich <jbeulich@suse.com>
AuthorDate:    Mon, 11 Nov 2019 15:32:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 Nov 2019 21:58:28 +01:00

x86/xen/32: Simplify ring check in xen_iret_crit_fixup()

This can be had with two instead of six insns, by just checking the high
CS.RPL bit.

Also adjust the comment - there would be no #GP in the mentioned cases, as
there's no segment limit violation or alike. Instead there'd be #PF, but
that one reports the target EIP of said branch, not the address of the
branch insn itself.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com

---
 arch/x86/xen/xen-asm_32.S | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index 392e033..cd17777 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -153,22 +153,15 @@ hyper_iret:
  * it's still on stack), we need to restore its value here.
  */
 ENTRY(xen_iret_crit_fixup)
-	pushl %ecx
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
 	 * One could imagine a case where userspace jumps into the
 	 * critical range address, but just before the CPU delivers a
-	 * GP, it decides to deliver an interrupt instead.  Unlikely?
-	 * Definitely.  Easy to avoid?  Yes.  The Intel documents
-	 * explicitly say that the reported EIP for a bad jump is the
-	 * jump instruction itself, not the destination, but some
-	 * virtual environments get this wrong.
+	 * PF, it decides to deliver an interrupt instead.  Unlikely?
+	 * Definitely.  Easy to avoid?  Yes.
 	 */
-	movl 3*4(%esp), %ecx		/* nested CS */
-	andl $SEGMENT_RPL_MASK, %ecx
-	cmpl $USER_RPL, %ecx
-	popl %ecx
-	je 2f
+	testb $2, 2*4(%esp)		/* nested CS */
+	jnz 2f
 
 	/*
 	 * If eip is before iret_restore_end then stack
