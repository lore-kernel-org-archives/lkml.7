Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D63C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6962121835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VoGDQ6Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgACLmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:42:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46860 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgACLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:42:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so42077719wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 03:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOp7/NK/kDQFb3w2KXAmvUYnxJH6vqk7p3b0dByfVmI=;
        b=VoGDQ6SiKuFgnf2qlFKP1psc3/j9gZewO2B8sqI595AAXi7Ed2XsUavtezZcxzQ+1f
         p/cidDY7cbnLVt3Cy0d72h8fWxNe0F4AjQKooGUwn2+Fjehbvvj5/zLvCOppTVknAd8Q
         F1oBWoqfuLyFU6HITwt0uRO00SO36F/sQ1dUco3i/hpnv9Ft7eEbUpbGKtlv21tT6X2f
         Q/SkDqhwGOTN3AreD0KKT+32vlSaPOmRpO7K9Si3WsIs8SQ/XM+NuIx5cEKxh67bH8ga
         zzDyoo0zOaAdD7WAjSfnNu9rSIULBXph9Gj5tfhyH3WU12WVrjTeR8RlmJdS6/xb8CoS
         6bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOp7/NK/kDQFb3w2KXAmvUYnxJH6vqk7p3b0dByfVmI=;
        b=nXzKO29BDepRNN5HX1bM8RXCAbteb0CtPTZ582AakWQ5k7gp178iGvhN2FDvbqgPFQ
         jkVWdtYNXNYyEEgngoJ2pFm4cgdbcXW8hCuwV/EvbNQ2xJ1IdSxDFPYb1LwkKHiJw2GF
         Ow3gW7TzDOv1nYqjc16e/ceZlZRXRY3jyQA+TEd4os+C79cC8yeZbjM3vrETSRaXTBlL
         /qaFrVIoU3+VlZk+7wj52dC1U7LrLwmguTp6dpL7NigDKXTbuj/btFaAxBnDSNp/2AZV
         mjFAkWTwqfD1cDzdghD6lR9OCLvbLSdpRMegz/gUsD0+Whuh2629+iEWMJtKAwIia129
         PPxQ==
X-Gm-Message-State: APjAAAXKbk0lY956cLkm8X58ZV+VAtuinCCQxVXfMQCgQjx2/iQMHaRl
        39Ebtpl6MktZobnUIvGAy/ZyPg==
X-Google-Smtp-Source: APXvYqxTqq6ykFq8IR98BhEbv2Xpz7UddsNCByTuY68itBs2JcsLp/9mCi6/E/c6kWhLf0xrXdZEuA==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr16048962wrj.357.1578051725088;
        Fri, 03 Jan 2020 03:42:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x18sm59934893wrr.75.2020.01.03.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 03:42:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>
Subject: [PATCH] mfd: max77650: Select REGMAP_IRQ in Kconfig
Date:   Fri,  3 Jan 2020 12:41:56 +0100
Message-Id: <20200103114156.20089-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

MAX77650 MFD driver uses regmap_irq API but doesn't select the required
REGMAP_IRQ option in Kconfig. This can cause the following build error
if regmap irq is not enabled implicitly by someone else:

    ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
    max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_chip'
    ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_domain'
    make: *** [Makefile:1079: vmlinux] Error 1

Fix it by adding the missing option.

Fixes: d0f60334500b ("mfd: Add new driver for MAX77650 PMIC")
Reported-by: Paul Gazzillo <paul@pgazz.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 420900852166..c366503c466d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -758,6 +758,7 @@ config MFD_MAX77650
 	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  Say Y here to add support for Maxim Semiconductor MAX77650 and
 	  MAX77651 Power Management ICs. This is the core multifunction
-- 
2.23.0

