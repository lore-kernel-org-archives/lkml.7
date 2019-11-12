Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27747C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67F20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKLJZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:25:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:25:36 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUSQQ-0006xt-PU; Tue, 12 Nov 2019 10:25:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5ADC41C0084;
        Tue, 12 Nov 2019 10:25:26 +0100 (CET)
Date:   Tue, 12 Nov 2019 09:25:26 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] m68k: Convert missed RODATA to RO_DATA
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-m68k@lists.linux-m68k.org, Sam Creasey <sammy@sammy.net>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <201911110920.5840E9AF1@keescook>
References: <201911110920.5840E9AF1@keescook>
MIME-Version: 1.0
Message-ID: <157355072603.29376.646015580479750741.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     de7156689d69e9861d9ddc54a9dea623c25020c5
Gitweb:        https://git.kernel.org/tip/de7156689d69e9861d9ddc54a9dea623c25020c5
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Mon, 11 Nov 2019 09:22:00 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Nov 2019 09:56:51 +01:00

m68k: Convert missed RODATA to RO_DATA

I missed two instances of the old RODATA macro (seems I was searching
for vmlinux.lds* not vmlinux*lds*). Fix both instances and double-check
the entire tree for other "RODATA" instances in linker scripts.

Fixes: c82318254d15 ("vmlinux.lds.h: Replace RODATA with RO_DATA")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Sam Creasey <sammy@sammy.net>
Link: https://lkml.kernel.org/r/201911110920.5840E9AF1@keescook
---
 arch/m68k/kernel/vmlinux-std.lds  | 2 +-
 arch/m68k/kernel/vmlinux-sun3.lds | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index 6e7eb49..4d33da4 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -31,7 +31,7 @@ SECTIONS
 
   _sdata = .;			/* Start of data section */
 
-  RODATA
+  RO_DATA(4096)
 
   RW_DATA(16, PAGE_SIZE, THREAD_SIZE)
 
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index 1a0ad6b..87d9f4d 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -24,7 +24,7 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
-	RODATA
+	RO_DATA(4096)
 
   _etext = .;			/* End of text section */
 
