Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F46C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9CD21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZpxIQpFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfISJgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:36:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43709 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388644AbfISJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:36:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so2309141wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HU8Y6pbxWWxRHBUPCakNxeD6oqUY5n5mmhoUaSAT3gk=;
        b=ZpxIQpFM42BVxOwOhk7rXeg7LiQ/OzWnqWklrcETy22L7NdwvJOg25CPHHr/9bBzA7
         yYeWiVE3oPtqE9Erb4DWeZ/tpghfcW9ioBBOioDqpw6G892y1x48m8xMPjmcy18Nry2o
         pw9WB4k9l0ZVsvVLUzhO7itF/vALzH+A5+u7WatGxEyn2WbEkNM7f+iinKkXxLrij3nR
         X8tXVIol/mse55uThB8RwHlSkQ1nypybZx9fynaYkSTUuvRmFID1CcA0+rCFTrRVlBCl
         KMjZIRs1sRY7Iur537wQ8DVFU9fuM+Yg/pHUEo9uqHvs7dUPEpEFnBAop33UTd/G+n80
         QpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HU8Y6pbxWWxRHBUPCakNxeD6oqUY5n5mmhoUaSAT3gk=;
        b=VwYGHanKCQHzWVgX5C8g/Vj3zw6B5z7iDAReYKFUAQJzg54nC1F0hQQGUWRM6yfRHL
         IAcjsO7stj+dStlwXnoEQ6YPJM4LAYXaz8xu6NknEUX2/AqEa4+N0h98thTeFm+gYodI
         gMR7s+u+dnCnBcEnGtO2BoZveMEaDBoObRLW4FMO/Qy5UghtTXZtZdCIDX7lOxi3gURm
         aZtkdJ4H7LUHLDZcA/h1S2gwZ4CX9M1Ls/IFz44rVZzl3WZLaTcX1h/pJxOHy6vCMTIG
         NGr5Sq3JSeh7iWOz9BKoaHQQBGT0EvoSO2Qr8YTgjqNNwKtn13Z0pjMTKj+4OQMBxFMA
         jmuA==
X-Gm-Message-State: APjAAAVlnjBEvWjv+xGhgirSK0Ef/fVo7VwyQvQOA+IaHa8/kJcovLim
        USZ1byXEtn6VbK6s/fdTuU6Tow==
X-Google-Smtp-Source: APXvYqwcwTAoAq6ipI04IFWalCiIwGVkBNhcLNPZV6e9XreTF113hZ1ic9ciMzNKiT6P7nJFBGetVA==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr6926414wrm.26.1568885790071;
        Thu, 19 Sep 2019 02:36:30 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id q19sm16701186wra.89.2019.09.19.02.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:36:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: meson: g12a: fix cpu clock rate setting
Date:   Thu, 19 Sep 2019 11:36:25 +0200
Message-Id: <20190919093627.21245-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190919093627.21245-1-narmstrong@baylibre.com>
References: <20190919093627.21245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_SET_RATE_NO_REPARENT is wrongly set on the g12a cpu premux0 clocks
flags, and CLK_SET_RATE_PARENT is required for the g12a cpu premux0 clock
and the g12b cpub premux0 clock, otherwise CCF always selects the SYS_PLL
clock to feed the cpu cluster.

Fixes: ffae8475b90c ("clk: meson: g12a: add notifiers to handle cpu clock change")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index ea4c791f106d..33c7e04b4a82 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -353,8 +353,7 @@ static struct clk_regmap g12a_cpu_clk_premux0 = {
 			{ .hw = &g12a_fclk_div3.hw },
 		},
 		.num_parents = 3,
-		/* This sub-tree is used a parking clock */
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -533,6 +532,7 @@ static struct clk_regmap g12b_cpub_clk_premux0 = {
 			{ .hw = &g12a_fclk_div3.hw },
 		},
 		.num_parents = 3,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.22.0

