Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A52173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbfGRM6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:58:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45995 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726608AbfGRM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:58:51 -0400
X-UUID: a0ecc646d1484f3ebc25b94386ad14df-20190718
X-UUID: a0ecc646d1484f3ebc25b94386ad14df-20190718
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <changqi.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1402023343; Thu, 18 Jul 2019 20:58:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 20:58:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 20:58:41 +0800
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
Subject: [PATCH v2] serial: 8250-mtk: modify mtk uart power and clock management
Date:   Thu, 18 Jul 2019 20:58:36 +0800
Message-ID: <1563454716-8355-1-git-send-email-changqi.hu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify mtk uart runtime interface, enable uart clock before register.

Signed-off-by: Changqi Hu <changqi.hu@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b0113d1..a07c8ae 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -389,7 +389,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(data->line);
 
-	/*wait until UART in idle status*/
+	/* wait until UART in idle status */
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
@@ -426,23 +426,15 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 static void
 mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	if (!state) {
-		if (!(up->capabilities & UART_CAP_RPM))
-			mtk8250_runtime_resume(port->dev);
-		else
+	if (!state)
+		if (!mtk8250_runtime_resume(port->dev))
 			pm_runtime_get_sync(port->dev);
-	}
 
 	serial8250_do_pm(port, state, old);
 
-	if (state) {
-		if (!(up->capabilities & UART_CAP_RPM))
+	if (state)
+		if (!pm_runtime_put_sync_suspend(port->dev))
 			mtk8250_runtime_suspend(port->dev);
-		else
-			pm_runtime_put_sync_suspend(port->dev);
-	}
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -554,6 +546,9 @@ static int mtk8250_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(&pdev->dev);
+	err = mtk8250_runtime_resume(&pdev->dev);
+	if (err)
+		return err;
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
-- 
1.8.1.1.dirty

