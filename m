Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D7C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8C2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122212;
	bh=FDrlU1PiRBI+pftJbsQpLFHChJmTaWWY3GczLZA6tEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pUqMcCZGgh3NAXSEw1J4qx47YYU60QL2uIoa8KM0LIkko1s8NJPbVowHhLDtxfBTg
	 B23XS877wPbwfq6uqleRLNRiL1R3E3584STF4kzY8yKf2529du2+SWilHLUyH1fYl1
	 5MNaLw0gLdc3NIKG+MzLmASVn+ej4KkO5l5UTVa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406041AbfJCRDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392515AbfJCQlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:41:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82622054F;
        Thu,  3 Oct 2019 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120910;
        bh=FDrlU1PiRBI+pftJbsQpLFHChJmTaWWY3GczLZA6tEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpLiA4Cj4aBci5g5uPQkGE7NpuvULBYG7Vc6Ja9DfJ8OdZgwaY3UEzRlg7c3RdWNd
         Cf6vFmUzcgRWnjE7Lsams4w+hXHGIvEDve5kqId1zMUuWO11/PH6vilboM4ovcfwsE
         M+M0H8B+sjzDmrkHnQrY7LDo21JK+3ZU07V12A64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grzegorz Halat <ghalat@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Zickus <dzickus@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 066/344] x86/reboot: Always use NMI fallback when shutdown via reboot vector IPI fails
Date:   Thu,  3 Oct 2019 17:50:31 +0200
Message-Id: <20191003154546.612832903@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grzegorz Halat <ghalat@redhat.com>

[ Upstream commit 747d5a1bf293dcb33af755a6d285d41b8c1ea010 ]

A reboot request sends an IPI via the reboot vector and waits for all other
CPUs to stop. If one or more CPUs are in critical regions with interrupts
disabled then the IPI is not handled on those CPUs and the shutdown hangs
if native_stop_other_cpus() is called with the wait argument set.

Such a situation can happen when one CPU was stopped within a lock held
section and another CPU is trying to acquire that lock with interrupts
disabled. There are other scenarios which can cause such a lockup as well.

In theory the shutdown should be attempted by an NMI IPI after the timeout
period elapsed. Though the wait loop after sending the reboot vector IPI
prevents this. It checks the wait request argument and the timeout. If wait
is set, which is true for sys_reboot() then it won't fall through to the
NMI shutdown method after the timeout period has finished.

This was an oversight when the NMI shutdown mechanism was added to handle
the 'reboot IPI is not working' situation. The mechanism was added to deal
with stuck panic shutdowns, which do not have the wait request set, so the
'wait request' case was probably not considered.

Remove the wait check from the post reboot vector IPI wait loop and enforce
that the wait loop in the NMI fallback path is invoked even if NMI IPIs are
disabled or the registration of the NMI handler fails. That second wait
loop will then hang if not all CPUs shutdown and the wait argument is set.

[ tglx: Avoid the hard to parse line break in the NMI fallback path,
  	add comments and massage the changelog ]

Fixes: 7d007d21e539 ("x86/reboot: Use NMI to assist in shutting down if IRQ fails")
Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Don Zickus <dzickus@redhat.com>
Link: https://lkml.kernel.org/r/20190628122813.15500-1-ghalat@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smp.c | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f97e75cf..231fa230ebc73 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -179,6 +179,12 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 	irq_exit();
 }
 
+static int register_stop_handler(void)
+{
+	return register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
+				    NMI_FLAG_FIRST, "smp_stop");
+}
+
 static void native_stop_other_cpus(int wait)
 {
 	unsigned long flags;
@@ -212,39 +218,41 @@ static void native_stop_other_cpus(int wait)
 		apic->send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
-		 * Don't wait longer than a second if the caller
-		 * didn't ask us to wait.
+		 * Don't wait longer than a second for IPI completion. The
+		 * wait request is not checked here because that would
+		 * prevent an NMI shutdown attempt in case that not all
+		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (num_online_cpus() > 1 && timeout--)
 			udelay(1);
 	}
-	
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if ((num_online_cpus() > 1) && (!smp_no_nmi_ipi))  {
-		if (register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
-					 NMI_FLAG_FIRST, "smp_stop"))
-			/* Note: we ignore failures here */
-			/* Hope the REBOOT_IRQ is good enough */
-			goto finish;
-
-		/* sync above data before sending IRQ */
-		wmb();
 
-		pr_emerg("Shutting down cpus with NMI\n");
+	/* if the REBOOT_VECTOR didn't work, try with the NMI */
+	if (num_online_cpus() > 1) {
+		/*
+		 * If NMI IPI is enabled, try to register the stop handler
+		 * and send the IPI. In any case try to wait for the other
+		 * CPUs to stop.
+		 */
+		if (!smp_no_nmi_ipi && !register_stop_handler()) {
+			/* Sync above data before sending IRQ */
+			wmb();
 
-		apic->send_IPI_allbutself(NMI_VECTOR);
+			pr_emerg("Shutting down cpus with NMI\n");
 
+			apic->send_IPI_allbutself(NMI_VECTOR);
+		}
 		/*
-		 * Don't wait longer than a 10 ms if the caller
-		 * didn't ask us to wait.
+		 * Don't wait longer than 10 ms if the caller didn't
+		 * reqeust it. If wait is true, the machine hangs here if
+		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
 		while (num_online_cpus() > 1 && (wait || timeout--))
 			udelay(1);
 	}
 
-finish:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
-- 
2.20.1



