Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17606C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD43A20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr0SyHBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfLJQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:42:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40245 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfLJQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:42:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so89964plp.7;
        Tue, 10 Dec 2019 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAZmhDLq44fHUuJGfTTESQPx/1QL+Ta6yKiRVIXpUF0=;
        b=Tr0SyHBMO2y3mbJLXSrmGeiJsEDUyMma4adOG4cGUtAzqIO7+9T5sEC3/ov3VSkQxQ
         OsaQxqAoD/WIEqsupov1DkcXzKWG6w8VkEdnfsbOmlI1rU4TgLkqCQzAHlybWsBEazsL
         S6OhwyJjS8c3Qq04r5HQY92yv+iUAO9nKrMAfXnlG0sUj6z5a2qSIJDVrfYGqn3rhcbV
         PAGYgUpgCfzmQ/5yUBDAqvXjnTzckmXZBSfX0hvzziA8HF+mNPfxddPy2jDeUpatGUlS
         UYfNwz8KBCGv7JE54c9d+Pt9m6KG1SShDYbJJOcUUJ+/5mRSP9giNkbOsPPXunBASOdu
         sZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAZmhDLq44fHUuJGfTTESQPx/1QL+Ta6yKiRVIXpUF0=;
        b=AZpDK8fIEdsHUeO1DIW9zMlRuKz49mXtW0c1ZjIEheF6glWVd9Lpf7xKBctyGDdx8e
         X+NmM0bbko30uwlXpRKYXqbAbRM1slQS3KPPbS3hI/wZhW0EZ6JT0Hgg7fye/WxYkL8e
         t5jlyH5LqtABr+D1zekCTT3ZHhg7v+evrWtaZryZ7a1jZvmCyUiR4Wavx3gDFkeQpHWE
         M0TpJAHZvXO4NTRZzQxhnwjc+eYLFVSGqdQn0VrYyYA/qHUyBnBrZj6DLEMx1G5aoyCs
         hzHjPUuyPmYAdgNvr3pI7izdXsYWJrLSci9iETynOIA+KbVy4beAvSfAQUv4sbSHAHZO
         Le9g==
X-Gm-Message-State: APjAAAWBupaLSpRfJyqQP70JEWRwzHGkW2P7xJYzsK6hw6xF+l3C3phY
        rJFb2xL4Lr4shcyYB2Ud4z6F/9ntLjM=
X-Google-Smtp-Source: APXvYqxuSY0ZTZjSLzycVFH0h3HqUrDh3xGSHPfzvt4EscYbB9Cpb50MHFQhK01A7nBPxwIPWLqN0w==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr6623044pjz.116.1575996139886;
        Tue, 10 Dec 2019 08:42:19 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:18 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/12] thermal: qoriq: Drop unnecessary drvdata cleanup
Date:   Tue, 10 Dec 2019 08:41:48 -0800
Message-Id: <20191210164153.10463-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver data of underlying struct device will be set to NULL by Linux's
driver infrastructure. Clearing it here is unnecessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index de8c9cd115aa..11749c673b3b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -327,8 +327,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->clk);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
2.21.0

