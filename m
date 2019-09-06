Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5862206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbfIFLKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:10:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392246AbfIFLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6B-00072i-JQ; Fri, 06 Sep 2019 13:08:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07BB01C0E21;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:14 -0000
From:   "tip-bot2 for Lubomir Rintel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mmp: Do not use of_address_to_resource() to
 get mux regs
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Marc Zyngier <maz@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822092643.593488-7-lkundrak@v3.sk>
References: <20190822092643.593488-7-lkundrak@v3.sk>
MIME-Version: 1.0
Message-ID: <156776809499.24167.7572723147707304063.tip-bot2@tip-bot2>
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

Commit-ID:     d6a95280ba169c3a3d632d983cc6977c544a06e8
Gitweb:        https://git.kernel.org/tip/d6a95280ba169c3a3d632d983cc6977c544a06e8
Author:        Lubomir Rintel <lkundrak@v3.sk>
AuthorDate:    Thu, 22 Aug 2019 11:26:29 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 30 Aug 2019 15:23:30 +01:00

irqchip/mmp: Do not use of_address_to_resource() to get mux regs

The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
are offsets from intc's base, not addresses on the parent bus. At this
point it probably can't be fixed.

On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
axi bus, and thus of_address_to_resource() won't work. We should treat
the values as mere integers as opposed to bus addresses.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Link: https://lore.kernel.org/r/20190822092643.593488-7-lkundrak@v3.sk
---
 drivers/irqchip/irq-mmp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 0671c3b..f60e52b 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -422,9 +422,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
-	struct resource res;
 	int i, ret, irq, j = 0;
 	u32 nr_irqs, mfp_irq;
+	u32 reg[4];
 
 	if (!parent)
 		return -ENODEV;
@@ -436,18 +436,22 @@ static int __init mmp2_mux_of_init(struct device_node *node,
 		pr_err("Not found mrvl,intc-nr-irqs property\n");
 		return -EINVAL;
 	}
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret < 0) {
-		pr_err("Not found reg property\n");
-		return -EINVAL;
-	}
-	icu_data[i].reg_status = mmp_icu_base + res.start;
-	ret = of_address_to_resource(node, 1, &res);
+
+	/*
+	 * For historical reasons, the "regs" property of the
+	 * mrvl,mmp2-mux-intc is not a regular "regs" property containing
+	 * addresses on the parent bus, but offsets from the intc's base.
+	 * That is why we can't use of_address_to_resource() here.
+	 */
+	ret = of_property_read_variable_u32_array(node, "reg", reg,
+						  ARRAY_SIZE(reg),
+						  ARRAY_SIZE(reg));
 	if (ret < 0) {
 		pr_err("Not found reg property\n");
 		return -EINVAL;
 	}
-	icu_data[i].reg_mask = mmp_icu_base + res.start;
+	icu_data[i].reg_status = mmp_icu_base + reg[0];
+	icu_data[i].reg_mask = mmp_icu_base + reg[2];
 	icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
 	if (!icu_data[i].cascade_irq)
 		return -EINVAL;
