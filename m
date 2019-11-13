Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD3C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C632246A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610475;
	bh=DaQLybh/xJL6ICV5KQelju/IXatkVj3q7xwN1oiX+YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B/n/hhbWuUPJgfbXmfbK1xsr3/+PbvzXKjwyLF9zFPDJOyEKDgAAhm9niRcGbCRK4
	 KFIXEbZayRAersMKgXRohAe2VM9fyRcGXWO1VwwwFV/dcO+xqRXMUVyFPE8mVb0lLM
	 Nv/rTIqSP5yMA9EbXyG5zvxgj8ubRqn77fI4ZVuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfKMCBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbfKMCBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:01:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 530AE2247C;
        Wed, 13 Nov 2019 02:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610466;
        bh=DaQLybh/xJL6ICV5KQelju/IXatkVj3q7xwN1oiX+YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvSX3VPk7wn/EsX/LssOj3bIKBwyLUpqXlL+9M78EUQ+KsTqr6lwjKpcrHD69bQ4a
         UM9nhHOTnK479+HWtd4oYq/cCh9RBq2e+eKGdKhVd9ap6n/6D2Z6k7ruDIqc2W0riD
         qfn7pfKYIxgO6Ael17HAjo07tUESUIPMfbyvYFFg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 53/68] mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup capable
Date:   Tue, 12 Nov 2019 20:59:17 -0500
Message-Id: <20191113015932.12655-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit c974ac771479327b5424f60d58845e31daddadea ]

If a child device like touchscreen is wakeup capable, then keep ADC
interface on, so that a touching resistive screen will generate wakeup
event to the system.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ti_am335x_tscadc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 60286adbd6a1c..e56f0844b98de 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -295,11 +295,24 @@ static int ti_tscadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused ti_tscadc_can_wakeup(struct device *dev, void *data)
+{
+	return device_may_wakeup(dev);
+}
+
 static int __maybe_unused tscadc_suspend(struct device *dev)
 {
 	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
 
 	regmap_write(tscadc->regmap, REG_SE, 0x00);
+	if (device_for_each_child(dev, NULL, ti_tscadc_can_wakeup)) {
+		u32 ctrl;
+
+		regmap_read(tscadc->regmap, REG_CTRL, &ctrl);
+		ctrl &= ~(CNTRLREG_POWERDOWN);
+		ctrl |= CNTRLREG_TSCSSENB;
+		regmap_write(tscadc->regmap, REG_CTRL, ctrl);
+	}
 	pm_runtime_put_sync(dev);
 
 	return 0;
-- 
2.20.1

