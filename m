Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA11C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D0221734
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSu4o+D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfIHKN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:13:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40413 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfIHKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so9863578ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mZN0trNPMDGK13UKBqW2zdfZhLOq96vtybPEWVfKPNw=;
        b=eSu4o+D14VPgj3Ynxc1N1DEPmO10ApZ1GvVsFUrqtPJRSKRwUCmUZEqTh5FWANi7DK
         Kx64es6+u0lX/QzhJ/Hvb+fUy2CtpUpvq5Tr54WwKwARFAjar4rmQ1Jpaie44uXp4MC7
         QGvl/fbYdwdScf/L7DTqStNqxyq33b3BxDiLmUEikDGOeS7vx6IGbkV8Jpso8WWIlJz8
         dN5erHSXWrVGemR8IYO3b1NBA4od7jAry3DZwPuZ2xdh/lXu48W8NULkDXHQTapEeAtx
         mxwDAZdX5djBy2GJSZv7T0XqRugKn5DVVOEWGnXscoIR6tjY/yFJAaJUsZw+UN3/J64X
         dfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mZN0trNPMDGK13UKBqW2zdfZhLOq96vtybPEWVfKPNw=;
        b=fqhGQg3PEfuBHt2rGC7OcaBm9HYbALBJTrgmqXnXRhyI9/QKiDiqi2EKS+rqSLXxXm
         4yvdn2LfSeKhxRkdqnD40We407n4dRiom/IGUvFWAPDwEVLauSpElEM6fOjtd6ehUwLn
         rBNWWbP7dl76hZjHoPYXTzi+mNopAz5ynGo4UrE/l8jXDGsFoPwymacJEyZ1KOL2/4Cs
         p6OghZDw5raiCn+X3J7Xjv4J6yGo3zyU12h3M5wrl4KCMCUEs6OV0oK/yZNrweNZ5p0u
         MIybvDk2KBobCUkOTPIIuOBvWz0ezQXBZ2FHpx90lJ4rwmmiPOx1IfHCB041X8Etr17E
         4omw==
X-Gm-Message-State: APjAAAWKA42F5/ZrxvPp5r7rwThInZCS/Qe9tRzHRDs16vnprRA+QCQP
        pX/GGapjQQ1Xr/Uk7NrzC4LN3A==
X-Google-Smtp-Source: APXvYqz8cu6BKIqcffnELf83zGndaKhR4JEUPbfnLof3jUsv/FRYX5HaVItHDHcK51dNgNqZHOapSQ==
X-Received: by 2002:a2e:331a:: with SMTP id d26mr12181565ljc.239.1567937567102;
        Sun, 08 Sep 2019 03:12:47 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:46 -0700 (PDT)
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
Subject: [PATCH v2 04/11] mmc: core: Move code to get pending SDIO IRQs to a function
Date:   Sun,  8 Sep 2019 12:12:29 +0200
Message-Id: <20190908101236.2802-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

To improve code quality, let's move the code that gets pending SDIO IRQs
from process_sdio_pending_irqs() into a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[Ulf: Converted function into static]
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..f75043266984 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,34 @@
 #include "core.h"
 #include "card.h"
 
+static int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
+{
+	struct mmc_card *card = host->card;
+	int ret;
+
+	WARN_ON(!host->claimed);
+
+	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
+	if (ret) {
+		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
+		       mmc_card_id(card), ret);
+		return ret;
+	}
+
+	if (*pending && mmc_card_broken_irq_polling(card) &&
+	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
+		unsigned char dummy;
+
+		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
+		 * register with a Marvell SD8797 card. A dummy CMD52 read to
+		 * function 0 register 0xff can avoid this.
+		 */
+		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
+	}
+
+	return 0;
+}
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +77,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 		return 1;
 	}
 
-	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
-	if (ret) {
-		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
-		       mmc_card_id(card), ret);
+	ret = sdio_get_pending_irqs(host, &pending);
+	if (ret)
 		return ret;
-	}
-
-	if (pending && mmc_card_broken_irq_polling(card) &&
-	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
-		unsigned char dummy;
-
-		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
-		 * register with a Marvell SD8797 card. A dummy CMD52 read to
-		 * function 0 register 0xff can avoid this.
-		 */
-		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
-	}
 
 	count = 0;
 	for (i = 1; i <= 7; i++) {
-- 
2.17.1

