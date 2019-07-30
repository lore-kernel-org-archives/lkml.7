Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6851CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E252171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgWL5H0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfG3Q7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:59:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbfG3Q6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so66548942wru.10;
        Tue, 30 Jul 2019 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=RgWL5H0abdsOwXIac0uk/56Qpu8Dml3donOrYITO24N5I+EnLII2X5yAKHLyjnUUks
         k6SiXHGvJjI3cynhy48jDglqa+w5KNfWmnDN40HOdpLfxidJIQ6x6SGnhf91KoX6cT/7
         rIIwoMVNT0LHM3Ojm3bcz/ywA5X7gmej0lVsuWO2NJwmQk0aODkAIjXzAbS1xMLDPPXH
         LXxngxauImVR5cZ/IeUt4oX9KBlva8JWARcA9omSG+bYJCW0E+7lC8AQChsnFP+bhlSz
         kU8jHeM5B5CX909YH65KKhO64jncXB3WD8XIRQ3wtw9QOJc4CxwsMos499pKdsdtlb4D
         xc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=BAPCYk4OBEgb1JsaYwiPTKmD8Sb4h5kcr47CoTbsaqlokEPXo1dIO0NiCe//DsLD3z
         VOSjHJVhF9V8pFxVGvFs7jjyxc0Z5GLEkNf3gv3GV3MO8D7JFO6lakpVyv8JwAO7h+eo
         jrijPIKWM/awjZFPCYndhTFkH0ax3eN8RurKXPEgYQITb9IctDqeExYyqc9+NjeeZnrq
         siJ8yn45dzKAbwCXt8jp9rdvgjFGxjmnNh6NoyhncWzO3M/FVfeAq7rjhPnKMrAfzQsy
         rqEVkohKCsSoti3Ht7iJdLWFIGlV1Q4wwyknpwOMliGvc4tcKUme3kqg3xJsVxZVSObv
         ENcg==
X-Gm-Message-State: APjAAAUJ/IJABGqYuFIc+KrnNRXaF0SIBvw4LORbW0/OXFEzSnAhKkNV
        vEExxwh57kOdd8RppZuRcsMD/MCP
X-Google-Smtp-Source: APXvYqyrsktUZZ3xbBXfS16fNrP8gGuWqmcaULBm5PX+z5WSnr534qgc8EXw5VVqQNiKjXWTTRZktA==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr74521257wrt.124.1564505896476;
        Tue, 30 Jul 2019 09:58:16 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:16 -0700 (PDT)
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
Subject: [PATCH v9 06/15] memory: tegra20-emc: Print a brief info message about the timings
Date:   Tue, 30 Jul 2019 19:56:09 +0300
Message-Id: <20190730165618.10122-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
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

