Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89584C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690C820C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406271AbfHIJdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:10 -0400
Received: from shell.v3.sk ([90.176.6.54]:51888 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406250AbfHIJdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2FF04D63D3;
        Fri,  9 Aug 2019 11:33:05 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EYIGhKe2bNVe; Fri,  9 Aug 2019 11:32:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A2645D63D1;
        Fri,  9 Aug 2019 11:32:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U_0ap2e1epJX; Fri,  9 Aug 2019 11:32:14 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 91B1BD6350;
        Fri,  9 Aug 2019 11:32:13 +0200 (CEST)
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
Subject: [PATCH 06/19] irqchip/mmp: add missing chained_irq_{enter,exit}()
Date:   Fri,  9 Aug 2019 11:31:45 +0200
Message-Id: <20190809093158.7969-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
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
 drivers/irqchip/irq-mmp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index af9cba4a51c2e..cd8d2253f56d1 100644
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
+	struct irq_chip *chip =3D irq_get_chip(irq);
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

