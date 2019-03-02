Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC4520857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KMKWYtgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSsxn+p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCBEaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:10 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbfCBEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:30:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E49F62212C;
        Fri,  1 Mar 2019 23:29:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fXphOE/P/aA++
        clgr5KBMvTn+12qMc94HBZ4q+3txlY=; b=KMKWYtgMNkxfKU9H/lGHeEnKbjruS
        dvDgbYlMlQW44Grw+z4fckki7J4UZ32ox9/WsTNZRkuTQprcS9CedhfGIJ83yOM4
        7HvvGprPpxVRHXOnnms1Np4Pduw4CeElwkHZ6ketbGv4kxrA+p1tee5beNLVL5Vc
        TBLWveOF33qwdJ5+bg04Hbi1JnwxMJa4M4P6LsfLDaOD/n5Z/0qhDtpEFhS/yvVp
        RvAMfKVbm43wQf4Bv4kllcKEkcK65V+fLzo6KgtD1PACOlUgeE73MPykjTTVwfi0
        mGvaIyCuJPg/3sNRn1f+6dktU+OS4U0kAUbbGvNXlPFVFDZfFKf5/hQvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fXphOE/P/aA++clgr5KBMvTn+12qMc94HBZ4q+3txlY=; b=GSsxn+p9
        bKpmswyhtO6zIY61jKhVET1EOiwkjg4LahQaO6+4dKEj8nqt/PHA2LF97PfjJNme
        ZFj+PuKK8pWAi3+esx28f7g6SqKWMHZ4ICp1tlOfTls9n/ZqNBWMxmz9Vv4bYje6
        vfTFwm+xFDfGiWgf1uL1wQvD4YSnYQBZxJptCQ0zuzKYL6fq1A9v4lQE3e0kwiZA
        pUCLfCCTCqx6Mt+fFIexLRpa+N1cF2Xuy+XFdw2jZRdJLvvqQCw0hMYm0O3GWEYP
        sVUCOtOHX/GUW2huqTpUQmWZP6d/FaGi1zTolG8yEfG6HY5++MgHoQBfbKGk7uCQ
        XBpWTi9MaxkYpQ==
X-ME-Sender: <xms:xwZ6XMD8mTg-J4fGCp6KB9xZHEOFb-3H2O6kkAFG4VjLipN3NJaSfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:xwZ6XJWv3cI6jK7nua2i0YpBSnuhPCzVpB9a8DrhhL8CehK_UJox_w>
    <xmx:xwZ6XN1spwmF_HxqfOo0IBHjlkVXaLPIaeCwW_xIwAknhjK0lK6dTQ>
    <xmx:xwZ6XCWgu5PMQkq-z3S3K5aIp3_aLPyvGk_BzlQUdVYi3_6Psl0yqg>
    <xmx:xwZ6XFa70yJ10_S02vw8IhxYf7b7mo8ImymdI1HmODZb4tBxBzqbyA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C47610310;
        Fri,  1 Mar 2019 23:29:59 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 12/15] [NOT FOR MERGE] irqchip/mbox: Introduce a mailbox-backed irqchip driver
Date:   Fri,  1 Mar 2019 22:29:48 -0600
Message-Id: <20190302042951.53671-13-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements a simple interrupt controller using message
passing over a mailbox channel. The intention is for the other end of
the channel to be implemented in firmware. This allows filtering and
forwarding interrupts from one processor to another.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/irqchip/Kconfig    |   9 ++
 drivers/irqchip/Makefile   |   1 +
 drivers/irqchip/irq-mbox.c | 199 +++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/irqchip/irq-mbox.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..d22921276797 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -406,6 +406,15 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config IRQ_MBOX
+	tristate "Simple mailbox-backed interrupt controller"
+	depends on MAILBOX
+	select IRQ_DOMAIN
+	help
+	  Support for interrupt controllers attached via a mailbox channel.
+	  This allows a coprocessor to inject interrupts via a simple
+	  message-based protocol.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..9de16ab4e69a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_IRQ_MBOX)			+= irq-mbox.o
diff --git a/drivers/irqchip/irq-mbox.c b/drivers/irqchip/irq-mbox.c
new file mode 100644
index 000000000000..f7f6b47bc5b9
--- /dev/null
+++ b/drivers/irqchip/irq-mbox.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018-2019 Samuel Holland <samuel@sholland.org>
+
+/*
+ * Simple mailbox-backed interrupt controller driver using 32-bit messages.
+ * The mailbox controller is expected to take a (uint32_t *) message argument.
+ *
+ * Client-to-server messages:
+ *   Byte 3 (MSB) : Reserved
+ *   Byte 2       : Reserved
+ *   Byte 1       : Message type (enumerated below)
+ *   Byte 0 (LSB) : IRQ number
+ *
+ * Server-to-client messages:
+ *   Byte 3 (MSB) : Reserved
+ *   Byte 2       : Reserved
+ *   Byte 1       : Message type (must be zero == interrupt received)
+ *   Byte 0 (LSB) : IRQ number
+ *
+ * IRQ lines must be unmasked before they can be used (generic irqchip code
+ * takes care of that in this driver).
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+
+#define MBOX_INTC_MAX_IRQS 32
+
+enum {
+	MSG_EOI    = 0,
+	MSG_MASK   = 1,
+	MSG_UNMASK = 2,
+};
+
+struct mbox_intc {
+	struct irq_chip chip;
+	struct irq_domain *domain;
+	struct mbox_chan *rx_chan;
+	struct mbox_chan *tx_chan;
+	struct mbox_client cl;
+};
+
+static int mbox_intc_map(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq)
+{
+	struct mbox_intc *intc = domain->host_data;
+
+	if (hwirq >= MBOX_INTC_MAX_IRQS)
+		return -ENODEV;
+
+	irq_set_chip_data(virq, intc);
+	irq_set_chip_and_handler(virq, &intc->chip, handle_fasteoi_irq);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mbox_intc_domain_ops = {
+	.map   = mbox_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void mbox_intc_rx_callback(struct mbox_client *cl, void *msg)
+{
+	struct mbox_intc *intc = container_of(cl, struct mbox_intc, cl);
+	uint32_t hwirq = *(uint32_t *)msg;
+
+	if (hwirq >= MBOX_INTC_MAX_IRQS)
+		return;
+
+	generic_handle_irq(irq_linear_revmap(intc->domain, hwirq));
+}
+
+static void mbox_intc_tx_msg(struct irq_data *d, uint8_t request)
+{
+	struct mbox_intc *intc = irq_data_get_irq_chip_data(d);
+	uint32_t msg = (request << 8) | (d->hwirq & GENMASK(0, 7));
+
+	/* Since we don't expect an ACK for this message, immediately complete
+	 * the transmission. This ensures that each message is sent out without
+	 * sleeping, and 'data' remains in scope until actual transmission. */
+	if (mbox_send_message(intc->tx_chan, &msg) >= 0)
+		mbox_client_txdone(intc->tx_chan, 0);
+}
+
+static void mbox_intc_irq_mask(struct irq_data *d)
+{
+	mbox_intc_tx_msg(d, MSG_MASK);
+}
+
+static void mbox_intc_irq_unmask(struct irq_data *d)
+{
+	mbox_intc_tx_msg(d, MSG_UNMASK);
+}
+
+static void mbox_intc_irq_eoi(struct irq_data *d)
+{
+	mbox_intc_tx_msg(d, MSG_EOI);
+}
+
+static int mbox_intc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_intc *intc;
+	int ret;
+
+	intc = devm_kzalloc(dev, sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	intc->cl.dev          = dev;
+	intc->cl.knows_txdone = true;
+	intc->cl.rx_callback  = mbox_intc_rx_callback;
+
+	if (of_get_property(dev->of_node, "mbox-names", NULL)) {
+		intc->rx_chan = mbox_request_channel_byname(&intc->cl, "rx");
+		if (IS_ERR(intc->rx_chan)) {
+			ret = PTR_ERR(intc->rx_chan);
+			dev_err(dev, "Failed to request rx mailbox channel\n");
+			goto err;
+		}
+		intc->tx_chan = mbox_request_channel_byname(&intc->cl, "tx");
+		if (IS_ERR(intc->tx_chan)) {
+			ret = PTR_ERR(intc->tx_chan);
+			dev_err(dev, "Failed to request tx mailbox channel\n");
+			goto err_free_rx_chan;
+		}
+	} else {
+		intc->rx_chan = mbox_request_channel(&intc->cl, 0);
+		intc->tx_chan = intc->rx_chan;
+		if (IS_ERR(intc->tx_chan)) {
+			ret = PTR_ERR(intc->tx_chan);
+			dev_err(dev, "Failed to request mailbox channel\n");
+			goto err;
+		}
+	}
+
+	intc->chip.name       = dev_name(dev);
+	intc->chip.irq_mask   = mbox_intc_irq_mask;
+	intc->chip.irq_unmask = mbox_intc_irq_unmask;
+	intc->chip.irq_eoi    = mbox_intc_irq_eoi;
+
+	intc->domain = irq_domain_add_linear(dev->of_node, MBOX_INTC_MAX_IRQS,
+					     &mbox_intc_domain_ops, intc);
+	if (IS_ERR(intc->domain)) {
+		ret = PTR_ERR(intc->domain);
+		dev_err(dev, "Failed to allocate IRQ domain: %d\n", ret);
+		goto err_free_tx_chan;
+	}
+
+	platform_set_drvdata(pdev, intc);
+
+	return 0;
+
+err_free_tx_chan:
+	if (intc->tx_chan != intc->rx_chan)
+		mbox_free_channel(intc->tx_chan);
+err_free_rx_chan:
+	mbox_free_channel(intc->rx_chan);
+err:
+	return ret;
+}
+
+static int mbox_intc_remove(struct platform_device *pdev)
+{
+	struct mbox_intc *intc = platform_get_drvdata(pdev);
+
+	irq_domain_remove(intc->domain);
+	if (intc->tx_chan != intc->rx_chan)
+		mbox_free_channel(intc->tx_chan);
+	mbox_free_channel(intc->rx_chan);
+
+	return 0;
+}
+
+static const struct of_device_id mbox_intc_of_match[] = {
+	{ .compatible = "allwinner,sunxi-msgbox-intc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mbox_intc_of_match);
+
+static struct platform_driver mbox_intc_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = mbox_intc_of_match,
+	},
+	.probe  = mbox_intc_probe,
+	.remove = mbox_intc_remove,
+};
+module_platform_driver(mbox_intc_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Simple mailbox-backed interrupt controller");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

