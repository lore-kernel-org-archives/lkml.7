Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E48C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7352147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qPKhsWQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCLKdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:33:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:33:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so2082688wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLXyLglHFa8WKhCE7UI5x+FxnCWWt9w4ptPRyC5dxNc=;
        b=qPKhsWQR7lHWo26jk2IHBy6RW1A9phLJfjgbuUVJNOrVCqmqzBWj34cb2oX5fKhLbz
         NpSChalSqLWnbRdbR7Y7g56ZcvDdokto9NJtKtfbLw7voyzrMJa9IP2viWSXxboulLOC
         T2d1sV10/mCFoSkGrJ2Qj9M6zJ7dZy0VDjDoupBFkmTmDbrb5UmcrGtzumI6UklPCsf4
         wGBUeL0ZJAUCa9EBTdtVzRp08QYLRVJoEyh9Vc9v3UmMv2LO8v95fl4xWe+Gx/LHn2yy
         TUrVjr89FAiZDKQ4T4I0gQaQ18U4eO081+dRX5B6CSR3+pQQ3aILMBNadLiAGJe/RdCN
         0brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLXyLglHFa8WKhCE7UI5x+FxnCWWt9w4ptPRyC5dxNc=;
        b=jVInU5qvabx511p5hr4f9PtnC+dhKzf8qKZD+0WcthmYOFF8xWlrWOn/xCyuebqMQo
         rGUF6kVhAL/zENvc5FkWeWiwd0jpDYQZCVHDewZIQG0Ii5z7n6148YixL2BlzjyZgKiN
         6P2kNgNrQcjG46P29IIZ4m1/BVdo1zGbuDnkJ35+c4J98EN36K3GPJw4ePwOY7/L/Cs+
         k4urjQfkVF5JGIjcP6HdeFwl+ITlHPzLUs9/9l7J6GqqC7EROao+lnS1oFsSl6wqDB8l
         u0pvZF1R3GSFDAeSSmqrPHFrDuQO8N4vmqvnrvB0CUfRkPnPGO2v/kJuGsGBEYh/roRG
         D8GA==
X-Gm-Message-State: APjAAAUG0r7Po++tX8DOiCux0jB6+JXzAzoX8Cs9oepBuJn+g0jFBIep
        PY71fwTsVJzqU0ie5sI7u6jXQA==
X-Google-Smtp-Source: APXvYqw+Fgo9wKVUnS2wQNNXAYH1Ft3PRJZxiDpiJ6ByNwrDzNMGErfcbMkBSzUkdTGXarFTVGsXMA==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr1391832wru.59.1552386782354;
        Tue, 12 Mar 2019 03:33:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm28673572wre.0.2019.03.12.03.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 03:33:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-oxnas@groups.io,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] clocksource/drivers/oxnas: Fix OX820 compatible
Date:   Tue, 12 Mar 2019 11:32:56 +0100
Message-Id: <20190312103256.13565-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OX820 compatible is wrong is the driver, fix it.

Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index eed6feff8b5f..30c6f4ce672b 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 TIMER_OF_DECLARE(ox810se_rps,
 		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
 TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
+		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
-- 
2.20.1

