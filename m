Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F5C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3A218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353904;
	bh=gPOzjF3Ah0fHfYf3kjNVVRihwvNCGPi5bn1dV1i4ZR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xw6jbXf/Y28vc5JJl1D4Jy/H5RXQRDA4a+piytPLw1YXY0kaGlictvCiGLGO/ROD3
	 w1cJCCQhJ6K9ifPeG3Whss3BSrQ/CrgcMUZI6EmIFhd85X3zI4hdNMocC7ROxEWJN2
	 ZLy0oacgeupiX9RA14TYygsatE8NhqOGFli5k+T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfDOSpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfDOSpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226262087C;
        Mon, 15 Apr 2019 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353899;
        bh=gPOzjF3Ah0fHfYf3kjNVVRihwvNCGPi5bn1dV1i4ZR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWUZEoT2xq/U2ZUF6zB82f7wyMs6Ize+yVaQDG8F/T+ZYxHkSIiika9LIo6IqSltB
         s4lYaMdcf33S8iJ8uKhqiQi0uRqZ9NUNf7JBTzKMd/CRLa97RhQHNjY1NXuhJKVY3w
         S8bu9mFZCjhOHJ1xYxhNPyX3bCXUZQN0OUoSVpwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/76] x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
Date:   Mon, 15 Apr 2019 20:43:27 +0200
Message-Id: <20190415183708.371743815@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 896c80bef4d3b357814a476663158aaf669d0fb3 ]

x86_64 restores system call MSRs in fix_processor_context(), and
x86_32 restored them along with segment registers.  The 64-bit
variant makes more sense, so move the 32-bit code to match the
64-bit code.

No side effects are expected to runtime behavior.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/65158f8d7ee64dd6bbc6c1c83b3b34aaa854e3ae.1513286253.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/power/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index ec923a1cdaf0..2335e8beb0cf 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -174,6 +174,9 @@ static void fix_processor_context(void)
 	write_gdt_entry(desc, GDT_ENTRY_TSS, &tss, DESC_TSS);
 
 	syscall_init();				/* This sets MSR_*STAR and related */
+#else
+	if (boot_cpu_has(X86_FEATURE_SEP))
+		enable_sep_cpu();
 #endif
 	load_TR_desc();				/* This does ltr */
 	load_mm_ldt(current->active_mm);	/* This does lldt */
@@ -233,12 +236,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	loadsegment(fs, ctxt->fs);
 	loadsegment(gs, ctxt->gs);
 	loadsegment(ss, ctxt->ss);
-
-	/*
-	 * sysenter MSRs
-	 */
-	if (boot_cpu_has(X86_FEATURE_SEP))
-		enable_sep_cpu();
 #else
 /* CONFIG_X86_64 */
 	asm volatile ("movw %0, %%ds" :: "r" (ctxt->ds));
-- 
2.19.1



