Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4375C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C76208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393940AbfIJP3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:29:53 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47699 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfIJP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:29:53 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 19DB860012;
        Tue, 10 Sep 2019 15:29:50 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/3] gpio: syscon: Add support for a custom get operation
Date:   Tue, 10 Sep 2019 17:28:53 +0200
Message-Id: <20190910152855.111588-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers might need a custom get operation to match custom
behavior implemented in the set operation.

Add plumbing for supporting that.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpio/gpio-syscon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 31f332074d7d..05c537ed73f1 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -43,8 +43,9 @@ struct syscon_gpio_data {
 	unsigned int	bit_count;
 	unsigned int	dat_bit_offset;
 	unsigned int	dir_bit_offset;
-	void		(*set)(struct gpio_chip *chip,
-			       unsigned offset, int value);
+	int		(*get)(struct gpio_chip *chip, unsigned offset);
+	void		(*set)(struct gpio_chip *chip, unsigned offset,
+			       int value);
 };
 
 struct syscon_gpio_priv {
@@ -252,7 +253,7 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	priv->chip.label = dev_name(dev);
 	priv->chip.base = -1;
 	priv->chip.ngpio = priv->data->bit_count;
-	priv->chip.get = syscon_gpio_get;
+	priv->chip.get = priv->data->get ? : syscon_gpio_get;
 	if (priv->data->flags & GPIO_SYSCON_FEAT_IN)
 		priv->chip.direction_input = syscon_gpio_dir_in;
 	if (priv->data->flags & GPIO_SYSCON_FEAT_OUT) {
-- 
2.23.0

