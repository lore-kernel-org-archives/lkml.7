Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C15AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654B8216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjvzg9a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfFZOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55375 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfFZOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2401664wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nq1XbTkt1vTkv4HhT7D+cz8CUmDBD84eY2DPwK+R49I=;
        b=hjvzg9a9a0GenL06gSEprpW5hS+B+44Q/gkHp+AUPMnoLW1Bd05iBosXOcZ1GGfuxp
         WPTDCKLDCOMesFSuks/dgz8jra2jLk7kiD4Vqen8neczpsp4q6FrKNyFeEp0C+uTAe6j
         2Zi52MITdf4b6wUq2zeEwfI7dzy4PAlW9qpYa15Wi9tH5qfIyIukx8f2t/+fJhmAPMsM
         6wT5N8qDxTetD43SLjJFvuWQsIjygRQ/9UJw6v/8UKz8lWKvxNj4F3/h1nckZ4BKKSAj
         W3JEHme142is+z+CQzKpOiD25ypNIxDrQI5UPw5rjI3dNkDUzuK0SixBohvRtoeffTm8
         yYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nq1XbTkt1vTkv4HhT7D+cz8CUmDBD84eY2DPwK+R49I=;
        b=PttfiAluONSSHeIZOVvEwyCvedSPFkIah/junF4DHI+IPBVX+LCb2GnolEC1PC7/pb
         SW4tD1QLZ9hAiD2+SaNdPv6n6E1rUlO+8b4OaH1pwisfOCUPNmGzRRkCEHMgoD0m7pml
         TGGz5MZNw3lVdwnJ6gSGdmLOMYqhzOBfcCS1CL9LLhcT3zVwzHJxcK0x2aQHRvT2NtM9
         7G3ZniLgIKj8v31rcgks/RYnyEocPlLG+56DEZ4VJEuwmZyBpvmuqSPiqw+hPbyKCPYW
         olMfwyHoj6BrRDSWIh4s62HpkoB32KtDIzkJGdRu66U12dRCmI9nOB/J79AJq+gEyBNs
         kC9w==
X-Gm-Message-State: APjAAAWyu1gNmsls7zDgGcopVtF21pn50oXPQNpeTAMzGVcTAxzTvm6w
        oLsei1VgzunouAOFb9g80TCg/GfiqjI=
X-Google-Smtp-Source: APXvYqy/gyXrr5TSHewUeTIot1Go2roqfk1bh0jcUiD6g99PjFboR54K2WyI/H9X9RIhFOcEYYsI4w==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr2999871wmd.63.1561560470791;
        Wed, 26 Jun 2019 07:47:50 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 23/25] clocksource/drivers/tegra: Set up maximum-ticks limit properly
Date:   Wed, 26 Jun 2019 16:46:49 +0200
Message-Id: <20190626144651.16742-23-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Tegra's timer has 29 bits for the counter and for the "load" register
which sets counter to a load-value. The counter's value is lower than
the actual value by 1 because it starts to decrement after one tick,
hence the maximum number of ticks that hardware can handle equals to
29 bits + 1.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index a907e71065bd..e9635c25eef4 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -139,9 +139,17 @@ static int tegra_timer_setup(unsigned int cpu)
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
 
+	/*
+	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
+	 * fire after one tick if 0 is loaded and thus minimum number of
+	 * ticks is 1. In result both of the clocksource's tick limits are
+	 * higher than a minimum and maximum that hardware register can
+	 * take by 1, this is then taken into account by set_next_event
+	 * callback.
+	 */
 	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
 					1, /* min */
-					0x1fffffff); /* 29 bits */
+					0x1fffffff + 1); /* max 29 bits + 1 */
 
 	return 0;
 }
-- 
2.17.1

