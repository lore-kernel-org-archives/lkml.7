Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1825FC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685A2238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPzbZc1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfGWDOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34951 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfGWDOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so28185450lfa.2;
        Mon, 22 Jul 2019 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=LPzbZc1ln5CeKWEUw+bwsc4nwS+PhyjSV4WNCuCTlYV+Q8eBnqbzGrein4fUUi9LlN
         L9Epn3fr0N2PTpbc27ePB1adsaF0iFF4mkKHnLu2OzWxI5ZDcIoxcjBzPlFnrcxFoErU
         brZS37IaOM+MxhnUmlUKFAIhgKPpRFjehihlphNGnk0wCFcUAjBn859VVPd5hSc+1b7V
         AF9PXDjrE28Sj0qXqltwWhgP2IX1hyIyiRKvmuUW/FwcIgQ99390XfqWEeaD0LW8AzA0
         +eeYLkwqlWPjKkx38wKb+VLpWwMl9CvYjgRq/UMnIvyk636z3zzkFEnjJe857uHZ3XRD
         YWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=W+EQAW+wXYqxpMMgDiRnDVF/lq2J0zNh+Gh5e9tT6Z6W2YlnVH8pBrnBfhyv6RR+6x
         BYRayZ14bzQtzdkO6YFSGG5Oj0h2NxN06mMigto/D//QL7qNehwb32/bPHDkj4jpOIth
         ZnVCTjZU1IxLs5QntRRNLe5wWMsFDxSbI9954iQu1sAQt7Ag6g2N7S/M0RsRx90ZgH1Z
         yZ2SELAo9CAWPQ9Oer16Qo/bnbhP7NyHcG1V8lXaKFORiKZ7SWXk4YS2JDcm9SLj7SE3
         d/RTzyvp/PUeQpx8hympQK8fSym7tyJhxF1EMiu/eDjA0D6bwyXcyNATJgNUkWV5KIaW
         5zag==
X-Gm-Message-State: APjAAAV428Wv+GWtNdC+AXZEIDFs9oA4y90g9pNaZ4/iyXlsV2HhKRGw
        5/1lD2Rum4ql4jYLqgfs98k=
X-Google-Smtp-Source: APXvYqzAYwb05zbcxgkuzIUY5XtUIQFuDzqaQeilcUyR+G8bM5CHcJ4e76AxrlJoykruyT6F6dtvdg==
X-Received: by 2002:ac2:4644:: with SMTP id s4mr33300455lfo.158.1563851653115;
        Mon, 22 Jul 2019 20:14:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/15] memory: tegra20-emc: Print a brief info message about the timings
Date:   Tue, 23 Jul 2019 06:12:38 +0300
Message-Id: <20190723031247.31932-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot print how many memory timings got the driver and what's the
RAM code. This is a very useful information when something is wrong with
boards memory timing.

Suggested-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 85c24f285fd4..25a6aad6a7a9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -368,6 +368,13 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
 	     NULL);
 
+	dev_info(emc->dev,
+		 "got %u timings for RAM code %u (min %luMHz max %luMHz)\n",
+		 emc->num_timings,
+		 tegra_read_ram_code(),
+		 emc->timings[0].rate / 1000000,
+		 emc->timings[emc->num_timings - 1].rate / 1000000);
+
 	return 0;
 }
 
-- 
2.22.0

