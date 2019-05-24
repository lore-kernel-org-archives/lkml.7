Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6EBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0D20815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUHxs0Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbfEXPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:35:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389914AbfEXPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so9050903ljj.5;
        Fri, 24 May 2019 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yr9SuSgJcQmXUlZFQ7lwiMnKS2BHo2uA+j1WQjZheiI=;
        b=AUHxs0Ag5lvuWYV6wXlSUWoM94eFyrXLuLnlZvzZZET0r2x34qIUfH86KUeXmz8KxP
         6ojeTF+EtC9J9CabTRxki6pl6l3z9wT+RluRahLMmeiTOryq2xjj8lSOXR1AjWaJzIqT
         HDvMEcuMTUnRf+zWghMkEPYeAxAXd+TO0jHewbjKHEPLW1s7w5kszc6Jz8VycMbysNYK
         UE/WWBNKnrO6kjMi1edXBWq8C+9SkVwuu2TVoHUb60jSvXU5oa0YCOY/5SFaCz6kv6Lp
         ukE1LaGlqq1y293RQbKJOgIrjjOCHbty8AB9yx3/CmgMH3zs8HMTa5katKqTtcIulgN4
         nzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yr9SuSgJcQmXUlZFQ7lwiMnKS2BHo2uA+j1WQjZheiI=;
        b=Achf2/9h/88a1Wy61XjiO1sjTOfUAf3pOxjY/Z/nczQCEDdHCG0NUdYJvsrf934h8t
         gRzL0dsKkDb07txbCBhhTD4TcTckhmNc/+2PpOQcinXj4kKsgtnHzqtCEOFuay6d4wzD
         d6DOXu2XxZkIdX/y/dd8+fmfcTuq7H+u+pYFV+ts2FsXSHdE30itTpJ4igg3Az4JpZcx
         I8ezepUJKQh900nnEAcmc9dYQ/fV2+p86pao3sPdO4S7KG2AMZKAOm7XcQx6YH4EThMm
         rSYzYTHxA0bGCpWON/tWCHuzd9QPQcxghwwK2FlpTyXTNgdSm7c3w5UwbVAFrRfCqQsk
         Sjzg==
X-Gm-Message-State: APjAAAXKiqAYL/C8teii728JAPSL3tATQGa4hJ1RhKJeZyumVWsS1Ir5
        6Mb02x0e35bGzmMMvk5J8Kc=
X-Google-Smtp-Source: APXvYqwX4WNp4CHGhfigOtxAt+kAz4V4VxI0eGau/GCv2afdpCjT/W9Y2CCVCN9RhxrJQN7tQfByWg==
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr25451712ljj.100.1558712131285;
        Fri, 24 May 2019 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 5/8] clocksource/drivers/tegra: Release all IRQ's on request_irq() error
Date:   Fri, 24 May 2019 18:32:50 +0300
Message-Id: <20190524153253.28564-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release all requested IRQ's on the request error to properly clean up
allocated resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 55e9b3e1fbeb..18b81d814b3b 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -293,7 +293,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -303,7 +303,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		if (ret) {
 			pr_err("%s: cannot setup irq %d for CPU%d\n",
 				__func__, cpu_to->clkevt.irq, cpu);
-			ret = -EINVAL;
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+			cpu_to->clkevt.irq = 0;
 			goto out_irq;
 		}
 	}
-- 
2.21.0

