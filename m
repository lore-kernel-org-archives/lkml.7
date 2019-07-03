Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA878C46478
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C720645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eaf2/9/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGCIs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:48:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:48:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1795864wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ou4rA/n5hCCp9CgLmxeOwfLMMWhPGZsRnA/o3AAcdA=;
        b=eaf2/9/b7qnhUd3T4ObWSAESQTjOsIsSaM2oVq8l72KqM7AEuFp6Y82TENcioyjzTN
         FD9aniLsLgwy+dmixV85NBn/f6EcREUTInTwtq/ZnJ3x3yuDinqMKYvREElcJr4sPtxU
         waOVyxjXkeJIfOcJ165poyi6Ee4q5hy/rgHNRahTnqhdDxJ7fkj+qpbRAnttwrogODBI
         bc6Dmd0D76RAzuaB8KbrNQai9V+AltdFPeVM5Hc0qeA1idP1hc6EU67zjlkrSTLa6NdC
         3hWmQU3McBpwltQNId3AxMbu4bEvZhOJBjWwzOYhCr1J6TZfyl3HK3e0c6skUIbFscnI
         ZB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ou4rA/n5hCCp9CgLmxeOwfLMMWhPGZsRnA/o3AAcdA=;
        b=FzwRMJIy7mfr2fAtdZAxcQIdBqHydrwnmYGmPLM+vI7FWYvCTfxf45RlJW9nDJEcM+
         r+V7WYlJSoNJMOUbDWgMfjFvbJe9YTtF/LPUDOR3zGYKM3YaQYcnDXJFwQt9w/GYAvFz
         U+LIBj9gDheExEERbFznitsHjkBmgTCqXj8vLQkxIlLtUARjFvdieUnvB4oyXsenm1KO
         YXsPTyJ3msKPbB7pkp7ZYmCmBT+zwJQm2TpSrhtJSkuyZnTA0A83NHfK+f8WWFiEJXeQ
         mjIX/0yCEdqa3B2dsTmSSYR2SMkh+VtJeXHKZsPCfyZBVJgZtpwphCxh32avBXaydf9U
         3BOA==
X-Gm-Message-State: APjAAAUyKxwsfen8v51Bm81jYALUyKFr7d/AHy4jQw2OZ0tYkCSeZAzh
        +7scSmBkakTvE2dWKSfzZQoWIg==
X-Google-Smtp-Source: APXvYqw6Ny54WrUCsn9o9sdC2JQrZTkp2gkJEzcpvO2fU/RY/j4DfhvgXavceUCRejF9V2gW/63QfA==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr22637747wrw.337.1562143734249;
        Wed, 03 Jul 2019 01:48:54 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t17sm1963200wrs.45.2019.07.03.01.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 01:48:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regulator: max77650: add MODULE_ALIAS()
Date:   Wed,  3 Jul 2019 10:48:49 +0200
Message-Id: <20190703084849.9668-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Define a MODULE_ALIAS() in the regulator sub-driver for max77650 so that
the appropriate module gets loaded together with the core mfd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/max77650-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5c4f86c98510..f81c4c1c82b2 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -496,3 +496,4 @@ module_platform_driver(max77650_regulator_driver);
 MODULE_DESCRIPTION("MAXIM 77650/77651 regulator driver");
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:max77650-regulator");
-- 
2.21.0

