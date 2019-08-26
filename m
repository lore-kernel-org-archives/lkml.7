Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F23AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598421744
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKbaMf3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfHZDSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:18:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43743 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHZDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so9259212pld.10;
        Sun, 25 Aug 2019 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEJ7QK2yA8QtwKk/jFpiizrreo9ZCT/dw31kH1OAjDQ=;
        b=aKbaMf3iq9PlX3Ydly/zPytKh/3KzTae2MX6e8fO7tqcage8p48acAPYVbQfR2cOxN
         OJN/F2VIXMLfpIK628pt73uNYZXfffmB5V5JOj6mwuzVgWUZElo/ZudVjsgdjFfKWik9
         CQCSq5Lk7kY928gqbr60PCFLNOP9ivo4RPZCIbL9cEhp6jx7ih0pAtZbnRw2h7zI8B/M
         azx+Ow3tcnSXEJudpM/SAMj0yaUM/JncpBqWFlx961GnQHsYms2UP37uU4MOv1CiDkbr
         ZHuqrfj9YFXbYBVyXd3o4nX37zq5KVIXePDSV6ikdFZlZHRbzIyBfbMC0ea/eCHQF6tV
         OJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEJ7QK2yA8QtwKk/jFpiizrreo9ZCT/dw31kH1OAjDQ=;
        b=IUgDU4Vtr/uKfu+L+Y6csSln07M2c8wNF3wq16AtivbZ5SQVW2lUelK7qn0t1cc9xh
         9vydlXup8QVuPn8RkNHQgWvAjdfEgAH8kEquDZK5UdWZL6ksWU1vXQ3liC/WfWyMarM2
         UUzT2TOI7dem9eW95/NY3Ry7VFOJ1lFnhKY2FggNRzjkt+agOKtPVaQF6Dm3/h8N8xgY
         xdSdrn5Yk1XEudAqUUuHY8pm+1bsDqp8MwETDwUTg2+qu2B7oodidc4c5pPUqyVG9map
         l1onUytVPF+hhHtVMAkgTLxlmKAR3eDrOEjXpxWNMzvCEiZlI9uIEpAePUPHNnD2xvil
         8kSA==
X-Gm-Message-State: APjAAAXipryAVieKpW54bONiXyzw2T5wh9KKEyLu8/1/3S4KnayIQlFs
        INpAo8qfjyJc/CrnE3fTezHXhPQZ
X-Google-Smtp-Source: APXvYqxBnMyuW/2Ku0SXqJs4rtxsPbRX+CjJX0FRh6L1hE7OpKxb7pxBLYZx9nSUK5f6DKp7v3o0wg==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr16337169ply.337.1566789532653;
        Sun, 25 Aug 2019 20:18:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:18:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/5] mmc: sdhci-sprd: fixed incorrect clock divider
Date:   Mon, 26 Aug 2019 11:18:26 +0800
Message-Id: <20190826031830.30931-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The register SDHCI_CLOCK_CONTROL should be cleared before config clock
divider, otherwise the frequency configured maybe lower than we
expected.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a3fb3a..d5871865a1e9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -217,10 +217,11 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	u32 div, val, mask;
 
-	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	clk |= ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
-	sdhci_enable_clk(host, clk);
+	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
+	sdhci_enable_clk(host, div);
 
 	/* enable auto gate sdhc_enable_auto_gate */
 	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-- 
2.20.1

