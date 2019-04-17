Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5AC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4084820674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YVXA2g3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfDQUoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbfDQUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so116887wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/0TdomXHBUKD3xd8SfrSE4UbCHhoD4KBzvsG8xwG04=;
        b=YVXA2g3nzw+IxHqkm2JY+V3v11I48wdnaIC3PhrF2Xg1XEc6oNhsVpPLIvUgY+45dP
         u4jH4n6UCixqWSCtDWbEzwHFxMcpjyam67IY7urAuzvFPK7RLCP+jGxZqQtBf1lF+dgQ
         FnCDtTSdFpHb5sfaEZVKoZ7mm4b3jkEurx5k2NGx+/kAjS7wvrg5J1YD6AV+N6iWQk7q
         PXDWb4mKAojHTPwwWfeKcc4e+0dJqVtTiaZtFCl/2Sgb0y7fU1ysNLM+nA9XZ0ayzGn5
         L/tZ6Bi2BW0eJBWnApA0MFeAA90zImjE1h7NcM/sOZXQvSwE8pmtr9MlD7jTUckMqMiN
         mPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/0TdomXHBUKD3xd8SfrSE4UbCHhoD4KBzvsG8xwG04=;
        b=nwgA1fzU80S4HckNaebIORSWHMhUK/V7DE3j8uGLi1wVe68fZkPnVZZiXvWvIajudL
         DkMESZeOdGdD7YROEar9BkhkRsoiZfMnzgbesmLjs+ak4Vlly8M73xGZuxBkYjfCGKq3
         0WA3N5tktcAn3BI9Nk910r9kDAunlrh/G/F2FAlnX0k5jMvgfvly9cE67Fvq+WO7JY7t
         3fFRopbUVuxNt7/2fAPWVNAYSugyfUa0g9g8V/xJpXw0TMsCcONWwYx9Vj2u1EmfZHtm
         G9lCIA+XkC4OnFYm1dajBcGlXabtO1cTDvzBZcz4nVJMX6flKXNnweTrhTfVhtHhr1Wo
         Wy4w==
X-Gm-Message-State: APjAAAUCBjSuXZkSDBjhOsQpJoE4wSZEaD9kuAlGyqmI4qOhTQO7hp3F
        Sw8WJj0M5FSAyHfRpYrv2/lUjw==
X-Google-Smtp-Source: APXvYqyOso8aqwCNWNJSbOk17iMMMUPOaL68Da1Zo65EMmyj6V05d9Iw6hvo1ulehze7Y3sDepzRbw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr38482698wrp.172.1555533850051;
        Wed, 17 Apr 2019 13:44:10 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:09 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mmc: meson-gx: irq is not shared
Date:   Wed, 17 Apr 2019 22:43:51 +0200
Message-Id: <20190417204355.469-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for another device to request the MMC irq. It should
only be used the MMC device.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8b690ecde4c5..3df50b53f834 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1328,7 +1328,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-				   meson_mmc_irq_thread, IRQF_SHARED,
+				   meson_mmc_irq_thread, IRQF_ONESHOT,
 				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
-- 
2.20.1

