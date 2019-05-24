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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22092C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B8217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8SbDGA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390549AbfEXPgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:36:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42620 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbfEXPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id 188so9022869ljf.9;
        Fri, 24 May 2019 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETNkw8fFUbaK1GsH9w3HEMnksKyWiZUE22AHo7ajX+U=;
        b=M8SbDGA6wwIJlmM9rMvcJz72o9PQH/mhr5Xd3uiGXyBk3T8rXuFqMzmQd1cUm4L7uz
         O8g0B/IKq/fbBcj9Op6t9h+Tj3P/7f4l6s6Y/kykIekuFqFQtzCpZykezYT+pHepTeZ+
         bOheDeNGW9I5ivbvwtIYGTSNsIEoykhfE8kH3oCAVtF0m52WEiUVbZUimsetAKMRiu41
         Yn9IKtQeZbrDv1lK3RNuw/zCVfaCb9hAHINcnIo1j+Vl4QIor3zjvJqHUGR0w6t7dtT7
         KgESQJZpOY6LOO+cey8d9kQtcIcMGebmgB/gZHKp5P14yD7S0JOPGK5uKkC8FSHbvy8Z
         qWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETNkw8fFUbaK1GsH9w3HEMnksKyWiZUE22AHo7ajX+U=;
        b=RH4OTt3/intpEDRm7LZoGxTFXmcnVjyFz9kg/ERmQBX9w9hWj6rQ1gPUzYzpo9L2XO
         aPlbdXQUH+R7W6X28BDGhbRmxgwRgSeM3+xH7SkTSGU4v/V4MA8OvskdBg2uZ0xMGxOC
         V36nC71iRrGJDNKTwLdrf3qI9NBhB/7eL8nfx9cnMDEU46lVjVyBz7W1TewfeseXv/aq
         zJ4pnkGILkXqMP7sfRbKM9aLI19+gjYjPevTCUlf2REnZqK1xNKWmcadtXMcC6Cg2YuR
         7ORblUqmwPpyes1XlMS33SWmHnjVScPedppr0oM3wrTJweu9EdmZohVAC5O0mMsPvvWU
         ni1w==
X-Gm-Message-State: APjAAAXEfcJtqcZt8cWQeIubULOnP0GxBjMpGBF5m+gh+WLtfNv6Jwpn
        +6fyEUsgsCgcqgpSccrdZ+w=
X-Google-Smtp-Source: APXvYqwgYtRJtqCKzf13z18XN4hNoPCaa7YIbnQ6b4deXZBTzTVZx5mLqsRee1lTE/FHhnhA6jXSRg==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr27106796ljl.132.1558712129183;
        Fri, 24 May 2019 08:35:29 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 3/8] clocksource/drivers/tegra: Reset hardware state on init
Date:   Fri, 24 May 2019 18:32:48 +0300
Message-Id: <20190524153253.28564-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
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
index 57e7aa2b80a3..739f83fdb318 100644
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

