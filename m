Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C92339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620345;
	bh=nWGqu5LvfO5GpMioG9+wuNyHYM4Bt3PWimoGc8ZaEzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9kwEasWUxn0JBv+GF0exUcfL8n72TCuklSH7G9iNlrBdRqwHZKNPrvunVi48VIYA
	 7qosKKCfaPzixypS18y3NX6BN4Y+6XSkqwvcd6kLSX2kNVtN5216JNlx9fEFdsz3pn
	 e0nyy6tTYrWgxtnoqiNx+WGhJs7WcFLN6aAWnljU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbfIDSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389297AbfIDSFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421E723404;
        Wed,  4 Sep 2019 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620339;
        bh=nWGqu5LvfO5GpMioG9+wuNyHYM4Bt3PWimoGc8ZaEzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVyLrUNaogrtJVa5TiSUfiuNh78a/oIbih4lRHanVwuhEBsSe8dSthp9+Lq4Ks5+W
         15RxuZdzXZleVkkhwbIAX02ymZaqOZENDvMzHdAAT1zQt3OV7B7ZO2UMrtJSbnGpXR
         k8Jhqa3TlrzzeJuCqghinZu4fk7uW2rf+LMC3P9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/93] i2c: emev2: avoid race when unregistering slave client
Date:   Wed,  4 Sep 2019 19:53:23 +0200
Message-Id: <20190904175305.131987137@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
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
index 35b302d983e0d..959d4912ec0d5 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -69,6 +69,7 @@ struct em_i2c_device {
 	struct completion msg_done;
 	struct clk *sclk;
 	struct i2c_client *slave;
+	int irq;
 };
 
 static inline void em_clear_set_bit(struct em_i2c_device *priv, u8 clear, u8 set, u8 reg)
@@ -339,6 +340,12 @@ static int em_i2c_unreg_slave(struct i2c_client *slave)
 
 	writeb(0, priv->base + I2C_OFS_SVA0);
 
+	/*
+	 * Wait for interrupt to finish. New slave irqs cannot happen because we
+	 * cleared the slave address and, thus, only extension codes will be
+	 * detected which do not use the slave ptr.
+	 */
+	synchronize_irq(priv->irq);
 	priv->slave = NULL;
 
 	return 0;
@@ -355,7 +362,7 @@ static int em_i2c_probe(struct platform_device *pdev)
 {
 	struct em_i2c_device *priv;
 	struct resource *r;
-	int irq, ret;
+	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -390,8 +397,8 @@ static int em_i2c_probe(struct platform_device *pdev)
 
 	em_i2c_reset(&priv->adap);
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, em_i2c_irq_handler, 0,
+	priv->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, priv->irq, em_i2c_irq_handler, 0,
 				"em_i2c", priv);
 	if (ret)
 		goto err_clk;
@@ -401,7 +408,8 @@ static int em_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	dev_info(&pdev->dev, "Added i2c controller %d, irq %d\n", priv->adap.nr, irq);
+	dev_info(&pdev->dev, "Added i2c controller %d, irq %d\n", priv->adap.nr,
+		 priv->irq);
 
 	return 0;
 
-- 
2.20.1



