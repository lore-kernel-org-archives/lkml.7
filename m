Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC5214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbfDRGVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:21:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:10807 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDRGVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:21:46 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Apr 2019 15:21:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 2C9D41800F6;
        Thu, 18 Apr 2019 15:21:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 18 Apr 2019 15:21:45 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 062DB1A15B7;
        Thu, 18 Apr 2019 15:21:45 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E29D91217B3;
        Thu, 18 Apr 2019 15:21:44 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH] serial: Fix using plain integer instead of Null pointer
Date:   Thu, 18 Apr 2019 15:21:25 +0900
Message-Id: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning that using plain integer as Null pointer.
This is reported by kbuild test robot.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/tty/serial/milbeaut_usio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index d303b7d..4a10604 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -500,7 +500,7 @@ static int __init mlb_usio_early_console_setup(struct earlycon_device *device,
 
 static int mlb_usio_probe(struct platform_device *pdev)
 {
-	struct clk *clk = devm_clk_get(&pdev->dev, 0);
+	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
 	struct uart_port *port;
 	struct resource *res;
 	int index = 0;
-- 
1.9.1

