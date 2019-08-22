Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2401C233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfHVJeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:34:22 -0400
Received: from shell.v3.sk ([90.176.6.54]:35905 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730857AbfHVJeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:34:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AAF37D756D;
        Thu, 22 Aug 2019 11:34:15 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UpO5WvmHcAzR; Thu, 22 Aug 2019 11:33:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E195CD7567;
        Thu, 22 Aug 2019 11:33:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7d6UZ33megEi; Thu, 22 Aug 2019 11:27:28 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DC5D6D755F;
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
        linux-clk@vger.kernel.org, Andres Salomon <dilinger@queued.net>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 08/20] irqchip/mmp: mask off interrupts from other cores
Date:   Thu, 22 Aug 2019 11:26:31 +0200
Message-Id: <20190822092643.593488-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andres Salomon <dilinger@queued.net>

On mmp3, there's an extra set of ICU registers (ICU2) that handle
interrupts on the extra cores.  When masking off interrupts on MP1,
these should be masked as well.

We add a new interrupt controller via device tree to identify when we're
looking at an mmp3 machine via compatible field of "marvell,mmp3-intc".

[lkundrak@v3.sk: Changed "mrvl,mmp3-intc" compatible strings to
"marvell,mmp3-intc". Tidied up the subject line a bit.]

Signed-off-by: Andres Salomon <dilinger@queued.net>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

--
Changes since v1:
- Moved mmp3-specific mmp_icu2_base initialization from mmp_init_bases() =
to
  mmp3_of_init() so that we don't have to check for marvell,mmp3-intc
  compatibility twice.
- Drop an superfluous call to irq_set_default_host()

 arch/arm/mach-mmp/regs-icu.h |  3 +++
 drivers/irqchip/irq-mmp.c    | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-mmp/regs-icu.h b/arch/arm/mach-mmp/regs-icu.h
index 0375d5a7fcb2b..410743d2b4020 100644
--- a/arch/arm/mach-mmp/regs-icu.h
+++ b/arch/arm/mach-mmp/regs-icu.h
@@ -11,6 +11,9 @@
 #define ICU_VIRT_BASE	(AXI_VIRT_BASE + 0x82000)
 #define ICU_REG(x)	(ICU_VIRT_BASE + (x))
=20
+#define ICU2_VIRT_BASE	(AXI_VIRT_BASE + 0x84000)
+#define ICU2_REG(x)	(ICU2_VIRT_BASE + (x))
+
 #define ICU_INT_CONF(n)		ICU_REG((n) << 2)
 #define ICU_INT_CONF_MASK	(0xf)
=20
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 126ffdbffdddf..25848d73f6792 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -44,6 +44,7 @@ struct icu_chip_data {
 	unsigned int		conf_enable;
 	unsigned int		conf_disable;
 	unsigned int		conf_mask;
+	unsigned int		conf2_mask;
 	unsigned int		clr_mfp_irq_base;
 	unsigned int		clr_mfp_hwirq;
 	struct irq_domain	*domain;
@@ -53,9 +54,11 @@ struct mmp_intc_conf {
 	unsigned int	conf_enable;
 	unsigned int	conf_disable;
 	unsigned int	conf_mask;
+	unsigned int	conf2_mask;
 };
=20
 static void __iomem *mmp_icu_base;
+static void __iomem *mmp_icu2_base;
 static struct icu_chip_data icu_data[MAX_ICU_NR];
 static int max_icu_nr;
=20
@@ -98,6 +101,16 @@ static void icu_mask_irq(struct irq_data *d)
 		r &=3D ~data->conf_mask;
 		r |=3D data->conf_disable;
 		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
+
+		if (data->conf2_mask) {
+			/*
+			 * ICU1 (above) only controls PJ4 MP1; if using SMP,
+			 * we need to also mask the MP2 and MM cores via ICU2.
+			 */
+			r =3D readl_relaxed(mmp_icu2_base + (hwirq << 2));
+			r &=3D ~data->conf2_mask;
+			writel_relaxed(r, mmp_icu2_base + (hwirq << 2));
+		}
 	} else {
 		r =3D readl_relaxed(data->reg_mask) | (1 << hwirq);
 		writel_relaxed(r, data->reg_mask);
@@ -201,6 +214,14 @@ static const struct mmp_intc_conf mmp2_conf =3D {
 			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
=20
+static struct mmp_intc_conf mmp3_conf =3D {
+	.conf_enable	=3D 0x20,
+	.conf_disable	=3D 0x0,
+	.conf_mask	=3D MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
+	.conf2_mask	=3D 0xf0,
+};
+
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
 {
 	int hwirq;
@@ -428,6 +449,33 @@ static int __init mmp2_of_init(struct device_node *n=
ode,
 }
 IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
=20
+static int __init mmp3_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	int ret;
+
+	mmp_icu2_base =3D of_iomap(node, 1);
+	if (!mmp_icu2_base) {
+		pr_err("Failed to get interrupt controller register #2\n");
+		return -ENODEV;
+	}
+
+	ret =3D mmp_init_bases(node);
+	if (ret < 0) {
+		iounmap(mmp_icu2_base);
+		return ret;
+	}
+
+	icu_data[0].conf_enable =3D mmp3_conf.conf_enable;
+	icu_data[0].conf_disable =3D mmp3_conf.conf_disable;
+	icu_data[0].conf_mask =3D mmp3_conf.conf_mask;
+	icu_data[0].conf2_mask =3D mmp3_conf.conf2_mask;
+	set_handle_irq(mmp2_handle_irq);
+	max_icu_nr =3D 1;
+	return 0;
+}
+IRQCHIP_DECLARE(mmp3_intc, "marvell,mmp3-intc", mmp3_of_init);
+
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
--=20
2.21.0

