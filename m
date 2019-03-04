Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B135C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67620663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YdiXJc8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfCDLM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:12:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42044 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCDLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:12:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so5061771wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 03:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29+JarNtSND52EQLZlnqpXRyyJiGyLkKn9lDDFsMMB4=;
        b=YdiXJc8cRAqeCv8J+RHlZ6puNN9/J6lTpsJFiYBUnCudBL3psbPQB47MZ1f3iemln+
         oOQ72RnRMswqih4jqdg1DVHC3EfDW5ZpDczTkNTrB0EWyKsiFSBKmm7lnWIPGU3MUzp+
         VRKfjL+GYMj0Z4dsVd/0hH2Wq5zQhXRp2c16aD5B7N9wYbq77ZiJgiI49Yf/cw3M+IK2
         N2Ey8Mig2YUC18D0MjMcJLV8dxE0ZsyyC/to5+QtgGQ9TMFIFeTwIZ+MqXKRdiN0JpfD
         los4P/84ecs0+PLG0YACpy2kss5Tu35DbReTYZKgq3kQAYjcQvIKjZKezhUuPZFy3m12
         DOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29+JarNtSND52EQLZlnqpXRyyJiGyLkKn9lDDFsMMB4=;
        b=LAOs+SaWE/kMXTBnTyJc5wL1AMosWB+iH6mrcFTMpFYUBsBVf3iVWY7OXyA58v5zxK
         JhJScmNq85MYRCtZI+AAzLY1btdJ46w6oldtkxMgbeOO9Q3nLC/FikBaDzmpnkEDU3sb
         XZVZ6MNiM66he0ADWSYiQYbREdlN42fJhhMEQ+JxKz2z1OogR0Vj+LZLQy+OrO9mJn5K
         FiIcKjD+GzUdrB7dwACuIlkW0YlzkPJIzZibLoW3Yp80r2VEcaR4jhjUcGD6fn6rDvjw
         xjLHtOKOxJIrmBLL7+KkrNWnrQ+QzUNzdpE0lDkCfOROrpQn0IEJp0FXF+eSVJZPpXyX
         03TQ==
X-Gm-Message-State: APjAAAVxtSoQ+4zLYWXyWnl80ezr2KiiOMXQmMBaQybuKJub72zAc95I
        S1CWuGww6RRhYpeVAZfYfLB8AKq+0+ih4g==
X-Google-Smtp-Source: APXvYqxbQX+BZojyycxMdhs/zf6GMatsLBsK9iSEUafPSHRpXwxVT1/2xUb3YQ6SlOTG/TXUXlWLBg==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr12416754wrg.156.1551697941865;
        Mon, 04 Mar 2019 03:12:21 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x22sm37727402wmc.19.2019.03.04.03.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 03:12:21 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-iio@vger.kernel.org, martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: meson-saradc: add support for Meson G12A
Date:   Mon,  4 Mar 2019 12:12:17 +0100
Message-Id: <20190304111217.882-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304111217.882-1-narmstrong@baylibre.com>
References: <20190304111217.882-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SAR ADC driver for the Amlogic Meson-G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 729becb2d3d9..69aeb5c58a9f 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1117,6 +1117,11 @@ static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
 	.name = "meson-axg-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
+	.param = &meson_sar_adc_gxl_param,
+	.name = "meson-g12a-saradc",
+};
+
 static const struct of_device_id meson_sar_adc_of_match[] = {
 	{
 		.compatible = "amlogic,meson8-saradc",
@@ -1142,6 +1147,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	}, {
 		.compatible = "amlogic,meson-axg-saradc",
 		.data = &meson_sar_adc_axg_data,
+	}, {
+		.compatible = "amlogic,meson-g12a-saradc",
+		.data = &meson_sar_adc_g12a_data,
 	},
 	{},
 };
-- 
2.20.1

