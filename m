Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDEC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431A22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MZkP95bV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbfGYNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:40:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389689AbfGYNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:40:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PDeBcg1023420
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 06:40:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PDeBcg1023420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564062012;
        bh=KdTvdtUJ2xYBbvljl4zkGCXlTd5kdOrVeeYsketxu40=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MZkP95bVDuH9UGrNovlwlDjhVxr4YBsd80hCfadqI5JwV9T6TC7hZW95fUApTo4Dy
         U5gkesjyh/1reWOi+7LYxRI2I77IIxKh+6HboEfRqyTAv8DnkkuuxyL/aTUB/Zk1GY
         35t34zSBQMwGTBL6MgkOL1oLbnYYhVVbderaspSF6Ulm0SplWBGNCneiKzagBXYHSI
         ZK+oGJVhJBi3kedhyHBVA2MB36bePA3pD1AR8qsLTZO6/oe2Su/oDGIKJrjR8Psglj
         5veS2N46A7JOePPXFZ8EWvAMNybYaKWtHqVksRFyEfK6G0M8oiqE7ZZTurngDEp/2m
         93DXJxgV2ONdg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PDeAYM1023417;
        Thu, 25 Jul 2019 06:40:10 -0700
Date:   Thu, 25 Jul 2019 06:40:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Grzegorz Halat <tipbot@zytor.com>
Message-ID: <tip-d92e35b76cfcafc31987a2aa186a8e8b4ee84f52@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        ghalat@redhat.com, dzickus@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, dzickus@redhat.com,
          ghalat@redhat.com
In-Reply-To: <20190628122813.15500-1-ghalat@redhat.com>
References: <20190628122813.15500-1-ghalat@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/reboot: Always use NMI fallback when shutdown
 via reboot vector IPI fails
Git-Commit-ID: d92e35b76cfcafc31987a2aa186a8e8b4ee84f52
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d92e35b76cfcafc31987a2aa186a8e8b4ee84f52
Gitweb:     https://git.kernel.org/tip/d92e35b76cfcafc31987a2aa186a8e8b4ee84f52
Author:     Grzegorz Halat <ghalat@redhat.com>
AuthorDate: Fri, 28 Jun 2019 14:28:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 15:35:08 +0200

x86/reboot: Always use NMI fallback when shutdown via reboot vector IPI fails

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
---
 arch/x86/kernel/smp.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f97e75c..231fa230ebc7 100644
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
