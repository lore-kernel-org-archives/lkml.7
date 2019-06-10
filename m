Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6645BC31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1E20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmwiIqCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbfFJQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46168 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfFJQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id h10so15345418edi.13;
        Mon, 10 Jun 2019 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9gQlsKSjgobvU6SFxjmU2LKUjAM0IEwn1v1XvUvuxc=;
        b=LmwiIqCQpVy17FT33JguNPcQTGtDrY/8BwSmoasyAfHax5SsN+v0nQ14I+wWztEYPk
         02E2lbAw493j/VgoU6PMnIcm7x+TJUktyTcCBKSqpktsw0odN52PLpSCfoujEigfJN2D
         FMwBZ0hdgW3GFwYXEO+WMq4TWYIQMtYg10eDIrVgGJ741EsajNL5VcaXcrLtKd9sCd+B
         VkQRgGDWHC/GFleBzYqWBNFxSINke9ayOXrW6A3iDSSwxpZNOyQ1CFZZxeqpeG2ITKyj
         nOMVmabtHoGLDWr0TfSMcqpjSpLHkrqY2pF+OUHJRxocdFzCFkBOgS+uzgNDaUGUx6Z0
         aeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9gQlsKSjgobvU6SFxjmU2LKUjAM0IEwn1v1XvUvuxc=;
        b=UHyVjWKwLspiIRfF9VX5YkPcSmQz9ZBBb5wzOXNiksVqiPidtbE8S9D5rDmDd9cIvV
         rVTh7hffLX4xyIlNVwlnms+lYIW6bPjyjPeU8WvISV8xyQJFPSthP3xtAtStbIMmlZI4
         GVREhHH39xLutfGJ6BfqtUH4CoZ8gc6cOLCDRuHRgruBoCNCUfHDAPVldGS32gHixeVQ
         f37Zcy9FHt5GT6WHar6OUKOHLWMIZ61lfH7B4TdcsljZd/+DoiHsNIypVc7xvzxlUNMX
         +8q1JjLtSCixfqfmGzNRjR4GzdigoMK07B0ufQdwPSx+kxpgwf2NUudqfz8NnRxkjAAx
         Zqhw==
X-Gm-Message-State: APjAAAVz8ERhj4uVJD9AlCkoiw25AYyXqwOAJtVjyMP9RZ+dL3YRNQKN
        SJCMtdeP0RX9rQFILsBBeWmsPr4x
X-Google-Smtp-Source: APXvYqxt7wNTHogSmYReya6Hooz+lrapLjJxEN5f6NgofXuhso/33sKs/hD44uZdKgF60LUBp3WQUQ==
X-Received: by 2002:a50:a935:: with SMTP id l50mr74993957edc.198.1560185301187;
        Mon, 10 Jun 2019 09:48:21 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id a9sm3075799edc.44.2019.06.10.09.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 09:48:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] clocksource/drivers/tegra: Restore timer rate on Tegra210
Date:   Mon, 10 Jun 2019 19:43:55 +0300
Message-Id: <20190610164400.11830-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610164400.11830-1-digetx@gmail.com>
References: <20190610164400.11830-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocksource rate is initialized only for the first per-CPU clocksource
and then that rate shall be replicated for the rest of clocksource's
because they are initialized manually in the code.

Fixes: 3be2a85a0b61 ("Support per-CPU timers on all Tegra's")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 9406855781ff..830c66e2d927 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -277,6 +277,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		 */
 		if (tegra20)
 			cpu_to->of_clk.rate = 1000000;
+		else
+			cpu_to->of_clk.rate = timer_of_rate(to);
 
 		cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
-- 
2.21.0

