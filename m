Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A7C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902C721473
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmBTP9IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDNSfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37178 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfDNSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so7481697pfr.4;
        Sun, 14 Apr 2019 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GcxksI+ld72d/6gUyG6MFtmActZkm6DcOZlU68HWDE=;
        b=DmBTP9IXtHoygWbmigNZ74BLd4p8+zCoEcrjSt8g8NucYol2G0Em3KFu5sH3bfDSce
         CFXYfx294I9CpMZC7+KcIjJcqPs0GNzJt90RlWRoB9Et6xT+Y8ZzOJrzUWCCLa7sBGEd
         f+/l5VL+me1OSHvd2lNWKCvMBHDbF7angHF9MFew++ZusYT0KmMzt1IJiWBX53c6ZVj5
         W+Px/uFTT+blfrs7BZtPMFM2XSA0BObyr7yyfR3kDp3QmLdKrtO+bq8Q86GpiiE+M3Rt
         RjPgsQtqWmrbl6CH2nVaeMbPqMPRbdXExwGxwTFmI+UUB5WE5FILPqf8anHu/RxAqwqg
         CCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GcxksI+ld72d/6gUyG6MFtmActZkm6DcOZlU68HWDE=;
        b=IfNS/ueRLAYclGUji2YQfv2PmlfO87EL/cTiNeGACcDjHzFqdgmW5NJVsN/PJrHKN5
         gJsovVC5eZCENcUBVv4TIVf2+4wNZytnmHx2TR+RbgGHoOGUf9QM3I6Jr6DAWodEIUSd
         ZeUYqsjouyCKdSuJbjjZ1cU5S5/ZmlMs9zJdoY4GIclsVX87TH8NXdfLrr1pHponlsk1
         jhXyVdeosw3jbShqu5vcL8XhW43L4Zh5bCLg1qGqkN4fvDLjeFIo9NxqLaMfKsv+YXrH
         Itd0573rquCIDcr/GUiuP6QKvKZYMs/4PhbEIqT+AbhbiSwPB0AO5xLBFnUTyWZpJ/Mv
         7l7Q==
X-Gm-Message-State: APjAAAXtR7xCiTW0tUSZaxcDMM9WwwqzQmhX2oq6ydJyYdgl/vdwtER2
        JfJqKRbYh0lzJl/UoCWiJJFOrspR
X-Google-Smtp-Source: APXvYqydGvv9m+D0ckMK7lifAjO+KEkGnl3XuV9ekZI6lLewrgZXGtMa6wsXuo9DdmEpWamEZ3pbRg==
X-Received: by 2002:a63:d250:: with SMTP id t16mr64362495pgi.288.1555266914707;
        Sun, 14 Apr 2019 11:35:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] iio: imx7d_adc: Use devm_platform_ioremap_resource()
Date:   Sun, 14 Apr 2019 11:35:01 -0700
Message-Id: <20190414183504.23286-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183504.23286-1-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to be able to drop a bit of
explicit boilerplate code.

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
index 72cfe9834bcb..147ee8575ad0 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -438,7 +438,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 {
 	struct imx7d_adc *info;
 	struct iio_dev *indio_dev;
-	struct resource *mem;
 	struct device *dev = &pdev->dev;
 	int irq;
 	int ret;
@@ -452,8 +451,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 	info->dev = dev;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(dev, mem);
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs)) {
 		ret = PTR_ERR(info->regs);
 		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);
-- 
2.20.1

