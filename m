Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1ECC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F374E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h57Q8Ma7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfFZOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfFZOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so3066829wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NrTLjCEQJCPZZPBocCnR2gGFul+oEek89zztJZXdth0=;
        b=h57Q8Ma7QA2S62Pumxd4IWE4LAB/INnqTPU1uEJawVth6Pq50X9neJBTKuh6OyAZ7m
         oY3MP7K3tFa4H34C2hQwW9heisfx5XMpEMRhGyeR6xv9XEtdpCjzwnZkDMKjAMHr50s5
         WhjUdPc/yoUIEzD9s2ev5j9N+GANAzVh/MIDS4H2+R3BV6OCwYfyeoqwESRKPE6ZouHu
         r1qBBrTd9t1rw6QjMR0EzjZAQhCKmpfvg8D1oNWDXqOFAAj7mdPB0dxCkHsI6ihhN6Uv
         Fda5MbwzojrblJOZCWTkiT5quzNRRxJQx6RGumw/5Ji06gyUmki+3DefjcMtveHEDNf7
         p7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NrTLjCEQJCPZZPBocCnR2gGFul+oEek89zztJZXdth0=;
        b=pxIDq+4JkEf/FAXaTCMNBafAmVvFtF5ZFmzQEkJJAsaqDLHU0dthNjKxY1t6DtXgU6
         tJMAx9hYFWn2fc7EKMy4Hfw5g9OLVyIdjfo6PrNBSiPTJmJmppC1YLxlaOCcDWX7C986
         h3Y2RbccQmAQlhg8HBvIL5rItBPTeUgyg7iHwlipposxGCtLnEhAe6+GXIE6QuGX/OJP
         LvLev+VGx4s8gV0NeKQecOQ0H+dej82zNy2/KF3j2RTRTjNmzX1xAeyn1MXHVtXnzJLh
         q2eh59vlpXY9K4xdO1sew50nSr+A9Vm9NTJUyy0VvLpg3X1oqtOBxL5aHrRVAQeZPzNH
         OaQA==
X-Gm-Message-State: APjAAAVe+upoaVlrpDnI+Dgh8Sp0EJttrnp9V06eWlYcX7wNnxEbaoEN
        j1r6shV3DuqP5/qLeAxC5omCJw==
X-Google-Smtp-Source: APXvYqxGpQiv5E4WGjCIQKYH9Y+gRBsbnKqD8dw94pr4vFwmPC93zjhp1ZIbYHoWZw3keMJc9Bn4Yg==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr3803585wrt.111.1561560468935;
        Wed, 26 Jun 2019 07:47:48 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 22/25] clocksource/drivers/tegra: Cycles can't be 0
Date:   Wed, 26 Jun 2019 16:46:48 +0200
Message-Id: <20190626144651.16742-22-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Tegra's timer uses n+1 scheme for the counter, i.e. timer will fire after
one tick if 0 is loaded. The minimum and maximum numbers of oneshot ticks
are defined by clockevents_config_and_register(min, max) invocation and
the min value is set to 1 tick. Hence "cycles" value can't ever be 0,
unless it's a bug in clocksource core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 8e70f38f1898..a907e71065bd 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -56,9 +56,16 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN |
-		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-		       reg_base + TIMER_PTV);
+	/*
+	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
+	 * fire after one tick if 0 is loaded.
+	 *
+	 * The minimum and maximum numbers of oneshot ticks are defined
+	 * by clockevents_config_and_register(1, 0x1fffffff + 1) invocation
+	 * below in the code. Hence the cycles (ticks) can't be outside of
+	 * a range supportable by hardware.
+	 */
+	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
 
 	return 0;
 }
-- 
2.17.1

