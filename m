Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C4C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26352073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PclJIQfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLJKIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:08:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfLJKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:08:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so19304889wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53E6+zgRkhJFW2BBywNsfl5Bmu09Uj7I3LhsYlPv/yI=;
        b=PclJIQfTM0ArnzA+0SrFj5O66enTwXrsB0tQfetxDJXzjjrrcXYlwzz1iuZxD+Hlst
         698sdGPLLZrFcLNFVSTmXoG7mMq7cMhokXIrA2nQ5CzB0N2qnaHbWKsWh3Mr8cDxOYE2
         4lwW4A+bqR33Oy5L/qg+ZdgEUMpwK+x/ypBv7VXNaVnME8bK98ydZnQThf5GmTnb/s1z
         E2/kUXqDHmq5OWGF4DVXGS2NIocuP01L/9FWH9YLoe6whpeaxAcSUMBZuoe93gzC9C8K
         M7bpnpGTrwCz6CgKAprOu7Wj1bgaU+k3JwT0zt/P1f8sQPaN0xjYEbth7pqKA8QZuwfh
         oMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53E6+zgRkhJFW2BBywNsfl5Bmu09Uj7I3LhsYlPv/yI=;
        b=oBmRWh7JIZpUj/Oie1Y/GzO17NS3+mzGWh8p7OlUSvf2pk7lP+K4UiZwnOrTyIlGkT
         uKu9o7oa3fPxH4dCwQuFb6E+1FneCqjEajkwYYjp5cAsmFojRbnFNQ82Fxht8892JjF7
         pO3vGUr7HVgdp9DAYBtQMSb5AeYDAGGyPGDIhp16uZspjlYgVTrgMrA1fbEGiTtjlw7H
         BcALdbDcfTYzkXGV3RHrf3d9A5A2LPBq7kRUOivAx1Z5/IMjYKfL9kEzLrTdFIL1SzM2
         Iw3ohzAwdhRn5k+i71qvIgmauvbEFHkONLTzZw6fOJz+wuJ/tp8SaXaJo/uE3Fqmy8C/
         5vHg==
X-Gm-Message-State: APjAAAUpOpIG/2tzATIjM4sEnO9weYUeHCAZpcL7jAxXUSvMRUjBxIfY
        +hOuqixCeS66B8N2InCb3PrZiQ==
X-Google-Smtp-Source: APXvYqz7GffBLgKokflLsYKh1DdYRrjX5Uq0IhqIeRUDbHP6ssACz2EgED3lcBsxC5OIi70niFkMNQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr2139960wrp.71.1575972514193;
        Tue, 10 Dec 2019 02:08:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z11sm2485533wrt.82.2019.12.10.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:08:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] led: max77650: add of_match table
Date:   Tue, 10 Dec 2019 11:08:32 +0100
Message-Id: <20191210100832.11186-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the led driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/leds/leds-max77650.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
index 4c2d0b3c6dad..a0d4b725c917 100644
--- a/drivers/leds/leds-max77650.c
+++ b/drivers/leds/leds-max77650.c
@@ -135,9 +135,16 @@ static int max77650_led_probe(struct platform_device *pdev)
 	return rv;
 }
 
+static const struct of_device_id max77650_led_of_match[] = {
+	{ .compatible = "maxim,max77650-led" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_led_of_match);
+
 static struct platform_driver max77650_led_driver = {
 	.driver = {
 		.name = "max77650-led",
+		.of_match_table = max77650_led_of_match,
 	},
 	.probe = max77650_led_probe,
 };
-- 
2.23.0

