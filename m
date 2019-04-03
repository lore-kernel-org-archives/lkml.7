Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5594EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248FC2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC5Y7EMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfDCHEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:04:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfDCHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so7823106pgu.10;
        Wed, 03 Apr 2019 00:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0Yltnmqgxph/eGeJ34Ce62Zgj1P8Kis8u3YVkRijyY=;
        b=hC5Y7EMy9VWhxlyShK6uB4W3PKqXn7DkXMGj8qzITxSM1agmgfKfmf2qIeAbtP9aCl
         S6EE11zm0OgZWURMX3uUqrOuEYFtGgZz+lwZ3ECoFdFZ1r9ibY6GbKzWqFyek6fth2Q1
         UtoaWlDH2VkG5Clxd8t6jZlpV0zo/q63vSXF2T5ve5XwnfJyZdBow4Xxdey41iF7quuN
         CRRka00/cgaSawJX6IERwpqasZlsjsKmuU5VwvUMNuz7MBrQeL9F071lgTVTfte8SRO0
         OHaHCq8o9V30EiMIYSiYyq3CAYLDPigSnsaTjPO23Ejsp+zXs2pfVNBPRMIQM3JfO0fl
         eZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0Yltnmqgxph/eGeJ34Ce62Zgj1P8Kis8u3YVkRijyY=;
        b=LxR7TOsVoYqIfVfUMLNAacWHz+xE2OF0tZcCtadwzoAcU/nS5skrys2E9fhyBr1a4J
         h6ES8kxUQ5iylqVKcX22/yHbbrHZ+ONU7EpqQ6W+LS2FVtTSWF0bTqcX8LDTnbDm/2WY
         95/feGKKSwbfrfjxjWnE7JZBglmg+tywojwyg5ihW9DMXPY+SdMV8jxyyn4bb3CTOeWx
         oRrqfCjBFD32RSl4HoscOYpuVzF5cT+hLDGXtImm0xSmuoTpzARP/Ki6AcB+q+VkqAjj
         kpwkZjixeznp/ml9SqQaNkSISwGXzKJrQt3ZdiA4dHb6OkyI1b6Y/Y4og0FpE3JniGPN
         0C1g==
X-Gm-Message-State: APjAAAVRzHlMZk+19SbVlMTNzhhM9y1/efik24v1UbJEoCsw1Eflg7od
        PcTkaj1iv4qv5nyf/IC+g1sEEmH9
X-Google-Smtp-Source: APXvYqwEBURyZYDon/koDwEhab+CF3h84IKy97fUy24tqt9WnON6QUwyjZub8tMz/McbSJ2I1QGWXA==
X-Received: by 2002:a62:58c7:: with SMTP id m190mr73357796pfb.4.1554275028199;
        Wed, 03 Apr 2019 00:03:48 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iio: imx7d_adc: Use devm_iio_device_register()
Date:   Wed,  3 Apr 2019 00:03:22 -0700
Message-Id: <20190403070325.1077-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_iio_device_register() and drop explicit call to
iio_device_unregister().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 72cfe9834bcb..9a46838ec7cf 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -517,7 +517,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	imx7d_adc_feature_config(info);
 	imx7d_adc_hw_init(info);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		imx7d_adc_power_down(info);
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
@@ -539,8 +539,6 @@ static int imx7d_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct imx7d_adc *info = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	imx7d_adc_power_down(info);
 
 	clk_disable_unprepare(info->clk);
-- 
2.20.1

