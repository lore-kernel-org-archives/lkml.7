Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77462C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4686B21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eK+nQS2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfHZUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40773 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbfHZUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so16579857wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3NlsbaVmcGi3otv9ZJ2fHYs8AFKgSTfNTic8ebJ9pLc=;
        b=eK+nQS2Aoko7nn/Hwp8NG6xTWIMU9o7rsicA86jWI/hqnzHtvX3hsz6Ozex+GBWt+1
         n09i1jpu0+/k02Si8KuL1CL0dPvxc8HnoMdSyP9EQMaKQnNS6rGt8zfn02dt0yM2Gq8C
         ITkdGB2Hyw5QnhRuq24WDfIQ0C08oQRC+1DLJ/ZpiX5JYqTkOYJZo+iNgGsqarOUUONq
         UfYb2Va+E/KbHQo3wes0PeRNkqOPKVJFA/kRJx+Z8MO5iu0hatSrc/DdUxGPgt5CA+5i
         t9gCRLV0h8FyGI6Wc52Mth900QYGf8bQoqcHxKpE3c8Gx/FIXEAFTGnLH5czmj7ZX+g1
         rw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3NlsbaVmcGi3otv9ZJ2fHYs8AFKgSTfNTic8ebJ9pLc=;
        b=l4YeKbvm3ooys9vrnlucxDCTEzEj/2aBy9HaSlTL7rQsfd4Y7j/P83eoL+YLR6sLWq
         ygz5AQpKVLcXHAPNKNl3qJMmjO/kKgyQPhG31qPPNMnEMugW9VJI1IyQUNZK/pJhezUQ
         hHCTxtongAzmJssEzO/cpMam/Gy+ZTCwPQfBufXBlcC02ph4UQaU6nv2XFymdzYbXHFU
         x28JT13f5nYPzCKENMEQ9tjYJbx3q9tEhpgXU2itsjEmZHcENrp46fOUvx8ThJmYskXO
         +e5DAKRAwlJ8jsHtA0b2h7dE+A8Xc0Qrrx92wVZ67gRyS+V9mUqF42Cv03f1bCA9mHR3
         DNQQ==
X-Gm-Message-State: APjAAAVBESW3M9eC1DZBXxvycIKkWqIi5HmOETCc6MU8LkvPE8KCljLz
        ivLMXLlnRw8g56g2tqWpx058gw==
X-Google-Smtp-Source: APXvYqydUnATzYCn0EWScuMiqbJA85WS+XKj8jFvBs7l930eiBInVzKH4tlZ/MiFRAVHfo7gTo+qxA==
X-Received: by 2002:adf:f844:: with SMTP id d4mr25413725wrq.128.1566852308552;
        Mon, 26 Aug 2019 13:45:08 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 12/20] clocksource/drivers/timer-of: Do not warn on deferred probe
Date:   Mon, 26 Aug 2019 22:43:59 +0200
Message-Id: <20190826204407.17759-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

Deferred probe is an expected return value for clk_get() on many
platforms. The driver deals with it properly, so there's no need
to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 80542289fae7..d8c2bd4391d0 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -113,8 +113,10 @@ static __init int timer_of_clk_init(struct device_node *np,
 	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
 		of_clk_get(np, of_clk->index);
 	if (IS_ERR(of_clk->clk)) {
-		pr_err("Failed to get clock for %pOF\n", np);
-		return PTR_ERR(of_clk->clk);
+		ret = PTR_ERR(of_clk->clk);
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to get clock for %pOF\n", np);
+		goto out;
 	}
 
 	ret = clk_prepare_enable(of_clk->clk);
-- 
2.17.1

