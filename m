Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06121479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWKbtRyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfIHKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42454 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIHKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so9872159lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UID+ZGhCw2nacez8i2dJLwbGqoz8PrG/hBN9ucQUcBM=;
        b=JWKbtRyO0r3UuwtokOdSoGl+Qf/PvjY0KfogNnlWS4LqEPt+bQ4pkFFt9NpCar4TDq
         W1r8Fe8rk49pFBluMRr1txg9wAIB49kpZODvn0Mnilqv8bsUcf7ZTbMf6YW8PJBpX7Ex
         3Xw6tuU/X3GNLeHcEs0bIW1qDFZjE1eIHpkqNdxy2jEn8miLTHs6EgPGlfBVqDGcMB/u
         uWihWHGjsi7HHCXw/LYUooLZBAIDrzLsDLdcE2uC+KHRK+rvtJxkXVKXoygNCSbCAoe7
         60tdgjYPNwKx08Cw/FmtwpUMuZinuyZ7Aiq6w5r6wjMlldyIkK+g/tn0wqRskNnoNMxO
         z5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UID+ZGhCw2nacez8i2dJLwbGqoz8PrG/hBN9ucQUcBM=;
        b=Pe3TCaN/NQUMNkk7pSk8rGEbYM4WyU2L+dE/ItkDexOplqKFDOvgVBsNkChpZ8Kue/
         +x0HCPPm4kXp4BWyFHrPGWZ1u2/f17iaTW1trQbi61eH7Nlr/BJdf/aUa9aFJHFXXRkj
         3hSyrNRXLKYtYjFYzPgn+7YyOGhafg7b6jBDnaVSomu1R+jFR3edmrRcpjWDNCuylThR
         hB3ZhN0uK5dBwaErZfzpZWx4YkwrqyGckT1qWAE/OM/T3R3NkRWvuh0hQtkXdq0ByB65
         6jkCqlqxg/oEPnIArqzNOR7OmgIuFuWaZ4egXRclAlC4hkMHIULNWwhbUW8q5EMeVSMf
         /r0w==
X-Gm-Message-State: APjAAAXVLyN9iZASNqmKvSe5oHQeIjr12TXT5RFUmaL0Xm9Kh9FyIpQB
        uyNiz53ZP40JAUfmYXdBQ65J7g==
X-Google-Smtp-Source: APXvYqxN5OLcZWms4eihOTuBGpXa6p5URvzKGYMW1aNgnfvEAUegHDBj6ZcMriUHcGTZYMRYr+R5GQ==
X-Received: by 2002:a2e:5714:: with SMTP id l20mr12019190ljb.122.1567937571210;
        Sun, 08 Sep 2019 03:12:51 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:50 -0700 (PDT)
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
Subject: [PATCH v2 07/11] mmc: core: WARN if SDIO IRQs are enabled for non-powered card in suspend
Date:   Sun,  8 Sep 2019 12:12:32 +0200
Message-Id: <20190908101236.2802-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure SDIO func drivers behaves correctly during system
suspend/resume, let add a WARN_ON in case the condition is a non-powered
SDIO card and there are some SDIO IRQs still being claimed.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8dd8fc32ecca..c557f1519b77 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
+
 	/* Prevent processing of SDIO IRQs in suspended state. */
 	mmc_card_set_suspended(host->card);
 	cancel_delayed_work_sync(&host->sdio_irq_work);
-- 
2.17.1

