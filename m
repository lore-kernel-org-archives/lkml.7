Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD98D21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239340;
	bh=BUTuqTi7EGNrt+/TX54y9XivWt9zhd35Hvj5orNffp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvExuchBlLI6J+3lGm+vwEucNWGhhDYx+dTi/KicfZFRCOF1/r5HMnGnztZNZ643E
	 cueyBAmDYZSbNTXT/DpymMt0EPT778Vhd7KGQd1jpZwPUH4ftZzEv/KKGsPheynynj
	 vU0je3TLxlM1kXmain5a2BDlyk6iS9lz3CwvNt1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfKHSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbfKHSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370E220865;
        Fri,  8 Nov 2019 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239330;
        bh=BUTuqTi7EGNrt+/TX54y9XivWt9zhd35Hvj5orNffp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o12XQ2hiU6rdy3vh6lzVwxB8KHkUpg/IAKKR1qf5kooJ2Dl9RHRFW9Ldvy3VqBIQN
         2bBW8ebAlla6BFYyehh7uU9HIl23bpHkpfj4F+UXyfxHQ8IUfcNAjuz3VdIZr7pGLE
         U1y71kJ3RIKBuQzlf0dK+V2SaCVAPqjDKIQEV5Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, Ard Biesheuvel" 
        <ardb@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 41/75] ARM: bugs: prepare processor bug infrastructure
Date:   Fri,  8 Nov 2019 19:49:58 +0100
Message-Id: <20191108174749.239886670@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit a5b9177f69329314721aa7022b7e69dab23fa1f0 upstream.

Prepare the processor bug infrastructure so that it can be expanded to
check for per-processor bugs.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/bugs.h |    4 ++--
 arch/arm/kernel/Makefile    |    1 +
 arch/arm/kernel/bugs.c      |    9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -10,10 +10,10 @@
 #ifndef __ASM_BUGS_H
 #define __ASM_BUGS_H
 
-#ifdef CONFIG_MMU
 extern void check_writebuffer_bugs(void);
 
-#define check_bugs() check_writebuffer_bugs()
+#ifdef CONFIG_MMU
+extern void check_bugs(void);
 #else
 #define check_bugs() do { } while (0)
 #endif
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -30,6 +30,7 @@ else
 obj-y		+= entry-armv.o
 endif
 
+obj-$(CONFIG_MMU)		+= bugs.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
--- /dev/null
+++ b/arch/arm/kernel/bugs.c
@@ -0,0 +1,9 @@
+// SPDX-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <asm/bugs.h>
+#include <asm/proc-fns.h>
+
+void __init check_bugs(void)
+{
+	check_writebuffer_bugs();
+}


