Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13D221874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbfHHKCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:02:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:13327 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389751AbfHHKCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:02:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 03:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="165649211"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2019 03:02:19 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/3] serial: lantiq: Make IRQ & ISR assignment dynamic
Date:   Thu,  8 Aug 2019 18:02:07 +0800
Message-Id: <b166a0593bee191fcd77b5bdf8fedc6f6330a371.1565257887.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver/IP is reused across multiple SoCs. Older SoCs supported three
separate IRQs for tx, rx & err interrupts. Newer Lightning Mountain SoC
supports single IRQ for all of tx/rx/err interrupts. This patch modifies
the driver design to support dynamic assignment of IRQ resources & ISRs
based on devicetree node compatible entries.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/lantiq.c | 141 ++++++++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 660d21db57dc..b129531dfb9a 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -100,6 +100,12 @@ static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
 
+struct ltq_soc_data {
+	int	(*fetch_irq)(struct device *dev, struct ltq_uart_port *ltq_port);
+	int	(*request_irq)(struct uart_port *port);
+	void	(*free_irq)(struct uart_port *port);
+};
+
 struct ltq_uart_port {
 	struct uart_port	port;
 	/* clock used to derive divider */
@@ -110,6 +116,8 @@ struct ltq_uart_port {
 	unsigned int		rx_irq;
 	unsigned int		err_irq;
 	spinlock_t		lock; /* exclusive access for multi core */
+
+	const struct ltq_soc_data	*soc;
 };
 
 static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
@@ -343,35 +351,12 @@ lqasc_startup(struct uart_port *port)
 
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
 
-	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
-		0, "asc_tx", port);
-	if (retval) {
-		pr_err("failed to request lqasc_tx_int\n");
+	retval = ltq_port->soc->request_irq(port);
+	if (retval)
 		return retval;
-	}
-
-	retval = request_irq(ltq_port->rx_irq, lqasc_rx_int,
-		0, "asc_rx", port);
-	if (retval) {
-		pr_err("failed to request lqasc_rx_int\n");
-		goto err1;
-	}
-
-	retval = request_irq(ltq_port->err_irq, lqasc_err_int,
-		0, "asc_err", port);
-	if (retval) {
-		pr_err("failed to request lqasc_err_int\n");
-		goto err2;
-	}
 
 	__raw_writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
 		port->membase + LTQ_ASC_IRNREN);
-	return 0;
-
-err2:
-	free_irq(ltq_port->rx_irq, port);
-err1:
-	free_irq(ltq_port->tx_irq, port);
 	return retval;
 }
 
@@ -381,9 +366,7 @@ lqasc_shutdown(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	unsigned long flags;
 
-	free_irq(ltq_port->tx_irq, port);
-	free_irq(ltq_port->rx_irq, port);
-	free_irq(ltq_port->err_irq, port);
+	ltq_port->soc->free_irq(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
 	__raw_writel(0, port->membase + LTQ_ASC_CON);
@@ -705,24 +688,98 @@ static struct uart_driver lqasc_reg = {
 	.cons =		&lqasc_console,
 };
 
+static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
+{
+	struct uart_port *port = &ltq_port->port;
+	struct resource irqres[3];
+	int ret;
+
+	ret = of_irq_to_resource_table(dev->of_node, irqres, 3);
+	if (ret != 3) {
+		dev_err(dev,
+			"failed to get IRQs for serial port\n");
+		return -ENODEV;
+	}
+	ltq_port->tx_irq = irqres[0].start;
+	ltq_port->rx_irq = irqres[1].start;
+	ltq_port->err_irq = irqres[2].start;
+	port->irq = irqres[0].start;
+
+	return 0;
+}
+
+static int request_irq_lantiq(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+	int retval;
+
+	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
+			     0, "asc_tx", port);
+	if (retval) {
+		dev_err(port->dev, "failed to request asc_tx\n");
+		return retval;
+	}
+
+	retval = request_irq(ltq_port->rx_irq, lqasc_rx_int,
+			     0, "asc_rx", port);
+	if (retval) {
+		dev_err(port->dev, "failed to request asc_rx\n");
+		goto err1;
+	}
+
+	retval = request_irq(ltq_port->err_irq, lqasc_err_int,
+			     0, "asc_err", port);
+	if (retval) {
+		dev_err(port->dev, "failed to request asc_err\n");
+		goto err2;
+	}
+	return 0;
+
+err2:
+	free_irq(ltq_port->rx_irq, port);
+err1:
+	free_irq(ltq_port->tx_irq, port);
+	return retval;
+}
+
+static void free_irq_lantiq(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	free_irq(ltq_port->tx_irq, port);
+	free_irq(ltq_port->rx_irq, port);
+	free_irq(ltq_port->err_irq, port);
+}
+
 static int __init
 lqasc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
-	struct resource *mmres, irqres[3];
+	struct resource *mmres;
 	int line;
 	int ret;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ret = of_irq_to_resource_table(node, irqres, 3);
-	if (!mmres || (ret != 3)) {
+	if (!mmres) {
 		dev_err(&pdev->dev,
-			"failed to get memory/irq for serial port\n");
+			"failed to get memory for serial port\n");
 		return -ENODEV;
 	}
 
+	ltq_port = devm_kzalloc(&pdev->dev, sizeof(struct ltq_uart_port),
+				GFP_KERNEL);
+	if (!ltq_port)
+		return -ENOMEM;
+
+	port = &ltq_port->port;
+
+	ltq_port->soc = of_device_get_match_data(&pdev->dev);
+	ret = ltq_port->soc->fetch_irq(&pdev->dev, ltq_port);
+	if (ret)
+		return ret;
+
 	/* get serial id */
 	line = of_alias_get_id(node, "serial");
 	if (line < 0) {
@@ -743,13 +800,6 @@ lqasc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	ltq_port = devm_kzalloc(&pdev->dev, sizeof(struct ltq_uart_port),
-			GFP_KERNEL);
-	if (!ltq_port)
-		return -ENOMEM;
-
-	port = &ltq_port->port;
-
 	port->iotype	= SERIAL_IO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops	= &lqasc_pops;
@@ -758,7 +808,6 @@ lqasc_probe(struct platform_device *pdev)
 	port->line	= line;
 	port->dev	= &pdev->dev;
 	/* unused, just to be backward-compatible */
-	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
 	if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
@@ -778,10 +827,6 @@ lqasc_probe(struct platform_device *pdev)
 	else
 		ltq_port->clk = devm_clk_get(&pdev->dev, "asc");
 
-	ltq_port->tx_irq = irqres[0].start;
-	ltq_port->rx_irq = irqres[1].start;
-	ltq_port->err_irq = irqres[2].start;
-
 	spin_lock_init(&ltq_port->lock);
 	lqasc_port[line] = ltq_port;
 	platform_set_drvdata(pdev, ltq_port);
@@ -791,8 +836,14 @@ lqasc_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct ltq_soc_data soc_data_lantiq = {
+	.fetch_irq = fetch_irq_lantiq,
+	.request_irq = request_irq_lantiq,
+	.free_irq = free_irq_lantiq,
+};
+
 static const struct of_device_id ltq_asc_match[] = {
-	{ .compatible = "lantiq,asc" },
+	{ .compatible = "lantiq,asc", .data = &soc_data_lantiq },
 	{},
 };
 
-- 
2.11.0

