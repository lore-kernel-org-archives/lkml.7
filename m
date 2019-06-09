Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B4C468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8DC20684
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2uEJvbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfFIT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:28:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39768 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfFIT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:28:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so5118448lfo.6;
        Sun, 09 Jun 2019 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/IlH8/FqEF5B/kMufxrFYWiQGlg7YiEsCppmIdJ87U=;
        b=t2uEJvbFG0yv7Kbfebe+VYLpRFpP7WhMkQvzgaKfUhZRhrp09o+lvbkEaWeKxjYbJJ
         XIxJ+J//M3sv0Ci2QIPoOlXq4viyHjqDJk7q18N3qW3zGeZFfYWWRvasRpZB7g5HvPLq
         d+uDJQynbPuZNDX8Hcxv4limyW711qq+2ARkhlVDcJP20G1J3VDmiXR+SbpluepaWBSd
         FDmTfjhi4lfF/B1zrWvoD8UweIoyii0fc+K8e+mdZqi6oeVp0Vcgve55twv05gQO9QQW
         sjn8mvFP5DAZZVNdJdOEuyKiD/L51vYj+zO0r1vHENQzhSx6irAkuZUxigX8gJfJQLbb
         E0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/IlH8/FqEF5B/kMufxrFYWiQGlg7YiEsCppmIdJ87U=;
        b=s6vzrvZPWnoi2mWNiw/p6B8Jj+UTcQevoGfrpa1Mo9QS5Oo1plcn/gl/8gTwiF8kpp
         XIgqZel7UINfh6CW7Yjh980II5G2ibdMNmX2lWTx+I3BTWjWBZ/dis2pfRQCYQB3asAk
         +WYeCGkyGi6NCMhsJxMown0oMzM/yWSQs6QhOi3mPe3dvFgNDZKPuJGc23JYdMKyQ2Fi
         gcXRBva3a5CEpaaLfoutXgK0qed3V7k8XzAqpjoEceg9EQ+m+2pGm4LofZLGr7Wo3EDo
         w8rx7ZaR9lXStPb9SBQujkmy9BXSGGQe6ZfpTbnQkuB0rYJ+ieitZhhSykPIv98FKCCs
         OF9A==
X-Gm-Message-State: APjAAAUgv0I3R8HGRsh9DfYqFXiuZkGJ8371LhlYV2T31HlU/hqzkoET
        9th0QvWi3rbGEQuM158ZFLJimMdI
X-Google-Smtp-Source: APXvYqw9JA//J7ASJAHOmn9Ac41mbnv1POI+bCKN1Qg8Z4oRFqpLoaBxrqyQ9EZGEwdwC1kb6TiUAw==
X-Received: by 2002:a19:c383:: with SMTP id t125mr25896405lff.89.1560108533776;
        Sun, 09 Jun 2019 12:28:53 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id e26sm1531685ljl.33.2019.06.09.12.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:28:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] clocksource/drivers/tegra: Set and use timer's period
Date:   Sun,  9 Jun 2019 22:27:29 +0300
Message-Id: <20190609192730.29459-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609192730.29459-1-digetx@gmail.com>
References: <20190609192730.29459-1-digetx@gmail.com>
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
index 6da169de47f9..089c2f51ed40 100644
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

