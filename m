Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87467CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572462173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1Lus7UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbfJWErt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 00:47:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45888 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbfJWErs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:47:48 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so23260116iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8s5Hu4KyRljjB6EbA5uq0pBLzHLqE6KU1oX4tmploss=;
        b=u1Lus7UDOm+SKfnoGFsmG4wfwjvs5p3bXbMjvCxR7fedthqKhDjCwwriDAqYJFE4bM
         Znl+41N+UHVA5B3MkXhRLKrrzW9vu9PPQnUX1h5i/06G4J6HtV4y37L1z6vVr6qQGNoe
         X2D2eaC14k6KgoNDvg/ldAJZbULZADk2Hc14X0yooUdVwleGQa7xcfuJdMyS301ttxdW
         UvAWlIll6fRjY/igwPTJk8U1K82ovfELMBORqGZW2o/Op0bMN5eYKAaI1VXmzvRBtPT4
         PTWn7HXSJly/B1DTQ21bSumX+9/qGVfQLKxwQ2CPzKjx3ZmF5JmzJsrhe4K5s87bpIfO
         B2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8s5Hu4KyRljjB6EbA5uq0pBLzHLqE6KU1oX4tmploss=;
        b=Op3euRmAmjkpqBfZ9SQz852O8sTyza6foy79mRweRukeKFNVK11C11Z8jV+pSffoAu
         6EKBZniqL3vM4N67DCJwvyigppAYmseXZOo5URj2FxPavDR536Rz/EoS2hgiUptTX3dv
         VKOMj1eCIXMe9jCcb8qrC836yt/xBWGoZDR8A2puZ8A98DFgPvqcu1KJAJteZQiY9yBr
         RLQT4s0BG+vOpx2qFehPOLVRecnshE1nJxLq4BoBTLk3AFw2Wv4T1rSbmKL4u1FUtX0p
         womJNYLBD9rxVF4Scl8/3gxXsJIF5CRucuh8uGlRNhIOuflCLd/4jfVIPhidWojHBAbg
         GL6Q==
X-Gm-Message-State: APjAAAUK6i9oz3DqlDNoE87RK1f7NzR69GL2VK1k2/JRzr/ovNFjIPp6
        cbiK+aEtAyKpEd87GWr2lck=
X-Google-Smtp-Source: APXvYqylczteWA5Ex/xulqtHFYZRtyZvZ+/djFw2nj7Bkv2Xd43P5j40w3DyJCsBgy/vrBCnGIpA/w==
X-Received: by 2002:a6b:510f:: with SMTP id f15mr1393656iob.116.1571806067822;
        Tue, 22 Oct 2019 21:47:47 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id k22sm3049563iom.38.2019.10.22.21.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 21:47:47 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     michal.simek@xilinx.com
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Markus.Elfring@web.de, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers: Fix error handling in ttc_setup_clocksource
Date:   Tue, 22 Oct 2019 23:47:36 -0500
Message-Id: <20191023044737.2824-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of ttc_setup_clocksource() when
clk_notifier_register() fails the execution should go to error handling.
Additionally, to avoid memory leak the allocated memory for ttccs should
be released, too. So, goto error handling to release the memory and
return.

Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 88fe2e9ba9a3..035e16bc17d3 100644
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
+		goto release_ttccs;
 
 	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
 
@@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 
 	err = clk_notifier_register(ttccs->ttc.clk,
 				    &ttccs->ttc.clk_rate_change_nb);
-	if (err)
+	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		goto release_ttccs;
+	}
 
 	ttccs->ttc.base_addr = base;
 	ttccs->cs.name = "ttc_clocksource";
@@ -363,16 +363,18 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
 		     ttccs->ttc.base_addr + TTC_CNT_CNTRL_OFFSET);
 
 	err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
-	if (err) {
-		kfree(ttccs);
-		return err;
-	}
+	if (err)
+		goto release_ttccs;
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
 	sched_clock_register(ttc_sched_clock_read, timer_width,
 			     ttccs->ttc.freq / PRESCALE);
 
 	return 0;
+
+release_ttccs:
+	kfree(ttccs);
+	return err;
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
-- 
2.17.1

