Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E16FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGF2yffb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393198AbfJPMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:43:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44978 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJPMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:43:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so11214686pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFYPT3OrsbiUD60Nb8NDIx2f6C6Q/2ZZ3HTvfG2KWDI=;
        b=TGF2yffbWIfYdq0R5MXC7aLdf2wihHo/XfTvhYAQ5bopyjIE6lMn2U21/SkQZR3zes
         v5JLJjnsHYDGNAmE2ci+pQy33q2Tk3WNhlgVMeLV57PmFmECvuM6th9Cbk+ZPachApgl
         H7zyK2DvXEcpCMkubmEnKrOVguuUldDwiCyzxpc9sCSjZDUg3SgHOeemOS1ZvhqrNlWe
         c3CgychUcuzfEaAJQrIVU+acJX4C+4QtUfKGwJOpfLAAf6RtbepKKCeilDh3k6bFwPnT
         5hOpvQTNbW9NwEt0DLVDnGHd5kUO79x12hTHgp2C2/ZQNc73FFvnMOi/F+NUemPxj1eF
         //rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFYPT3OrsbiUD60Nb8NDIx2f6C6Q/2ZZ3HTvfG2KWDI=;
        b=Vw6ZxGXrp1cuItMhjue1vRU//6/gh0C3PSgaMOFG7N5mCwfRfI9ryjR+bm8Cc5isc0
         gO3KkDzlnIrCdpNMXOg7n+IdaZVxtdXVEjxsrRyCylmHg0AeHCoOhO/3vzNdO146AL+Q
         w9dxSMF9s7Krk7THboqKI7TFDZlmdOoakAbup3K2+0fFWfhVOhMMwWAuOD0h1fpST4Cl
         Ch1qq6KRC5ZzzgKTnlJBbhwp7gXtDuipGU8Zz/8vw+b5O0CI4J4AgR+7IprFbvcSq3w/
         r8iJS+wk9Ygf2DsSyz/SvNO2K+JZAKLxxXFrj0UX8TjL7UFEG+qCLm1mLcYtkWFEMR/u
         ZZmw==
X-Gm-Message-State: APjAAAUPLUS8ktl/n7TLDR5Li4J6fYi6v1Y8OyYp83XwGJSXow5DJk/d
        onAB0b8csGvn1AkChzmZMyw=
X-Google-Smtp-Source: APXvYqxlKqqfHauh1QZMUlXSk8OuNmVIgZ6K0hVwnYMm6tGgku/yb2kebWcD53eqiq0YGhBolFRbSg==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr41460060pll.211.1571229822775;
        Wed, 16 Oct 2019 05:43:42 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i37sm2604894pje.23.2019.10.16.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:43:41 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] clocksource: asm9260: Add a check for of_clk_get
Date:   Wed, 16 Oct 2019 20:43:30 +0800
Message-Id: <20191016124330.22211-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm9260_timer_init misses a check for of_clk_get.
Add a check for it and print errors like other clocksource drivers.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/clocksource/asm9260_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 9f09a59161e7..5b39d3701fa3 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -194,6 +194,10 @@ static int __init asm9260_timer_init(struct device_node *np)
 	}
 
 	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clk!\n");
+		return PTR_ERR(clk);
+	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.20.1

