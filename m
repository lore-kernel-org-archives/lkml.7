Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC392080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2BSh+mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfFZOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54759 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfFZOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2400954wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNYOymAKKEH/tI650TaMtzoROF9PuK3S14KyC5Y7dck=;
        b=h2BSh+mBbKB/aAzQ/gQlS+Wj5rwnDzY9BvtREtVrYXOVriKwhIKpHmd+rJkVSbmG+7
         leuCcbHhQpcbswklQB9CS5AFvmAK3Q0l2OJQtqmvEdPvYb+CaC/+FpLEqsB0CvfU5HtF
         x2gP4Z8dfJEIDFqZr7kggg+1ZO6Edh/MzRyPFaps22Ey8JWbglZHGoV3505OjL9D2c3q
         yrrbJcAxDIjQkN5JvsrMw/qvtZkH0JZZWEIfjiz9/U3M3NAogydbjEc5OxSU8KRCEzKU
         iBnLuanOJQETHsnRwmp4BiPnYRnbMRXwgArRpKaMSOKwM4mFB7yDl5EJ8rGO9jdxCWWE
         F5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNYOymAKKEH/tI650TaMtzoROF9PuK3S14KyC5Y7dck=;
        b=b7OkoP14Y7qblagKoczZQYVyX76IKMYVjV/i7sO0VGUPta3TusUzGxAgcgahf6ET51
         g+YPRQ5iWUhNCSO45ChFkpSu/ruXQjMsseJaWFZfSnOqrOMDfpWNMN8ehpxsT2KvQJSL
         w4pR6BL8BjgXY8XAYC0+XQiBXzlupag54G8gi0p0XC00Xgkjw0XOG7C+DrG17hgYprf5
         0oMkUM919WVukq+PlJ1mgcDLfvvrXYy1Jj4ws0cUFwtwhEJPDvrK7coJh4y/ZBtFSNVB
         FhrVmDYlUCC5t4fwN95jSVK0/HKEORRhllZpk4f18/17NjCCPgDblQ55vMC46EgqJiKB
         YJWw==
X-Gm-Message-State: APjAAAXbSs0IrRGdH+dedu91g5xl8ZpYPx7ihvK3p+m8t+4f7xRvs421
        3wYCxIXHoqSBGkdU2PRuPJJKPA==
X-Google-Smtp-Source: APXvYqwhOresNDpLpLvnoNXvBnluPEveGjhRuYSXOWXlyJsI+E7rzWIim7HNPzw2lJ/GRgxl5Eho1A==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr2932893wmj.2.1561560435122;
        Wed, 26 Jun 2019 07:47:15 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE)
Subject: [PATCH 03/25] clocksource/drivers/arc_timer: Use BIT() instead of _BITUL()
Date:   Wed, 26 Jun 2019 16:46:29 +0200
Message-Id: <20190626144651.16742-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

This is in-kernel C code, so there is no reason to use _BITUL().
Replace it with equivalent BIT().

I added #include <linux/bits.h> explicitly although it has been included
by other headers eventually.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arc_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index b28970ca4a7a..b1f21bf3b83c 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
@@ -142,7 +143,7 @@ static u64 arc_read_rtc(struct clocksource *cs)
 		l = read_aux_reg(AUX_RTC_LOW);
 		h = read_aux_reg(AUX_RTC_HIGH);
 		status = read_aux_reg(AUX_RTC_CTRL);
-	} while (!(status & _BITUL(31)));
+	} while (!(status & BIT(31)));
 
 	return (((u64)h) << 32) | l;
 }
-- 
2.17.1

