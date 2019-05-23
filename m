Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B96C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4444020881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="REOaV5Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfEWO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:59:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfEWO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:59:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so6654932wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CssnNRfqQDe95aEHLIDwNrxoMm4Qr1zdDx/8yvm4qr8=;
        b=REOaV5SsGZnknVjXNHI1+w/KigvMYFqry/bQQI5clubnG+/RkWUFG/ltDAyrO4zkDH
         c77lz+ZH9APatZ8RBKfqZIrQu6VUfGLvuNAfXebV7VcJq0pdvlNCsyc1vYPkRZn5Z45u
         2RLB+M9VXCmNsKrfoShvy6RVSnqq5FoHPvGXyFNWVwSPoutqYs4IInrK2K5u60CYCeyx
         /OOz32VPGeF+hV8c9HwrzIXhievnXkU76cLyiI5nnx49ZFl3HkF9Qdx/uqVIY6MKNnFa
         p6yzQku7tHyyS/MUqo1UMfav8fcHGO1INv8DrGX9vjXdZRQkAqTzCcRFRfOP+0Q7ScDv
         1CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CssnNRfqQDe95aEHLIDwNrxoMm4Qr1zdDx/8yvm4qr8=;
        b=APZ6ytkV/uW1xrI5dOUzNDuDFiZ8+HVWVCqCrkjifBux+v6d0YaJosPRGnuG/45s7Z
         C1mY+510q3gCNSaT6Bd+vx3lYjXtVHpgUhTXj+1/K38b9x4MvFtDRivNvmZ0xKTEhoHj
         juNcy6caxcQyrjXlT+9My4KC6pBCdhnbwHiC2fOlrR2uMByVsax0G0PxmJ48qQ4njVG4
         LMn3fMiwzgFXsaHu9MfVR01mUXQUhe0gG6xqqn59jft2V7TnSU60y1N5s007x2zNmwEd
         7ezYgRlEtua3FcVjpJ6pcdt3e6ly7YHXbeW9oM5lJhlG3Yc1Rjsf7RsXk4f9h/2Jv7zx
         nzmQ==
X-Gm-Message-State: APjAAAWu+/iUOjWsOj18/AjjOHF0y1kvsaR8cE+Qc2jxG/HTdjGDWZ7K
        q+e+gzCz5zW3fUgoWgW09hhDPw==
X-Google-Smtp-Source: APXvYqx/uuRO0IHEqvTfUgTvkFrAj21iMWd3FOVHEIJ7N9kr8gaNKLRjtE6H+YJHuIRDbZsfcx4ktQ==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr1327464wrw.65.1558623597101;
        Thu, 23 May 2019 07:59:57 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o11sm14429930wrp.23.2019.05.23.07.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 07:59:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] mmc: meson-gx: fix irq ack
Date:   Thu, 23 May 2019 16:59:50 +0200
Message-Id: <20190523145950.7030-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning the ISR of the meson-gx and acking only raised irqs,
the ack of the irq was moved at the very last stage of the function.

This was stable during the initial tests but it triggered issues with
hs200, under specific loads (like booting android). Acking the irqs
after calling the mmc_request_done() causes the problem.

Moving the ack back to the original place solves the issue. Since the
irq is edge triggered, it does not hurt to ack irq even earlier, so
let's do it early in the ISR.

Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6ef465304052..cb3f6811d69a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -873,6 +873,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
+	/* ack all raised interrupts */
+	writel(status, host->regs + SD_EMMC_STATUS);
+
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -919,9 +922,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	/* ack all raised interrupts */
-	writel(status, host->regs + SD_EMMC_STATUS);
-
 	return ret;
 }
 
-- 
2.20.1

