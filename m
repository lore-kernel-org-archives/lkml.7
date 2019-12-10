Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C13BC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120782073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bPAQRmcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLJKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:08:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfLJKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:08:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so19277835wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0Q3rlyg/cD4ZOuBBjfL4TrA9kTX5CvG82OdXXHMeyo=;
        b=bPAQRmcUhvcJNrCY8U7uC5UcrXODzhonZEpp5pvH3eBhWeItFe9oJZ+7mU+grlWMUB
         LyGr7XOybE5aYoGNDEzvfr16Lb5+PNyqbaexFf5v3U0AKjVqFh79aRh6Cdoi+mZDT4QY
         7Pxc7HuvIxH2JF581adlgDJA/Zq9+vfWPSJxxWOUaYSPAbNLqn6ATy+31BnEWDXSt11a
         ARILRU7f90mkzQNytOD5nOmmmT9DqDGLuYwifxNxo7TfKkr6LdKkayAQpSzPXqM0gFaN
         Iy4OuxVSYpkx0CqrwwmL/n/hMvtzPK45NiaGAzVJwlTovdlyLEy8Qukf3T5s9sf4GDC5
         TEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0Q3rlyg/cD4ZOuBBjfL4TrA9kTX5CvG82OdXXHMeyo=;
        b=QmkgNtSiKyNLbG4zJm05dhDiiAFcB0KckDbnlOIYeDh4xN+bkWDRItg7Hbc2qSbTMn
         f8zC/GKnod3icjpABNka58HnqAvXmge5MnaEQq+yIfR8EM/GGYiZRRAycg/Nqc4Szwoi
         clQNpEAgsaCbGJVofPXnYkbi0/rApkDXOK7Ok3Yqq+A9d3gyMUzKgaJH4AUx0ebmOrlg
         eYNVVfUno2vkfj70ChK+rtqFa0N2TtlOdgQfoZOtcq8Z1FNSbmFmCHsGX5XYOduvUS8x
         2kv25hNzCp0aleE24pmIkgsfbVnSipEjQcplKd+lU7t3iv3lLh9nXwaIg4pbBQHiKBwM
         CoLA==
X-Gm-Message-State: APjAAAWBMkKytRujgxDMIT8E+rrtS/MJukITR8ph2TnHqxH0HzahvZ0c
        BT/Y6sDPlQSzv2Oba9Yltr2uwA==
X-Google-Smtp-Source: APXvYqxuVThypfwC7Fvv6ys4Y0xFGCC49P5yn1lExjo9Q6sxcbnAKDrS3fV7I0Yhnd4ByPDj/bTPJw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr2371552wru.6.1575972484233;
        Tue, 10 Dec 2019 02:08:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t8sm2658949wrp.69.2019.12.10.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:08:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] input: max77650-onkey: add of_match table
Date:   Tue, 10 Dec 2019 11:07:53 +0100
Message-Id: <20191210100753.11090-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the onkey driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/input/misc/max77650-onkey.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
index 4d875f2ac13d..ee55f22dbca5 100644
--- a/drivers/input/misc/max77650-onkey.c
+++ b/drivers/input/misc/max77650-onkey.c
@@ -108,9 +108,16 @@ static int max77650_onkey_probe(struct platform_device *pdev)
 	return input_register_device(onkey->input);
 }
 
+static const struct of_device_id max77650_onkey_of_match[] = {
+	{ .compatible = "maxim,max77650-onkey" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_onkey_of_match);
+
 static struct platform_driver max77650_onkey_driver = {
 	.driver = {
 		.name = "max77650-onkey",
+		.of_match_table = max77650_onkey_of_match,
 	},
 	.probe = max77650_onkey_probe,
 };
-- 
2.23.0

