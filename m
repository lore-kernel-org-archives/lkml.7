Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0654C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Tq4VqcHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCRMLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37268 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCRMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3991902wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLg3L6grnAGmFYQazg7azf3p/k2fOQDJEXr143gP9xI=;
        b=Tq4VqcHQYH2yJ/RnjuEvkQ1xd1BcnqsNAglnJlItTA2HC6JIi8z0fu+DDlilm86mfo
         qBSj9xIEFxYJCHPsyMipzxUPcng20RfC4b0LSOGxzsbon/10v4jPcCH/2oyyVEoDddde
         Lyxg7Mvaelf+1a7AxK173uAOgHx3uuuM03Dsy5Q9G6QE5akEHFBTIPbP1ESYfuS4ZAdf
         5msSuZNgzpvOHCx4FwvnWiLHs/FFMgiUrRmx8y5+LrbuOqJarmPLsJC+Kfnf+HJe58yH
         PCq58uKG0Yu8lRXam0vOgSin4EtW0wLlTAJtIo8hTmNjsF5g8HIJgjmHmhvK4va/dZy9
         gtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLg3L6grnAGmFYQazg7azf3p/k2fOQDJEXr143gP9xI=;
        b=aVjjmmhagpXghE7ssERgSKKd7dkHRRyk2J/MsBl5Y2UMDjF6zmwb1dIevxN3wap42M
         O8tyZIpSmySGmF1ATJeN91t87vRbMyE9hmunKo6aUnqCyezGkhMZTOkp00m05/UjToDX
         /O6H4V9mrJWhqnOsqaNJiAHExSBO1a/F8d4XUdHxU4dAUb0jZU3NNO/vCHSBK/EMCMxh
         QY6Ba9K5cZAEoN/v1crjMLRVCz/Cunv2kADp2kZYeijsQjxOVvRPeMctX7PndG0r+rmC
         Eql/ZFvwulGmKPXA7rQly4yJ9k5SuiiMApRz6IJh3Rbd72KPA52tXnVRv2+Oy+jLwOcj
         u07w==
X-Gm-Message-State: APjAAAUBKzHvlGuwL1TDjhHguFwul7vpXnuhx9d/GCW8z7WRIbwThg0S
        FuubJBmQZZY/XCkIxZ2QMKfDEw==
X-Google-Smtp-Source: APXvYqyCYmMm3aViu7XD8Ig/s1tPFFZLmRq13e6EKNcCU8G2Afhso/zmyB++lHcfS6EJiCcOw5fuXw==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr10744612wmj.110.1552911074203;
        Mon, 18 Mar 2019 05:11:14 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 02/11] ARM: davinci: enable the clocksource driver for DT mode
Date:   Mon, 18 Mar 2019 13:10:51 +0100
Message-Id: <20190318121100.28132-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318121100.28132-1-brgl@bgdev.pl>
References: <20190318121100.28132-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch all davinci boards supporting device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer for ARCH_DAVINCI.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 054ead960f98..f893798e13d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -588,6 +588,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select COMMON_CLK
 	select CPU_ARM926T
+	select DAVINCI_TIMER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 5a6de5368ab0..740410a3bb6a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -398,17 +398,3 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-static int __init of_davinci_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	davinci_timer_init(clk);
-
-	return 0;
-}
-TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.20.1

