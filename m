Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D09C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731B2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbgAIRK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:10:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgAIRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:10:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipbKg-00086y-W2; Thu, 09 Jan 2020 18:10:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 942D81C2CE9;
        Thu,  9 Jan 2020 18:10:54 +0100 (CET)
Date:   Thu, 09 Jan 2020 17:10:54 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add missing __must_hold() sparse annotation
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216144208.29852-2-jbi.octave@gmail.com>
References: <20191216144208.29852-2-jbi.octave@gmail.com>
MIME-Version: 1.0
Message-ID: <157858985444.30329.16284662324525124496.tip-bot2@tip-bot2>
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

Commit-ID:     099368bb10c0e340f0b236b169e8b13235e0907c
Gitweb:        https://git.kernel.org/tip/099368bb10c0e340f0b236b169e8b13235e0907c
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Mon, 16 Dec 2019 14:42:08 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jan 2020 18:03:37 +01:00

genirq: Add missing __must_hold() sparse annotation

Add __must_hold() annotation to address the following sparse warning:

  warning: context imbalance in irq_wait_for_poll - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191216144208.29852-2-jbi.octave@gmail.com
---
 kernel/irq/spurious.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 2ed97a7..f865e5f 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -34,6 +34,7 @@ static atomic_t irq_poll_active;
  * true and let the handler run.
  */
 bool irq_wait_for_poll(struct irq_desc *desc)
+	__must_hold(&desc->lock)
 {
 	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
 		      "irq poll in progress on cpu %d for irq %d\n",
