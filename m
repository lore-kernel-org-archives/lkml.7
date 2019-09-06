Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5972C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A114206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393208AbfIFLIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392514AbfIFLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6V-0007Bv-DN; Fri, 06 Sep 2019 13:08:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 121BC1C0E30;
        Fri,  6 Sep 2019 13:08:18 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:18 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2m: Register the frame's PA instead of
 its VA in fwnode
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809802.24167.9307504019127622312.tip-bot2@tip-bot2>
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

Commit-ID:     7d5b7695c22f6e22d9a16df17f477832eef8e2b7
Gitweb:        https://git.kernel.org/tip/7d5b7695c22f6e22d9a16df17f477832eef8e2b7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 31 Jul 2019 16:13:42 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Aug 2019 14:24:37 +01:00

irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode

Do not expose the frame's VA (it appears in debugfs). Instead,
record the PA, which at least can be used to precisely identify
the associated irqchip and domain.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7338f90..e88e75c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -525,7 +525,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 			spi_start, nr_spis);
 	}
 
-	fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
+	fwnode = irq_domain_alloc_fwnode(&res.start);
 	if (!fwnode) {
 		pr_err("Unable to allocate GICv2m domain token\n");
 		return -EINVAL;
