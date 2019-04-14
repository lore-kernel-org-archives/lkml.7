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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3933C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34B52075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meioH2Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDNSfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41752 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfDNSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so7464472pfd.8;
        Sun, 14 Apr 2019 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGTzF41L1VgnLfWEU9BbyLh73JFOItO3TYxOuE7zO4Y=;
        b=meioH2JjyGHt80eChzF+p+P7m8tCQgkztWLt5ZThSW27PUv9JpcUtE33KDUT+52Lb2
         5I18f7P9RoW41jzFQZZo49zc/GiCv251Wm73HfUWudFFhhllpnJhZeX7ysMFkVLkLklE
         Jxb6wXkLreQq4A5MnZdtGcYuSzJRHvgrRTRE7JSxsUll7C9moR4u0rMfuNL+5KzN/63m
         sbxpLt3uZdXp11kAEKyLiQpGT+beHFHAMdgzYvBLpXSSLtVpv9wNuPKs6s320oPz3RGW
         Cr/usyQP2W3odcLYn9JJRYCesZhZeSSL/+pG8TtLET7kl/Qm56wfAHf4BSep8vjBcEzd
         Co0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGTzF41L1VgnLfWEU9BbyLh73JFOItO3TYxOuE7zO4Y=;
        b=r4/7Tr04bTj0pOhfnuFsecDnJx2KZzTng8uyyfAfF5iFa2ta8eXVIp74JuQ4Zl8Q/6
         dVSZ4N3LIl2+5UMQxInEIeBZPJ7LjxO4XP1SCawjxeuWcKsKoEy0GnLpIjEe3b8+s96e
         /DUdyrvP/dDGvcYDkHjABsoBD1dzNhakSe/lHqkvW7qJ4roimaRwJzaAAdUylBrE9Wed
         aBHe/4rcWUjkGBBUDIj0PauXYdaYGBKiq13rAPFPQrjJeYwH46HWgFs9jbe4KiajXc1k
         b/aDBVgVhfADXAFqMyuKJ8ZE0rqYRKtxjsEIGJsrBD6V8b6gEEia5OO+wK+OysXMHB8M
         VuYw==
X-Gm-Message-State: APjAAAV7H4lt3qe+gCsvHVfmX4EI+PJZ4TLR/OemO0FR3NoxJmVIWSG3
        8+v5SlLGwzLuGGd0uRzncMao+4sH
X-Google-Smtp-Source: APXvYqypkd/WRM6BTzIcUnDKsxXexNa9dZOegJ0e76bapHsle7ZrjwjrRrlREo4M0witSBKMN5lfqw==
X-Received: by 2002:aa7:9296:: with SMTP id j22mr71868918pfa.140.1555266918863;
        Sun, 14 Apr 2019 11:35:18 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] iio: imx7d_adc: Use devm_iio_device_register()
Date:   Sun, 14 Apr 2019 11:35:04 -0700
Message-Id: <20190414183504.23286-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183504.23286-1-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_iio_device_register() and drop imx7d_adc_remove().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index c5b0dc7d0e49..958a34dd88ac 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -554,7 +554,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
 		return ret;
@@ -563,21 +563,10 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx7d_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
-
 static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable, imx7d_adc_enable);
 
 static struct platform_driver imx7d_adc_driver = {
 	.probe		= imx7d_adc_probe,
-	.remove		= imx7d_adc_remove,
 	.driver		= {
 		.name	= "imx7d_adc",
 		.of_match_table = imx7d_adc_match,
-- 
2.20.1

