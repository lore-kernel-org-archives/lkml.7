Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09ACC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41C620673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPzAomh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfGGWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40688 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfGGWzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so8329890qke.7;
        Sun, 07 Jul 2019 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=SPzAomh5UOLtllr4UWH8t9ajcZtnIF0sP/jikxH99MsIpm1St8ukU9Apim4EK5FJys
         Z8AG9qu0fd8UUM2qFaJGvW3uGbfW5qpEs57iG9Hd1PJ5sJXtJTelcGiaMSYVjbGlKwYT
         sA9cfnT3mC6YXeaBs15nTMRXuxVZxJ7425nM1nB8BC9NaxKHxLDmDFzDp/NxhjucQA60
         pF1n1/qdzKE2DabyKAQXUVqnsZcka3ZA5YeRyPedgTXfxuXXOAJdpZvHWYuqRsCw3h3h
         oNLUf75YGdCogcVn2lws5v13IOi0OQZaCsjKeA1dJ4q/4lySa1b8ydV0VSTHyfcC/lpt
         G/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=AUdSh+V1SWMQIHBjSFpIdFjh2/K21tn+oX2dvCW8IXFrGegmSkBHw7FiwpQ7xOcbDn
         BcMkbRah59OrQVmZWVb8lDZc+ag8hcI9yv4lLxu3hfitZ/lZe6yFmqBqDI89REeuydHk
         5dN1L/JPHnlXfFk9AKYXcaJapESgou+oycQ4zn+Pjh3AAa9qjq4QNUX5/XU0yoeV1Cpg
         yX62nZ8jGxs/4JwqZt7EzDAwSL2QYuSrVYMstq7yqKXn1Uf3Kj0Mr1j8E9skqZId9rWe
         PMUvmdyrhtIjqPFCVne/eBr3z/swkMqip9g8BKNfU5Y7Ylk/kgPbpklfpWaBFXb1irb9
         JYdw==
X-Gm-Message-State: APjAAAUViqk1h/WAobcd4grmDcV1Vcc9V8pxp6JxAWZZvOMhBYINMnM/
        UJyE0+UTewbg5rJdN6osPT0=
X-Google-Smtp-Source: APXvYqzDlqjc8aji63VqwvAcm/e5Ppc3PPMJBgg6B5qEHP8UTsNN4vyV6jjo6hdgrtSdZ8sdEnufUw==
X-Received: by 2002:a37:8081:: with SMTP id b123mr11765219qkd.62.1562540116845;
        Sun, 07 Jul 2019 15:55:16 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:16 -0700 (PDT)
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
Subject: [PATCH v7 11/13] memory: tegra: Ensure timing control debug features are disabled
Date:   Mon,  8 Jul 2019 01:54:22 +0300
Message-Id: <20190707225424.9562-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 43819e8df95c..1bad7f238881 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -657,6 +657,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 410efc4d7e7b..cd52628c2b96 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -30,6 +30,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

