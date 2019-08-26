Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CFF22CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPW1jRGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfHZUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53724 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfHZUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so794890wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FoQUNs6EXC98c6qNkjKAv+h1NQz6LneBfiroF9aLlEY=;
        b=jPW1jRGNr3AnUe8RjuZmRCXkYAzsbzMhz32nq0OWWy1zpvhbhiDiAAuRPeiyVl491V
         cCLcdpNtFLqim8SyephS7b9b9ko8sszl0kvNj9BUd6h/QBPgHXF6o+PKgNQPiVfYIRFH
         B5PaOVC29nRY9kNRjKZOXYVORKwkhwB4w6wIQfyh5qoOxK8zLHitQH33/0d6bWm9f+Hp
         jXHkDDm3osu6MOCTwW7J2wI7rENToUJpJEwajOTRQlt9CP252Ej6QkLEf/vKr4EMYtlw
         qSq1d5xHTNDG2TjA+3gjsTNtCTSGd3PgMPfHdHP33PAXjh10wjQNIX5E0VjydN1qN6wD
         2U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FoQUNs6EXC98c6qNkjKAv+h1NQz6LneBfiroF9aLlEY=;
        b=btnqkaIZGMoXWn1j+ENn3aqzTK4hmkgTEMce5YYF8e/lN4Vfixi4UuN3SzEWE4QBsY
         aUrmHDKrcAHfBVMSsCZHylSpWwQKvwCX1SmUI5GLPGlZyJ89ohEBuf4jR/TKxLtVym2y
         5cg/+GuUtMPtp5Igqax+emmMYo0Xo95tOtHpUp1zqDr8P1LIzOCASN88gyYzHOv1puZU
         LCsOlvCRvAPMJZAd2e/q8sLTfJUD4UBqLkeII5IxuaNoVMseRFXtQQvnEKS25Ywxx9p2
         tkIyHZhq1Qn7Aqgn5qnvmQJgZRLHpKbe0iTw3AHzqwTzE7TWXkBGG1VOk3ayXW8rPGln
         Atjw==
X-Gm-Message-State: APjAAAVTF+a+qUPnn9HPyMhYLB0Sq+0HpYe8J2WxLmEhmrqZ+l+R+INf
        B+d2jOh3eCVRUhzyVwLStpT14bdOpYY=
X-Google-Smtp-Source: APXvYqyHbekAIjbL3EcGUIK26+5NTPt6HqD6js8hW+tX33ban4SVbg0ypMkdOAVMDSLQmyTu6FbxxA==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr21953351wml.87.1566852304570;
        Mon, 26 Aug 2019 13:45:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:03 -0700 (PDT)
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
Subject: [PATCH 10/20] clocksource/drivers/renesas-ostm: Use DIV_ROUND_CLOSEST() helper
Date:   Mon, 26 Aug 2019 22:43:57 +0200
Message-Id: <20190826204407.17759-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the DIV_ROUND_CLOSEST() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 61d5f3b539ce..37c39b901bb1 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -221,7 +221,7 @@ static int __init ostm_init(struct device_node *np)
 	}
 
 	rate = clk_get_rate(ostm_clk);
-	ostm->ticks_per_jiffy = (rate + HZ / 2) / HZ;
+	ostm->ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
 
 	/*
 	 * First probed device will be used as system clocksource. Any
-- 
2.17.1

