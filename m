Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DB7C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9675720663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoKFulYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfKFN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:28:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfKFN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:28:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so17164641pgs.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dBTjXXvoKMVg6TJv/+lsC8FjMXyU4jEJXQ4/NvF04y8=;
        b=zoKFulYa2zGCTxLWB23LTz9Sh0jybKnXxRzHrtoT0ETVUyQNv1aDvV1eOG+6xh1TCm
         0emi1CMyMkPjoOSRNqxkU+C0PIor1+s97Ii0awqpDY25otIHH0qdIoDq6YrEXIxL/lbc
         NFX+zA939PD+pq3LKyY4XLciG5oaaBVER0UpuvJbyuFNBH1RH2remgD5duRDzvuzM4tD
         h6iWHbw8/XHh621L02ECaKK0G7wLaV8JhI8rAK6VUkgEvzPqoZBA5WCzx+aLLw+s5gpZ
         N/mNYI+N0mRHOdDbwiIKubYvPWEP/y6oTiEANmlQ/Ao2B3Jjkk3PZPon0eVUpelGbUq0
         RC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dBTjXXvoKMVg6TJv/+lsC8FjMXyU4jEJXQ4/NvF04y8=;
        b=SWAlmtR7hEKOQXxDpTENhjfD+z+u8qeH7tiiNnvLOEL8h3OpuB1YV1Xyg/mpeuflAz
         8AgT1fs2TH3BRzQE+reLkBqzr1gBDsbPHXg00/nXhz8Lz0zMMn2lJulwvmbqxrv2OA+A
         ho1t8aVvQfgrGDoR5uxNerz8oUNWjnKrpE6JuFcLxckeFOGwN4m69qAeWRKt+0x75jL+
         jCSyijYabdMS49uRAYn7cTKDwq8G2vYkiQ0P3nO0S3h3hGZO7zSgfzULXn5JEAZD2hm0
         D4B5oHjDjeoPOacygFOhKu9UQIx9xb9mNiUn0QxelZ357ved4wP/e3AcoqsuVWaoI7M9
         I0Qg==
X-Gm-Message-State: APjAAAUkHJ9mFDaSlvVRy0LGiV9sJhWBd+4hz+mdOWhnepUdZy6Qy8AM
        7xIISPSh2rHzQphKSKP6hmzft9EprBK89w==
X-Google-Smtp-Source: APXvYqwDRf9TEjaCBK3xROumR4SRu+7KUt+mKQpZJeGGEo3kii1ZV3aetC6mleugfWkwiwGPi9uIBg==
X-Received: by 2002:a63:925c:: with SMTP id s28mr2484003pgn.175.1573046919086;
        Wed, 06 Nov 2019 05:28:39 -0800 (PST)
Received: from localhost ([49.248.202.230])
        by smtp.gmail.com with ESMTPSA id m15sm20764961pgv.58.2019.11.06.05.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 05:28:38 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 01/11] thermal: of-thermal: Appease the kernel-doc deity
Date:   Wed,  6 Nov 2019 18:58:17 +0530
Message-Id: <ebd5991d5554202893fbcab4707be6d26f502aef.1573046440.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573046440.git.amit.kucheria@linaro.org>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comment starting with /** by simply /* to avoid having
it interpreted as a kernel-doc comment.

Fixes the following warning when compile with make W=1:
linux.git/drivers/thermal/of-thermal.c:761: warning: cannot understand function prototype: 'const char *trip_types[] = '

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index dc5093be553ec..5235aed2fadd5 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -754,7 +754,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 	return ret;
 }
 
-/**
+/*
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
  */
-- 
2.17.1

