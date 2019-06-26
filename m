Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5892216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+jbMOKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfFZOrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:41 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38128 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfFZOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:34 -0400
Received: by mail-wm1-f42.google.com with SMTP id s15so2403163wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JvEiCBwyt/FKczphOvHNL3YMIgGxDxP9ixu7/5tHp7M=;
        b=u+jbMOKdCIDcgNwQ5SKzxdumQXKz+4H/GV1MYi+b0w+rDX9SQoHqjFAawZpxvfsaxT
         MVvo4u0FeLLKRpMrYCVr6WvteuSo/FxHmlXzHzRHTPz9InQ6AExsJHd8WY3ODYlzOP0F
         1sf/iJfMEw6yKIlAEu5o2wgAK5/Yedgxz52cdYRjyx7RlS8wbf/Rvd0mwZRJvCM/OoL3
         0E33X1DK8ePMSOPLrxkIanWPc4EeXZ9gzBj2ULS5JjvFqAMbYF8F5Fq+jsqJ2W1gt/5K
         YkkpBnbr9DJXFwvFFaj1BIdHKyK4BGJypovS5jC7Q+IhdooN4uTdD1QK7bilfWdJxkKv
         fo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JvEiCBwyt/FKczphOvHNL3YMIgGxDxP9ixu7/5tHp7M=;
        b=HUEUXwObDnTkaGWZhEYUySJxDjPezJAS4GVcUILS+fBENOwBrFRq4o67r8I9Gdgp+Y
         TMBBQk6AHByI+62pZJ76LwjXW0amgybARUEDAgCcs2rZ1iTl/26AZJidEnCwEtwEy8V4
         0awhLpo7d4m/74D8Bnldyr9nTF5+NJ7H1DhvHQMGBOQ/jFySNrJ0Z+VYfwnJ3zFlxJQX
         gfP5T5XCyDU4heAJsqj4HnR7J/DJK04m54ZMa9mBkmb7qJvrvaq8BDh5Iy7QhrULSBP/
         zfyyEJJn/HebK5LnjquFNVnQY1AErljMo7vqlc5oVHX56R8vWxID/AFzlXR1skbtNOBN
         D3Cg==
X-Gm-Message-State: APjAAAUa2ZuEUyDyxgcibHnZePkWOG/1QPCV985Oa9QcwHs0pNWAvuQL
        yUout9/7up4uJc8aBo1fIfG8Uw==
X-Google-Smtp-Source: APXvYqxuwZ5g62iGl/0rN5GUTTLzLcVXiaN/QG/LuI6qU97XyWHatljo4pFpid4afVTHBHXc1gYkow==
X-Received: by 2002:a05:600c:1150:: with SMTP id z16mr2908235wmz.168.1561560452590;
        Wed, 26 Jun 2019 07:47:32 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH 13/25] clocksource/drivers/tegra: Rename timer-tegra20.c to timer-tegra.c
Date:   Wed, 26 Jun 2019 16:46:39 +0200
Message-Id: <20190626144651.16742-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Rename driver's source file to better reflect that it's not specific to
older SoC generations.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                           | 2 +-
 drivers/clocksource/{timer-tegra20.c => timer-tegra.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{timer-tegra20.c => timer-tegra.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 236858fa7fbf..4145b21eaed3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
-obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
+obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra.c
similarity index 100%
rename from drivers/clocksource/timer-tegra20.c
rename to drivers/clocksource/timer-tegra.c
-- 
2.17.1

