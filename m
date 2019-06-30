Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9FFC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E8E2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+BN7oUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfF3VEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:04:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35636 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfF3VEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so10961148ljh.2;
        Sun, 30 Jun 2019 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=Y+BN7oUlg28GhXQErXTWAHzaajtoG/KWmiRkwyOzNPsh9L9XkqiqTgaO/GMypEWW8r
         mSz9atQsaRTlQOEMdaV38MLl3t91LcQtIj2M/F1nGGXGFsBeJrn61eWU+iigtX9vn7iG
         Uz7EdnPcs22hlZLcDeoJe+ugWjkU/otHQokFZ8FvyFJnpeSBX+W1CfI+H33GtlrAvh1o
         vxw+qmNXYwu7hP+8qrl97/XVGQrW2dYugWMuAU9vv2RMh+AxUkjXqOtLz6XVovkyTdZ2
         tU4vo+WoRV08cI2+twZHBzjPFJTWsNVFwh2zYM3J2iFOo+NSgGKzWe5tB+5qruBat34f
         AM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=MxIFEuj/EvyGdCUN/iMHG+5K9CqA0t2NIBOM/13+vlM8cWwLJXSkE2kBmokJj4Zdzj
         +50S0UzEDWIly6WL/3gHpsxyFC41MoE0AX0fVR0Uwl8HEVd9J0AbeZoY7hZ2lUUxVA90
         vXYcvvjYiafx7nmaHugcvH2VyBNYJy76WfdV+tD5Zssdpgbv1m8dpnHrjtvD2HXUxBMc
         EWmgwcuiLv1imDA7dNwuqPveq8pTcijBRRx8J+/FBUbwlDFxRLPI1+ICBb7IYf7jBsHT
         xGaowVT7+5gZRLj4FlsNu5eOL8hUQyGzKtbJ3j8Pm/qyhHM4ifbweQVghtiaLcQlVvwy
         kckQ==
X-Gm-Message-State: APjAAAXLcc4F/31IPRd13RfR6tyjz3XlIxUG6SYLQTknbspSFFbm+qyj
        BstzVsa6lcQSnKfCmUwvZiE=
X-Google-Smtp-Source: APXvYqzK9XJnEsqCS1xeO9fF9Od39cG64Rp2GuwpRCBjc2w4GCN9kumfNs9v1l6rPVYR4pOmmhvN9g==
X-Received: by 2002:a2e:3604:: with SMTP id d4mr12050809lja.85.1561928682787;
        Sun, 30 Jun 2019 14:04:42 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:42 -0700 (PDT)
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
Subject: [PATCH v6 06/15] memory: tegra20-emc: Print a brief info message about the timings
Date:   Mon,  1 Jul 2019 00:00:10 +0300
Message-Id: <20190630210019.26914-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
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

