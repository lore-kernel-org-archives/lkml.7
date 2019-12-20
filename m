Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D0A24676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2a18GCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLTAJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:09:37 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43545 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTAJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:09:36 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so6066950ioo.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MTszdXA31s6xPF2TlS6Lmct/FIX8+UeMJUwiKqaD1H0=;
        b=n2a18GCi3DeWASocTD5N9/6wsr665l5p4/2DrWqBBQoMBz4RPGUQWN+K0MO4xyr+DF
         rqvRubb02dpEFF0gQpVLlT3xnKIQ/hR4TQ33c21kbCuhSzYhNaZRmTjzOxE/gs5tia9o
         LQu6HUfeOm+x+Z/K/0QdkOI5i+OgB62OHQTHgsu21qbfpTJhYA9LU2FGr1M0EA9kS997
         EJjvOoic7TsMaDD4IG71q5CtwhEvYifVCrQC7nnkM7kQWBK/DDMyvHUToci+XQjt1gbT
         evFV9sQJETWt9Q1lh58zinjU2jOH3cQDR/3Q4nzPG2pyUYd4SMgZJsnBua44AHuPOe8n
         Tvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MTszdXA31s6xPF2TlS6Lmct/FIX8+UeMJUwiKqaD1H0=;
        b=SypLz/lS+va/TWzu0Ga4QhhhHUCuWLoMqI9Gmrqz+FKf5Wf7AqobTXcEaiNVRnji+k
         w6TQ0bgezEy6nHaSpU3Im4sA0L+Atmx+TcfnvjKO7pyGpKyXzfvPHFfLNbSLsoEHh5kg
         vU6NJo3XAHPdcB+H2X+oeN3qeA7YuZro+lft9yWcackxHitN2JKnmkYbSz/lNLOfDI0y
         7pOE44r7oLHHD/wCzXDiwPn+FVKwExGaPdvvD7244wdVAunY0fjjQTcczG+t+BkYvCu9
         5jST/B4UCa1yMcC2OYX7HXhXiBjAs9sbdTK25CLNCP7pCz0zSbgK36m0iB+ZUziJTaAX
         /msA==
X-Gm-Message-State: APjAAAWJkT1clfo9Stapa+HIOXUwpHYMa0BoXtg44OliZp8LiBlNaOBY
        pcnxGfy1KbN1aE0sMzBJg6o=
X-Google-Smtp-Source: APXvYqwJfO4AtKgYH0x9fTiKnObinPDpwfkYMVw1/y/J6GwULjFNxdg8gM1hnHOcY5MvKhXJOfQgww==
X-Received: by 2002:a02:bb02:: with SMTP id y2mr9506946jan.99.1576800575988;
        Thu, 19 Dec 2019 16:09:35 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id n9sm2409305ioo.38.2019.12.19.16.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:09:35 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] clocksource/drivers: Fix memory leaks in ttc_setup_clockevent and ttc_setup_clocksource
Date:   Thu, 19 Dec 2019 18:09:21 -0600
Message-Id: <20191220000923.9924-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of ttc_setup_clockevent() and
ttc_setup_clocksource(), the allocated memory for ttccs is leaked when
clk_notifier_register() fails. Use goto to direct the execution into error
handling path.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index c6d11a1cb238..46d69982ad33 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -328,10 +328,8 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 	ttccs->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttccs->ttc.clk);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
+	if (err)
+		goto release_ttcce;
 
 	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
 
@@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 
 	err = clk_notifier_register(ttccs->ttc.clk,
 				    &ttccs->ttc.clk_rate_change_nb);
-	if (err)
+	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		goto release_ttcce;
+	}
 
 	ttccs->ttc.base_addr = base;
 	ttccs->cs.name = "ttc_clocksource";
@@ -363,16 +363,20 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 
 	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
+	if (err)
+		goto release_ttcce;
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
 	sched_clock_register(ttc_sched_clock_read, timer_width,
 			     ttccs->ttc.freq / PRESCALE);
 
 	return 0;
+
+release_ttcce:
+
+	kfree(ttcce);
+	return err;
+
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
-- 
2.17.1

