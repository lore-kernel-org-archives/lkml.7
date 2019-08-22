Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7010233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfHVJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:33:52 -0400
Received: from shell.v3.sk ([90.176.6.54]:35817 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733261AbfHVJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:33:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DE820D7562;
        Thu, 22 Aug 2019 11:33:46 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ChwZ04mvNs-n; Thu, 22 Aug 2019 11:33:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 239B0D7570;
        Thu, 22 Aug 2019 11:32:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5GDqGikVRw22; Thu, 22 Aug 2019 11:27:28 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 866AFD755E;
        Thu, 22 Aug 2019 11:26:48 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 07/20] irqchip/mmp: add missing chained_irq_{enter,exit}()
Date:   Thu, 22 Aug 2019 11:26:30 +0200
Message-Id: <20190822092643.593488-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lack of chained_irq_exit() leaves the muxed interrupt masked on MMP3.
For reasons unknown this is not a problem on MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Use irq_desc_get_chip() instead of irq_get_chip()

 drivers/irqchip/irq-mmp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index e41e47ab71d3b..126ffdbffdddf 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -132,11 +133,14 @@ struct irq_chip icu_irq_chip =3D {
 static void icu_mux_irq_demux(struct irq_desc *desc)
 {
 	unsigned int irq =3D irq_desc_get_irq(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct irq_domain *domain;
 	struct icu_chip_data *data;
 	int i;
 	unsigned long mask, status, n;
=20
+	chained_irq_enter(chip, desc);
+
 	for (i =3D 1; i < max_icu_nr; i++) {
 		if (irq =3D=3D icu_data[i].cascade_irq) {
 			domain =3D icu_data[i].domain;
@@ -146,7 +150,7 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 	}
 	if (i >=3D max_icu_nr) {
 		pr_err("Spurious irq %d in MMP INTC\n", irq);
-		return;
+		goto out;
 	}
=20
 	mask =3D readl_relaxed(data->reg_mask);
@@ -158,6 +162,9 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 			generic_handle_irq(icu_data[i].virq_base + n);
 		}
 	}
+
+out:
+	chained_irq_exit(chip, desc);
 }
=20
 static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
--=20
2.21.0

