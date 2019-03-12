Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE150C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864612147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCLO7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:59:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfCLO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:46 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2VKr-1gv1YW3fcl-013wCV; Tue, 12 Mar 2019 15:57:59 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drivers: tty: serial: 8250_ingenic: use devm_ioremap_resource()
Date:   Tue, 12 Mar 2019 15:57:35 +0100
Message-Id: <1552402660-31730-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:thA4UC77PIi9r7aMo9YO/wWIkrDunLceVvD/w7UieSa3NllqYkQ
 iX7eKeu2NKb2hvBOlhl2Ify+E9Np9McXGiHwBYCchxZvlHQQiJF01s0ss8BsIJ15I4kEQM3
 P5yWsqQEg/j9LYL9LLRaKq2o6MG1H4OuHZAygSYUn8o5rAHsotq7C5YZ/tl1142rScYLYwS
 5502cxruJjeB2haaNcs7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:15gx4hq1iDY=:aMocQ0noojZQuWoYW58L24
 Hm4FTgsfQ0EcopSKdmU9rGm/uyDYyhXw6g6cxqGWTXKABP7MUxudSufLKCwhkIjh0fpP32FpV
 sfjLKNaZfitK+fF3RZnLS7AaTxLp7+iukjHfTYKmJ8tvZk5bPiEMthQoPIGhypyjbDlQKvEBJ
 gsU2raGsktmR2YE6n8/1mTsRpUJaTvSa4Ha1nc94jHl+vV6zPyTyW8mq4cPswH20fsR555/Au
 ifrfUUDTsyVOZ91G2GyQtMneKdn+iEz40c65vtZht4HEzOs8UU/eb9IW1PjAVCIJhgDAFRG+b
 uDDz7NCmnJTOPv9eJM+qHjwwYan4qfBgQ1Kfw96pDzh6/tvdpaXUqL9WGDGvYfQkphtBwXpEN
 Q3wbxFiyVF2RBXQOv35/RZuiWRG+NDDQ5QN06KKhYtXzax5Ao87RqICMmfUrGYWLYqA17k6vD
 6qIh5G99QqaatH6iVUjnEELRZ05DRgiNOx5mjbiMm3RtAYQ95tT3eC9VGlRNgYcGJD59O1BOV
 ZOOSGrR2Z/LAI2c0OEr7ISXvJCl9bBdeDYL1yoig/XmrmxQLfF/EfnZtcAgmR8emUrqoDVAQA
 TlV5nymNlJfLOMFLzRUStG/vzqOCkXp8hMg5T67EY2aCsom94j31wardjKrJLrlF6pZfSp/Pq
 LUmhC7i1FLwrmFKNnSu56zdOuyU2DdYcUo9yMpsE1Qtvefz6w2FU03lMGRR8B+BrndmtB6pth
 FSx/53ZXodSXGohHSYcx4iwJY4oaw6Hd9NPhCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper devm_ioremap_resource() to make the code a little bit
shorter and easier to read.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c..90ae3e2 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -249,8 +249,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	if (line >= 0)
 		uart.port.line = line;
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

