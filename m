Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B83C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF57216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj8A5nub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGWDPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:15:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfGWDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17so14993952ljk.10;
        Mon, 22 Jul 2019 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=Fj8A5nubxQA2N7K2vJKg6c7QiT6J1sbbNkD3C/o+ytVgKg2G9QSsVW7QtBhd8+3AMk
         XLr50uruX2/HkyOj2ZLh9koa6GXE+80dkA2NDcxFuLixSOoEm5kjNIJ9zIaUJEuuAWKy
         NiW+DwZ4nftZ5YHVla6DYc6HSO9TBnjjdpcGhjGgMdvbi4rlaBgnLPQbBvXv0TwUhv5X
         LyRFKRnyyTSQdQMtElznUw7Q5rgLaiH++DwDyX627IKuInPVITbB/FAqSU+cWgWe9Go+
         A/VnGZzZFl1eAyM3mYo0SHJByeDBeiQtgOO3zvoJjDr1bqpOmGef/mdcVd9Bp5iQmiv1
         5QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ty6qgDcH1fj9SELU8vi4wQcPSTs39HjIXkEXwkiA/cs=;
        b=Q6Pun0ZaN5DsK2V7LNDqshdEDngX3ds8hX074ahOoF5JF7PhKxgB/Mnt36a9FYKDIQ
         y3PLciQ3lQGfz6bkWaMPZbQ3I7DQppW7Ab0YG1fy/AROIscwdqE42Lr2dUuJrQDHB5J2
         IzVo9QgdyFo/s8eQZtLRPJW+Ixbk9lz843T5eIz9tGZwrY+VdkQT4J/vueylu1Akv9Li
         8n5GPi0rTYY65i9/hYMTg/bJsWWZdROFjDamIE2D8B6Z1G+jya2D1mXLFDhI3N7ziI3y
         pfP8AFVB70Z1lm9vCtP+4AhmV8yrwpE38mhR44NL9qdzbiTq3D2B7Jt8u+eigpXnSkg/
         ElIA==
X-Gm-Message-State: APjAAAWVdFYviHwTYeyO9jJgKhulMu/kk9r/UciOT/e5AXJxH43JXZCq
        w4Og6EpMuMk41cW6o7hagy0=
X-Google-Smtp-Source: APXvYqyWfiWPFjBS+P3DjX/TByiSMm/lmqEOS4S9FVpfjlgwxHmlS+nbVAJMDR0Hxehh0TJo2NG5hg==
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr39245715ljj.156.1563851655308;
        Mon, 22 Jul 2019 20:14:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:14 -0700 (PDT)
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
Subject: [PATCH v8 08/15] memory: tegra20-emc: wait_for_completion_timeout() doesn't return error
Date:   Tue, 23 Jul 2019 06:12:40 +0300
Message-Id: <20190723031247.31932-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interruptible" variant may error out, the "uninterruptible" not.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da75efc632c7..1b23b1c34476 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -224,7 +224,7 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 
 static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 {
-	long timeout;
+	unsigned long timeout;
 
 	dev_dbg(emc->dev, "%s: flush %d\n", __func__, flush);
 
@@ -240,10 +240,6 @@ static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
 	if (timeout == 0) {
 		dev_err(emc->dev, "EMC-CAR handshake failed\n");
 		return -EIO;
-	} else if (timeout < 0) {
-		dev_err(emc->dev, "failed to wait for EMC-CAR handshake: %ld\n",
-			timeout);
-		return timeout;
 	}
 
 	return 0;
-- 
2.22.0

