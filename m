Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D8C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E815C2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vmvwmGEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLJKI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:08:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfLJKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:08:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so19306030wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmXraLxcHSpW35myu7I+B9nstgq5MxK4V2VimsmMd8Q=;
        b=vmvwmGEPJaOfpVKMoAgpHwHqH4DSZ1j/trCMbExQ9xzY7fEc8MS71UlD/1JVFPgsWZ
         eRnqvF9UeBzTz6JnU/C/H/o8uwNN8vNOD9ywUFJSqgBOfNZ1hcnaymzmzdeRd5xP7PUu
         SZFChz+Ig08dPyNYi3sLXiO8Vr7sQAKi/F1YI3QSccR6jy9ccSJCCRqgrSPEgRs292I9
         7V8opH/42799pk0/tj+I1JkkrZQwgSvxPJNcQMb22jgUbq2KTvDg1du8saN5Pz4evSg2
         FaYnpXmykU+u9Wirep/HHn5hHlFGG7M0iW8YD9ZgbpvVSdcfCkam2RZzv+sK57/iIdGr
         NYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmXraLxcHSpW35myu7I+B9nstgq5MxK4V2VimsmMd8Q=;
        b=uH3q4R26hlhRY6XuF+bzzR9xH3a75BXQAXp/MgmMsoMIR/hF6Ukr+V6gzH3uzXheco
         yHsxBbdkoUd7MS8Kvm83pxAoPj80baj8IZd9bBtBrwX71WkZglsaAh8K/LAWXOjSZyU7
         /0A3x06eR3QlcvA4QnIsa3qVjsPBdT2A4RjXdCqcbyMy+iWw6WjofPy0emck3b/GS+4G
         X9CY40YglHFbn/3gYh4KeDsU0FIka2SXhU0JqeVBNbjFoPRRqOxciriqIkVRLFUx5JB6
         LfW2bCRX7qWg/KBsd0Jj/2tp0tAj2hhDGNEWqqQd9x9cnieErtqhZyFvoJAinsjyWlcM
         M91Q==
X-Gm-Message-State: APjAAAVeU+JnZOmt1hvwZ7Uc6wmeJYdytmyOSbv9hgt+Zqp4PAB3ABjB
        Gv6RPZyYNbcF4DxCcxkSlyDqJg==
X-Google-Smtp-Source: APXvYqxXggVqtg2wLF1aAKh1TnH7Vc3phZwAUgHw1rAwoN2bqO5sh1FHO27U1ggc2547SbjFzD9jrg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr2234029wrq.176.1575972537067;
        Tue, 10 Dec 2019 02:08:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k13sm2642109wrx.59.2019.12.10.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:08:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] power: supply: max77650: add of_match table
Date:   Tue, 10 Dec 2019 11:08:55 +0100
Message-Id: <20191210100855.11252-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need the of_match table if we want to use the compatible string in
the pmic's child node and get the charger driver loaded automatically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/power/supply/max77650-charger.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index 5f9477c5cf5a..d913428bedc0 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -354,9 +354,16 @@ static int max77650_charger_remove(struct platform_device *pdev)
 	return max77650_charger_disable(chg);
 }
 
+static const struct of_device_id max77650_charger_of_match[] = {
+	{ .compatible = "maxim,max77650-charger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77650_charger_of_match);
+
 static struct platform_driver max77650_charger_driver = {
 	.driver = {
 		.name = "max77650-charger",
+		.of_match_table = max77650_charger_of_match,
 	},
 	.probe = max77650_charger_probe,
 	.remove = max77650_charger_remove,
-- 
2.23.0

