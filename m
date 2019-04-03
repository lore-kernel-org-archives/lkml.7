Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C0DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8107D2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXwCGDl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfDCECV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36206 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDCECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so7613142pgc.3;
        Tue, 02 Apr 2019 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyOnTBJf/kTDbr8sbHX90kGMHGeBMmlt7qQvUMBV6R8=;
        b=AXwCGDl8j7mR0lj+I7+AvreG5NKPpLssswWxd3yx2MFt1Ol2xIyDe9VwRf5b3cEqZT
         1q8nx/SRn2MNYA2XltmPs+ryqoOpLPFYQaL685BW5wPRms/rHTgI08oHETew5amhTQqk
         Rc6Koo/xh3hDysvUWsoKS8XQb2zK0f18qTmx3dasRHfBXbCPgvu9DtTZxoOSQCuzpL9Z
         E2WsJCt6D7bngVuqy4KHeoYMef5Q9vVD093MkztIPvqIlbsOBRJhBsTPljVY9eG97s/z
         6a45dyRRe/us04vM3eMJg0DOIAKO8phT+rxso6M4vosqtd9v3L/BUCQW1qp4x5BGo+20
         bmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyOnTBJf/kTDbr8sbHX90kGMHGeBMmlt7qQvUMBV6R8=;
        b=pTh3MnuU06vy3i6aaWSMPLv8HFcaxkLsaPcpDhymftKGHA39h89Fp5aD2XjzbnY9UU
         JNyyMG8ERQcbzi+8fQLZnz/lLrOcbZB83rfuGMnadvihJ2B5dNiNj33EmunSzbl/2+zB
         az7aF0vmsRp3oMRWqk1jGvx01HIF2GdHvTs291pwL2EzgfL0D0LpB3HvoL3/zhr2ze/w
         ahxQdik7QaNqoFNlB76sS/8+0H+0h4omyT96B5h0bigNA0IWHZ7YEdjTwiH6BrEdtNSL
         OMs8/ach+F7JzQwuxVBTJ3XbYl3p+lFO+Skk3AYHJbajBfUdDl2wnpjed19alzKZloPN
         x2Lw==
X-Gm-Message-State: APjAAAVF+W31xtr8Zicx8rTzLgYx3SlPF1oXeuzBcxXgiv+nfZh5zLGi
        pcqn4C5fNpGR4IoKKuJL6kShpIqI
X-Google-Smtp-Source: APXvYqxeUsVilA9Lr7txbpx+AndJ5LWeIK/Em8v+1oBU1sC5ufT8eWQ7DcmuVPTTpWayUO3ehoQvCA==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr69081973pgl.213.1554264123069;
        Tue, 02 Apr 2019 21:02:03 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:02:02 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] spi: gpio: Make sure spi_master_put() is called in every error path
Date:   Tue,  2 Apr 2019 21:01:31 -0700
Message-Id: <20190403040133.1459-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a number of failure paths in spi_gpio_probe() that do not call
spi_master_put() potentially leaking memory. Fix this problem by
registering a cleanup funciont via devm_add_action_or_reset() right
after SPI controller is allocated.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3a6a9c6966c0..668f2cd82d98 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -363,6 +363,11 @@ static int spi_gpio_probe_pdata(struct platform_device *pdev,
 	return 0;
 }
 
+static void spi_gpio_put(void *data)
+{
+	spi_master_put(data);
+}
+
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
@@ -378,6 +383,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
+	if (status)
+		return status;
+
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
@@ -429,11 +438,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	status = spi_bitbang_start(&spi_gpio->bitbang);
-	if (status)
-		spi_master_put(master);
-
-	return status;
+	return spi_bitbang_start(&spi_gpio->bitbang);
 }
 
 static int spi_gpio_remove(struct platform_device *pdev)
@@ -445,8 +450,6 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	/* stop() unregisters child devices too */
 	spi_bitbang_stop(&spi_gpio->bitbang);
 
-	spi_master_put(spi_gpio->bitbang.master);
-
 	return 0;
 }
 
-- 
2.20.1

