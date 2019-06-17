Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6727208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KN3JUQFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfFQT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:29:59 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38309 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfFQT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:29:57 -0400
Received: by mail-wr1-f47.google.com with SMTP id d18so11275614wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6SeONynbSMb/LpB25tjr9lmR6DQm+1ofOPgJs9DwU6s=;
        b=KN3JUQFoVuq9g3d+sb2f+QypVLDr1ZifAcfACFXChB6X/9q8jBPhRVDdyiExH1m3mV
         4OoN0VKm4Q/3iAeE0umwZfvRBP6JOtgaccSFJy6PXjkL3NYW9kywWAvrdlnw8csAHSDM
         XsO58I/TyjFdNXZkQyYogh8K3AWIQv8GoCMsT9p4A+0mDVKDoAX3SzG/mivs6LQy02lc
         kVIsRTxdYdTFHgFtzThiogIeEx2DttZ40TYOCUDkHUs1FP95hAiEfSnGL6P5J6qAe00n
         2zQtUDESDqN1ma5jBS+d98sBvFN3jVzNS5e956lpY2eJWb6wzTFgbZ/VIAnRgTLOkNeR
         neMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6SeONynbSMb/LpB25tjr9lmR6DQm+1ofOPgJs9DwU6s=;
        b=cOlUZfAfPO1kWD3XTJ7e4ZCcZscviGMiWKapbU/3SJInEivgPq/28WRNjUF0YDDJ2W
         BQnpi+ZTL5sjvmd57tYRrOQVbeghVXFznYx8cpaVDCO2muiQ2aagLafLF0zwNTPx2Hqk
         vu+LJserM8XmpdRrCX6fJvKO9VBrzDgoWnH2LF+KJtHEphIe64LIhbB3upzNXESKOKVm
         dLtbisIAvbW7iIv2F94w/ikUEhxGlF431E7elbQQvnFMnYMebwNrHkvsDpcJ0JmLIwPA
         LN1WOLfYoAzRjS9FwLmLrJ3GBe2HhTGYPh8Jniu1Hc7IyFOJb4aK2zQR/3j8YVlBVln6
         k27A==
X-Gm-Message-State: APjAAAWQTLmQCELXujg+u3C6CBvYMBJ5iEZ2dRvJgr0sIWlHQSSti1qZ
        mcqk4sWJJm9rWKSYh72c/2WQ5w==
X-Google-Smtp-Source: APXvYqxBW7xGdL5vy7Z5G05hC4Mb55jO/UL6X2jStGLj9tRh7aNLnmpN/x7su76+0qlemQjt8f9ntQ==
X-Received: by 2002:adf:e705:: with SMTP id c5mr48983855wrm.270.1560799795842;
        Mon, 17 Jun 2019 12:29:55 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (cust-west-pareq2-46-193-13-130.wb.wifirst.net. [46.193.13.130])
        by smtp.googlemail.com with ESMTPSA id u18sm9412034wrr.11.2019.06.17.12.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 12:29:55 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/3] arch: riscv: add config option for building SiFive's SoC resource
Date:   Mon, 17 Jun 2019 21:29:48 +0200
Message-Id: <1560799790-20287-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
References: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a config option for building SiFive SoC specific resources
e.g. SiFive device tree, platform drivers...

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/Kconfig                  | 2 ++
 arch/riscv/Kconfig.socs             | 8 ++++++++
 arch/riscv/boot/dts/sifive/Makefile | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/Kconfig.socs

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ee32c66e1af3..eace5857c9e9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -94,6 +94,8 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT
 	default 2
 
+source "arch/riscv/Kconfig.socs"
+
 menu "Platform type"
 
 choice
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
new file mode 100644
index 000000000000..60dae1b5f276
--- /dev/null
+++ b/arch/riscv/Kconfig.socs
@@ -0,0 +1,8 @@
+menu "SoC selection"
+
+config SOC_SIFIVE
+       bool "SiFive SoCs"
+       help
+         This enables support for SiFive SoC platform hardware.
+
+endmenu
diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
index baaeef9efdcb..6d6189e6e4af 100644
--- a/arch/riscv/boot/dts/sifive/Makefile
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-y += hifive-unleashed-a00.dtb
+dtb-$(CONFIG_SOC_SIFIVE) += hifive-unleashed-a00.dtb
-- 
2.7.4

