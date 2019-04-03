Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7953C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3AA214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:47:01 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:37416 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:47:00 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id vqmy1z00K3XaVaC01qmyXq; Wed, 03 Apr 2019 16:46:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBhAI-0003ah-Aj; Wed, 03 Apr 2019 16:46:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBhAI-00029w-9J; Wed, 03 Apr 2019 16:46:58 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: Add missing error handling for CS GPIOs
Date:   Wed,  3 Apr 2019 16:46:56 +0200
Message-Id: <20190403144656.8257-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
present (i.e. -ENOENT), it may still return other error codes, like
-EPROBE_DEFER.  Currently these are not handled, leading to
unrecoverable failures later in case of probe deferral:

    gpiod_set_consumer_name: invalid GPIO (errorpointer)
    gpiod_direction_output: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)

Detect and propagate errors to fix this.

Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bd2a424672df266c..2ad20c735b61c4aa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2199,6 +2199,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		 */
 		cs[i] = devm_gpiod_get_index_optional(dev, "cs", i,
 						      GPIOD_OUT_LOW);
+		if (IS_ERR(cs[i]))
+			return PTR_ERR(cs[i]);
 
 		if (cs[i]) {
 			/*
-- 
2.17.1

