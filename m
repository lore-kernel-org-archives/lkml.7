Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50373C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279EC21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twWc4/+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbfEXLQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40051 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbfEXLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id t4so1326384wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7Wy/UoR346yun6rGdrn0w0Sk7Zt+3JLoV24BHUfklw=;
        b=twWc4/+Qzxo/D1UOnToCY0eDa73j5l1K8Qp94mmxWXgleAnqOFh7FoKKZXgEX4YCZ0
         k2+yDABe/dRSA4VkRLWycdfvXMNAh72chSlPqCET2BGRhVfJyuoVFeS8WwFTy7HwZ5LZ
         RHnk8bGliEfW33uzlNY+eHQRjzpwMaHQtca8eb9UsIl+QVPTpYk0CQDqCU8rAZQL+VCQ
         jIEpo5lLqbJeJcRRObCrX2EcluaWMkAhvFRcRKq0/9bjxxpX1u2WV6zE+8uh2LN2M9Lr
         57VthcvkM2QDAh+/7dH2ni5xz4/7svNg+4NpIlS7Md0oowPzqWjkGBq9JjBEZSOqfKy7
         JRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7Wy/UoR346yun6rGdrn0w0Sk7Zt+3JLoV24BHUfklw=;
        b=BSZtwcg4XluQ7viQ4XtYkCMRR+pZBDGs6broLnFyYVZOxRfKGJU05aNpYeQhZrBbDJ
         IOdne5850jWKU/EMSHt3FT7t55FTGrfQM6sseI2S0Ns0tFfRwvOD7iNuMNbofWU7JzEG
         m77FeVdJZdA/WAHZCLyTjKgvvtDFQVCAQiAF992GEfQWj6XXpyalcqS5cpb7tSnFHCXH
         ocM3hKZiHKjIY5MEQAgYCcjUC+DwFZvhCPNOtIiYQv2qXRogTxhroQYsQdzEw4rMh3ZC
         CSaW7SYHG7MRz8qFDJZTDQKc3FxJ782tQYfDPQLzUg2O/ZTlARBtwK36AzjkL9E2uSm2
         Sm2g==
X-Gm-Message-State: APjAAAVQtPmAUCddQQPr33+EQuFaTbS9jAcWkyNEGdLagc3N0UhPmKnl
        nz0vrIoGANNnr3prAZP2NUuwmw==
X-Google-Smtp-Source: APXvYqw/r6MOQUm7yL1/YotNmLwatMoacJjTUqbMZk2z6ica/A8ndWWmfGDLMbPOl6S4ZfvHpN/7yQ==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr5174901wrn.133.1558696600480;
        Fri, 24 May 2019 04:16:40 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 3/9] genirq/timings: Optimize the period detection speed
Date:   Fri, 24 May 2019 13:16:09 +0200
Message-Id: <20190524111615.4891-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a minimal period and if there is a period which is a
multiple of it but lesser than the max period then it will be detected
before and the minimal period will be never reached.

 1 2 1 2 1 2 1 2 1 2 1 2
 <-----> <-----> <----->
 <-> <-> <-> <-> <-> <->

In our case, the minimum period is 2 and the maximum period is 5. That
means all repeating pattern of 2 will be detected as repeating pattern
of 4, it is pointless to go up to 2 when searching for the period as it
will always fail.

Remove one loop iteration by increasing the minimal period to 3.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 250bb00ccd85..06bde5253a7d 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -261,7 +261,7 @@ void irq_timings_disable(void)
 #define EMA_ALPHA_VAL		64
 #define EMA_ALPHA_SHIFT		7
 
-#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MIN	3
 #define PREDICTION_PERIOD_MAX	5
 #define PREDICTION_FACTOR	4
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
-- 
2.17.1

