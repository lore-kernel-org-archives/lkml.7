Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C78C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259262063A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kfwiml/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKRRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:35:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfKRRfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:35:16 -0500
Received: from zn.tnic (p200300EC2F27B5003D22FC05E431AFF8.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:3d22:fc05:e431:aff8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46CAF1EC072D;
        Mon, 18 Nov 2019 18:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574098511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ndkDKtfR+XvFiIIHQaaiR63mI1Ov3k+RZNEVbDcRAoA=;
        b=kfwiml/3cso9RddEMd/IeRS8ROF89RgW4TqWMEUjdx6ulAZVkpQGmrFl4pw23Bwr1TaCmb
        RUuzX5HAo8sm+UKhmzA/gA1/ta9v+vSqCTbo/Ikdtk2fGtEbUQJeI9phyPcjeevQ1seI0K
        OjWE1CDmhGwJDT8dPM1KHuFd0utIQ5Y=
Date:   Mon, 18 Nov 2019 18:35:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ftrace: Mark ftrace_modify_code_direct() __ref
Message-ID: <20191118173510.GK6363@zn.tnic>
References: <20191111132457.761255803@infradead.org>
 <157381099055.29467.10982011694493970062.tip-bot2@tip-bot2>
 <20191116204607.GC23231@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191116204607.GC23231@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 09:46:07PM +0100, Borislav Petkov wrote:
> WARNING: vmlinux.o(.text+0x8c0b1): Section mismatch in reference from the function ftrace_modify_code_direct() to the function .init.text:text_poke_early()
> The function ftrace_modify_code_direct() references
> the function __init text_poke_early().
> This is often because ftrace_modify_code_direct lacks a __init 
> annotation or the annotation of text_poke_early is wrong.
> 
> FATAL: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> make[1]: *** [scripts/Makefile.modpost:66: __modpost] Error 1
> make: *** [Makefile:1077: vmlinux] Error 2

Here's a fix suggested by Peter:

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/ftrace: Mark ftrace_modify_code_direct() __ref

... because it calls the .init.text function text_poke_early(). That is
ok because it does call that function early, during boot.

Fixes: 9706f7c3531f ("x86/ftrace: Use text_poke()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191116204607.GC23231@zn.tnic
---
 arch/x86/kernel/ftrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 2a179fb35cd1..108ee96f8b66 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -99,7 +99,12 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
 	return 0;
 }
 
-static int
+/*
+ * Marked __ref because it calls text_poke_early() which is .init.text. That is
+ * ok because that call will happen early, during boot, when .init sections are
+ * still present.
+ */
+static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 			  const char *new_code)
 {
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
