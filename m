Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2FC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2262145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewjY1d/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfIEKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:30:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36854 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfIEKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:30:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so1194537pgm.3;
        Thu, 05 Sep 2019 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a0i1FIb88gFlL2LY0yW1IKgiASu6yccQldhMUKcVI4=;
        b=ewjY1d/eI/d1WpFLLyyh/e54luM1Z+5SrqttbaMINV6aPH1LaCxJMwELmgZyHNa8Ji
         hTy4AedszETLQRrBegWPbyClgtlqD7e0WcL4rCH3YQfFbjEZ5BoPDNJmMOW/8QUV2yZW
         QZ+5F0YBFFfkqFmr9eDPo7Xc3m9R5vHplhR1h6ri07PPuPQVuf8jpP0SJutwzXWGT0m2
         nWngyjQSSrM6+mW9cjloZFJIYvta3ouZwJOMvMr5Jh15xZTetz8KuUqL/IRwG2U9CJ5a
         EiVxRbRRuoPvGYB8x8Ew10WT+22j9JaOw4g3ZUqVdZ9ryNuXSIiPoSJg6Dg+Tx6H6Rvt
         pMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a0i1FIb88gFlL2LY0yW1IKgiASu6yccQldhMUKcVI4=;
        b=ad3VJvjIagtXYDcKeOYqhynb+ElkHAE0w7wVaIQ6S0EQCSlm2UgiaGkmeBrtyZUcgm
         1dnY7CVksbvo6P5wdX90t+XAQitrX1SI6nihVY0jVKbeMaxDH9OtYJ/8+Nbh6N++dHEp
         zljREs9JHPZ1SqDRxsm5gEfxDAn8BfWVxJIsJWz8DGeFB9YBJFuE+mqkPg5aejocx25v
         3k9Mi9dQQDxoauUEypOwqN4tFgzX9RhHQ7b6JETzFwWuW0E5dwrbH7KensrXo++ouxSI
         0X6+5+wD39hT4Ortp4f4ozYO5m7WvdnjpzG3uUh6MaPDPTID3RR9NX0cWo5/eTTAhWnI
         Y80Q==
X-Gm-Message-State: APjAAAWMb5snghPyB8FKf9FlK3KK6rvfEw0nmaJR6ob6NFwLJ4wiyAyO
        L2MBTGrWpzX/0fiucK1DM5L1K+fm
X-Google-Smtp-Source: APXvYqyvG17prXzc53bcEE+eqwnBHjWNLYaoPtRRdOT9mg9cNMeKZhb10I4duan0O6cshyXgGQaWsA==
X-Received: by 2002:aa7:8013:: with SMTP id j19mr2963257pfi.184.1567679435325;
        Thu, 05 Sep 2019 03:30:35 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v43sm9291955pjb.1.2019.09.05.03.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 03:30:34 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] clk: sprd: add missing kfree
Date:   Thu,  5 Sep 2019 18:30:09 +0800
Message-Id: <20190905103009.27166-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The number of config registers for different pll clocks probably are not
same, so we have to use malloc, and should free the memory before return.

Fixes: 3e37b005580b ("clk: sprd: add adjustable pll support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/clk/sprd/pll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
index 36b4402bf09e..640270f51aa5 100644
--- a/drivers/clk/sprd/pll.c
+++ b/drivers/clk/sprd/pll.c
@@ -136,6 +136,7 @@ static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
 					 k2 + refin * nint * CLK_PLL_1M;
 	}
 
+	kfree(cfg);
 	return rate;
 }
 
@@ -222,6 +223,7 @@ static int _sprd_pll_set_rate(const struct sprd_pll *pll,
 	if (!ret)
 		udelay(pll->udelay);
 
+	kfree(cfg);
 	return ret;
 }
 
-- 
2.20.1

