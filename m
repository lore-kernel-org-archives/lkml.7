Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522921872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaCTVJwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfHZUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41708 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbfHZUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so16573394wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GWZ01Skh8cQcWVz+pcA6teJikvF4jln+3VYBxfBbkpc=;
        b=aaCTVJwleR8Zw8xXwUhKuTzGd3qAizfF2VBj/m0V6UyufC3CfXvN26JTI9Qrqgssr/
         MhbELD3m6GkHfHycRbKyOSLyJp1wxd8gM339k0zH0PrYKmvsziPSwDgx8OJQWIo6wrwZ
         yU7N3lGW+65+NSrVqjMTQIyBNrKfysn9IMIvmb6xeRY7xPFzJwXkU8xVO0ez8FjkkANm
         Nijts4qCeRVlCthLo6XSxPOVkh/3IaPj8g63mPvqx6G7z1P2cVY6jMWljaPU9hKc1R0R
         Z7kkWsD4ujQUzzh/Y0Rxv/O91hBecyfb02dbxrwgW8Tge+9m29v1crfF+7pvspowd1Ai
         DaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GWZ01Skh8cQcWVz+pcA6teJikvF4jln+3VYBxfBbkpc=;
        b=m9Er6NFSeMpI8H6GNocClnh4yD+gGwArujh32yFb7kk4qxmZP+a12X9xWZB7AUZLzt
         4Pp/GBNYJk7Du1EbH3goNDC4ZmfPLEJqLcAgGJGF+iL+FeGSbNrJG25MGIiOGcwLVZ8B
         BJ6nY1wLyGBvw/xF4QW37gGpqu1hcqtXtzWa4K8XwgbEKFfipCljqBcB9L3JIOWok/0s
         tBGKJ6ExjwCqqUx//utxI4WCxrHu2fmmGF46CwHyetFskKhV8IBgY4OjfqiTS0ilaDv6
         y74yBkb6oUd7/CEI+xA/70yznKm2GrNY5/BzPrtfuVsVMxSGZcDhp/wQlHsTiw8JgRjD
         bLDQ==
X-Gm-Message-State: APjAAAW9vQMcnxGjcwzq+AdBw/NkI+2xns6sG+DvhuxtuhB2LbqNWRZy
        i/KJ7hbbZGmrQGksv8E9KnNHrQ==
X-Google-Smtp-Source: APXvYqzPx683hISSMEiLSPegjxKr3ZnA/URrCNibdrFqGNOCuSaM5/nrVsE1EecmfWjLGocI32sTDg==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr23928260wrv.272.1566852285709;
        Mon, 26 Aug 2019 13:44:45 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 04/20] clocksource: sun4i: Add missing compatibles
Date:   Mon, 26 Aug 2019 22:43:51 +0200
Message-Id: <20190826204407.17759-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Newer Allwinner SoCs have different number of interrupts, let's add
different compatibles for all of them to deal with this properly.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 65f38f6ca714..0ba8155b8287 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -219,5 +219,9 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
+		 sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
+		 sun4i_timer_init);
 TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
 		       sun4i_timer_init);
-- 
2.17.1

