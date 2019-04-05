Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C465C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C54921726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="LGlrh8eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDEPft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:35:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38126 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:35:48 -0400
Received: by mail-yw1-f67.google.com with SMTP id m207so2453567ywd.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRh5+UVfRHA4K8teRGPBm4u1JCTr/upUGY1lyNvhnDo=;
        b=LGlrh8eL4C3rOZmFyxkrqY0vEshF+DNcrhCkAGmtSIZeFU6MRMwPqrBMF9WzR6+uqc
         nlUboJYfF6XEzs3COBuxj2PUR57ZD3OYQB0EnRnhi+yLd+9dq6QDQo6Z0mCp2G9fm5Qe
         HNFlLT7VSvh4hq2kewK99B+35RvSuFpnRh58Ej0nvnvTYp6Xf+scajjeRTFMGgyzedZc
         ZaLFFPXuIJlDPa3A1u4TCOHy4P3OiXbNALJtZGTYCgYta4bbYMMZu4Ks+NieoYC2QFtN
         H0WmfciwJxRC3AYZ32uDA/jqwJrIYc91j6YKTZ/0z9ibe5+qAtwV8wpxkpz0SdUa/OlJ
         2jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRh5+UVfRHA4K8teRGPBm4u1JCTr/upUGY1lyNvhnDo=;
        b=BR5vwS2KDaCMUPKhlA8pqXfx5PVOhQqR5soHV4o5XrQniojRF1cYZWfD6dA2qING7G
         99rzMdrIVnIVDXl+LY2ogn0vsdx9UhAiIJMGeLlrH/jrI4fS100XBl0x99O89/9sB1Ux
         BCSDZOP0/oKeLhvi5q1d3+5doikPge1QSDKTtn2EMAey98oedPBLFtEnhSbZ1+/2CCwN
         wTuiAuBhOHWPtUx+/vHxHI7IyyA/nPtyvUQdmx40kqxLu3NSdkbR90Lc/J6Tu+su5Coj
         DaXboa0XNiA6CtIjUft9y8aJzSrq+fwQsURkWZK1AbWiGxCyVMtz7L+4U6TNQlJL+jqp
         6LlQ==
X-Gm-Message-State: APjAAAX2maipPHyeS/Rgllp2Ek+3JMZTWLcDHIPTjV1iv79dD+WANj3+
        VsOJimuq9rFQOva5ufORS0oj4w==
X-Google-Smtp-Source: APXvYqx/28H90aXvhmOCfZEblDb9Z4bz8iWMyhTe7dfLnbwUwlT2xc7+yf8z1gbYNw+pnPF2Uwr8jg==
X-Received: by 2002:a81:3a82:: with SMTP id h124mr11084977ywa.263.1554478546892;
        Fri, 05 Apr 2019 08:35:46 -0700 (PDT)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:38ae:7ccc:265c:2d2c])
        by smtp.gmail.com with ESMTPSA id f133sm8274686ywb.107.2019.04.05.08.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:35:45 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/entry: re-enable interrupts before exiting
Date:   Fri,  5 Apr 2019 09:35:24 -0600
Message-Id: <20190405153525.29587-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel oopses in an interrupt, nothing re-enables interrupts:

Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at
./include/linux/percpu-rwsem.h:33
Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name:
lkdtm_xpfo_test
Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D
4.13.0-rc5+ #228
Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.1-1ubuntu1 04/01/2014
Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20

do_exit() expects to be called in a well-defined environment, so let's
re-enable interrupts after unwinding the stack, in case they were disabled.

Note that if any spinlocks are held, etc. we'll also get the above warning,
so this isn't a silver bullet. So, let's add a C helper in case someone
wants to add fancier lock busting or if we've forgotten to unwind something
else.

I've had to add back in the hack that Josh removed in 8c1f75587a18
("x86/entry/64: Add unwind hint annotations") with the loop after the call,
because for whatever reason without that I get a warning:

  AS      arch/x86/entry/entry_64.o
arch/x86/entry/entry_64.o: warning: objtool: .entry.text: unexpected end of section

It seems to actually work fine for me though, since the new helper is also
__noreturn. Perhaps there's a better way to do this?

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
---
I split this out from the XPFO series since it's mostly unrelated, and is
just a bug I found while working on that series.
---
 arch/x86/entry/common.c   | 10 ++++++++++
 arch/x86/entry/entry_32.S |  2 +-
 arch/x86/entry/entry_64.S |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7bc105f47d21..4e9c54e0495f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -427,3 +427,13 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 #endif
+
+void __noreturn __finish_rewind_stack_do_exit(long code)
+{
+	/*
+	 * If we oopsed in an interrupt handler, interrupts may be off. Let's turn
+	 * them back on before going back to "normal" code.
+	 */
+	 local_irq_enable();
+	 do_exit(code);
+}
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..095b8770e3b0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1507,6 +1507,6 @@ ENTRY(rewind_stack_do_exit)
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esi
 	leal	-TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
 
-	call	do_exit
+	call	__finish_rewind_stack_do_exit
 1:	jmp 1b
 END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..c6166133e45d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1672,5 +1672,6 @@ ENTRY(rewind_stack_do_exit)
 	leaq	-PTREGS_SIZE(%rax), %rsp
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
-	call	do_exit
+	call	__finish_rewind_stack_do_exit
+1:	jmp 1b
 END(rewind_stack_do_exit)
-- 
2.19.1

