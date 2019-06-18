Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA4C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661F2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRFUU+v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfFROEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:04:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37094 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfFROEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id d11so9392992lfb.4;
        Tue, 18 Jun 2019 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGtYvpn4I0jJbqxAf7ldvCplrBd2VH6MuMjptajnNUk=;
        b=JRFUU+v5WIoi99mY2jb0ZfXWXd6tGt848YpxJzJho3JpJKNNU6G2k9s+PuTFUoaGTr
         pPAAIupVitqL4XWBLNe1wiHqayP6C7i20a6bBK3fVi3XBgd2Ss+5RGR9DzA3FN3+iNm0
         6G/8KB+eeeWvTb21Z/J3FoQnd2Q+LVSOdckNWSenjE/Sbtqxm9HbbZZttqnL5ncb6MVM
         9BuMZVOlphORSpa7o1h7BKxFShMaZy9B+nxgX2U0+4jl2QyCJEmMjST0zNe1vEs/GDx6
         MD2SMk20EnpMGfIaw5E61jPur3gk7Z5XzguA7lVPCBV8l9bLpY978zrvXBO+D1Ih9Gk0
         VtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGtYvpn4I0jJbqxAf7ldvCplrBd2VH6MuMjptajnNUk=;
        b=TzMXrt6AoHSxi6pQhuIKMAjQO8jo8IpeMD4MXLFhducINGszGO0WdTAKPSmtPy5H/H
         +Akhk7aOwcq7fp687BSiBkDyPtVgOIpAZ61YPEmntq4h40cr7iH06BhlHb6pY4i1lZsI
         +wf0xOgfXLj1q1ywTftG8EgrCy/csQp7byDr/Ed/QOP5KFApAPeNOcTh08kT7agdqODd
         FxbwsU2Zf8+N2XJ/Hkxl9nBQWr8aAjcrLhiqDLenbaYf+yY9cwA4wQ6WlpAeZ4jHPRrp
         5PYzY+0enJ/xfsWS4OgRM1f7iB7oKvgr2icWuk84ZX/nW7Ol+VX3E90uIx2PKT+F/xNB
         JAoA==
X-Gm-Message-State: APjAAAW2yZzTHpvqgM2RQ/bRGhBkOEacVW3GBG2mgcRjOMGeZDnXc85n
        jammS+ndAkCXzsfUkzt4OLs=
X-Google-Smtp-Source: APXvYqy4wwqSdOKSc8aHYzMQqM/TTQCx8pj5NWfBNRQECvYckaVREVOiHKUf3bCe6bURZ0SyfbZd2w==
X-Received: by 2002:ac2:4312:: with SMTP id l18mr51123390lfh.139.1560866683466;
        Tue, 18 Jun 2019 07:04:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] clocksource/drivers/tegra: Set up maximum-ticks limit properly
Date:   Tue, 18 Jun 2019 17:03:58 +0300
Message-Id: <20190618140358.13148-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra's timer has 29 bits for the counter and for the "load" register
which sets counter to a load-value. The counter's value is lower than
the actual value by 1 because it starts to decrement after one tick,
hence the maximum number of ticks that hardware can handle equals to
29 bits + 1.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index b84324288749..355b29ff6362 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -137,9 +137,17 @@ static int tegra_timer_setup(unsigned int cpu)
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
2.22.0

