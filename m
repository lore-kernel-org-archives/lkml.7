Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163DC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441020C01
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCBo8b5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEEQZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:25:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfEEQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so9068578lja.8;
        Sun, 05 May 2019 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyUdd7HrC5y8waWKk3rsytQ58W6hY1rOklTf7qr80Ss=;
        b=UCBo8b5Kwr9Gc/6O1fuWHNgYRS+5wDY07hS63Ww/AXqaPoMlszvPymYiIBi+hpClIt
         arCfRKGCY8Wi0WCmtrDTr92u3R0OyfSL0OUcs6BS7uOOmifN9QmSRtsW6AfG+PGgV5yj
         8cnq2JaHecyMTdWVlfgZoiEKiZLVvFD8pLx0WypYLAyWC1bIMbV6N7ClTwk5pws2jrqU
         v7VqFDDECw+fmwDzj5O2fjmYOyHi7DpjDfJDhmK2L05qm+XYFWTY/fl+4sbfh4BGxTEB
         T2jd3iDqojSHGQKMrVXx4Okft9vaFlCtJ9lqqFIP30lZLTzOHYMIzjG249mit6DiW1/6
         4unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyUdd7HrC5y8waWKk3rsytQ58W6hY1rOklTf7qr80Ss=;
        b=YFcbNvpFjM2jGtdpMn9KKDHkhmOS6SF5DCdpuc13J671bqgSvfEAxgjdSNZ0ld9cbR
         qr1K3G+CBDKlJ2YjGlwyyBA85UN9TFpjn6dYb1y/UkecpleFMg7mNIPIyba3wCz4IyBD
         2e7BkAare9rL2RBTTOc73xbJWVbpRlQx0YuIMujfT/0hSFwUTTu4GIjHyt95cgO4JTEJ
         2TmZJhcadxmgC83Za0aG8tAftnhKhlPV2Ph8Pp4xpe3IfnCCc2HAAsIiOS0yMBopYHEN
         TvVOZMg883uCPS4N25aiJ3Z5jDxANUIGsgSsnydMhpJquTSUjYffOOhoJG5YTNafeUA3
         bj6Q==
X-Gm-Message-State: APjAAAX4bDk3rW/bmHFwwB2cszAuo3VcLHm5eTmoqnsOjGETYtRra4Ad
        5pCiSRltooaxt3CQQHLn2tc=
X-Google-Smtp-Source: APXvYqx8xQxdH7ASIRU5U2MpdvZfWv/HHfTehI51Dpom1W6PVz9eizPm7oMhKbj0IrCNzgg50dXupA==
X-Received: by 2002:a2e:9049:: with SMTP id n9mr471574ljg.168.1557073517451;
        Sun, 05 May 2019 09:25:17 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] clocksource/drivers/tegra: Reset hardware state on init
Date:   Sun,  5 May 2019 19:24:32 +0300
Message-Id: <20190505162436.23125-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505162436.23125-1-digetx@gmail.com>
References: <20190505162436.23125-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset timer's hardware state to ensure that initially it is in a
predictable state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 42a19a4019a9..b7d1e6221348 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -132,6 +132,9 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
+	writel(0, timer_of_base(to) + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
 
-- 
2.21.0

