Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D80921855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NpvI9a0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfDTKLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54568 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfDTKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAsha023762;
        Sat, 20 Apr 2019 05:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755054;
        bh=iXUXUm4QoDhPmhf12xtdYiS+6qxDPoq2OQmGpFJkuFU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NpvI9a0Loe5B1S9BUyiPnsoOgQK8KzeXb2pik8ijlxoncTqMhyaNrZm/a1kHLCzqx
         6bXCgzC/54I7J7vEPJgC/76zVVRPfwEkfPtEraa74Dg4OBOnq+Yrrr7oPHQVx5S2sU
         MajlbCZVsfdRibGMzVxC1KVnehijDrFab84ntX/M=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KAAsNn060173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:10:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:10:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:10:54 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHZw070234;
        Sat, 20 Apr 2019 05:10:50 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v7 07/14] gpio: thunderx: Use the default parent apis for {request,release}_resources
Date:   Sat, 20 Apr 2019 15:39:43 +0530
Message-ID: <20190420100950.7997-8-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420100950.7997-1-lokeshvutla@ti.com>
References: <20190420100950.7997-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thunderx_gpio_irq_{request,release}_resources apis are trying to
{request,release} resources on parent interrupt. There are default
apis doing the same. Use the default parent apis instead of writing
the same code snippet.

Cc: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v6:
- new patch

 drivers/gpio/gpio-thunderx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 1306722faa5a..715371b5102a 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -363,22 +363,16 @@ static int thunderx_gpio_irq_request_resources(struct irq_data *data)
 {
 	struct thunderx_line *txline = irq_data_get_irq_chip_data(data);
 	struct thunderx_gpio *txgpio = txline->txgpio;
-	struct irq_data *parent_data = data->parent_data;
 	int r;
 
 	r = gpiochip_lock_as_irq(&txgpio->chip, txline->line);
 	if (r)
 		return r;
 
-	if (parent_data && parent_data->chip->irq_request_resources) {
-		r = parent_data->chip->irq_request_resources(parent_data);
-		if (r)
-			goto error;
-	}
+	r = irq_chip_request_resources_parent(data);
+	if (r)
+		gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
 
-	return 0;
-error:
-	gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
 	return r;
 }
 
@@ -386,10 +380,8 @@ static void thunderx_gpio_irq_release_resources(struct irq_data *data)
 {
 	struct thunderx_line *txline = irq_data_get_irq_chip_data(data);
 	struct thunderx_gpio *txgpio = txline->txgpio;
-	struct irq_data *parent_data = data->parent_data;
 
-	if (parent_data && parent_data->chip->irq_release_resources)
-		parent_data->chip->irq_release_resources(parent_data);
+	irq_chip_release_resources_parent(data);
 
 	gpiochip_unlock_as_irq(&txgpio->chip, txline->line);
 }
-- 
2.21.0

