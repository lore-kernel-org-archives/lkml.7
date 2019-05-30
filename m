Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E30C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E099262FD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH3mYn0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfE3XRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:17:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42149 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfE3XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:17:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id g24so1902287eds.9;
        Thu, 30 May 2019 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8OuX4xShfNASS1kU8dLb0K1y+qLHuVxh22K4Er6Vwk0=;
        b=KH3mYn0gHZuJL8QRMPVXovnbxLJCVRy8MUXPWOmrRKKwPPnnhowfJE5JGNGY/iyBal
         HCwmGbgbTOI8NEFztLRQdkL3RnniYglTXoKno2LF9LeBCaxSx/wP0ZoG0itMVKKRDPmk
         5pdXTjEG+Ucq5Wzt3Anr27481Qk9gC/LYcwaLu5h3IrR9C1kv21ItqVs57zDvw9spHhd
         sQsxehz03mTRPnjdN3jd1OKt56jNexDDmSylD2gbleX7twbJPKt6GjTANvPBn/RX2u2d
         ane8D7xR6YgEmbuocDLkG8Zp7ySp6TgPNrq5Q06BaxkpW+61eS1LrzQSW8QCqPoGzyc7
         HtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8OuX4xShfNASS1kU8dLb0K1y+qLHuVxh22K4Er6Vwk0=;
        b=o7uhhfYS0ByDPw4eQnqAHf/23DibfHb7G8vtWIzkc6Jwh2k2Fl8yhhcB6DHtwErGBm
         sDkc4A6ty9RpSIMQ/fiv8sqsk9beiR2GXWzz9mnlAKhDIHqRa81rumv+Ki6e0AE90u5B
         un/ITyn6yObvbEDf1Fmep6LK+UC7/aGUKmop47YbLBtQmeddBaFAzYtOW7btuUW+UQsr
         2ZeHGm6/BE4MBbiziUhNz3ikU95EPuJo/jCwJlvZUQHpTdvDmaiVpkRlP3QORl5HPIKm
         ALQvAXWNkDI+bHaeTxzpqEWpUcHk3sor3X9mvjHF/PL3zwpeX/abe6vlS/L8d6myM3IP
         QolQ==
X-Gm-Message-State: APjAAAVM/ZtQx9Kdcyksd4FSxLg+TRMgXb8I3QjzLv1+wfFZjgQHl4/w
        4M9gOC1bhnoKQKiZr7/mlR/mxrpm
X-Google-Smtp-Source: APXvYqyMC4qGSTVgdOQhe33bp8TEa1zZ1dv2k4qCdG/f2Fg+AjPD+O9YIaOKNrbTeHwIwRdh7GrO+Q==
X-Received: by 2002:a50:e048:: with SMTP id g8mr7783570edl.26.1559258236714;
        Thu, 30 May 2019 16:17:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f3sm656568ejo.90.2019.05.30.16.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:17:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM BMIPS MIPS
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE)
Subject: [PATCH] irqchip/bcm7038-l1: Fix build on ARM/ARM64
Date:   Thu, 30 May 2019 16:16:58 -0700
Message-Id: <20190530231658.23273-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses cpu_logical_map[] which is defined under
arch/{arm,arm64}/include/asm/smp_plat.h.

Fixes: 5f7f0317ed28 ("IRQCHIP: Add new driver for BCM7038-style level 1 interrupt controllers")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 0acebac1920b..970857a32508 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -30,6 +30,9 @@
 #include <linux/types.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+#endif
 
 #define IRQS_PER_WORD		32
 #define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
-- 
2.17.1

