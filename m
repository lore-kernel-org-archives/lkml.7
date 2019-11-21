Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE98A206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKUUOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:14:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKUUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:14:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXsqQ-0004gW-HB; Thu, 21 Nov 2019 21:14:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F8611C1A4C;
        Thu, 21 Nov 2019 21:14:26 +0100 (CET)
Date:   Thu, 21 Nov 2019 20:14:26 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/doublefault/32: Fix stack canaries in the
 double fault handler
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157436726610.21853.16819575541395688892.tip-bot2@tip-bot2>
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

Commit-ID:     3580d0b29cab08483f84a16ce6a1151a1013695f
Gitweb:        https://git.kernel.org/tip/3580d0b29cab08483f84a16ce6a1151a1013695f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 11:50:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Nov 2019 19:37:42 +01:00

x86/doublefault/32: Fix stack canaries in the double fault handler

The double fault TSS was missing GS setup, which is needed for stack
canaries to work.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
---
 arch/x86/kernel/doublefault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/doublefault.c b/arch/x86/kernel/doublefault.c
index 0b8cedb..d5c9b13 100644
--- a/arch/x86/kernel/doublefault.c
+++ b/arch/x86/kernel/doublefault.c
@@ -65,6 +65,9 @@ struct x86_hw_tss doublefault_tss __cacheline_aligned = {
 	.ss		= __KERNEL_DS,
 	.ds		= __USER_DS,
 	.fs		= __KERNEL_PERCPU,
+#ifndef CONFIG_X86_32_LAZY_GS
+	.gs		= __KERNEL_STACK_CANARY,
+#endif
 
 	.__cr3		= __pa_nodebug(swapper_pg_dir),
 };
