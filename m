Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B089C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5159E204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HinVinbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfEGIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:52:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35137 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfEGIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:52:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so7727724pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dNAJ+SVyrYLoiqrIO4nUnSzvAgENUeMlXwgh+RKKKqY=;
        b=HinVinbhksnXiGKGe6/Z5KhseSdzkjW0LKmh4Qb82xsP4qx+TZ/0u7bbxysEIRZdiD
         oyJxfuIdq0w4hMwh2CiRIZ13Fo4EaqNWX/SEccRAp5p8waCu/UbpTiEQDVkC8ZFrpMMs
         semuD00958mxKyjUHfMQhpWsRihLznGs1C+occEaYwFnAXiajXU2KgwkMecyCD420sB+
         F0SEj2h8+v8F/rXNc1Ypvn8SOPydvcIkuO1gDV5L+rZuRHkNpwFknfMHfTn867K67V1S
         3JkHR1MoMheoPeHIwv9uCpj5y6oqhai+mdAhgDCJBVx+7lAc4vJsEj88eTzQX8KlZOkr
         IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dNAJ+SVyrYLoiqrIO4nUnSzvAgENUeMlXwgh+RKKKqY=;
        b=Zg8AxYDNTqGBdDfH3bGWEALtyoE/gFRNFJXmHWanIJLK3Kf3NlAEj4kbQ1cqfECy3M
         afT8e7L/IQSetYcMyUFzl2qMEObWzkvJXEA9V+ryqG1J5YEXNrsj8SPXFyUs23nCunkc
         OIM53BwnMVIDQuGExY0PbyHf0E+ieyCl6m2d82VSR3+hYRZZT0a3ufx6FMAh6mxfLSIb
         I2tHjTEoBSfNn2I930KRhOlqYb2Gy577PIjEMxKNEDj6Nppz/NsqH9KR7KmJtwflVDSK
         rNcqwiI/429xsOEf7I8CC9bVdBlwQ2exxkVmGQ9qezawdFobwdiAXlS/Qll/MJz4fYLu
         h2PQ==
X-Gm-Message-State: APjAAAXNXtIaJ7KfDaioAni6TGMJKegWJpE71O/RZHUOcefxgMxBDLSZ
        +EJ5Z6Xti7l9yHt1vwJUrA==
X-Google-Smtp-Source: APXvYqyYVyAzMP3ePrQJL3aJiwTcqYjrCiPRG1uqWAj1YxWJdXzkmUj+Q3c09yJL5O5+xO276BogoQ==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr40439220pfm.251.1557219175650;
        Tue, 07 May 2019 01:52:55 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h127sm16502548pgc.31.2019.05.07.01.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 01:52:54 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Wei Huang <wei@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/idt: split out idt routines
Date:   Tue,  7 May 2019 16:52:30 +0800
Message-Id: <1557219151-32212-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557219151-32212-1-git-send-email-kernelfans@gmail.com>
References: <1557219151-32212-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some idt routines can be reused in early boot stage. Splitting them out.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Wei Huang <wei@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/idt.h | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c      | 58 +----------------------------------------
 2 files changed, 65 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/include/asm/idt.h

diff --git a/arch/x86/include/asm/idt.h b/arch/x86/include/asm/idt.h
new file mode 100644
index 0000000..147f128
--- /dev/null
+++ b/arch/x86/include/asm/idt.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IDT_H
+#define _ASM_X86_IDT_H
+
+#include <asm/desc_defs.h>
+
+struct idt_data {
+	unsigned int	vector;
+	unsigned int	segment;
+	struct idt_bits	bits;
+	const void	*addr;
+};
+
+#define DPL0		0x0
+#define DPL3		0x3
+
+#define DEFAULT_STACK	0
+
+#define G(_vector, _addr, _ist, _type, _dpl, _segment)	\
+	{						\
+		.vector		= _vector,		\
+		.bits.ist	= _ist,			\
+		.bits.type	= _type,		\
+		.bits.dpl	= _dpl,			\
+		.bits.p		= 1,			\
+		.addr		= _addr,		\
+		.segment	= _segment,		\
+	}
+
+/* Interrupt gate */
+#define INTG(_vector, _addr)				\
+	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+
+/* System interrupt gate */
+#define SYSG(_vector, _addr)				\
+	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
+
+/* Interrupt gate with interrupt stack */
+#define ISTG(_vector, _addr, _ist)			\
+	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+
+/* System interrupt gate with interrupt stack */
+#define SISTG(_vector, _addr, _ist)			\
+	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL3, __KERNEL_CS)
+
+/* Task gate */
+#define TSKG(_vector, _gdt)				\
+	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
+
+static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
+{
+	unsigned long addr = (unsigned long) d->addr;
+
+	gate->offset_low	= (u16) addr;
+	gate->segment		= (u16) d->segment;
+	gate->bits		= d->bits;
+	gate->offset_middle	= (u16) (addr >> 16);
+#ifdef CONFIG_X86_64
+	gate->offset_high	= (u32) (addr >> 32);
+	gate->reserved		= 0;
+#endif
+}
+
+#endif
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 01adea2..80b811a 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -9,49 +9,7 @@
 #include <asm/proto.h>
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
-
-struct idt_data {
-	unsigned int	vector;
-	unsigned int	segment;
-	struct idt_bits	bits;
-	const void	*addr;
-};
-
-#define DPL0		0x0
-#define DPL3		0x3
-
-#define DEFAULT_STACK	0
-
-#define G(_vector, _addr, _ist, _type, _dpl, _segment)	\
-	{						\
-		.vector		= _vector,		\
-		.bits.ist	= _ist,			\
-		.bits.type	= _type,		\
-		.bits.dpl	= _dpl,			\
-		.bits.p		= 1,			\
-		.addr		= _addr,		\
-		.segment	= _segment,		\
-	}
-
-/* Interrupt gate */
-#define INTG(_vector, _addr)				\
-	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL0, __KERNEL_CS)
-
-/* System interrupt gate */
-#define SYSG(_vector, _addr)				\
-	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
-
-/* Interrupt gate with interrupt stack */
-#define ISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
-
-/* System interrupt gate with interrupt stack */
-#define SISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL3, __KERNEL_CS)
-
-/* Task gate */
-#define TSKG(_vector, _gdt)				\
-	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
+#include <asm/idt.h>
 
 /*
  * Early traps running on the DEFAULT_STACK because the other interrupt
@@ -202,20 +160,6 @@ const struct desc_ptr debug_idt_descr = {
 };
 #endif
 
-static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
-{
-	unsigned long addr = (unsigned long) d->addr;
-
-	gate->offset_low	= (u16) addr;
-	gate->segment		= (u16) d->segment;
-	gate->bits		= d->bits;
-	gate->offset_middle	= (u16) (addr >> 16);
-#ifdef CONFIG_X86_64
-	gate->offset_high	= (u32) (addr >> 32);
-	gate->reserved		= 0;
-#endif
-}
-
 static void
 idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sys)
 {
-- 
2.7.4

