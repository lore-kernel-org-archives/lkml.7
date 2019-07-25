Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644302083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gU9RlzjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfGYH4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:56:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43948 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388666AbfGYH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:56:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so22596057pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oPhMC5eLv3LSVkBhX5uqN94UAFd9buQ6xbizcntcIj4=;
        b=gU9RlzjKhjVYpSzfgbQtfgo4FUEPEtq8PTlxfAMmALiP6j7lO9a1JjhQ2/waNbbRh3
         q1cqem1MSNir9sfiSTZdURrn+1MBTgX6N4mdEU735+P37HKkR8LNRkiZJwGBuWz5FRKZ
         B5s70u0vk96SBR0+TgZteULP5GWzfT2/PH+NWm6TtTo3TnQ/gkOCPKbAJ3ColBXyB9BU
         vMxReKCWpwvNFYUeXmW497IB11fJ9hMBG6xvQtlFqFpQM5K6IQ8dPQuYSMEQsu15qQkZ
         r6HatIt/DN5NQcHMp1ItDn0gArYHDJ3e17HrL6b+3ta7UqGm9RXU01l81wiUHMDV1jNJ
         24Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oPhMC5eLv3LSVkBhX5uqN94UAFd9buQ6xbizcntcIj4=;
        b=jJN6GibPob6rZQ/oFR37tEweC9g0zZdKrK/314O+EK1lEqFohFpuGcUjIGIgnXfMn2
         oGQdR8DXSDhQ8/bEdqHFb0mXuaTB7mMGilEjQV3GDfBESQao6SQop3CgYqrKz3kQ0x8J
         19QyILOeq80usGXivlEObksHNtuZALhRNqnRtFivefN2wjs5VtPCur8bPEXRqNJDopbI
         tefmZo/uj9VNPOv3BDmBHQEZt3SdCWEHvoNTP9gU/a+gn4zSFfJG/SfE4LemfCA6RI8C
         vWTleTsEgC706zLTSiR52xd79WXdgR+vH5QzNMUY/Xm8BSESEHZKN1hgpFLcj74Ju4ef
         Ux1w==
X-Gm-Message-State: APjAAAUgtuqChibuQRnf4R/HEdJRLVWeyMuQpc3W9cMJPkMH2s/qMnR9
        fD3pzuYCNXH0LF51bn170BVMqg==
X-Google-Smtp-Source: APXvYqy+e+5oK4u7Xqc2D6N3+nHwMsCbW0trRnX/rMhmvbjT0I6R9vvI2j6wgbVVk2Bzh/re5uUU2A==
X-Received: by 2002:aa7:9407:: with SMTP id x7mr15929124pfo.163.1564041395498;
        Thu, 25 Jul 2019 00:56:35 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m9sm89021419pgr.24.2019.07.25.00.56.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 00:56:35 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     wsa+renesas@sang-engineering.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] i2c: sprd: Make I2C driver can be built as a module
Date:   Thu, 25 Jul 2019 15:56:16 +0800
Message-Id: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is no need to keep our I2C driver to be initialized so early,
thus changing to module level and let it can be built as a module,
meanwhile adding some module information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/Kconfig    |    2 +-
 drivers/i2c/busses/i2c-sprd.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 09367fc..69f1931 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -977,7 +977,7 @@ config I2C_SIRF
 	  will be called i2c-sirf.
 
 config I2C_SPRD
-	bool "Spreadtrum I2C interface"
+	tristate "Spreadtrum I2C interface"
 	depends on I2C=y && ARCH_SPRD
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 9611235..8002835 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -644,8 +645,7 @@ static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
 	},
 };
 
-static int sprd_i2c_init(void)
-{
-	return platform_driver_register(&sprd_i2c_driver);
-}
-arch_initcall_sync(sprd_i2c_init);
+module_platform_driver(sprd_i2c_driver);
+
+MODULE_DESCRIPTION("Spreadtrum I2C master controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

