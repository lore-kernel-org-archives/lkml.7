Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C73C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A900B216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDWCjm8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfFZOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45194 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfFZOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so3031228wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xbKA0smPXCZEOcgoyMlueKs3ww4dd6xR3XnPjEGM51E=;
        b=zDWCjm8qIMat15taR6Vgva5poRMzK3ZkCbvGxUmroGNdKg3fG8jFkC5OTYnhgGB0cV
         7gfXuGk2mdHPIi9YfgWprHBzEk8fnSIvmbGD6U+rm6hI0xPcaS418QoLkATOXXtiSn3g
         1jrUcKaV2SMJPepmaRV4uw6uG6t0qIcxCp/AnoIUAiENQZTdvcPYhL7aRKk0KM6iYm2a
         ztJvNYXEMqUvOYSRcqSfhE++ROphXTzb0b9IsemNRnx8sNJJvj3Kmd+jWcADb/Ne++uM
         sdTFoU8ywdZo65g/oU8pY0oZI1X3z2HHljfzI5wLbYksYHNBmNJ+qmFg7te8RQqUil9B
         yiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xbKA0smPXCZEOcgoyMlueKs3ww4dd6xR3XnPjEGM51E=;
        b=brnG7VkamXOvgjkK0gfF3BFRSKQHpbLU+jUXKjfeYpxSrq3ckC6Twc7NjbKnc5rBfa
         QSrF9WbIHJpG7ed+TfOFLWJuv+EJmieDVb2M2u6wM5PWnQMzq+tIeFNtsD1m5E6ByGG3
         Zgx2aXWf8quBtDUANYC3u16J3FuIeOe9PFfnpCshpd2kvEN8NeVy73wCMuGCrLA1Mc4E
         LTLaV3JANu/Fn7Vfqa4X+MlAeipb3RPtEm/j8gXPBdQZTlujsaBMu5gu9AQIExb3iiVs
         U9vfQxtewXQPcwos7DR3WTu8IkrCZ6icxauPbceQV1UunBfP9ZAIKBue5FYgBTw07/f9
         aLEw==
X-Gm-Message-State: APjAAAWd1DZzZHpG58NebzJebqEf5M6uzWN2JAYhmouMrwUT1DIqm8q+
        fC2qzyXERbDQiZmmrUUv65KDFA==
X-Google-Smtp-Source: APXvYqw8tAOsz2Ha3HSKk5iRGY83u02k2cjg8idywWaolu4Q1s+cYNpH3ITffjzIpcK3i+in17M6Mw==
X-Received: by 2002:adf:f7c8:: with SMTP id a8mr3928511wrq.246.1561560443835;
        Wed, 26 Jun 2019 07:47:23 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 07/25] clocksource/drivers/tegra: Reset hardware state on init
Date:   Wed, 26 Jun 2019 16:46:33 +0200
Message-Id: <20190626144651.16742-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Reset timer's hardware state to ensure that initially it is in a
predictable state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra20.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index acd68c77fa91..3e4f12aee8df 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -123,6 +123,9 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
+	writel(0, timer_of_base(to) + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
 
-- 
2.17.1

