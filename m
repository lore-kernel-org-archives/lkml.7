Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3B20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Ssd3LhrM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oc3dkL9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfCBE37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:29:59 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfCBE34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B68C22110;
        Fri,  1 Mar 2019 23:29:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Ul6U1RKmV4zUb
        SoOgM/PW1wyd1jLSOpRx03spNa81eE=; b=Ssd3LhrMTqdU/vvv0er298GTSTH5B
        uR9EnNEVdG2q7lYkVVDHzW8uboh/XtdckSGRG9sy+dzQg6lx4pPDjOvme2my7sgp
        m3uVJG+NBUiek2ngjkL0RYLQv+1yqr7W3JIAViXyyBe4fmVWt5XesFGXFDe9ULny
        oIUBZw+ubSRTTUIjPS60bpdSW7yDM/lH28yEbdJiRJxguEEhUcQu/IWD47FZCQDM
        LIvTjaRyEDfTA46BZf9ODr7fBxJC31P7jKvs7Pnt8dC+vto+DmWi7WrJR9btYcXY
        ecOikWKu9Tx5hNWVllq+MNzTcBM9S22sUzu6FK8Qt4ggjdAt4KcY1pWZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ul6U1RKmV4zUbSoOgM/PW1wyd1jLSOpRx03spNa81eE=; b=oc3dkL9D
        uDQ7smH5mtaaWn1FzZsl1VWrBriq/1UZmGoDEXXsJFrcZZj3pn2oXcCpECXHWNKW
        hGpi7BXnUb8RFsMHcMdHEs8RQf5Jo49CZgEzgei8XQdxdNAANakUwnw6g7/M1y5i
        G3D0vWfAjb3tFtE5AMII54OzHFCBHQ/HDpoz+8sL3tQ/6TbntDoSY7IdtS51epmI
        PHQGWUkccYPcFwK7LqBGx8b8+UPYlwtKUbImmBGO4iaMZBL9bgb8mYFxnlpK4nuA
        +5VDDBBblQor5BKgGoM9ZzqBDKr7NEI9W+2GTbvF1OiQvmujXO84LTsrs7k+l4e8
        XRXtHYoOaUU2SA==
X-ME-Sender: <xms:wwZ6XPi4H23dG3yvlk8En7CKI4aDuA7tB8zOmvWatzBkd3F2qk9HTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wwZ6XNmNV1TSt6I1GCdJJJQdj522D8Id6U4HWW3HI7WFx37bHgG87w>
    <xmx:wwZ6XFZCkPxe0e4vmeP-CnJTtyU2LSWUixhDX0K9D5PVJ9pD7AKMog>
    <xmx:wwZ6XIG781P-RvkoRUhnr1XpmSZs-wZA9tKLDfeNaOs1ueXc40luDw>
    <xmx:wwZ6XEgNL417LtvIn8jNYRmIO7UuV3f5c3r4xHuMGiEhWCKsG1ty0Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CFC110310;
        Fri,  1 Mar 2019 23:29:54 -0500 (EST)
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
Subject: [PATCH v3 04/15] mailbox: sunxi-msgbox: Add a new mailbox driver
Date:   Fri,  1 Mar 2019 22:29:40 -0600
Message-Id: <20190302042951.53671-5-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sun8i, sun9i, and sun50i SoCs contain a hardware message box
used for communication between the ARM CPUs and the ARISC management
coprocessor. The hardware contains 8 unidirectional 4-message FIFOs.

Add a driver for it, so it can be used for SCPI or other communication
protocols.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/mailbox/Kconfig        |  11 ++
 drivers/mailbox/Makefile       |   2 +
 drivers/mailbox/sunxi-msgbox.c | 315 +++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3eeb12e93e98..6309e755d04a 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -205,4 +205,15 @@ config MTK_CMDQ_MBOX
 	  mailbox driver. The CMDQ is used to help read/write registers with
 	  critical time limitation, such as updating display configuration
 	  during the vblank.
+
+config SUNXI_MSGBOX
+	tristate "Allwinner sunxi Message Box"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	default ARCH_SUNXI
+	help
+	  Mailbox implementation for the hardware message box present in
+	  Allwinner sun8i, sun9i, and sun50i SoCs. The hardware message box is
+	  used for communication between the application CPUs and the power
+	  management coprocessor.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c818b5d011ae..f29a119a3fac 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -44,3 +44,5 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
 obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
+
+obj-$(CONFIG_SUNXI_MSGBOX)	+= sunxi-msgbox.o
diff --git a/drivers/mailbox/sunxi-msgbox.c b/drivers/mailbox/sunxi-msgbox.c
new file mode 100644
index 000000000000..fb0d733dd3b4
--- /dev/null
+++ b/drivers/mailbox/sunxi-msgbox.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2017-2019 Samuel Holland <samuel@sholland.org>
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define NUM_CHANS		8
+
+#define CTRL_REG(n)		(0x0000 + 0x4 * ((n) / 4))
+#define CTRL_RX(n)		BIT(0 + 8 * ((n) % 4))
+#define CTRL_TX(n)		BIT(4 + 8 * ((n) % 4))
+
+#define REMOTE_IRQ_EN_REG	0x0040
+#define REMOTE_IRQ_STATUS_REG	0x0050
+#define LOCAL_IRQ_EN_REG	0x0060
+#define LOCAL_IRQ_STATUS_REG	0x0070
+
+#define RX_IRQ(n)		BIT(0 + 2 * (n))
+#define RX_IRQ_MASK		0x5555
+#define TX_IRQ(n)		BIT(1 + 2 * (n))
+#define TX_IRQ_MASK		0xaaaa
+
+#define FIFO_STATUS_REG(n)	(0x0100 + 0x4 * (n))
+#define FIFO_STATUS_MASK	BIT(0)
+
+#define MSG_STATUS_REG(n)	(0x0140 + 0x4 * (n))
+#define MSG_STATUS_MASK		GENMASK(2, 0)
+
+#define MSG_DATA_REG(n)		(0x0180 + 0x4 * (n))
+
+#define mbox_dbg(mbox, ...)	dev_dbg((mbox)->controller.dev, __VA_ARGS__)
+
+struct sunxi_msgbox {
+	struct mbox_controller controller;
+	struct clk *clk;
+	spinlock_t lock;
+	void __iomem *regs;
+};
+
+static bool sunxi_msgbox_last_tx_done(struct mbox_chan *chan);
+static bool sunxi_msgbox_peek_data(struct mbox_chan *chan);
+
+static inline int channel_number(struct mbox_chan *chan)
+{
+	return chan - chan->mbox->chans;
+}
+
+static inline struct sunxi_msgbox *channel_to_msgbox(struct mbox_chan *chan)
+{
+	return (struct sunxi_msgbox *)chan->con_priv;
+}
+
+static irqreturn_t sunxi_msgbox_irq(int irq, void *dev_id)
+{
+	struct mbox_chan *chan;
+	struct sunxi_msgbox *mbox = dev_id;
+	int n;
+	uint32_t msg, status;
+
+	status = readl(mbox->regs + LOCAL_IRQ_STATUS_REG);
+	if (!(status & RX_IRQ_MASK))
+		return IRQ_NONE;
+
+	for (n = 0; n < NUM_CHANS; ++n) {
+		if (!(status & RX_IRQ(n)))
+			continue;
+		chan = &mbox->controller.chans[n];
+		while (sunxi_msgbox_peek_data(chan)) {
+			msg = readl(mbox->regs + MSG_DATA_REG(n));
+			mbox_dbg(mbox, "Channel %d received 0x%08x\n", n, msg);
+			mbox_chan_received_data(chan, &msg);
+		}
+		/* The IRQ can be cleared only when the FIFO is empty. */
+		writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STATUS_REG);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sunxi_msgbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct sunxi_msgbox *mbox = channel_to_msgbox(chan);
+	int n = channel_number(chan);
+	uint32_t msg = *(uint32_t *)data;
+
+	/* Using a channel backwards gets the hardware into a bad state. */
+	if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
+		return 0;
+
+	/* We cannot post a new message if the FIFO is full. */
+	if (readl(mbox->regs + FIFO_STATUS_REG(n)) & FIFO_STATUS_MASK) {
+		mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
+		return -EBUSY;
+	}
+
+	writel(msg, mbox->regs + MSG_DATA_REG(n));
+	mbox_dbg(mbox, "Channel %d sent 0x%08x\n", n, msg);
+
+	return 0;
+}
+
+static int sunxi_msgbox_startup(struct mbox_chan *chan)
+{
+	struct sunxi_msgbox *mbox = channel_to_msgbox(chan);
+	int n = channel_number(chan);
+
+	/* The coprocessor is responsible for setting channel directions. */
+	if (readl(mbox->regs + CTRL_REG(n)) & CTRL_RX(n)) {
+		/* Clear existing messages in the receive FIFO. */
+		while (sunxi_msgbox_peek_data(chan))
+			readl(mbox->regs + MSG_DATA_REG(n));
+		writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STATUS_REG);
+
+		/* Enable the receive interrupt. */
+		spin_lock(&mbox->lock);
+		writel(readl(mbox->regs + LOCAL_IRQ_EN_REG) | RX_IRQ(n),
+		       mbox->regs + LOCAL_IRQ_EN_REG);
+		spin_unlock(&mbox->lock);
+	}
+
+	mbox_dbg(mbox, "Channel %d startup\n", n);
+
+	return 0;
+}
+
+static void sunxi_msgbox_shutdown(struct mbox_chan *chan)
+{
+	struct sunxi_msgbox *mbox = channel_to_msgbox(chan);
+	int n = channel_number(chan);
+
+	if (readl(mbox->regs + CTRL_REG(n)) & CTRL_RX(n)) {
+		/* Disable the receive interrupt. */
+		spin_lock(&mbox->lock);
+		writel(readl(mbox->regs + LOCAL_IRQ_EN_REG) & ~RX_IRQ(n),
+		       mbox->regs + LOCAL_IRQ_EN_REG);
+		spin_unlock(&mbox->lock);
+
+		/* Clear existing messages in the receive FIFO. */
+		while (sunxi_msgbox_peek_data(chan))
+			readl(mbox->regs + MSG_DATA_REG(n));
+		writel(RX_IRQ(n), mbox->regs + LOCAL_IRQ_STATUS_REG);
+	}
+
+	mbox_dbg(mbox, "Channel %d shutdown\n", n);
+}
+
+static bool sunxi_msgbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct sunxi_msgbox *mbox = channel_to_msgbox(chan);
+	int n = channel_number(chan);
+
+	/*
+	 * The hardware allows snooping on the remote user's IRQ status. We
+	 * consider a message to be acknowledged only when the receive IRQ for
+	 * that channel is cleared. As the hardware only allows clearing the
+	 * IRQ for a channel when the FIFO is empty, this still ensures that
+	 * the message has actually been read. It also gives the receiver an
+	 * opportunity to perform minimal processing before acknowledging a
+	 * message.
+	 */
+	return !(readl(mbox->regs + REMOTE_IRQ_STATUS_REG) & RX_IRQ(n));
+}
+
+static bool sunxi_msgbox_peek_data(struct mbox_chan *chan)
+{
+	struct sunxi_msgbox *mbox = channel_to_msgbox(chan);
+	int n = channel_number(chan);
+
+	return (readl(mbox->regs + MSG_STATUS_REG(n)) & MSG_STATUS_MASK) > 0;
+}
+
+static const struct mbox_chan_ops sunxi_msgbox_chan_ops = {
+	.send_data    = sunxi_msgbox_send_data,
+	.startup      = sunxi_msgbox_startup,
+	.shutdown     = sunxi_msgbox_shutdown,
+	.last_tx_done = sunxi_msgbox_last_tx_done,
+	.peek_data    = sunxi_msgbox_peek_data,
+};
+
+static int sunxi_msgbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_chan *chans;
+	struct reset_control *reset;
+	struct resource *res;
+	struct sunxi_msgbox *mbox;
+	int i, ret;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	chans = devm_kcalloc(dev, NUM_CHANS, sizeof(*chans), GFP_KERNEL);
+	if (!chans)
+		return -ENOMEM;
+
+	for (i = 0; i < NUM_CHANS; ++i)
+		chans[i].con_priv = mbox;
+
+	mbox->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(mbox->clk)) {
+		ret = PTR_ERR(mbox->clk);
+		dev_err(dev, "Failed to get clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(mbox->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(dev, "Failed to get reset control: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		dev_err(dev, "Failed to deassert reset: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto err_disable_unprepare;
+	}
+
+	mbox->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mbox->regs)) {
+		ret = PTR_ERR(mbox->regs);
+		dev_err(dev, "Failed to map MMIO resource: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	/* Disable all interrupts for this end of the msgbox. */
+	writel(0, mbox->regs + LOCAL_IRQ_EN_REG);
+
+	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
+			       sunxi_msgbox_irq, 0, dev_name(dev), mbox);
+	if (ret) {
+		dev_err(dev, "Failed to register IRQ handler: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	mbox->controller.dev           = dev;
+	mbox->controller.ops           = &sunxi_msgbox_chan_ops;
+	mbox->controller.chans         = chans;
+	mbox->controller.num_chans     = NUM_CHANS;
+	mbox->controller.txdone_irq    = false;
+	mbox->controller.txdone_poll   = true;
+	mbox->controller.txpoll_period = 5;
+
+	spin_lock_init(&mbox->lock);
+	platform_set_drvdata(pdev, mbox);
+
+	ret = mbox_controller_register(&mbox->controller);
+	if (ret) {
+		dev_err(dev, "Failed to register controller: %d\n", ret);
+		goto err_disable_unprepare;
+	}
+
+	return 0;
+
+err_disable_unprepare:
+	clk_disable_unprepare(mbox->clk);
+
+	return ret;
+}
+
+static int sunxi_msgbox_remove(struct platform_device *pdev)
+{
+	struct sunxi_msgbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->controller);
+	clk_disable_unprepare(mbox->clk);
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_msgbox_of_match[] = {
+	{ .compatible = "allwinner,sun6i-a31-msgbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sunxi_msgbox_of_match);
+
+static struct platform_driver sunxi_msgbox_driver = {
+	.driver = {
+		.name = "sunxi-msgbox",
+		.of_match_table = sunxi_msgbox_of_match,
+	},
+	.probe  = sunxi_msgbox_probe,
+	.remove = sunxi_msgbox_remove,
+};
+module_platform_driver(sunxi_msgbox_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner sunxi Message Box");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

