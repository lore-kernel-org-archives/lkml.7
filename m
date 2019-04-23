Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D270320843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qypmTfDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDWJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39453 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfDWJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so17767391wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9mkQOCOyKUJCXFL3UmoX1uExjUUiwIU7JlFlpoGkgA=;
        b=qypmTfDBnIggohr4oTcl1DKf+xQhzrv43qq64kdnrsD5FiChu544D2Z/Q6kDPHyMyE
         YFr/zzUgt/cRfM02ECYDfFz8ANOaKMQZfoVXdk9Szf/L6Cx0N9zY2TEjP59uvaeYm7Xe
         A2CteyW3kkGwfrZsA4lxmp7pNmDnZa0Dxc6ynlfMeN+WQnIU9RTYJf2jmZwkBvh4Q5On
         KFGW76zK0Hd1RFqBtWmy3Cnbt4+pcMfuveWDl9PPOIPhjtMTOb47nFGhA9qIhfKCfhuM
         B65nCNoiNI2pZpuw+HMJzBH/Wf66saIli5qI8RnEFtEJ6/oYDs9hQEJom43JcDBIWrV3
         EKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9mkQOCOyKUJCXFL3UmoX1uExjUUiwIU7JlFlpoGkgA=;
        b=nU6HlsYbxPfTjnJkg3ueG3UBV4tvTRQyguP6uOsjRyNpUaQlPMh7Ukry9UEP06Ins5
         r3y6vmPF86+6ih1RM6NoSrqSqQ6VF+y4qa1ujQTQMhQXtCPckfDo/z1UUUw97mWSRo/N
         GNBaI6xRf8E/ewYsZe+TyoTwYDZ5gWHKqOKsksjqeFeJdqiTWvCqdo+Pi+yHbBSRaSr1
         2ZcTUnq2v6qcbKmI6U/BWyATQeYwBI4wR66q61QYByfyzM48+wZ3WSJ6LqiqJ3fHUQAj
         9zfV7pR5WvPgcijhBOCghU5ty2abi5RmkpCk1BSALAEIHTuTZpCVsy6o6hrymmp3wcfJ
         oahg==
X-Gm-Message-State: APjAAAXQ7Jp5Yft5wddyNfR1KbHVubzHYgodvn8R1fjDgY6nIt0+G5YF
        wDvV3Kw568XdL3DJq+xxOpkyTA==
X-Google-Smtp-Source: APXvYqxItRPwOb/4WnO6Xb62IZlKEytOErCBr1HMvACHuQpk5+YTXCFKJJkhl6u146I2ujBEhnUcRw==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr1517688wmh.13.1556010168140;
        Tue, 23 Apr 2019 02:02:48 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] mmc: meson-gx: correct irq flag
Date:   Tue, 23 Apr 2019 11:02:31 +0200
Message-Id: <20190423090235.17244-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for another device to request the MMC irq. It should
only be used the MMC device, so remove IRQ_SHARED and replace by
IRQ_ONESHOT as we don't the irq to fire again until the irq thread is
done

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8b690ecde4c5..3df50b53f834 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1328,7 +1328,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-				   meson_mmc_irq_thread, IRQF_SHARED,
+				   meson_mmc_irq_thread, IRQF_ONESHOT,
 				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
-- 
2.20.1

