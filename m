Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F4C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6A206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKOLvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:51:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfKOLvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:51:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVa8U-0006c7-Lz; Fri, 15 Nov 2019 12:51:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5250F1C08AC;
        Fri, 15 Nov 2019 12:51:34 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:51:33 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build/vdso: Remove meaningless CFLAGS_REMOVE_*.o
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191114154922.30365-1-yamada.masahiro@socionext.com>
References: <20191114154922.30365-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Message-ID: <157381869387.29467.2747574809933300571.tip-bot2@tip-bot2>
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

Commit-ID:     66584ea6b70a6cbae661292702e56a07580dbbd4
Gitweb:        https://git.kernel.org/tip/66584ea6b70a6cbae661292702e56a07580dbbd4
Author:        Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate:    Fri, 15 Nov 2019 00:49:22 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 15 Nov 2019 12:07:32 +01:00

x86/build/vdso: Remove meaningless CFLAGS_REMOVE_*.o

CFLAGS_REMOVE_*.o syntax is used to drop particular flags when
building objects from C files. It has no effect for assembly files.

vdso-note.o is compiled from the assembly file, vdso-note.S, hence
CFLAGS_REMOVE_vdso-note.o is meaningless.

Neither vvar.c nor vvar.S is found in the vdso directory. Since there
is no source file to create vvar.o, CFLAGS_REMOVE_vvar.o is also
meaningless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191114154922.30365-1-yamada.masahiro@socionext.com
---
 arch/x86/entry/vdso/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f21541..2b75e80 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -87,11 +87,9 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
-CFLAGS_REMOVE_vvar.o = -pg
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
