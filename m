Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE22D2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrKRJ01F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEILMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:12:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43395 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfEILLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so2440129wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QCYNgLeacHF6Po+7GOvr1beHIPnLrcjXHBlwdHrGCU0=;
        b=xrKRJ01FjexwcW6Amk2UUkgupUslrHuPLDtpflcQVkX5Ui7ZAjWgKS3dqp58CehLKT
         m7U0HLJL81DLGNl6Nx8C/Ze2rWrVrZwAO8aM27Roy/Ir2eESs+RkNsf/uY6dyUXS6US2
         e/efAcycx/5aKwBol9pNrIh/G34Q/aw2VxmiGEk2XrAfc/dMaUXXsVbit8T/LT8KlTzB
         SKj1qIdFVKRAKmp4X13yEt/cAu12cSOGL6sjJjgG3NeQqmd9HoVWW9ItPzkBRyBTx2FF
         +WQJjZK3DHfwhBM/4FxygB9SdEVA7e38iRLAhYmZSg67u5I1ZWtN994Oppt1+kZR4FlQ
         4fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QCYNgLeacHF6Po+7GOvr1beHIPnLrcjXHBlwdHrGCU0=;
        b=m16gNsVTN9PfUS3mwxLeO49zUPHdB8y34L0QyP33nXcr/JsD9kgrenkVcIgzM1KS9h
         nfdyVGiXmMXFLr73zBE1VlPgQzaaZrC1x2Ti9LmUmvZC9tnySZzUcXWhqvVNfiRPFchN
         DcotpCfmGFskXntFnlI0pRm+lVwrVsKUd77uRHFP5SqBaR1BA4qKA27u+coBH2gOMRdS
         EKzRpOCbgDGrZ7Gi4BS7IcCZkRwZJNBr//4Lfu6WRo/J/M+YhiHtS7jxQ95fiQURfr0X
         ii+3/FNZl5yXpMGyugQ157GiiKMFGEOrSxPyJqDDxVizt9ObelVh2/iLxx8YiBtyvjxz
         nq2g==
X-Gm-Message-State: APjAAAUaGkrHZJTLqL3qR4FEeh12Nh9A1czuXaIOa2QuxVI4/mDDYXro
        yMk9NEOzBC/W5C6vqkaxi/Tobg==
X-Google-Smtp-Source: APXvYqzMGoZEXQojTRjD72YL1yIFVm7J1W+VHiI9SvPm03np6VnCkUTzFJcvv1XUeh0PfNamyp1clg==
X-Received: by 2002:a5d:6ad2:: with SMTP id u18mr2489123wrw.199.1557400299916;
        Thu, 09 May 2019 04:11:39 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM
        SUB-ARCHITECTURES)
Subject: [PATCH 10/15] ARM: at91: Implement clocksource selection
Date:   Thu,  9 May 2019 13:10:43 +0200
Message-Id: <20190509111048.11151-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow selecting and unselecting the PIT clocksource driver so it doesn't
have to be compiled when unused.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 903f23c309df..da1d97a06c53 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -107,6 +107,29 @@ config SOC_AT91SAM9
 	    AT91SAM9X35
 	    AT91SAM9XE
 
+comment "Clocksource driver selection"
+
+config ATMEL_CLOCKSOURCE_PIT
+	bool "Periodic Interval Timer (PIT) support"
+	depends on SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_PIT
+	help
+	  Select this to get a clocksource based on the Atmel Periodic Interval
+	  Timer. It has a relatively low resolution and the TC Block clocksource
+	  should be preferred.
+
+config ATMEL_CLOCKSOURCE_TCB
+	bool "Timer Counter Blocks (TCB) support"
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	select ATMEL_TCB_CLKSRC
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config HAVE_AT91_UTMI
 	bool
 
-- 
2.17.1

