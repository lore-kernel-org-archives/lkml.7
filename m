Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F302CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E220650
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfJ0GV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:21:56 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:36188 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfJ0GVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:21:55 -0400
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 75BCD96C06;
        Sun, 27 Oct 2019 06:21:51 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id D3DD543C53;
        Sun, 27 Oct 2019 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-217.61.153.185.bambit.de [217.61.153.185])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 369AB403C2;
        Sun, 27 Oct 2019 06:21:51 +0000 (UTC)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250-mtk: Use platform_get_irq_optional() for optional irq
Date:   Sun, 27 Oct 2019 07:21:17 +0100
Message-Id: <20191027062117.20389-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, this warnings are printed on bananapi-r2:

[    4.935780] mt6577-uart 11004000.serial: IRQ index 1 not found
[    4.962589] 11002000.serial: ttyS1 at MMIO 0x11002000 (irq = 202, base_baud = 1625000) is a ST16650V2
[    4.972127] mt6577-uart 11002000.serial: IRQ index 1 not found
[    4.998927] 11003000.serial: ttyS2 at MMIO 0x11003000 (irq = 203, base_baud = 1625000) is a ST16650V2
[    5.008474] mt6577-uart 11003000.serial: IRQ index 1 not found

Fix this by calling platform_get_irq_optional() instead.

now it looks like this:

[    4.872751] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes since v1:
	https://patchwork.kernel.org/patch/11213813/
	change from platform_irq_count to platform_get_irq_optional
---
 drivers/tty/serial/8250/8250_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b411ba4eb5e9..4d067f515f74 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -544,7 +544,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	data->rx_wakeup_irq = platform_get_irq(pdev, 1);
+	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
 
 	return 0;
 }
-- 
2.17.1

