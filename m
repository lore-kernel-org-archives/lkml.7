Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43ED21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfICFbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:31:13 -0400
Received: from mx.socionext.com ([202.248.49.38]:49356 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfICFbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:31:11 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Sep 2019 14:31:05 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 52837605F8;
        Tue,  3 Sep 2019 14:31:05 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 3 Sep 2019 14:31:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id DF561403C1;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B5E011204B3;
        Tue,  3 Sep 2019 14:31:04 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
Subject: [PATCH 1/3] spi: uniphier: fix wrong register overwrite
Date:   Tue,  3 Sep 2019 14:30:59 +0900
Message-Id: <1567488661-11428-2-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it changes the spi mode, the register is overwritten incorrectly.
This commit fixes this register overwrite.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c1e6f32..e6ebbb1 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -214,6 +214,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 	if (!priv->is_save_param || priv->mode != spi->mode) {
 		uniphier_spi_set_mode(spi);
 		priv->mode = spi->mode;
+		priv->is_save_param = false;
 	}
 
 	if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
-- 
2.7.4

