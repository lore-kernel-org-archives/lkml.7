Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D107F20835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZU4c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:56:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:56:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZhso-00067p-0b; Tue, 26 Nov 2019 21:56:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 476B51C1DA4;
        Tue, 26 Nov 2019 21:56:25 +0100 (CET)
Date:   Tue, 26 Nov 2019 20:56:25 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/iopl: Make 'struct tss_struct' constant size again
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157480178512.21853.8292665417533058103.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0bcd7762727dd8ba9b9b6f828e5a4cbd5da4f725
Gitweb:        https://git.kernel.org/tip/0bcd7762727dd8ba9b9b6f828e5a4cbd5da4f725
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 26 Nov 2019 21:49:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:49:04 +01:00

x86/iopl: Make 'struct tss_struct' constant size again

After the following commit:

  05b042a19443: ("x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise")

'struct cpu_entry_area' has to be Kconfig invariant, so that we always
have a matching CPU_ENTRY_AREA_PAGES size.

This commit added a CONFIG_X86_IOPL_IOPERM dependency to tss_struct:

  111e7b15cf10: ("x86/ioperm: Extend IOPL config to control ioperm() as well")

Which, if CONFIG_X86_IOPL_IOPERM is turned off, reduces the size of
cpu_entry_area by two pages, triggering the assert:

  ./include/linux/compiler.h:391:38: error: call to ‘__compiletime_assert_202’ declared with attribute error: BUILD_BUG_ON failed: (CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE

Simplify the Kconfig dependencies and make cpu_entry_area constant
size on 32-bit kernels again.

Fixes: 05b042a19443: ("x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b4e29d8..e51afbb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -411,9 +411,7 @@ struct tss_struct {
 	 */
 	struct x86_hw_tss	x86_tss;
 
-#ifdef CONFIG_X86_IOPL_IOPERM
 	struct x86_io_bitmap	io_bitmap;
-#endif
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
