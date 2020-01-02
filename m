Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C28C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BAD21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578006056;
	bh=3CZRpoCYbEuB7Sm43TDfe1oKWGuVqkSm8Cgi9hPRVvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wn8V5L8dHF9XfpxqLURQy0YDZBiN6WmlZctH/Yhx/4LfaeZYvUMPFVXgTQb7OuWK0
	 iTgHT8guRfdBo8Oi9SwNFcnP6sB47tsXQYx97wJkqytT43zUx3N3RKdLIOHp4sZxbG
	 DLlRQzuyRu5tn11Q6zWFN/qyBpZJtXyN0XXuk34c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgABXAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgABWMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:12:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E098221835;
        Thu,  2 Jan 2020 22:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003136;
        bh=3CZRpoCYbEuB7Sm43TDfe1oKWGuVqkSm8Cgi9hPRVvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDe/BcE5Pv/KKbBVRHeg53QgRMoRhJIthjdTItdUc/gh7IedhNe5b2jR3EdnDr1gp
         Lz8wNcXRITXDyGey+e4nAxNCB0mLqTFPYZZucBoavWwB+j0I+GJssDWLqYlfp/7u5y
         8A3vjJEKLiW/KuBzAMo8rB5667w+bn/+EIf1AOeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 008/191] gpio: mxc: Only get the second IRQ when there is more than one IRQ
Date:   Thu,  2 Jan 2020 23:04:50 +0100
Message-Id: <20200102215830.678377647@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit c8f3d144004dd3f471ffd414690d15a005e4acd6 ]

On some of i.MX SoCs like i.MX8QXP, there is ONLY one IRQ for each
GPIO bank, so it is better to check the IRQ count before getting
second IRQ to avoid below error message during probe:

[    1.070908] gpio-mxc 5d080000.gpio: IRQ index 1 not found
[    1.077420] gpio-mxc 5d090000.gpio: IRQ index 1 not found
[    1.083766] gpio-mxc 5d0a0000.gpio: IRQ index 1 not found
[    1.090122] gpio-mxc 5d0b0000.gpio: IRQ index 1 not found
[    1.096470] gpio-mxc 5d0c0000.gpio: IRQ index 1 not found
[    1.102804] gpio-mxc 5d0d0000.gpio: IRQ index 1 not found
[    1.109144] gpio-mxc 5d0e0000.gpio: IRQ index 1 not found
[    1.115475] gpio-mxc 5d0f0000.gpio: IRQ index 1 not found

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mxc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 7907a8755866..c77d474185f3 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -411,6 +411,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
+	int irq_count;
 	int irq_base;
 	int err;
 
@@ -426,9 +427,15 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
 
-	port->irq_high = platform_get_irq(pdev, 1);
-	if (port->irq_high < 0)
-		port->irq_high = 0;
+	irq_count = platform_irq_count(pdev);
+	if (irq_count < 0)
+		return irq_count;
+
+	if (irq_count > 1) {
+		port->irq_high = platform_get_irq(pdev, 1);
+		if (port->irq_high < 0)
+			port->irq_high = 0;
+	}
 
 	port->irq = platform_get_irq(pdev, 0);
 	if (port->irq < 0)
-- 
2.20.1



