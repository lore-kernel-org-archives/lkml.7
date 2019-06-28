Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953FC46478
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD512133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfF1Kly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:41:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1Klx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:41:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUD7D-1i7Nb429UB-00RL08; Fri, 28 Jun 2019 12:41:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: davinci_voicecodec: remove pointless #include
Date:   Fri, 28 Jun 2019 12:41:22 +0200
Message-Id: <20190628104132.2791616-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vhVXoLeqKXMn0+9LfigQM3R2EGN0KWX0jx3S6cH5lheI6R++ykD
 PGlHix3EwmomFlILJl1suu+nxt1njb9uE8Bm1FKqdx3gu/C0OIvSONUUbKzgaj1iCmCdLAt
 zlxgrG14J4jwkBDnH8VaKM58btsoMAXr8U+I94w4CLS7iF4dHiLtVOlzrNPvL06ml1qVEED
 fQpI8lf90Pf2uEboWhMOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jGbO6oPkDPo=:D2FW8L4GGuL63suwBhrlVl
 fC6qm38w7oll4AQjjedX15qcIbSQXv5pWArxXNMa+oQa9Qh7Je9nj27mUUwdURIfpWZtItIP+
 cATJswf5LOZ4+2EdTzuM9wAv+/uVzEpr+9hlBdWAgfFNoSD8q0LXqfbx6/P3+v3anQyZvSINI
 zWLuSPQcA/5eZdIRjLvLKzTzYHzqTqgUo13mMOE+kZfGLZwloyZ1o7h1WYct6QiLbAfM5NWML
 EzT4QoGXORU1cNbK8Qm3559aDEsRqv8kDiyg05PjA0JGZ8Dinr0gE+7kW8jhwXxvvlDDR+asO
 nyRpDUK8ka1VXyoM1nUWEXluEjOT5NVug2SL1M1TZ8zC4mm/y2JYT9jqcIoGjNiSMtrs/Qsq2
 UA+IM2UOfDMb8hjxZGyJahboalXJvrusfS1rysEvXVCX6MW9d9hC5V/053j+AFYacU9VM38r/
 Q2rrktc0A2GUPIOQ2DuVhhT9QY5F3MdRDkMYygwCyM8chh5PrpIa8zJgqMyg6TEZksJG5Qf57
 Qxe1blBHg/AZ+pibJFJswwSuvMw/kx1P1LR8KjZyBt64ClXdFAaAtd2GB4I89Ffo0Eo9zJ447
 i/Qc72Nef4TWCnTVsE3y2PI7CmKK1kl/n7J4NWCKQsFkCDpekWTgxdMcwYMNECE4lyKWQYN6S
 wVE3r5daifPTPDQwVkuPxAUGJP/us2/bs6EvJTRskr6TlvpRgJOUR3RKWISbss57BNYWuKCLq
 +M7YWEJCHURWJqFsrUWq1bDykmpeSuvQUC9jQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building davinci as multiplatform, we get a build error
in this file:

drivers/mfd/davinci_voicecodec.c:22:10: fatal error: 'mach/hardware.h' file not found

The header is only used to access the io_v2p() macro, but the
result is already known because that comes from the resource
a little bit earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/davinci_voicecodec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index 13ca7203e193..e5c8bc998eb4 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 
 #include <linux/mfd/davinci_voicecodec.h>
-#include <mach/hardware.h>
 
 static const struct regmap_config davinci_vc_regmap = {
 	.reg_bits = 32,
@@ -31,6 +30,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	struct davinci_vc *davinci_vc;
 	struct resource *res;
 	struct mfd_cell *cell = NULL;
+	dma_addr_t fifo_base;
 	int ret;
 
 	davinci_vc = devm_kzalloc(&pdev->dev,
@@ -48,6 +48,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
+	fifo_base = (dma_addr_t)res->start;
 	davinci_vc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(davinci_vc->base)) {
 		ret = PTR_ERR(davinci_vc->base);
@@ -70,8 +71,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	}
 
 	davinci_vc->davinci_vcif.dma_tx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_tx_addr =
-		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_WFIFO);
+	davinci_vc->davinci_vcif.dma_tx_addr = fifo_base + DAVINCI_VC_WFIFO;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -81,8 +81,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	}
 
 	davinci_vc->davinci_vcif.dma_rx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_rx_addr =
-		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_RFIFO);
+	davinci_vc->davinci_vcif.dma_rx_addr = fifo_base + DAVINCI_VC_RFIFO;
 
 	davinci_vc->dev = &pdev->dev;
 	davinci_vc->pdev = pdev;
-- 
2.20.0

