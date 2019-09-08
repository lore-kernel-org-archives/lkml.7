Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE67C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C640920863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edn66P4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfIHKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35097 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfIHKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so8279844lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xyicSoe6hBPX50Bq7X1NmDZdoCyXZNomcUNAFE37PKY=;
        b=Edn66P4SYLLch2VlatADxUAdLd0tfPrivUo4T6tVpdrp6UL1oMk62JvZ/hUJkvl87r
         Y4Rm76XwOcNH2VYEBygULdW5dVpM0jJkgDrgRJ3tLHe0DbyD+VC17UKw8QcWIoEhLW6g
         UxzARtbao3FE7GweeUr4Qonq+zdqyH5yT9dMcyQ1L2uBx0oU/N8x9O8wa1/WcKH5sb9d
         9/HHhGHe1Lb5zmI73R/bjlpLVEaAc/mzChuooMB7S9eV3mxlP4d21X0xNbO8k6ssorLY
         I6whMaBA6Wswcg0rkCzfsWxj+NH2NnWVUScQXOlFfJOwxwNbJgeZyOXxMOyxOgKhTBsk
         GmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xyicSoe6hBPX50Bq7X1NmDZdoCyXZNomcUNAFE37PKY=;
        b=fIqXgmabHrusWF6QHhLZMFgLN4rJwG9eTh+dBy1aXhCVvZYXCvAw4SPgq4ycBbprYa
         1nkk++L1GtF38tehlBz59lA35kHDf+7BcKjfddscYfgk+J+Mz3GO1s7I9+/XTfSmUYTH
         QAXIv7bnQ2twE2jes9VP1iWmaey13KkPyxp2BhA+HS9huJwuCyxZaf8eVBGj4yS425NP
         VflcHANOMPdQ26EtD9QASsr7R/ltYGLXiYuBBnzFXgJzCX+wzQ1tIpOZMinSXBMV0XQV
         KapFUniOqn51OMz3/KPfISYe3fzyZU87FsJk6t0bt52KpHl5768Si9R/mn8S2VP41/P0
         2a7Q==
X-Gm-Message-State: APjAAAV9SDnlQziaaYbOaNpiLdcZXlF+2FL6nFN++K+ImExlusNlgO5Z
        LNh6yB07D+n2xXYX+G/1r6wT3Q==
X-Google-Smtp-Source: APXvYqx9rsoHVDfNzT1ZVdZm1qIiEGkOqHceJPLVcgXZDKXrF+hMW6kC9XtCo2PmnIfoI33u7rdyTA==
X-Received: by 2002:ac2:508b:: with SMTP id f11mr12898573lfm.153.1567937565846;
        Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:45 -0700 (PDT)
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
Subject: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Sun,  8 Sep 2019 12:12:28 +0200
Message-Id: <20190908101236.2802-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
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
index 6946bb040a28..ae7688098b7b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
 	} else {
 		host->save_para.pad_tune = readl(host->base + tune_reg);
 	}
+
+	if (sdio_irq_claimed(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static void msdc_restore_reg(struct msdc_host *host)
-- 
2.17.1

