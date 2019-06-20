Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A21C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2753020675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfFTPVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:21:49 -0400
Received: from shell.v3.sk ([90.176.6.54]:51739 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfFTPVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:21:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5137DCC536;
        Thu, 20 Jun 2019 17:21:44 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mOScGofMifvh; Thu, 20 Jun 2019 17:21:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 53F66CC53C;
        Thu, 20 Jun 2019 17:21:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2Yg7H9k7TFsZ; Thu, 20 Jun 2019 17:21:38 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3B852CC536;
        Thu, 20 Jun 2019 17:21:38 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] irqchip/mmp: do not use of_address_to_resource() to get mux regs
Date:   Thu, 20 Jun 2019 17:21:22 +0200
Message-Id: <20190620152122.1407853-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
are offsets from intc's base, not addresses on the parent bus. At this
point it probably can't be fixed.

On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
axi bus, and thus of_address_to_resource() won't work. We should treat
the values as mere integers as opposed to bus addresses.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v4 of "MMP platform fixes" set
- Add a comment, as suggested by Pavel
---
 drivers/irqchip/irq-mmp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 8eed478f3b7e..e3d3baa0470f 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -427,9 +427,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_=
init);
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
-	struct resource res;
 	int i, ret, irq, j =3D 0;
 	u32 nr_irqs, mfp_irq;
+	u32 reg[4];
=20
 	if (!parent)
 		return -ENODEV;
@@ -441,18 +441,20 @@ static int __init mmp2_mux_of_init(struct device_no=
de *node,
 		pr_err("Not found mrvl,intc-nr-irqs property\n");
 		return -EINVAL;
 	}
-	ret =3D of_address_to_resource(node, 0, &res);
+
+	/*
+	 * For historical reasonsm, the "regs" property of the
+	 * mrvl,mmp2-mux-intc is not a regular * "regs" property containing
+	 * addresses on the parent bus, but offsets from the intc's base.
+	 * That is why we can't use of_address_to_resource() here.
+	 */
+	ret =3D of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
 	if (ret < 0) {
 		pr_err("Not found reg property\n");
 		return -EINVAL;
 	}
-	icu_data[i].reg_status =3D mmp_icu_base + res.start;
-	ret =3D of_address_to_resource(node, 1, &res);
-	if (ret < 0) {
-		pr_err("Not found reg property\n");
-		return -EINVAL;
-	}
-	icu_data[i].reg_mask =3D mmp_icu_base + res.start;
+	icu_data[i].reg_status =3D mmp_icu_base + reg[0];
+	icu_data[i].reg_mask =3D mmp_icu_base + reg[2];
 	icu_data[i].cascade_irq =3D irq_of_parse_and_map(node, 0);
 	if (!icu_data[i].cascade_irq)
 		return -EINVAL;
--=20
2.21.0

