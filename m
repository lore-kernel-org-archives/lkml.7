Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC02C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96FF21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw2CYVIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfHZUpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbfHZUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so795084wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OA1YNeBx+8aF3UbvHkUdfo5e5H5+BTnVhu+4DZoJ9fU=;
        b=Qw2CYVIes9ZxpQuAYS32DRr3g29lH2pNz7f0H8wnHGokAThyoTkArELW7SBmIbbV4c
         P5ns7XUOrNA0fohmMs7EufD86nZuSwaa28iWg6d6KgRf8mE7NhIQE21+NORL44Bzauk5
         +MhPJelvveOCWo4yldg2pTnjYn+K4ieQnUaZnGgDtdCCU0Hg8iw5dJ3CzNtxlE2BXHAr
         NYxy2WUBj4jK9FyYNOXPytaY7RwYVkNrQFGFbkSvEj38CqFm2rRr8BEJdk7OwkroI+Z0
         7DnQAqoIri/Uad1ZReHtuhO6q5dcDLoNJ3A/zUbWq8LkopJwXu4EcQkWAX/UIlbSJwnK
         PKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OA1YNeBx+8aF3UbvHkUdfo5e5H5+BTnVhu+4DZoJ9fU=;
        b=PChVKXXhl4zLLAzvbYnTGzxME6Wv+WfqtLgODXlmq7RBzPXyfKVcBW1S4nktXnKmZt
         ID+OJEx0Q3BU50DbJ7uCvgiPqLLnBgsDuk7e9yEkDQCJGu2u4xB29D1uqEJxpLyb72XX
         5Rl6xhzDzAck/Zw279ujiO7Asze7BawXfuS6BF2cmXFpJOXo2G8roFHgzlSs7+W9oDq8
         eEZNrad28WR/EuVIUCQG1hYMbQXhaCWQWOawSfFAENC8EUiSVCgnLkrFcezoLyOL8Q6s
         3eFbu9LV3E9doGbbdh2BfPoWCa1/aGMYiw4nrTIfzlFc3PpGl3608gEKY1dBbqTnOIWu
         D+Ag==
X-Gm-Message-State: APjAAAWfhH+5ICrqL2LktqkVFTfTEGeVPIdMoXOpizw01lXSv4bxVuw3
        O/1n9ItwGXp6CK+pjNTrp5LiVi1OW+M=
X-Google-Smtp-Source: APXvYqyvXmsvciFEhpW32ekSSz9RowZxvGkiwdo2Xh2gd7I7PBA1CRJqNTxMXziYmS/0z0zjgJu4HA==
X-Received: by 2002:a1c:45:: with SMTP id 66mr23577980wma.40.1566852310139;
        Mon, 26 Aug 2019 13:45:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 13/20] clocksource/drivers: Do not warn on probe defer
Date:   Mon, 26 Aug 2019 22:44:00 +0200
Message-Id: <20190826204407.17759-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

Deferred probe is an expected return value on many platforms and so
there's no need to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index dda1946e84dd..ee9574da53c0 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -29,7 +29,9 @@ void __init timer_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("Failed to initialize '%pOF': %d\n", np,
+				       ret);
 			continue;
 		}
 
-- 
2.17.1

