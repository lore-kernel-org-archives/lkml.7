Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B17AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461123431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr8gEgTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfICOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:23:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfICOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id u13so13025938lfm.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0NvqeeJAxqM9LsjMwddoa5m6zhHcHlw9n+K/8LgxXIo=;
        b=Dr8gEgTBXp1w4VtAi4Mg6OCCy2rvOuKA2OxrnTOj+lxUU6Y5Zr/e/LiMXo9c/gTVMj
         dimHRhhs+yp1gkbZp4z0mztJjWrv3WJBlxkhrla8bsYlzwEUe4f1j3+POiAD3wnTTDu0
         ZXSwSUnivY32b9fKF7b3hLCaNRrkTSAK5o/qkfMGdNnVK6jI/byKgyQLIFIy00GkkTiB
         uPgncVJ8PHuhJVF+6MiyqQbwg2bwS+dUntVWLDg+RUJc61GM/Bm5LkB+XtwrREL0QX0R
         VIcIjvZ6WYdM4CJ6ZIHN0AugBpHZS696oD4v4XD1agn/DGhqtNf2KkEuLA+Gw6HZccSl
         ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0NvqeeJAxqM9LsjMwddoa5m6zhHcHlw9n+K/8LgxXIo=;
        b=rwp0uLYPrcAPP11JHiDN5WrIxnMGR31pGTD23ZU1mSLUvlstqwM5wZSqmTU31+vXud
         sy9bsGnMoQEe4DRVZKq16wpwEV4unorkd4NVq09ulZSLDC/V/sxCIr4SuIXTH5ywBtJu
         MGhYMFrifHfhRcKQbpREanbkSyG+REN5odM/e1ppPa+zOvVf9CJ2jR3j3QK1sr8oneP6
         pzk7MVUVAzG6JfK7bhasWB3t9sRqYtMFxYZpVo462XcvkaZ3cFpYWnJf3KcGpK1CBovE
         16rhs5Ar/IkppzawkYF/YTv5DQbThLl6zaj6mRbIqlNpL2P5+IFuFkKqdEvWlhAwGg9L
         R/6g==
X-Gm-Message-State: APjAAAV/sO5p8MsnLL/+VO6x/NAYmBPrmdbUOnmHGA4jGuMzF3kC1rVG
        OmQ+u4Pw7EZP4Y0cmen9AU2D6Q==
X-Google-Smtp-Source: APXvYqweF7JPxx3cnV/NebwZQV+1f/Ir2g4Sh+rI5IK4GEBLjBEWnZeSOmycdTJye0f6h/XH6sRvAw==
X-Received: by 2002:ac2:5485:: with SMTP id t5mr18239629lfk.27.1567520557351;
        Tue, 03 Sep 2019 07:22:37 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:36 -0700 (PDT)
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
Subject: [PATCH 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Tue,  3 Sep 2019 16:21:59 +0200
Message-Id: <20190903142207.5825-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means msdc_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().

This means during system suspend/resume, the register context of the mtk-sd
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the mtk-sd driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the mtk-sd driver, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6946bb040a28..669ea0668159 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
+
+	if (sdio_irq_enabled(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
-- 
2.17.1

