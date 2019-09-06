Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94779C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C3321929
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392348AbfIFLI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47036 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392278AbfIFLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6H-00076h-JZ; Fri, 06 Sep 2019 13:08:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FA611C0E23;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Warn about inconsistent
 implementations of extended ranges
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809635.24167.7858449540084580045.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ad5a78d3da81836c88d1f2d53310484462660997
Gitweb:        https://git.kernel.org/tip/ad5a78d3da81836c88d1f2d53310484462660997
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 25 Jul 2019 15:30:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:35 +01:00

irqchip/gic-v3: Warn about inconsistent implementations of extended ranges

As is it usual for the GIC, it isn't disallowed to put together a system
that is majorly inconsistent, with a distributor supporting the
extended ranges while some of the CPUs don't.

Kindly tell the user that things are sailing isn't going to be smooth.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 5 +++++
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d3727e8..8af08dd 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1014,6 +1014,11 @@ static void gic_cpu_init(void)
 
 	gic_enable_redist(true);
 
+	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
+	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
+	     "Distributor has extended ranges, but CPU%d doesn't\n",
+	     smp_processor_id());
+
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9ec3349..5cc10cf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -496,6 +496,7 @@
 #define ICC_CTLR_EL1_A3V_SHIFT		15
 #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
 #define ICC_CTLR_EL1_RSS		(0x1 << 18)
+#define ICC_CTLR_EL1_ExtRange		(0x1 << 19)
 #define ICC_PMR_EL1_SHIFT		0
 #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
 #define ICC_BPR0_EL1_SHIFT		0
