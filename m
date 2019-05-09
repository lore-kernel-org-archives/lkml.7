Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C8C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C020644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVNkiLZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEILLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46200 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfEILLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so1824236wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvXnZafEYce3eQKqHnoNFRM0UdhTjWak2LbszgnoCDw=;
        b=nVNkiLZZnD0l0mljltaU+TL2K/INQVTmvo6L6LxI4KN1XdK8+rV4sSWsBWCDaI0v2u
         4MV/gdQ/dH//yjmesEhgh7co8VVsOg9SGz0aNJi3RMSiZNJN3uhnXNWjqYPg3i+7NE9g
         P9UG4KP4Wkn+o3i52xoJSa4mp90sh1Cu0F0XUfRXvhkjojFuWq5usvUFwTVVZxktGnz4
         m9sdKKS5d9WX3FDpvhMfwERGRJm8Pc8S0w6keRmjiXlVF9SkrEQHLO6oHpBUtHiHzZTU
         s8pidw8/Xl2K9ntFRohkonecIOKkLuZCK8UKelRWP563YP6k8Qe0pLvW9rMEC6F1mIAb
         n1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvXnZafEYce3eQKqHnoNFRM0UdhTjWak2LbszgnoCDw=;
        b=MT2MTPY7OJaUSUl/pY1abi2zv962TH5VnWqXGw9Fz5rTbTYkLsQ/kF8wwEuKDEJmZ/
         r+GIJTroTJMeUAouLq2FadLXnPOP/h5N+sTWXLLmM3iCHb4Ew8IxfHGoyJCm1ScwK+q6
         u6frq7+Zgt6SHp/rfY/GBiG90Nt84l4NsoYK13FtPt9YzPvkS6z9f4/SiwMLRlspBDhv
         SmKKfJqkMdMpwteGFgtcFSPxfUGGk0UDS23PV4PEToqIv7SnmN8acAGClCXEgrcUQ8tc
         yyW3ddBy2bvHy1dsKhypsrhMrRRLdVzUw0MiQ6MuM9Y8d0dck2R0bbERqJcVRRMMWB0r
         nVSg==
X-Gm-Message-State: APjAAAUsxCq8QXStGan2xzWbemo0up3BRTRDAJup5AApHQxPaZxJP3Nm
        rBHTc+WSLts8jbEmasHvMi/AQA==
X-Google-Smtp-Source: APXvYqz/tfg0kvd52vftBvhMXj5rBnbW/SfA92OndwT53A//UUiNej0enl6FDxrI74BMaCHgrSeBmg==
X-Received: by 2002:adf:f108:: with SMTP id r8mr814863wro.221.1557400301093;
        Thu, 09 May 2019 04:11:41 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/15] clocksource/drivers/tcb_clksrc: Move Kconfig option
Date:   Thu,  9 May 2019 13:10:44 +0200
Message-Id: <20190509111048.11151-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Move the ATMEL_TCB_CLKSRC option to drivers/clocksource and make it silent
if COMPILE_TEST is not selected.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig |  7 +++++++
 drivers/misc/Kconfig        | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ede5d20299b9..eb1560187434 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -410,6 +410,13 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
+config ATMEL_TCB_CLKSRC
+	bool "Atmel TC Block timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF if OF
+	help
+	  Support for Timer Counter Blocks on Atmel SoCs.
+
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 268a01d3d6f3..c84033909395 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -59,20 +59,6 @@ config ATMEL_TCLIB
 	  blocks found on many Atmel processors.  This facilitates using
 	  these blocks by different drivers despite processor differences.
 
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ARCH_AT91
-	select TIMER_OF if OF
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
-- 
2.17.1

