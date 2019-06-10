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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A84C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65E206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNaUhZ4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfFJQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43336 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfFJQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so15396293edb.10;
        Mon, 10 Jun 2019 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNaE+JyTMbe3vWyJjoPXuE9tx9E7XgUahA0r4EQDpWk=;
        b=UNaUhZ4J26e1YN0E5HgpidahdbTAdrZZAE74lVVCvMFAkthT7xS4FQjXqjcWYxowzV
         YFn4c2Yl06QJFUIdlkRMsOFqI9l4bDJwRVc5vB+WS9L1XPONYnbQG0ifRADi7tcsIlVD
         Jl+YF0lzUxt1hG8JFipYQ23QNrIXzAfDQI7KWjJCZeZHVeWpHyiYMNTUrdhE7K6y8U5/
         MaBwZsm/I2iYHWJaZWjAO3rxvJ28C4NkUrdAfG3gaOPuZrA4KIOOMffaBiRz9iy59ZeY
         XMNsUAAG+DsTkjxvX/t/bGMwxeNEnhLIe1oMh7XQVj0pqULa22CpbYQEFF/IX4GV19rW
         5nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNaE+JyTMbe3vWyJjoPXuE9tx9E7XgUahA0r4EQDpWk=;
        b=CZCbLG11/bIuQ5sk3hfBSMt/W1EBU9+euiCEq4NAqbHofYlUZe56lOL9DCvlaKANkk
         2ie1FHwva551/68p0KQ6wrHn4UXSjdd1gPha1kuG4Wjfff83EUnzk1I6Q0CqijbnnPIU
         iVZP8Y2MClFTNQWGtoESr41z+Cwfb2GU4alP/hcg2MCZHaLFlMg1GXpI+Srr3Zmnpbl6
         gf+TpKitCN8KXJKmB6+VFYO7QqWfpIcRADB3Qj7J5VX2Fn8sG3mx3bua1pfBy1c6JPOF
         CL4YmzJGw1ePn+pqYvOBMSltN04hj5jLHk97tgA0Cb9Ky39h6+v7HyYqGFSKs/jlbnna
         p5GA==
X-Gm-Message-State: APjAAAX6PfcKxaRWS3BWl+dp3P6O3q+OlM6VN5P9er+8FDnG6VdBiV6d
        hD9oIsxyjzDNQ5WJCromjcbU+WbC
X-Google-Smtp-Source: APXvYqzrc8u6mQ+GuOk68KhLmwetYvKai4YQWu7MPs8Supql0qozPF1RQWyfBAR4OVbjVtjW2cuvig==
X-Received: by 2002:a17:906:d154:: with SMTP id br20mr5543813ejb.76.1560185304079;
        Mon, 10 Jun 2019 09:48:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] clocksource/drivers/tegra: Set and use timer's period
Date:   Mon, 10 Jun 2019 19:43:57 +0300
Message-Id: <20190610164400.11830-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610164400.11830-1-digetx@gmail.com>
References: <20190610164400.11830-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_clk structure has a period field that is set up initially by
timer_of_clk_init(), that period value need to be adjusted for a case of
TIMER1-9 that are running at a fixed rate that doesn't match the clock's
rate. Note that the period value is currently used only by some of the
clocksource drivers internally and hence this is just a minor cleanup
change that doesn't fix anything.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 810b4e7435cf..646b3530c2d2 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+	unsigned long period = timer_of_period(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
-		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
 		       reg_base + TIMER_PTV);
 
 	return 0;
@@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		cpu_to->clkevt.rating = rating;
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->of_clk.period = DIV_ROUND_UP(rate, HZ);
 		cpu_to->of_clk.rate = rate;
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
-- 
2.21.0

