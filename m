Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D229223401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620256;
	bh=z7dm4AA2ULE5iGAB7SozRx/Ck4WKdrAiJM6pw+ys/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y8okPBWLpGbAdbkHsiW1pRk8qDhVOWyYg1k8xTsunVM+BjFZu6/FTuVjZ+uV5rkFD
	 AxzfXB4DbMCAjHzFzdk+A/jjJRJbxIKiGvS8UqzCildONi3O3jLqSdTwVOkg6DjKAX
	 bRR+8V8AnTZhLgp98e5wA6Z9kA8kHIB/9UFaYEAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfIDSEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388462AbfIDSEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:04:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F96D206BA;
        Wed,  4 Sep 2019 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620251;
        bh=z7dm4AA2ULE5iGAB7SozRx/Ck4WKdrAiJM6pw+ys/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOTMg0RxpRuf9kHGXIrsQzOkYnkE3Iqvqn4GByC7e8qRqQ/m9XOv9zKb4EWLEwP3+
         7N1zpfVPFaPXXalkbv3nT4BWHp6WEgE8VIvAOJg63mTqmsP8uaVFafp9OVlC6B5obM
         7bglJFiXyPVSKQXp8eKYMVPhR+tg8EVBaicSWQvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/57] i2c: emev2: avoid race when unregistering slave client
Date:   Wed,  4 Sep 2019 19:53:36 +0200
Message-Id: <20190904175302.770724586@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d7437fc0d8291181debe032671a289b6bd93f46f ]

After we disabled interrupts, there might still be an active one
running. Sync before clearing the pointer to the slave device.

Fixes: c31d0a00021d ("i2c: emev2: add slave support")
Reported-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-emev2.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index d2e84480fbe96..dd97e5d9f49a2 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -72,6 +72,7 @@ struct em_i2c_device {
 	struct completion msg_done;
 	struct clk *sclk;
 	struct i2c_client *slave;
+	int irq;
 };
 
 static inline void em_clear_set_bit(struct em_i2c_device *priv, u8 clear, u8 set, u8 reg)
@@ -342,6 +343,12 @@ static int em_i2c_unreg_slave(struct i2c_client *slave)
 
 	writeb(0, priv->base + I2C_OFS_SVA0);
 
+	/*
+	 * Wait for interrupt to finish. New slave irqs cannot happen because we
+	 * cleared the slave address and, thus, only extension codes will be
+	 * detected which do not use the slave ptr.
+	 */
+	synchronize_irq(priv->irq);
 	priv->slave = NULL;
 
 	return 0;
@@ -358,7 +365,7 @@ static int em_i2c_probe(struct platform_device *pdev)
 {
 	struct em_i2c_device *priv;
 	struct resource *r;
-	int irq, ret;
+	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -393,8 +400,8 @@ static int em_i2c_probe(struct platform_device *pdev)
 
 	em_i2c_reset(&priv->adap);
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, em_i2c_irq_handler, 0,
+	priv->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, priv->irq, em_i2c_irq_handler, 0,
 				"em_i2c", priv);
 	if (ret)
 		goto err_clk;
@@ -404,7 +411,8 @@ static int em_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	dev_info(&pdev->dev, "Added i2c controller %d, irq %d\n", priv->adap.nr, irq);
+	dev_info(&pdev->dev, "Added i2c controller %d, irq %d\n", priv->adap.nr,
+		 priv->irq);
 
 	return 0;
 
-- 
2.20.1



