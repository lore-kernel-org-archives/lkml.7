Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F644C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF7420665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055367;
	bh=FHvq+boAvDdM7njmaZ+/0r16I2kG0EUYTXG9Pc49Ueo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZStw2y56ikf19+fAjb0PpDIKdAyGr90hmcnpAXDUg3R5YO1tVtKINKHwciFwKHDYh
	 JmtSl+yc3VY6RS5gHxchtZocx5KfJDZhFgLaUE7roVgn2zlq+5uVYM053Q0u3eqtMJ
	 qAXhtb1AI946dpFjsf+JakexL7MMZtK1KaB/UwRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFTSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfFTSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:02:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 722762082C;
        Thu, 20 Jun 2019 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053747;
        bh=FHvq+boAvDdM7njmaZ+/0r16I2kG0EUYTXG9Pc49Ueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOFuUVjO3weBe5r9lwrovPlVOmeXYFNFUWP+9QELTXrwoqOH/IUaOvPrClO0qD+eT
         nPxefsLC4oT9i9ghvn0+JH403NFpcTqLO+7nNLeyqee3C3vmcMi36w1G3LKsGcw0L2
         5koLM45+oxmOJ3RKuL8DLNowxqAwMo2h8h6DI3zY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stefan Agner <stefan@agner.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 005/117] ARM: prevent tracing IPI_CPU_BACKTRACE
Date:   Thu, 20 Jun 2019 19:55:39 +0200
Message-Id: <20190620174352.289718734@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit be167862ae7dd85c56d385209a4890678e1b0488 ]

Patch series "compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING", v3.

This patch (of 11):

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type as
triggered by raise_nmi():

  arch/arm/kernel/smp.c: In function 'raise_nmi':
  arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
    trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace.  For clarification, I'm
also adding a two new code comments describing how this one is special.

The warning appears to have shown up after commit e7273ff49acf ("ARM:
8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which changed the
number assignment from '15' to '8', but as far as I can tell has existed
since the IPI tracepoints were first introduced.  If we decide to
backport this patch to stable kernels, we probably need to backport
e7273ff49acf as well.

[yamada.masahiro@socionext.com: rebase on v5.1-rc1]
Link: http://lkml.kernel.org/r/20190423034959.13525-2-yamada.masahiro@socionext.com
Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Borislav Petkov <bp@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/smp.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 3d7351c844aa..2fd0a2619b0b 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7a5dc011c523..deea60f01d24 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -75,6 +75,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -801,7 +805,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.20.1



