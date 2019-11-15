Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6BAC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D92073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKOVNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44608 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKOVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitN-0007Qq-SH; Fri, 15 Nov 2019 22:12:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2528B1C18D3;
        Fri, 15 Nov 2019 22:12:30 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Avoid bitmap allocation if no permissions are set
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.404509322@linutronix.de>
References: <20191113210104.404509322@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385235012.12247.1247139198046995586.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     5487da6bf0775d996352442b89a8defbd671b4ae
Gitweb:        https://git.kernel.org/tip/5487da6bf0775d996352442b89a8defbd671b4ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:02 +01:00

x86/ioperm: Avoid bitmap allocation if no permissions are set

If ioperm() is invoked the first time and the @turn_on argument is 0, then
there is no point to allocate a bitmap just to clear permissions which are
not set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.404509322@linutronix.de

---
 arch/x86/kernel/ioport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index ca6aa1e..80fa36b 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -36,6 +36,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 */
 	bitmap = t->io_bitmap_ptr;
 	if (!bitmap) {
+		/* No point to allocate a bitmap just to clear permissions */
+		if (!turn_on)
+			return 0;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap)
 			return -ENOMEM;
