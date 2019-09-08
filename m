Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5ECC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461321479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mcwgjbdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfIHKNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:13:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46237 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfIHKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so8222398lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBQNfgH478Agi6Qq65UuCm0AdFgtpDY1/4Ukd7tPN04=;
        b=Mcwgjbdp32PK8AZUMsmSzkK40Pkz9/HfpmUTEvkfaXJir+M1fqFP9wGs7zB3qW+3by
         X5GgXP39/Npz/F+rDuxpX5aPchObiqqORL9ZlkuVhbpwB+GFTVF7lub61Evi0KKMCezt
         Dqw6YkxkDH/JmWHtRO/poQ31ezNS6Psl/exogXW7T0ppn4elIzW2We2net4M5m9JGbHu
         g3aACABD48I4MJnMvQk/ClIIG2b67EDRyRtu1/O5m8QGdNBfBol/CPk5DbIfeeHSs8Ap
         2nqZDZM+ZAlZEhT9VcPp+fUkBFIMMBx4t5RzmA0fGreFt8Pje7ZKBQ8S/7rcd5abLAY0
         0pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBQNfgH478Agi6Qq65UuCm0AdFgtpDY1/4Ukd7tPN04=;
        b=eJJtrIYGre5ofLmQ48+eYs7dWHp1WQbldLHEVywF4nbp8KGxbxoNDN2qfP+nKalhzc
         7mEfb8txLxRYYUzwwSxMvcYkvMaEr9lJW97uGPQdJ3XVZw5LVLz1tZvkQ9j+wEiehMr7
         usJ4CfmsAPZYhNlWhA/6WqwertHav+MuFSN4i3vfa7BvCV+XnbvhLH8ZXsTfhnrJzSX1
         BumIKTKotH4Jk/MLicp9VAVYq39fOZ+PKM8LGoykSYHzSfK1aeFRxVq+VAA7BhmOm73E
         QEYTArgvAQSPTdSu0LiaDfKyeF5IPW9OT2p56m3d91qlMGSLabQ6RHtjYSvbU8P4X5Da
         A7+A==
X-Gm-Message-State: APjAAAV79CgJodl20uadiznHXtL096jfAI5cWPwlyQ5hmcU51k6BMCn5
        cMq8Y17cXPhS9Hb9YivnEGiwoVlGpUvBpg==
X-Google-Smtp-Source: APXvYqwAZcqc8OF77Bx7ciHC787UfAzR/Jk/8p6iWyWeRbk6Ie4qBOLjOvzlPaRvFZEofbuug/3pUQ==
X-Received: by 2002:ac2:4a82:: with SMTP id l2mr12357581lfp.85.1567937573894;
        Sun, 08 Sep 2019 03:12:53 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date:   Sun,  8 Sep 2019 12:12:34 +0200
Message-Id: <20190908101236.2802-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..efa6cda8c991 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2163,8 +2163,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1

