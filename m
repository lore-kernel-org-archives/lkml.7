Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D1C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C2021921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x1issdWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGVNR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:17:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfGVNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:17:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so39436313wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1ffjQ0IDz3Rx/A0gmq8SxV+cunonTZVAynZexDe78o=;
        b=x1issdWAgb0eS09Lxw7xPwhpwTU/39XeACBh9kB60ut2VxtDWkMyag4EgQnTlwUfcf
         yMqzIL8posvumO6ojHZU+KQZKHkPAw0TxUCc1gmsUz2RVLABK2P9nilaNmQFpxpXZe4R
         558gUEn1aEzsxJgffzJ00EpOjdSOUZtdK4jdgB7FxC7chGee4Ja/xYIG8jJQfLPynNzN
         xInD69jezWLr0edoE1fOOGAGfi4KPZlfm9BWTJ+GRtXqjwwKBtLZI8NDotGACdm1JFnT
         0Kb4dQWEo7m/0EG6jO5yAXsTFfNWyy6543RHwZpFOkLoye+XrXDF09gecVRHlC29kGJU
         nFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ffjQ0IDz3Rx/A0gmq8SxV+cunonTZVAynZexDe78o=;
        b=VsAkE5jf82ySipUaUhSRY8qd021Lno9QjqgA8+OJmLNUIcq26q3l8/9EQ95SYfrB0v
         VMf4FwwOYTqwIMUJ/0zG/kniig9XrId5oMhyrbmWEasidnnDNq/lSz0FMwIvr8wfVCgM
         KDWngdie3I11SGie0Od3w/drCGFJbKEqlQ4zAj8896usP9knOPr7lFZeeH5gJDPEpefV
         JdCrSGaI0E8Al/wsbTewT84EOhy8+LeKb/NxyITrln8CgnAsMQQSNvhz4Os/IZRAqeGo
         4/mbVH17kqFARtDIiQxYKbT+WPhMNZ1nk1nzRGIQ3ZcWqsnXl1zpMfV5mAvwg9Po7eRn
         p8rw==
X-Gm-Message-State: APjAAAVtPgckOO7lUcaauYibzMf2EvU7GwTqsHWL9TbMSHxWPyN/825i
        sjEEYlsLtzb+2GVWmiarRIM=
X-Google-Smtp-Source: APXvYqxAM4HVkzwLrfr/Q9QNR2M395lkxfoX//pzPMx9anNZm+rzLlLqHPhKZOS4R2VQWLj7Nv8Zsg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr76325444wrt.84.1563801472845;
        Mon, 22 Jul 2019 06:17:52 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 01/10] ARM: davinci: enable the clocksource driver for DT mode
Date:   Mon, 22 Jul 2019 15:17:39 +0200
Message-Id: <20190722131748.30319-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722131748.30319-1-brgl@bgdev.pl>
References: <20190722131748.30319-1-brgl@bgdev.pl>
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
index 33b00579beff..92ff58be1a43 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -583,6 +583,7 @@ config ARCH_DAVINCI
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
2.21.0

