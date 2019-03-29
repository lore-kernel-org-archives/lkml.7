Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BA8206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lM2mYK0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfC2Qii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:38:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48334 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbfC2Qid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:38:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44W6qp2YXLz9tyQb;
        Fri, 29 Mar 2019 17:38:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lM2mYK0C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 472DEqQ7keEp; Fri, 29 Mar 2019 17:38:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qp1SGLz9tyQP;
        Fri, 29 Mar 2019 17:38:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553877510; bh=9v4QWxkm63JjwppE7+ziKlmj91tDM+OAPGi/cz6kzSI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=lM2mYK0C34iCTH31geXqXHATBrY2t+Yv3sU001H7zljmQZ8bmbOIsTa9TLG6nrlwT
         yxIzjnH5gK7gX8B2l7b5y+s8GK7EFdTXuNgRfAyNzsYgT8nfn7mwRhVPioN/1HXNhl
         o7iScimrd8+WbiwiHPVTfyvFreIij76ewzvR9qFk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C87838B93D;
        Fri, 29 Mar 2019 17:38:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id q6zXybNXPN9S; Fri, 29 Mar 2019 17:38:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A34818B938;
        Fri, 29 Mar 2019 17:38:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8E9AF6FC56; Fri, 29 Mar 2019 16:38:31 +0000 (UTC)
Message-Id: <80da43c3de25a07b22e568bdb67afe215c379589.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/17] powerpc/32: enter syscall with MSR_EE inconditionaly
 set
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 16:38:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscalls are expected to be entered with MSR_EE set. Lets
make it inconditional by forcing MSR_EE on syscalls.

This patch adds EXC_XFER_SYS for that.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[splited out from benh RFC patch]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S        | 2 +-
 arch/powerpc/kernel/head_32.h        | 4 ++++
 arch/powerpc/kernel/head_40x.S       | 2 +-
 arch/powerpc/kernel/head_44x.S       | 2 +-
 arch/powerpc/kernel/head_8xx.S       | 2 +-
 arch/powerpc/kernel/head_booke.h     | 4 ++++
 arch/powerpc/kernel/head_fsl_booke.S | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 577d196c26f2..6e1b0897f5da 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -367,7 +367,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
 	DO_KVM  0xc00
 SystemCall:
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
 	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index aa0131bb09b5..7221418a883f 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -123,6 +123,10 @@
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
 
+#define EXC_XFER_SYS(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
 #define EXC_XFER_EE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
 			  ret_from_except_full)
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index cce9bd33a176..1a80a3e45e44 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -350,7 +350,7 @@ _ENTRY(saved_ksp_limit)
 /* 0x0C00 - System Call Exception */
 	START_EXCEPTION(0x0C00,	SystemCall)
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37117ab11584..9cc01948651f 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -283,7 +283,7 @@ interrupt_base:
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
 	NORMAL_EXCEPTION_PROLOG(BOOKE_INTERRUPT_SYSCALL)
-	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
+	EXC_XFER_SYS(0x0c00, DoSyscall)
 
 	/* Auxiliary Processor Unavailable Interrupt */
 	EXCEPTION(0x2020, BOOKE_INTERRUPT_AP_UNAVAIL, \
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 7b76ad1b9620..19ad6484f198 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -186,7 +186,7 @@ Alignment:
 	. = 0xc00
 SystemCall:
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
 	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 1b22a8dea399..612f54ba1125 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -251,6 +251,10 @@ END_BTB_FLUSH_SECTION
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
 
+#define EXC_XFER_SYS(n, hdlr)						\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
 #define EXC_XFER_EE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
 			  ret_from_except_full)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 32332e24e421..e77a2ed94642 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -411,7 +411,7 @@ interrupt_base:
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
 	NORMAL_EXCEPTION_PROLOG(SYSCALL)
-	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
+	EXC_XFER_SYS(0x0c00, DoSyscall)
 
 	/* Auxiliary Processor Unavailable Interrupt */
 	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
-- 
2.13.3

