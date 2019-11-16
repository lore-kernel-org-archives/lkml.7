Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D91DC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFBF206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKPMDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:03:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:03:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwmn-0002XZ-KN; Sat, 16 Nov 2019 13:02:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3869D1C190B;
        Sat, 16 Nov 2019 13:02:41 +0100 (CET)
Date:   Sat, 16 Nov 2019 12:02:41 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry/32: Remove unused resume_userspace label
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191023123117.686514045@linutronix.de>
References: <20191023123117.686514045@linutronix.de>
MIME-Version: 1.0
Message-ID: <157390576119.12247.2366713267971139294.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     df1a7524741b6c094786032e12a21a448321d9f6
Gitweb:        https://git.kernel.org/tip/df1a7524741b6c094786032e12a21a448321d9f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Oct 2019 14:27:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 12:55:55 +01:00

x86/entry/32: Remove unused resume_userspace label

The C reimplementation of SYSENTER left that unused ENTRY() label
around. Remove it.

Fixes: 5f310f739b4c ("x86/entry/32: Re-implement SYSENTER using the new C path")
Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191023123117.686514045@linutronix.de

---
 arch/x86/entry/entry_32.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index a987b62..4bbcc5e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -824,7 +824,6 @@ ret_from_intr:
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
 
-SYM_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
