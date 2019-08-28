Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79145C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676222CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfH1Muq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:50:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Muq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:50:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2xPE-0003LC-8j; Wed, 28 Aug 2019 14:50:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D6F2C1C07D2;
        Wed, 28 Aug 2019 14:50:31 +0200 (CEST)
Date:   Wed, 28 Aug 2019 12:50:31 -0000
From:   "tip-bot2 for Neil Horman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/vector: Warn when vector space exhaustion
 breaks affinity
Cc:     djuran@redhat.com, Neil Horman <nhorman@tuxdriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822143421.9535-1-nhorman@tuxdriver.com>
References: <20190822143421.9535-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Message-ID: <156699663175.31014.3746755502169958579.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     743dac494d61d991967ebcfab92e4f80dc7583b3
Gitweb:        https://git.kernel.org/tip/743dac494d61d991967ebcfab92e4f80dc7583b3
Author:        Neil Horman <nhorman@tuxdriver.com>
AuthorDate:    Thu, 22 Aug 2019 10:34:21 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 14:44:08 +02:00

x86/apic/vector: Warn when vector space exhaustion breaks affinity

On x86, CPUs are limited in the number of interrupts they can have affined
to them as they only support 256 interrupt vectors per CPU. 32 vectors are
reserved for the CPU and the kernel reserves another 22 for internal
purposes. That leaves 202 vectors for assignement to devices.

When an interrupt is set up or the affinity is changed by the kernel or the
administrator, the vector assignment code attempts to honor the requested
affinity mask. If the vector space on the CPUs in that affinity mask is
exhausted the code falls back to a wider set of CPUs and assigns a vector
on a CPU outside of the requested affinity mask silently.

While the effective affinity is reflected in the corresponding
/proc/irq/$N/effective_affinity* files the silent breakage of the requested
affinity can lead to unexpected behaviour for administrators.

Add a pr_warn() when this happens so that adminstrators get at least
informed about it in the syslog.

[ tglx: Massaged changelog and made the pr_warn() more informative ]

Reported-by: djuran@redhat.com
Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: djuran@redhat.com
Link: https://lkml.kernel.org/r/20190822143421.9535-1-nhorman@tuxdriver.com
---
 arch/x86/kernel/apic/vector.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fdacb86..2c5676b 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -398,6 +398,17 @@ static int activate_reserved(struct irq_data *irqd)
 		if (!irqd_can_reserve(irqd))
 			apicd->can_reserve = false;
 	}
+
+	/*
+	 * Check to ensure that the effective affinity mask is a subset
+	 * the user supplied affinity mask, and warn the user if it is not
+	 */
+	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
+			    irq_data_get_affinity_mask(irqd))) {
+		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
+			irqd->irq);
+	}
+
 	return ret;
 }
 
