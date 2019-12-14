Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE2C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC5520724
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfLNHNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:13:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfLNHNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:13:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ig1bm-0003Fj-M6; Sat, 14 Dec 2019 08:12:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D2691C047B;
        Sat, 14 Dec 2019 08:12:56 +0100 (CET)
Date:   Sat, 14 Dec 2019 07:12:55 -0000
From:   "tip-bot2 for Ilie Halip" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Discard .eh_frame sections
Cc:     Borislav Petkov <bp@alien8.de>, Ilie Halip <ilie.halip@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126144545.19354-1-ilie.halip@gmail.com>
References: <20191126144545.19354-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Message-ID: <157630757591.30329.774656997098904968.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     163159aad74d3763b350861b879b41e8f64121fc
Gitweb:        https://git.kernel.org/tip/163159aad74d3763b350861b879b41e8f64121fc
Author:        Ilie Halip <ilie.halip@gmail.com>
AuthorDate:    Tue, 26 Nov 2019 16:45:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 13 Dec 2019 11:45:59 +01:00

x86/boot: Discard .eh_frame sections

When using GCC as compiler and LLVM's lld as linker, linking setup.elf
fails:

   LD      arch/x86/boot/setup.elf
  ld.lld: error: init sections too big!

This happens because GCC generates .eh_frame sections for most of the
files in that directory, then ld.lld places the merged section before
__end_init, triggering an assert in the linker script.

Fix this by discarding the .eh_frame sections, as suggested by Boris.
The kernel proper linker script discards them too.

 [ bp: Going back in history, 64-bit kernel proper has been discarding
   .eh_frame since 2002:

    commit acca80acefe20420e69561cf55be64f16c34ea97
    Author: Andi Kleen <ak@muc.de>
    Date:   Tue Oct 29 23:54:35 2002 -0800

      [PATCH] x86-64 updates for 2.5.44

      ...

    - Remove the .eh_frame on linking. This saves several hundred KB in the
      bzImage
 ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: clang-built-linux@googlegroups.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lore.kernel.org/lkml/20191118175223.GM6363@zn.tnic/
Link: https://github.com/ClangBuiltLinux/linux/issues/760
Link: https://lkml.kernel.org/r/20191126144545.19354-1-ilie.halip@gmail.com
---
 arch/x86/boot/setup.ld | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 0149e41..3da1c37 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -51,7 +51,10 @@ SECTIONS
 	. = ALIGN(16);
 	_end = .;
 
-	/DISCARD/ : { *(.note*) }
+	/DISCARD/	: {
+		*(.eh_frame)
+		*(.note*)
+	}
 
 	/*
 	 * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
