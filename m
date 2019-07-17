Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0467C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54742173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGQMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:54:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20099 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbfGQMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:54:47 -0400
X-UUID: 1bd4ee1fab2d47dd858a01cd016cad59-20190717
X-UUID: 1bd4ee1fab2d47dd858a01cd016cad59-20190717
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <changqi.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 896351659; Wed, 17 Jul 2019 20:54:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Jul 2019 20:54:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Jul 2019 20:54:42 +0800
From:   Changqi Hu <changqi.hu@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Changqi Hu <changqi.hu@mediatek.com>,
        Peter Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH] modify mtk uart power and clock management
Date:   Wed, 17 Jul 2019 20:54:39 +0800
Message-ID: <1563368079-29684-1-git-send-email-changqi.hu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify mtk uart runtime interface, add uart clock use count.

Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 65 ++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f470ded..b0113d1 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -31,6 +31,7 @@
 #define MTK_UART_RXTRI_AD	0x14	/* RX Trigger address */
 #define MTK_UART_FRACDIV_L	0x15	/* Fractional divider LSB address */
 #define MTK_UART_FRACDIV_M	0x16	/* Fractional divider MSB address */
+#define MTK_UART_DEBUG0	0x18
 #define MTK_UART_IER_XOFFI	0x20	/* Enable XOFF character interrupt */
 #define MTK_UART_IER_RTSI	0x40	/* Enable RTS Modem status interrupt */
 #define MTK_UART_IER_CTSI	0x80	/* Enable CTS Modem status interrupt */
@@ -386,9 +387,18 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(data->line);
 
-	clk_disable_unprepare(data->uart_clk);
-	clk_disable_unprepare(data->bus_clk);
+	/*wait until UART in idle status*/
+	while
+		(serial_in(up, MTK_UART_DEBUG0));
+
+	if (data->clk_count == 0U) {
+		dev_dbg(dev, "%s clock count is 0\n", __func__);
+	} else {
+		clk_disable_unprepare(data->bus_clk);
+		data->clk_count--;
+	}
 
 	return 0;
 }
@@ -398,16 +408,16 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	int err;
 
-	err = clk_prepare_enable(data->uart_clk);
-	if (err) {
-		dev_warn(dev, "Can't enable clock\n");
-		return err;
-	}
-
-	err = clk_prepare_enable(data->bus_clk);
-	if (err) {
-		dev_warn(dev, "Can't enable bus clock\n");
-		return err;
+	if (data->clk_count > 0U) {
+		dev_dbg(dev, "%s clock count is %d\n", __func__,
+			data->clk_count);
+	} else {
+		err = clk_prepare_enable(data->bus_clk);
+		if (err) {
+			dev_warn(dev, "Can't enable bus clock\n");
+			return err;
+		}
+		data->clk_count++;
 	}
 
 	return 0;
@@ -416,13 +426,23 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 static void
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
-	if (!state)
-		pm_runtime_get_sync(port->dev);
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (!state) {
+		if (!(up->capabilities & UART_CAP_RPM))
+			mtk8250_runtime_resume(port->dev);
+		else
+			pm_runtime_get_sync(port->dev);
+	}
 
 	serial8250_do_pm(port, state, old);
 
-	if (state)
-		pm_runtime_put_sync_suspend(port->dev);
+	if (state) {
+		if (!(up->capabilities & UART_CAP_RPM))
+			mtk8250_runtime_suspend(port->dev);
+		else
+			pm_runtime_put_sync_suspend(port->dev);
+	}
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -499,6 +519,8 @@ static int mtk8250_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->clk_count = 0;
+
 	if (pdev->dev.of_node) {
 		err = mtk8250_probe_of(pdev, &uart.port, data);
 		if (err)
@@ -531,17 +553,12 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	err = mtk8250_runtime_resume(&pdev->dev);
-	if (err)
-		return err;
+	pm_runtime_enable(&pdev->dev);
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
@@ -552,11 +569,13 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
-	mtk8250_runtime_suspend(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mtk8250_runtime_suspend(&pdev->dev);
+
 	return 0;
 }
 
-- 
1.8.1.1.dirty

