Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77206C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8920868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhW3v/ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfGORaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:30:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41057 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731841AbfGOR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:29:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so17103060ljg.8;
        Mon, 15 Jul 2019 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcSOrGe+NvjMoF+zn2PIaLNd8UvLOujvhVj6vQXyo6w=;
        b=HhW3v/cibY/jUqSagSPCr1VHPYsVuGgoaPGChGpTHi/snObYasL3gJLsJRWypVcYf5
         /QVNFWMtJDlXMm/G92Mqbs+p6XvHEKSQAX6XGrWcgAUPQMaAQGGOrBOLVGaQzDlFaGjj
         Tc7/d4AyKryOJlQAzWoQ3sOhSUOg3HQBV1qF/eLskSCge9An3+JJO/J0lyx1InW59298
         ClNpJTh+HlDaJF5GYDlltoQgqyl+V01oitYm8t+2Ah7mMNz13ooCr6I4Kmf1/i7FNuBw
         jN4Vi2LkePvPbzzBHqMkte6oT/nNflE25/k0JYxqoDZM8RlztDS9p1gnS25jtgzIYOze
         tzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcSOrGe+NvjMoF+zn2PIaLNd8UvLOujvhVj6vQXyo6w=;
        b=uWpPilqCmvmEjBorU0aBAQon3pYzZqErsanyoddIAi0ZFsfHKF2ArnhjAfy+JsI1eX
         ywd9hEs8H3NxtQFunNhbEnazFjg9Uxh4T5yzr/P5DcF1e1R+mj3zK0tbIggglX0wnCJb
         eu/u1RzhKoKvJbml74tlnRORYjqSHKrKJsDDIRDxrdZNgSiFHGHn3ozYNZpw5rOhZf85
         UIw5zVEg9Fqj76vPOKcYrdpFUeD/BAgVh+yo/9CcVkM/andYbxx9EVlVMWnjmToekRU/
         23dcBP0a17A587bC5HRXFMP6wZ9Dv8+XmwdBsbgZCB9E4tZsQUH0gkNRQy1GdMh3CEMy
         O5Ww==
X-Gm-Message-State: APjAAAWBhqLZ83PsMO+MRn3VKql1CqarM18ynMEMuCDfkxn9bVjMckWs
        7avEOWnvfZ8j27+PLraGj40=
X-Google-Smtp-Source: APXvYqyc+nXxLCxnPxpYEysbEKKxLVQGneSSFyXG+OHogwxMgfq2PeUYIDNHm30PQPkkJYMi6Z+Y7Q==
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr14618377ljc.123.1563211794677;
        Mon, 15 Jul 2019 10:29:54 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Mon, 15 Jul 2019 20:26:26 +0300
Message-Id: <20190715172629.4437-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new CPU Idle driver has all necessary features in order to allow
the deepest idling state on Tegra30 SoC where the whole CPU cluster is
power-gated using the coupled idle state.

Note that outer_disable() now need to be invoked directly since it
produces erroneous warning message about secondary CPUs being online
because it doesn't know that secondaries are turned off at that point
by the cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c        | 4 ++--
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 7d9ef26e52a7..1845b87a7cf3 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -146,8 +146,8 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
 
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 2ab293343069..ea084a0aa448 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -324,7 +324,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	case TEGRA114:
 	case TEGRA124:
-- 
2.22.0

