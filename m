Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD9C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBB121773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1FR1Pacd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfDQUoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfDQUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so111186wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1pW48pbPFvZbhJkwoKxPVapl0Fl2yGEGKo5zLNjkdw=;
        b=1FR1PacdQ8mXv9C6T5DTFoe3CVzRscWQE+uxrgdsEaoShIulc95xQsIdTtKd4DRjVh
         YfDkUPGVLcUqjHjGOxa2185xMmiynn9EtcSKFTrdsFr6nGbkxA8kwjSdoxpFe52SameY
         kuP+Dd1oiemB0n54v87R6G8RsmvOaFmlk7jJ06iI2/zEbwJfEW1nB769d5Iak0qDoA3x
         uSiYL/84ZjyJl9rwuRAnUm0CsKshLzCJDmk36XpZXkvzEM1pVF8640JGfYPfk1UwwC/z
         aBzawWLceIRetZFlOX31z98w4/Z79krvDvlVF+GGx30O1svCVNDyBvP2BfJ9suZ2Yk/r
         YNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1pW48pbPFvZbhJkwoKxPVapl0Fl2yGEGKo5zLNjkdw=;
        b=AlIcoAGePJEoFqi6CM+lH7lQala1xMeRsEuPDEND3prL/KmsXd8hfFyoApJ10FMuh9
         bBxtXcAckqzU30slujXJf4rMsL8HqIAEHelmFFt2JRWipX5zLyhGNx4lQsW7mbnTNSy9
         popLC8eAjPoGZ1GAQVehfxUrPaHH2eW3ski27d7gYBDtOF5nDKo+NaDnLwk+MvJ7Co0W
         2njXcGDchd2yb5yKOFQ4ys4GtpiuO94gUslH2Qc9YqUqELJtVYk7tuBh3QAHm4rzbOIM
         DrqgeV2bR6eqqGJB9RoiTAMa+Sd636ik2qqjwYiVvVxI/HXfmk1loQhmDQszhOPoj5bT
         MDCw==
X-Gm-Message-State: APjAAAU0KzCkTwK/BsV+ssqvoX1c9oWstWWyR3czYPQunBho56/meT6z
        fm5LKe20XYJ6mLjBJAKRTolchg==
X-Google-Smtp-Source: APXvYqwOyBI7s6NDYfn2VcQR5FZQWq1it2JvaM9jhBEKRlph/3LQeQNCx7QJSL/ufohtL9AfyEKTdw==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr61038475wrs.267.1555533848824;
        Wed, 17 Apr 2019 13:44:08 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mmc: meson-gx: ack only raised irq
Date:   Wed, 17 Apr 2019 22:43:50 +0200
Message-Id: <20190417204355.469-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is merely a clean up. It makes sense to only ack raised irqs
instead of acking everything all the time.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2deeacc051b1..8b690ecde4c5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1082,9 +1082,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	}
 
 out:
-	/* ack all enabled interrupts */
-	writel(irq_en, host->regs + SD_EMMC_STATUS);
-
 	if (cmd->error) {
 		/* Stop desc in case of errors */
 		u32 start = readl(host->regs + SD_EMMC_START);
@@ -1096,6 +1093,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+	/* ack all raised interrupts */
+	writel(status, host->regs + SD_EMMC_STATUS);
+
 	return ret;
 }
 
-- 
2.20.1

