Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5521872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440222AbfJYMaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:30:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37675 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436494AbfJYMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:30:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNyjP-00072V-0l; Fri, 25 Oct 2019 14:30:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9A2081C0086;
        Fri, 25 Oct 2019 14:30:14 +0200 (CEST)
Date:   Fri, 25 Oct 2019 12:30:14 -0000
From:   "tip-bot2 for Alan Mikhak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Skip contexts except
 supervisor in plic_init()
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571933503-21504-1-git-send-email-alan.mikhak@sifive.com>
References: <1571933503-21504-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Message-ID: <157200661432.29376.6464692458150883535.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     41860cc447045c811ce6d5a92f93a065a691fe8e
Gitweb:        https://git.kernel.org/tip/41860cc447045c811ce6d5a92f93a065a691fe8e
Author:        Alan Mikhak <alan.mikhak@sifive.com>
AuthorDate:    Thu, 24 Oct 2019 09:11:43 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Oct 2019 11:48:13 +01:00

irqchip/sifive-plic: Skip contexts except supervisor in plic_init()

Modify plic_init() to skip .dts interrupt contexts other
than supervisor external interrupt.

The .dts entry for plic may specify multiple interrupt contexts.
For example, it may assign two entries IRQ_M_EXT and IRQ_S_EXT,
in that order, to the same interrupt controller. This patch
modifies plic_init() to skip the IRQ_M_EXT context since
IRQ_S_EXT is currently the only supported context.

If IRQ_M_EXT is not skipped, plic_init() will report "handler
already present for context" when it comes across the IRQ_S_EXT
context in the next iteration of its loop.

Without this patch, .dts would have to be edited to replace the
value of IRQ_M_EXT with -1 for it to be skipped.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv
Link: https://lkml.kernel.org/r/1571933503-21504-1-git-send-email-alan.mikhak@sifive.com
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 3e51dee..b1a33f9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* skip context holes */
-		if (parent.args[0] == -1)
+		/* skip contexts other than supervisor external interrupt */
+		if (parent.args[0] != IRQ_S_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);
