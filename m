Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7735C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A366A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gbBFvw9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfEUPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:47:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbfEUPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:47:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LFkWKv028109;
        Tue, 21 May 2019 17:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=/FwJ1TQFru+32XoeDMyEaHFno8vBWsvjxdibmbx8Z44=;
 b=gbBFvw9PfoW4Jz1Z5DI5evS/YoZjHP52RrV3HaNP/qCmI+pE+lF5J1aHrDRpoiRo8ugv
 eueMNl8Oed88Ojs9BomX52FAr+86xmAVlTb9LN5sy2P9u4FK5YumzMcNjrr7SufkZR2e
 s2G6lVfq6UDuTD0jexrlTomUSgiG7BYulNcqB8pStV9yxmtnsQCovd8Z7d2gdfE/KgsU
 eakofKIn0tJPCHqWS23ZnEOHpj+aJmX0aJNXEkobP+WRF5gl+WuhgS06y2i44abJAAq9
 sRnfNEMpyLqUOp/PiFW5kJlJB9el1v4bkkep7gvNuXihyWVl6NKXkdnokN0IN0vEncKF kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7h0tkyr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 17:46:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 522913A;
        Tue, 21 May 2019 15:46:45 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35CBE2CED;
        Tue, 21 May 2019 15:46:45 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May
 2019 17:46:45 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May 2019 17:46:43
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Erwan Le Ray" <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        "Fabien Dessenne" <fabien.dessenne@st.com>
Subject: [PATCH 7/7] serial: stm32: fix the get_irq error case
Date:   Tue, 21 May 2019 17:45:47 +0200
Message-ID: <1558453547-22866-8-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
References: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks the returned values of platform_get_irq() for both required
"event" and optional "wakeup" IRQs during probe. This allows the driver
probe to be deferred if needed.
Removes redundant checks for 'cfg.has_wakeup'.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1334e42..9c2b04e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -852,12 +852,31 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
-	port->irq	= platform_get_irq(pdev, 0);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get event IRQ: %d\n", ret);
+		return ret ? ret : -ENODEV;
+	}
+	port->irq = ret;
+
 	port->rs485_config = stm32_config_rs485;
 
 	stm32_init_rs485(port, pdev);
 
-	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	if (stm32port->info->cfg.has_wakeup) {
+		stm32port->wakeirq = platform_get_irq(pdev, 1);
+		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO) {
+			if (stm32port->wakeirq != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"Can't get event wake IRQ: %d\n",
+					stm32port->wakeirq);
+			return stm32port->wakeirq ? stm32port->wakeirq :
+				-ENODEV;
+		}
+	}
+
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1064,7 +1083,7 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0) {
+	if (stm32port->wakeirq > 0) {
 		ret = device_init_wakeup(&pdev->dev, true);
 		if (ret)
 			goto err_uninit;
@@ -1094,11 +1113,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	return 0;
 
 err_wirq:
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+	if (stm32port->wakeirq > 0)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
 err_nowup:
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+	if (stm32port->wakeirq > 0)
 		device_init_wakeup(&pdev->dev, false);
 
 err_uninit:
@@ -1112,7 +1131,6 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
@@ -1134,7 +1152,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
-	if (cfg->has_wakeup && stm32_port->wakeirq >= 0) {
+	if (stm32_port->wakeirq > 0) {
 		dev_pm_clear_wake_irq(&pdev->dev);
 		device_init_wakeup(&pdev->dev, false);
 	}
@@ -1252,7 +1270,7 @@ static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
-	if (!cfg->has_wakeup || stm32_port->wakeirq < 0)
+	if (stm32_port->wakeirq <= 0)
 		return;
 
 	if (enable) {
-- 
1.9.1

