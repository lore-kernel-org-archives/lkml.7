Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F397C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975D2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyCgQPw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfICOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39845 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbfICOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id l11so13050552lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUKvWKooE3Nr2LfWI7qknPBybhkMjg8O69FVSs9vXkc=;
        b=IyCgQPw2ykZcke64WeocrNRFfaD/9n4LX7jp4OolaJu1chstHr8JQY7az9MsM2LHfu
         8LnV9+FB2P45atdwxzfs9q/98aYbBbqFB5/0BxMEdS//a2gDnHY/GYf8z0Qp5EBNSK85
         IIJ7o+AfG0+am8hlLHi+fYcB7rdS3ni89UoSdaaIUQ7vTBikpGzly3mo3OcRApe7OwGQ
         twMGIlge9iU3ldpxwXFOFGJcklC/73gUGANUrHanqOveSb0DgprvK6HLjkK2NFnak9YP
         X3XrGDU2OW5ywt4hKN45BGBzSvIzXn5Pspth/FugIwTE4wJW1Otk2zU2/sS0ea0xxdFt
         askQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUKvWKooE3Nr2LfWI7qknPBybhkMjg8O69FVSs9vXkc=;
        b=QVRxM+V/gvMuHlDWNlFCwh6a/Dr4j7jGmCNbfck7rJB/EIP+SSe/iajgSvslg+oX7O
         PnCPRvjueuiC+b11EupGk+E5T46gc3jKS9cZVq4IIfwqs7+J0TIcM4eXb6J7rmhKCIg/
         gEJhmTzCJ6fub8T4rWUZBNLxpmoCQSKuuJludz0/noxo+yPXxUPzQUAZHdlTqWuay+sq
         MEGPX10/JkEZUQZnKPislNKJ3nbzPKNcJiUeVpw51Jy8ROH7M/O6O3ozVN+i7AemMVnQ
         npwKPk4bJSzkOn6b7/EephSZK9d2r0U92I8VKhEz66/JV12fS1hdjVeYupDCTCT93UEK
         pHpQ==
X-Gm-Message-State: APjAAAV7XYF5aWyk/nOsnwUcz3aTTCfXnffdyuVmRFjOgOGtZ1BKfvPF
        Dv8Qgkk5nGAGy/iQvqElSp8eeQ==
X-Google-Smtp-Source: APXvYqxdOyp0rTA+keK8Vz0OkfEJsyNPg/rV68LgoYLikCASTYSTPK8ZKcshiuJ0b1rvVD46hW0z+g==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr4772155lff.103.1567520565203;
        Tue, 03 Sep 2019 07:22:45 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:44 -0700 (PDT)
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
Subject: [PATCH 09/11] mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
Date:   Tue,  3 Sep 2019 16:22:05 +0200
Message-Id: <20190903142207.5825-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci_ack_sdio_irq() is called only when SDIO IRQs are enabled.
Therefore, let's drop the redundant check of the internal
SDHCI_SDIO_IRQ_ENABLED flag and just re-enable the IRQs immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c1ebc26846db..2a9be044448a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2161,8 +2161,7 @@ static void sdhci_ack_sdio_irq(struct mmc_host *mmc)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
-		sdhci_enable_sdio_irq_nolock(host, true);
+	sdhci_enable_sdio_irq_nolock(host, true);
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
2.17.1

