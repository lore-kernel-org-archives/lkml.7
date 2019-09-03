Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47202341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFHtfa4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfICOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46713 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfICOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so582210lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SADru+zeJoUa6Kq7NgE3oCMhDB2qphP6ONJw4NgANKU=;
        b=OFHtfa4wufhXWOWb3kQTUHd0i9YHGWH7vS4YpuePByo1apgcQx0qPn5D2rDAPelA2Z
         c9AFN0rmRl04Af4morxrZ3mOH/6uAa5o24p5hlLofES39wmRTB39cuKWKsxsRbwOPueA
         DWKNvjHA7bcEZ1WnlxtbCacM07rt3dqTsZp4a0qXvTQeCR28W5+16F2Hu7sZslGhNe+2
         /aLGk/irsE8VSg2imBO3LXorORY3s5UnmKKS0pZ1Wf/Tcs/Byda5X4A+tL6KlvEDpHqt
         vHpl86saT3X7iGXCPgRyUtq7iDDP1IjtuQWaqjKo5k1t5UqNlEovBQ6B26wBM3t7/M3q
         dWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SADru+zeJoUa6Kq7NgE3oCMhDB2qphP6ONJw4NgANKU=;
        b=XeDsL/HmruFtICnskX4IpvyM07Amaqc8K2JgWllRQkc7Ln1RgIoN/OOT2RtPr3F2bE
         JFDwG7kEfKeyRypI2SP4pr7KmM34jCmljiPNBmqUisZPTlXHhf0sjUZRdmGd93pROOKM
         fa3o6YUr6Owoh0dWrB60snIEqbqVchQBB9CvEN+8I3BI0DD1oOlkYDjReflR6wTeeGKr
         uV4SxN3wtC3rhyBlKeD7t7CxF4gl9Nvxdu0dkLInOK5XDoRaevkaa3C6+5eh75ozP5Q+
         Xj0+Cld8+vzKKHhcV2bckD8lpOD9YhESd35T8EjgMNVBi1KCdnGl1KjGVFsf4kZRx/O5
         U/Qw==
X-Gm-Message-State: APjAAAXIwXh7qgP69xcq6sqMHwlLY9G00vLHtcc5TR8aZjRZkqkVssnZ
        wI6XY3EZt2T2DXfv5k6KraLXnw==
X-Google-Smtp-Source: APXvYqx/2ml75qZUvcITEBML+/VXCJWVUP/iHChuBbmOfuQX/0u72UoOykubRwkl0ub8F7RLyPaLPA==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr451699lfi.81.1567520556123;
        Tue, 03 Sep 2019 07:22:36 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:35 -0700 (PDT)
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
Subject: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
Date:   Tue,  3 Sep 2019 16:21:58 +0200
Message-Id: <20190903142207.5825-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
the driver. However, this still means dw_mci_runtime_suspend|resume() gets
called during system suspend/resume, via pm_runtime_force_suspend|resume().
This means during system suspend/resume, the register context of the dw_mmc
device most likely loses its register context, even in cases when SDIO IRQs
have been enabled.

To re-enable the SDIO IRQs during system resume, the dw_mmc driver
currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
the SDIO card, but this isn't the recommended solution. Instead, it's
better to deal with this locally in the dw_mmc driver, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index eea52e2c5a0c..f114710e82b4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
 	/* Force setup bus to guarantee available clock output */
 	dw_mci_setup_bus(host->slot, true);
 
+	/* Re-enable SDIO interrupts. */
+	if (sdio_irq_enabled(host->slot->mmc))
+		__dw_mci_enable_sdio_irq(host->slot, 1);
+
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-- 
2.17.1

