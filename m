Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9448CC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B63215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se0oyKMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAFBRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:17:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33771 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgAFBRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:17:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so41263850lji.0;
        Sun, 05 Jan 2020 17:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4M1pbXI4iZqpx2CZVGwVg04bXNfT4TMrAkn2UqNwoHw=;
        b=Se0oyKMlmuyw/YYxi6zZKlC8K1EQMsNZBShw8PPJtx6J11F1VcNwFQsFJi6jDAvqPw
         wVbEYbvVQHkONk1YFCaUzMZCsoHfFbg54UNFMHfIpMbt0ad1pnhvWpm/LF1QUOCBo1uo
         9SYRsFssJwucmyZtMB2KCUnOZAQeQAU4Gx/BHQ1Iu/2NVHnq0FJjc65fYKbbHOkESa6y
         JP9LkjwHFU8UIr0OZdGlw82haT6hciK8q/o/iEZ/70VOwEILFt4c5OKUToOXs0nvKav5
         IbGch0p23k9zNUsxuFGJG0tlpPXNA4swoY6zHTfnkzhrw/07Umx7wmn8mBDTEOTnLUVt
         rPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4M1pbXI4iZqpx2CZVGwVg04bXNfT4TMrAkn2UqNwoHw=;
        b=f8XS6HIGcXUBEVMyvQPFs5XaOrJMbyRP+G1Ye9zt4yWCla1KSSkUPHFfepfQH1W48Q
         jBWVbZP7dAIsZwB95SCxs/UKKzZFFwR13HOIydJ87dYMACw7RdGEqYb9dAT+SfJ5AQgf
         BGdiW9sikkQxLSiaqMf0hfTvU6hNmoFckFfmAH69STphpa5GV9SiN/r6eN7ECavp3s2V
         WC/6IXLaPACBRUlBpS9vq/QjFrDpSFnbPVz4EKbxb6YS9A7Zbqf5MIdlf03X1yu/7ng3
         Wnh9omuVys7ZX0QeF83p4St2swcRkv3YeOg1DukhBl4FPrbprLfsMQIWyoXTyeSR94hn
         0QAg==
X-Gm-Message-State: APjAAAWhAVcWTyPj0THZc4RLrya2dvc3l3zhLn7EguELDsFGtFHLoFQv
        0duRgKG5cqrYKXQ6uJr9r6o=
X-Google-Smtp-Source: APXvYqzHZv3ZLSm9iyb+iAqTkmf2jyFr5iIOEvv/Y50+jciOiDlSMxvvKCo5ERPibKL4bxzex1ABmA==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr58258457ljn.40.1578273451173;
        Sun, 05 Jan 2020 17:17:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Mon,  6 Jan 2020 04:17:06 +0300
Message-Id: <20200106011708.7463-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA controller shall be released on driver's removal.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index a75d2dd850c7..108307c428d1 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1556,6 +1556,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	tegra_dma_deinit_hw(tdma);
 
-- 
2.24.0

