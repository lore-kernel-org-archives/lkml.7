Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8158C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97896206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lowJ6to+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfGPIko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:40:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39344 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfGPIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:40:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so9744906pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kGFpGBaBujywG/+yNdtKwAUVS9nMgcc92lBSyKZrI68=;
        b=lowJ6to+9duq7wnyIimDqrrCBXEtL+JDfQ0dGTtoxIWPEs6jpOpziacWlDUYg2gkS8
         Kt9l7Z7Z9AJEL3xamalmyXQoFIqpOE2pQghsORT4QqKH8MNlOWp84J8ne77mGTALCUoT
         6nHfwMPUFSB4jjG2ShDvzgMtJWHNGORtdNhwwFms6+wa+cIbDP9KRqM1JmDHCV2p7Czt
         68AthgLox89BpC8HfEQ0jfe88zPjaFi5qy5LVsddszCRF31bMOAXjPqDCiCApi2IDOHF
         0M/OI7iuQKDIOsfs6OavUUzOAH8tNlvdB1j9VoLnAhvSzcQz5XLHd4NsXIW8kgc3vJIU
         BypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kGFpGBaBujywG/+yNdtKwAUVS9nMgcc92lBSyKZrI68=;
        b=HnupoAVckJD9wghTr2Ae83WgOtcU2SBY0pnGvwLOwDOdSxGk5Ad0o0t2Hsi+LyqQkr
         rkYLQT13zlKxMljr9a2RmQaOHxYVjtowb16IrruCWIjrbl6GI8FRtQH2uS+4N+H0Kxcf
         5637cqXHs36q3tlRXSSHEloLGvuMqWnBhfRjpR7nrWlc+uqDGVye7LUqxsKofdXS8SEU
         9St7JSuJX6auVxuwOkCbKExT1qwF9d4SxCtuQli7gFLSyaaeyxJwndsx7SyBDkTaORl/
         PC9Sc0Z4AvnQKnjThYrqil4mA4EN9ee7SgNzy3s42OX+dxoInaNvh6/RhgaQJxcnFi/I
         s4tQ==
X-Gm-Message-State: APjAAAXSWJ88aVBcvm4v4k+8UMgm70buwCgRp0bFeDXA6xiAsfkXbZAL
        GAu4AIIiGlgC+Ruo+jFqTQ==
X-Google-Smtp-Source: APXvYqyvAUbT1ctstMdEC7Ci7T7CEcd1SkAbsTKqkql67MyXZde1wmDZ902+qygPsYaamzjsOsP8DQ==
X-Received: by 2002:a17:902:1081:: with SMTP id c1mr34218710pla.200.1563266443274;
        Tue, 16 Jul 2019 01:40:43 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 185sm24689857pfa.170.2019.07.16.01.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 01:40:42 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Matteo Croce <mcroce@redhat.com>,
        Len Brown <len.brown@intel.com>, Pu Wen <puwen@hygon.cn>,
        Nicolai Stange <nstange@suse.de>,
        Hui Wang <john.wanghui@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/realmode: remove trampoline_status flag
Date:   Tue, 16 Jul 2019 16:40:24 +0800
Message-Id: <1563266424-3472-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, there is no reader of trampoline_status. It turns out that
after commit ce4b1b16502b ("x86/smpboot: Initialize secondary CPU only if
master CPU will wait for it"), trampoline_status is not needed any more.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Matteo Croce <mcroce@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Hui Wang <john.wanghui@huawei.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/realmode.h          | 1 -
 arch/x86/kernel/smpboot.c                | 5 -----
 arch/x86/realmode/rm/header.S            | 1 -
 arch/x86/realmode/rm/trampoline_32.S     | 3 ---
 arch/x86/realmode/rm/trampoline_64.S     | 3 ---
 arch/x86/realmode/rm/trampoline_common.S | 4 ----
 6 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index c536823..09ecc32 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -20,7 +20,6 @@ struct real_mode_header {
 	u32	ro_end;
 	/* SMP trampoline */
 	u32	trampoline_start;
-	u32	trampoline_status;
 	u32	trampoline_header;
 #ifdef CONFIG_X86_64
 	u32	trampoline_pgd;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd89..2ef10d9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -965,8 +965,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		       int *cpu0_nmi_registered)
 {
-	volatile u32 *trampoline_status =
-		(volatile u32 *) __va(real_mode_header->trampoline_status);
 	/* start_ip had better be page-aligned! */
 	unsigned long start_ip = real_mode_header->trampoline_start;
 
@@ -1058,9 +1056,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		}
 	}
 
-	/* mark "stuck" area as not stuck */
-	*trampoline_status = 0;
-
 	if (x86_platform.legacy.warm_reset) {
 		/*
 		 * Cleanup possible dangling ends...
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 30b0d30..6363761 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -19,7 +19,6 @@ GLOBAL(real_mode_header)
 	.long	pa_ro_end
 	/* SMP trampoline */
 	.long	pa_trampoline_start
-	.long	pa_trampoline_status
 	.long	pa_trampoline_header
 #ifdef CONFIG_X86_64
 	.long	pa_trampoline_pgd;
diff --git a/arch/x86/realmode/rm/trampoline_32.S b/arch/x86/realmode/rm/trampoline_32.S
index 2dd866c..1868b15 100644
--- a/arch/x86/realmode/rm/trampoline_32.S
+++ b/arch/x86/realmode/rm/trampoline_32.S
@@ -41,9 +41,6 @@ ENTRY(trampoline_start)
 
 	movl	tr_start, %eax	# where we need to go
 
-	movl	$0xA5A5A5A5, trampoline_status
-				# write marker for master knows we're running
-
 	/*
 	 * GDT tables in non default location kernel can be beyond 16MB and
 	 * lgdt will not be able to load the address as in real mode default
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 24bb759..aee2b45 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -49,9 +49,6 @@ ENTRY(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	movl	$0xA5A5A5A5, trampoline_status
-	# write marker for master knows we're running
-
 	# Setup stack
 	movl	$rm_stack_end, %esp
 
diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
index 7c70677..8d8208d 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -2,7 +2,3 @@
 	.section ".rodata","a"
 	.balign	16
 tr_idt: .fill 1, 6, 0
-
-	.bss
-	.balign	4
-GLOBAL(trampoline_status)	.space	4
-- 
2.7.5

