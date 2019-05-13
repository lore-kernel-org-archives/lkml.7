Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A60C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58D221019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaMLGxq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfEMKaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfEMKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so14588532wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7Wy/UoR346yun6rGdrn0w0Sk7Zt+3JLoV24BHUfklw=;
        b=KaMLGxq5Wb940wNjeO7BJOduBqFwHX0vgpSfCZ+93hfjbyg7qWJg271Pn/VKXyd39w
         bQCBsUYg1VvXJegV31qG8hLePpv0czgoGzUEMs4phtmeD/zmUC1nfEQJC8ogw28eG2bk
         +An7yw8256pDJcinE/m0XLNIcmUeUAE4y2m9c4gUA0k5QBEPJpb+AkdYJlChJ+5gw1t3
         tSRK6T23ZWmmujbo1eRKJF1zxUdU34dcaU/iPR3nEkUY5wwIkPRxWuJTrBBYsQt6fL3P
         gSTqWb24e4RuKL5Jy3Dqu9SzUr4XxOABGUldg3IeYOApTUZlwsQTBHDdGq6GsTBGut5c
         4IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7Wy/UoR346yun6rGdrn0w0Sk7Zt+3JLoV24BHUfklw=;
        b=NcpAtH/VZizNdO8a7DFvFEvnwlSa3C70cS/jXBfiTn/U0drxwA18U6rJbb9jMDMrVq
         5xRLSnZ8raN8vF/fTlnd83X8vxgjfHtTJGx3pItWJKatTSAP18Hxe8Uj6/wzEUogmidk
         xVn5diRwfMpkJjwormgZT1zumsJVoG8/HodDzO6+wyrMb9GacadJDdsHJbtIXmz770z8
         PWa3hTp+MxVJt937WjvQnUTeatjXBQ41CqPT9y73gwttv5hahtzbOw1pVkBM3DvoPArk
         WbCUnwTfYL4YDahPyrURcAGkX/KbhVmEsrmTT30ZZlRbENhQoh/g80KDm99LTEV/e/Gx
         D0dg==
X-Gm-Message-State: APjAAAUdIqXNF8q6mAAdQwCY0XRzoIjCvaSePquo9GPrUz9HbnG7MK9h
        f1VZxvqBDdKee1yAskBv3rLO2g==
X-Google-Smtp-Source: APXvYqzaKak2EGUlqbwSxfk+3WjuJ5CdCEmkmiyotWJ1fu298O3yTyiEct5iALI9pG8fbfhd906uWg==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr16196807wrx.205.1557743407366;
        Mon, 13 May 2019 03:30:07 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] genirq/timings: Optimize the period detection speed
Date:   Mon, 13 May 2019 12:29:47 +0200
Message-Id: <20190513102953.16424-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a minimal period and if there is a period which is a
multiple of it but lesser than the max period then it will be detected
before and the minimal period will be never reached.

 1 2 1 2 1 2 1 2 1 2 1 2
 <-----> <-----> <----->
 <-> <-> <-> <-> <-> <->

In our case, the minimum period is 2 and the maximum period is 5. That
means all repeating pattern of 2 will be detected as repeating pattern
of 4, it is pointless to go up to 2 when searching for the period as it
will always fail.

Remove one loop iteration by increasing the minimal period to 3.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 250bb00ccd85..06bde5253a7d 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -261,7 +261,7 @@ void irq_timings_disable(void)
 #define EMA_ALPHA_VAL		64
 #define EMA_ALPHA_SHIFT		7
 
-#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MIN	3
 #define PREDICTION_PERIOD_MAX	5
 #define PREDICTION_FACTOR	4
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
-- 
2.17.1

