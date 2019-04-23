Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B1520843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0CRtXmBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDWJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35028 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfDWJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so17794582wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1pW48pbPFvZbhJkwoKxPVapl0Fl2yGEGKo5zLNjkdw=;
        b=0CRtXmBu8o8LrKmAYE/sKRtheqjZAWj3UgypeINdpuSrpGNjH3EQKerJ+HyxR/+FTG
         Zp5uBMcs29yn/DaNQUqyYDg/IkVtX4U/o7gddZfA9w/7rS6uCFRnJ2s2ubM8u30AGIi2
         clgE2Gwb8zHddinILtYdLIce/IiGEU68JPc2mZVYXnsPx1kwuNJDWDfDmWdh9Qqy/hdV
         F3617T0lI1T+MlUHawgS2qHBdqSYcIX8t9GSHuQNXtmDqF1dp328G+t/YcxMGZ1pDlvG
         Ac4kyDTTAugznAgDZXTKGRnVqxV1RPTHDaxU4CK5ZCNg6LPpLcxISp8yVsyv//Dz+hYE
         RRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1pW48pbPFvZbhJkwoKxPVapl0Fl2yGEGKo5zLNjkdw=;
        b=bBqZ7a6nMUjAupLCRceIRHqWWvg/VR2Cdut8jq4ZN8M3G7b8E6EQqJrFkATDECikAG
         L3BLJlNwgiEzTTTPxRo2Iap2WV039AAewYm2nrJnGjR0eFxsCn/Nwsaw78NcZg3BZIaN
         n0titE5HIlTF4xMda6hIZW7DN8W3ZhQiMaSAvvubLN2cLIvX7er0m1H7WDSbbopamIBp
         yhBVLC/KSx+X4a7NXBqVxCJs/i83JMG+HRyx5lIMbDeYutqRBTkOfeO2hm03vZd3D703
         XqN6NgC9gIWGpsehrkDVxStto8u6KTN9c1NHHk4retl7n0zfvUsGU22ibDDnczcOT4Zj
         wnCw==
X-Gm-Message-State: APjAAAXYp5Ij9E96aLsFjbIpIqvvvQpL8gj2LjP3fpwZhGISVAOF3ub4
        9kXPvFOgxzXEurQzgQ+6P2O9p+9jWEg=
X-Google-Smtp-Source: APXvYqzzCOMdrBdPKyxxoS08iD+SgVF4LB7GCWsEcXJzhUb9nTV15PQBVCPQPfVbUfx6P2sVdCaUtQ==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr1556030wmj.44.1556010166990;
        Tue, 23 Apr 2019 02:02:46 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] mmc: meson-gx: ack only raised irq
Date:   Tue, 23 Apr 2019 11:02:30 +0200
Message-Id: <20190423090235.17244-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
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

