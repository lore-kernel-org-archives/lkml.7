Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05552C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DA821874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbfHHKC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:02:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:44191 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbfHHKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:02:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 03:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="168935651"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 03:02:23 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 3/3] serial: lantiq: Add support for Lightning Mountain SoC
Date:   Thu,  8 Aug 2019 18:02:08 +0800
Message-Id: <0df20f6e4bbf9de09c85a5c92c92e642f62f441f.1565257887.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IRQ & ISR support in the driver for Lightning Mountain SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/lantiq.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index b129531dfb9a..fcbea43dc334 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -57,6 +57,7 @@
 #define ASC_IRNCR_TIR		0x1
 #define ASC_IRNCR_RIR		0x2
 #define ASC_IRNCR_EIR		0x4
+#define ASC_IRNCR_MASK		GENMASK(2, 0)
 
 #define ASCOPT_CSIZE		0x3
 #define TXFIFO_FL		1
@@ -115,6 +116,7 @@ struct ltq_uart_port {
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
 	unsigned int		err_irq;
+	unsigned int		common_irq;
 	spinlock_t		lock; /* exclusive access for multi core */
 
 	const struct ltq_soc_data	*soc;
@@ -293,6 +295,31 @@ lqasc_rx_int(int irq, void *_port)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t lqasc_irq(int irq, void *p)
+{
+	unsigned long flags;
+	u32 stat;
+	struct uart_port *port = p;
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	spin_lock_irqsave(&ltq_port->lock, flags);
+	stat = readl(port->membase + LTQ_ASC_IRNCR);
+	spin_unlock_irqrestore(&ltq_port->lock, flags);
+	if (!(stat & ASC_IRNCR_MASK))
+		return IRQ_NONE;
+
+	if (stat & ASC_IRNCR_TIR)
+		lqasc_tx_int(irq, p);
+
+	if (stat & ASC_IRNCR_RIR)
+		lqasc_rx_int(irq, p);
+
+	if (stat & ASC_IRNCR_EIR)
+		lqasc_err_int(irq, p);
+
+	return IRQ_HANDLED;
+}
+
 static unsigned int
 lqasc_tx_empty(struct uart_port *port)
 {
@@ -677,6 +704,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
+OF_EARLYCON_DECLARE(lantiq, "intel,lgm-asc", lqasc_serial_early_console_setup);
 
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
@@ -751,6 +779,42 @@ static void free_irq_lantiq(struct uart_port *port)
 	free_irq(ltq_port->err_irq, port);
 }
 
+static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
+{
+	struct uart_port *port = &ltq_port->port;
+	int ret;
+
+	ret = of_irq_get(dev->of_node, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to fetch IRQ for serial port\n");
+		return ret;
+	}
+	ltq_port->common_irq = ret;
+	port->irq = ret;
+
+	return 0;
+}
+
+static int request_irq_intel(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+	int retval;
+
+	retval = request_irq(ltq_port->common_irq, lqasc_irq, 0,
+			     "asc_irq", port);
+	if (retval)
+		dev_err(port->dev, "failed to request asc_irq\n");
+
+	return retval;
+}
+
+static void free_irq_intel(struct uart_port *port)
+{
+	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+
+	free_irq(ltq_port->common_irq, port);
+}
+
 static int __init
 lqasc_probe(struct platform_device *pdev)
 {
@@ -842,8 +906,15 @@ static const struct ltq_soc_data soc_data_lantiq = {
 	.free_irq = free_irq_lantiq,
 };
 
+static const struct ltq_soc_data soc_data_intel = {
+	.fetch_irq = fetch_irq_intel,
+	.request_irq = request_irq_intel,
+	.free_irq = free_irq_intel,
+};
+
 static const struct of_device_id ltq_asc_match[] = {
 	{ .compatible = "lantiq,asc", .data = &soc_data_lantiq },
+	{ .compatible = "intel,lgm-asc", .data = &soc_data_intel },
 	{},
 };
 
-- 
2.11.0

