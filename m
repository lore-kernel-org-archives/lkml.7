Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65CC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C81222D3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfJEKPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:15:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39721 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfJEKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:15:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iGh5W-0001FC-Ee; Sat, 05 Oct 2019 12:14:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B74151C073C;
        Sat,  5 Oct 2019 12:14:57 +0200 (CEST)
Date:   Sat, 05 Oct 2019 10:14:57 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Reorder early variables
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191003095238.29831-1-jslaby@suse.cz>
References: <20191003095238.29831-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157027049768.9978.11005637397803915038.tip-bot2@tip-bot2>
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

Commit-ID:     1a8770b746bd05ef68217989cd723b2c24d2208d
Gitweb:        https://git.kernel.org/tip/1a8770b746bd05ef68217989cd723b2c24d2208d
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Thu, 03 Oct 2019 11:52:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 05 Oct 2019 12:11:00 +02:00

x86/asm: Reorder early variables

Moving early_recursion_flag (4 bytes) after early_level4_pgt (4k) and
early_dynamic_pgts (256k) saves 4k which are used for alignment of
early_level4_pgt after early_recursion_flag.

The real improvement is merely on the source code side. Previously it
was:
* __INITDATA + .balign
* early_recursion_flag variable
* a ton of CPP MACROS
* __INITDATA (again)
* early_top_pgt and early_recursion_flag variables
* .data

Now, it is a bit simpler:
* a ton of CPP MACROS
* __INITDATA + .balign
* early_top_pgt and early_recursion_flag variables
* early_recursion_flag variable
* .data

On the binary level the change looks like this:
Before:
 (sections)
  12 .init.data    00042000  0000000000000000  0000000000000000 00008000  2**12
 (symbols)
  000000       4 OBJECT  GLOBAL DEFAULT   22 early_recursion_flag
  001000    4096 OBJECT  GLOBAL DEFAULT   22 early_top_pgt
  002000 0x40000 OBJECT  GLOBAL DEFAULT   22 early_dynamic_pgts

After:
 (sections)
  12 .init.data    00041004  0000000000000000  0000000000000000 00008000  2**12
 (symbols)
  000000    4096 OBJECT  GLOBAL DEFAULT   22 early_top_pgt
  001000 0x40000 OBJECT  GLOBAL DEFAULT   22 early_dynamic_pgts
  041000       4 OBJECT  GLOBAL DEFAULT   22 early_recursion_flag

So the resulting vmlinux is smaller by 4k with my toolchain as many
other variables can be placed after early_recursion_flag to fill the
rest of the page. Note that this is only .init data, so it is freed
right after being booted anyway. Savings on-disk are none -- compression
of zeros is easy, so the size of bzImage is the same pre and post the
change.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191003095238.29831-1-jslaby@suse.cz
---
 arch/x86/kernel/head_64.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f3d3e96..f00d7c0 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -335,12 +335,6 @@ early_idt_handler_common:
 	jmp restore_regs_and_return_to_kernel
 END(early_idt_handler_common)
 
-	__INITDATA
-
-	.balign 4
-GLOBAL(early_recursion_flag)
-	.long 0
-
 #define NEXT_PAGE(name) \
 	.balign	PAGE_SIZE; \
 GLOBAL(name)
@@ -375,6 +369,8 @@ GLOBAL(name)
 	.endr
 
 	__INITDATA
+	.balign 4
+
 NEXT_PGD_PAGE(early_top_pgt)
 	.fill	512,8,0
 	.fill	PTI_USER_PGD_FILL,8,0
@@ -382,6 +378,9 @@ NEXT_PGD_PAGE(early_top_pgt)
 NEXT_PAGE(early_dynamic_pgts)
 	.fill	512*EARLY_DYNAMIC_PAGE_TABLES,8,0
 
+GLOBAL(early_recursion_flag)
+	.long 0
+
 	.data
 
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
