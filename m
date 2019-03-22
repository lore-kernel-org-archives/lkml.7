Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4152082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256927;
	bh=5KsjDBw4pFj88ficVFtwdfiYmDYAQ5j09/yBFxIbCus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EfluXz+hzzbZJ17/wPb/K5q0u1mUdK8UIkOQ83B1Q8t9uyLvEwLgtjggWlOJYsFzY
	 N5W4BPzVAjtB9o/rAzllU3WFomoVGloNA7Wc5YtoImHBBK04vUzM1Q5oVvlbJQtGj3
	 oEa3jNu+pWbKHEDm2g+9LJj3VJbUalq16qIQUfkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfCVMP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390052AbfCVMPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926CA21900;
        Fri, 22 Mar 2019 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256923;
        bh=5KsjDBw4pFj88ficVFtwdfiYmDYAQ5j09/yBFxIbCus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgiYAwVJlpK8pt91zvJbXBrXfVufwh/vlN0D4scXVJ4EwHwdfXcmrLP8rlaiqxHZ7
         hzp+EP/MeynDhSJCYnng4gm7tyDeFe0dBCbILvUoHmSGf1krWk1LYdQFg0cTt3rk+q
         Nteovneyfly8W/kW2wFEuvEZaDDleaAYDjharlI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5.0 077/238] s390/setup: fix early warning messages
Date:   Fri, 22 Mar 2019 12:14:56 +0100
Message-Id: <20190322111303.154582631@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit 8727638426b0aea59d7f904ad8ddf483f9234f88 upstream.

The setup_lowcore() function creates a new prefix page for the boot CPU.
The PSW mask for the system_call, external interrupt, i/o interrupt and
the program check handler have the DAT bit set in this new prefix page.

At the time setup_lowcore is called the system still runs without virtual
address translation, the paging_init() function creates the kernel page
table and loads the CR13 with the kernel ASCE.

Any code between setup_lowcore() and the end of paging_init() that has
a BUG or WARN statement will create a program check that can not be
handled correctly as there is no kernel page table yet.

To allow early WARN statements initially setup the lowcore with DAT off
and set the DAT bit only after paging_init() has completed.

Cc: stable@vger.kernel.org
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/setup.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -369,7 +369,7 @@ void __init arch_call_rest_init(void)
 		: : [_frame] "a" (frame));
 }
 
-static void __init setup_lowcore(void)
+static void __init setup_lowcore_dat_off(void)
 {
 	struct lowcore *lc;
 
@@ -380,19 +380,16 @@ static void __init setup_lowcore(void)
 	lc = memblock_alloc_low(sizeof(*lc), sizeof(*lc));
 	lc->restart_psw.mask = PSW_KERNEL_BITS;
 	lc->restart_psw.addr = (unsigned long) restart_int_handler;
-	lc->external_new_psw.mask = PSW_KERNEL_BITS |
-		PSW_MASK_DAT | PSW_MASK_MCHECK;
+	lc->external_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->external_new_psw.addr = (unsigned long) ext_int_handler;
 	lc->svc_new_psw.mask = PSW_KERNEL_BITS |
-		PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
+		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	lc->svc_new_psw.addr = (unsigned long) system_call;
-	lc->program_new_psw.mask = PSW_KERNEL_BITS |
-		PSW_MASK_DAT | PSW_MASK_MCHECK;
+	lc->program_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->program_new_psw.addr = (unsigned long) pgm_check_handler;
 	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
 	lc->mcck_new_psw.addr = (unsigned long) mcck_int_handler;
-	lc->io_new_psw.mask = PSW_KERNEL_BITS |
-		PSW_MASK_DAT | PSW_MASK_MCHECK;
+	lc->io_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->io_new_psw.addr = (unsigned long) io_int_handler;
 	lc->clock_comparator = clock_comparator_max;
 	lc->nodat_stack = ((unsigned long) &init_thread_union)
@@ -452,6 +449,17 @@ static void __init setup_lowcore(void)
 	lowcore_ptr[0] = lc;
 }
 
+static void __init setup_lowcore_dat_on(void)
+{
+	struct lowcore *lc;
+
+	lc = lowcore_ptr[0];
+	lc->external_new_psw.mask |= PSW_MASK_DAT;
+	lc->svc_new_psw.mask |= PSW_MASK_DAT;
+	lc->program_new_psw.mask |= PSW_MASK_DAT;
+	lc->io_new_psw.mask |= PSW_MASK_DAT;
+}
+
 static struct resource code_resource = {
 	.name  = "Kernel code",
 	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
@@ -1072,7 +1080,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	setup_resources();
-	setup_lowcore();
+	setup_lowcore_dat_off();
 	smp_fill_possible_mask();
 	cpu_detect_mhz_feature();
         cpu_init();
@@ -1085,6 +1093,12 @@ void __init setup_arch(char **cmdline_p)
 	 */
         paging_init();
 
+	/*
+	 * After paging_init created the kernel page table, the new PSWs
+	 * in lowcore can now run with DAT enabled.
+	 */
+	setup_lowcore_dat_on();
+
         /* Setup default console */
 	conmode_default();
 	set_preferred_console();


