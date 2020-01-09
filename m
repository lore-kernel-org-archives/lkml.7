Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79571C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AB52072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgAIQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:31:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbgAIQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:31:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipai8-0007Ts-Ir; Thu, 09 Jan 2020 17:31:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 314501C2CE5;
        Thu,  9 Jan 2020 17:31:04 +0100 (CET)
Date:   Thu, 09 Jan 2020 16:31:04 -0000
From:   "tip-bot2 for Luca Ceresoli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Show irq name in non-oneshot error message
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191105140854.27893-1-luca@lucaceresoli.net>
References: <20191105140854.27893-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Message-ID: <157858746402.30329.9327836906001451057.tip-bot2@tip-bot2>
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

Commit-ID:     025af39b87dc4dc78de4e861ca8b88a1d5ba89f6
Gitweb:        https://git.kernel.org/tip/025af39b87dc4dc78de4e861ca8b88a1d5ba89f6
Author:        Luca Ceresoli <luca@lucaceresoli.net>
AuthorDate:    Tue, 05 Nov 2019 15:08:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jan 2020 15:42:54 +01:00

genirq: Show irq name in non-oneshot error message

Requesting a threaded IRQ with handler=NULL and !ONESHOT fails, but the
error message does not include the IRQ line name, which makes it harder to
find the offending driver.

Print the IRQ line name to clarify where the error comes from. Use the same
format as the other pr_err() above in the same function.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191105140854.27893-1-luca@lucaceresoli.net

---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486..b6c53ab 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1500,8 +1500,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * has. The type flags are unreliable as the
 		 * underlying chip implementation can override them.
 		 */
-		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
-		       irq);
+		pr_err("Threaded irq requested with handler=NULL and !ONESHOT for %s (irq %d)\n",
+		       new->name, irq);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
