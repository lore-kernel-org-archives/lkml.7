Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC22C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18EC216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sAkBH4wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfGFInP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 04:43:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:43:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x668h4HP351377
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 6 Jul 2019 01:43:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x668h4HP351377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562402585;
        bh=Uo4rkYrgZmi4bhQTRyfMXE8q9YNR3nRwhlV+/Wf6dYM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sAkBH4wTQf904dGRI6IP1F/6vvDIAP/MjfERem12V6BWCXLDq1TM0dJ9GGekmnqXO
         /yEO8MPLPMTcRq/ZaTXln362oPPS8J7LevO6DtbxVvfL5sy7lrs2vy0d1iBMDctQ0e
         FYwjyGqSfpEn7ONmsWravPcn2VqkMkZN308rRziMi0IYjmcrrVPSPn631OxP/5PiyZ
         kJGnY2Xzk4pFpOIm9LATtttgdZznmnfMzp3zwShxBM+TwdpTKWX94x0HTAjR+A1YN/
         OuhZS2dNbKtrhOPBkT2Y86iaU4Z19h/5+6XTE9KlvBzzEItZsZek6GHQKYeOEPH55v
         cAhz5AV1Kxs8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x668h4Z1351374;
        Sat, 6 Jul 2019 01:43:04 -0700
Date:   Sat, 6 Jul 2019 01:43:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shijith Thotton <tipbot@zytor.com>
Message-ID: <tip-c09cb1293523dd786ae54a12fd88001542cba2f6@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, sthotton@marvell.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, sthotton@marvell.com
In-Reply-To: <1562313336-11888-1-git-send-email-sthotton@marvell.com>
References: <1562313336-11888-1-git-send-email-sthotton@marvell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Update irq stats from NMI handlers
Git-Commit-ID: c09cb1293523dd786ae54a12fd88001542cba2f6
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

Commit-ID:  c09cb1293523dd786ae54a12fd88001542cba2f6
Gitweb:     https://git.kernel.org/tip/c09cb1293523dd786ae54a12fd88001542cba2f6
Author:     Shijith Thotton <sthotton@marvell.com>
AuthorDate: Fri, 5 Jul 2019 07:56:20 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 6 Jul 2019 10:40:19 +0200

genirq: Update irq stats from NMI handlers

The NMI handlers handle_percpu_devid_fasteoi_nmi() and handle_fasteoi_nmi()
do not update the interrupt counts. Due to that the NMI interrupt count
does not show up correctly in /proc/interrupts.

Add the statistics and treat the NMI handlers in the same way as per cpu
interrupts and prevent them from updating irq_desc::tot_count as this might
be corrupted due to concurrency.

[ tglx: Massaged changelog ]

Fixes: 2dcf1fbcad35 ("genirq: Provide NMI handlers")
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1562313336-11888-1-git-send-email-sthotton@marvell.com
---
 kernel/irq/chip.c    | 4 ++++
 kernel/irq/irqdesc.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..04c850fb70cb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,6 +748,8 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	/*
 	 * NMIs cannot be shared, there is only one action.
@@ -962,6 +964,8 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 	trace_irq_handler_exit(irq, action, res);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index c52b737ab8e3..9149dde5a7b0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -946,6 +946,11 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
 }
 
+static bool irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 /**
  * kstat_irqs - Get the statistics for an interrupt
  * @irq:	The interrupt number
@@ -963,7 +968,8 @@ unsigned int kstat_irqs(unsigned int irq)
 	if (!desc || !desc->kstat_irqs)
 		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
-	    !irq_settings_is_per_cpu(desc))
+	    !irq_settings_is_per_cpu(desc) &&
+	    !irq_is_nmi(desc))
 	    return desc->tot_count;
 
 	for_each_possible_cpu(cpu)
