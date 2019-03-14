Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1269AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B3321852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a7krBakc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCNPIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:08:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40382 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfCNPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:08:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so6251194wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6fuNqsQ+BOvEoXpno6EWlv6F6RdSdbtUvXoIjHVdh0=;
        b=a7krBakciN2OwiMBchmY9jcxNhB7cZPjD0V8bzqPocFfnSjzzGeAT6X/HWbBUIVGm7
         j2QFXWIoi1kXJ9HXIf1l/clPmUf4lrhbnYSUYYmOy5+2XvdSaVTYaKe5CZuzfI56w3n/
         ggF1qhhLAKyhCKn2kn7bzL6OMvwwLbsSdPrLzxW6hc08o9eQOZtRzyoPHd/sz1Wb+ul5
         EIlnU9QIV6KSn6rg0uMYSkRCcNSrgiyjqJ6WvWuhim2ZWg4WbHcTXpiyRG36EcUmH2Vs
         0bkX+H0/85xiZR0ycFtH5BRNQgz43dShR2XOwHSWdHVaa1OD4gaV98cLNChnYAq6UdQh
         oK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6fuNqsQ+BOvEoXpno6EWlv6F6RdSdbtUvXoIjHVdh0=;
        b=ANXPGGseoLR5HSIrI6x9rtJ5QVUQAhCVkjgXrdL/iqJ8lu0osfb7HCP0YZRkX0aoEZ
         K020ddh9tnnTM/F9zn4gD70GAYmVOgMJLOGoyBl/j6EK7FA4itJCAwbx1wozoygHHAvH
         Z6sDjNHVsoTJTbaP+4kyWkdjdGjbtka1UsOPCnFbY71QflU3MmTi5pt6IrjONqgNla31
         EaRfouhJhgF7AqR+MsbjjXFwhb+5ibAAh+HGj4lgnas2O0MPr6yKj/ySqIDYQugU/yJw
         0PwfhUpzNm/92nqR8AmF7eeor9dSlBjg2SSmGIstC5mVgDFnPjk+vscE/lhjgradND1j
         9/zw==
X-Gm-Message-State: APjAAAWAgeVyROEHpPTEgCyAQdvEzAnXtjhoxUzx0gTievqfQSCsdYeN
        6HeeqmKwSvmLcMlClKydPR5L/wGIjBQ=
X-Google-Smtp-Source: APXvYqyXl65hU7NlqkkGkzGHl4jHfMg/wv0GfbVstxK5CLojU1SUfBCTabKcr+JRdf8s5HseG9SjHw==
X-Received: by 2002:adf:b591:: with SMTP id c17mr33921681wre.195.1552576084866;
        Thu, 14 Mar 2019 08:08:04 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-31-143.w90-86.abo.wanadoo.fr. [90.86.86.143])
        by smtp.gmail.com with ESMTPSA id p6sm42947662wre.63.2019.03.14.08.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:08:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] gpio: mockup: move the driver out of the IOMEM drivers section
Date:   Thu, 14 Mar 2019 16:07:50 +0100
Message-Id: <20190314150750.9371-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314150750.9371-1-brgl@bgdev.pl>
References: <20190314150750.9371-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The testing driver doesn't really depend on HAS_IOMEM. We may want to
build it for testing purposes on architectures not supporting IOMEM,
for example: on user-mode linux. Move it out of the "Memory Mapped GPIO
drivers" section.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e9473e968d9a..474ab3f7f9ce 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -330,18 +330,6 @@ config GPIO_MM_LANTIQ
 	  (EBU) found on Lantiq SoCs. The gpios are output only as they are
 	  created by attaching a 16bit latch to the bus.
 
-config GPIO_MOCKUP
-	tristate "GPIO Testing Driver"
-	depends on GPIOLIB
-	select IRQ_SIM
-	help
-	  This enables GPIO Testing driver, which provides a way to test GPIO
-	  subsystem through sysfs(or char device) and debugfs. GPIO_SYSFS
-	  must be selected for this test.
-	  User could use it through the script in
-	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
-	  it.
-
 config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
@@ -1440,4 +1428,16 @@ config GPIO_VIPERBOARD
 
 endmenu
 
+config GPIO_MOCKUP
+	tristate "GPIO Testing Driver"
+	depends on GPIOLIB
+	select IRQ_SIM
+	help
+	  This enables GPIO Testing driver, which provides a way to test GPIO
+	  subsystem through sysfs(or char device) and debugfs. GPIO_SYSFS
+	  must be selected for this test.
+	  User could use it through the script in
+	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
+	  it.
+
 endif
-- 
2.20.1

