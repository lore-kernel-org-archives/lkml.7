Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC306CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380921655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pformDiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfKDOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:23:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39702 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfKDOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:23:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so12181106wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DlHGsHCYz6i9keGsLrYM+8DrDokVvhA17QRfhwApon4=;
        b=pformDiSnMnhGM0gWYP61EL4IsZN5i5fQ20RPhOIcGPtbvADApmq3GGz3ONVTEshHm
         wUje680PA6qM1Er/+RfRn3rLoXyJ3NpKVfmdZ8nVsuKHtCIStEltZD9vqc8Gru0cEJLj
         BBXQmTmeGmCPA0FSuvLswr1oygRQXRacmKn6mMNa7Wj5mCsqwfQ7W3jvUbNWOjsPrE5C
         +s9Tr0F8RqgF+zp6uKjx9lunA6aY0/AHe3l7bor+KvIjirdp5ndgS/qnucYbOCKyo4IN
         EoV8o3HmWJqw6Ffth7CtcZB8UJLk0rlpMe4fCx0380dohUIF1SUGT2Ksbfsdn3hdIR+b
         f/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DlHGsHCYz6i9keGsLrYM+8DrDokVvhA17QRfhwApon4=;
        b=DTOeZKLJaXDV2IczwL44pvL4PHSjahYfRh07mAGshD13yuX7gSlIViNTUcoaFHyr7j
         WU1rmGQqcuqfkiXVB7KbJs2ELkPFQ9pdoMH0ZbkldvNq37iJyPi/LHuQuNO1LXFVZXkM
         AFwsHrjISw7mRaU4zXVTUcXDvYyNUelUxxWtxHsNFrb2pepOUAy+gHFUGWT80x3E2j5e
         0w6oyzIA78T7dZyQ/k88F7s/vn0o/SWwI8m9RBRu56atevcvZjo10Qixf5kXPI4MkpqX
         XTYETKb5JJMA4jkZ0+mFswYzLaktBTh0JVKb6XJ+qP2v4bHB5I0nQ+/eaC8qklCUMTJV
         og+Q==
X-Gm-Message-State: APjAAAUXqDQ8qZJFOoEOUqKyFWKn+3XZyzVrGGUxVOmVa8wQilkJ+bcf
        EVg6524CWaaWKGTpC2a4u7h4IA==
X-Google-Smtp-Source: APXvYqw5dRFCT4rWakrmWngzJkmEsTf4OzwjQFejtITeq3kHdmXf626rugiPj/J78gqdopl+XXEyQw==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr21507045wma.99.1572877394844;
        Mon, 04 Nov 2019 06:23:14 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id l18sm21692446wrn.48.2019.11.04.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:23:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH 4/5] clocksource/drivers/renesas-ostm: Use unique device name instead of ostm
Date:   Mon,  4 Nov 2019 15:22:56 +0100
Message-Id: <20191104142257.30029-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104142257.30029-1-daniel.lezcano@linaro.org>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
 <20191104142257.30029-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently all OSTM devices are called "ostm", also in kernel messages.

As there can be multiple instances in an SoC, this can confuse the user.
Hence construct a unique name from the DT node name, like is done for
platform devices.

On RSK+RZA1, the boot log changes like:

    -clocksource: ostm: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57352151442 ns
    +clocksource: timer@fcfec000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57352151442 ns
     sched_clock: 32 bits at 33MHz, resolution 30ns, wraps every 64440619504ns
    -ostm: used for clocksource
    -ostm: used for clock events
    +/soc/timer@fcfec000: used for clocksource
    +/soc/timer@fcfec400: used for clock events
     ...
    -clocksource: Switched to clocksource ostm
    +clocksource: Switched to clocksource timer@fcfec000

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-5-geert+renesas@glider.be
---
 drivers/clocksource/renesas-ostm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 46012d905604..3d06ba66008c 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -64,9 +64,9 @@ static int __init ostm_init_clksrc(struct timer_of *to)
 	writeb(CTL_FREERUN, timer_of_base(to) + OSTM_CTL);
 	writeb(TS, timer_of_base(to) + OSTM_TS);
 
-	return clocksource_mmio_init(timer_of_base(to) + OSTM_CNT, "ostm",
-				     timer_of_rate(to), 300, 32,
-				     clocksource_mmio_readl_up);
+	return clocksource_mmio_init(timer_of_base(to) + OSTM_CNT,
+				     to->np->full_name, timer_of_rate(to), 300,
+				     32, clocksource_mmio_readl_up);
 }
 
 static u64 notrace ostm_read_sched_clock(void)
@@ -190,13 +190,13 @@ static int __init ostm_init(struct device_node *np)
 			goto err_cleanup;
 
 		ostm_init_sched_clock(to);
-		pr_info("ostm: used for clocksource\n");
+		pr_info("%pOF: used for clocksource\n", np);
 	} else {
 		ret = ostm_init_clkevt(to);
 		if (ret)
 			goto err_cleanup;
 
-		pr_info("ostm: used for clock events\n");
+		pr_info("%pOF: used for clock events\n", np);
 	}
 
 	return 0;
-- 
2.17.1

