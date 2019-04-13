Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1AC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF90C20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9F3zM/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfDMI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfDMI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so6231580ply.4;
        Sat, 13 Apr 2019 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLQ/nNmpG86cdxUkBF2/3YqgQ/OejpmjaLfh3C1Z/s4=;
        b=L9F3zM/pd92X9TaVrcKKjPtEOhDHUSLzFC5wIWXuoPTJPvhzknIihGT4PcTzqDVbNo
         7I+VNfiWhOYiyp9DEaknYzR7I2FJWTqYsEdGJIP3WnIRey1mJXD7eQTMalbCaClz5ItS
         iF7gDRCnMTkqWKooiIXIiYfc7nh9ip4Yw1ovbq3IaNKBZBdvsW8Hh/iH74ZIVIMU5zDQ
         Baq2f7/a3tDkpafNkedP4sqggW6hnIU9b7lirhdr+llP6pPogH6Iwp5amn39Pwl5kETF
         G2rvsLuG/sesbjLGqsWbdKmlzwy+hNFJLMdIWkPRSKauYDwzxlyoor/+6QxI+YpaYgkV
         /klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLQ/nNmpG86cdxUkBF2/3YqgQ/OejpmjaLfh3C1Z/s4=;
        b=tzJ6mPW73Tx3P1yAt5vzfI0jCXfnLtEoiikA3bdPJNnN9ycZG1LGKXEyTDfV7WeipI
         +OKz9dHeVwFBCvTzaX9I01Ne0jpc0X985wJUfbliptwGBX0qJctHuvOMuehVYUYZBr00
         3ztIE7lz0gAvCfxQZHbNSkeJgKKuiYFmv3pYWDFvL+V9tBpXjGfplmBEJSjBMPhdszDx
         htBs8dRT1d6AkwldXWXTWygUfbpx4JHnfItfR5bqyAj9T55LV+4Io6p/TLZ7rUKr/9Jx
         0hKOiGA2lrky9oi0QTSX1N9o5vyoLtozNmAiEmhv12Dz84bfRd6O5HdbIU59f/Dcsi/g
         Mrfg==
X-Gm-Message-State: APjAAAUJdymTeMmSQ7cdYrS1kUxu1Xds3EKhbh0xldWseGZNazby3HkP
        ZqMzUkXGsbJ18ebL1OH0yw5nIJ9q
X-Google-Smtp-Source: APXvYqw3qTdW0Wvq+ebg/r95kQZU60CBOm9Gol6MNlLUzxMHhdRpyXUDZ4qRw9lP3ruw9SpkKqlGAw==
X-Received: by 2002:a17:902:9048:: with SMTP id w8mr63357472plz.195.1555144086165;
        Sat, 13 Apr 2019 01:28:06 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/12] thermal: qoriq: Remove unnecessary DT node is NULL check
Date:   Sat, 13 Apr 2019 01:27:37 -0700
Message-Id: <20190413082748.29990-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's impossible to use this driver outside of Device Tree, so if the
probe function is called, the dev.of_node is guaranteed to not be NULL
and guarding against that is pointless. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 405d1fbdd0cb..5828314ec74d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1

