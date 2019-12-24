Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67137206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLXA7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 19:59:02 -0500
Received: from mx.socionext.com ([202.248.49.38]:23640 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfLXA6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:58:50 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 24 Dec 2019 09:58:48 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id C4C45603AB;
        Tue, 24 Dec 2019 09:58:48 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 24 Dec 2019 09:59:28 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4149E1A01CF;
        Tue, 24 Dec 2019 09:58:48 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/5] spi: uniphier: Add handle_err callback function
Date:   Tue, 24 Dec 2019 09:58:25 +0900
Message-Id: <1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds master->handle_err() callback function to stop transfer due to
error. The function also resets FIFOs and disables interrupt.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-uniphier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 3859649..c4e3b96 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -432,6 +432,22 @@ static int uniphier_spi_unprepare_transfer_hardware(struct spi_master *master)
 	return 0;
 }
 
+static void uniphier_spi_handle_err(struct spi_master *master,
+				    struct spi_message *msg)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	u32 val;
+
+	/* stop running spi transfer */
+	writel(0, priv->base + SSI_CTL);
+
+	/* reset FIFOs */
+	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
+	writel(val, priv->base + SSI_FC);
+
+	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
+}
+
 static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
 {
 	struct uniphier_spi_priv *priv = dev_id;
@@ -538,6 +554,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 				= uniphier_spi_prepare_transfer_hardware;
 	master->unprepare_transfer_hardware
 				= uniphier_spi_unprepare_transfer_hardware;
+	master->handle_err = uniphier_spi_handle_err;
 	master->num_chipselect = 1;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-- 
2.7.4

