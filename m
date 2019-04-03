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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9ECC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFFD21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWZbvmDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfDCHDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:03:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45222 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfDCHDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so7817725pgk.12;
        Wed, 03 Apr 2019 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsmfB0G+hQf4SGB6WnLz/inN0CmeW1ILJP4wTpRSWHA=;
        b=CWZbvmDe4f5Q7tQeO8FGrKLK6K77hcEaWSKAvOjjMJRoFCyxNzeW7IL+vKMXRV+fWj
         Z4rr8dsKUhJ46p2QJQzEIlTxSuytxBOUqOazI0rCz7SJXe9TUuQ1I4WALGvYjqlhO30E
         6AbuV1jP6EGTKrsipSgDKkBmDl+pp/XAo11oC8MpEubF+GQyh3JnqK221mHf/aPp5JCw
         o6EyWN46quz+AFDSSJ3LSJk2IL57p1HQ+rEne1Thkfd0NcHhZ23IbRQn4QBDwxai8ow0
         oRuEpfGd9Z0NIvz4mfqCZAaljfO4ecL7svA+wORflD+KUEabiM5dOqRpDP0TKcMgSK4P
         MxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsmfB0G+hQf4SGB6WnLz/inN0CmeW1ILJP4wTpRSWHA=;
        b=sJ8PQHwO8BMjmfnSLhotyO43J5AXPU5ND18Mmn4cbRHJ+inrdIz52XWus0U9OFBRc2
         UDfhjQpCKE0o+WDs1dpNIjUqoIWUqM1JC6vTGkxNRNvHo0JAtS9PCcaCxEMwM7Ubpa6X
         I8lmw3ybyYYKzIBrBuavFTe/F5Y3ZRn7cXlcxzks0dzkJcTCfBeKK0j8XFwU/7R2KDEj
         cgGoOSnbI1UydHn3q7Qp5hzgbs/2jAkothMT0R0uU8DzfUeQpbp9qC1+Dv0eOg8gXDG3
         ohp4GWuYdm7MgXr1zngJLShWFQOl8j16Y2HZWI/XfLgRHzo48mU1xPm5vHeUgES6guRx
         d7jg==
X-Gm-Message-State: APjAAAUWkglQNzpCZ0hxAunuHukPtspQ9X/M+7u+kXOGNlNh2n1bZ9B8
        GEafL+1SaKumtZyNV7d3wyTbjhwc
X-Google-Smtp-Source: APXvYqyiVVFOOPm5x/zLFIF4bBzOAvq0KB/UEKDgONWbFMxphyoT7OObXmLpCzup/UXl7z3OG/XUfg==
X-Received: by 2002:a63:525f:: with SMTP id s31mr70502941pgl.172.1554275029566;
        Wed, 03 Apr 2019 00:03:49 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iio: imx7d_adc: Use devm_platform_ioremap_resource()
Date:   Wed,  3 Apr 2019 00:03:23 -0700
Message-Id: <20190403070325.1077-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
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
index 9a46838ec7cf..8bba92611d54 100644
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

