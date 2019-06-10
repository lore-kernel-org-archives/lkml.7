Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647DC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF9320862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG0nn8Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfFJQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38762 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbfFJQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id g13so15410676edu.5;
        Mon, 10 Jun 2019 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeS1NZV9l6cKb9kBau6tKM3IexXNZlumeWCO8CC2qpE=;
        b=oG0nn8Khx/Etm7tZOkNf97tgp8ZYFbygkpMs6tBWr4hwbvLNO8iViNDU9acxyf5ikk
         +vkmDH7LQUaB2DqAFRQTELxmItYRnfGk+VHhm/Wr/WruyrIaFhKvjF4B2IKoyOUp6KbI
         qhatueJBoHMJvud6f4z3gl7N3EQmbbqNwGXtixcacQkOlcRrt8+/6wI5xtq0KH58zgsz
         E3p1SJ4OKPTflXnGEW8VMaAtH56x/KI0poFLbvlQCSGB8Qn4F/LUpz5TZzAqpCB/nKu6
         prpQl71jFagoQIPsyeBvstZbPtYLDG5+LP6vY+pbxdY7cOgtIAMpFSnXHJ2qT+Eya+hj
         xW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeS1NZV9l6cKb9kBau6tKM3IexXNZlumeWCO8CC2qpE=;
        b=p+TlsnOHST2swzE3nAhpLPzR0n6C9iHJ8uE0yci33XTrRYLrrcYu7LliWZ7+EoESC+
         jzKlEBQP7op18gKReSIjsQ9NCuFt27nSq8qpSvX+wcdbkzMydsnf8IvN69fQghm1bzgg
         GXgD7u6taDkJeL8hkhq1HUfr0MlL6u8FUx+QCxxSb9//13Q71H42pcKnxfhVOJEPRqRJ
         GiTkO8ErFMp7/gmbAuFIC7PL2QbGXR5LjuVXXNWMmw2IRhTQBRo8hlJ34jGy2THKn2ZC
         LklFhN9RkDmC7CHFfm6ySRxTUbhK2peW9W9bj6sPYz8BT0wtlYE+F6DtvTlVrHRXxb24
         IjHQ==
X-Gm-Message-State: APjAAAWFfur4z5RR9Tr4Cnefm71hGT9NhY3WJwgVQATsnm7NgJ/bY+EU
        1Bl+EJj12UdUtyIOKbbmZE4=
X-Google-Smtp-Source: APXvYqzW5FmOjsrmFKMH1f5FKBZgReQQBW1m46ckDr/kAUa4/FMiGEFaI0VsUNI8jhjJwPwr6HJruA==
X-Received: by 2002:a17:906:e9d3:: with SMTP id kb19mr59416694ejb.248.1560185305194;
        Mon, 10 Jun 2019 09:48:25 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] clocksource/drivers/tegra: Drop unneeded typecasting in one place
Date:   Mon, 10 Jun 2019 19:43:58 +0300
Message-Id: <20190610164400.11830-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610164400.11830-1-digetx@gmail.com>
References: <20190610164400.11830-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to cast void because kernel allows to do that without
a warning message from a compiler.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 646b3530c2d2..a7fa12488066 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -81,7 +81,7 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 
 static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
 	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-- 
2.21.0

