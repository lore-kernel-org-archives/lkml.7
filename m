Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06080205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6HgvJ8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFZOtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:49:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55331 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfFZOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2400260wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oLgj+UEWnuH/nXzCuT6g/iWSmzVogRXnWTAEILdbE8=;
        b=s6HgvJ8pz1mFKEtN0S8Kx9pkvKR2hjJZQySOrYD5K1+chU0fVGduV7GZMyF3sPX+XP
         645jKICzuF/sRqjhGHXYBtile4u0wJRoXk0iR/C/BjVuJ9Yos7KEMttePh5RkgUEUFZY
         BFWYme23UHytrWrv8RdBL+HhqsGiG7Dg03CXJ7PlKyPswGdl5CQph53Ws44hO8ARRW6U
         6p9rWDsKFXwbHlMiTUnBK0wuZ0MLTHmPNuup5VGhaMWNqd2BCaTsMVA6NnM9zBumwNTY
         /N1p+SPM916dXvzl/I8xgVmELNbCNs3Ip8Plv4gBgFS1poaeG7CoOsIQjoWGZaHiADUQ
         t4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oLgj+UEWnuH/nXzCuT6g/iWSmzVogRXnWTAEILdbE8=;
        b=QtGvEmnBmgDzYyDmJcEn3auGEcS+5v2UEQEXBwL/BykK64vJhR8whbc/5be87qlL+U
         48+U7XtBkHsT6A49XJNlR0cQA0Iwod5fkBP/ri3yN/OD9dPMgcGVZdtug7eOc160nknO
         bIpMQr3rHa6w0L/2e58IUbRsYXUG8IFn1Xscl7Puy3l5JEfghDC0H6E3/tUfYboW0yVv
         RQHrBmojR9TzjdpIZGD4ppRqI8HCTzOu6NNcHq8e5burE5Hn0i6bfvmU7CVG6uR5L1Pz
         AKevWa7DxVfx4TUPkgD5s3SWwQioLBdLdH1d+5EiYW4H2aPhBJikRCQ7jxSq0rfOOeln
         GERw==
X-Gm-Message-State: APjAAAV8rZKXYkPytsJ339b5q0FchR70VyRddftLEwkIq302LI85Z+dW
        u2r6lElsI89k10rjUv4gcuDxAz0BEpQ=
X-Google-Smtp-Source: APXvYqykht4NS8VD1sBSEX2C9Z71CZayXXzjnTsjQySD6gnTuNYoC0X1KZLlRi3p0hL5bCwStcKRLw==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74mr3154779wmg.43.1561560446690;
        Wed, 26 Jun 2019 07:47:26 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 09/25] clocksource/drivers/tegra: Release all IRQ's on request_irq() error
Date:   Wed, 26 Jun 2019 16:46:35 +0200
Message-Id: <20190626144651.16742-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Release all requested IRQ's on the request error to properly clean up
allocated resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra20.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 276b55f6ada0..e2ef6b8211a5 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -284,7 +284,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -294,7 +294,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
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
2.17.1

