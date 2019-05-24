Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2193C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B9721850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJ1stP/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391121AbfEXLRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:17:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40053 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390906AbfEXLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so1326474wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJ/OTTzXkpFYyCPQfFmBGF9g9r7JKprAJcxNABvYugk=;
        b=gJ1stP/+skWInP/MCWzv188wslOchZmZz7clJcjMeGjOAKJVQ8ZUw6DC3QDutVoMw0
         P9CD1wa68T48LNgzOL7NlendOV281v85ONTsvsKVKy7YZIlATB8R96UEy2fslY9V+hNP
         +AD88uTiybNf3E+9E77v6ACNBfmmGwR8DBJ4X0lOPm0ygG1/ayhIkfa66R06mrzcqHqz
         Bwge7jwBG8R++lmUEjjQwHdjlVQVZG28lqF4cR+8pO2kDAoNE7liSM+Qtt86AhCrDxw8
         WyjbpoBwIOpNWeny42n9gNyVfmFWBgVcxTsD9vz4BKVE6P/Xyxvpx4mnB6NAQORjH68h
         RzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJ/OTTzXkpFYyCPQfFmBGF9g9r7JKprAJcxNABvYugk=;
        b=Vj+wcGup37+AcHBAjvkdaemg7BTh+xo0scB2v2SIAJStmD9VZMu43MhxNJjBIkMUpT
         JWp1i7G2U/Fqva8vNubkM+sk6stjGIqR0vveDSCyOBCoWdWJoZTNIUVpj2NycKmYwQ72
         1giiEZ/gIZRJUQeY/bYobYMlQ37boxakP+390IlT8BTaBf1OF8oe3p0CAeUQvYDx9h10
         LhfrNRZsbxe4bGgVoRkm6b8XYMiON4tg9HqgKa6jorM9UZjqE1su8zFlT+3cT0wwdlP7
         CXgSuiv6iJNAgbqrryfTnXMM2M5+k4YJM7/Bfkpf8ZhoIBIuQeY0OmMljxxORxt5n5xe
         RBtg==
X-Gm-Message-State: APjAAAW8WrC42vqAF/vP0Ap5rKCoexyxGMpaGR9CJugRtUGZ4FmYyPSp
        bRgczp0cysjn/NaSHHjOHWAh2lleLes=
X-Google-Smtp-Source: APXvYqwLT4QBS8z2EMD4tz2k+B7csRsPTzLT+U55/TpTh9wgMAjKbffrAFoN1cIOiCh1GuX1fcR2FA==
X-Received: by 2002:adf:e9ca:: with SMTP id l10mr4153207wrn.47.1558696601880;
        Fri, 24 May 2019 04:16:41 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 4/9] genirq/timings: Use the min kernel macro
Date:   Fri, 24 May 2019 13:16:10 +0200
Message-Id: <20190524111615.4891-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The' min' is available as a kernel macro. Use it instead of writing
the same code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 06bde5253a7d..8928601b4b42 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -406,8 +406,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	/*
 	 * 'count' will depends if the circular buffer wrapped or not
 	 */
-	count = irqs->count < IRQ_TIMINGS_SIZE ?
-		irqs->count : IRQ_TIMINGS_SIZE;
+	count = min_t(int, irqs->count,  IRQ_TIMINGS_SIZE);
 
 	start = irqs->count < IRQ_TIMINGS_SIZE ?
 		0 : (irqs->count & IRQ_TIMINGS_MASK);
-- 
2.17.1

