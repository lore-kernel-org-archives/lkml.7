Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0949C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD8D21BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178462;
	bh=dWZQeEXELj4oPCyvPKatzqbyZkyD3e/BEQa+Mm6YXN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJHpzUyT6o6219LHEA4az46Ez/EH7z6RwJZnPkxT+cu8NXyQbpEntMMGH3V/gCwj3
	 Srx8MTDpv1ylTJiekTPhoD6auMVDB/9AByouGQ93U1ecB7l+/Ug3DJa90Fyu1GfJUM
	 Xr9Z4sPoVuSjJ2bPCB0zQeInr4xa+ikA+Zq0TfeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfIVSyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394442AbfIVSxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:53:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F252190F;
        Sun, 22 Sep 2019 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178434;
        bh=dWZQeEXELj4oPCyvPKatzqbyZkyD3e/BEQa+Mm6YXN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yK+p7E1pEmR+oHWX3ee3HSHpmPbVjmfAtWVpqyuHaik9P8E3Fkulivdu8Wqh+fsxj
         zw2+RJEVDlKCpaeOn5WJz3xUSb+dkQU9ELIpoRmJZ4g+yCwI5r46Se36n55WJAsERv
         jZE7B3HwEjB3cHm1dUvYcMwL9j1wIMVwM8ChS23w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 169/185] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
Date:   Sun, 22 Sep 2019 14:49:07 -0400
Message-Id: <20190922184924.32534-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 1c81d69d4c98aab56c5a7d5a810f84aefdb37e9b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b6387ef71..978c8ccce7e31 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2421,6 +2421,9 @@ static void msdc_restore_reg(struct msdc_host *host)
 	} else {
 		writel(host->save_para.pad_tune, host->base + tune_reg);
 	}
+
+	if (sdio_irq_claimed(host->mmc))
+		__msdc_enable_sdio_irq(host, 1);
 }
 
 static int msdc_runtime_suspend(struct device *dev)
-- 
2.20.1

