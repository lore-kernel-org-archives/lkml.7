Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD25323697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEnDskUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfICNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:50:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfICNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:50:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so17606817wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aOyM32hMSWR1qRMtRvlicJ7f1Z5Z1CPh11gGjkkMTtY=;
        b=SEnDskUHk7MKEpfjF3e0404Vx6RbV3Us34tpICArdFY5gu+Ad0LCkJkr+CWV8p0R7D
         0P9jX11NcJR/cppXMJNg4DK7nZ4wLb6hHDDRE5vjvkM60LHU4/vAUwvFhKtPrHwDZ2ed
         MSUFYAAPsEguqTREsrN9QgP2MicHw3nwD4o0WSQ9aRwsqQbzSqEACxn4LH5D+Vp78CVk
         zGVrqCc8E494TwnqdASdi1A/hNkXjwD2RO4iTxLPHlIZqeX4ExGXV9jYgJPO74QRp3dQ
         cpqFJjn1ShGo0tkINNFZOWHirhB8CwhLCdXMAd2igfWtPSS/kpS4LJwQGOzp98a8ZqJS
         bO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aOyM32hMSWR1qRMtRvlicJ7f1Z5Z1CPh11gGjkkMTtY=;
        b=B/6lMMtlCA6mATSta4fRoBg9kikon3eEysSJLR/lRzYIOhVofqtCYV7vG1Wt/IoHyg
         1m+hq/AeR5O/8gxe83WjF6uekrFe5rEIxIQ+/EbOjh7TSlcbQRk2+bL47Jvfb5I7qRBe
         E0l1ccDO4ahEusmgv+Xx4ZyNJKLa+jTTC9L63PD7CkotHlcYvAZLUdvESpKtWx2OWmt/
         Jd1VUr8+ghtDXm9jQTJuGoMTvA5mhexU3dBzjY+p6FLHwiYmxvmWaIOOdTMFocdoMxlM
         CwXdWW7Q1iTukfmyZt3u8pszNhLE11ZRHn/8aexNgdmSIvlc+2dQRvU3MdFn/swxEZWh
         9OnQ==
X-Gm-Message-State: APjAAAWAQuRaXou6GBKFF808wjuk6qfqUZmqNqkHA3veW6KOYUQfo7Bk
        69lWLaT3sH6SCw7TR/rcyBNAqA==
X-Google-Smtp-Source: APXvYqwcNl225P8oK2CwZViBuGxf6CcNTfssQRviSxt65FF0BMbjIKf7EyVLOO4EJX1BTSuZUsMZLg==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr43453065wre.169.1567518656051;
        Tue, 03 Sep 2019 06:50:56 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id a17sm20710665wmm.47.2019.09.03.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:50:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     agross@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
Date:   Tue,  3 Sep 2019 14:50:52 +0100
Message-Id: <20190903135052.13827-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with ACPI, the Geni Serial Engine is not set as the I2C/SPI
parent and thus, the wrapper (parent device) is unassigned.  This causes
the kernel to crash with a null dereference error.

Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Since we are already at -rc7 this patch should be processed ASAP - thank you.

drivers/soc/qcom/qcom-geni-se.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index d5cf953b4337..7d622ea1274e 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -630,6 +630,9 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	struct geni_wrapper *wrapper = se->wrapper;
 	u32 val;
 
+	if (!wrapper)
+		return -EINVAL;
+
 	*iova = dma_map_single(wrapper->dev, buf, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
@@ -663,6 +666,9 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	struct geni_wrapper *wrapper = se->wrapper;
 	u32 val;
 
+	if (!wrapper)
+		return -EINVAL;
+
 	*iova = dma_map_single(wrapper->dev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
-- 
2.17.1

