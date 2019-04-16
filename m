Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0424C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4B2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyF8uzFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfDPMqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:46:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36182 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDPMqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:46:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so25271551wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NMWyYBj57clQg9cPStM6YOP8/oChd8nV1DdtcAwo3Es=;
        b=hyF8uzFtE+0sfA3ztefzqUPe7dOLT6Vb2n6fZUkLwnp1OOMvvE4oZhae7+7rVTqpI2
         PVRLZJkfpKJEX3/50YQLCbFiB/+xRo1mY2IPMRzumyoXfCyd1GIJxSfFDwPUiiuWo2Xq
         5NWM3dx993VuTDeB7OanzLQ6WBwGaAVdFJf4682K3RD8TRKqv07FKgtPJcIF443k8HGj
         JxqUOGNu2X/N8RUK2F+2Bqz2rMNqWAkgj+dGu0f/ux15zEaXPPwk4IHVmaTRP2eYYPjL
         BBruiDzLOsl1zjmdsXMfMtSCU5t1T5nV1gmLdEXojDQib4gnqMf4JKCC+f/Qm8Q3mBNz
         KDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NMWyYBj57clQg9cPStM6YOP8/oChd8nV1DdtcAwo3Es=;
        b=NDxJnfEUYbLY1dml8aOSRd+se06z12tH2I81qSd2b80Kg3vS9H/zsOXNTM9X7zsBmi
         6coTHlST9M3A7Ubj6ulN45F805SdQt/iWsn7oShJCYEu4Cl76SzouqdQHrtq3/Nr4dqs
         RNoPk3HGoMQ3RhQPW9TXOydIhee/pR3MgNc9Ywdlj+mnwP7qfCSwTuhDqk7EVzpxHxQL
         urXkGIFbHxrHLDVqFrNItJfsRYb/Pho1VC6Pp/xoG6Bhf/oqn+B2bSMoB9NURH4Vt2Ml
         58Wj9fYDtZF/DdEodduW0tn3LTL9mnDxgnZVb0S/HEZ1Va2TE3lp3vaa+91naHDOwrE7
         q8zQ==
X-Gm-Message-State: APjAAAVoj9jnGOelJQ+Nd1ie6s2N9NACxXYwI8LszeMy0ls/jCGOnvR5
        7XSHyUPlDfcD/HtzIUGOCckw0I+xlic=
X-Google-Smtp-Source: APXvYqzdR33ZizpYD6gABsEpXDXVH8D1hITTCikBLwqDhGtKul4LkD+pFBDOzbbh7O1UQSW1YMp5HQ==
X-Received: by 2002:a7b:c92f:: with SMTP id h15mr26394157wml.115.1555418807377;
        Tue, 16 Apr 2019 05:46:47 -0700 (PDT)
Received: from mai.imgcgcw.net (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.gmail.com with ESMTPSA id p6sm42823732wrs.6.2019.04.16.05.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:46:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/4] clocksource/drivers/npcm: select TIMER_OF
Date:   Tue, 16 Apr 2019 14:46:37 +0200
Message-Id: <20190416124640.20058-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When this is disabled, we get a link failure:

drivers/clocksource/timer-npcm7xx.o: In function `npcm7xx_timer_init':
timer-npcm7xx.c:(.init.text+0xf): undefined reference to `timer_of_init'

Fixes: 1c00289ecd12 ("clocksource/drivers/npcm: Add NPCM7xx timer driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..4b3d143f0f8a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -145,6 +145,7 @@ config VT8500_TIMER
 config NPCM7XX_TIMER
 	bool "NPCM7xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
+	select TIMER_OF
 	select CLKSRC_MMIO
 	help
 	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
-- 
2.17.1

