Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E875220857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCRMzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:55:54 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58963 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:55:54 -0400
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C756924000C;
        Mon, 18 Mar 2019 12:55:51 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: axp20x: Allow the AXP223 to be probed by i2c
Date:   Mon, 18 Mar 2019 13:55:48 +0100
Message-Id: <20190318125548.24851-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP223 can be used both using the RSB proprietary bus, or a more
traditional I2C bus. The RSB is a faster bus and provides more features
(like some integrity checks on the messages), so it's usually preferrable
to use it, but since it's proprietary, when we want to use the PMIC in a
multi-master setup, the i2c might make sense as well.

Let's add that possibility.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mfd/axp20x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index a7b7c5423ea5..c2e8a0dee7f8 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
 	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
+	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ },
 };
@@ -75,6 +76,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp202", 0 },
 	{ "axp209", 0 },
 	{ "axp221", 0 },
+	{ "axp223", 0 },
 	{ "axp806", 0 },
 	{ },
 };
-- 
2.20.1

