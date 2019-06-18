Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C77AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6CC20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RUZ5pi4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfFRPnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:43:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37568 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:43:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so53226wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2DroQv2ruFtbq7x0Nc/gqYAN5TH+pK8pLfYV3S723M=;
        b=RUZ5pi4GEOGMywZronlWI8Un8Y1j8se22zqHCih+IyO1yuWzno8FVkuUjJBI3m0H6Q
         WP+YBGRHeje8c5wvIMHqN7krS90n0cJhrasXt3x0ulEmWaGWSp/ys+LYjmb7QWdcRWu+
         niqe1vDD6rIcuo2KfRBS5a2SQZMCAzEE7Ydb2pGdgWlJblMRS7A2EL3Pt31Z29uGh/Co
         /96ef69t97+oB8uh+groM6vvJwNTZ4IdxZE9tWyCd1AnCvU2fOJB/EJvIs/1t2gKJJv2
         Hzb6Bdqzi6zhHpcMMg+XCwpFEzxSGcqCaQoIFoAWu8YaeF2JM64TdjnYcyWZNTccyS3v
         vbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2DroQv2ruFtbq7x0Nc/gqYAN5TH+pK8pLfYV3S723M=;
        b=MHZAi6weumHNPLrx8v8LNJt4pr5xljKuCWnAgsGV+C/M6XgTekE5FooJL+6QnjpRzo
         985bb8cdXj6xy8kbsAagbors40cJe9yFl2oXicnS65vebQc2lwCdsV5p5DLzw1Ovl9fb
         kJGdRJc88hLov4V6Lev3DhZY/ptGHvKBjVULRqs5FZqp1P7DakpUS2kKyPGmX45ESiBM
         L0LiGX58uPNPJpC5ksMyrz32SyCMXDN2qH9MwVYtD4150Se1J330MyVHztvDOboTgTz4
         dvngqrftu790uvvOWxU7qQ3zDwjDRH5td1cxE6wf21rI8eeKhkXWgHLKwt5dfyvWR+qr
         qDSw==
X-Gm-Message-State: APjAAAU4YDu13lrumjlY9Tcjfi9yHEJqNc3JuwawTCmG37sI1yIf4HtX
        I1qRS12/Gv0zhh+2xfY27eeedA==
X-Google-Smtp-Source: APXvYqz3Tk6+Cw9PNouMQlpWVk3VHeEq+wax/N8KlWO1MqvPx1tt7KUzbGTY6HmB7/AfzGz9g8DQjg==
X-Received: by 2002:a05:6000:1c6:: with SMTP id t6mr40208869wrx.236.1560872631011;
        Tue, 18 Jun 2019 08:43:51 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z5sm2633287wma.36.2019.06.18.08.43.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 08:43:50 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] mfd: mt6397: Use PLATFORM_DEVID_NONE macro instead of -1
Date:   Tue, 18 Jun 2019 17:43:46 +0200
Message-Id: <20190618154347.16991-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct macro when adding the MFD devices instead of using
directly '-1' value.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 337bcccdb914..190ed86ad93e 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -299,9 +299,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
-					   ARRAY_SIZE(mt6323_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6323_devs, ARRAY_SIZE(mt6323_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	case MT6397_CID_CODE:
@@ -314,9 +314,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
-					   ARRAY_SIZE(mt6397_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6397_devs, ARRAY_SIZE(mt6397_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	default:
-- 
2.20.1

