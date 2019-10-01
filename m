Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F7BECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9022070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfJAUTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:19:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJAUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:18:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFObe-0004Og-KL; Tue, 01 Oct 2019 22:18:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 328C41C03AB;
        Tue,  1 Oct 2019 22:18:46 +0200 (CEST)
Date:   Tue, 01 Oct 2019 20:18:45 -0000
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/realmode: Explicitly set entry point via ENTRY in
 linker script
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Smith <Peter.Smith@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com, grimar@accesssoftek.com,
        Ingo Molnar <mingo@redhat.com>, maskray@google.com,
        ruiu@google.com, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190925180908.54260-1-ndesaulniers@google.com>
References: <20190925180908.54260-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <156996112595.9978.10016104223665574360.tip-bot2@tip-bot2>
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

Commit-ID:     6a181e333954a26f46596b36f82abd14743570fd
Gitweb:        https://git.kernel.org/tip/6a181e333954a26f46596b36f82abd14743570fd
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Wed, 25 Sep 2019 11:09:06 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 22:13:17 +02:00

x86/realmode: Explicitly set entry point via ENTRY in linker script

Linking with ld.lld via

$ make LD=ld.lld

produces the warning:

  ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000

Linking with ld.bfd shows the default entry is 0x1000:

$ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
  Entry point address:               0x1000

While ld.lld is being pedantic, just set the entry point explicitly,
instead of depending on the implicit default. The symbol pa_text_start
refers to the start of the .text section, which may not be at 0x1000 if
the preceding sections listed in arch/x86/realmode/rm/realmode.lds.S
were large enough. This matches behavior in arch/x86/boot/setup.ld.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Peter Smith <Peter.Smith@arm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: clang-built-linux@googlegroups.com
Cc: grimar@accesssoftek.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: maskray@google.com
Cc: ruiu@google.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190925180908.54260-1-ndesaulniers@google.com
Link: https://github.com/ClangBuiltLinux/linux/issues/216
---
 arch/x86/realmode/rm/realmode.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 3bb9808..64d135d 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -11,6 +11,7 @@
 
 OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
+ENTRY(pa_text_start)
 
 SECTIONS
 {
